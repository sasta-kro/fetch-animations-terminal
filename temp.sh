#!/bin/bash

# Defining Colors using tput (Command Substitution)
# using raw colour notation such as `\e[31m` works but it might not work for all terminals.
# thus it is encouraged to use `tput setaf <number>`. 'setaf' = Set ANSI Foreground
# `setaf` asks the terminal what a specific colour code is for this terminal. 
# That's why `setaf` is more portable than raw colour code. 

# `tput` = terminal put (terminal interaction)

# ANSI color codes
# Blue corresponds to setaf 4.
BLUE=$(tput setaf 4)

# White corresponds to setaf 7 in the standard ANSI palette.
WHITE=$(tput setaf 7)

# sgr0 resets all attributes (colors, bold, etc.) to the terminal default. 
# (or else the terminal might be coloured even after the program ends)
RESET=$(tput sgr0)

# Trap executes cleanup commands when SIGINT (Ctrl+C) or TERM signals occur.
# 'tput cnorm' restores the cursor visibility before exiting.
trap 'tput cnorm; echo; exit' INT TERM

# Array of frames containing the ASCII art of Fedora logo.
# The variable expansion requires quotes to preserve newlines and spacing.
frames=(

...

)

# Clearing the screen (pervious texts in the terminal) provides a blank canvas for the animation
clear

# `civis` (Cursor Invisible) hides the block/line cursor to prevent flickering.
# will be reverted with `cnorm` when the script ends
tput civis 

# `sc`` (Save Cursor) marks the current position (0,0 after clear) as the anchor point.
tput sc

# Iterates through the frames array.
for frame in "${frames[@]}"; do
    
    # rc (Restore Cursor) moves the cursor back to the saved anchor point (top-left).
    # This ensures the new frame overwrites the old frame exactly.
    tput rc

    # Prints the frame. Newlines inside the string move the cursor down naturally.
    # no need for `-e` since there are no escape characters
    echo -n "$frame"
    
    # Pauses for 0.2 seconds. 0.001 is often too fast for the eye to register.
    sleep 0.03
done

# Restores the cursor visibility before the script ends naturally.
tput cnorm
echo ""