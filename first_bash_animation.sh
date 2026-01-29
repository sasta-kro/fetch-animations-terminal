#!/bin/bash
# This tells the system to use bash to execute this file
# `#!` is literally called a Shabang. And the rest is the absoulte path of the application that should run

# Clean up cursor when program ends (this script hides the cursor during animation)
# If the user hits Ctrl+C, we want to show the cursor again before exiting.
# `tput` stands for "terminal put". this 'tput cnorm' command restores the cursor
trap 'tput cnorm; echo; exit' INT
# this is like try/catch in Kotlin. `trap...INT` catches a Signal INTerrupt (just this, nothing else) and executes the command.

# PREPARATION
# 'tput civis' hides the cursor so it doesn't flicker during animation.
# `civis` = cursor invisible. `cnorm` = cursor normal
tput civis 

clear # clear anything that might be in the way before the animation

# Define the frames for the animation
# Use an array `()` to store frames.
# IMPORTANT: Whitespace is a syntax. So even in variable assignment, there should be no whitespace around `=`
# or else Bash will think I am trying to run the command `frames` with arguments `=` and `(...)`
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

# THE main LOOP
while true; do
    # Iterate through each frame in the array
    # Normally, to access a variable in Bash, we have to do $variable (e.g. $frame)
    # but if the variable is not simple, it is accessed with ${variable} (e.g. ${frame}) just like in Kotlin
    # `[]` square bracket is is array access `array[0]` (e.g. $frames[0]) just like Kotlin/Python
    # Bash for-loops go through space separated values like `for i in 1 2 3 4; do`
    # `@` is the ALL index syntax. It tells Bash to unwrap the array into space separated elements. (spaces inside strings don't count)
    # like `"Element 1" "Element 2" "Element 3"` and so they will be iterated with space seperation

    for frame in "${frames[@]}"; do
        
        # \r = Carriage Return. It moves the cursor back to the start of the line. 
        # `-e` = enable escape characters, `-n` = no new line at the end of echo.
        # Combined `-e` with `-n` flag, this allows overwritting the previous text instead of printing a new line.
        echo -ne "$frame\r"
        
        # Sleep for 0.1 seconds to control speed
        sleep 0.1
    done
done


# Note: in Bash, 0 is True and 1 is False (exit code 0 is success

# Note: Conditions
# Kotlin style string equality
# if [[ "$name" == "Gemini" ]]; then ...  # [[]] syntax is for conditions 
# # Integer math uses yet ANOTHER syntax: (( ... ))
# if (( count > 5 )); then ...)

# `$()` syntax is to store or use the result of a command 
# current_time=$(date "+%H:%M:%S")
# echo "Script started at $current_time"