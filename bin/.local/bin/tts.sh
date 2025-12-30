#!/bin/bash

SINK_ID="TTS_Cable"
SOURCE_ID="TTS_Mic_Source"

SINK_DESC="TTS Virtual Cable"
SOURCE_DESC="TTS Mic"

CURRENT_LANG="cs"

cleanup() {
    echo -e "\n\nunloading modules..."

    pactl list modules short | grep "sink_name=$SINK_ID" | awk '{print $1}' | xargs -r pactl unload-module
    pactl list modules short | grep "source_name=$SOURCE_ID" | awk '{print $1}' | xargs -r pactl unload-module

    exit 0
}

show_help() {
    echo "commands:"
    echo "  !help          - Show this menu"
    echo "  !lang <code>   - Change language (e.g., !lang en, !lang cs)"
    echo "  !exit          - Close the program and remove the mic"
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

    espeak-ng -v "$CURRENT_LANG" -s 150 --stdout "$INPUT" | pw-play --target "$SINK_ID" -
done
