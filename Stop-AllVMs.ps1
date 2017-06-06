
workflow Stop-ALLVMs 
{ 
     
    param( 
 
      [string]$ResourceGroupName, 
      [string]$TenantID, 
      [string]$SPuser,
      [string]$SPpass 
     ) 
     

$ServicePassword = convertto-securestring $SPpass -asplaintext -force # The password of the Service Principal
$creds = new-object -typename System.Management.Automation.PSCredential -argumentlist $SPuser, $ServicePassword
Login-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $TenantID


$GetVMs = get-AzureRmVM -ResourceGroupName "$ResourceGroupName"

     if(!$GetVMs) { 
        Write-Output "No VMs were found in your subscription." 
     } else { 
        Foreach ($VM in $GetVMs) 
        { 
            Write-Output "Stopping $($VM.Name)"
        Stop-AzureRmVM -ResourceGroupName "$ResourceGroupName" -Name $VM.Name -Force -ErrorAction SilentlyContinue 
        } 
}
}
