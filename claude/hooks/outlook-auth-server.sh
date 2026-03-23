#!/bin/bash
# Pre-tool hook: ensure Outlook OAuth auth server is running on port 3333
# before any outlook-assistant authenticate call

# Check if port 3333 is already in use
if lsof -i :3333 -sTCP:LISTEN &>/dev/null; then
  exit 0
fi

# Start the auth server in the background
cd /Users/wallyhansen/cl/cl-os/integrations/outlook-mcp
nohup node outlook-auth-server.js &>/tmp/outlook-auth-server.log &

# Wait up to 3 seconds for the server to start
for i in 1 2 3; do
  sleep 1
  if lsof -i :3333 -sTCP:LISTEN &>/dev/null; then
    exit 0
  fi
done

echo "Warning: Auth server may not have started. Check /tmp/outlook-auth-server.log" >&2
exit 0
