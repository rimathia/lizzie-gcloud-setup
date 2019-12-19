#!/usr/bin/env bash

# Installs KataGo for Lizzie on a gcloud compute instance
set -eu

source ./config.sh

./scripts/start-instance.sh
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "sudo mkdir -p /katago && sudo chmod -R o+rw /katago"
gcloud compute scp --zone "$ZONE" remote-katago/* "$INSTANCE_NAME":/katago
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "sudo chmod +x /katago/setup-katago.sh && /katago/setup-katago.sh"
