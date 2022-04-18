#!/bin/bash

# This script simply removes any old ReplicaSets that have DESIRED, CURRENT, READY counts all as 0.
kubectl get rs -A -o wide | tail -n +2 | awk '{if ($3 + $4 + $5 == 0) print "kubectl delete rs -n "$1, $2 }' | sh