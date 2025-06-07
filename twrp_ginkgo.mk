#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Only the below variable(s) need to be changed!
#

# The below variables will be generated automatically
#
# Release name (automatically taken from this file's suffix)
PRODUCT_RELEASE_NAME := ginkgo

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := ginkgo
PRODUCT_NAME := twrp_ginkgo
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Xiaomi Redmi Note 8
PRODUCT_MANUFACTURER := Xiaomi

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/xiaomi/ginkgo/device.mk)
