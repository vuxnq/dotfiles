#!/bin/bash

SINK_ID="TTS_Cable"
SOURCE_ID="TTS_Mic_Source"

SINK_DESC="TTS Virtual Cable"
SOURCE_DESC="TTS Mic"

CURRENT_LANG="cs"
MONITOR=false

cleanup() {
    echo -e "\n\nunloading modules..."

    if [[ -n "$LOOPBACK_ID" ]]; then
        pactl unload-module "$LOOPBACK_ID"
        LOOPBACK_ID=""
    else
        pactl list modules short | grep -F "TTS_Monitor" | awk '{print $1}' | xargs -r pactl unload-module
    fi

    pactl list modules short | grep "source_name=$SOURCE_ID" | awk '{print $1}' | xargs -r pactl unload-module
    pactl list modules short | grep "sink_name=$SINK_ID" | awk '{print $1}' | xargs -r pactl unload-module

    exit 0
}

show_help() {
    echo "commands:"
    echo "  !help          - show this menu"
    echo "  !lang <code>   - change language (e.g., !lang en, !lang cs)"
    echo "  !monitor       - toggle monitoring: also play to default sink"
    echo "  !exit          - close the program"
}

trap cleanup SIGINT SIGTERM

if ! pactl list modules short | grep -q "$SINK_ID"; then
    echo "loading virtual mic: $SOURCE_DESC"

    # null sink
    pactl load-module module-null-sink \
        sink_name=$SINK_ID \
        sink_properties=\'device.description=\"$SINK_DESC\"\' > /dev/null

    # virtual mic
    pactl load-module module-remap-source \
        master=$SINK_ID.monitor \
        source_name=$SOURCE_ID \
        source_properties=\'device.description=\"$SOURCE_DESC\"\' > /dev/null
else
    echo "virtual mic already loaded!"
fi

echo "for help, type '!help'"

while true; do
    read -e -p "($CURRENT_LANG) input: " INPUT
    
    # skip empty
    if [[ -z "$INPUT" ]]; then
        continue
    fi

    history -s "$INPUT"

    if [[ "$INPUT" == "!exit" ]]; then
        cleanup
    fi

    if [[ "$INPUT" == "!help" ]]; then
        show_help
        continue
    fi

    if [[ "$INPUT" =~ ^!lang[[:space:]](.+) ]]; then
        CURRENT_LANG="${BASH_REMATCH[1]}"
        echo "language changed to: $CURRENT_LANG"
        continue
    fi

    if [[ "$INPUT" == "!monitor" ]]; then
        DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')
        if [ "$MONITOR" = false ]; then
            LOOPBACK_ID=$(pactl load-module module-loopback \
                source=$SINK_ID.monitor \
                sink=$DEFAULT_SINK)
            MONITOR=true
            echo "monitoring enabled"
        else
            pactl unload-module "$LOOPBACK_ID"
            LOOPBACK_ID=""
            MONITOR=false
            echo "monitoring disabled"
        fi
        continue
    fi

    espeak-ng -v "$CURRENT_LANG" -s 150 --stdout "$INPUT" | pw-play --target "$SINK_ID" -
done
