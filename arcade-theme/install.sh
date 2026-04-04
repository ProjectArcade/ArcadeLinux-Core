#! /usr/bin/env bash

ROOT_UID=0
CORE_REPO="https://github.com/ProjectArcade/ArcadeLinux-Core"

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

SRC_DIR=$(cd $(dirname $0) && pwd)
THEME_NAME=Arcade

COLOR_VARIANTS=('' '-dark')
PCOLOR_VARIANTS=('' '-alt' '-dark')
WINDOW_VARIANTS=('' '-opaque' '-sharp')
SCALE_VARIANTS=('' '_x1.25' '_x1.5' '_x1.75' '_x2.0')

usage() {
  cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -n, --name NAME         Specify theme name (Default: $THEME_NAME)
  -c, --color VARIANT     Specify color variant(s) [light|alt|dark] (Default: All variants)
  -w, --window VARIANT    Specify window variant(s) [default|opaque|sharp] (Default: round blur version)
  -h, --help              Show help
EOF
}

[[ ! -d "${AURORAE_DIR}" ]] && mkdir -p "${AURORAE_DIR}"
[[ ! -d "${SCHEMES_DIR}" ]] && mkdir -p "${SCHEMES_DIR}"
[[ ! -d "${PLASMA_DIR}" ]] && mkdir -p "${PLASMA_DIR}"
[[ ! -d "${LAYOUT_DIR}" ]] && mkdir -p "${LAYOUT_DIR}"
[[ ! -d "${LOOKFEEL_DIR}" ]] && mkdir -p "${LOOKFEEL_DIR}"
[[ ! -d "${KVANTUM_DIR}" ]] && mkdir -p "${KVANTUM_DIR}"
[[ ! -d "${WALLPAPER_DIR}" ]] && mkdir -p "${WALLPAPER_DIR}"
[[ ! -d "${ICONS_DIR}" ]] && mkdir -p "${ICONS_DIR}"

install_sf_fonts() {
  if ! fc-list | grep -qi "SF Pro"; then
    echo "SF Pro font not found, installing..."
    if command -v yay >/dev/null 2>&1; then
      yay -S --noconfirm apple-fonts 2>/dev/null || true
    elif command -v paru >/dev/null 2>&1; then
      paru -S --noconfirm apple-fonts 2>/dev/null || true
    else
      echo "No AUR helper found. Install manually: yay -S apple-fonts"
    fi
    fc-cache -f
    echo "SF Pro font installed."
  else
    echo "SF Pro font already installed, skipping."
  fi
}

install_arcade_icons() {
  if [[ ! -d "${ICONS_DIR}/Arcade-icons" ]]; then
    echo "Arcade-icons not found, downloading from ArcadeLinux-Core..."
    git clone --depth=1 "${CORE_REPO}" /tmp/ArcadeLinux-Core-tmp
    cp -r /tmp/ArcadeLinux-Core-tmp/Arcade-icons-theme/Arcade-icons "${ICONS_DIR}/"
    rm -rf /tmp/ArcadeLinux-Core-tmp
    echo "Arcade-icons installed."
  else
    echo "Arcade-icons already installed, skipping."
  fi
  # Fix missing trash icon names
  local ICON_PLACES="${ICONS_DIR}/Arcade-icons/places/scalable"
  [[ -f "${ICON_PLACES}/user-trash.svg" ]] && cp "${ICON_PLACES}/user-trash.svg" "${ICON_PLACES}/trash.svg"
  [[ -f "${ICON_PLACES}/user-trash.svg" ]] && cp "${ICON_PLACES}/user-trash.svg" "${ICON_PLACES}/trashcan.svg"
  [[ -f "${ICON_PLACES}/user-trash-full.svg" ]] && cp "${ICON_PLACES}/user-trash-full.svg" "${ICON_PLACES}/trashcan-full.svg"
  gtk-update-icon-cache "${ICONS_DIR}/Arcade-icons/" 2>/dev/null || true
}

install_arcade_splash() {
  if [[ ! -d "${LOOKFEEL_DIR}/arcade-splash" ]]; then
    echo "arcade-splash not found, downloading from ArcadeLinux-Core..."
    git clone --depth=1 "${CORE_REPO}" /tmp/ArcadeLinux-Core-tmp2
    mkdir -p "${LOOKFEEL_DIR}"
    cp -r /tmp/ArcadeLinux-Core-tmp2/arcade-splash "${LOOKFEEL_DIR}/"
    rm -rf /tmp/ArcadeLinux-Core-tmp2
    echo "arcade-splash installed."
  else
    echo "arcade-splash already installed, skipping."
  fi
}

