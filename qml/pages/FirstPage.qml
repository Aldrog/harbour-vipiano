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


import QtQuick 2.6
import Sailfish.Silica 1.0


Page {
    id: page

    allowedOrientations: Orientation.All

    Column {
        anchors.fill: parent

        PageHeader {
            id: header
            title: qsTr("Welcome to ViPiano (Virtual Piano)")
        }

        ComboBox {
            label: qsTr("Program")
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Yamaha Grand Piano")
                    onClicked: synthesizer.selectProgram(0, 0)
                }
                MenuItem {
                    text: qsTr("Church Organ")
                    onClicked: synthesizer.selectProgram(0, 19)
                }
            }
        }

        Grid {
            id: keyboard

            width: parent.width
            leftPadding: Theme.horizontalPageMargin
            rightPadding: Theme.horizontalPageMargin
            spacing: Theme.paddingSmall

            columns: ~~((parent.width - leftPadding - rightPadding + spacing) / (500 + spacing))

            Repeater {
                model: 10
                Octave {
                    number: index
                }
            }
        }
    }
}

