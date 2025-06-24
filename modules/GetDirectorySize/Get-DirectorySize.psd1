@{

# Script module or binary module file associated with this manifest.
RootModule = 'Get-DirectorySize.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# ID used to uniquely identify this module
GUID = ''

# Author of this module
Author = 'Forever Thawne'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2019-2023 Forever Thawne'

# Description of the functionality provided by this module
Description = 'This module is for checking summarized file size or directory size.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
CLRVersion = '4.0'

FunctionsToExport = @('Get-Size', 'Get-ChildItemDetails', 'Format-Size')

AliasesToExport = @('dirs')
}

