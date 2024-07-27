#!/bin/bash

# Define the I2C bus and VCP code for brightness
I2C_BUS=7  # Replace with your actual I2C bus number
VCP_CODE=10  # VCP code for brightness
STEP=10  # Adjust this value to control the increment/decrement step
SLEEP=.1

# Get the current brightness
# CURRENT_BRIGHTNESS=$(ddcutil --bus=$I2C_BUS getvcp $VCP_CODE | awk -F '[:,=]' '/current value/ {print $3}' | tr -d ' ')

# Calculate new brightness
if [ "$1" == "up" ]; then
  cmd=("ddcutil" "--async" "--maxtries" "1,1,1" "--noverify" "--sleep-multiplier" "$SLEEP" "--bus=$I2C_BUS" "setvcp" "$VCP_CODE" "+" "$STEP")
  "${cmd[@]}"
elif [ "$1" == "down" ]; then
  cmd=("ddcutil" "--async" "--maxtries" "1,1,1" "--noverify" "--sleep-multiplier" "$SLEEP" "--bus=$I2C_BUS" "setvcp" "$VCP_CODE" "-" "$STEP")
  "${cmd[@]}"
else
  echo "Usage: $0 {up|down}"
  exit 1
fi


