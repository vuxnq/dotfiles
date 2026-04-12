import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "components"

Item {
  id: root
  height: Screen.height
  width: Screen.width

  Image {
    id: backgroundImage
    source: config.Background
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
  }

  Item {
    id: mainPanel
    z: 3
    anchors {
      fill: parent
    }
    Clock {
      id: time
    }
    LoginPanel {
      id: loginPanel
    }
  }
}
