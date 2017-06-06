
workflow Stop-ALLVMs 
{ 
     
    param( 
 
      [string]$ResourceGroupName 
 
     ) 
     

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

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
