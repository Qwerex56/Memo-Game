extends Node2D
class_name Main_Scene

func _process(_delta):
	var time_left = get_node("%TimeLeft")
	#warning-ignore:INTEGER_DIVISION
	var minutes : int = int(time_left.time_left) / 60
	var seconds : int = int(time_left.time_left) % 60
	get_node("GUI/Navigation/GameStatus/TimeLeft/Label").text = str(minutes) + " : " + str(seconds)
	pass

func ResetGrid():
	var grid = get_node("%Grid")
	grid.ClearGrid()
	get_node("%TimeLeft").start()
	grid.tiles = grid.GenerateGrid()
	get_node("GUI/Navigation/GameStatus/PairsCollected/Label").text = "0 / 8" 
	pass

func PauseGame():
	print("Game Paused")
	pass

func _on_Navigation_ResetGrid():
	ResetGrid()
	pass

func _on_Navigation_PauseGame():
	PauseGame()
	pass

func _on_Grid_EndGame(hasWon : bool):
	if hasWon:
		return
	PauseGame()
	pass

func _on_Grid_PairConnected(count : int):
	get_node("GUI/Navigation/GameStatus/PairsCollected/Label").text = str(count) + " / 8" 
	pass
