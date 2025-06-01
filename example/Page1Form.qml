import QtQuick
import QtQuick.Controls

Page {
    height: 400
    width: 600

    header: Label {
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
        text: qsTr("My Page")
    }

    Button {
        text: qsTr("<b>Foo</b>")
    }
}
