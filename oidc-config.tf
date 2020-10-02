locals {
  oidc_config = {
    name                   = var.oidc_config.name
    issuer                 = var.oidc_config.issuer
    clientID               = var.oidc_config.client_id
    clientSecret           = var.oidc_config.client_secret
    requestedScopes        = var.oidc_config.requested_scopes
    requestedIDTokenClaims = var.oidc_config.requested_id_token_claims
  }
}