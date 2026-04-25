#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Rotire 180° (Transformare 2)
# Aceasta este singura valoare garantată matematic care corectează 180 de grade.
MATRIX_180_FLIP="-1 0 1 0 -1 1"
MATRIX_NORMAL="1 0 0 0 1 0"

CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2
    NEW_MATRIX=$MATRIX_180_FLIP
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
else
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, transform, $NEW_TRANSFORM_DISPLAY"

# Aici aplici rotirea doar pe dispozitivele de touch și pen
# Dacă ecranul este rotit, schimbăm și transformarea pentru input
if [ "$NEW_TRANSFORM_DISPLAY" -eq 2 ]; then
    # Ecranul este rotit cu 180°
    hyprctl keyword device "$TOUCH_FINGER:input_transform,$MATRIX_180_FLIP"
    hyprctl keyword device "$TOUCH_PEN:input_transform,$MATRIX_180_FLIP"
else
    # Ecranul este în poziția normală
    hyprctl keyword device "$TOUCH_FINGER:input_transform,$MATRIX_NORMAL"
    hyprctl keyword device "$TOUCH_PEN:input_transform,$MATRIX_NORMAL"
fi

#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Flip Orizontal (Mirror X) - Aceasta va corecta oglindirea suplimentară.
MATRIX_FLIP_HORIZONTAL=" -1 0 1 0 1 0"
MATRIX_NORMAL=" 1 0 0 0 1 0" # Matricea identitate (fără transformare)

CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2  # Rotirea ecranului: 180°
    # Aplicăm o singură oglindire (pe X)
    NEW_MATRIX=$MATRIX_FLIP_HORIZONTAL 
    NEW_RES=$RES_NORMAL
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    NEW_TRANSFORM_DISPLAY=0  # Revine la Rotire Normală
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
else
    # Revine la normal
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, $RES_NORMAL, 0x0, 1.0, transform, $NEW_TRANSFORM_DISPLAY"

# Aplică Matricea de Transformare la Touchscreen (FINGER)
hyprctl keyword device "$TOUCH_FINGER:input_transform,$NEW_MATRIX"

# Aplică Matricea de Transformare la Stylus (PEN)
hyprctl keyword device "$TOUCH_PEN:input_transform,$NEW_MATRIX"
#!/bin/bash

# Numele monitorului intern (eDP-1)
MONITOR="eDP-1"
# Rezoluția ta nativă
RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Rotire 180° + Flip (corecția oglindirii)
# Această matrice (-1 0 1 0 -1 1) ar trebui să fie corectă din punct de vedere matematic.
MATRIX_180_FLIP="-1 0 1 0 -1 1"
# Matricea identitate (pentru starea normală)
MATRIX_NORMAL="1 0 0 0 1 0" 

# Extrage transformarea curentă a monitorului
CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2 # Setează Rotirea la 180°
    NEW_MATRIX=$MATRIX_180_FLIP
else
    NEW_TRANSFORM_DISPLAY=0 # Revine la Rotirea Normală
    NEW_MATRIX=$MATRIX_NORMAL
fi

# Aplică Rotirea la Ecran (Sintaxa simplă care a funcționat anterior)
hyprctl keyword monitor "$MONITOR, transform, $NEW_TRANSFORM_DISPLAY"

# ! APLICARE PE TOATE DISPOZITIVELE WACOM/ELAN (WILDCARD)
# Folosim 'input_transform' pe wildcard pentru a prinde ambele dispozitive Wacom (pen și finger)
# și pentru a anula oglindirea.
hyprctl keyword device "wacom*:input_transform,$NEW_MATRIX"
hyprctl keyword device "elan*:input_transform,$NEW_MATRIX"
#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Rotire 180° (Transformare 2)
# Aceasta este singura valoare garantată matematic care corectează 180 de grade.
MATRIX_180_FLIP="-1 0 1 0 -1 1"
MATRIX_NORMAL="1 0 0 0 1 0"

CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2
    NEW_MATRIX=$MATRIX_180_FLIP
    NEW_RES=$RES_NORMAL
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
else
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, transform, $NEW_TRANSFORM_DISPLAY"

