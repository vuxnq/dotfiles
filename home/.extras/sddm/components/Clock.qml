import QtQuick 2.15

Item {
  width: parent.width
  anchors {
    top: parent.top
    topMargin: Screen.height * 0.25
  }

  Column {
    width: parent.width

    Text {
      id: timeText
      width: parent.width
      renderType: Text.NativeRendering
      font.family: config.Font
      font.pointSize: 30
      font.weight: config.FontWeight
      color: config.text
      horizontalAlignment: Text.AlignHCenter
      text: Qt.formatDateTime(new Date(), "HH:mm")
      Timer {
        interval: 1000
        running: true
        onTriggered: timeText.text = Qt.formatDateTime(new Date(), "HH:mm")
      }
    }

    Text {
      id: dateText
      width: parent.width
      renderType: Text.NativeRendering
      font.family: config.Font
      font.pointSize: 15
      font.weight: config.FontWeightBold
      color: config.subtext0
      horizontalAlignment: Text.AlignHCenter
      text: Qt.formatDateTime(new Date(), "ddd, dd MMM yyyy")
      Timer {
        interval: 60000
        running: true
        onTriggered: dateText.text = Qt.formatDateTime(new Date(), "ddd, dd MMM yyyy")
      }
    }
  }
}
