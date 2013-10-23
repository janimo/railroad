// Most of the game logic is here

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

