# nuwa
My Personal HomeLab Infrastructure as Code

## Terraform
Using terraform to easily setup and destroy the vms on my xenserver. The provider I will use is xen xenorchestra.

## Virtual Machines

- 3 k3s cluster vm on nvme storage
- 1 low cpu large storage for arch mirror

## External Variables

### On Linux

#### xoa.sh
```bash
#!/bin/sh

export XOA_URL=wss://xoa.host.com
export XOA_USER=admin@admin.net
export XOA_PASSWORD=admin

# Change the contents of this output to get the environment variables
# of interest. The output must be valid JSON, with strings for both
# keys and values.
cat <<EOF
{
  "XOA_URL": "$XOA_URL",
  "XOA_USER": "$XOA_USER"
  "XOA_PASSWORD": "$XOA_PASSWORD"
}
EOF
```

### On Windows

#### xoa.ps1
```powershell
$Env:XOA_URL = "wss://xoa.host.com"
$Env:XOA_USER = "admin@admin.net"
$Env:XOA_PASSWORD = "admin"

ConvertTo-Json @{
    XOA_URL = $Env:XOA_URL
    XOA_USER = $Env:XOA_USER
    XOA_PASSWORD = $Env:XOA_PASSWORD
}
```