---
external help file: Microsoft.Azure.PowerShell.Cmdlets.ResourceManager.dll-Help.xml
Module Name: Az.Resources
ms.assetid: BA40BD11-8167-48D7-AC71-72B2FD9924F2
online version: https://learn.microsoft.com/powershell/module/az.resources/new-azpolicyassignment
schema: 2.0.0
---

# New-AzPolicyAssignment

## SYNOPSIS
Creates a policy assignment.

## SYNTAX

### DefaultParameterSet (Default)
```
New-AzPolicyAssignment -Name <String> [-Scope <String>] [-NotScope <String[]>] [-DisplayName <String>]
 [-Description <String>] [-PolicyDefinition <PsPolicyDefinition>]
 [-PolicySetDefinition <PsPolicySetDefinition>] [-Metadata <String>]
 [-EnforcementMode <PolicyAssignmentEnforcementMode>] [-AssignIdentity] [-IdentityType <ManagedIdentityType>]
 [-IdentityId <String>] [-Location <String>] [-NonComplianceMessage <PsNonComplianceMessage[]>]
 [-ApiVersion <String>] [-Pre] [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### PolicyParameterObjectParameterSet
```
New-AzPolicyAssignment -Name <String> [-Scope <String>] [-NotScope <String[]>] [-DisplayName <String>]
 [-Description <String>] -PolicyDefinition <PsPolicyDefinition> [-PolicySetDefinition <PsPolicySetDefinition>]
 -PolicyParameterObject <Hashtable> [-Metadata <String>] [-EnforcementMode <PolicyAssignmentEnforcementMode>]
 [-AssignIdentity] [-IdentityType <ManagedIdentityType>] [-IdentityId <String>] [-Location <String>]
 [-NonComplianceMessage <PsNonComplianceMessage[]>] [-ApiVersion <String>] [-Pre]
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### PolicyParameterStringParameterSet
```
New-AzPolicyAssignment -Name <String> [-Scope <String>] [-NotScope <String[]>] [-DisplayName <String>]
 [-Description <String>] -PolicyDefinition <PsPolicyDefinition> [-PolicySetDefinition <PsPolicySetDefinition>]
 -PolicyParameter <String> [-Metadata <String>] [-EnforcementMode <PolicyAssignmentEnforcementMode>]
 [-AssignIdentity] [-IdentityType <ManagedIdentityType>] [-IdentityId <String>] [-Location <String>]
 [-NonComplianceMessage <PsNonComplianceMessage[]>] [-ApiVersion <String>] [-Pre]
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### PolicySetParameterObjectParameterSet
```
New-AzPolicyAssignment -Name <String> [-Scope <String>] [-NotScope <String[]>] [-DisplayName <String>]
 [-Description <String>] [-PolicyDefinition <PsPolicyDefinition>] -PolicySetDefinition <PsPolicySetDefinition>
 -PolicyParameterObject <Hashtable> [-Metadata <String>] [-EnforcementMode <PolicyAssignmentEnforcementMode>]
 [-AssignIdentity] [-IdentityType <ManagedIdentityType>] [-IdentityId <String>] [-Location <String>]
 [-NonComplianceMessage <PsNonComplianceMessage[]>] [-ApiVersion <String>] [-Pre]
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

### PolicySetParameterStringParameterSet
```
New-AzPolicyAssignment -Name <String> [-Scope <String>] [-NotScope <String[]>] [-DisplayName <String>]
 [-Description <String>] [-PolicyDefinition <PsPolicyDefinition>] -PolicySetDefinition <PsPolicySetDefinition>
 -PolicyParameter <String> [-Metadata <String>] [-EnforcementMode <PolicyAssignmentEnforcementMode>]
 [-AssignIdentity] [-IdentityType <ManagedIdentityType>] [-IdentityId <String>] [-Location <String>]
 [-NonComplianceMessage <PsNonComplianceMessage[]>] [-ApiVersion <String>] [-Pre]
 [-DefaultProfile <IAzureContextContainer>] [<CommonParameters>]
```

