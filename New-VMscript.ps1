Param(

    [Parameter(Mandatory = $True)]
    [ValidateNotNullOrEmpty()]
    [string] $SubscriptionId,
    
    [Parameter(Mandatory = $True)]
    [ValidateNotNullOrEmpty()]
    [string] $ResourceGroupName,

    [Parameter(Mandatory = $True)]
    [ValidateNotNullOrEmpty()]
    [string] $Location,

    [Parameter(Mandatory = $True)]
    [ValidateNotNullOrEmpty()]
    [string] $UserName,

    [Parameter(Mandatory = $True)]
    [ValidateNotNullOrEmpty()]
    [string] $Password
    )
     # Install AzureRM Module   
        
    Write-Output "Checking if AzureRm module is installed.."
    $azureRmModule = Get-Module AzureRM -ListAvailable | Select-Object -Property Name -ErrorAction SilentlyContinue
    if (!$azureRmModule.Name) 
    {
        Write-Output "AzureRM module Not Available. Installing AzureRM Module"
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
        Install-Module Azure -Force
        Install-Module AzureRm -Force 
        Write-Output "Installed AzureRM Module successfully"
    } 
    else
    {
        Write-Output "AzureRM Module Available"
    }

    # Import AzureRM Module

    Write-Output "Importing AzureRm Module.."
    Import-Module AzureRm -ErrorAction SilentlyContinue -Force
    Import-Module AzureRM.profile
    Import-Module AzureRM.resources
    Import-Module AzureRM.Compute

    # Login to AzureRM Account

    Write-Output "Login Into Azure RM.."
    
    $Psswd = $Password | ConvertTo-SecureString -asPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential($UserName,$Psswd)
    Login-AzureRmAccount -Credential $Credential

    # Select the AzureRM Subscription

    Write-Output "Selecting Azure Subscription.."
    Select-AzureRmSubscription -SubscriptionId $SubscriptionId

    Install-WindowsFeature -name Web-Server -IncludeManagementTools