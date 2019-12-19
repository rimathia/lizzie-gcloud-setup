#!/usr/bin/env bash

# Installs leela-zero and katago for Lizzie on a gcloud compute instance
set -eu

source ./config.sh

./scripts/start-instance.sh
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "sudo mkdir -p /leela && sudo chmod -R o+rw /leela"
gcloud compute scp --zone "$ZONE" remote/*.sh "$INSTANCE_NAME":/leela
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "/leela/setup.sh"
./scripts/tune-instance.sh

gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "sudo mkdir -p /katago && sudo chmod -R o+rw /katago"
gcloud compute scp --zone "$ZONE" remote_katago/* "$INSTANCE_NAME":/katago
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "/katago/setup-katago.sh"
