terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.4.2"
    }
  }
}

provider "authentik" {
  url   = "https://auth.${var.cluster_domain}"
  token = var.authentik_token
}
