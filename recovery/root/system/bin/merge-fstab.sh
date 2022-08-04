#!/system/bin/sh

# Dynamic Partitions
if dd if=/dev/block/by-name/system bs=256k count=1|strings|grep ginkgo_dynamic_partitions > /dev/null; then
    echo >> /system/etc/recovery.fstab
    for p in system system_ext product vendor odm; do
        echo "${p} /${p} ext4 ro,barrier=1 wait,logical" >> /system/etc/recovery.fstab
    done
    echo >> /system/etc/recovery.fstab
    echo "/dev/block/bootdevice/by-name/metadata /metadata ext4 nosuid,nodev,noatime,discard wait,check,formattable" >> /system/etc/recovery.fstab
    echo >> /system/etc/twrp.flags
    cat /system/etc/twrp.flags.dynamic >> /system/etc/twrp.flags
else
    echo >> /system/etc/recovery.fstab
    echo "/dev/block/bootdevice/by-name/system /system ext4 ro,barrier=1 wait,formattable" >> /system/etc/recovery.fstab
    echo "/dev/block/bootdevice/by-name/vendor /vendor ext4 ro,barrier=1 wait,formattable" >> /system/etc/recovery.fstab
    echo >> /system/etc/twrp.flags
    cat /system/etc/twrp.flags.nondynamic >> /system/etc/twrp.flags
fi
