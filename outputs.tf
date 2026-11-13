output "flow_id" {
  description = "The ID of the deployed Dial Telekom inbound call flow"
  value       = genesyscloud_flow.dial_telekom_inbound_flow.id
}
