Import-Module ActiveDirectory

# Define path to CSV file
$Csvfile = "C:\Users\Administrator\Desktop\new-users.csv"
$Users = Import-Csv $Csvfile
$DefaultPassword = ConvertTo-SecureString "SecurePassword" -AsPlainText -Force

try {
    foreach ($User in $Users) {
         # Construct full name from GivenName and Surname
         $FullName = "$($User.GivenName) $($User.Surname)"
        try {
            New-ADUser -Name $FullName `
                       -GivenName $User.GivenName `
                       -Surname $User.Surname `
                       -SamAccountName $User.SamAccountName `
                       -UserPrincipalName "$($User.SamAccountName)@lab-test.local" `
                       -Path $User.OU `
                       -AccountPassword $DefaultPassword `
                       -Enabled $true `
                       -ChangePasswordAtLogon $false

            Write-Host "Created user: $FullName" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to create user $($FullName): $($_)"
        }
    }
}
catch {
    Write-Error "Failed to process CSV file: $_"
    exit 1
}