## DESCRIPTION
The **New-AzPolicyAssignment** cmdlet creates a policy assignment.
Specify a policy and scope.

## EXAMPLES

### Example 1: Policy assignment at subscription level
```powershell
$Subscription = Get-AzSubscription -SubscriptionName 'Subscription01'
$Policy = Get-AzPolicyDefinition -Name 'VirtualMachinePolicy'
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicyDefinition $Policy -Scope "/subscriptions/$($Subscription.Id)"
```

The first command gets a subscription named Subscription01 by using the Get-AzSubscription cmdlet and stores it in the $Subscription variable.
The second command gets the policy definition named VirtualMachinePolicy by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The final command assigns the policy in $Policy at the level of the subscription identified by the subscription scope string.

### Example 2: Policy assignment at resource group level
```powershell
$ResourceGroup = Get-AzResourceGroup -Name 'ResourceGroup11'
$Policy = Get-AzPolicyDefinition -Name 'VirtualMachinePolicy'
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId
```

The first command gets a resource group named ResourceGroup11 by using the Get-AzResourceGroup cmdlet and stores it in the $ResourceGroup variable.
The second command gets the policy definition named VirtualMachinePolicy by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The final command assigns the policy in $Policy at the level of the resource group identified by the **ResourceId** property of $ResourceGroup.

### Example 3: Policy assignment at resource group level with policy parameter object
```powershell
$ResourceGroup = Get-AzResourceGroup -Name 'ResourceGroup11'
$Policy = Get-AzPolicyDefinition -BuiltIn | Where-Object {$_.Properties.DisplayName -eq 'Allowed locations'}
$Locations = Get-AzLocation | Where-Object displayname -like '*east*'
$AllowedLocations = @{'listOfAllowedLocations'=($Locations.location)}
New-AzPolicyAssignment -Name 'RestrictLocationPolicyAssignment' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId -PolicyParameterObject $AllowedLocations
```

The first command gets a resource group named ResourceGroup11 by using the Get-AzResourceGroup cmdlet.
The command stores that object in the $ResourceGroup variable.
The second command gets the built-in policy definition for allowed locations by using the Get-AzPolicyDefinition cmdlet.
The command stores that object in the $Policy variable.
The third and fourth commands create an object containing all Azure regions with "east" in the name.
The commands store that object in the $AllowedLocations variable.
The final command assigns the policy in $Policy at the level of a resource group using the policy parameter object in $AllowedLocations.
The **ResourceId** property of $ResourceGroup identifies the resource group.

### Example 4: Policy assignment at resource group level with policy parameter file
Create a file called _AllowedLocations.json_ in the local working directory with the following content.


```powershell
<#{
    "listOfAllowedLocations":  {
      "value": [
        "westus",
        "westeurope",
        "japanwest"
      ]
    }
}#>
$ResourceGroup = Get-AzResourceGroup -Name 'ResourceGroup11'
$Policy = Get-AzPolicyDefinition -BuiltIn | Where-Object {$_.Properties.DisplayName -eq 'Allowed locations'}
New-AzPolicyAssignment -Name 'RestrictLocationPolicyAssignment' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId -PolicyParameter .\AllowedLocations.json
```

The first command gets a resource group named ResourceGroup11 by using the Get-AzResourceGroup cmdlet and stores it in the $ResourceGroup variable.
The second command gets the built-in policy definition for allowed locations by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The final command assigns the policy in $Policy at the resource group identified by the **ResourceId** property of $ResourceGroup using the policy parameter file AllowedLocations.json from the local working directory.

### Example 5: Policy assignment with a system assigned managed identity
```powershell
$ResourceGroup = Get-AzResourceGroup -Name 'ResourceGroup11'
$Policy = Get-AzPolicyDefinition -Name 'VirtualMachinePolicy'
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId -Location 'eastus' -IdentityType 'SystemAssigned'
```

