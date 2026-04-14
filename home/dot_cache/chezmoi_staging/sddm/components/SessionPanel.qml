import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Item {
  property var session: sessionList.currentIndex
  implicitHeight: sessionButton.height
  implicitWidth: sessionButton.width

  DelegateModel {
    id: sessionWrapper
    model: sessionModel
    delegate: ItemDelegate {
      id: sessionEntry
      height: config.input_height
      width: parent.width
      highlighted: sessionList.currentIndex == index

      contentItem: Text {
        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.FontSize
        font.weight: config.FontWeightBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.text
        text: name
      }

      background: Rectangle {
        color: config.base
        radius: config.rounding_small
      }

      states: [
        State {
          name: "hovered"
          when: sessionEntry.hovered
          PropertyChanges { target: background; color: config.lavender }
          PropertyChanges { target: contentItem; color: config.base }
        },
        State {
          name: "selected"
          when: sessionEntry.highlighted
          PropertyChanges { target: background; color: config.lavender }
          PropertyChanges { target: contentItem; color: config.base }
        }
      ]

      transitions: Transition {
        PropertyAnimation { properties: "color"; duration: 100 }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          sessionList.currentIndex = index
          sessionPopup.close()
        }
      }
    }
  }

  Button {
    id: sessionButton
    height: config.input_height
    width: config.input_height
    hoverEnabled: true

    Label {
      id: buttonLabel
      anchors.centerIn: parent
      font.family: config.Font
      font.pointSize: config.FontSize
      font.weight: config.FontWeight
      color: config.text
      text: ""
    }

    background: Rectangle { radius: config.rounding; color: config.surface0 }

    states: [
      State {
        name: "pressed"
        when: down
        PropertyChanges { target: background; color: config.surface1 }
      },
      State {
        name: "hovered"
        when: hovered
        PropertyChanges { target: background; color: config.lavender }
        PropertyChanges { target: buttonLabel; color: config.base }
      },
      State {
        name: "active"
        when: checked || highlighted
        PropertyChanges { target: background; color: config.lavender }
        PropertyChanges { target: buttonLabel; color: config.base }
      }
    ]

    transitions: Transition { PropertyAnimation { properties: "color"; duration: 100 } }

    onClicked: sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
  }

  Popup {
    id: sessionPopup
    padding: config.gaps_out
    width: config.input_width * 1 + padding * 2
    x: -config.input_width - 16
    y: -(contentHeight + padding * 2) + sessionButton.height

    background: Rectangle {
      radius: config.rounding
      color: config.crust
      border.width: config.border_size
      border.color: config.surface0
    }

    contentItem: ListView {
      id: sessionList
      implicitHeight: contentHeight
      spacing: config.gaps_in
      model: sessionWrapper
      currentIndex: sessionModel.lastIndex
      clip: true
    }

    enter: Transition {
      ParallelAnimation {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 100; easing.type: Easing.OutExpo }
        NumberAnimation { property: "x"; from: sessionPopup.x + (config.input_width * 0.1); to: sessionPopup.x; duration: 100; easing.type: Easing.OutExpo }
      }
    }
    exit: Transition {
      NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 100; easing.type: Easing.OutExpo }
    }
  }
}
