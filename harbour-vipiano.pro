# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-vipiano

CONFIG += sailfishapp

SOURCES += \
    src/synthesizer.cpp \
    src/harbour-vipiano.cpp

OTHER_FILES += \
    qml/harbour-vipiano.qml \
    qml/cover/Cover.qml \
    qml/pages/PianoPage.qml \
    qml/pages/Octave.qml \
    translations/*.ts

INCLUDEPATH += tempdest/usr/share/harbour-vipiano/include
LIBS += -Ltempdest/usr/share/harbour-vipiano/lib -lfluidsynth
QMAKE_RPATHDIR += /usr/share/harbour-vipiano/lib

PKGCONFIG += sndfile audioresource

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

HEADERS += \
    src/synthesizer.h

DISTFILES += \
    rpm/harbour-vipiano.changes.in \
    rpm/harbour-vipiano.spec \
    rpm/harbour-vipiano.yaml \
    harbour-vipiano.desktop
