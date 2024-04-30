$Env:XOA_URL = "{xoa_url}"
$Env:XOA_USER = "{xoa_user}"
$Env:XOA_PASSWORD = "{xoa_password}"
$Env:PROXMOX_URL = "{proxmox_url}"
$Env:PROXMOX_TOKEN_ID = "{proxmox_token_id}"
$Env:PROXMOX_TOKEN_SECRET = "{proxmox_token_secret}"
$Env:PROXMOX_HOST = "{proxmox_host}"
$Env:PROXMOX_HOST_PASSWORD = "{proxmox_host_password}"

ConvertTo-Json @{
    XOA_URL = $Env:XOA_URL
    XOA_USER = $Env:XOA_USER
    XOA_PASSWORD = $Env:XOA_PASSWORD
    PROXMOX_URL = $Env:PROXMOX_URL
    PROXMOX_TOKEN_ID = $Env:PROXMOX_TOKEN_ID
    PROXMOX_TOKEN_SECRET = $Env:PROXMOX_TOKEN_SECRET,
    PROXMOX_HOST = $Env:PROXMOX_HOST,
    PROXMOX_HOST_PASSWORD = $Env:PROXMOX_HOST_PASSWORD
}