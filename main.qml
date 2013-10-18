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

	//Check whether the currently built train matches the original
	function checkMatch() {
		if (station.children.length != newTrain.length)
			return false;

		for (var i = 0; i < newTrain.length; i++ ) {
			if (newTrain[i] != station.children[i].name)
				return false
		}
		return true
	}

	function addToStation(img) {
		var component = Qt.createComponent("Train.qml");
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
		var t = []
		for (var i=0;i<wagons;i++) {
			var nw = Math.floor(Math.random()*nWag)
			t.push("wagon%1.png".arg(nw+1))
		}
		var nl = Math.floor(Math.random()*nLoco)
		t.push("loco%1.png".arg(nl+1))
		return t
	}

	function showTrain() {
		newTrain = getRandomTrain(2)
		for(var i=0;i<newTrain.length;i++) {
			addToStation(newTrain[i]);
		}
	}

	function newGame() {
		trains = initTrains()
		showTrain();
		timer.start()
		trainSound.play()
	}

	function startGame() {
		depot.visible = true
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
		id: timer
		interval: 3000
		onTriggered: startGame()
	}

	Audio {
		id: trainSound
		source: "assets/sounds/train.wav"
	}

	Component.onCompleted: newGame()
}
