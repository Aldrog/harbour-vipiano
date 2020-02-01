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

Item {
    id: octave

    property int number: 0
    readonly property int whiteWidth: width / 7
    property int blackWidth: whiteWidth / 2
    property int blackHeight: height * 2/3

    function keyNumFromPoint(point) {
        for (var i = 0; i < blackKeys.count; i++) {
            var item = blackKeys.itemAt(i)
            if (point.x >= item.x && point.x < item.x + item.width &&
                point.y >= item.y && point.y < item.y + item.height)
                return item.keyNum
        }
        for (i = 0; i < whiteKeys.count; i++) {
            item = whiteKeys.itemAt(i)
            if (point.x >= item.x && point.x < item.x + item.width &&
                point.y >= item.y && point.y < item.y + item.height)
                return item.keyNum
        }
        return -1
    }

    height: 250

    MultiPointTouchArea {
        property var keysPressed: []

        anchors.fill: parent

        function tryAdding(key) {
            for (var i in keysPressed) {
                if (key === keysPressed[i])
                    return
            }
            synthesizer.startPlaying(number * 12 + key)
        }

        function tryRemoving(key) {
            for (var i in keysPressed) {
                if (key === keysPressed[i])
                    return
            }
            synthesizer.stopPlaying(number * 12 + key)
        }

        onTouchUpdated: {
            var keys = []
            for (var i in touchPoints) {
                var key = keyNumFromPoint(touchPoints[i])
                if (key < 0)
                    continue
                tryAdding(key)
                keys.push(key)
            }
            var tmp = keysPressed
            keysPressed = keys
            keys = tmp
            for (i in keys) {
                tryRemoving(keys[i])
            }
        }
    }

    Row {
        height: parent.height
        Repeater {
            id: whiteKeys

            model: 7
            Rectangle {
                property int keyNum: [0, 2, 4, 5, 7, 9, 11][index]

                color: "white"
                border.color: "gray"
                border.width: 3
                height: parent.height
                width: whiteWidth
            }
        }
    }

    Repeater {
        id: blackKeys

        model: [1, 2, 4, 5, 6]
        Rectangle {
            property var whiteKey: whiteKeys.count > modelData ? whiteKeys.itemAt(modelData) : null
            property int keyNum: [1, 3, 6, 8, 10][index]

            color: "black"
            height: blackHeight
            width: blackWidth
            y: 0
            x: whiteKey.x - width/2
            z: 1
        }
    }
}
