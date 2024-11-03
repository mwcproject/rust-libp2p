#!/bin/bash

# Script to replace all occurrences of libp2p dependencies with mwc-libp2p equivalents in .toml files

# Define replacements as an associative array
declare -A replacements=(
    ["mwc-libp2p-swarm-derivee"]="mwc-libp2p-swarm-derivee"
)

# Loop over each replacement pattern in all .toml files
for key in "${!replacements[@]}"; do
    # Replace hyphenated versions (e.g., libp2p-core to mwc-libp2p-core)
    find . -type f -not -path '*/.*' -not -name "Cargo.lock" -exec \
        sed -i "s|$key|${replacements[$key]}|g" {} +
    
    # Replace underscore versions (e.g., libp2p_core to mwc_libp2p_core)
    underscore_key="${key//-/_}"
    underscore_replacement="${replacements[$key]//-/_}"
    find . -type f -not -path '*/.*' -not -name "Cargo.lock" -exec \
        sed -i "s|$underscore_key|$underscore_replacement|g" {} +
done

echo "All replacements completed."