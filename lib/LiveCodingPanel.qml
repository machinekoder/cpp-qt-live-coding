import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt.labs.settings
import com.machinekoder.live

Item {
  id: root
  property alias hideToolBar: hideToolBarCheck.checked
  property int flags: Qt.Window
  property int visibility: Window.AutomaticVisibility

  readonly property var defaultNameFilters: ["*.qmlc", "*.jsc", "*.pyc", ".#*", ".*", "*~", "__pycache__", "*___jb_tmp___", // PyCharm safe write
    "*___jb_old___"]
  property var additionalNameFilters: []

  QtObject {
    id: d

    function reload() {
      loader.source = ""
      LiveCoding.clearQmlComponentCache()
      loader.source = fileDialog.file
    }

    function openWithSystemEditor() {
      LiveCoding.openUrlWithDefaultApplication(fileDialog.file)
    }

    function unload() {
      loader.source = ""
      fileDialog.selected = false
      browser.update()
    }

    function restart() {
      LiveCoding.restartApplication()
    }
  }

  Settings {
    id: windowSettings
    category: "window"
    property alias width: root.width
    property alias height: root.height
    property alias x: root.x
    property alias y: root.y
    property alias visibility: root.visibility
    property alias hideToolBar: hideToolBarCheck.checked
  }

  MouseArea {
    id: smallArea
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 10
    width: height
    z: 10
    visible: contentItem.loaded && !fullArea.delayedVisible
    hoverEnabled: true
    propagateComposedEvents: true

    onClicked: mouse.accepted = false
    onEntered: fullArea.visible = true
  }

  MouseArea {
    property bool delayedVisible: false

    id: fullArea
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.left: parent.left
    height: 40
    z: 9
    hoverEnabled: true
    propagateComposedEvents: true
    visible: false

    onClicked: (mouse) => {mouse.accepted = false}
    onPressed: (mouse) => {mouse.accepted = false}
    onReleased: (mouse) => {mouse.accepted = false}
    onExited: visible = false
    onVisibleChanged: delayTimer.start()

    Timer {
      id: delayTimer
      interval: 10
      onTriggered: fullArea.delayedVisible = fullArea.visible // break binding loop
    }
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.topMargin: menuBar.visible ? 5 : 0

    RowLayout {
      id: menuBar
      visible: !hideToolBarCheck.checked || (smallArea.containsMouse
                                             || fullArea.containsMouse
                                             || !contentItem.loaded)

      Button {
        Layout.preferredHeight: 30
        enabled: fileDialog.selected
        text: qsTr("Edit")
        onClicked: d.openWithSystemEditor()
      }

      Button {
        Layout.preferredHeight: 30
        enabled: fileDialog.selected
        text: qsTr("Reload")
        onClicked: d.reload()
      }

      Button {
        Layout.preferredHeight: 30
        text: qsTr("Unload")
        onClicked: d.unload()
      }

      Button {
        Layout.preferredHeight: 30
        text: qsTr("Restart")
        onClicked: d.restart()
      }

      Item {
        Layout.fillWidth: true
      }

      CheckBox {
        id: hideToolBarCheck
        text: qsTr("Hide Tool Bar")
        checked: false
      }

      CheckBox {
        text: qsTr("Fullscreen")
        checked: root.visibility === Window.FullScreen

        onClicked: {
          if (checked) {
            root.visibility = Window.FullScreen
          } else {
            root.visibility = Window.AutomaticVisibility
          }
        }
      }

      CheckBox {
        text: qsTr("On Top")
        checked: root.flags & Qt.WindowStaysOnTopHint

        onClicked: {
          if (checked) {
            root.flags = root.flags | Qt.WindowStaysOnTopHint
          } else {
            root.flags = root.flags & ~Qt.WindowStaysOnTopHint
          }
        }
      }
    }

    Item {
      id: contentItem
      Layout.fillWidth: true
      Layout.fillHeight: true
      property bool loaded: loader.status !== Loader.Null

      Loader {
        id: loader
        anchors.fill: parent

        onStatusChanged: {
          if (status !== Loader.Error) {
            return
          }

          var msg = loader.sourceComponent.errorString()
          errorLabel.text = qsTr("QML Error: Loading QML file failed:\n") + msg
        }
      }

      Label {
        id: errorLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        visible: loader.status === Loader.Error
      }

      FileSelectionDialog {
        id: fileDialog
        anchors.fill: parent
        model: browser ? browser.qmlFiles : []
        visible: !contentItem.loaded

        onSelectedChanged: {
          if (selected) {
            d.reload()
          }
        }
      }
    }
  }

  ProjectBrowser {
    id: browser
    //projectPath: userProjectPath
    extensions: ['qml', 'ui.qml']
  }

  FileWatcher {
    id: fileWatcher
    fileUrl: browser ? browser.projectPath : ""
    recursive: true
    enabled: fileDialog.selected
    onFileChanged: {
      d.reload()
    }
    nameFilters: root.defaultNameFilters.concat(root.additionalNameFilters)
  }

  // add additional components that should only be loaded once here.
}
