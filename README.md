# android_vendor_yugen — Project Yugen vendor layer 幽玄

Syncs to `vendor/yugen`. This is the whole of Yugen that is not AOSP: product
identity, version scheme, and the framework colour defaults.

```make
# how a device tree reaches this file
$(call inherit-product, vendor/yugen/config/common.mk)
```

LineageOS device trees reach it indirectly — they inherit
`vendor/lineage/config/common_full_phone.mk`, which is the compatibility shim
in `android_vendor_yugen_compat`.

## Layout

```
config/version.mk    the only place version numbers live
config/common.mk     brand, ro.yugen.* and ro.lineage.* compatibility props
config/theme.mk      wires the overlay in; no RRO package yet
overlay/common/      build-time framework overlay (dynamic-colour defaults)
tools/gen-palette.py regenerates the overlay from the seed palette
```

## Palette

Defaults are applied at build time, so the device is sumi-and-shu from first
boot. Wallpaper-based dynamic colour still overrides them at runtime if the
user turns it on; the overlay is a default, not a lock.

| Name | Hex | Role |
|---|---|---|
| sumi 墨 | `#1C1B1A` | neutral1 — ink |
| warm grey | `#6B6259` | neutral2 |
| shu 朱 | `#C8442B` | accent1 — vermillion |
| kintsugi 金継ぎ | `#B08C4F` | accent3 — gold |
| ai 藍 | `#2E4A62` | reserved |
| matcha 抹茶 | `#6B7F5C` | reserved |
| sakura 桜 | `#E7B7B0` | reserved |

Change a seed in `tools/gen-palette.py`, run it, commit both the script and the
generated XML. Do not edit individual tones.

```bash
./tools/gen-palette.py
```

## What is deliberately absent

- No apps, no prebuilts, no blobs. Those belong to the device tree or GApps.
- No boot animation, fonts, or wallpapers yet. They arrive with the theme
  milestone and are licensed individually.
- No feature toggles. Anything that breaks the minimal promise ships off.

Licensed Apache-2.0. Upstream notices remain with their files.
