import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Pane {
    id:root

    property string zoneName

    background: Rectangle{
        color:"black"
        opacity: 0.5

    }
    property int celsius:temperatureDial.value
    property int fahrenheit:(celsius*1.8)+32

    readonly property color temperatureColor: {
        if(celsius<10)
            return Qt.color("lightblue")
        if(celsius>=10 && celsius<20)
            return Qt.color("cyan")
        if(celsius>=20 && celsius<30)
            return Qt.color("orange")

        return Qt.color("red")

    }

    palette{
        windowText: root.temperatureColor
        dark: root.temperatureColor
    }


    RowLayout{
        anchors.fill: parent
        spacing: 10

        ColumnLayout{
            spacing: 10

            RowLayout{
                spacing: 10

                CheckBox{
                    id:zoneEnabledCheckBox
                    checked: true
                    text: qsTr("Enable %1").arg(root.zoneName)
                }
                Switch{
                    id:unitsSwitch
                    text: qsTr("°C / °F")
                }
            }
            RowLayout{
                enabled: zoneEnabledCheckBox.checked
                spacing: 10

                Image {
                    source: "assets/cool.svg"
                    Layout.alignment: Qt.AlignBottom
                }
                Dial{
                    id:temperatureDial
                    from: 0
                    to:40

                    value: 21

                    stepSize: 1
                    snapMode: Dial.SnapAlways

                    onValueChanged: console.log("dial",value)
                }

                Image {
                    source: "assets/heat.svg"
                    Layout.alignment: Qt.AlignBottom
                }

            }

        }
        ColumnLayout{
            spacing: 10
            Label{
                text:unitsSwitch.checked?root.fahrenheit+"°F":root.celsius+"°C"
                font{
                    weight: Font.ExtraLight
                    pixelSize: 200
                }
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignRight
                renderType: Text.CurveRendering
            }
            RowLayout{
                spacing: 10
                Image {
                    source: fanSpeedSlider.value>0? Qt.resolvedUrl("assets/fan_outline.svg"):Qt.resolvedUrl("assets/fan_off.svg")
                    scale: 0.75
                }
                Slider{
                    id:fanSpeedSlider

                    from: 0
                    to:100
                    Layout.fillWidth: true
                }
                Image {
                    source: Qt.resolvedUrl("assets/fan_fill.svg")
                    scale: 1.25
                }
            }
        }
    }

}
