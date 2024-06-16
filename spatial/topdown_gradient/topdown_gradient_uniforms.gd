extends Node

# Note: This script isn't very good really, I wouldn't use it LOL. Just adjust gradient height
# manually on the shader's parameters.

# This script is designed to work in conjunction with a same or child MeshInstance3D node
# With 3D_topdown_gradient shader applied.
# It will send uniform information about the mesh, to said shader.

var mesh_material;

var top_mesh_extreme_vertex_height : float = 0.0
var bottom_mesh_extreme_vertex_height : float = 0.0

func _ready():
	#Find the mesh as either self (attatched to) or children
	var nd = get_node(".")
	if nd is MeshInstance3D:
		process_vertices(nd)
		mesh_material = nd.get_active_material(0)
	else:
		for child in get_children():
			if child is MeshInstance3D:
				process_vertices(child)
				mesh_material = child.get_active_material(0)
				break
	assign_uniforms()

func process_vertices(nd):
	var m = nd.get_mesh()
	for i in range(m.get_surface_count()):
		var mdt = MeshDataTool.new()
		mdt.create_from_surface(m, i)
		for vtx in range(mdt.get_vertex_count()):
			var vert = mdt.get_vertex(vtx)
			if vert.y > top_mesh_extreme_vertex_height:
				top_mesh_extreme_vertex_height = vert.y
			elif vert.y < bottom_mesh_extreme_vertex_height:
				bottom_mesh_extreme_vertex_height = vert.y
			#print("global vertex: " + str(vert)) #local coords

func assign_uniforms():
	mesh_material.set_shader_parameter("top_mesh_extreme_vertex_height", top_mesh_extreme_vertex_height)
	mesh_material.set_shader_parameter("bottom_mesh_extreme_vertex_height", bottom_mesh_extreme_vertex_height)
