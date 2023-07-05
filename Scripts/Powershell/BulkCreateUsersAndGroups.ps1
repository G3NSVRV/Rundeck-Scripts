## VARIABLES INIZIALIZATION
$dcPath="DC=rundeck,DC=local"
$rundeckDCPath="OU=Rundeck,DC=rundeck,DC=local"
#$userPath="OU=Users,OU=Rundeck,DC=rundeck,DC=local"
#$rolesPath="OU=Roles,OU=Rundeck,DC=rundeck,DC=local"
$domain="rundeck.local"
$username="rundeckUser"
$group="rundeckRole"
$password="Pa$$w0rd!"
$count=001..100

## CREATE REQUIRED OrganizationUnits
New-ADOrganizationalUnit -Name Rundeck -Path $dcPath
$output = New-ADOrganizationalUnit -Name Users -Path $rundeckDCPath -Verbose 4>&1
$userPath = echo $output | ForEach-Object { ([string]$_).Split('"')[3] }
$output = New-ADOrganizationalUnit -Name Roles -Path $rundeckDCPath -Verbose 4>&1
$rolesPath = echo $output | ForEach-Object { ([string]$_).Split('"')[3] }

# CREATE BULK USERS ON AD
foreach ($n in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
{ New-AdUser -UserPrincipalName $username$n@$domain -EmailAddress $username$n@$domain -Name $username$n -GivenName $username -Surname $n -Path $userPath -Enabled $true -ChangePasswordAtLogon $false -AccountPassword (ConvertTo-SecureString $password -AsPlainText -force) -passThru }

# CREATE BULK GROUPS ON AD
foreach ($n in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
{ New-ADGroup -Name $group$n -Path $rolesPath -GroupScope Global -PassThru -Verbose }

# ADD BULK GROUPS TO EACH USER ON AD
foreach ($x in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
{
    foreach ($n in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
    {
        Add-ADGroupMember -Identity $group$n -Members $username$x
        echo "$group$n -> $username$x"
    }
}

# TESTING 
# ADD BULK USERS TO GROUPS ON AD
#$count=0001..1000
#foreach ($n in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
#{ Add-ADGroupMember -Identity $group$n -Members $username$n }
#
# COUNT FROM 1 TO 10 WITH PAD 4
#$count=1..10
#foreach ($n in ($count| ForEach-Object {"{0:d4}" -f ($_)}))
#{ echo $n }