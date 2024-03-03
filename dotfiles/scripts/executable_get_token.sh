#!/bin/bash

# BROKEN
default_port=8100

port=${1:-$default_port}

html_content=$(curl -s http://localhost:8100)

echo "Response: " $html_content

token=$(echo "$html_content" | pup 'script:contains("localStorage") text{}' | jq -r 'match("CognitoIdentityServiceProvider\\..*\\.idToken") | .string')

if [ -n "$token" ]; then
    echo "Token: $token"
		export TOKEN="$token"
else
    echo "Token not found in local storage."
fi

