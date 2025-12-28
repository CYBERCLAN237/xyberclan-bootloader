#!/usr/bin/env bash
set -e

# Enable debug mode to see frames without clearing
DEBUG_MODE=1

# Source the poweroff animation functions
source "$(dirname "$0")/poweroff-animation.sh"

# Run the shutdown animation with a short delay for quick test
animate_shutdown 0.1

echo "Power-off animation test completed successfully."
