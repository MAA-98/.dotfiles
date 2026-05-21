# Cloudflare auth for CLI + Terraform
export CLOUDFLARE_API_TOKEN="$(security find-generic-password -a "$USER" -s cloudflare-api-token -w)"