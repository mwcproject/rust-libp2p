#!/bin/bash

# Script to replace all occurrences of libp2p dependencies with mwc-libp2p equivalents in .toml files

# Define replacements as an associative array
declare -A replacements=(
    ["mwc-libp2p-core"]="mwc-mwc-libp2p-core"
    ["mwc-libp2p-floodsub"]="mwc-mwc-libp2p-floodsub"
    ["mwc-libp2p-gossipsub"]="mwc-mwc-libp2p-gossipsub"
    ["mwc-libp2p-identify"]="mwc-mwc-libp2p-identify"
    ["mwc-libp2p-kad"]="mwc-mwc-libp2p-kad"
    ["mwc-libp2p-mplex"]="mwc-mwc-libp2p-mplex"
    ["mwc-libp2p-noise"]="mwc-mwc-libp2p-noise"
    ["mwc-libp2p-ping"]="mwc-mwc-libp2p-ping"
    ["mwc-libp2p-plaintext"]="mwc-mwc-libp2p-plaintext"
    ["mwc-libp2p-pnet"]="mwc-mwc-libp2p-pnet"
    ["mwc-libp2p-request-response"]="mwc-mwc-libp2p-request-response"
)

# Loop over each replacement pattern in all .toml files
for key in "${!replacements[@]}"; do
    # Replace hyphenated versions (e.g., mwc-libp2p-core to mwc-mwc-libp2p-core)
    find . -type f -not -path '*/.*' -not -name "Cargo.lock" -exec \
        sed -i "s|$key|${replacements[$key]}|g" {} +
    
    # Replace underscore versions (e.g., mwc_libp2p_core to mwc_mwc_libp2p_core)
    underscore_key="${key//-/_}"
    underscore_replacement="${replacements[$key]//-/_}"
    find . -type f -not -path '*/.*' -not -name "Cargo.lock" -exec \
        sed -i "s|$underscore_key|$underscore_replacement|g" {} +
done

echo "All replacements completed."
