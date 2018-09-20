
workflow Get-AzureVMTutorial
{
    #The name of the Automation Credential Asset this runbook will use to authenticate to Azure.
    $CredentialAssetName = 'DefaultAzureCredential'

    #Get the credential with the above name from the Automation Asset store
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName
    if(!$Cred) {
        Throw "Could not find an Automation Credential Asset named '${CredentialAssetName}'. Make sure you have created one in this Automation Account."
    }

    #Connect to your Azure Account
    $Account = Add-AzureAccount -Credential $Cred
    if(!$Account) {
        Throw "Could not authenticate to Azure using the credential asset '${CredentialAssetName}'. Make sure the user name and password are correct."
    }

    #TODO (optional): pick the right subscription to use. Without this line, the default subscription for your Azure Account will be used.
    #Select-AzureSubscription -SubscriptionName "TODO: your Azure subscription name here"
    
    #Get all the VMs you have in your Azure subscription
    $VMs = New-AzureRmResourceGroup -Name "testrg001" -Location "CentralUS"

