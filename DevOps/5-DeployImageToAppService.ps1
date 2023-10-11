$planname = "svein-server-plan"
$app_name = "svein-server-app"

az appservice plan create --name $planname --resource-group $resourceGroup --sku B1 --is-linux --location westeurope

az webapp create `
     --resource-group $resourceGroup `
     --plan $planname `
     --name $app_name `
     --deployment-container-image-name "$acr_name.azurecr.io/server:v1" 

$passord = az acr credential show -n $acr_name --resource-group $resourceGroup --query "passwords[0].value" -o json
$username = az acr credential show -n $acr_name --resource-group $resourceGroup --query "username" -o json

az webapp config container set `
    --resource-group $resourceGroup `
    --name $app_name `
    --docker-custom-image-name "$acr_name.azurecr.io/server:v1" `
    --docker-registry-server-url "$acr_name.azurecr.io" `
    --docker-registry-server-user $username `
    --docker-registry-server-password $passord