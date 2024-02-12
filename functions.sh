#!/bin/bash


function provider-login {
    local ERROR_VAR=$?
    if [[ $ERROR_VAR == 0 ]]; then
        if [[ $1 == "azure" ]]; then
            az login --service-principal -u "$AZURE_CLIENT_ID" -p "$AZURE_CLIENT_SECRET" --tenant "$AZURE_TENANT_ID"
            az account set --subscription "$AZURE_SUBSCRIPTION_ID"
            az account show
            ERROR_VAR=$?
        fi
    fi
    return $ERROR_VAR
}
