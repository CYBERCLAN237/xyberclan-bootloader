# Customization Guide

## Overview

The XYBERCLAN boot loader can be customized to match your preferences. This guide covers various customization options.

## Boot Animation Customization

### Changing Animation Speed

Edit `scripts/boot-animation.sh` and modify the delay parameter:

```bash
# Faster animation (0.2 seconds between frames)
animate_boot 0.2

# Slower animation (0.5 seconds between frames)
animate_boot 0.5
```

### Changing Colors

The animation uses these color variables in `scripts/boot-animation.sh`:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
```

Modify the `display_frame` calls to use different colors:

```bash
display_frame "$FRAME4" "$CYAN"  # Change to cyan
```

### Custom Slogan

To change the slogan from "for open minded" to your own:

1. Edit `scripts/boot-animation.sh`
2. Find the line: `SLOGAN="for open minded"`
3. Change it to your custom text: `SLOGAN="your custom slogan"`

## Plymouth Theme Customization

### Background Color

Edit `config/plymouth/xyberclan.script`:

```javascript
// Change background colors (RGB values 0.0 to 1.0)
Window.SetBackgroundTopColor(0.0, 0.0, 0.2);     // Dark blue
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);  // Black
```

### Text Size and Color

```javascript
// Adjust logo text (red, green, blue, alpha)
logo.image = Image.Text("XYBERCLAN", 0.3, 0.9, 1.0);  // Larger, brighter

// Adjust slogan text
slogan.image = Image.Text("for open minded", 0.5, 0.7, 0.9);
```

### Animation Speed

```javascript
// Change refresh rate (higher = faster)
progress += 0.02;  // Faster animation
progress += 0.005; // Slower animation
```

## GRUB Customization

### Custom Distributor Name

Edit `/etc/default/grub` after installation:

```bash
GRUB_DISTRIBUTOR="XYBERCLAN - your custom text"
```

Then update GRUB:

```bash
sudo update-grub
```

### GRUB Colors

Add to `/etc/default/grub`:

```bash
GRUB_COLOR_NORMAL="cyan/black"
GRUB_COLOR_HIGHLIGHT="white/cyan"
```

## Adding Custom ASCII Art

### Create Your Own Logo

1. Create ASCII art using tools like:
   - [ASCII Art Generator](http://patorjk.com/software/taag/)
   - [Text to ASCII Art Generator](https://www.ascii-art-generator.org/)

2. Save to `assets/xyberclan-logo.txt`

3. Update `scripts/boot-animation.sh` with your new frames

### Using Image-Based Logo

For Plymouth, you can use actual images:

1. Create a PNG image (recommended size: 256x256)
2. Place in `/usr/share/plymouth/themes/xyberclan/`
3. Update `xyberclan.script`:

```javascript
logo.image = Image("logo.png");
logo.sprite = Sprite(logo.image);
```

## Advanced Customization

### Multiple Animation Variants

Create different animation styles by copying `boot-animation.sh`:

```bash
cp scripts/boot-animation.sh scripts/boot-animation-alt.sh
# Edit the alternative version
```

### Conditional Animations

Add logic to show different animations based on conditions:

```bash
# In boot-animation.sh
if [ $(date +%H) -lt 12 ]; then
    # Morning animation
    display_frame "$FRAME_MORNING" "$YELLOW"
else
    # Evening animation
    display_frame "$FRAME_EVENING" "$BLUE"
fi
```

## Applying Changes

After making customizations:

### For Plymouth Changes

```bash
sudo update-initramfs -u  # Debian/Ubuntu
sudo dracut -f            # Fedora/RHEL
sudo reboot
```

### For GRUB Changes

```bash
sudo update-grub
sudo reboot
```

### For Script Changes

No reboot needed if using systemd service - changes apply on next boot.

## Sharing Your Customizations

If you create cool customizations, consider sharing them with the XYBERCLAN community by:

1. Forking the repository
2. Adding your customization
3. Creating a pull request

---

*for open minded*
