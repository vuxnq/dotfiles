import QtQuick 2.15
import SddmComponents 2.0

Clock {
  id: time
  color: config.text
  timeFont.family: config.Font
  dateFont.family: config.Font

  timeFont.pointSize: 30
  dateFont.pointSize: 15

  timeFont.weight: 800
  dateFont.weight: 700

  anchors {
    horizontalCenter: parent.horizontalCenter
    top: parent.top
    margins: 300
  }
}
