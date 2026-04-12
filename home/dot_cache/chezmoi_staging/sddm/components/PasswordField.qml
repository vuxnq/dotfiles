import QtQuick 2.15
import QtQuick.Controls 2.15

StyledTextField {
  id: root
  focus: true
  placeholderText: "password"
  placeholderTextColor: config.subtext0
  echoMode: TextInput.Password
  passwordCharacter: "*"
  passwordMaskDelay: config.PasswordShowLastLetter
}
