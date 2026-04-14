import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: root
  selectByMouse: true
  selectionColor: config.overlay0
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pointSize: config.FontSize
  font.weight: 800
  color: config.text
  horizontalAlignment: TextInput.AlignHCenter

  background: Rectangle {
    id: fieldBackground
    radius: config.rounding_small
    color: config.base
    border.width: config.border_size
    border.color: config.surface0
  }

  states: [
    State {
      name: "focused"
      when: root.activeFocus
      PropertyChanges {
        target: fieldBackground
        border.color: config.lavender
      }
    },
    State {
      name: "hovered"
      when: root.hovered
      PropertyChanges {
        target: fieldBackground
        border.color: config.lavender
      }
    }
  ]

  transitions: Transition {
    PropertyAnimation {
      properties: "border.color"
      duration: 100
    }
  }
}
