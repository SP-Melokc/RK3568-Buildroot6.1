#!/bin/sh
# board/alientek/atk-dlrk3568/post-build.sh
# buildroot post-build (called with $1 = TARGET_DIR)
set -e
TARGET_DIR="$1"

# 1) bpftool needs libsframe.so.1 -- a binutils-2.43 lib that buildroot's
#    binutils *target-install* step forgets to install.  Without it bpftool
#    dies with: error while loading shared libraries: libsframe.so.1
#    The aarch64 lib is already built; just copy it into the target.
for d in "$BUILD_DIR"/binutils-*/libsframe/.libs; do
	[ -d "$d" ] || continue
	for f in libsframe.so.1.0.0 libsframe.so.1 libsframe.so; do
		if [ -e "$d/$f" ]; then
			cp -a "$d/$f" "$TARGET_DIR/usr/lib/"
		fi
	done
done

# 2) auto-mount tracefs at boot so ftrace / kprobe events are available
mkdir -p "$TARGET_DIR/sys/kernel/tracing"
if ! grep -q 'sys/kernel/tracing' "$TARGET_DIR/etc/fstab" 2>/dev/null; then
	printf 'tracefs\t\t/sys/kernel/tracing\ttracefs\tdefaults\t0 0\n' \
		>> "$TARGET_DIR/etc/fstab"
fi

echo "post-build(atk-dlrk3568): libsframe + tracefs fstab applied"
