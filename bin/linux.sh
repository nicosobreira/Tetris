#!/usr/bin/env bash

. setup.sh

downloadAppImage() {
    name=$1
    link=$2

    if [[ ! -f "$name" ]]; then
        echo "Downloading $name"
        wget -O "./$name" "$link"
        echo "Changing permissions $name"
        chmod +x "$name"
    fi
}

APPIMAGETOOL="appimagetool.AppImage"
APPIMAGETOOL_LINK="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"

LOVE="love-$VERSION.AppImage"
LOVE_DIR="squashfs-root"
LOVE_LINK="https://github.com/love2d/love/releases/download/$VERSION/love-$VERSION-x86_64.AppImage"

downloadAppImage $LOVE $LOVE_LINK

downloadAppImage $APPIMAGETOOL $APPIMAGETOOL_LINK

./"$LOVE" --appimage-extract

cat "squashfs-root/bin/love" "./$GAME" > "squashfs-root/bin/$NAME"

chmod +x "squashfs-root/bin/$NAME"
rm "squashfs-root/bin/love"

# Can add Icon
cat <<EOF > squashfs-root/love.desktop
[Desktop Entry]
Name=$NAME
Comment=Another tetris game
MimeType=application/x-love-game;
Exec=$NAME %f
Type=Application
Categories=Development;Game;
Terminal=false
Icon=love
NoDisplay=true
EOF

./"$APPIMAGETOOL" squashfs-root "$NAME.AppImage"

cat <<'EOF' > squashfs-root/AppRun
#!/bin/sh
if [ -z "$APPDIR" ]; then
    APPDIR="$(dirname "$(readlink -f "$0")")"
fi
export LD_LIBRARY_PATH="$APPDIR/lib/:$LD_LIBRARY_PATH"
if [ -z "$XDG_DATA_DIRS" ]; then #unset or empty
    XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
fi
export XDG_DATA_DIRS="$APPDIR/share/:$XDG_DATA_DIRS"
if [ -z "$LUA_PATH" ]; then
    LUA_PATH=";" # so ends with ;;
fi
# if user's LUA_PATH does not end with ;; then user doesn't want the default path ?
export LUA_PATH="$APPDIR/share/luajit-2.1.0-beta3/?.lua;$APPDIR/share/lua/5.1/?.lua;$LUA_PATH"
if [ -z "$LUA_CPATH" ]; then
    LUA_CPATH=";"
fi
export LUA_CPATH="$APPDIR/lib/lua/5.1/?.so;$LUA_CPATH"
# run the SuperGame bin
exec "$APPDIR/bin/SuperGame" "$@"
EOF

chmod +x squashfs-root/AppRun
