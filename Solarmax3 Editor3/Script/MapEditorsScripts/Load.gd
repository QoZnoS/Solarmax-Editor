class_name Load
# 建议预加载项与主体分离
# UI，天体，各种控件也尽量都与主编辑器分离，MapEditor只作为启动以及管理中心
const starTexturePath : String = "res://Textures/StarTexture"

# 未来要修改文件夹, 增加在Texture增加文件夹BetaVersion1、3(测试版1、3)
# 现在的纹理会被放入BetaVersion1(测试版1)
static func init_star_pattern_dictionary(path:String = starTexturePath) -> Dictionary:
	var dictionary_result : Dictionary = {}
	var directory = DirAccess.open(path) # 新建 DirAccess 对象并打开文件系统中的某个现存目录
	
	# directory如果返回的是null, 也就是打开失败了
	if directory == null:
		# 正式上来时，要告知用户缺少文件
		assert(false, "无法打开目录: " + path)# 如果无法打开，强制停止项目
		return dictionary_result
	
	# 初始化用于通过get_next()函数
	# “流”是什么: 把读一点处理一点(以及相反的生成一点, 写入一点)的数据类型(或曰操作)抽象出来, 就是流
	# 流就是读一点数据, 处理一点点数据
	directory.list_dir_begin()# 开始访问文件夹的流
	var file_name : String = directory.get_next()# 获得文件名
	while file_name != "":
		# 跳过 "."(当前目录) 和 ".."(上级目录) 目录(虽然好像没遇到)
		# 另外，该判断可以实现隐藏文件
		if file_name == "." or file_name == "..":
			file_name = directory.get_next()
			continue
		# 访问非星球纹理和星球文件夹
		var full_path = path.path_join(file_name) # 获得完整路径
		if directory.current_is_dir(): # 判断正在访问的这个东西是不是文件夹
			var get_planets : Dictionary = init_star_pattern_dictionary(full_path) # 递归子文件夹
			dictionary_result.merge(get_planets) # 添加星球
		else:
			if full_path.right(7) != ".import":# 不加载引擎内自己添加的.import文件
				var star_texture = ResourceLoader.load(full_path)# 获得天体纹理
				if star_texture != null : # ResourceLoader.load()方法访问失败会返回null
					var star_texture_name = file_name.left(-4) # 获得天体贴图名称
					dictionary_result[star_texture_name] = star_texture
		file_name = directory.get_next()
	directory.list_dir_end()# 结束访问文件夹的流
	
	return dictionary_result
