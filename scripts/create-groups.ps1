$groups = @(
    @{ Name = "Sales_Team"; Path = "OU=Users,OU=Sales,OU=HeadOffice,DC=lab-test,DC=local" },
    @{ Name = "HR_Staff"; Path = "OU=Users,OU=HR,OU=HeadOffice,DC=lab-test,DC=local" },
    @{ Name = "Finance_Team"; Path = "OU=Users,OU=Finance,OU=HeadOffice,DC=lab-test,DC=local" },
    @{ Name = "IT_Users"; Path = "OU=Users,OU=IT,OU=HeadOffice,DC=lab-test,DC=local" }
)

# Loop through each group and check if it exists
foreach ($group in $groups) {
    $groupName = $group.Name
    $groupPath = $group.Path

    if (Get-ADGroup -Filter "Name -eq '$groupName'" -ErrorAction SilentlyContinue) {
        Write-Host "Group '$groupName' already exists."
    } else {
        New-ADGroup -Name $groupName -GroupCategory Security -GroupScope Global -Path $groupPath
        Write-Host "Group '$groupName' created successfully."
    }
}