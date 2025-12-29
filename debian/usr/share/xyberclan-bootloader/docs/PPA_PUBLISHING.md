# PPA Publishing Guide for XYBERCLAN

This guide will walk you through publishing the `xyberclan-bootloader` to your Launchpad PPA.

## 1. Install Required Tools
Run this in your terminal:
```bash
sudo apt update
sudo apt install devscripts debhelper dput gpg
```

## 2. Generate your GPG Key
Launchpad requires all uploads to be signed.
1. Run: `gpg --full-generate-key`
2. **Settings**:
   - Kind: `RSA and RSA` (default)
   - Keysize: `4096`
   - Expiration: `0` (never)
   - Real Name: `psycho237-prog` (MUST match `debian/control`)
   - Email: `psychomarlon6@gmail.com` (MUST match `debian/control`)
3. Set a passphrase you will remember.

## 3. Upload Key to Ubuntu Keyserver
Once created, find your Key ID:
```bash
gpg --list-keys --keyid-format SHORT
```
Upload it (replace `YOUR_KEY_ID` with the 8 characters after `rsa4096/`):
```bash
gpg --keyserver hkps://keyserver.ubuntu.com --send-keys YOUR_KEY_ID
```

## 4. Register Key on Launchpad
1. Go to: [https://launchpad.net/~/+editpgpkeys](https://launchpad.net/~/+editpgpkeys)
2. Copy your **Key Fingerprint** (the long string of letters/numbers from `gpg --fingerprint`).
3. Launchpad will send you an encrypted email. Follow the instructions there to verify.

## 5. Prepare the Source Package
In your project directory, run:
```bash
# Clean up previous builds
rm -rf build/
# Create the signed source package (replace YOUR_FINGERPRINT)
debuild -S -sa -kYOUR_FINGERPRINT --no-lintian
```
*Note: Use the full fingerprint, not just the short Key ID.*
*It will ask for your GPG passphrase.*

## 6. Upload to PPA
Once verified by Launchpad, upload the `.changes` file (found in the parent directory):
```bash
# Replace 'your-username' and 'ppa-name' with your Launchpad info
dput ppa:your-username/ppa-name ../xyberclan-bootloader_1.0.0_source.changes
```

## 7. Wait for Build
Launchpad will take 10-20 minutes to build your package. Once it turns green on your PPA page, anyone can install it!
