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


Rectangle {
    id: octave

    property int number: 0
    property int whiteWidth: 50
    property int blackWidth: 30
    readonly property int totalWidth: 7 * whiteWidth + 5 * blackWidth

    function keyNumFromPoint(point) {
        var x = point.x
        if(x < whiteWidth)
            return 0
        x -= whiteWidth
        if(x < blackWidth)
            return 1
        x -= blackWidth
        if(x < whiteWidth)
            return 2
        x -= whiteWidth
        if(x < blackWidth)
            return 3
        x -= blackWidth
        if(x < whiteWidth)
            return 4
        x -= whiteWidth
        if(x < whiteWidth)
            return 5
        x -= whiteWidth
        if(x < blackWidth)
            return 6
        x -= blackWidth
        if(x < whiteWidth)
            return 7
        x -= whiteWidth
        if(x < blackWidth)
            return 8
        x -= blackWidth
        if(x < whiteWidth)
            return 9
        x -= whiteWidth
        if(x < blackWidth)
            return 10
        x -= blackWidth
        return 11
    }

    height: 100
    width: keys.width
    color: "transparent"

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
        id: keys
        height: parent.height
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "black"
            border.color: "gray"
            height: parent.height
            width: blackWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "black"
            border.color: "gray"
            height: parent.height
            width: blackWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "black"
            border.color: "gray"
            height: parent.height
            width: blackWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "black"
            border.color: "gray"
            height: parent.height
            width: blackWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
        Rectangle {
            color: "black"
            border.color: "gray"
            height: parent.height
            width: blackWidth
        }
        Rectangle {
            color: "white"
            border.color: "gray"
            height: parent.height
            width: whiteWidth
        }
    }
}
