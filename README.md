# argon-macos
macOS packaging & development tooling for
[Argon](https://github.com/anyosag/Argon), a fork of the
[Helium Browser](https://github.com/imputnet/helium).

## Building and development
[> See docs/building.md](docs/building.md)

To build a release on GitHub, run the "Build macOS binaries of Argon"
workflow from the Actions tab. Each finished run has an arm64 and an x86_64
DMG among its artifacts, and ticking "Create a release" also publishes them
as a release.

Argon is built without an Apple Developer ID, so it is ad-hoc signed and not
notarized:

- macOS blocks the first launch. After copying Argon to Applications, run
  `xattr -dr com.apple.quarantine /Applications/Argon.app`, or try to open
  it once and then click Open Anyway in System Settings → Privacy &
  Security. (Since macOS 15, right-click → Open no longer skips this.)
- Each build has a new signature, so macOS may ask for your password the
  first time a new version opens its "Argon Storage Key" Keychain item.
- Passkeys stored in iCloud Keychain need Apple-approved entitlements, which
  only a Developer ID build can carry.
- There's no built-in updater, which needs a Sparkle signing key: install
  each new version by hand.

With a Developer ID, set the `PROD_MACOS_*` secrets listed in
`.github/workflows/build-phase.yml` to sign and notarize instead.

## Icons
`resources/assets/AppIcon.icon` (Icon Composer) is the source of the macOS 26
app icon, and `resources/assets/Assets.xcassets` holds the fallback bitmaps
for older macOS. Both compile into `resources/assets/Assets.car`, which has
to be built on a Mac with Xcode 26: run `devutils/compile_assets_car.sh` and
commit the result. (`actool` on GitHub's macOS runners can't read `.icon`
packages.)

`resources/dmg_dsstore` (the DMG window layout) is rebuilt and committed by
the `Regenerate DMG layout` workflow whenever its sources change.

## Credits

### Helium
This repo is a fork of
[helium-macos](https://github.com/imputnet/helium-macos).

### ungoogled-chromium-macos
helium-macos is based on
[ungoogled-chromium-macos](https://github.com/ungoogled-software/ungoogled-chromium-macos),
but heavily modified for Helium. Special thanks to everyone behind
ungoogled-chromium, they made working with Chromium infinitely easier.

## License
All code, patches, modified portions of imported code or patches, and
any other content that is unique to Helium or Argon and not imported from
other repositories is licensed under GPL-3.0. See [LICENSE](LICENSE).

Any content imported from other projects retains its original license (for
example, any original unmodified code imported from ungoogled-chromium remains
licensed under their [BSD 3-Clause license](LICENSE.ungoogled_chromium)).
