# Development Environment Setup Guide

This document explains how to use the `setup-dev-env.sh` script to prepare your Linux system for porting and developing Command & Conquer Red Alert.

## What the Script Does
- Detects your Linux distribution (Ubuntu/Debian, Fedora, Arch, CachyOS, openSUSE)
- Installs all required build tools and libraries (SDL2, OpenGL, ALSA, PulseAudio or PipeWire, etc.)
- Handles distro-specific package names and installation commands
- On Arch/CachyOS, checks for `pipewire-pulse` and avoids conflicts with `pulseaudio`

## Usage
1. Open a terminal in the project root directory.
2. Make the script executable:
   ```sh
   chmod +x setup-dev-env.sh
   ```
3. Run the script:
   ```sh
   ./setup-dev-env.sh
   ```
4. Follow any on-screen instructions. If your distro is not recognized, install the listed packages manually.

## Notes
- You may need `sudo` privileges to install packages.
- The script is safe to run multiple times.
- For unsupported distros, refer to the package list in the script and install equivalents manually.

## Troubleshooting
- If you encounter package conflicts (e.g., `pulseaudio` vs `pipewire-pulse`), follow the script's guidance or use your preferred audio backend.
- For further help, consult your distribution's documentation or package manager manual.
