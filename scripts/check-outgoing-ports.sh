#!/bin/bash

# TODO: Still need to find a method of testing UDP outbound. Currently only does TCP.

REQUIRED_OUTBOUND_TCP_PORTS=(80 443 1337)
REQUIRED_OUTBOUND_UDP_PORTS=(1337)

for i in "${REQUIRED_OUTBOUND_TCP_PORTS[@]}"
do
  echo "Checking to see if outbound TCP port $i is open..."
  
  curlResult=$(curl --max-time 10 -s portquiz.net:$i)

  if [[ "$curlResult" == *"Connection timed out"* ]]; then
    echo "Connection timed out. TCP port $i outbound does not seem to be allowed. Check your firewall rules."

  elif [[ "$curlResult" == *"Port test successful"* ]]; then
    echo "Port test successful. TCP port $i outbound was allowed."

  else
    echo "curl result is something unexpected. portquiz.net may be throttling."
  fi

  sleep 3 # try to avoid portquiz.net throttling
done