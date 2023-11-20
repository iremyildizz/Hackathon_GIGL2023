extends Node2D

func placeFirstClientInLine() -> void:
	$YSort/WatingLine.popClientFromQueue()
