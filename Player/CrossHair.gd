@tool
extends Control

const START_LINE = 16
const FINISH_LINE = 24
const COLOR_LINE = Color.WHITE
const THICKNESS_LINE = 2
const CIRCLE_OUTLINE_COLOR = Color.DIM_GRAY
const CIRCLE_OUTLINE_THICKNESS = 4
const CENTER_DOT_THICKNESS = 2

func _draw() -> void:
	# circle outline
	draw_circle(Vector2.ZERO, CIRCLE_OUTLINE_THICKNESS, CIRCLE_OUTLINE_COLOR)
	
	# circle center
	draw_circle(Vector2.ZERO, CENTER_DOT_THICKNESS, COLOR_LINE)
	
	# line right
	draw_line(Vector2(START_LINE, 0), Vector2(FINISH_LINE, 0), COLOR_LINE, THICKNESS_LINE)
	
	# left line
	draw_line(Vector2(-FINISH_LINE, 0), Vector2(-START_LINE, 0), COLOR_LINE, THICKNESS_LINE)
	
	# bottom line
	draw_line(Vector2(0, START_LINE), Vector2(0, FINISH_LINE), COLOR_LINE, THICKNESS_LINE)
	
	# top line
	draw_line(Vector2(0, -START_LINE), Vector2(0, -FINISH_LINE), COLOR_LINE, THICKNESS_LINE)
	
