#!/usr/bin/env bash

get_time() {
    cat tmp | grep "NVIM STARTED" | cut -d ' ' -f 1
}

pf() {
    printf '%s : ' "$@"
}

# FIXME: I could not add >/dev/null at the end of each warmup as Neovim
#        segfaults in WSL for some reason when redirecting to stdout lmao
echo "Warmup #1"
nvim -c q 2>&1 | tee -a /dev/null
echo "Warmup #2"
nvim -c q 2>&1 | tee -a /dev/null
echo "Warmup #3"
nvim -c q 2>&1 | tee -a /dev/null
echo "Warmup #4"
nvim -c q 2>&1 | tee -a /dev/null
echo "Warmup #5"
nvim -c q 2>&1 | tee -a /dev/null

pf "No config"
nvim --clean -nu NORC --startuptime tmp
get_time
rm tmp

pf "With config"
nvim --startuptime tmp
get_time
rm tmp

pf "Opening init.lua"
nvim "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua" --startuptime tmp
get_time
rm tmp

pf "Opening Python file"
nvim tmp.py --startuptime tmp
get_time
rm tmp

pf "Opening C File"
nvim tmp.c --startuptime tmp
get_time
rm tmp

pf "Opening norg File"
nvim tmp.norg --startuptime tmp
get_time
rm tmp
