# Spotify-Connect-muOS-Application

This application enables devices running muOS to play music from Spotify through Spotify Connect. It is built on top of [librespot](https://github.com/librespot-org/librespot), a Rust implementation of the Spotify client. This repository includes a compiled version of librespot for the `aarch64` architecture, making it compatible with the RG35XX line of devices.

## Features

- **Spotify Connect**: Stream music from your Spotify account directly to your muOS device.

## Installation

### Prerequisites

- A device with muOS.
- A Spotify Premium account.

### Steps

1. **Download the Latest Release**: Download the latest release of muOS from the [Releases](https://github.com/yourusername/muOS/releases) page.

2. **Transfer to Device**: Transfer the downloaded files to your `Archive` directory on your device.

3. **Install with Archive Manager**: Open `Archive Manager` on your device and install the file you downloaded.

4. **Run the Application**: Go to the `Applications` menu on your device and run the app to toggle whether your device is used as a Spotify Connect endpoint.*

5. **Play Music**: You should now see your device - "muOS Device - xxxxxx" — in your Spotify Connect menu, ready to play music!

**You can tell if the app is running by launching Spotify on another device and checking if your muOS device appears as an option to play music.*

## Credits

muOS is based on the [librespot](https://github.com/librespot-org/librespot) project. All credit for the core functionality goes to the librespot contributors. This project packages librespot as a precompiled binary for the `aarch64` architecture to make it work on muOS, and adds a simple way to use it.

## License

This project is licensed under the same license as librespot. Please see their [LICENSE](https://github.com/librespot-org/librespot/blob/master/LICENSE) file for details.

## Disclaimer from librespot

"Using this code to connect to Spotify's API is probably forbidden by them. Use at your own risk."
