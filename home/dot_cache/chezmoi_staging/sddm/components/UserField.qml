import QtQuick 2.15
import QtQuick.Controls 2.15

StyledTextField {
  id: root
  echoMode: TextInput.Normal
  placeholderText: "username"
  placeholderTextColor: config.subtext0
  text: userModel.lastUser
}
