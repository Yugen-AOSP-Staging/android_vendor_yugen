#
# Project Yugen — build-time resource overlay wiring.
# SPDX-License-Identifier: Apache-2.0
#
# The palette in overlay/common is applied as a classic build-time overlay, so
# framework-res ships with Yugen colours as its defaults and the result works
# before /data exists. Because these are defaults, wallpaper-based dynamic
# colour still wins at runtime when the user enables it.
#
# This is intentionally not an RRO package: an RRO would have to be a
# separately signed APK inside PRODUCT_PACKAGES, and we do not need a
# toggleable theme yet. When the static theme packs land (milestone 2) they
# become RROs and live next to this overlay.
#

ifndef YUGEN_THEME_MK
YUGEN_THEME_MK := true

YUGEN_OVERLAY_DIR := vendor/yugen/overlay/common

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(YUGEN_OVERLAY_DIR)
PRODUCT_PACKAGE_OVERLAYS += $(YUGEN_OVERLAY_DIR)

endif # YUGEN_THEME_MK
