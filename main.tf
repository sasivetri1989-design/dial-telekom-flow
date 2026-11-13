# Deploy the "Dial Telekom" inbound call flow using the Architect flow YAML file.
# The genesyscloud_flow resource calls archy internally to publish the flow.
# filepath points to the YAML exported from Genesys Architect.

resource "genesyscloud_flow" "dial_telekom_inbound_flow" {
  filepath = "${path.module}/Dial Telekom_v1-0.yaml"
}
