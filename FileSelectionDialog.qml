import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

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

    function filterModel(model) {
      var newModel = []
      for (var key in model) {
        var item = model[key]
        if (item.toLowerCase().indexOf(filterInput.text.toLowerCase()) !== -1) {
          newModel.push(item)
        }
      }
      return newModel
    }

    function select(file) {
      root.file = "file://" + file
        // @disable-check M110
        root.folder = "file://" + new String(file).substring(
            0, file.lastIndexOf('/'))
      root.selected = true
    }
  }

  Settings {
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
        readonly property string data_: d.filteredModel[index]
        text: data_
        onClicked: d.select(text)
        height: visible ? 30 : 0
      }

      onCountChanged: {
        if (root.autoSelect && (count == 1) && !root.selected) {
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
