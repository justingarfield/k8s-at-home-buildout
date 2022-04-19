#!/bin/bash

helm install jackett k8s-at-home/jackett -n jollyroger

# Configure public trackers automatically
# If Flaresolverr installed, configure automatically (move flaresolverr steps before these ones)
# Make sure a non-default API key gets auto-generated
# Configure BasePathOverride /jackett
# How to handle admin password?
