# ArcadeLinux-Core

> Core components for **Arcade Linux** — an Arch-based distro with a macOS-inspired aesthetic, built for low-end hardware (2GB RAM minimum).

---

## Projects

| Project | Description |
|---|---|
| `calamares-core` | Custom Calamares GUI installer with Arcade Linux branding |

---


## Credits & Attribution

- Calamares configuration forked from [ArchCraft](https://github.com/archcraft-os/core-packages) by [adi1090x](https://github.com/adi1090x), licensed under [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html)
- Built on [Calamares](https://calamares.io) — the universal installer framework

<div align="center">

<img src="./calamares-core/screeshotshots/arcade_welcome.png" alt="Welcome" width="550"/>
<p><em>Welcome</em></p>



</div>

---

## Requirements

```bash
sudo pacman -S calamares kpmcore partitionmanager qt5-base qt5-svg qt5-xmlpatterns
```

---

## How to Build

```bash
cd calamares-core

# Build the package
makepkg -sf

# Output: calamares-3.4.2-2-x86_64.pkg.tar.zst
```

---

## How to Test Locally (without ISO)

```bash
cd calamares-core

# Build and install
makepkg -si

# Copy branding to system
sudo cp -r branding/arcade /usr/share/calamares/branding/
sudo cp settings.conf /usr/share/calamares/settings.conf
sudo cp modules/* /etc/calamares/modules/

# Launch in debug mode
sudo calamares -d
```

> **Note:** "No partitions" and "not enough disk space" warnings are normal on desktop. They disappear when running from the live ISO with a real disk.

---

## How to Sync to Arcade-OS ISO

After making changes, run this to sync everything:

```bash
# Sync branding
cp -r calamares-core/branding/arcade \
  ../Arcade-OS/Profile/airootfs/usr/share/calamares/branding/

# Sync settings
cp calamares-core/settings.conf \
  ../Arcade-OS/Profile/airootfs/etc/calamares/

# Sync modules
cp calamares-core/modules/* \
  ../Arcade-OS/Profile/airootfs/etc/calamares/modules/

# Update local-repo
cp calamares-core/calamares-3.4.2-2-x86_64.pkg.tar.zst \
  ../Arcade-OS/local-repo/

cd ../Arcade-OS/local-repo
repo-add -R arcade-local.db.tar.gz calamares-3.4.2-2-x86_64.pkg.tar.zst
```

Then rebuild the ISO:

```bash
cd ../Arcade-OS/Profile
sudo rm -rf work/
sudo mkarchiso -v -w work/ -o out/ .
```

---

## How to Customize Branding

**Colors** — edit `calamares-core/branding/arcade/branding.desc`:
```yaml
style:
   sidebarBackground:    "#1A1A1A"
   sidebarText:          "#FFFFFF"
   sidebarTextSelect:    "#00FF00"
   sidebarTextHighlight: "#00CC00"
```

**Logo** — replace `branding/arcade/logo.png` — `256x256px`, transparent PNG.

**Welcome image** — replace `branding/arcade/welcome.png` — `600x250px`.

**Slideshow** — add images to `branding/arcade/slides/` as `1.png`, `2.png`, etc.

**Stylesheet** — edit `branding/arcade/stylesheet.qss` for buttons, fonts, layout.

---

## Install Sequence

```
Welcome → Location → Keyboard → Partition → Users → Summary → Install → Finish
```

---

## Known Issues

- Animated GIF not supported in Calamares welcome page — use static PNG
- `bootloader-config` module does not exist in Calamares 3.4.2 — do not add to sequence
- "No partitions" error is expected when testing on desktop without a virtual disk

---

## License

GPL-3.0 — Made with ❤️ by [@thakurabhinav22](https://github.com/thakurabhinav22)