---
to: scripts/flux_watch.sh
---
v=1
while [ $v -eq 1 ]; do 
    clear; 
    flux get all; 

    # Sleep for about 12 Seconds
    for i in {1..2}; do for j in '-' '\' '|' '/'; do echo -ne "\r$j"; sleep 1; done; done; 
    echo "Checking ..."
    # If everything is Ready Quit
    if flux get all | awk -F'\t' '{print $4}' | grep -q "False"; then
        echo "Waiting for Flux to be Ready"
        v=1
    else
        echo "Flux is Ready"
        v=0
    fi
done
