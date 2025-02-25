@tool
class_name VTileMap
extends Node2D

@export var tile_set: TileSet
@export var x_axis := Vector2i(1, 0) : set = _set_x_axis
@export var y_axis := Vector2i(0, 1) : set = _set_y_axis

@export_group("Data")
@export var cells: Array[VTileMapCell]



# drawing

func _draw() -> void:
	draw_set_transform(Vector2i(y_axis.x + x_axis.x, y_axis.y - x_axis.y) / -2)
	for cell: VTileMapCell in cells:
		var source: TileSetAtlasSource = tile_set.get_source(cell.source_id)
		draw_texture_rect_region(
			source.texture,
			Rect2(map_to_local(cell.coords), source.texture_region_size),
			Rect2(cell.tile_id * source.texture_region_size, source.texture_region_size)
		)



# cell

func set_cell(coords: Vector2i, source_id: int, tile_id: Vector2i) -> void:
	var cell := VTileMapCell.new()
	cell.coords = coords
	cell.source_id = source_id
	cell.tile_id = tile_id
	
	var idx: int = bsearch_coords(coords)
	if idx < cells.size() and cells[idx].coords == coords:
		cells[idx] = cell
	else:
		cells.insert(idx, cell)
	
	queue_redraw()


func clear_cell(coords: Vector2i) -> void:
	var idx: int = bsearch_coords(coords)
	if idx < cells.size() and cells[idx].coords == coords:
		cells.remove_at(idx)
		queue_redraw()


func get_cell(coords: Vector2i) -> VTileMapCell:
	var idx: int = bsearch_coords(coords)
	if idx < cells.size() and cells[idx].coords == coords:
		return cells[idx]
	return null



# coord

func local_to_map(point: Vector2) -> Vector2i:
	var coords: Vector2
	coords.x = (y_axis.x * point.y - y_axis.y * point.x) / (y_axis.x * x_axis.y - y_axis.y * x_axis.x)
	coords.y = (point.x - coords.x * x_axis.x) / y_axis.x
	return coords.round()


func map_to_local(coords: Vector2i) -> Vector2:
	return coords.x * x_axis + coords.y * y_axis


func bsearch_coords(coords: Vector2i) -> int:
	return cells.map(func(cell: VTileMapCell) -> Vector2i: return cell.coords).bsearch_custom(coords, _coord_sort, true)


func _coord_sort(a: Vector2i, b: Vector2i) -> bool:
	return a.y < b.y or a.y == b.y and a.x > b.x



# setter

func _set_x_axis(value: Vector2i) -> void:
	x_axis = value
	queue_redraw()


func _set_y_axis(value: Vector2i) -> void:
	y_axis = value
	queue_redraw()
