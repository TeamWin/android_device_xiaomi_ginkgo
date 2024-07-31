#!/system/bin/sh
# Determine the filesystem of a block device

FBE=$(getprop ro.crypto.dm_default_key.options_format.version)

# Check if EROFS filesystem is present
dd if=/dev/block/by-name/system bs=256k count=1 | strings | grep -q -E "ginkgo_erofs_dynapart"
ISEROFS=$?

# Dynamic partitions
if dd if=/dev/block/by-name/system bs=256k count=1 | strings | grep -q -E "ginkgo_dynapart|qti_dynamic_partitions|ginkgo_erofs_dynapart"; then
    if [ "$ISEROFS" -eq 0 ]; then
        cat /system/etc/recovery.fstab.erofs >> /system/etc/recovery.fstab
    else
        cat /system/etc/recovery.fstab.ext4 >> /system/etc/recovery.fstab
    fi

    if [ "$FBE" = "2" ]; then
        cat /system/etc/recovery.fstab.fbev2 >> /system/etc/recovery.fstab
    fi

    for p in system vendor; do
        echo "/super_${p} emmc /dev/block/bootdevice/by-name/${p} flags=display=\"Super_${p}\";backup=1" >> /system/etc/twrp.flags
    done
else
    # Non-dynamic partitions
    cat /system/etc/twrp.flags.nondynpart >> /system/etc/twrp.flags
    cat /system/etc/recovery.fstab.fbev1 >> /system/etc/recovery.fstab
fi
