# Spotify-Connect-muOS-Application

This an application designed to allow devices that run muOS to play music from Spotify through Spotify Connect. It is built on top of [librespot](https://github.com/librespot-org/librespot), a Rust implementation of the Spotify client. This repository includes a compiled version of librespot for the `aarch64` architecture, making it compatible with the RG35XX line of devices.

## Features

- **Spotify Connect**: Stream music from your Spotify account directly to your muOS device.

## Installation

### Prerequisites

- A device with muOS.
- A Spotify Premium account.

### Steps

1. **Download the Latest Release**: Download the latest release of muOS from the [Releases](https://github.com/yourusername/muOS/releases) page.

2. **Transfer to Device**: Transfer the downloaded files to your ```Archive``` directory on your device.

3. **Install it with Archive Manager**: Go into Archive Manager on your device and install the file you downloaded.

4. **Run the Application**: Go into your Applications menu on your device, and run the app to toggle whether your device is used as a Spotify Connect Endpoint.*

6. **You can now play music!**: You should now see your device - "muOS Device - xxxxxx" in your Spotify Connect menu ready to play from, and now you should be done!

**You can tell if it's on or off by launching Spotify on a different device and seeing if your device comes up as an option to play music from.*

## Credits

muOS is based on the [librespot](https://github.com/librespot-org/librespot) project. All credit for the core functionality goes to the librespot contributors. This project merely packages librespot as a precompiled binary for the `aarch64` architecture to make it work on muOS, and adds a way to use it.

## License

This project is licensed under the same license as librespot. Please see the [LICENSE](https://github.com/librespot-org/librespot/blob/master/LICENSE) file for details.

## Disclaimer from librespot

Using this code to connect to Spotify's API is probably forbidden by them. Use at your own risk.
