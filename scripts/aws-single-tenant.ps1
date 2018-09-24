<#
.SYNOPSIS
Create new ec2 instance.
.NOTES
    Author:  Mary Mazi
    Version: 1.0
    Created: 09/20/2018
    Last Modified: 
    Modified By: 
    Changes:
    X.X - Put changes here
    To Do:
    X.X - Put todos here
  .PARAMETER ImageId
      ImageId of the AMI to create the instance from.
    This is a required parameter.
.PARAMETER MinCount
    Minimum number of instances to be created.
    This is a required parameter.
.PARAMETER MaxCount
    Maximum number of instances to be created.
    This is a required parameter.
.PARAMETER KeyName
      Name of the keypair to use to log into the AMI.
    This is a required parameter.
  .PARAMETER SecurityGroups
    Name of the base AMI's security group.
    This is a required parameter.
.PARAMETER InstanceType
    Type of instance to be created.
    This is a required parameter.

.EXAMPLE
    PS .\new_single_tenant_environment.ps1 'ami-0efc5b6c' 1 1 'single-tenant-env-key' 'SingleTenantEvnSG' 't2.large'

#>

# Define the parameters for the script
[CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, Position=0)]
        [string]$ImageId,

        [Parameter(Mandatory=$True, Position=1)]
        [int]$MinCount,

        [Parameter(Mandatory=$True, Position=2)]
        [int]$MaxCount,

        [Parameter(Mandatory=$True, Position=3)]
        [string]$KeyName,

        [Parameter(Mandatory=$True, Position=4)]
        [string]$SecurityGroup,

        [Parameter(Mandatory=$True, Position=5)]
        [string]$InstanceType
    )


# Create a new ec2 Instance
New-EC2Instance -ImageId $ImageId -MinCount $MinCount -MaxCount $MaxCount -KeyName $KeyName -SecurityGroups $SecurityGroup -InstanceType $InstanceType 