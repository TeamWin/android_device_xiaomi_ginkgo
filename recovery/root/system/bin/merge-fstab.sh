#!/system/bin/sh
# Determine the filesystem of a block device

FSTYPE=$(getprop ro.fs_type | tr '[:upper:]' '[:lower:]')
FBE=$(getprop ro.crypto.dm_default_key.options_format.version)

# Dynamic partitions
if dd if=/dev/block/by-name/system bs=256k count=1 | strings | grep -q ginkgo_dynapart; then
    if [ "$FSTYPE" = "erofs" ]; then
        echo >> /system/etc/recovery.fstab
        cat /system/etc/recovery.fstab.erofs >> /system/etc/recovery.fstab
    else
        echo >> /system/etc/recovery.fstab
        cat /system/etc/recovery.fstab.ext4 >> /system/etc/recovery.fstab
    fi

    if [ "$FBE" = "2" ]; then
        echo >> /system/etc/recovery.fstab
        cat /system/etc/recovery.fstab.fbev2 >> /system/etc/recovery.fstab
    fi

    for p in system vendor; do
        echo "/super_${p} emmc /dev/block/bootdevice/by-name/${p} flags=display=\"Super_${p}\";backup=1" >> /system/etc/twrp.flags
    done
else
    # Non-dynamic partitions
    echo >> /system/etc/twrp.flags
    cat /system/etc/twrp.flags.nondynpart >> /system/etc/twrp.flags
    echo >> /system/etc/recovery.fstab
    cat /system/etc/recovery.fstab.fbev1 >> /system/etc/recovery.fstab
fi
