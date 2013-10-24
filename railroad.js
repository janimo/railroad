// Most of the game logic is here

//Total number of locomotives and wagons.
//TODO: autodetect by looking into assets folder, so it can be easily customized
var nLoco = 9
var nWag = 13

//Number of wagons in current train
var difficulty = 1

//The train to copy
var newTrain = []

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
	bonusAnimation.start()
	difficulty++
}

//Add a new wagon/locomotive to the station at the front of the current train
function addToDemoStation(img) {
	var component = Qt.createComponent("Train.qml")
	var object = component.createObject(demoStation, {
				name : img
	})
	object.anchors.bottom = demoStation.bottom
}

//Add a new wagon/locomotive to the station at the front of the current train
function addToStation(img) {
	var component = Qt.createComponent("Train.qml")
	var object = component.createObject(station, {
				name : img
	})
	object.anchors.bottom = station.bottom
	object.clicked.connect(function() {object.parent = null; object.destroy();removeSound.play();checkMatch()})
	addSound.play()
}

//Create a new train consisting of a locomotive and a given number of wagons randomly
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

//Show a new train in the station
function createTrain() {
	getRandomTrain(difficulty)
	demoStation.children = null
	for(var i=0;i<newTrain.length;i++) {
		addToDemoStation(newTrain[i])
	}
}

function animateTrain() {
	demoStation.x = 0
	demoStation.visible = true
	startGameTimer.start()
	trainSound.play()
}

//Reinitialize game state
function newGame() {
	station.children = null
	createTrain()
	animateTrain()
}

//Start constructing a train similar to the one shown
function guessTrain() {
	demoStation.visible = false
}

//One time game initialization
function initGame() {
	trains = initTrains()
	newGame()
}

//Init the array of locomotive and wagon names
//TODO: init depot dynamically
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

function keypress(event) {
	if (event.key == Qt.Key_Q) Qt.quit();
}
