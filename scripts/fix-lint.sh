#!/bin/sh

# fix-lint.sh - Fix spacing issues in files

# Initialize variables
FIX_COMMENTS="yes"
FIX_TRAILING="yes"
FIX_EOL="yes"
PATTERN=""
AUTO_FIND="no"

# Process a single file
process_file() {
    local file="$1"
    
    # Check if the file exists
    if [ ! -f "$file" ]; then
        echo "Skipping: '$file' not found or not a regular file"
        return
    fi
    
    # Create a backup
    cp "$file" "$file.bak"
    
    # Apply fixes
    if [ "$FIX_TRAILING" = "yes" ]; then
        $SED -i 's/[ \t]*$//' "$file"
    fi
    
    # Fix inline comment spacing
    if [ "$FIX_COMMENTS" = "yes" ]; then
        # Fix comment spacing on non-comment lines only
        $SED -i '/^[ \t]*#/!s/\([^ \t]\)[ \t]*#/\1  #/g' "$file"
    fi
    
    # Ensure file ends with a newline
    if [ "$FIX_EOL" = "yes" ]; then
        # Check if file already ends with newline
        if [ "$(tail -c 1 "$file" | wc -l)" -eq 0 ]; then
            # Add newline if not present
            echo "" >> "$file"
        fi
    fi
    
    echo "Fixed: $file"
    
    # Clean up backup
    rm "$file.bak"
}

# Handle arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            echo "Usage: $(basename "$0") [options] [file(s)]"
            echo "Options:"
            echo "  -h, --help         Show this help message"
            echo "  --fix-comments     Fix comment spacing (default: yes)"
            echo "  --no-comments      Skip fixing comment spacing"
            echo "  --no-trailing      Skip fixing trailing whitespace"
            echo "  --no-eol           Skip adding new line at end of file"
            echo "  --auto             Auto-find and fix files with lint errors"
            echo "  --pattern          File pattern to match (e.g., '*.yaml' or '*.yml')"
            exit 0
            ;;
        --fix-comments)
            FIX_COMMENTS="yes"
            shift
            ;;
        --no-comments)
            FIX_COMMENTS="no"
            shift
            ;;
        --no-trailing)
            FIX_TRAILING="no"
            shift
            ;;
        --no-eol)
            FIX_EOL="no"
            shift
            ;;
        --auto)
            AUTO_FIND="yes"
            shift
            ;;
        --pattern)
            shift
            PATTERN="$1"
            shift
            ;;
        *)
            # Assume it's a file or pattern to process
            if [ "$PATTERN" = "" ]; then
                PATTERN="$1"
            fi
            shift
            ;;
    esac
done

# Determine which sed to use
if [ "$(uname)" = "Darwin" ]; then
    if command -v gsed >/dev/null 2>&1; then
        SED=gsed
    else
        echo "Error: gsed not installed. Install with 'brew install gnu-sed'"
        exit 1
    fi
else
    SED=sed
fi

# Auto-find files with lint errors if requested
if [ "$AUTO_FIND" = "yes" ]; then
    # Auto-detect linting errors if yamllint is available
    if command -v yamllint >/dev/null 2>&1; then
        echo "Auto-finding files with lint errors..."
        
        if [ -z "$PATTERN" ]; then
            # Default to common YAML files
            PATTERN="*.yaml *.yml"
        fi
        
        # Find YAML files with the specific linting errors we target
        FILES=$(yamllint $PATTERN 2>/dev/null | grep -E "(comments|new-line-at-end-of-file)" | cut -d':' -f1 | sort -u)
        
        if [ -z "$FILES" ]; then
            echo "No files with targetable lint errors found."
            exit 0
        fi
        
        for file in $FILES; do
            process_file "$file"
        done
    else
        echo "Error: yamllint not installed. Install with 'pip install yamllint'"
        exit 1
    fi
else
    # Process specified pattern
    if [ -z "$PATTERN" ]; then
        echo "Error: No files specified. Use --pattern or --auto"
        exit 1
    fi
    
    # Handle file patterns (*.yaml) or specific files
    for file in $PATTERN; do
        if [ -f "$file" ]; then
            # Direct file
            process_file "$file"
        elif [ -d "$file" ]; then
            # Directory - process yaml files
            find "$file" -type f -name "*.yaml" -o -name "*.yml" | while read -r yaml_file; do
                process_file "$yaml_file"
            done
        else
            # Expand wildcards
            for matched_file in $(find . -name "$file" 2>/dev/null); do
                process_file "$matched_file"
            done
        fi
    done
fi

exit 0
