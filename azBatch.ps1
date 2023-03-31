# Set Resource Group and Batch Account Name
$RG = (New-AzResourceGroup -Name "azBatch-RB" -Location "East US" -Force).ResourceGroupName
$batchAcctName = "azbatchacctek1"

# Create an example Batch Account is one doesn't exist
if (-not (Get-AzBatchAccount -ResourceGroupName $RG -Name $batchAcctName -ErrorAction SilentlyContinue)) {
    New-AzBatchAccount -ResourceGroupName $RG -Name $batchAcctName -Location "East US"
}
$batchAuthContext = Get-AzBatchAccountKey -ResourceGroupName $RG -AccountName $batchAcctName

# Look up the supported images
Get-AzBatchSupportedImage -batchContext $batchAuthContext | Where-Object ImageReference -Like "*dsvm*"