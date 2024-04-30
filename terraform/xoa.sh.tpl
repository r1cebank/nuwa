#!/bin/sh

export XOA_URL={xoa_url}
export XOA_USER={xoa_user}
export XOA_PASSWORD={xoa_password}
export PROXMOX_URL={proxmox_url}
export PROXMOX_TOKEN_ID={proxmox_token_id}
export PROXMOX_TOKEN_SECRET={proxmox_token_secret}
export PROXMOX_HOST={proxmox_host}
export PROXMOX_HOST_PASSWORD={proxmox_host_password}

# Change the contents of this output to get the environment variables
# of interest. The output must be valid JSON, with strings for both
# keys and values.
cat <<EOF
{
  "XOA_URL": "$XOA_URL",
  "XOA_USER": "$XOA_USER",
  "XOA_PASSWORD": "$XOA_PASSWORD",
  "PROXMOX_URL": "$PROXMOX_URL",
  "PROXMOX_TOKEN_ID": "$PROXMOX_TOKEN_ID",
  "PROXMOX_TOKEN_SECRET": "$PROXMOX_TOKEN_SECRET",
  "PROXMOX_HOST": "$PROXMOX_HOST",
  "PROXMOX_HOST_PASSWORD": "$PROXMOX_HOST_PASSWORD"
}
EOF