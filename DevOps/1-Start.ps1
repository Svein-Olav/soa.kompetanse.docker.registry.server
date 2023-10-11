# Logg p� azure med riktig bruker
az login

# Setter riktig subscription
$SECRET = (az keyvault secret show --name subscriptionID --vault-name kompetanse-keyvault-kv --query value --output tsv)

$subscriptionID = $SECRET
az account set --subscription $subscriptionID

# Vis subscription informasjon
az account show

#Resource group m� eksistere. Vi lager en variabel for � slippe � skrive inn navnet flere ganger
$global:resourceGroup = "svein-container-registry-rg"
az group create -l westeurope -n $resourceGroup
