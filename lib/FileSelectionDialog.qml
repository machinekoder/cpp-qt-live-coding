import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.settings

Item {
  property bool selected: false
  property string folder: ""
  property string file: ""
  property bool autoSelect: true
  property var model: []

  id: root

  QtObject {
    id: d
    readonly property var filteredModel: filterModel(root.model)

    function filterModel(model: list) {
      var newModel = []
      for (var key in model) {
        var item = model[key]
        if (item.toLowerCase().indexOf(filterInput.text.toLowerCase()) !== -1) {
          newModel.push(item)
        }
      }
      return newModel
    }

    function select(file: string) {
      root.file = "file://" + file
      root.folder = "file://" + new String(file).substring(
            0, file.lastIndexOf('/'))
      root.selected = true
    }
  }

  Settings {
    category: "live_coding"
    property alias filterText: filterInput.text
  }

  ColumnLayout {
    anchors.fill: parent

    TextField {
      id: filterInput
      Layout.fillWidth: true
      placeholderText: "filter"

      onFocusChanged: {
        if (focus) {
          selectAll()
        }
      }
    }

    ListView {
      id: listView
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      model: d.filteredModel

      delegate: Button {
        readonly property string data: d.filteredModel[index]
        text: data
        onClicked: d.select(text)
        height: visible ? 30 : 0
      }

      onCountChanged: {
        if (root.autoSelect && (count === 1) && !root.selected) {
          selectTimer.start()
        }
      }
    }
  }

  Timer {
    id: selectTimer
    interval: 10
    onTriggered: d.select(d.filteredModel[0])
  }
}
