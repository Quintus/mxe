# This file is part of MXE.
# See index.html for further information.

PKG             := cegui
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := f0a8616bcb37843ad2f83c88745b9313906cb8e9
$(PKG)_SUBDIR   := CEGUI-$($(PKG)_VERSION)
$(PKG)_FILE     := CEGUI-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/crayzedsgui/CEGUI%20Mk-2/$($(PKG)_VERSION)/$($(PKG)_FILE)?download
$(PKG)_DEPS     := gcc freeglut freeimage freetype pcre libxml2 expat

define $(PKG)_UPDATE
    echo 'TODO: Updates for package cegui need to be written.' >&2; echo $(cegui_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --enable-freetype \
        --enable-pcre \
        --disable-xerces-c \
        --enable-libxml \
        --enable-expat \
        --disable-corona \
        --disable-devil \
        --enable-freeimage \
        --disable-silly \
        --enable-tga \
        --enable-stb \
        --enable-opengl-renderer \
        --disable-ogre-renderer \
        --disable-irrlicht-renderer \
        --disable-directfb-renderer \
        --enable-null-renderer \
        --enable-samples \
        --disable-lua-module \
        --disable-python-module \
        PKG_CONFIG='$(TARGET)-pkg-config' \
        CFLAGS="`$(TARGET)-pkg-config --cflags glut freeimage`" \
        CXXFLAGS="`$(TARGET)-pkg-config --cflags glut freeimage`" \
        LDFLAGS="`$(TARGET)-pkg-config --libs glut freeimage`"
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(SED) -i 's/Cflags:\(.*\)/Cflags: \1 -DCEGUI_STATIC/' '$(1)/cegui/CEGUI.pc'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
