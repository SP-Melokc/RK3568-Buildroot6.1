#!/bin/bash
# www.opendev.com
# dengzhimao@alientek.com

video_device="$1"

resolution=$(v4l2-ctl --get-fmt-video -d "$video_device" 2>/dev/null | grep -E "Width/Height\s*:\s*[0-9]+/[0-9]+" | awk '{print $3}')

width=$(echo "$resolution" | cut -d'/' -f1)
height=$(echo "$resolution" | cut -d'/' -f2)

if [[ "$width" -eq 800 && "$height" -eq 600 ]]; then
    exit 1
else
    exit 0
fi
