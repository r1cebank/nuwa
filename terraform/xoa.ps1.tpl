$Env:XOA_URL = "{xoa_url}"
$Env:XOA_USER = "{xoa_user}"
$Env:XOA_PASSWORD = "{xoa_password}"

ConvertTo-Json @{
    XOA_URL = $Env:XOA_URL
    XOA_USER = $Env:XOA_USER
    XOA_PASSWORD = $Env:XOA_PASSWORD
}