import QtQuick 2.0
import QtMultimedia 5.0

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

	//Check whether the currently built train matches the original
	function checkMatch() {
		if (station.children.length != newTrain.length)
			return

		for (var i = 0; i < newTrain.length; i++ ) {
			if (newTrain[i] != station.children[i].name)
				return
		}

		//if we get here, the guess was correct
		bonusSound.play()
		difficulty++
		newGameTimer.start()
	}

	//Add a new wagon/locomotive to the station at the front of the current train
	function addToStation(img) {
		var component = Qt.createComponent("Train.qml")
		var object = component.createObject(station, {
					name : img
		})
		object.anchors.bottom = station.bottom
		object.clicked.connect(function() {object.parent = null; object.destroy();checkMatch()})
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
						addToStation(trains[index])
						checkMatch()
				}
				x: (index % 5) * 230 + 30
				y: parent.height/5 * (Math.floor(index/5) + 1) - height
			}
		}
	}

	function getRandomTrain(wagons) {
		if (wagons == undefined) {
			wagons = 1
		}
		newTrain = []
		for (var i=0;i<wagons;i++) {
			var nw = Math.floor(Math.random()*nWag)
			newTrain.push("wagon%1.png".arg(nw+1))
		}
		var nl = Math.floor(Math.random()*nLoco)
		newTrain.push("loco%1.png".arg(nl+1))
	}

	function showTrain() {
		getRandomTrain(difficulty)
		for(var i=0;i<newTrain.length;i++) {
			addToStation(newTrain[i])
		}
	}

	//Reinitialize game state
	function newGame() {
		station.children = null
		showTrain()
		startGameTimer.start()
		trainSound.play()
	}

	//Start constructing a train similar to the one shown
	function startGame() {
		station.children = null
		depot.visible = true
	}

	//One time game initialization
	function initGame() {
		trains = initTrains()
		newGame()
	}

	function initTrains() {
		var t = []
		for(var i=0;i<nLoco;i++) {
			t.push("loco%1.png".arg(i+1))
		}
		for(var i=0;i<nWag;i++) {
			t.push("wagon%1.png".arg(i+1))
		}
		return t
	}

	Timer {
		id: startGameTimer
		interval: 6000
		onTriggered: startGame()
	}

	Timer {
		id: newGameTimer
		interval: 3000
		onTriggered: newGame()
	}

	Audio {
		id: trainSound
		source: "assets/sounds/train.wav"
	}

	Audio {
		id: bonusSound
		source: "assets/sounds/bonus.wav"
	}

	Component.onCompleted: initGame();
}
