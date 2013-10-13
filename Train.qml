import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	id: train
	height:imageID.sourceSize.height
	width:imageID.sourceSize.width
	color:"transparent"

	signal clicked
	property url image

	Image {
		id: imageID
		anchors.fill:parent
		source: train.image
	}

	MouseArea {
		anchors.fill:parent
		onClicked: train.clicked()
	}
}
