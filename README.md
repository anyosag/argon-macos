# argon-macos
macOS packaging & development tooling for
[Argon](https://github.com/anyosag/Argon), a fork of the
[Helium Browser](https://github.com/imputnet/helium).

## Building and development
[> See docs/building.md](docs/building.md)

Argon builds without Helium's signing secrets are ad-hoc signed and not
notarized, so macOS blocks the first launch: open Argon with right-click
→ Open, or run `xattr -dr com.apple.quarantine /Applications/Argon.app`.
They also have no built-in updater, which needs a Sparkle signing key.

## Icons
`resources/assets/AppIcon.icon` (Icon Composer) is the source of the app
icon. `Assets.car` and `resources/dmg_dsstore` can only be built on macOS;
the `Regenerate macOS icon and DMG assets` workflow rebuilds and commits
them whenever their sources change.

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
