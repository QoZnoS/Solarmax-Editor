extends Node

var shared_date : Resource

# 编辑器基本信息
# 交流变量
#阵营
var defined_camp_ids : Array[int]
var camp_colors : Dictionary
# 天体贴图字典
var star_pattern_dictionary : Dictionary
var stars : Array[Star]
# 轨道类型
var orbit_types : Dictionary

var chosen_star : MapNodeStar = MapNodeStar.new()
var is_star_chosen : bool = false# 用于未来判断是否有天体被选择

var star_fleets : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	Mapeditor1ShareData.editor_data_updated.connect(_on_global_data_updated)
	Mapeditor1ShareData.init_editor_data()
	
	# 初始化变量
	# 加载编辑器基本信息
	#check_initalisation()
	
	# 处理变量
	
	
	# 初始化创建天体UI
	#$StarEditUIOpenButton.visible = false
	#$UI/CreateUI.visible = true
	#if is_star_chosen == false:
		#$UI/CreateUI/StarInformation/SetStarShipButton.disabled = true
	#$UI/CreateUI/StarInformation/CamptionInputLabel/StarCampInput.text = "0"
	#$UI/CreateUI/StarInformation/CamptionInputLabel/StarCampInputOptionButton.clear()


func _on_global_data_updated(key : String):
	match key:
		"defined_camp_ids":
			defined_camp_ids = Mapeditor1ShareData.defined_camp_ids
		"camp_colors":
			camp_colors = Mapeditor1ShareData.camp_colors
		"star_pattern_dictionary":
			star_pattern_dictionary = Mapeditor1ShareData.star_pattern_dictionary
		"stars":
			stars = Mapeditor1ShareData.stars
		"orbit_types":
			orbit_types = Mapeditor1ShareData.orbit_types
		"all_basic_information":
			defined_camp_ids = Mapeditor1ShareData.defined_camp_ids
			camp_colors = Mapeditor1ShareData.camp_colors
			star_pattern_dictionary = Mapeditor1ShareData.star_pattern_dictionary
			stars = Mapeditor1ShareData.stars
			orbit_types = Mapeditor1ShareData.orbit_types
		"chosen_star", "is_star_chosen", "star_fleets":
			pass
		_:
			push_error("数据更新出错，请检查要提交的内容名是否正确")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_pressed("up"):
		#$Camera.position -= Vector2(0, 100) * delta
	#if Input.is_action_pressed("down"):
		#$Camera.position += Vector2(0, 100) * delta
	#if Input.is_action_pressed("left"):
		#$Camera.position -= Vector2(100, 0) * delta
	#if Input.is_action_pressed("right"):
		#$Camera.position += Vector2(100, 0) * delta


func initialize_ui():
	$UI/StarEditUI.star_pattern_dictionary = star_pattern_dictionary
	$UI/StarEditUI.defined_camp_ids = defined_camp_ids
	$UI/StarEditUI.camp_colors = camp_colors
	$UI/StarEditUI.stars = stars
	$UI/StarEditUI.orbit_types = orbit_types

func check_initalisation():
	if star_pattern_dictionary == {}:
		push_error("初始化天体贴图数据失败，请检查天体贴图文件夹是否存在")
	if defined_camp_ids == null:
		push_error("初始化天体阵营数据失败，
				请检查编辑器基本信息文件(res://GameInformation/MapEditor1BasicInformation.json)是否有问题")
	if camp_colors == null:
		push_error("初始化阵营颜色数据失败，
				请检查编辑器基本信息文件(res://GameInformation/MapEditor1BasicInformation.json)是否有问题")
	#if stars == null:
		#assert(false, "初始化天体数据失败，
				#请检查编辑器基本信息文件(res://GameInformation/MapEditor1BasicInformation.json)是否有问题")
		# 应当弹出警告窗


func _on_star_edit_ui_open_button_button_up():
	$StarEditUIOpenButton.visible = false
	$UI/StarEditUI.visible = true


func _on_export_button_button_up():
	pass # Replace with function body.
