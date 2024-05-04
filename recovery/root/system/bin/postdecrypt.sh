#!/sbin/sh

umount "/vendor"
replace_ro_with_rw() {
    local file="$1"
    sed -i 's/\bro\b/rw/g' "$file"
}

# Path to the fstab files
fstab_file="/system/etc/fstab"
recovery_fstab_file="/system/etc/recovery.fstab"

# Modify the vendor mount point in recovery.fstab
vendor_line_recovery=$(grep "/vendor" "$recovery_fstab_file")
if [ -n "$vendor_line_recovery" ]; then
    modified_vendor_line_recovery=$(echo "$vendor_line_recovery" | sed 's/ro/rw/')
    sed -i "s|$vendor_line_recovery|$modified_vendor_line_recovery|" "$recovery_fstab_file"
    echo "Vendor line in $recovery_fstab_file modified successfully." >> /tmp/psd.log
else
    echo "Vendor line not found in $recovery_fstab_file." >> /tmp/psd.log
fi

# Replace "ro" with "rw" in recovery.fstab
replace_ro_with_rw "$recovery_fstab_file" >> /tmp/psd.log


# Modify the vendor mount point in fstab
vendor_line=$(grep "/vendor" "$fstab_file")
if [ -n "$vendor_line" ]; then
    modified_vendor_line=$(echo "$vendor_line" | sed 's/ro/rw/')
    sed -i "s|$vendor_line|$modified_vendor_line|" "$fstab_file"
    echo "Vendor line in $fstab_file modified successfully." >> /tmp/psd.log
else
    echo "Vendor line not found in $fstab_file." >> /tmp/psd.log
fi
mount "/vendor"
echo "Modification completed successfully." >> /tmp/psd.log
