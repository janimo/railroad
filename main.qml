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

	//Station at the top of the screen showing the moving train
	Row {
		id: demoStation
		height: parent.height/5

		NumberAnimation on x {
			id: stationAnimation
			to: 1200
			duration: 15000
			easing.type: Easing.InQuad
			onStopped: Railroad.guessTrain()
		}
	}

	//Station at the top of the screen
	Row {
		id: station
		height: parent.height/5
		visible: ! demoStation.visible

		transform: Scale {
			id: stationScale
			property real scale: 1
			origin.x: 250
			origin.y: 60
			xScale: scale
			yScale: scale
		}

		SequentialAnimation {
			id: bonusAnimation
			loops: 3
			PropertyAnimation {
				target: stationScale
				property: "scale"
				from: 1.0
				to: 1.3
				duration:500
			}
			PropertyAnimation {
				target: stationScale
				property: "scale"
				from: 1.3
				to: 1.0
				duration: 500
			}
			onStopped: Railroad.newGame()
		}
	}

	//All trains
	property var trains: []
	//The train to copy
	property var newTrain: []

	//Depot
	Rectangle  {
		id: depot
		visible: ! demoStation.visible
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

	Audio {
		id: trainSound
		source: "assets/sounds/train.wav"
	}

	Audio {
		id: addSound
		source: "assets/sounds/bleep.wav"
	}

	Audio {
		id: removeSound
		source: "assets/sounds/smudge.wav"
	}

	Audio {
		id: bonusSound
		source: "assets/sounds/bonus.wav"
	}

	focus: true
	Keys.onPressed: Railroad.keypress(event)

	Component.onCompleted: Railroad.initGame();
}
