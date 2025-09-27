#!/usr/bin/env bash


#Author:Naduni
#Date:2025-09-27
#Script: list down the users in the public repo who uses that repo hashicorp terraform

#make scripts safe (exit on error,fail pipelines if any command fails)
set -euo pipefail  

# read arguments or use default repo

OWNER="${1:-hashicorp}"  #first argument, default 'hashicorp'
REPO="${2:-terraform}"      #second argument, default 'terrform'

#API endpoint

API_URL="https://api.github.com/repos/${OWNER}/${REPO}/contributors?per_page=100"


echo "fetching contributors for ${OWNER}/${REPO} ..."


#IF GITHUB_TOKEN is set, use it; otherwise do unauthenticated request

if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  curl -sS -H "Authorization: token ${GITHUB_TOKEN}" "$API_URL" | jq -r '.[].login'
else
	curl -sS "$API_URL" | jq -r '.[].login'
fi	