# Aplică Matricea de Transformare la Touchscreen (FINGER)
hyprctl keyword device "$TOUCH_FINGER:input_transform,$NEW_MATRIX"

# Aplică Matricea de Transformare la Stylus (PEN)
hyprctl keyword device "$TOUCH_PEN:input_transform,$NEW_MATRIX"
#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Flip Orizontal (Mirror X) - Aceasta va corecta oglindirea suplimentară.
MATRIX_FLIP_HORIZONTAL=" -1 0 1 0 1 0"
MATRIX_NORMAL=" 1 0 0 0 1 0" # Matricea identitate (fără transformare)

CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2  # Rotirea ecranului: 180°
    # Aplicăm o singură oglindire (pe X)
    NEW_MATRIX=$MATRIX_FLIP_HORIZONTAL 
    NEW_RES=$RES_NORMAL
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    NEW_TRANSFORM_DISPLAY=0  # Revine la Rotire Normală
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
else
    # Revine la normal
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, $RES_NORMAL, 0x0, 1.0, transform, $NEW_TRANSFORM_DISPLAY"

# Aplică Matricea de Transformare la Touchscreen (FINGER)
hyprctl keyword device "$TOUCH_FINGER:input_transform,$NEW_MATRIX"

# Aplică Matricea de Transformare la Stylus (PEN)
hyprctl keyword device "$TOUCH_PEN:input_transform,$NEW_MATRIX"
#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Rotire 180° (Transformare 2)
MATRIX_180_FLIP="-1 0 1 0 -1 1 0 0 1"
MATRIX_NORMAL="1 0 0 0 1 0 0 0 1"

# Obținem transformarea curentă a monitorului
CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Dacă ecranul este în poziția normală (0), îl rotim la 180, și invers
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    # Transformă ecranul la 180°
    NEW_TRANSFORM_DISPLAY=2
    NEW_MATRIX=$MATRIX_180_FLIP
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    # Dacă ecranul este deja rotit, îl aducem înapoi la normal
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
else
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, transform, $NEW_TRANSFORM_DISPLAY"

# Aici aplicăm rotirea pe dispozitivele de touch și pen
if [ "$NEW_TRANSFORM_DISPLAY" -eq 2 ]; then
    # Ecranul este rotit cu 180°
    xinput set-prop "$TOUCH_FINGER" "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
    xinput set-prop "$TOUCH_PEN" "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
else
    # Ecranul este în poziția normală
    xinput set-prop "$TOUCH_FINGER" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
    xinput set-prop "$TOUCH_PEN" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
fi
#!/bin/bash

MONITOR="eDP-1"
# NUMELE REALE ALE DISPOZITIVELOR TALE WACOM
TOUCH_FINGER="wacom-hid-5276-finger"
TOUCH_PEN="wacom-hid-5276-pen"

RES_NORMAL="1920x1200@60.02600"

# Matricea pentru Rotire 180° (Transformare 2)
# Aceasta este singura valoare garantată matematic care corectează 180 de grade.
MATRIX_180_FLIP="-1 0 1 0 -1 1"
MATRIX_NORMAL="1 0 0 0 1 0"

CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r --arg MON "$MONITOR" '.[] | select(.name == $MON) | .transform')

# Comută transformarea afișajului: 0 (Normal) <-> 2 (180 grade)
if [ "$CURRENT_TRANSFORM" -eq 0 ]; then
    NEW_TRANSFORM_DISPLAY=2
    NEW_MATRIX=$MATRIX_180_FLIP
    NEW_RES=$RES_NORMAL
elif [ "$CURRENT_TRANSFORM" -eq 2 ]; then
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
else
    NEW_TRANSFORM_DISPLAY=0
    NEW_MATRIX=$MATRIX_NORMAL
    NEW_RES=$RES_NORMAL
fi

# Aplică Rotirea la Ecran
hyprctl keyword monitor "$MONITOR, transform, $NEW_TRANSFORM_DISPLAY"

# Aplică Matricea de Transformare la Touchscreen (FINGER)
hyprctl keyword device "$TOUCH_FINGER:input_transform,$NEW_MATRIX"

# Aplică Matricea de Transformare la Stylus (PEN)
hyprctl keyword device "$TOUCH_PEN:input_transform,$NEW_MATRIX"
