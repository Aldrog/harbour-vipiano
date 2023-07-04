project(harbour-vipiano CXX)
cmake_minimum_required(VERSION 3.5)

find_package (Qt5 COMPONENTS Core Network Qml Gui Quick REQUIRED)

include(FindPkgConfig)
# App dependencies
pkg_search_module(SAILFISH sailfishapp REQUIRED)
pkg_search_module(AUDIORESOURCE audioresource REQUIRED)
# Fluid dependencies
pkg_check_modules(GLIB REQUIRED glib-2.0>=2.6.5 gthread-2.0>=2.6.5)
pkg_check_modules(PULSE libpulse-simple>=0.9.8)
pkg_check_modules(LIBSNDFILE sndfile>=1.0.0)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 11)
# Strip binary in release mode
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -s")

set(DEPS_DIR ${CMAKE_BINARY_DIR}/deps)
include(ExternalProject)
ExternalProject_Add(fluid
    URL      https://github.com/FluidSynth/fluidsynth/archive/v2.1.0.tar.gz
    URL_HASH MD5=e0461e01e121bd0902d29233664e2f43
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX:STRING=${DEPS_DIR}
        -DBUILD_SHARED_LIBS:BOOL=OFF
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        # Linking with libsailfishapp requires position independent code.
        # Also, CMAKE_POSITION_INDEPENDENT_CODE doesn't work here
        # as it gets overwriten by fluidsynth configuration.
        -DCMAKE_C_FLAGS:STRING="-fPIC"
        -Denable-dbus:BOOL=OFF
        -DCMAKE_BUILD_TYPE=Release
)

add_executable(harbour-vipiano 
    src/synthesizer.h 
    src/synthesizer.cpp
    src/synthsettings.h 
    src/synthsettings.cpp
    src/harbour-vipiano.cpp
)

add_dependencies(harbour-vipiano fluid)
target_include_directories(harbour-vipiano PRIVATE
    $<BUILD_INTERFACE:
    ${SAILFISH_INCLUDE_DIRS}
    ${AUDIORESOURCE_INCLUDE_DIRS}
    ${DEPS_DIR}/include
>)

target_link_directories(harbour-vipiano PUBLIC "${DEPS_DIR}/lib64")

target_link_libraries(harbour-vipiano
    Qt5::Quick
    ${SAILFISH_LDFLAGS}
    ${AUDIORESOURCE_LDFLAGS}
    # FluidSynth with dependencies
    libfluidsynth.a
    ${GLIB_LDFLAGS}
    ${PULSE_LDFLAGS}
    ${LIBSNDFILE_LDFLAGS}
)

install(TARGETS harbour-vipiano
    RUNTIME DESTINATION bin
)
install(DIRECTORY qml
    DESTINATION share/harbour-vipiano
)
install(DIRECTORY translations
    DESTINATION share/harbour-vipiano
    FILES_MATCHING PATTERN "*.qm"
)
install(FILES harbour-vipiano.desktop
    DESTINATION share/applications
)
foreach(SIZE 86x86 108x108 128x128 172x172)
    install(FILES icons/${SIZE}/harbour-vipiano.png
        DESTINATION share/icons/hicolor/${SIZE}/apps
    )
endforeach()
install(FILES soundfonts/FluidR3Mono_GM.sf3
    DESTINATION share/harbour-vipiano/soundfonts
)
