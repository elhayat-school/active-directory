# example
New-ADOrganizationalUnit -Name "oran"        -Path "DC=ghs, DC=local"

New-ADOrganizationalUnit -Name "birdjir"     -Path "OU=oran, DC=ghs, DC=local"
New-ADOrganizationalUnit -Name "usto"        -Path "OU=birdjir, OU=oran, DC=ghs, DC=local"
New-ADOrganizationalUnit -Name "users"       -Path "OU=usto, OU=birdjir, OU=oran, DC=ghs, DC=local"