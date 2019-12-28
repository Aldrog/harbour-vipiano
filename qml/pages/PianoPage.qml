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

    ComboBox {
        id: selector

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        label: qsTr("Program")
        value: synthesizer.currentProgram.name

        menu: ContextMenu {
            Repeater {
                model: synthesizer.availablePrograms

                MenuItem {
                    text: modelData.name
                    onClicked: synthesizer.currentProgram = modelData
                }
            }
        }
    }

    Grid {
        id: keyboard

        anchors {
            left: parent.left
            right: parent.right
            leftMargin: Theme.horizontalPageMargin
            rightMargin: Theme.horizontalPageMargin
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
            top: selector.bottom
        }
        spacing: Theme.paddingSmall

        columns: isPortrait ? 1 : 2

        Repeater {
            model: 6
            Octave {
                number: index + 2
                width: {
                    if (isPortrait)
                        return page.width - 2*Theme.horizontalPageMargin
                    else
                        return page.width / 2 - Theme.horizontalPageMargin - keyboard.spacing / 2
                }
                height: {
                    var rows = isPortrait ? 6 : 3
                    return (keyboard.height - (rows-1)*keyboard.spacing) / rows
                }
            }
        }
    }
}

