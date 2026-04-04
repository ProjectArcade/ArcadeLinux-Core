#! /usr/bin/env bash

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  SCHEMES_DIR="/usr/share/color-schemes"
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  LAYOUT_DIR="/usr/share/plasma/layout-templates"
  LOOKFEEL_DIR="/usr/share/plasma/look-and-feel"
  KVANTUM_DIR="/usr/share/Kvantum"
  WALLPAPER_DIR="/usr/share/wallpapers"
  ICONS_DIR="/usr/share/icons"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  LAYOUT_DIR="$HOME/.local/share/plasma/layout-templates"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  KVANTUM_DIR="$HOME/.config/Kvantum"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
  ICONS_DIR="$HOME/.local/share/icons"
fi

THEME_NAME=Arcade

uninstall() {
  local name=${1}

  # Aurorae window decorations
  [[ -d "${AURORAE_DIR}/${name}" ]] && rm -rfv "${AURORAE_DIR}/${name}"*

  # Plasma desktop theme
  [[ -d "${PLASMA_DIR}/${name}" ]] && rm -rfv "${PLASMA_DIR}/${name}"*

  # Color schemes
  [[ -f "${SCHEMES_DIR}/${name}.colors" ]] && rm -rfv "${SCHEMES_DIR}/${name}"*.colors

  # Look and feel / global theme
  [[ -d "${LOOKFEEL_DIR}/com.github.ProjectArcade.${name}" ]] && rm -rfv "${LOOKFEEL_DIR}/com.github.ProjectArcade.${name}"*

  # Kvantum
  [[ -d "${KVANTUM_DIR}/${name}" ]] && rm -rfv "${KVANTUM_DIR}/${name}"*

  # Wallpapers
  [[ -d "${WALLPAPER_DIR}/${name}" ]] && rm -rfv "${WALLPAPER_DIR}/${name}"*

  # Plasma layout template
  [[ -d "${LAYOUT_DIR}/org.github.desktop.WhiteSurPanel" ]] && rm -rfv "${LAYOUT_DIR}/org.github.desktop.WhiteSurPanel"

  # Arcade-icons
  [[ -d "${ICONS_DIR}/Arcade-icons" ]] && rm -rfv "${ICONS_DIR}/Arcade-icons"

  # Arcade splash
  [[ -d "${LOOKFEEL_DIR}/arcade-splash" ]] && rm -rfv "${LOOKFEEL_DIR}/arcade-splash"
}

echo "Uninstalling '${THEME_NAME} kde themes'..."

uninstall "${THEME_NAME}"

# Reset to default Breeze theme
echo "Resetting to default Breeze theme..."
if command -v plasma-apply-lookandfeel >/dev/null 2>&1; then
  plasma-apply-lookandfeel --apply org.kde.breeze.desktop --resetLayout
else
  lookandfeeltool --apply org.kde.breeze.desktop
fi

# Reset plasma layout
rm -f ~/.config/plasma-org.kde.plasma.desktop-appletsrc
plasmashell --replace &> /dev/null &

echo "Uninstall finished."