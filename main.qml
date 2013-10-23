import QtQuick 2.0
import QtMultimedia 5.0
import "railroad.js" as Railroad

Rectangle {

	//Total number of locomotives and wagons.
	//TODO: autodetect by looking into assets folder, so it can be easily customized
	property int nLoco: 9
	property int nWag:13

	//Number of wagons in current train
	property int difficulty: 1

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
		interval: 6000
		onTriggered: Railroad.startGame()
	}

	Timer {
		id: newGameTimer
		interval: 3000
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

	Component.onCompleted: Railroad.initGame();
}
