import QtQuick 2.0
import QtMultimedia 5.0
import "railroad.js" as Railroad

Rectangle {

	//Window dimensions
	height: 600
	width: 1200

	//Background image
	Image {
		width: parent.width
		height: parent.height
		source: "assets/images/railroad-bg.svg"
	}

	//Station at the top of the screen
	Row {
		id: station
		height: parent.height/5
	}

	//All trains
	property var trains: []
	//The train to copy
	property var newTrain: []

	//Depot
	Rectangle  {
		id: depot
		visible: false
		color:"transparent"
		anchors.top: station.bottom
		height: 19*parent.height/25
		width: parent.width
		Repeater {
			model: trains.length
			Train {
				name: trains[index]
				onClicked: {
						Railroad.addToStation(trains[index])
						Railroad.checkMatch()
				}
				x: (index % 5) * 230 + 30
				y: parent.height/5 * (Math.floor(index/5) + 1) - height
			}
		}
	}

	Timer {
		id: startGameTimer
		interval: 3000
		onTriggered: stationAnimation.start()
	}

	Timer {
		id: newGameTimer
		interval: 5000
		onTriggered: Railroad.newGame()
	}

	Audio {
		id: trainSound
		source: "assets/sounds/train.wav"
	}

	Audio {
		id: bonusSound
		source: "assets/sounds/bonus.wav"
	}

	PropertyAnimation {
		id: stationAnimation
		target: station
		property: "x"
		from: 0
		to: 1200
		duration: 15000
		easing.type: Easing.InQuad
		onStopped: Railroad.startGame()
	}

	Component.onCompleted: Railroad.initGame();
}
