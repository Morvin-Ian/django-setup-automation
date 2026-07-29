#!/bin/bash

GREEN='\033[0;32m'
BOLD='\033[1m'
RESET='\033[0m'

statement="Django setup automation By ___ Morvin Ian ___"


terminal_width=$(tput cols)

num_asterisks=$(( (terminal_width - ${#statement}) / 2 - 1))

printf "%${terminal_width}s\n" | tr ' ' '*'

printf "%${num_asterisks}s${GREEN}${BOLD}%s${RESET}%${num_asterisks}s\n" "" "$statement" ""

printf "%${terminal_width}s\n" | tr ' ' '*'

