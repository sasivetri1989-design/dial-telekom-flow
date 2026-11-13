# Dial Telekom — Genesys Cloud Inbound Call Flow

This repository manages the **"Dial Telekom"** inbound call flow in Genesys Cloud Architect using Terraform and the [Genesys Cloud Terraform provider](https://registry.terraform.io/providers/mypurecloud/genesyscloud/latest).

---

## Repository Structure

```
dial-telekom-flow/
├── provider.tf              # Genesys Cloud provider + Terraform version lock
├── variables.tf             # Input variables (OAuth credentials)
├── main.tf                  # genesyscloud_flow resource
├── outputs.tf               # Exposes the deployed flow ID
├── Dial Telekom_v1-0.yaml   # Architect flow YAML (exported from Genesys)
└── .github/
    └── workflows/
        └── deploy-flow.yml  # CI/CD: Terraform plan & apply on push to main
```

---

## Prerequisites

| Requirement | Details |
|---|---|
| Terraform | `~> 1.9` |
| Genesys Cloud Provider | `mypurecloud/genesyscloud ~> 1.0` |
| Genesys Cloud OAuth Client | Roles: **Architect** → Edit Flows |
| AWS Region | `ap-south-1` (Mumbai) |

---

## How to Export the Flow from Genesys Architect

1. Log in to **Genesys Cloud** → navigate to **Admin → Architect**.
2. Open the **"Dial Telekom"** inbound call flow.
3. Click the **⋮ menu → Export** and download the `.yaml` file.
4. Rename it to `Dial Telekom_v1-0.yaml` (or match the version to `main.tf`).
5. Place it in the root of this repository.
6. Commit and push — the GitHub Actions workflow will deploy it automatically.

---

## GitHub Secrets Required

Set these in **Settings → Secrets and variables → Actions**:

| Secret Name | Description |
|---|---|
| `GENESYSCLOUD_OAUTHCLIENT_ID` | OAuth Client ID from Genesys Cloud |
| `GENESYSCLOUD_OAUTHCLIENT_SECRET` | OAuth Client Secret from Genesys Cloud |

---

## Local Development

```bash
# Set credentials as environment variables
export TF_VAR_genesyscloud_oauthclient_id="<your-client-id>"
export TF_VAR_genesyscloud_oauthclient_secret="<your-client-secret>"

# Initialise, plan, apply
terraform init
terraform plan
terraform apply
```

---

## CI/CD Flow

```
Push to main  ──►  terraform init
                   terraform validate
                   terraform plan   ──► artifact uploaded
                   terraform apply  ──► flow published to Genesys Cloud
```

Pull Requests run `plan` only (no apply). Apply happens only on merge to `main`.
