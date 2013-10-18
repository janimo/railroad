import QtQuick 2.0

Rectangle {
	id: train
	height:imageID.sourceSize.height
	width:imageID.sourceSize.width
	color:"transparent"

	signal clicked
	property string name

	Image {
		id: imageID
		anchors.fill:parent
		source: "assets/images/"+train.name
	}

	MouseArea {
		id: mouseArea
		anchors.fill:parent
		onClicked: train.clicked()
	}

	states: State {
		name: "pressed"
		when: mouseArea.pressed
		PropertyChanges {
			target: train
			opacity: 0.4
		}
	}
}
