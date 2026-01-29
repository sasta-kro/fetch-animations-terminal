#!/bin/bash
# This tells the system to use bash to execute this file

# Clean up cursor
# If the user hits Ctrl+C, we want to show the cursor again before exiting.
# 'tput cnorm' restores the cursor.
trap 'tput cnorm; echo; exit' INT

# PREPARATION
# 'tput civis' hides the cursor so it doesn't flicker during animation.
tput civis 
clear

# Define our frames for the animation
# We use an array () to store frames.
frames=(
    "[      ]"
    "[=     ]"
    "[==    ]"
    "[===   ]"
    "[====  ]"
    "[===== ]"
    "[======]"
    "[===== ]"
    "[====  ]"
    "[===   ]"
    "[==    ]"
    "[=     ]"
)

echo "Starting Breathing Animation (Press Ctrl+C to stop)..."

# 4. THE LOOP
while true; do
    # Iterate through each frame in the array
    for frame in "${frames[@]}"; do
        
        # \r = Carriage Return. It moves the cursor back to the start of the line.
        # This allows us to overwrite the previous text instead of printing a new line.
        echo -ne "$frame\r"
        
        # Sleep for 0.1 seconds to control speed
        sleep 0.1
    done
done