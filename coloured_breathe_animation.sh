#!/bin/bash

# Configuration
# Define Colors using tput (Command Substitution)
# using raw colour notation such as `\e[31m` works but it might not work for all terminals.
# thus it is encouraged to use `tput setaf <number>`. 'setaf' = Set ANSI Foreground
# `setaf` asks the terminal what a specific colour code is for this terminal. 
# That's why `setaf` is more portable than raw colour code. 


# Storing the result of the command in the variable with `$()` syntax
# Common numbers: 1=Red, 2=Green, 3=Yellow, 4=Blue, 5=Magenta, 6=Cyan, 7=White
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
# YELLOW=$(tput setaf 3)
# BLUE=$(tput setaf 4)
# CYAN=$(tput setaf 6)
RESET=$(tput sgr0) # Resets color to default (or else the terminal might be coloured even after the program ends)

# SETUP 

# Trap: catch Ctrl+C (INT interrutption), restore cursor, reset colors, and exit
trap 'tput cnorm; echo -ne "${RESET}"; exit' INT
# alternatively, this can be used: `trap 'tput cnorm; tput sgr0; exit' INT`
# this is calling the command directly instead of wrapping it in a string and printing it.

# Hide cursor
tput civis # tput cursor invisible
clear

# Frames array
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

echo "Starting Colored Breathing Animation (Press Ctrl+C to stop)..."

# MAIN LOOP 

while true; do
    for frame in "${frames[@]}"; do
        # print: COLOR + FRAME + RESET + Carriage Return
        #  `COLOR + FRAME + RESET` ensures the color only applies to the frame, not the rest of the terminal
        
        # Example 1: Static Color (Cyan). No if statements required
        # echo -ne "${CYAN}${frame}${RESET}\r"
        
        # Example 2: Dynamic "warning" wolor
        # making it RED if the bar is full "[======]", and GREEN otherwise.
        
        if [[ "$frame" == "[======]" ]]; then
             current_color=$RED
        else
             current_color=$GREEN
        fi
        
        echo -ne "${current_color}${frame}${RESET}\r"
        
        sleep 0.1
    done
done