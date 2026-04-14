import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
  id: root
  height: config.input_height
  width: config.input_height
  hoverEnabled: true

  property string buttonText: ""

  Label {
    id: buttonLabel
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    font.family: config.Font
    font.pointSize: config.FontSize
    font.weight: config.FontWeight
    color: config.text
    text: root.buttonText
  }

  background: Rectangle {
    radius: config.rounding
    color: config.base
  }

  states: State {
    name: "hovered"
    when: root.hovered
    PropertyChanges {
      target: root.background
      color: config.lavender
    }
    PropertyChanges {
      target: buttonLabel
      color: config.base
    }
  }

  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 100
    }
  }
}
