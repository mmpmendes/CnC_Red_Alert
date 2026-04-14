# CnC Red Alert Linux Port Plan

## Development Environment Requirements

To begin porting, set up a Linux development environment with the following tools and libraries:

- **Operating System:**
  - Ubuntu 20.04+ (or any modern Linux distribution)
- **Build Tools:**
  - GCC (g++) or Clang
  - GNU Make or CMake (recommended)
  - NASM or GNU Assembler (for porting assembly)
  - Git
- **Libraries:**
  - SDL2 (development headers)
  - OpenGL (Mesa or proprietary drivers, with dev headers)
  - ALSA (libasound2-dev) and/or PulseAudio (libpulse-dev)
- **Debugging/Testing:**
  - GDB
  - Valgrind
  - SDL2 test utilities
- **Optional:**
  - Visual Studio Code, CLion, or other C/C++ IDE
  - Doxygen (for documentation)

Install dependencies using your package manager, e.g.:
```sh
sudo apt-get install build-essential cmake git libsdl2-dev libgl1-mesa-dev libasound2-dev libpulse-dev gdb valgrind nasm
```

## Overview
This plan details the steps required to build and run CnC Red Alert on Linux, replacing Windows-specific dependencies with cross-platform alternatives (SDL2/OpenGL/ALSA). The goal is a fully functional port with graphics, audio, and input support.

## Detailed Steps and File Mapping

### 1. Analyze Windows-Specific Dependencies
- Catalog all files using Win32, DirectX, GDI, TASM, Watcom, or HMI SOS APIs.
- **Key files:**
  - Audio: `WIN32LIB/AUDIO/` (SOUNDIO.CPP, SOUND.H, SOSCODEC.ASM, etc.)
  - Graphics: `WIN32LIB/DRAWBUFF/`, `WWFLAT32/VIDEO/`, `WWFLAT32/SHAPE/`
  - Input: `WIN32LIB/KEYBOARD/`, `WWFLAT32/KEYBOARD/`
  - Assembly: All `.ASM` files in `WIN32LIB/`, `WWFLAT32/`, `CODE/`, etc.
  - Build: All `MAKEFILE*`, `.MAK`, `.BAT` scripts
- Identify all Windows API calls and platform-specific code for replacement.
- **Subtasks:**
  - List all Windows API usages and dependencies in a spreadsheet or markdown table.
  - Mark each for replacement, removal, or porting.

### 2. Replace Graphics Subsystem
- Refactor graphics code to use SDL2/OpenGL:
  - Replace GDI/DirectX calls in `DRAWBUFF/`, `WWFLAT32/VIDEO/`, `WWFLAT32/SHAPE/`
  - **Key files:** `BUFFER.CPP`, `GBUFFER.CPP`, `DRAWRECT.CPP`, `VIDEO.CPP`, `VIDEO.H`, `BITBLIT.ASM`, `PUTPIX.ASM`, `DRAWLINE.ASM`, etc.
- **Subtasks:**
  - Map each Windows graphics API call to SDL2/OpenGL equivalent.
  - Create SDL2 window/context initialization code.
  - Refactor blitting, drawing, and buffer management to use SDL2 surfaces/textures.
  - Replace palette and color management with SDL2/OpenGL methods.
  - Test rendering output for correctness.

### 3. Replace Audio Subsystem
- Replace DirectSound/HMI SOS with SDL2/ALSA/PulseAudio:
  - Refactor `SOUNDIO.CPP`, `SOUND.H`, `SOSCODEC.ASM`, `AUDUNCMP.ASM`, `OLSOSDEC.ASM`, `SOUNDINT.CPP`, `SOUNDLCK.CPP`, etc.
  - Remove or replace HMI SOS dependencies (`SOS*.H`, `SOS*.ASM`)
- **Subtasks:**
  - Map each Windows audio API call to SDL2/ALSA equivalent.
  - Implement SDL2 audio device initialization and callback.
  - Port or rewrite audio mixing and playback routines.
  - Replace or stub out HMI SOS codec/decoder logic.
  - Test sound playback and mixing.

### 4. Replace Input Handling
- Refactor input code to use SDL2 input APIs:
  - Replace Windows input in `KEYBOARD/KEYBOARD.CPP`, `KEYBOARD.H`, `MOUSE.CPP`, `MOUSE.H`, `WWFLAT32/KEYBOARD/KEYBOARD.ASM`, `MOUSE.ASM`
- **Subtasks:**
  - Map Windows input event handling to SDL2 event loop.
  - Refactor keyboard and mouse state management.
  - Ensure all in-game controls are mapped and functional.
  - Test input responsiveness and edge cases.

### 5. Port or Replace Assembly Code
- Identify all `.ASM` files in `WIN32LIB/`, `WWFLAT32/`, `CODE/`, etc.
- **Subtasks:**
  - List all assembly routines and their purpose.
  - Port performance-critical routines to C/C++ or GNU assembler.
  - Replace or stub non-portable or unnecessary assembly.
  - Validate correctness and performance of replacements.

### 6. Update Build System
- Write CMakeLists.txt or GNU Makefiles for Linux.
- Remove/adapt Watcom/Borland makefiles and batch scripts.
- **Subtasks:**
  - List all source files and dependencies.
  - Write CMake or Makefile rules for each module.
  - Add checks for SDL2, OpenGL, ALSA, and other dependencies.
  - Test build on clean Linux environment.

### 7. Remove or Stub Unused Windows Code
- Remove or stub code that cannot be ported or is not needed for Linux.
- **Subtasks:**
  - Identify all Windows-only code paths and files.
  - Remove or #ifdef-out Windows-specific logic.
  - Ensure codebase compiles without Windows headers/libraries.

### 8. Test and Debug Linux Port
- Build and run the game on Linux.
- **Subtasks:**
  - Test graphics, audio, and input in-game.
  - Use debugging tools (gdb, valgrind, SDL2 test utilities).
  - Fix platform-specific bugs and performance issues.

### 9. Document Linux Build and Run
- Write clear documentation for building and running the game on Linux.
- **Subtasks:**
  - List all required dependencies and installation steps.
  - Document build commands and environment setup.
  - Add troubleshooting and FAQ section.

---

This plan maps each porting step to specific files and modules, enabling parallel work on graphics, audio, input, assembly, and build system tasks. Update this plan as porting progresses and new challenges are discovered.
