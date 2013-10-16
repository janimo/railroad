import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	property int nLoco: 9
	property int nWag:14

	height: 600
	width: 1200

	//Background image
	Image {
		width: parent.width
		height: parent.height
		source: "assets/images/railroad-bg.svg"
	}

	//Station
	Row {
		id: station
		height: parent.height/5
	}

	function addToStation(index) {
		var component = Qt.createComponent("Train.qml");
		var object = component.createObject(station, {
					image : trains[index]
		})
	}

	property variant trains

	//Depot
	Grid  {
		id: depot
		anchors.top: station.bottom
		spacing: 25
		columns: 5
		rows: 5
		Repeater {
			model: trains.length
			Train {
				image: trains[index]
				onClicked: addToStation(index)
			}
		}
	}

	function newGame() {
		trains = initTrains()
	}

	function initTrains() {
		var t = []
		for(var i=0;i<nLoco;i++) {
			t.push("assets/images/loco%1.png".arg(i+1))
		}
		for(var i=0;i<nWag;i++) {
			t.push("assets/images/wagon%1.png".arg(i+1))
		}
		return t
	}

	Component.onCompleted: newGame()
}
