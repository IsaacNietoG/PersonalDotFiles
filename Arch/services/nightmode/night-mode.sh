#!/bin/bash

# Configuración: Hora de inicio (19 = 7 PM) y fin (7 = 7 AM)
START_HOUR=19
END_HOUR=7
CURRENT_HOUR=$(date +%H)

# Si la hora actual es mayor o igual a START o menor que END
if [ "$CURRENT_HOUR" -ge "$START_HOUR" ] || [ "$CURRENT_HOUR" -lt "$END_HOUR" ]; then
    # Solo lo ejecuta si no está corriendo ya
    if ! pgrep -x "hyprsunset" > /dev/null; then
        hyprsunset --temperature 2000K &
    fi
else
    # Si es de día, mata el proceso
    pkill -x hyprsunset
fi
