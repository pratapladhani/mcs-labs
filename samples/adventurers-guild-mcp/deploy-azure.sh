#!/bin/bash

# Azure Deployment Script for Adventurers Guild MCP Server
# This script deploys the MCP server to Azure Container Apps

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}⚔️  Adventurers Guild MCP - Azure Deployment${NC}"
echo ""

# Configuration
RESOURCE_GROUP="rg-adventurers-guild-lab"
LOCATION="eastus"
CONTAINER_APP_ENV="env-adventurers-guild"
CONTAINER_APP_NAME="adventurers-guild-mcp"
ACR_NAME="acradventurersguild$RANDOM"

echo -e "${YELLOW}📋 Configuration:${NC}"
echo "  Resource Group: $RESOURCE_GROUP"
echo "  Location: $LOCATION"
echo "  ACR Name: $ACR_NAME"
echo ""

# Step 1: Register required resource providers
echo -e "${YELLOW}🔧 Step 1: Registering Azure resource providers...${NC}"

echo "  Registering Microsoft.ContainerRegistry..."
az provider register --namespace Microsoft.ContainerRegistry

echo "  Registering Microsoft.App..."
az provider register --namespace Microsoft.App

echo "  Registering Microsoft.OperationalInsights..."
az provider register --namespace Microsoft.OperationalInsights

# Wait for registration
echo ""
echo -e "${YELLOW}⏳ Waiting for resource providers to register (this may take 2-5 minutes)...${NC}"

for provider in "Microsoft.ContainerRegistry" "Microsoft.App" "Microsoft.OperationalInsights"; do
  echo "  Waiting for $provider..."
  while [ "$(az provider show --namespace $provider --query registrationState -o tsv)" != "Registered" ]; do
    sleep 15
    echo "    Still registering $provider..."
  done
  echo -e "  ${GREEN}✓${NC} $provider registered"
done

echo ""
echo -e "${GREEN}✓ All resource providers registered${NC}"
echo ""

# Step 2: Create resource group
echo -e "${YELLOW}🏗️  Step 2: Creating resource group...${NC}"
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION \
  --output none

echo -e "${GREEN}✓ Resource group created${NC}"
echo ""

# Step 3: Create Azure Container Registry
echo -e "${YELLOW}📦 Step 3: Creating Azure Container Registry...${NC}"
az acr create \
  --resource-group $RESOURCE_GROUP \
  --name $ACR_NAME \
  --sku Basic \
  --admin-enabled true \
  --output none

echo -e "${GREEN}✓ ACR created${NC}"
echo ""

# Step 4: Build and push container image
echo -e "${YELLOW}🔨 Step 4: Building and pushing container image...${NC}"
az acr build \
  --registry $ACR_NAME \
  --image adventurers-guild-mcp:latest \
  --file Dockerfile \
  .

echo -e "${GREEN}✓ Image built and pushed${NC}"
echo ""

# Step 5: Get ACR credentials
echo -e "${YELLOW}🔑 Step 5: Retrieving ACR credentials...${NC}"
ACR_USERNAME=$(az acr credential show --name $ACR_NAME --query username -o tsv)
ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query "passwords[0].value" -o tsv)
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer -o tsv)

echo -e "${GREEN}✓ Credentials retrieved${NC}"
echo ""

# Step 6: Create Container Apps environment
echo -e "${YELLOW}🌍 Step 6: Creating Container Apps environment...${NC}"
az containerapp env create \
  --name $CONTAINER_APP_ENV \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --output none

echo -e "${GREEN}✓ Environment created${NC}"
echo ""

# Step 7: Deploy Container App
echo -e "${YELLOW}🚀 Step 7: Deploying Container App...${NC}"
az containerapp create \
  --name $CONTAINER_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --environment $CONTAINER_APP_ENV \
  --image "$ACR_LOGIN_SERVER/adventurers-guild-mcp:latest" \
  --target-port 3000 \
  --ingress external \
  --registry-server $ACR_LOGIN_SERVER \
  --registry-username $ACR_USERNAME \
  --registry-password $ACR_PASSWORD \
  --cpu 0.25 \
  --memory 0.5Gi \
  --min-replicas 0 \
  --max-replicas 1 \
  --output none

echo -e "${GREEN}✓ Container App deployed${NC}"
echo ""

# Step 8: Get the public URL
echo -e "${YELLOW}🔗 Step 8: Getting public URL...${NC}"
FQDN=$(az containerapp show \
  --name $CONTAINER_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query properties.configuration.ingress.fqdn -o tsv)

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Deployment Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}🌐 MCP Server URL:${NC} https://$FQDN/mcp"
echo ""
echo -e "${YELLOW}📝 Test your deployment:${NC}"
echo ""
echo "  curl https://$FQDN/mcp \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -H 'Accept: application/json' \\"
echo "    -d '{\"jsonrpc\":\"2.0\",\"id\":\"1\",\"method\":\"tools/list\"}'"
echo ""
echo -e "${YELLOW}🧹 To delete all resources later:${NC}"
echo "  az group delete --name $RESOURCE_GROUP --yes --no-wait"
echo ""