The first command gets a resource group named ResourceGroup11 by using the Get-AzResourceGroup cmdlet and stores it in the $ResourceGroup variable.
The second command gets the policy definition named VirtualMachinePolicy by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The final command assigns the policy in $Policy to the resource group. A system assigned managed identity is automatically created and assigned to the policy assignment.

### Example 6: Policy assignment with a user assigned managed identity
```powershell
$ResourceGroup = Get-AzResourceGroup -Name 'ResourceGroup11'
$Policy = Get-AzPolicyDefinition -Name 'VirtualMachinePolicy'
$UserAssignedIdentity = Get-AzUserAssignedIdentity -ResourceGroupName 'ResourceGroup1' -Name 'UserAssignedIdentity1'
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId -Location 'eastus' -IdentityType 'UserAssigned' -IdentityId $UserAssignedIdentity.Id
```

The first command gets a resource group named ResourceGroup11 by using the Get-AzResourceGroup cmdlet and stores it in the $ResourceGroup variable.
The second command gets the policy definition named VirtualMachinePolicy by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The third command gets the user assigned managed identity named UserAssignedIdentity1 by using the Get-AzUserAssignedIdentity cmdlet and stores it in the $UserAssignedIdentity variable.
The final command assigns the policy in $Policy to the resource group. The user assigned managed identity identified by the **Id** property of $UserAssignedIdentity is assigned to the policy assignment by passing the **Id*** property to the IdentityId parameter.

### Example 7: Policy assignment with an enforcement mode property
```powershell
$Subscription = Get-AzSubscription -SubscriptionName 'Subscription01'
$Policy = Get-AzPolicyDefinition -Name 'VirtualMachinePolicy'
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicyDefinition $Policy -Scope "/subscriptions/$($Subscription.Id)" -EnforcementMode DoNotEnforce
```

The first command gets a subscription named Subscription01 by using the Get-AzSubscription cmdlet and stores it in the $Subscription variable.
The second command gets the policy definition named VirtualMachinePolicy by using the Get-AzPolicyDefinition cmdlet and stores it in the $Policy variable.
The final command assigns the policy in $Policy at the level of the subscription identified by the subscription scope string. 
The assignment is set with an EnforcementMode value of _DoNotEnforce_ i.e. the policy effect is not enforced during resource creation or update.

### Example 8: Policy assignment with non-compliance messages
```powershell
$PolicySet = Get-AzPolicySetDefinition -Name 'VirtualMachinePolicySet'
$NonComplianceMessages = @(@{Message="Only DsV2 SKUs are allowed."; PolicyDefinitionReferenceId="DefRef1"}, @{Message="Virtual machines must follow cost management best practices."})
New-AzPolicyAssignment -Name 'VirtualMachinePolicyAssignment' -PolicySetDefinition $PolicySet -NonComplianceMessage $NonComplianceMessages
```

The first command gets the policy set definition named VirtualMachinePolicySet by using the Get-AzPolicySetDefinition cmdlet and stores it in the $PolicySet variable.
The second command creates an array of non-compliance messages. One general purpose message for the entire assignment and one message specific to a SKU restriction policy within the assigned policy set definition.
The final command assigns the policy set definition in $PolicySet to the subscription with two non-compliance messages that will be shown if a resource is denied by policy.

## PARAMETERS

### -ApiVersion
Specifies the version of the resource provider API to use.
If you do not specify a version, this cmdlet uses the latest available version.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssignIdentity
Generate and assign a system assigned managed identity for this policy assignment. The identity will be used when executing deployments for 'deployIfNotExists' and 'modify' policies. Location is required when assigning an identity.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with azure

