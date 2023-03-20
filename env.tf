data "external" "env" {
  # program = ["${path.module}/xoa.sh"]

  # For Windows (or Powershell core on MacOS and Linux),
  # run a Powershell script instead
  program = ["Powershell.exe", "./xoa.ps1"]
}
