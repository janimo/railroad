// Most of the game logic is here

//Total number of locomotives and wagons.
//TODO: autodetect by looking into assets folder, so it can be easily customized
var nLoco = 9
var nWag = 13

//Number of wagons in current train
var difficulty = 1

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
function showTrain() {
	getRandomTrain(difficulty)
	for(var i=0;i<newTrain.length;i++) {
		addToStation(newTrain[i])
	}
}

//Reinitialize game state
function newGame() {
	station.children = null
	depot.visible = false
	showTrain()
	startGameTimer.start()
	trainSound.play()
}

//Start constructing a train similar to the one shown
function startGame() {
	station.children = null
	station.x = 0
	depot.visible = true
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

