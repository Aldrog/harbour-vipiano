/*
 * Copyright © 2017 Andrew Penkrat
 *
 * This file is part of ViPiano.
 *
 * ViPiano is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ViPiano is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ViPiano.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Image {
        id: clef

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: keyboard.bottom
        }

        source: "../images/clef_" + (Theme.colorScheme == Theme.LightOnDark ? "w" : "b") + ".svg"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: keyboard

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: width/3

        source: "../images/keyboard.svg"
        fillMode: Image.PreserveAspectFit
    }
}

