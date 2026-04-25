#!/bin/bash

# Configurație monitor
MONITOR="eDP-1"
TMP_CONF="/tmp/hypr_rotate.conf"

# Obținem starea curentă a monitorului
CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

if [ -z "$CURRENT_TRANSFORM" ] || [ "$CURRENT_TRANSFORM" == "null" ]; then
    CURRENT_TRANSFORM=0
fi

# Decidem noua stare (0 sau 2)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_MON=2
    # Matricea pentru 180 grade (rotație completă)
    MATRIX="-1 0 1 0 -1 1"
else
    NEW_MON=0
    # Matricea normală
    MATRIX="1 0 0 0 1 0"
fi

# 1. Aplicăm rotația la monitor
hyprctl keyword monitor "$MONITOR, preferred, auto, 1, transform, $NEW_MON"

# 2. Generăm configurarea pentru dispozitive
# Folosim blocul 'device {}' pentru a evita problemele cu numele dispozitivelor
echo "" > "$TMP_CONF"

# Luăm toate dispozitivele Wacom și Elan
DEVICES=$(hyprctl devices -j | jq -r '.mice[].name, .touch[].name, .tablets[].name' | grep -E "wacom|elan" | sort -u)

for DEV in $DEVICES; do
    cat <<EOF >> "$TMP_CONF"
device {
    name = $DEV
    transform = $NEW_MON
    output = $MONITOR
}
EOF
done

# 3. Spunem Hyprland să aplice această configurare
hyprctl keyword source "$TMP_CONF"

echo "Monitor setat la $NEW_MON. Configurația de input a fost generată în $TMP_CONF și aplicată."
