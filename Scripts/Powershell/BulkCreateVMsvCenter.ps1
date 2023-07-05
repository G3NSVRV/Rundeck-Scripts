#
# PowerCLI to create VMs from existing vSphere VM
# Version 1.0
# Magnus Andersson RTS
#
# Specify vCenter Server, vCenter Server username and vCenter Server user password
$vCenter="192.168.235.207"
$vCenterUser="administrator@vsphere.local"
$vCenterUserPassword='Pa$$w0rd'
#
# Specify number of VMs you want to create
$vm_count = "1"
#
# Specify the VM you want to clone
$clone = "template"
#
# Specify the Customization Specification to use
$customspecification="default"
#
# Specify the datastore or datastore cluster placement
$ds = "vms"
#
# Specify vCenter Server Virtual Machine & Templates folder
$Folder = "RSE-379"
#
# Specify the vSphere Cluster
$Cluster = "cluster"
#
# Specify the VM name to the left of the - sign
$VM_prefix = "RSE379-"
#
# End of user input parameters
#_______________________________________________________
#
write-host "Connecting to vCenter Server $vCenter" -foreground green
Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0
1..$vm_count | foreach {
$y="{0:d4}" -f + $_
$VM_name= $VM_prefix + $y
$ESXi=Get-Cluster $Cluster | Get-VMHost -state connected | Get-Random
write-host "Creation of VM $VM_name initiated" -foreground green
New-VM -Name $VM_Name -VM $clone -VMHost $ESXi -Datastore $ds -Location $Folder -OSCustomizationSpec $customspecification -RunAsync
}