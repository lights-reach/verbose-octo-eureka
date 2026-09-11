extends CanvasLayer

@onready var anim: AnimationPlayer = $anim
var changing_scenes = false

func change_scenes(new_scene: String):
	if changing_scenes == false:
		changing_scenes = true
		print("mumbo")
		anim.play("Fade in")
		await get_tree().create_timer(0.5).timeout
		changing_scenes = false
		get_tree().change_scene_to_file(new_scene)
		anim.play("Fade out")
