#
# Project Yugen — version identity.
# SPDX-License-Identifier: Apache-2.0
#
# Single source of truth. Bump here, never in a script; release tooling reads
# these values by parsing this file.
#

# --- Yugen release train -------------------------------------------------
# Independent of the Android base version on purpose: Yugen 1.0.0 runs on
# Android 17, and a 1.0.1 security respin still runs on Android 17.
YUGEN_VERSION_MAJOR := 1
YUGEN_VERSION_MINOR := 0
YUGEN_VERSION_PATCH := 0
YUGEN_VERSION := $(YUGEN_VERSION_MAJOR).$(YUGEN_VERSION_MINOR).$(YUGEN_VERSION_PATCH)

# Release name. Japanese; short; not translated.
YUGEN_RELEASE_NAME := Tsuki

# --- Platform base -------------------------------------------------------
# The AOSP tag the manifest pins, and the LineageOS branch the hardware layer
# is taken from. These two are deliberately separate: the platform is stock
# AOSP, only the device glue comes from LineageOS.
YUGEN_ANDROID_VERSION := 17
YUGEN_BASE_TAG := android-17.0.0_r1
YUGEN_LINEAGE_BRANCH := lineage-24.0
# Reported as ro.lineage.build.version so Lineage-aware overlays and tooling
# read a version they understand.
YUGEN_LINEAGE_COMPAT_VERSION := 24.0

# --- Build identity ------------------------------------------------------
# RELEASE_TYPE=RELEASE gives an official build; anything else, or nothing,
# is an unofficial one.
ifndef YUGEN_BUILDTYPE
    ifdef RELEASE_TYPE
        YUGEN_BUILDTYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^YUGEN_||g')
    endif
endif
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(YUGEN_BUILDTYPE)),)
    YUGEN_BUILDTYPE := UNOFFICIAL
endif

# Build date, UTC, no time of day so repeated builds of the same commit are
# seen as identical by the updater.
YUGEN_BUILD_DATE := $(shell date -u +%Y%m%d)

# 1.0-20261111-UNOFFICIAL. The zip is renamed to this by release tooling.
YUGEN_DISPLAY_VERSION := $(YUGEN_VERSION)-$(YUGEN_BUILD_DATE)-$(YUGEN_BUILDTYPE)
