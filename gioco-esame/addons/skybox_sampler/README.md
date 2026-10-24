# Skybox Sampler - 6 free skies for Godot 4

Six complete, seamless skyboxes as ready-to-use Godot 4 resources: three space skies (Teal & Magenta Nebula,
Ringed Gas Giant, Supernova Remnant) and three outdoor skies (Golden Hour, Thunderstorm, Moonlit Night).
Each sky is a 2048 x 1024 equirectangular panorama with a PanoramaSkyMaterial and an Environment that uses it
for the background, ambient light and reflections. No seams, no pinching at the poles.

## Install

Copy `addons/skybox_sampler/` into your project's `addons/` folder (or install from the Asset Store). It is a
plain asset pack: there is no plugin to enable.

## Use

* Add a `WorldEnvironment` node and set its Environment to one of
  `res://addons/skybox_sampler/environments/<sky>.tres`.
* Or build your own Environment: set Background to Sky and use `res://addons/skybox_sampler/skies/<sky>.tres`
  as the Sky material.
* Demo: open `res://addons/skybox_sampler/demo/demo.tscn` and run it. The camera rotates slowly; press Left/Right
  (or A/D) to cycle through the six skies.

Tested in Godot 4.5 (Forward+, Mobile and Compatibility renderers). Resources use the format=3 text format, so
Godot 4.0 and later can load them.

## The skies

| File | Name | From |
|------|------|------|
| `01_teal_magenta_nebula` | Teal & Magenta Nebula | Space Skyboxes: 20 Stylized Skies |
| `09_ringed_gas_giant` | Ringed Gas Giant | Space Skyboxes: 20 Stylized Skies |
| `14_supernova_remnant` | Supernova Remnant | Space Skyboxes: 20 Stylized Skies |
| `02_golden_hour` | Golden Hour | Stylized Sky Skyboxes: 16 Day, Sunset, Night and Storm Skies |
| `08_thunderstorm` | Thunderstorm | Stylized Sky Skyboxes: 16 Day, Sunset, Night and Storm Skies |
| `12_moonlit_night` | Moonlit Night | Stylized Sky Skyboxes: 16 Day, Sunset, Night and Storm Skies |

## More skies

These six are the free samplers of three paid packs by the same publisher on itch.io, which add the remaining
skies at 4096 x 2048 with 1024 px cube faces and Unity-ready cubemaps:

* Space Skyboxes: 20 Stylized Skies - https://the-knightshift.itch.io/space-skyboxes
* Stylized Sky Skyboxes: 16 Day, Sunset, Night and Storm Skies - https://the-knightshift.itch.io/stylized-skyboxes
* Alien Worlds Skyboxes: 16 Exoplanet Skies - https://the-knightshift.itch.io/alien-skyboxes

## License

Free for commercial and non-commercial use, no attribution required; not for resale or redistribution as assets.
Full text in LICENSE.md.

## AI disclosure

Made with AI assistance: the skies are painted by procedural code that an AI wrote, then checked by eye and by
numeric seam checks. No AI image generator was used; every pixel comes from the code.
