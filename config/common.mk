#
# Project Yugen — common product configuration.
# SPDX-License-Identifier: Apache-2.0
#
# Inherited by every Yugen product, either directly or through the
# vendor/lineage compatibility shim (see android_vendor_yugen_compat) that
# unmodified LineageOS device trees call.
#
# Keep this file small. Identity and defaults only; packages belong in the
# product that wants them, and features are off until deliberately added.
#

ifndef YUGEN_COMMON_MK
YUGEN_COMMON_MK := true

YUGEN_PATH := vendor/yugen

include $(YUGEN_PATH)/config/version.mk
include $(YUGEN_PATH)/config/theme.mk

# --- Identity ------------------------------------------------------------
# Brand only. PRODUCT_MODEL and PRODUCT_MANUFACTURER stay owned by the device
# tree: Play certification and hardware attestation key off them.
PRODUCT_BRAND ?= Yugen

# --- Properties ----------------------------------------------------------
# TARGET_PRODUCT is available while product configuration is parsed, and is
# also what a lineage_<device> user actually types at lunch.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.yugen.version=$(YUGEN_VERSION) \
    ro.yugen.display.version=$(YUGEN_DISPLAY_VERSION) \
    ro.yugen.release=$(YUGEN_RELEASE_NAME) \
    ro.yugen.device=$(TARGET_PRODUCT) \
    ro.yugen.base=$(YUGEN_BASE_TAG) \
    ro.yugen.build.date=$(YUGEN_BUILD_DATE)

# LineageOS compatibility properties. Device-tree overlays and Lineage-aware
# apps read these; publishing them keeps those overlays meaningful while
# making it obvious the build is Yugen, not LineageOS.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lineage.version=$(YUGEN_VERSION) \
    ro.lineage.display.version=$(YUGEN_DISPLAY_VERSION) \
    ro.lineage.build.version=$(YUGEN_LINEAGE_COMPAT_VERSION) \
    ro.lineage.releasetype=$(YUGEN_BUILDTYPE) \
    ro.lineage.device=$(TARGET_PRODUCT)

# --- Audio defaults ------------------------------------------------------
# The stock AOSP ringtone/notification/alarm set stays in place; overriding
# these here would silently break the first boot if a sound is renamed.
# Japanese type defaults, wallpaper and boot animation land with the theme
# milestone.

endif # YUGEN_COMMON_MK
