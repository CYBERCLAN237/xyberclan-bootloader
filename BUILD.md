# Build Instructions for .deb Package

## Prerequisites
```bash
sudo apt-get install dpkg-dev
```

## Building the Package

1. From the project root directory:
```bash
dpkg-deb --build debian xyberclan-bootloader_1.0.0_all.deb
```

2. The .deb file will be created in the current directory

## Testing the Package

```bash
# Install
sudo dpkg -i xyberclan-bootloader_1.0.0_all.deb

# Run installer
sudo xyberclan-bootloader-install

# Remove if needed
sudo apt-get remove xyberclan-bootloader
```

## Package Contents

- `/usr/share/xyberclan-bootloader/` - Main installation directory
  - `scripts/` - Installation and animation scripts
  - `assets/` - ASCII art and resources
  - `docs/` - Documentation
- `/usr/bin/xyberclan-bootloader-install` - Wrapper command
- `/usr/share/doc/xyberclan-bootloader/` - README and LICENSE

## Version Updates

To release a new version:
1. Update version in `debian/DEBIAN/control`
2. Rebuild the package with new version number
3. Create a GitHub release and attach the .deb file