install() {
  local name="${1}"
  local color="${2}"

  [[ -d "${KVANTUM_DIR}/${name}" ]] && rm -rf "${KVANTUM_DIR}/${name}"
  [[ -d "${WALLPAPER_DIR}/${name}" ]] && rm -rf "${WALLPAPER_DIR}/${name}"*
  [[ -d "${LAYOUT_DIR}/org.github.desktop.WhiteSurPanel" ]] && rm -rf "${LAYOUT_DIR}/org.github.desktop.WhiteSurPanel"

  cp -r "${SRC_DIR}/Kvantum/${name}"                                                   "${KVANTUM_DIR}"

  if [[ "${opaque}" == "true" ]]; then
    cp -r "${SRC_DIR}/Kvantum/${name}-opaque"                                          "${KVANTUM_DIR}"
  fi

  cp -r "${SRC_DIR}/wallpaper/${name}"*                                                "${WALLPAPER_DIR}"
  cp -r "${SRC_DIR}/plasma/layout-templates/org.github.desktop.WhiteSurPanel"          "${LAYOUT_DIR}"
}

install_plasma() {
  local name="${1}"
  local pcolor="${2}"

  [[ "${pcolor}" == '-dark' ]] && local ELSE_COLOR='Dark'
  [[ "${pcolor}" == '-light' ]] && local ELSE_COLOR='Light'
  [[ "${pcolor}" == '-alt' ]] && local ELSE_COLOR='Alt'

  [[ -d "${PLASMA_DIR}/${name}${pcolor}" ]] && rm -rf "${PLASMA_DIR}/${name}${pcolor}"
  [[ -f "${SCHEMES_DIR}/${name}${ELSE_COLOR}.colors" ]] && rm -rf "${SCHEMES_DIR}/${name}${ELSE_COLOR}.colors"
  [[ -d "${LOOKFEEL_DIR}/com.github.ProjectArcade.${name}${pcolor}" ]] && rm -rf "${LOOKFEEL_DIR}/com.github.ProjectArcade.${name}${pcolor}"

  cp -r "${SRC_DIR}/color-schemes/"*                                                   "${SCHEMES_DIR}"
  cp -r "${SRC_DIR}/plasma/desktoptheme/${name}${pcolor}"                              "${PLASMA_DIR}"
  cp -r "${SRC_DIR}/plasma/desktoptheme/"{icons,weather}                               "${PLASMA_DIR}/${name}${pcolor}"
  cp -r "${SRC_DIR}/plasma/look-and-feel/com.github.ProjectArcade.${name}${pcolor}"   "${LOOKFEEL_DIR}"
}

install_aurorae() {
  local name="${1}"
  local color="${2}"
  local window="${3}"
  local scale="${4}"

  local AURORAE_THEME="${AURORAE_DIR}/${name}${color}${window}${scale}"

  [[ -d "${AURORAE_THEME}" ]] && rm -rf "${AURORAE_THEME}"

  cp -r "${SRC_DIR}/aurorae/main${window}/${name}${color}${window}${scale}"          "${AURORAE_THEME}"
  cp -r "${SRC_DIR}/aurorae/common/assets${color}/"*.svg                             "${AURORAE_THEME}"
  cp -r "${SRC_DIR}/aurorae/"{metadata.desktop,metadata.json}                        "${AURORAE_THEME}"
  cp -r "${SRC_DIR}/aurorae/main${window}/${name}${color}${window}rc"                "${AURORAE_THEME}/${name}${color}${window}${scale}rc"

  sed -i "s/WhiteSur/${name}${color}${window}${scale}/g" "${AURORAE_THEME}/metadata.desktop" "${AURORAE_THEME}/metadata.json"
}

while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -n|--name)
      name="${1}"
      shift
      ;;
    -c|--color)
      shift
      for pcolor in "$@"; do
        case "$pcolor" in
          light)
            colors+=("${COLOR_VARIANTS[0]}")
            pcolors+=("${PCOLOR_VARIANTS[0]}")
            shift
            ;;
          alt)
            colors+=("${COLOR_VARIANTS[0]}")
            pcolors+=("${PCOLOR_VARIANTS[1]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[1]}")
            pcolors+=("${PCOLOR_VARIANTS[2]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo -e "ERROR: Unrecognized color variant '$1'."
            echo -e "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -w|--window)
      shift
      for window in "$@"; do
        case "$window" in
          default)
            windows+=("${WINDOW_VARIANTS[0]}")
            shift
            ;;
          opaque)
            windows+=("${WINDOW_VARIANTS[1]}")
            opaque='true'
            echo -e "Install opaque theme version."
            shift
            ;;
          sharp)
            windows+=("${WINDOW_VARIANTS[2]}")
            sharp='true'
            echo -e "Install sharp theme version."
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo -e "ERROR: Unrecognized color variant '$1'."
            echo -e "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo -e "ERROR: Unrecognized installation option '$1'."
      echo -e "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

