#!/bin/bash -eu

# Compiles resources/assets/Assets.car (the macOS 26 app icon) from
# resources/assets/AppIcon.icon, with the fallback bitmaps for older macOS
# from resources/assets/Assets.xcassets. Run it on a Mac with Xcode 26; the
# flags follow Chromium's tools/mac/icons/compile_car.py. GitHub's macOS
# runners can't do this: actool there fails to read any .icon package,
# Helium's own included.

_resources="$(dirname "$(dirname "$(greadlink -f "${BASH_SOURCE[0]}")")")/resources"

_tmp="$(mktemp -d)"
trap 'rm -rf "$_tmp"' EXIT

cp -R "$_resources/assets/Assets.xcassets" "$_resources/assets/AppIcon.icon" "$_tmp/"
mkdir "$_tmp/out"

xcrun actool \
  --output-format=xml1 --notices --warnings --errors \
  --platform=macosx --target-device=mac \
  --lightweight-asset-runtime-mode=enabled \
  --enable-icon-stack-fallback-generation=disabled \
  --include-all-app-icons \
  --app-icon=AppIcon \
  --minimum-deployment-target=13.0 \
  --output-partial-info-plist="$_tmp/partial.plist" \
  --compile="$_tmp/out" \
  "$_tmp/Assets.xcassets" "$_tmp/AppIcon.icon"

xcrun assetutil --info "$_tmp/out/Assets.car" | grep -q '"AppIcon"'
cp "$_tmp/out/Assets.car" "$_resources/assets/Assets.car"
echo "Updated $_resources/assets/Assets.car"
