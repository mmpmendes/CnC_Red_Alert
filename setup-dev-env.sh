#!/usr/bin/env bash
# setup-dev-env.sh - Install required tools and libraries for CnC Red Alert Linux port
# Supports: Ubuntu/Debian, Fedora, Arch, openSUSE

set -e

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect Linux distribution. Please install dependencies manually."
    exit 1
fi

echo "Detected distribution: $DISTRO"

case "$DISTRO" in
    ubuntu|debian)
        sudo apt-get update
        sudo apt-get install -y build-essential cmake git libsdl2-dev libgl1-mesa-dev libasound2-dev libpulse-dev gdb valgrind nasm
        ;;
    fedora)
        sudo dnf install -y @development-tools cmake git SDL2-devel mesa-libGL-devel alsa-lib-devel pulseaudio-libs-devel gdb valgrind nasm
        ;;
    arch|cachyos)
        echo "Note: On Arch/CachyOS, 'pulseaudio' and 'pipewire-pulse' conflict. If you use PipeWire, you can skip installing 'pulseaudio'."
        sudo pacman -Sy --noconfirm base-devel cmake git sdl2 mesa alsa-lib gdb valgrind nasm
        if ! pacman -Q pipewire-pulse &>/dev/null; then
            sudo pacman -Sy --noconfirm pulseaudio
        else
            echo "pipewire-pulse detected, skipping pulseaudio installation."
        fi
        ;;
    opensuse*|suse)
        sudo zypper install -y -t pattern devel_C_C++
        sudo zypper install -y cmake git libSDL2-devel Mesa-libGL-devel alsa-devel libpulse-devel gdb valgrind nasm
        ;;
    *)
        echo "Unsupported or unrecognized distribution: $DISTRO"
        echo "Please install the following packages manually:"
        echo "build-essential/cmake/git/libsdl2-dev/libgl1-mesa-dev/libasound2-dev/libpulse-dev/gdb/valgrind/nasm"
        exit 1
        ;;
esac

echo "Development environment setup complete!"