# ── STEP 1: Remove stale themes ──────────────────────────────────
echo -e "Installing '${THEME_NAME} kde themes'..."
rm -rf "${LOOKFEEL_DIR}/arcade.splash"
rm -rf "${LOOKFEEL_DIR}/ArcadeSplash"

# ── STEP 2: Install SF Pro font ──────────────────────────────────
install_sf_fonts

# ── STEP 3: Install icons and splash ─────────────────────────────
install_arcade_icons
install_arcade_splash

# ── STEP 4: Install theme files ──────────────────────────────────
for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  install "${name:-${THEME_NAME}}" "${color}"
done

for pcolor in "${pcolors[@]:-${PCOLOR_VARIANTS[@]}}"; do
  install_plasma "${name:-${THEME_NAME}}" "${pcolor}"
done

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  for window in "${windows[@]:-${WINDOW_VARIANTS[0]}}"; do
    for scale in "${scales[@]:-${SCALE_VARIANTS[@]}}"; do
      install_aurorae "${name:-${THEME_NAME}}" "${color}" "${window}" "${scale}"
    done
  done
done

echo -e "Install finished..."

# ── STEP 5: Rebuild KDE cache ────────────────────────────────────
if command -v kbuildsycoca6 >/dev/null 2>&1; then
  kbuildsycoca6 >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
  kbuildsycoca5 >/dev/null 2>&1 || true
fi

# ── STEP 6: Apply global theme ───────────────────────────────────
echo "Applying Arcade theme..."
if command -v plasma-apply-lookandfeel >/dev/null 2>&1; then
  plasma-apply-lookandfeel --apply com.github.ProjectArcade.Arcade
else
  lookandfeeltool --apply com.github.ProjectArcade.Arcade
fi

# ── STEP 7: Apply color scheme and widget style ──────────────────
if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
  plasma-apply-colorscheme ArcadeDark
fi
kwriteconfig6 --file kdeglobals --group General --key ColorScheme "ArcadeDark"
kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle "kvantum-dark"

# ── STEP 8: Set SF Pro as system font ────────────────────────────
if fc-list | grep -qi "SF Pro"; then
  kwriteconfig6 --file kdeglobals --group General --key font "SF Pro Text,11,-1,5,50,0,0,0,0,0"
  kwriteconfig6 --file kdeglobals --group General --key menuFont "SF Pro Text,11,-1,5,50,0,0,0,0,0"
  kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "SF Pro Text,9,-1,5,50,0,0,0,0,0"
  kwriteconfig6 --file kdeglobals --group General --key toolBarFont "SF Pro Text,10,-1,5,50,0,0,0,0,0"
  kwriteconfig6 --file kdeglobals --group General --key fixed "SF Mono,11,-1,5,50,0,0,0,0,0"
  echo "SF Pro font set as system font."
fi

# ── STEP 9: Set icon theme ───────────────────────────────────────
kwriteconfig6 --file kdeglobals --group Icons --key Theme "Arcade-icons"

# ── STEP 10: Enable KWin blur ────────────────────────────────────
kwriteconfig6 --file kwinrc --group Plugins --key blurEnabled true
kwriteconfig6 --file kwinrc --group Effect-blur --key BlurStrength 10
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true

# ── STEP 11: Reset plasma layout ─────────────────────────────────
rm -f ~/.config/plasma-org.kde.plasma.desktop-appletsrc

# ── STEP 12: Set panel opacity ───────────────────────────────────
for panel_id in $(grep -o "Panel [0-9]*\]" ~/.config/plasmashellrc | grep -o "[0-9]*" | sort -u); do
  kwriteconfig6 --file plasmashellrc --group "PlasmaViews" --group "Panel ${panel_id}" --key "opacityMode" "3"
  kwriteconfig6 --file plasmashellrc --group "PlasmaViews" --group "Panel ${panel_id}" --key "floating" "1"
done

# ── STEP 13: Restart plasmashell ─────────────────────────────────
plasmashell --replace &> /dev/null &
sleep 5

# ── STEP 14: Apply wallpaper AFTER plasmashell starts ────────────
WALLPAPER_IMAGE="/home/notspidey/Desktop/ProjectArcade/ArcadeLinux-Core/arcade-theme/wallpaper/Arcade/contents/images/3840x2160.png"
if command -v plasma-apply-wallpaperimage >/dev/null 2>&1 && [[ -f "${WALLPAPER_IMAGE}" ]]; then
  plasma-apply-wallpaperimage "${WALLPAPER_IMAGE}"
  echo "Wallpaper applied: ${WALLPAPER_IMAGE}"
fi

echo "Done. Log out and back in for full effect."