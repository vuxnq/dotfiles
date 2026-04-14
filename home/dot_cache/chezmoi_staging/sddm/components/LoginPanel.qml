import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session

  anchors.fill: parent

  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: config.input_height * 3 + (2 * config.gaps_in) + (2 * config.border_size) + (2 * config.gaps_out)
    width: config.input_width * 1 + (2 * config.border_size) + (2 * config.gaps_out)
    radius: config.rounding
    color: config.crust
    border.width: config.border_size
    border.color: config.surface0
  }

  Column {
    spacing: config.gaps_in
    z: 5
    width: config.input_width
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }

    UserField {
      id: userField
      height: config.input_height
      width: parent.width
    }

    PasswordField {
      id: passwordField
      height: config.input_height
      width: parent.width
      onAccepted: loginButton.clicked()
    }

    Button {
      id: loginButton
      height: config.input_height
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
        text: "login"
      }

      background: Rectangle {
        radius: config.rounding_small
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
