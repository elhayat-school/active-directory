# Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ADUsers variable
$ADUsers = Import-Csv ADUsers.csv -Delimiter ","

$Domain = "ghs.local"
$MailServer = "elhayatschool.com"

# Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

    #Read user data from each field in each row and assign the data to a variable as below
    $firstname = $User.firstname
    $lastname = $User.lastname.ToUpper()
    $username = "$lastname.$firstname".ToLower()
    $UPN = "$username@$Domain"
    $password = $User.password
    $OU = $User.ou #This field refers to the OU the user account is to be created in
    $email = "$username@$MailServer"
    $city = "Oran"
    $company = $User.company
    $division = $User.division
    $department = $User.Dpt
    $office = "NA"
    $jobtitle = "NA"
    $telephone = "NA"

    # Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName $UPN `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path $OU `
            -Country "DZ" `
            -State "Oran" `
            -City $city `
            -StreetAddress $null `
            -EmailAddress $email `
            -OfficePhone $telephone `
            -Organization "Groupe Elhayat School" `
            -Company $company `
            -Division $division `
            -Department $department `
            -Office $office `
            -Title $jobtitle `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) `
            -ChangePasswordAtLogon $false `
            -CannotChangePassword $true `
            -PasswordNeverExpires $true

        # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"