
# ----------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Code generated by Microsoft (R) AutoRest Code Generator.Changes may cause incorrect behavior and will be lost if the code
# is regenerated.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Create an in-memory object for SasDatastoreCredentials.
.Description
Create an in-memory object for SasDatastoreCredentials.

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MachineLearningServices.Models.Api20220501.SasDatastoreCredentials
.Link
https://learn.microsoft.com/powershell/module/az.MLWorkspace/new-AzMLWorkspaceDatastoreSasCredentialObject
#>
function New-AzMLWorkspaceDatastoreSasCredentialObject {
    [OutputType('Microsoft.Azure.PowerShell.Cmdlets.MachineLearningServices.Models.Api20220501.SasDatastoreCredentials')]
    [CmdletBinding(PositionalBinding=$false)]
    Param(

        [Parameter(Mandatory, HelpMessage="[Required] Storage container secrets.")]
        [string]
        $SasToken
    )

    process {
        $Object = [Microsoft.Azure.PowerShell.Cmdlets.MachineLearningServices.Models.Api20220501.SasDatastoreCredentials]::New()
        $Object.CredentialsType = 'Sas'
        $Secret = [Microsoft.Azure.PowerShell.Cmdlets.MachineLearningServices.Models.Api20220501.SasDatastoreSecrets]::New()
        $Secret.SecretsType = 'Sas'
        if ($PSBoundParameters.ContainsKey('SasToken')) {
            $Secret.SasToken = $SasToken
        }
        $Object.Secret = $Secret
        return $Object
    }
}

