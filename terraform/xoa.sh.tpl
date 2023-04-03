#!/bin/sh

export XOA_URL={xoa_url}
export XOA_USER={xoa_user}
export XOA_PASSWORD={xoa_password}

# Change the contents of this output to get the environment variables
# of interest. The output must be valid JSON, with strings for both
# keys and values.
cat <<EOF
{
  "XOA_URL": "$XOA_URL",
  "XOA_USER": "$XOA_USER",
  "XOA_PASSWORD": "$XOA_PASSWORD"
}
EOF