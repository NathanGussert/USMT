function Initialize-USMTShare {
    [CmdletBinding()]
    param (
        $USMTFolderPath = "E:\Shares\USMT",
        $USMTToolURL
    )
    
    begin {
        
    }
    
    process {
        # Check desired folder path for USMT tool
        # Check for secondary "Data" volume and get it's drive letter
            # Check for a "Shares" folder and use that
        

        try {
            Get-ChildItem $USMTFolderPath -ErrorAction Stop
        }
        catch {
            New-Item -Path $USMTFolderPath -ItemType Directory
        }
                
        
        # Set the NTFS permissions
        $Acl = Get-Acl $USMTFolderPath
        $Acl.SetAccessRuleProtection($False,$True)
        $identity = 'Authenticated Users'
        $fileSystemRights = "Modify"
        $type = "Allow"

        $ACLRule = @{
            TypeName = 'System.Security.AccessControl.FileSystemAccessRule'
            ArgumentList = $identity, $fileSystemRights, 'ContainerInherit, ObjectInherit', 'None', $type
        }
        
        $rule = New-Object @ACLRule
        #$rule = New-Object System.Security.AccessControl.FileSystemAccessRule( "$($Folder.Name) - Folder Access ( $Level )", $Level ,'ContainerInherit, ObjectInherit', 'None', 'Allow')
        $Acl.AddAccessRule( $rule )
        # Apply the new ACL Rule to the folder
        $Acl | Set-ACL $USMTFolderPath

        # Share the folder
        $SMBShareParams = @{
            Name = 'USMT'
            Path = $USMTFolderPath
            FullAccess = 'Authenticated Users'
        }

        $USMTShare = New-SmbShare @SMBShareParams
        
        # Download USMT tool if not preset
                
        try {
            Get-ChildItem "$USMTFolderPath\User State Migration Tool" -ErrorAction Stop 
        }
        catch {
            Invoke-Expression(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/NathanGussert/Start-FileDownload/main/Start-FileDownload.psm1')
            #Start-FileDownload
        }

        # Check desired folder path is Shared and permissions are set
        # Set folder shareing and permissions if not appropriate


    }
    
    end {
        
    }
}

<#

function Test-USMTShare {
    [CmdletBinding()]
    param (
        $USMTFolderPath = "C:\Scans",
        $USMTToolURL
        )
        
        begin {
            
        }
        
        process {
            # Check for USMT Share existance
            try {
                Get-SMBShare 'USMT'
            }
            catch {
                try {
                    Get-SMBShare 'USMT$'
                }
                catch {
                    # SMB Share not present.  This needs to be created
                    "Thing failed on both.  Should not get here if one responds though"
                }
            }
            
            # Check the USMT share and folder permission
            try {
                Get-Permissions
            }
            catch {
                # Permissions not set as they should be.  These should get set.
            }
            
            
        }
        
        end {
            
        }
    }
#>