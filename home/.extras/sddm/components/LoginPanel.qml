import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: 35
  property var inputWidth: 200

  anchors.fill: parent

  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: inputHeight * 3 + (2 * 8) + 32
    width: inputWidth + 32
    radius: 4
    color: config.crust
    border.width: 2
    border.color: config.surface0
  }

  Column {
    spacing: 8
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }

    UserField {
      id: userField
      height: inputHeight
      width: parent.width
    }

    PasswordField {
      id: passwordField
      height: inputHeight
      width: parent.width
      onAccepted: loginButton.clicked()
    }

    Button {
      id: loginButton
      height: inputHeight
      width: parent.width
      enabled: user !== "" && password !== ""
      hoverEnabled: true

      contentItem: Text {
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize
          weight: config.FontWeight
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.crust
        text: "Login"
      }

      background: Rectangle {
        radius: 2
        color: config.text
      }

      states: [
        State {
          name: "hovered"
          when: loginButton.hovered
          PropertyChanges {
            target: loginButton.background
            color: config.lavender
          }
          PropertyChanges {
            target: loginButton.contentItem
            color: config.base
          }
        }
      ]

      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 100
        }
      }

      onClicked: sddm.login(user, password, session)
    }
  }

  Row {
    spacing: 8
    z: 5
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
      bottomMargin: 50
    }
    StyledButton {
      buttonText: ""
      onClicked: sddm.powerOff()
    }
    StyledButton {
      buttonText: ""
      onClicked: sddm.reboot()
    }
    StyledButton {
      buttonText: ""
      onClicked: sddm.suspend()
    }
    SessionPanel { id: sessionPanel }
  }

  Connections {
    target: sddm
    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
