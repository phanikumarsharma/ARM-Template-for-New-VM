$ausername="srinivas.gudibanda@outlook.com"
$apassword="sRi342143" | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($ausername,$apassword)
$login=Login-AzureRmAccount -Credential $credential
$subscription=Select-AzureRmSubscription -Subscription "RDMI Partner"
$rg=New-AzureRmResourceGroup -Name "testrg001" -Location "CentralUS"
[pscustomobject]$rgname=$rg
#$rgname
