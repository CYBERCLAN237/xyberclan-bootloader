# Troubleshooting Guide

## Common Issues and Solutions

### Issue: Plymouth theme not displaying

**Symptoms:**
- Boot screen shows default theme instead of XYBERCLAN
- No animation visible during boot

**Solutions:**

1. **Verify Plymouth is installed:**
   ```bash
   plymouth --version
   ```

2. **Check if theme is set:**
   ```bash
   sudo plymouth-set-default-theme --list
   # Should show 'xyberclan' in the list
   ```

3. **Set the theme manually:**
   ```bash
   sudo plymouth-set-default-theme xyberclan
   sudo update-initramfs -u
   sudo reboot
   ```

4. **Check theme files exist:**
   ```bash
   ls -la /usr/share/plymouth/themes/xyberclan/
   ```

---

### Issue: GRUB changes not visible

**Symptoms:**
- GRUB menu still shows original distributor name
- No XYBERCLAN branding in GRUB

**Solutions:**

1. **Verify GRUB configuration:**
   ```bash
   cat /etc/default/grub | grep DISTRIBUTOR
   ```

2. **Manually update GRUB:**
   ```bash
   # Debian/Ubuntu
   sudo update-grub
   
   # Fedora/RHEL
   sudo grub2-mkconfig -o /boot/grub2/grub.cfg
   
   # Arch Linux
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

3. **Check GRUB installation:**
   ```bash
   sudo grub-install --version
   ```

---

### Issue: Installation script fails

**Symptoms:**
- Script exits with errors
- Permission denied messages

**Solutions:**

1. **Run with sudo:**
   ```bash
   sudo ./scripts/install.sh
   ```

2. **Make script executable:**
   ```bash
   chmod +x scripts/install.sh
   sudo ./scripts/install.sh
   ```

3. **Check script dependencies:**
   ```bash
   # Ensure bash is available
   bash --version
   ```

---

### Issue: Black screen during boot

**Symptoms:**
- Screen goes black during boot
- System eventually boots but no animation

**Solutions:**

1. **Check kernel parameters:**
   Edit `/etc/default/grub` and ensure:
   ```bash
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
   ```

2. **Verify graphics drivers:**
   ```bash
   lsmod | grep -i video
   ```

3. **Try text mode:**
   Temporarily disable Plymouth:
   ```bash
   sudo systemctl disable plymouth-start.service
   sudo reboot
   ```

---

### Issue: Animation is too fast/slow

**Symptoms:**
- Boot animation plays too quickly or slowly

**Solutions:**

1. **Adjust animation speed:**
   Edit `scripts/boot-animation.sh`:
   ```bash
   # Find the animate_boot function call
   animate_boot 0.4  # Change this value (0.2 = faster, 0.6 = slower)
   ```

2. **For Plymouth, edit the script file:**
   ```bash
   sudo nano /usr/share/plymouth/themes/xyberclan/xyberclan.script
   # Adjust the progress increment value
   ```

---

### Issue: Systemd service not starting

**Symptoms:**
- Boot message doesn't appear
- Service fails to start

**Solutions:**

1. **Check service status:**
   ```bash
   sudo systemctl status xyberclan-boot.service
   ```

2. **View service logs:**
   ```bash
   sudo journalctl -u xyberclan-boot.service
   ```

3. **Manually enable service:**
   ```bash
   sudo systemctl enable xyberclan-boot.service
   sudo systemctl start xyberclan-boot.service
   ```

4. **Check script permissions:**
   ```bash
   ls -la /home/psycho/Documents/org-profile/xyberclan-bootloader/scripts/boot-animation.sh
   chmod +x /home/psycho/Documents/org-profile/xyberclan-bootloader/scripts/boot-animation.sh
   ```

---

### Issue: Uninstallation doesn't restore original theme

**Symptoms:**
- After uninstall, boot screen is broken
- Original theme not restored

**Solutions:**

1. **Check backups:**
   ```bash
   ls -la /var/backups/xyberclan-bootloader/
   ```

2. **Manually restore Plymouth:**
   ```bash
   sudo plymouth-set-default-theme -R
   sudo update-initramfs -u
   ```

3. **Restore GRUB from backup:**
   ```bash
   sudo cp /var/backups/xyberclan-bootloader/grub-* /etc/default/grub
   sudo update-grub
   ```

---

## Getting Help

If you're still experiencing issues:

1. **Check the logs:**
   ```bash
   # System logs
   sudo journalctl -b
   
   # Plymouth logs
   sudo journalctl -u plymouth-start.service
   ```

2. **Create an issue on GitHub:**
   - Go to https://github.com/CYBERCLAN237/xyberclan-bootloader/issues
   - Provide:
     - Your Linux distribution and version
     - Error messages
     - Steps you've already tried

3. **Join the XYBERCLAN community:**
   - Visit: https://xyber-clan.vercel.app/
   - Ask for help from other community members

## Emergency Recovery

If your system won't boot after installation:

1. **Boot into recovery mode:**
   - Hold Shift during boot to access GRUB menu
   - Select "Advanced options" → "Recovery mode"

2. **Remove XYBERCLAN boot loader:**
   ```bash
   sudo /path/to/xyberclan-bootloader/scripts/uninstall.sh
   ```

3. **Rebuild initramfs:**
   ```bash
   sudo update-initramfs -u -k all
   ```

4. **Reboot:**
   ```bash
   sudo reboot
   ```

---

*for open minded*
