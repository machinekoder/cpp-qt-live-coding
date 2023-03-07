import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt.labs.settings
import com.machinekoder.live

ApplicationWindow {
  id: root
  visible: true
  title: qsTr("Qt Live Coding")
  width: 1024
  height: 800
  flags: liveCoding.flags
  visibility: liveCoding.visibility

  Component.onCompleted: {
      for (var i = 0; i < Qt.application.screens.length; ++i) {
          let screen = Qt.application.screens[i]
          if (screen.serialNumber === windowSettings.screen) {
              root.screen = screen
              return
          }
      }
  }

  Component.onDestruction: {
      windowSettings.screen = root.screen.serialNumber
  }

  LiveCodingPanel {
    id: liveCoding
    anchors.fill: parent
  }

  Settings {
    id: windowSettings
    category: "window"
    property alias width: root.width
    property alias height: root.height
    property alias x: root.x
    property alias y: root.y
    property alias visibility: liveCoding.visibility
    property alias flags: liveCoding.flags
    property alias hideToolBar: liveCoding.hideToolBar
    property string screen: ""
  }
}
