# scaleway-csi

A Helm chart aggregating the official Scaleway CSI chart and external secrets required for authentication.

## Included Components
- Scaleway CSI (from https://helm.scw.cloud/)
- ExternalSecret to fetch API keys

## Usage

Configure `externalSecret` properly to point to your Secret Store.
