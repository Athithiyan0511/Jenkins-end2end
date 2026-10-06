#!/bin/bash

set -e

INSTANCE_ID="${EC2_INSTANCE_ID}"

if [ -z "$INSTANCE_ID" ]; then
    echo "ERROR: EC2_INSTANCE_ID is not set."
    exit 1
fi

ipv4_address=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

if [ -z "$ipv4_address" ] || [ "$ipv4_address" = "None" ]; then
    echo "ERROR: Could not retrieve EC2 public IP."
    exit 1
fi

file_to_find="../backend/.env.docker"

if [ ! -f "$file_to_find" ]; then
    echo "ERROR: File not found: $file_to_find"
    exit 1
fi

sed -i -e "s|^FRONTEND_URL.*|FRONTEND_URL=\"http://${ipv4_address}:5173\"|g" "$file_to_find"

echo "Backend environment updated: FRONTEND_URL=http://${ipv4_address}:5173"
