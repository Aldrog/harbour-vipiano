# ViPiano
A virtual MIDI piano keyboard built on top of FluidSynth for Sailfish OS.

## Building
Since this project is using CMake, building from QtCreator won't work. Instead, packages are built manually by logging into MerSDK VM and running `mb2 -t <target> build`. For more information refer to tutorial in Sailfish SDK [manual](https://sailfishos.org/wiki/Tutorial_-_Building_packages_manually).

## License
ViPiano is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

FluidSynth can be distributed under the terms of the GNU Lesser General Public License, either version 2.1 of the License, or (at your option) any later version.

FluidR3 sound font bundled with ViPiano can be distributed under the terms of MIT License.