```yaml
Type: Microsoft.Azure.Commands.Common.Authentication.Abstractions.Core.IAzureContextContainer
Parameter Sets: (All)
Aliases: AzContext, AzureRmContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
The description for policy assignment

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DisplayName
Specifies a display name for the policy assignment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnforcementMode
The enforcement mode for policy assignment. Currently, valid values are Default, DoNotEnforce.

```yaml
Type: System.Nullable`1[Microsoft.Azure.Commands.ResourceManager.Cmdlets.Entities.Policy.PolicyAssignmentEnforcementMode]
Parameter Sets: (All)
Aliases:
Accepted values: Default, DoNotEnforce

Required: False
Position: Named
Default value: Default
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IdentityId
Specifies the Id of the user assigned managed identity to assign to this policy assignment. This value is required if the value 'UserAssigned' is passed to the -IdentityType parameter. 

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityType
Specifies the type of managed identity to assign to this policy assignment. If the 'SystemAssigned' value is provided, a system assigned managed identity is generated and assigned to this policy assignment. If the 'UserAssigned' value is provided, the user assigned identity passed via its Id to the -IdentityId parameter is assigned to this policy assignment. The identity will be used when executing deployments for 'deployIfNotExists' and 'modify' policies. Location is required when assigning an identity. Permissions must be granted to the identity using New-AzRoleAssignment after the system assigned identity is created. The IdentityType parameter will be given precedence if both the AssignIdentity and the IdentityType parameter are used.

```yaml
Type: System.Nullable`1[Microsoft.Azure.Commands.ResourceManager.Cmdlets.Entities.Resources.ManagedIdentityType]
Parameter Sets: (All)
Aliases:
Accepted values: SystemAssigned, UserAssigned, None

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
The location of the policy assignment's resource identity. This is required when the -IdentityType value is provided.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Metadata
The metadata for the new policy assignment. This can either be a path to a file name containing the metadata, or the metadata as a string.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies a name for the policy assignment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NonComplianceMessage
The non-compliance messages that describe why a resource is non-compliant with the policy.

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsNonComplianceMessage[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NotScope
The not scopes for policy assignment.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyDefinition
Specifies a policy, as a **PsPolicyDefinition** object that contains the policy rule.

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyDefinition
Parameter Sets: DefaultParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyDefinition
Parameter Sets: PolicyParameterObjectParameterSet, PolicyParameterStringParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyDefinition
Parameter Sets: PolicySetParameterObjectParameterSet, PolicySetParameterStringParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyParameter
The policy parameter file path or policy parameter string.

```yaml
Type: System.String
Parameter Sets: PolicyParameterStringParameterSet, PolicySetParameterStringParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyParameterObject
The policy parameter object.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: PolicyParameterObjectParameterSet, PolicySetParameterObjectParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicySetDefinition
The policy set definition object.

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicySetDefinition
Parameter Sets: DefaultParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicySetDefinition
Parameter Sets: PolicyParameterObjectParameterSet, PolicyParameterStringParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicySetDefinition
Parameter Sets: PolicySetParameterObjectParameterSet, PolicySetParameterStringParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Pre
Indicates that this cmdlet considers pre-release API versions when it automatically determines which version to use.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Specifies the scope at which to assign the policy.
For instance, to assign a policy to a resource group, specify the following:
`/subscriptions/`subscription ID`/resourcegroups/`resource group name

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.String[]

### Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyDefinition

### Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicySetDefinition

### System.Nullable`1[[Microsoft.Azure.Commands.ResourceManager.Cmdlets.Entities.Policy.PolicyAssignmentEnforcementMode, Microsoft.Azure.PowerShell.Cmdlets.ResourceManager, Version=3.5.0.0, Culture=neutral, PublicKeyToken=null]]

### Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsNonComplianceMessage[]

## OUTPUTS

### Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyAssignment

## NOTES

## RELATED LINKS

[Get-AzPolicyDefinition](./Get-AzPolicyDefinition.md)

[Get-AzPolicyAssignment](./Get-AzPolicyAssignment.md)

[Remove-AzPolicyAssignment](./Remove-AzPolicyAssignment.md)

[Set-AzPolicyAssignment](./Set-AzPolicyAssignment.md)


