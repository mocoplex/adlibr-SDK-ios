--====================================
-- file : _TriDCommon.lua
-- author : ulralra
-- date : 2009-09-02
-- description : common utilities for configuration works.
--	consult ParamSet.cpp and ScriptManager.cpp to know about
--	what the leftmost charactor of each table means
--	support for lua 5.2.0
-- Tri-d communications, Co., Ltd.
--====================================

-- support for lua 5.1.x
unpack = function (t)
	return table.unpack(t)
end

loadstring = function (str)
	return load(str)
end


TRID = {}

MODE_DEBUG_INTERNAL = true

MODE_DEBUG = false
MODE_ASSERT = false
DEBUG_FILE = ""
PROTECT_CLASS = true
__TEMP_TIMER_INDEX = 1
PRINT_DB = false

--====================================
-- Constants
--====================================
TRID.VERSION	= 1119 -- 2012.09.13
TRID.EPSILON	= 0.001
TRID.PI		= 3.1415926
TRID.PI_2		= 1.5707963
TRID.RAD2ANG	= 57.29578049   -- FLOAT(180.f/PI)
TRID.ANG2RAD	= 0.017453292   -- FLOAT(PI/180.f);
TRID.RadianToDegree = function (radian)
	return radian * TRID.RAD2ANG
end
TRID.Degree2Radian = function (degree)
	return degree * TRID.ANG2RAD
end
TRID.IDENTITY_MAT = {1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1}
TRID.DEFAULT_DELIMITER = " "
TRID.HUGE_NUMBER = 1000000

-- [result code]
-- these values are shared with ClientResult.h
TRID.RESULT_OK				= 1
TRID.RESULT_FAIL			= 10000
TRID.RESULT_NOT_FOUND		= 10001
TRID.RESULT_ALREADY_EXIST	= 10002
TRID.RESULT_ALREADY_DONE		= 10005
TRID.RESULT_GRAPHIC_FULL		= 141073

-- [[logic object type]]
-- these values are shared with logicframework
-- using in TRIDGLUE.CreateLogicObject.
TRID.LOGIC_OBJECT_DEFAULT	= 0
TRID.LOGIC_OBJECT_3D		= 1
TRID.LOGIC_OBJECT_SPACE		= 2
TRID.LOGIC_OBJECT_CAMERA		= 3

-- [[ BaseController Mode ]]
-- these values are shared with BaseController.h
TRID.CONTROL_ROTATE_EYE		= 0
TRID.CONTROL_ROTATE_TARGET	= 1
TRID.CONTROL_ROTATE_OBJECT	= 2
TRID.CONTROL_ROTATE_SMOOTH	= 4
TRID.CONTROL_AUTO_ZOOM_TARGET= 8
TRID.CONTROL_USE_LOCAL_PAN_RANGE= 16

-- [[clear mode]]
-- these values are shared with GraphicAPI.h
TRID.CLEAR_COLOR = 1
TRID.CLEAR_DEPTH = 2
TRID.CLEAR_ALL	= 255

-- [[ set contents time mode ]]
-- these values are shared with GraphicScriptManagerInitializer.cpp
TRID.CONTENTS_TIME_APPLY_MOTION = 1
TRID.CONTENTS_TIME_APPLY_ANIMATION = 2

-- [[FOID]]
-- these values are shared with each FOIDs.h
-- if you add new GUI FOID, you must add it to TRID.IsGUI
TRID.FOID_NULL				= 0
TRID.FOID_CHILD_NAMEMAP		= 1 
TRID.FOID_DATA_STORAGE		= 2 
TRID.FOID_NODE				= 3
TRID.FOID_NOTIFIER_SET		= 4
TRID.FOID_TRANSLATOR		= 5 
TRID.FOID_TAG				= 6
TRID.FOID_POSITION			= 65537 
TRID.FOID_BOUNDING_INTERFACE	= 65538 
TRID.FOID_BOUNDING_NODE		= 65539
TRID.FOID_BOUNDING_SPHERE	= 65540
TRID.FOID_BOUNDING_BOX		= 65541 
TRID.FOID_BLOCK_OBJECT		= 65542
TRID.FOID_GRAPHIC_NODE		= 65543
TRID.FOID_RENDER			= 65544
TRID.FOID_RENDER_2D			= 65545
TRID.FOID_RENDER_3D			= 65546
TRID.FOID_RENDER_RESOURCE	= 65547
TRID.FOID_ENVMAP_MANAGER	= 65548
TRID.FOID_SHADOWMAP_MANAGER	= 65549
TRID.FOID_BOUNDING_SET		= 65550
TRID.FOID_3D_OBJECT			= 65551
TRID.FOID_FRAME			= 65552
TRID.FOID_FRAME_BASE		= 65553
TRID.FOID_GRAPHIC_OBJECT		= 65554
TRID.FOID_GUI_OBJECT			= 65555
TRID.FOID_VIEW				= 65556
TRID.FOID_3D_CAMERA			= 65557
TRID.FOID_3D_LIGHT			= 65558
TRID.FOID_WINDOW			= 65559
TRID.FOID_SUBWINDOW		= 65560
TRID.FOID_MOVE_HEADER		= 65561
TRID.FOID_LIST_BOX			= 65562
TRID.FOID_FOG_OBJECT		= 65563
TRID.FOID_SCROLL_BAR		= 65564
TRID.FOID_BUTTON			= 65565
TRID.FOID_TAB_HEADER		= 65566
TRID.FOID_EDIT_BOX			= 65567
TRID.FOID_RENDER_REDIRECT	= 65568
TRID.FOID_RENDER_LINE		= 65569
TRID.FOID_RENDER_GRID		= 65570		
TRID.FOID_SCRIPTLOADER		= 65571
TRID.FOID_RENDER_TERRAIN		= 65572
TRID.FOID_BONE_BOX			= 65573
TRID.FOID_POST_EFFECTOR		= 65574
TRID.FOID_FLASH_CONTROL		= 65575
TRID.FOID_VIDEO				= 65576
TRID.FOID_X3D_CONTROL		= 65577
TRID.FOID_ANIMATION_PLAYER	= 65578
TRID.FOID_RENDER_CUBEMAP		= 65579
TRID.FOID_PROJECTION_SHADOW	= 65580
TRID.FOID_TERRAIN_OBJECT		= 65581
TRID.FOID_BILLBOARDSET             = 65583
TRID.FOID_PARTICLE_SYSTEM        = 65584
TRID.FOID_MOUSE_INPUT_GENERATOR	= 65585
TRID.FOID_ANIMATION_FRAME_CONTROL	= 65586
TRID.FOID_SHADER_VARIABLE_CONTROL	= 65587
TRID.FOID_BONE_CUSTOMIZING_CONTROL= 65588
TRID.FOID_MOTION_CONTROL		= 65589
TRID.FOID_LENSFLARE                          = 65590
TRID.FOID_BOUNDING_INTERFACE_CONTROL = 65591
TRID.FOID_CAMERA_PROPERTY_CONTROL = 65592
TRID.FOID_LIGHT_PROPERTY_CONTROL = 65593
TRID.FOID_LOGIC_NODE		= 131074

TRID.IsGUI = function (FOID)
	if FOID == TRID.FOID_GUI_OBJECT 
	or FOID == TRID.FOID_BUTTON 
	or FOID == TRID.FOID_FRAME
	or FOID == TRID.FOID_FRAME_BASE
	or FOID == TRID.FOID_VIEW
	or FOID == TRID.FOID_EDIT_BOX
	or FOID == TRID.FOID_LIST_BOX
	or FOID == TRID.FOID_SCROLL_BAR	
	or FOID == TRID.FOID_WINDOW
	or FOID == TRID.FOID_SUBWINDOW
	or FOID == TRID.FOID_TAB_HEADER then
		return true
	else
		return false
	end
end

-- [[Graphic Node Flag]]
-- these values are shared with GraphicNodeObject.h
TRID.FLAG_NOT_RENDER		= 1
TRID.FLAG_NOT_PICKUP		= 32
TRID.FLAG_NOT_COLLISION		= 64
TRID.FLAG_NOT_CULLING		= 128
TRID.FLAG_HIDE_BUT_PICKUP		= 193
TRID.FLAG_HIDE				= 225
TRID.FLAG_CHECK_COLLISION_NOT_PROCESS_HORIZONTAL	= 1024
TRID.FLAG_CHECK_COLLISION_NOT_PROCESS_VERTICAL	= 2048
TRID.FLAG_CAMERA_COLLISION	= 4096
TRID.FLAG_ONLY_CHECK_MY_AREA	= 8192
TRID.FLAG_ONLY_RUN_ON_ATTACHED = 16384

-- [[Key Input]]
-- these values are shared with windows.h
TRID.VK_ADD		= 107
TRID.VK_SUBTRACT	= 109
TRID.VK_SHIFT		= 16
TRID.VK_CONTROL	= 17
TRID.VK_MENU		= 18
TRID.VK_ESCAPE		= 27
TRID.VK_DELETE		= 46
TRID.VK_WHEEL		= 65535
TRID.VK_LBUTTON	= 1
TRID.VK_RBUTTON	= 2
TRID.VK_MBUTTON	= 4
TRID.VK_MENU		= 18
TRID.VK_LEFT        	= 37
TRID.VK_UP          	= 38
TRID.VK_RIGHT       	= 39
TRID.VK_DOWN        	= 40
TRID.VK_RETURN      	= 13
TRID.VK_BACK		= 8
TRID.VK_TAB		= 9
TRID.VK_SPACE		= 32
TRID.VK_0			= 48
TRID.VK_1			= 49
TRID.VK_2			= 50
TRID.VK_3			= 51
TRID.VK_4			= 52
TRID.VK_5			= 53
TRID.VK_6			= 54
TRID.VK_7			= 55
TRID.VK_8			= 56
TRID.VK_9			= 57
TRID.VK_A			= 65
TRID.VK_B			= 66
TRID.VK_C			= 67
TRID.VK_D			= 68
TRID.VK_E			= 69
TRID.VK_F			= 70
TRID.VK_G			= 71
TRID.VK_H			= 72
TRID.VK_I			= 73
TRID.VK_J			= 74
TRID.VK_K			= 75
TRID.VK_L			= 76
TRID.VK_M			= 77
TRID.VK_N			= 78
TRID.VK_O			= 79
TRID.VK_P			= 80
TRID.VK_Q			= 81
TRID.VK_R			= 82
TRID.VK_S			= 83
TRID.VK_T			= 84
TRID.VK_U			= 85
TRID.VK_V			= 86
TRID.VK_W			= 87
TRID.VK_X			= 88
TRID.VK_Y			= 89
TRID.VK_Z			= 90

-- [[Animation Slots]]
-- these values are shared with AniInfo.h
TRID.ANISLOT_NONE		= 0
TRID.ANISLOT_BODY		= 1
TRID.ANISLOT_DOWN		= 2
TRID.ANISLOT_UP		= 3
TRID.ANISLOT_HEAD		= 4
TRID.ANISLOT_ARMS		= 5
TRID.ANISLOT_HANDS		= 6
TRID.ANISLOT_LEFTHAND	= 7
TRID.ANISLOT_RIGHTHAND	= 8

-- [[Modeling Slots]]
-- if you modify this index order, you must modify several dress scripts.
TRID.MODELSLOT_NONE	= 0
TRID.MODELSLOT_LEG08	= 1
TRID.MODELSLOT_LEG07	= 2
TRID.MODELSLOT_LEG06	= 3
TRID.MODELSLOT_LEG05	= 4
TRID.MODELSLOT_LEG04	= 5
TRID.MODELSLOT_LEG03	= 6
TRID.MODELSLOT_LEG02	= 7
TRID.MODELSLOT_LEG01	= 8
TRID.MODELSLOT_BODY10	= 9
TRID.MODELSLOT_BODY09	= 10
TRID.MODELSLOT_BODY08	= 11
TRID.MODELSLOT_BODY07	= 12
TRID.MODELSLOT_BODY06	= 13
TRID.MODELSLOT_BODY05	= 14
TRID.MODELSLOT_BODY04	= 15
TRID.MODELSLOT_BODY03	= 16
TRID.MODELSLOT_BODY02	= 17
TRID.MODELSLOT_BODY01	= 18
TRID.MODELSLOT_ARM04	= 19
TRID.MODELSLOT_ARM03	= 20
TRID.MODELSLOT_ARM02	= 21
TRID.MODELSLOT_ARM01	= 22
TRID.MODELSLOT_HEAD02	= 23
TRID.MODELSLOT_HEAD01	= 24
-- if you add new slot, you must modify the following index
TRID.MODELSLOT_SKIN_START = 1
TRID.MODELSLOT_SKIN_END = 24
-- currently this slot is used only metaverse project
TRID.MODELSLOT_FOOT	= 51
TRID.MODELSLOT_DOWN	= 52
TRID.MODELSLOT_UP		= 53
TRID.MODELSLOT_OUT		= 54
TRID.MODELSLOT_HAIR		= 55
TRID.MODELSLOT_EARINGS	= 56
TRID.MODELSLOT_GLASSES	= 57
TRID.MODELSLOT_NECKLACE	= 58
TRID.MODELSLOT_BRACELET	= 59
TRID.MODELSLOT_BELT		= 60
TRID.MODELSLOT_OPA_DRESS= 61

-- if you add new slot, you must modify the following index
TRID.MODELSLOT_DRESS_START = 51
TRID.MODELSLOT_DRESS_END = 61

--[[Fog mode]]
-- these values are shared with FogType.h
TRID.FOG_MODE_NONE	= 0
TRID.FOG_MODE_EXP	= 1
TRID.FOG_MODE_EXP2	= 2

-- [[Font Style]]
-- these values are shared with GraphicTypes.h
TRID.FONT_BOLD		= 1
TRID.FONT_UNDERLINE	= 2
TRID.FONT_STRIKEOUT	= 4

-- [[MessageBox Type]]
-- these values are shared with GraphicScriptManagerInitializer.cpp
TRID.MESSAGEBOX_TYPE_OK      = 0
TRID.MESSAGEBOX_TYPE_YESNO = 1

-- [[Message IDs]]
-- these values are shared with some ***MessageIDs.h
TRID.MSG_FLAG_CHANGED = 196613
TRID.MSG_DELETE = 196617
TRID.MSG_CHILD_ADDED = 196620
TRID.MSG_CHILD_REMOVED = 196621

TRID.MSG_CHANGE_MAT = 262150
TRID.MSG_START_MOVING = 262180
TRID.MSG_MOVING = 262181
TRID.MSG_END_MOVING = 262182
TRID.MSG_COLLISION_TO_TARGET = 262183
TRID.MSG_BOUNDING_AREA_CHANGED = 262188
TRID.MSG_ANIMATION_FINISHED = 262193
TRID.MSG_LISTBOX_ITEM_SELECTED = 262197
TRID.MSG_LISTBOX_ITEM_DESELECTED = 262198
TRID.MSG_LISTBOX_ITEM_ENTERED = 262199
TRID.MSG_LISTBOX_ITEM_LEFT = 262200
TRID.MSG_LISTBOX_ITEM_CLICKED = 262201
TRID.MSG_LISTBOX_ITEM_DBCLICKED = 262202
TRID.MSG_SET_VIEWPORT_ORIGIN = 262207
TRID.MSG_FOCUSED = 262208
TRID.MSG_UNFOCUSED = 262209
TRID.MSG_EDITBOX_SUBMITTED = 262212
TRID.MSG_CHANGE_CONTENTS_VIEWPORT = 262218
TRID.MSG_GENERATE_LIGHTMAP = 262219
TRID.MSG_3D_BOUNDING_AREA_CHANGED = 262224
TRID.MSG_SLIDER_MOVED = 262225
TRID.MSG_SCROLLBAR_MOVED = TRID.MSG_SLIDER_MOVED	-- same as TRID.MSG_SLIDER_MOVED
TRID.MSG_CONTROLLER_ENABLE = 262226
TRID.MSG_MOVE_SCROLLBAR = 262227
TRID.MSG_LISTBOX_CAN_SELECT_ITEM = 262228
TRID.MSG_LISTBOX_CAN_DESELECT_ITEM = 262229
TRID.MSG_END_CHANGING = 262231
TRID.MSG_COLLISION_TO_ME = 262233
TRID.MSG_SET_CUBEMAP = 262235
TRID.MSG_SELECTED = 262175
TRID.MSG_DESELECTED = 262176
TRID.MSG_NOTIFY_NOT_FOCUSED_AREA = 262237
TRID.MSG_RESOURCE_LOADED_IN_CURRENT_SCENE = 262238
TRID.MSG_START_CONTROL = 262241
TRID.MSG_ANIMATION_CURRENT_FRAME_CHANGED = 262244

TRID.MSG_LBUTTON_DOWN = 65537
TRID.MSG_LBUTTON_UP = 65538
TRID.MSG_LBUTTON_CLICK = 65539
TRID.MSG_LBUTTON_DBCLICK = 65540
TRID.MSG_RBUTTON_DOWN = 65541
TRID.MSG_RBUTTON_UP = 65542
TRID.MSG_RBUTTON_CLICK = 65543
TRID.MSG_RBUTTON_DBCLICK = 65544
TRID.MSG_MOUSE_MOVE = 65545
TRID.MSG_MOUSE_ENTER = 65546
TRID.MSG_MOUSE_LEAVE = 65547
TRID.MSG_WHEEL = 65548
TRID.MSG_DROP_FILES = 65558

TRID.MSG_KEY_DOWN = 131073
TRID.MSG_KEY_UP = 131074
TRID.MSG_KEY_CLICK = 131075

TRID.MSG_CONNECTION_OPENED	= 393217
TRID.MSG_CONNECTION_CLOSED	= 393218
TRID.MSG_RECV_PACKET		= 393220
TRID.MSG_RECV_STRING_PACKET	= 393221
TRID.MSG_SEND_PACKET_FAILED	= 393223
TRID.MSG_CHECK_CONNECTION	= 393226

TRID.MSG_TOUCHES_DOWN = 720897
TRID.MSG_TOUCHES_MOVE = 720898
TRID.MSG_TOUCHES_UP = 720899

-- [[Layout Flag]]
-- these values are shared with LayoutObject.h
TRID.LAYOUT_CENTER_X	= 1
TRID.LAYOUT_CENTER_Y	= 2
TRID.LAYOUT_FROMRIGHT	= 4
TRID.LAYOUT_FROMBOTTOM	= 8
TRID.LAYOUT_FILL_X		= 16
TRID.LAYOUT_FILL_Y		= 32
TRID.LAYOUT_IN_WINDOW	= 64
TRID.LAYOUT_IN_PARENT_X	= 128
TRID.LAYOUT_WRAP_CONTENT_X = 256
TRID.LAYOUT_WRAP_CONTENT_Y = 512
TRID.LAYOUT_REVERSE_X 	= 1024
TRID.LAYOUT_REVERSE_Y 	= 2048
TRID.LAYOUT_IN_PARENT_Y	= 4096
TRID.LAYOUT_IN_PARENT	= TRID.LAYOUT_IN_PARENT_X + TRID.LAYOUT_IN_PARENT_Y

TRID.LAYOUT_X_POSITION_MASK = TRID.LAYOUT_CENTER_X + TRID.LAYOUT_FROMRIGHT + TRID.LAYOUT_REVERSE_X
TRID.LAYOUT_Y_POSITION_MASK = TRID.LAYOUT_CENTER_Y + TRID.LAYOUT_FROMBOTTOM + TRID.LAYOUT_REVERSE_Y
TRID.LAYOUT_POSITION_MASK = TRID.LAYOUT_X_POSITION_MASK + TRID.LAYOUT_Y_POSITION_MASK
TRID.LAYOUT_X_SIZE_MASK = TRID.LAYOUT_FILL_X + TRID.LAYOUT_WRAP_CONTENT_X
TRID.LAYOUT_Y_SIZE_MASK = TRID.LAYOUT_FILL_Y + TRID.LAYOUT_WRAP_CONTENT_Y
TRID.LAYOUT_SIZE_MASK = TRID.LAYOUT_X_SIZE_MASK + TRID.LAYOUT_Y_SIZE_MASK

-- [[FindFile Mode]]
-- these values are shared with ClientFile.h
TRID.FIND_FILES = 1
TRID.FIND_DIRECTORIES = 2
TRID.FIND_SUBFOLDERS = 4

-- [[Material Bit]]
-- these values are shared with TextureMaterialTypes.h
TRID.MATERIAL_NONE			= 0
TRID.MATERIAL_DIFF_BIT		= 1
TRID.MATERIAL_SPECLEVEL_BIT	= 2
TRID.MATERIAL_OPA_BIT		= 4
TRID.MATERIAL_BUMP_BIT		= 8
TRID.MATERIAL_CUBE_BIT		= 16
TRID.MATERIAL_ENV_BIT		= 32
TRID.MATERIAL_GLOW_BIT		= 64
TRID.MATERIAL_LIGHT_BIT		= 128
TRID.MATERIAL_ENVLEVEL_BIT	= 256
TRID.MATERIAL_AMBI_BIT		= 512
TRID.MATERIAL_SHADER_BIT		= 1024
TRID.MATERIAL_MULTI_BIT		= 2048
TRID.MATERIAL_CUSTOM1_BIT	= 16384
TRID.MATERIAL_CUSTOM2_BIT	= 32768
TRID.MATERIAL_CUSTOM3_BIT	= 65536
TRID.MATERIAL_CUSTOM4_BIT	= 131072
TRID.MATERIAL_CUSTOM5_BIT	= 262144
TRID.MATERIAL_CUSTOM6_BIT	= 524288
TRID.MATERIAL_CUSTOM7_BIT	= 1048576
TRID.MATERIAL_CUSTOM8_BIT	= 2097152
TRID.MATERIAL_ALL_MASK		= 4294967295

-- [[Material Parameter Type]]
-- these values are shared with ShaderVarName.h
TRID.MATERIAL_PARAM_INT		= 0
TRID.MATERIAL_PARAM_FLOAT	= 1
TRID.MATERIAL_PARAM_BOOL	= 2
TRID.MATERIAL_PARAM_FLOAT3	= 3
TRID.MATERIAL_PARAM_FLOAT4	= 4
TRID.MATERIAL_PARAM_IMAGE	= 5
TRID.MATERIAL_PARAM_TEXTUREID = 6
TRID.MATERIAL_PARAM_MATRIX	= 7
TRID.MATERIAL_PARAM_FLOAT2	= 8

-- [[Default Shader Variable Index]]
-- these values are shared with ShaderVarName.h
TRID.VAR_WORLDMATARRAY      = 0
TRID.VAR_CAMERAPOS          = 1
TRID.VAR_VERTEXSHADERMODE   = 2
TRID.VAR_WORLDVIEWPROJ      = 3
TRID.VAR_LIGHTDIR           = 4
TRID.VAR_OBJECTLIGHTPOS     = 5
TRID.VAR_SHADOWMAPSIZE      = 6
TRID.VAR_LIGHTPROJ          = 7
TRID.VAR_LIGHTPROJBIAS      = 8
TRID.VAR_CAMPROJ            = 9
TRID.VAR_MAXBONE            = 10
TRID.VAR_MORPHRATIO         = 11
TRID.VAR_TOTALAMBIENT       = 12
TRID.VAR_TOTALDIFFUSE       = 13
TRID.VAR_TOTALSPECULAR      = 14
TRID.VAR_PIXELSHADERMODE    = 15
TRID.VAR_OFFSETLIGHTMAP     = 16
TRID.VAR_ADDRESSU           = 17
TRID.VAR_ADDRESSV           = 18
TRID.TEX_SHADOWTEXTURE      = 19
TRID.TEX_DEFAULTTEXTURE     = 20
TRID.TEX_ENVTEXTURE         = 21
TRID.TEX_ENVLEVELTEXTURE    = 22
TRID.TEX_SPECLEVELTEXTURE   = 23
TRID.TEX_BUMPTEXTURE        = 24
TRID.TEX_GLOWTEXTURE        = 25
TRID.TEX_LIGHTMAP           = 26
TRID.TEX_OPATEXTURE         = 27
TRID.VAR_GLOBAL_COLOR       = 28
TRID.VAR_LIGHTMAPINTENSITY = 39
TRID.TEX_CUSTOM1MAP = 83
TRID.TEX_CUSTOM2MAP = 84
TRID.TEX_CUSTOM3MAP = 85
TRID.TEX_CUSTOM4MAP = 86
TRID.TEX_CUSTOM5MAP = 87
TRID.TEX_CUSTOM6MAP = 88
TRID.TEX_CUSTOM7MAP = 89
TRID.TEX_CUSTOM8MAP = 90

-- [[ Engine Options ]]
TRID.GRAPHIC_OPTION_ALL_MIPMAP 	= 1
TRID.GRAPHIC_OPTION_ANISOTROPIC 	= 2

-- [[ ETC Options ]]
-- these values are shared with GraphicScriptManagerInitializer.cpp
TRID.ETC_OPTION_USE_KDTREE 	= 1

-- [[Texture Property]]
-- these values are shared with TextureMaterialTypes.h
TRID.TEXTURE_2D			= 0
TRID.TEXTURE_1D			= 1
TRID.TEXTURE_CUBE			= 2

TRID.TEXTURE_HASOPA		= 16
TRID.TEXTURE_MIPMAP			= 32
TRID.TEXTURE_CLAMPX			= 64
TRID.TEXTURE_CLAMPY			= 128
TRID.TEXTURE_NEARESTMIN		= 256
TRID.TEXTURE_NEARESTMAG		= 512
TRID.TEXTURE_TWOSIDE		= 1024
TRID.TEXTURE_BORDERX		= 2048
TRID.TEXTURE_BORDERY		= 4096
TRID.TEXTURE_HASLEVEL		= 8192
TRID.TEXTURE_HASALPHA		= 16384
TRID.TEXTURE_BUMPMAP		= 32768
TRID.TEXTURE_NOCOMPRESS     	= 65536
TRID.TEXTURE_NOSCALE		= 131072
TRID.TEXTURE_DYNAMIC		= 524288
TRID.TEXTURE_MIRRORX               = 33554432  
TRID.TEXTURE_MIRRORY               = 67108864

-- [[Position Data]]
-- these values are shared with PositionObject.h
TRID.MOTION_POSITION			= 0
TRID.MOTION_ROTATION			= 1
TRID.MOTION_SCALE				= 2
TRID.MOTION_POSITION_WORLD		= 3
TRID.MOTION_ROTATION_WORLD		= 4
TRID.MOTION_SCALE_WORLD			= 5
TRID.MOTION_POS_ROT_SCA			= 6
TRID.MOTION_POSITION_NO_LAYOUT	= 8
TRID.MOTION_VELOCITY			= 9 
TRID.MOTION_ACC				= 10
TRID.MOTION_ROTATION_VELOCITY	= 11
TRID.MOTION_ROTATION_ACC		= 12
TRID.MOTION_SCALE_VELOCITY		= 13
TRID.MOTION_SCALE_ACC			= 14
TRID.MOTION_POS_ROT                    	= 15
TRID.MOTION_POS_ROT_WORLD             = 16
TRID.MOTION_VELOCITY_FULL		= 17

-- [[Motion Flag]]
-- these values are shared with MotionObject.h
TRID.MOTION_FLAG_APPROXIMATELY_DEST = 8
TRID.MOTION_FLAG_EASE_IN = 16
TRID.MOTION_FLAG_EASE_OUT = 32
TRID.MOTION_FLAG_EASE_CURVE = 64
TRID.MOTION_FLAG_ALWAYS_FOLLOW = 128
TRID.MOTION_FLAG_ROUNDED_INTEGER = 256

-- [[Render Resource Flag]]
-- these values are shared with ModelRenderConst.h
TRID.RENDER_NO_DEPTH	= 1
TRID.RENDER_NO_LIGHTING	= 2
TRID.RENDER_NO_LIGHTMAP_GENERATION= 4
TRID.RENDER_USE_BAKED_LIGHTMAP	= 8
TRID.RENDER_NO_SHADOW			= 16
TRID.RENDER_NOT_CHECK_GRAPHICS_LOADED	= 32
TRID.RENDER_NO_FOG		= 64
TRID.RENDER_MESH_DEPTHBIAS = 128
TRID.RENDER_SUBMESH_NO_DEPTH_TEST = 256
TRID.RENDER_SUBMESH_SIMPLE_OPA = 512
TRID.RENDER_FLIP_TRIANGLE = 1024
TRID.RENDER_NO_DEPTHMASK = 4096
TRID.RENDER_DISCARD_TRANSPARENT = 8192
TRID.RENDER_SHADER_DEFAULT_CONST = 16384
TRID.RENDER_WITHOUT_SHADOWMAP = 32768
TRID.RENDER_REAL_TRANSPARENT = 65536
TRID.RENDER_2D_SHARED_TEXTURE = 16777216
TRID.RENDER_2D_LOAD_DIRECTLY	= 33554432
TRID.RENDER_BLEND_ADD = 524288
TRID.RENDER_2D_IN_3D = 67108864

-- [[Camera Flag]]
-- these values are shared with 3DCamera.h
TRID.CAMFLAG_HAS_LIGHT		= 8
TRID.CAMFLAG_NO_PICKUP		= 16
TRID.CAMFLAG_RENDER_WIREFRAME= 32
TRID.CAMFLAG_RENDER_AS_BOX	= 64
TRID.CAMFLAG_RENDER_DIFF		= 128
TRID.CAMFLAG_CHECK_COLLISION	= 1024
TRID.CAMFLAG_NOT_CONTROLLED	= 2048
TRID.CAMFLAG_CHECK_TERRAIN 	= 4096

-- [[Effect Motion Type]]
-- these values are shared with RenderObject.h
TRID.EFFECT_CURRENT_COLOR		= 0
TRID.EFFECT_DESTINATION_COLOR		= 1
TRID.EFFECT_VELOCITY_COLOR		= 2

-- [[Camera Vector Type]]
-- these values are shared with 3DCamera.h
TRID.CAM_EYE		= 0
TRID.CAM_TAR		= 1
TRID.CAM_UP		= 2

-- [[Camera Projection Data]]
-- these values are shared with 3DCamera.h
TRID.PROJ_NEAR		= 0 
TRID.PROJ_FAR		= 1
TRID.PROJ_ASP		= 2 
TRID.PROJ_FOV		= 3 
TRID.PROJ_LEFT		= 4 
TRID.PROJ_TOP		= 5 
TRID.PROJ_RIGHT		= 6 
TRID.PROJ_BOTTOM	= 7
TRID.PROJ_PERSPECTIVE= 8
TRID.PROJ_LAST		= 9

-- [[Light Property Index]]
-- these values are shared with LightPropertyController.h
TRID.LIGHT_PROPERTY_AMBIENT = 0
TRID.LIGHT_PROPERTY_DIFFUSE = 1
TRID.LIGHT_PROPERTY_INTENSITY = 2
TRID.LIGHT_PROPERTY_RANGE = 3
TRID.LIGHT_PROPERTY_SPOT_COSINE = 4

-- [[Resource Type]]
-- these values are shared with ResourceObject.h
TRID.RESOURCE_FRAMEANIMATION = 2
TRID.RESOURCE_BITMAPIMAGE=4
TRID.RESOURCE_LUASCRIPT	= 5
TRID.RESOURCE_MATERIAL	= 6
TRID.RESOURCE_MODEL	= 7
TRID.RESOURCE_MORPHING	= 8
TRID.RESOURCE_SOUND 	= 14
TRID.RESOURCE_FILE 		= 15
TRID.RESOURCE_LIGHTMAPUV= 10
TRID.RESOURCE_SCRIPTPACKAGE = 16
TRID.RESOURCE_PUPPYREDRESOURCE = 17
TRID.RESOURCE_PUPPYRED_EXTERN_MODEL_RESOURCE = 18
TRID.RESOURCE_PUPPYRED_EXTERN_ANIMATION_RESOURCE = 19

-- [[Light Type]]
-- these values are shared with 3DLight.h
TRID.LIGHT_DIRECTIONAL	= 0
TRID.LIGHT_POINT		= 1

-- [[Light Vector Type]] 
-- these values are shared with 3DLight.h
TRID.LIGHT_EYE			= 0
TRID.LIGHT_TAR			= 1
TRID.LIGHT_UP			= 2

-- [[Light Color Type]]
-- these values are shared with 3DLight.h
TRID.LIGHT_AMBIENT		= 0
TRID.LIGHT_DIFFUSE		= 1
TRID.LIGHT_SPECULAR		= 2

-- [[Bounding Interface Flag]]
-- these values are shared with BoundingInterface.h
TRID.FLAG_BA_SHOW	            = 1
TRID.FLAG_BA_GLOBAL_PLACEMENT	= 4
TRID.FLAG_BA_GET_AREA_FROM_RESOURCE = 16
TRID.FLAG_BA_CHECK_COLLISION_WITH_ONLY_BOUNDING = 128
TRID.FLAG_BA_CHECK_PICKUP_WITH_ONLY_BOUNDING = 256
TRID.FLAG_BA_FIXED_SCALE	= 512

-- [[ListBox Icon Type]]
-- these values are shared with ListBox.h
TRID.ICON_NUM_0     = 0
TRID.ICON_NUM_1     = 1
TRID.ICON_NUM_2     = 2
TRID.ICON_NUM_3     = 3
TRID.ICON_NUM_4     = 4
TRID.ICON_NUM_5     = 5
TRID.ICON_NUM_6     = 6
TRID.ICON_NUM_7     = 7
TRID.ICON_NUM_8     = 8
TRID.ICON_NUM_9     = 9
TRID.ICON_EMPTY_SLOT= 10
TRID.ICON_SELECTED  = 11
TRID.ICON_DISABLED  = 12
TRID.ICON_MOUSEOVERED= 13

-- [[GUI Text Layout Flag]]
-- these values are shared with RenderObject.h
TRID.TEXTLAYOUT_LEFT	= 1
TRID.TEXTLAYOUT_RIGHT	= 2
TRID.TEXTLAYOUT_TOP	= 4
TRID.TEXTLAYOUT_BOTTOM	= 8
TRID.TEXTLAYOUT_WRAP_TEXT = 16
TRID.TEXTLAYOUT_WRAP_TEXT_FIX_WIDTH = 32

-- [[Move Header Flag]]
-- these values are shared with MoveHeader.h
TRID.MOVEHEADER_NO_CHECK			= 0	-- you can move gui anywhere in window screen.
TRID.MOVEHEADER_WHOLE_IN_WINDOW		= 1	-- a whole body of gui must be in window screen.
TRID.MOVEHEADER_STICK_TO_EDGE_OF_WINDOW = 2	-- if a gui move to be close at edges of window, automatically sticks to the edge of window.

-- [[Render Order Type]]
-- these values are shared with GraphicObject.h
TRID.RENDER_ORDER_BACKGROUND	= 0
TRID.RENDER_ORDER_FIRST		= 5
TRID.RENDER_ORDER_DEFAULT	= 10
TRID.RENDER_ORDER_OPA		= 20
TRID.RENDER_ORDER_LAST		= 30
TRID.RENDER_ORDER_AFTER_RENDER = 40


TRID.RENDER_ORDER_FOREGROUND = TRID.RENDER_ORDER_LAST
TRID.RENDER_ORDER_SKY		= TRID.RENDER_ORDER_BACKGROUND
TRID.RENDER_ORDER_TOP_MOST	= TRID.RENDER_ORDER_FIRST
TRID.RENDER_ORDER_BOTTOM_MOST= TRID.RENDER_ORDER_FOREGROUND

-- [[Bone Customizing Vector Type]]
-- these values are shared with AnimationPlayer.h
TRID.BONE_CUSTOM_SCALE = 0
TRID.BONE_CUSTOM_TRANSLATE = 1
TRID.BONE_CUSTOM_BILLBOARD = 2
TRID.BONE_CUSTOM_ROTATE = 3

--[[ Billboard type ]]
-- these values are shared with AnimationPlayer.h
TRID.BILLBOARD_FULL = 0
TRID.BILLBOARD_FIX_AXIS = 1

-- [[Timer Flag]]
--these values are shared with TimeManager.h
TRID.TIMER_CONTENTS = 2

-- [[Collision Check Flag]]
--these values are shared with MoveObject.h
TRID.COLLISION_CHECK_NONE	= 0
TRID.COLLISION_CHECK_AVATAR	= 1
TRID.COLLISION_CHECK_HAS_BASE_ALTITUDE = 2
TRID.COLLISION_CHECK_HAS_GRAVITY = 4
TRID.COLLISION_CHECK_NOMOVING = 8
TRID.COLLISION_CHECK_BOX = 16

-- [[Network Channel Type]]
--these values are shared with NetworkType.h
TRID.NETWORK_TCP = 0
TRID.NETWORK_HTTP = 1

-- [[Network Flag]]
--these values are shared with NetworkType.h
TRID.NETWORK_SECURE_SEND= 1
TRID.NETWORK_SECURE_RECV= 2
TRID.NETWORK_SECURE_ALL	= 3
TRID.NETWORK_SWAPORDER	= 4	-- obsolete
TRID.NETWORK_ANSISTRING	= 8	-- obsolete
TRID.NETWORK_CHECKTYPE	= 16
TRID.NETWORK_NO_SIZE	= 32
TRID.NETWORK_PRINT_PACKET= 64

-- [[Registry Key]]
--these values are shared with TriDRegistry.h
TRID.REG_WORKING_PATH = "workingPath"
TRID.REG_WAITING_SCRIPT = "waitingScript"
TRID.REG_CONTENTS_PATH = "contentsPath"
TRID.REG_NUMBER = 0
TRID.REG_STRING = 1

-- [[Scrollbar Button Type]]
-- these values are shared with ScrollBar.h
-- used in TRIDGLUE.GetScrollbarButton
TRID.SCROLLBAR_INCREASER = 0
TRID.SCROLLBAR_DECREASER = 1
TRID.SCROLLBAR_THUMB = 2

-- [[ system type ]]
TRID.OS_WINDOWS = "windows"
TRID.OS_IOS = "iOS"
TRID.OS_ANDROID = "android"

-- [[Button State Type]]
-- these values are shared with Button.h
-- used in GlueSetStateProperty
TRID.BUTTON_OFF	= 0
TRID.BUTTON_ON		= 1
TRID.BUTTON_PRESSED	= 2
TRID.BUTTON_DISABLED= 3

-- [[Button Toggle Type]]
-- these values are shared with Button.h
TRID.TOGGLE_NONE	= 0
TRID.TOGGLE_AT_CLICK = 1
TRID.TOGGLE_AT_DOWN = 2

-- [[EnvironmentMap Type]]
-- these values are shared with MaterialElement.h
-- used in materialMaker
TRID.ENVTYPE_MIRROR	= 0
TRID.ENVTYPE_SHADOW= 1
TRID.ENVTYPE_STENCIL = 2

-- [[Lightmap Generation Mode]]
-- these values are shared with LightmapLogicID.h
TRID.LIGHTMAP_WITH_AO		= 1
TRID.LIGHTMAP_WITH_SHADOW	= 2
TRID.LIGHTMAP_GLOBAL_AO		= 4
TRID.LIGHTMAP_CALC_OPACITY	= 8

-- [[Terrain Modify Height Mode]]
-- these values are shared with TerrainObject.h
TRID.MODIFY_HEIGHT_UP 		= 0
TRID.MODIFY_HEIGHT_DOWN		= 1
TRID.MODIFY_HEIGHT_RANDOM	= 2
TRID.MODIFY_HEIGHT_SMOOTH	= 3
TRID.MODIFY_HEIGHT_FLAT		= 4

-- [[Terrain Brush Material Mode]]
-- these values are shared with TerrainObject.h
TRID.BRUSH_PAINT 		= 0
TRID.BRUSH_ERASE		= 1

--[[Load Manually Flag]]
-- these values are shared with ResourceManager.h
TRID.LOAD_MANUALLY_PERMANENT = 1
TRID.LOAD_MANUALLY_ONLY_DOWNLOAD = 2
TRID.LOAD_MANUALLY_ONLY_FILELOAD = 4
TRID.LOAD_MANUALLY_WAIT_UNTIL_LOADED = 8

--[[Material Shader Custom Mode]]
-- these values are shared with ShaderInfo.h
TRID.USE_CUSTOM_BONEINDEX = 1
TRID.USE_CUSTOM_TANGENT = 2
TRID.USE_CUSTOM_OPACITY = 4
TRID.USE_CUSTOM_RENDER_GLOW = 16
TRID.USE_CUSTOM_RENDER_TRANSPARENT_BOTTLE = 32
TRID.USE_CUSTOM_TWOSIDE = 64
TRID.USE_CUSTOM_NO_DEPTH = 128
TRID.USE_CUSTOM_NO_DEPTHMASK = 256
TRID.USE_CUSTOM_FLIP_TRIANGLE = 512

--[[Material Shader Custom Code]]
-- these values are shared with ShaderInfo.h
TRID.CUSTOM_SHADER_CODE_LIGHT_FACTOR			= 0
TRID.CUSTOM_SHADER_CODE_BASIC_LIGHT_COLOR		= 1
TRID.CUSTOM_SHADER_CODE_DEFAULT_MATERIAL_COLOR	= 2
TRID.CUSTOM_SHADER_CODE_ADDITIONAL_LIGHT_COLOR	= 3
TRID.CUSTOM_SHADER_CODE_SPECULAR_LEVEL		= 4
TRID.CUSTOM_SHADER_CODE_GLOW_COLOR			= 5
TRID.CUSTOM_SHADER_CODE_OPACITY				= 6
TRID.CUSTOM_SHADER_CODE_COLOR_ADJUST			= 7
TRID.CUSTOM_SHADER_CODE_NORMAL_IN_PIXEL		= 8
TRID.CUSTOM_SHADER_CODE_INPUT_POSITION		= 9
TRID.CUSTOM_SHADER_CODE_TEXTURE_COORD		= 10
TRID.CUSTOM_SHADER_CODE_LIGHTMAP_TEXTURE_COORD	= 11
TRID.CUSTOM_SHADER_CODE_CUSTOM1OUTPUT		= 12
TRID.CUSTOM_SHADER_CODE_CUSTOM2OUTPUT		= 13
TRID.CUSTOM_SHADER_CODE_CUSTOM3OUTPUT		= 14
TRID.CUSTOM_SHADER_CODE_AMBIENT_COLOR			= 15
TRID.CUSTOM_SHADER_CODE_DIFFUSE_COLOR			= 16
TRID.CUSTOM_SHADER_CODE_DIFFUSE_FACTOR		= 17
TRID.CUSTOM_SHADER_CODE_LAST				= 18

--[[Cursor Order]]
-- these values are shared with CursorManager.h
-- cursor with bigger level has higher priority.
TRID.CURSOR_ORDER_DEF = 0
TRID.CURSOR_ORDER_LV1 = 1
TRID.CURSOR_ORDER_LV2 = 2
-- if you add level, you must modify CURSOR_ORDER_LAST.
TRID.CURSOR_ORDER_LAST = 3


--[[System Cursor]]
-- these values are shared with CursorManager.h
TRID.SYS_CURSOR_START	= 1
TRID.SYS_CURSOR_ARROW	= 1
TRID.SYS_CURSOR_WAIT	= 2
TRID.SYS_CURSOR_CROSS	= 3
TRID.SYS_CURSOR_SIZE	= 4
TRID.SYS_CURSOR_SIZENWSE= 5
TRID.SYS_CURSOR_SIZENESW= 6
TRID.SYS_CURSOR_SIZEWE	= 7
TRID.SYS_CURSOR_SIZENS	= 8
TRID.SYS_CURSOR_SIZEALL	= 9
TRID.SYS_CURSOR_HAND	= 10
-- if you add level, you must modify SYS_CURSOR_LAST.
TRID.SYS_CURSOR_LAST	= 11

--[[Post Effect Flag]]
-- these values are shared with PostEffector.h
TRID.POST_EFFECT_RENDER_DEPTH = 1
TRID.POST_EFFECT_ACCUMULATE = 2
TRID.POST_EFFECT_NO_SHADER = 4
TRID.POST_EFFECT_RENDER_GLOW = 8
TRID.POST_EFFECT_HDR = 16
TRID.POST_EFFECT_RENDER_LIGHTMAP = 32
TRID.POST_EFFECT_RENDER_SHADOW = 64
TRID.POST_EFFECT_EDGE_GLOW = 128
TRID.POST_EFFECT_MSAA = 256


--[[ Specific Folder Type ]]
-- these values are shared with BaseScriptManagerInitializer.cpp
TRID.FOLDER_MYDOCUMENT = 0
TRID.FOLDER_MYPICTURE = 1
TRID.FOLDER_MYMUSIC = 2
TRID.FOLDER_MYVIDEO = 3

--[[Particle Emitter Type]]
TRID.PE_POINT = 1
TRID.PE_BOX = 2
TRID.PE_CYLINDER = 3
TRID.PE_ELLIPSOID = 4
TRID.PE_RING = 5

--[[Particle Affector Type]]
TRID.PA_COLORFADER = 1
TRID.PA_DEFLECTORPLANE = 2
TRID.PA_DIRECTIONRANDOMISER = 3
TRID.PA_LINEARFORCE = 4
TRID.PA_ROTATION = 5
TRID.PA_SCALE = 6
TRID.PA_DEVIANTDIRECTION = 7

--[[Particle Billboard Type]]
TRID.BBT_POINT = 0
TRID.BBT_ORIENTED_COMMON = 1
TRID.BBT_ORIENTED_SELF = 2
TRID.BBT_PERPENDICULAR_COMMON = 3
TRID.BBT_PERPENDICULAR_SELF = 4

--[[Particle Force Application]]
TRID.FA_AVERAGE = 0
TRID.FA_ADD = 1

--[[Particle Billboard Rotation Type]]
TRID.BBR_VERTEX = 0
TRID.BBR_TEXCOORD = 1

--[[TriDParticlePlayMode]]
TRID.PPM_LOOPING = 0 
TRID.PPM_ONESHOT = 1
TRID.PPM_DURATION = 2

--[[TriDParticleEmitterShape]]
TRID.PES_POINT = 0 
TRID.PES_BOX = 1
TRID.PES_CYLINDER = 2
TRID.PES_ELLIPSOID = 3

--[[TriDParticleUVAnimation]]
TRID.PUV_1x1 = 0 
TRID.PUV_2x2 = 1
TRID.PUV_3x3 = 2
TRID.PUV_4x4 = 3

--[[TriDBillboardStyle]]
TRID.BS_BILLBOARD = 0 
TRID.BS_STRETCHED = 1
TRID.BS_SORTED = 2
TRID.BS_VERTICAL = 3
TRID.BS_HORIZONTAL = 4

--[[NotifyMessage]]
TRID.NOTIFY_SENSOR_ACCELERATION = "_SENSOR_ACCELERATION"
TRID.NOTIFY_ON_PAUSE = "_ON_PAUSE"

-- this table name is same as ScriptManager.h
TRIDGLUE = {}
TRID.ProtectGlueFunctions = function ()
	TRIDGLUE = TRID.ProtectTable(TRIDGLUE)
end
--====================================
-- Common Data Types 
--====================================
TRID.TABLE = function (value)
	return {0, value}
end

TRID.FILE = function (filename)
	return {1, filename}
end

TRID.UNPACKTABLE = function (value)
	return {2, value}
end

-- not used
TRID.INTEGER = function (value)
    return value
	--return {100, value}		-- 'd' 100
end
-- not used
TRID.UNSIGNEDINTEGER = function (value)
    return value
	--return {117, value}		-- 'u' 117
end
-- not used
TRID.DWORD = function (value)
    return value
	--return {111, value}		-- 'o' 111
end

TRID.COLOR_MARK = 114
TRID.ARGB = function (a, r, g, b)
	return {TRID.COLOR_MARK, a, r, g, b}	-- 'r' 114
end

TRID.RGBA = function (r, g, b, a)
	return TRID.ARGB(a, r, g, b)
end

TRID.XRGB = function (r, g, b)
	return TRID.ARGB(255, r, g, b)
end

TRID.COLOR_A = function (color)
	return color and color[2] or 0
end
TRID.COLOR_R = function (color)
	return color and color[3] or 0
end
TRID.COLOR_G = function (color)
	return color and color[4] or 0
end
TRID.COLOR_B = function (color)
	return color and color[5] or 0
end

TRID.WHITECOLOR = TRID.XRGB(255, 255, 255)
TRID.BLACKCOLOR = TRID.XRGB(0,0,0)

-- for binary data
TRID.INT32 = function (value)
	return {100, value}	-- 'd' 100
end
TRID.INT16 = function (value)
	return {115, value}	-- 's' 115
end
TRID.INT8 = function (value)
	return {121, value}	-- 'y' 121
end
TRID.FLOAT = function (value)
	return {102, value}	-- 'f' 102
end
TRID.BINARYDATA = function (data)
	return {116, data}	-- 't' 116
end
-- obsolete.
TRID.BINARY = function (size, data)
	return {105, size, data}	-- 'i' 105
end

TRID.SetDebugPrintHandler = function (tag, func)
	if not _DEBUG_PRINT_HANDLER then
		_DEBUG_PRINT_HANDLER = {}
	end
	_DEBUG_PRINT_HANDLER[tag] = func
end

TRID.DebugPrint = function (text, tag)
	if MODE_DEBUG and MODE_DEBUG_INTERNAL then
		if DEBUG_FILE and DEBUG_FILE ~= "" then
			local tagText = tag or "log"
			local logger = io.open(DEBUG_FILE, "a")
			if logger then
				if DEBUG_IDENTIFIER then
					logger:write("[" .. DEBUG_IDENTIFIER .. "][" .. tagText .. "][" .. os.date("%c", os.time()) .. "] " .. text .. "\n")
				else
					logger:write("[" .. tagText .. "][" .. os.date("%c", os.time()) .. "] " .. text .. "\n")
				end
				io.close(logger)
				logger = nil
			else
				print("[" .. tagText .. "][" .. os.date("%c", os.time()) .. "] " .. text .. "\n")
			end
		else
			print(text)
		end
	end
	if _DEBUG_PRINT_HANDLER and tag and _DEBUG_PRINT_HANDLER[tag] then
		_DEBUG_PRINT_HANDLER[tag](text)
	end
end

TRID.DebugPrintDB = function (prefix, dbInstance, tableName, numColumn)
	if MODE_DEBUG and PRINT_DB  and MODE_DEBUG_INTERNAL then
		local result = {dbInstance:GlueSelectQuery("SELECT * FROM \"" .. tableName .. "\";")}
		if not result[1] then
			TRID.DebugPrint("TRID.DebugPrintDB in " .. prefix .. " - select query failed. " .. tostring(result[2]))
			return
		end
		
		TRID.DebugPrint(prefix .. " - " .. tableName .. " = {")
		local line, cell
		for i = 3, #result, numColumn do
			line = nil
			for j = 1, numColumn do
				cell = tostring(result[i + j - 1])
				line = line and (line .. " " .. cell .. ",") or ("\t" .. cell .. ",")
			end
			TRID.DebugPrint(line)
		end
		TRID.DebugPrint("}")
	end
end

TRID.TryAndCatchException = function (tryFunc, catchFunc)
	local try, errCode = pcall(tryFunc)
	if not try then
		if type(errCode) == "table" then
			TRID.DebugPrint(errCode._string, "error")
		elseif type(errCode) == "string" then
			TRID.DebugPrint(errCode, "error")
		end
		if catchFunc then catchFunc(errCode) end
	end
end

TRID.SplitBySeparator = function (str, pattern, includeNullString)
	local curPattern = pattern or "[ ]"
	local result = {}
	if not str then
		return result
	end
	local start = 0
	local next, nextEnd = string.find(str, curPattern, start+1)
	while next ~= nil do
		local subStr = string.sub(str, start+1, next-1)
		if includeNullString or subStr ~= "" then
			result[#result+1] = subStr
		end
		--print(result[#result])
		start = nextEnd
		next, nextEnd = string.find(str, curPattern, start+1)
	end
	if start+1 <= #str then
		result[#result+1] = string.sub(str, start+1, #str)
		--print(result[#result])
	elseif includeNullString then
		result[#result+1] = ""
	end
	return result
end

TRID.GetFileList = function (targetFolder, extenstionList)
	if not targetFolder then
		TRID.DebugPrint("TRID.GetFileList - path is nil.", "warning")
		return {}
	end
	targetFolder = TRID.AdjustPath(targetFolder)
	local fileList = {}
	local systemInfo = TRID.GetSystemInfo()
	if systemInfo == TRID.OS_WINDOWS then
		local TEMP_TEXT_FILE = "_file_list_" .. tostring(TRID.GetCurrentTime()) .. ".txt"
		os.execute("del " .. TEMP_TEXT_FILE)
		os.execute("dir \"" .. targetFolder .. "\" /b /s >> " .. TEMP_TEXT_FILE)
		
		-- collect model files from the list.
		local scriptFile = io.open(TEMP_TEXT_FILE, "r")
		local line, i
		for line in scriptFile:lines() do
			local insertThis = false
			if extenstionList then
				local fileNameArray = TRID.SplitBySeparator(line, "[.]")
				if #fileNameArray > 0 then
					local ext = fileNameArray[#fileNameArray]
					for i=1, #extenstionList do
						if string.lower(ext) == extenstionList[i] then
							insertThis = true
							break
						end
					end
				end
			else
				insertThis = true
			end
			
			if insertThis then
				table.insert(fileList, TRID.AdjustPath(line))
			end
		end
		scriptFile:close()
		scriptFile = nil
		os.execute("del " .. TEMP_TEXT_FILE)
	else
		TRID.DebugPrint("TRID.GetFileList - do not support this system.", "error")
	end
	return fileList
end

-- replace \ to /
TRID.AdjustPath = function (path)
	if not path then
		TRID.DebugPrint("TRID.AdjustPath - path is nil. " .. debug.traceback(), "warning")
		return nil
	end
	local pathArray = TRID.SplitBySeparator(path, "[\\]")
	local convertedPath
	for i=1, #pathArray do
		if convertedPath == nil then
		    convertedPath = pathArray[i]
		else
		    convertedPath = convertedPath .. "/" .. pathArray[i]
		end
	end
	return convertedPath
end

TRID.ReplaceCharacter = function (text, from, to)
	if not (text and from and to) then
		TRID.DebugPrint("TRID.ReplaceCharacter - (text or from or to) is nil. " .. debug.traceback(), "warning")
		return nil
	end
	local pathArray = TRID.SplitBySeparator(text, "[" .. from .. "]")
	local convertedPath
	for i=1, #pathArray do
		if convertedPath == nil then
		    convertedPath = pathArray[i]
		else
		    convertedPath = convertedPath .. to .. pathArray[i]
		end
	end
	return convertedPath
end
-- for test
TRID.ReadjustPath = function (path)
	if not path then
		TRID.DebugPrint("TRID.ReadjustPath - path is nil. " .. debug.traceback(), "warning")
		return nil
	end
	local pathArray = TRID.SplitBySeparator(path, "[/]")
	local convertedPath
	for i=1, #pathArray do
		if convertedPath == nil then
		    convertedPath = pathArray[i]
		else
		    convertedPath = convertedPath .. "\\" .. pathArray[i]
		end
	end
	return convertedPath
end
-- for test
TRID.GetLastFolderName = function (path)
	if not path then
		TRID.DebugPrint("TRID.GetLastFolderName - path is nil. " .. debug.traceback(), "warning")
		return nil
	end
	local pathArray = TRID.SplitBySeparator(path, "[/]")
	return pathArray[#pathArray]
end

TRID.GetFileName = function (path)
	if not path then
		TRID.DebugPrint("TRID.GetFileName - path is nil.", "warning")
		return nil
	end
	local convertedPath = TRID.AdjustPath(path)
	local pathArray = TRID.SplitBySeparator(convertedPath, "[/]")
	return pathArray[#pathArray]
end

TRID.GetFileNameOnly = function (path)
	if not path then
		TRID.DebugPrint("TRID.GetFileNameOnly - path is nil.", "warning")
		return nil
	end
	local fileName = TRID.GetFileName(path)
	local array = TRID.SplitBySeparator(fileName, "[.]", true)
	local result = ""
	for i=1,#array-1 do
		if i > 1 then
			result = result .. "." .. array[i]
		else
			result = array[i]
		end
	end
	return result
end

TRID.GetFileExtension = function (path)
	if not path then
		TRID.DebugPrint("TRID.GetFileExtension - path is nil.", "warning")
		return nil
	end
	local fileName = TRID.GetFileName(path)
	local array = TRID.SplitBySeparator(fileName, "[.]", true)
	if #array == 1 then
		return ""
	else
		return array[#array]
	end
end

TRID.GetClassNameFromScriptPath = function (scriptPath)
	return TRID.GetFileNameOnly(scriptPath)
end

TRID.GetPath = function (path)
	if not path then
		TRID.DebugPrint("TRID.GetPath - path is nil.", "warning")
		return nil
	end
	local convertedPath = TRID.AdjustPath(path)
	local firstChar = string.byte(convertedPath, 1,1)
	local pathArray = TRID.SplitBySeparator(convertedPath, "[/]", true)
	local result = ""
	for i=1,#pathArray-1 do
		if i > 1 then
			result = result .. "/" .. pathArray[i]
		else
			-- if first character is '/', add this to result at first.
			if firstChar == 47 then
				result = "/" .. pathArray[i]
			else
				result = pathArray[i]
			end
		end
	end
	return result
end

TRID.GetArgumentList = function()
	if _TRID_ARGUMENT_ == nil or _TRID_ARGUMENT_ == "" then
		return nil
	end
	
	local argu1 = TRID.SplitBySeparator(_TRID_ARGUMENT_, "[\"]", true)
	if #argu1 <= 1 then
		return TRID.SplitBySeparator(_TRID_ARGUMENT_)
	end

	local result = {}
	for i=1, #argu1 do
		-- this is a string in double quotation
		if (i % 2) == 0 then
			result[#result + 1] = argu1[i]
		else
			local list = TRID.SplitBySeparator(argu1[i])
			for k=1, #list do
				if list[k] ~= "" then
					result[#result + 1] = list[k]
				end
			end
		end
	end
	return result
end

TRID.IsNullString = function(str)
	return not (str and str ~= "")
end

TRID.ProtectTable = function (tbl)
  return setmetatable ({}, 
    {
		__index = tbl,
		__metatable = "You can not modify metatable.",
		__newindex = function (t, n, v)
			error ("attempting to change constant " .. tostring (n) .. " to " .. tostring (v), 2)
		end
    })
end

TRID.ProtectTableAdd = function (tbl)
  return setmetatable ({}, 
    {
		__index = tbl,
		__metatable = "You can not modify metatable.",
		__newindex = function (t, n, v)
			if (PROTECT_CLASS and tbl[n] ~= nil) then
				error ("attempting to change constant " .. tostring (n) .. " to " .. tostring (v), 2)
			else
				tbl[n] = v
			end
		end
    })
end

--====================================
-- vector operation
--====================================
TRID.Vec3Invert = function (A)
    return {-A[1], -A[2], -A[3]}
end

TRID.Vec3Add = function (A, B)
    return {A[1] + B[1], A[2] + B[2], A[3] + B[3]}
end

TRID.Vec3Subtract = function (A, B)
	if not (A and B) then
		TRID.DebugPrint("Vec3Subtract - error " .. debug.traceback())
	end
    return {A[1] - B[1], A[2] - B[2], A[3] - B[3]}
end

TRID.Vec3Multiply = function (A, B)
	if type(B) == "table" then
		return {A[1]*B[1], A[2]*B[2], A[3]*B[3]}
	else
		return {A[1]*B, A[2]*B, A[3]*B}
	end
end

TRID.Vec3Divide = function (A, scalar)
    if scalar == 0 then
        return A
    else
        return {A[1]/scalar, A[2]/scalar, A[3]/scalar}
    end
end

TRID.Vec3GetLength = function (vec)
    return math.sqrt(vec[1]*vec[1] + vec[2]*vec[2] + vec[3]*vec[3])
end

TRID.Vec3GetSquareLength = function (vec)
    return (vec[1]*vec[1] + vec[2]*vec[2] + vec[3]*vec[3])
end

TRID.Vec3GetDistance = function (pos1, pos2)
    local diff = TRID.Vec3Subtract(pos1, pos2)
    return TRID.Vec3GetLength(diff)
end

TRID.Vec3GetSquareDistance = function (pos1, pos2)
    local vec = TRID.Vec3Subtract(pos1, pos2)
    return vec[1]*vec[1] + vec[2]*vec[2] + vec[3]*vec[3]
end

TRID.Vec3Normalize = function (vec)
    local length = TRID.Vec3GetLength(vec)
    return TRID.Vec3Divide(vec, length), length
end

TRID.Vec3XYAngleInDegree = function (vec)
	local x = vec[1]
	local y = vec[2]
	if x > 0 then
		if y >= 0 then
			return math.atan(y/x) * TRID.RAD2ANG
		else
			return 360 + math.atan(y/x) * TRID.RAD2ANG
		end
	elseif x == 0 then
		if y > 0 then
			return 90
		elseif y == 0 then
			return 0
		else
			return 270
		end
	else
		return 180 + math.atan(y/x) * TRID.RAD2ANG
	end
end

TRID.ASIN = function (value)
	return math.asin( (value<-1) and -1 or ((value<1) and value or 1) )
end

-- result : arctan(y/x). 0 ~ 360 degree.
TRID.ATAN2 = function (y, x)
	local result = 0
	if (-TRID.EPSILON < x and x < TRID.EPSILON) then
		if (y > 0) then
			result = 90
		else
			result = 270
		end
	else
		result = math.atan(y / x) * TRID.RAD2ANG
		if (x < 0) then
			result = result + 180
		elseif (y < 0) then
			result = result + 360
		end
	end
	return result
end

TRID.Vec3ConvertToAngle = function (vec)
	local dir = TRID.Vec3Normalize(vec)
	local upVec = {0,0,1}
	if TRID.Vec3Compare(dir, upVec) then
		return {0,-90,0}
	elseif TRID.Vec3Compare(dir, {0,0,-1}) then
		return {0,90,0}
	end
	local yaxis = TRID.Vec3CrossProduct(upVec, dir)
	yaxis = TRID.Vec3Normalize(yaxis)
	local up = TRID.Vec3CrossProduct(dir, yaxis)
	up[1] = math.max(-1,math.min(1,up[1]))

	-- -90 ~ 90
	local angleY = TRID.ASIN(up[1]) * TRID.RAD2ANG
	local cosineY = math.cos(angleY * TRID.ANG2RAD)
	local angleX = 0
	local angleZ = 0
	if (-TRID.EPSILON < cosineY and cosineY < TRID.EPSILON) then
		dir[2] = math.max(-1,math.min(1,dir[2]))
		angleZ = TRID.ASIN(dir[2]) * TRID.RAD2ANG
	else
		angleZ = TRID.ATAN2(-yaxis[1], dir[1])
		angleX = TRID.ATAN2(-up[2], up[3])
	end

	return {angleX, angleY, angleZ}
end

TRID.Vec3AngleInDegree = function (vec1, vec2)
	local nomalV1 = TRID.Vec3Normalize(vec1)
	local nomalV2 = TRID.Vec3Normalize(vec2)
	local innerProduct = TRID.Vec3DotProduct(nomalV1, nomalV2)
	innerProduct = math.min(1, math.max(-1, innerProduct))
	local radian = math.acos(innerProduct)
	local degree = TRID.RadianToDegree(radian)
	
	local z = TRID.Vec3CrossProduct(nomalV1, nomalV2)
	if z[3] > 0 then
		return degree
	else
		return -degree
	end
end

TRID.Vec3DotProduct = function (A, B)
    return A[1] * B[1] + A[2] * B[2] + A[3] * B[3]
end

TRID.Vec3CrossProduct = function (A, B)
	return {A[2] * B[3] - A[3] * B[2], A[3] *  B[1] - A[1] * B[3], A[1] * B[2] - A[2] *  B[1]}
end

TRID.FloatEqual = function (a, b)
    if a == nil or b == nil then
        return false
    end
    return math.abs(a-b) < TRID.EPSILON
end

TRID.Vec3Equal = function (A, B)
    return TRID.FloatEqual(A[1],B[1]) and TRID.FloatEqual(A[2],B[2]) and TRID.FloatEqual(A[3],B[3])
end

-- result = A * (1-ratio) + B * ratio
TRID.Vec3Lerp = function (A,B,ratio)
	return {B[1]*ratio + A[1]*(1-ratio), B[2]*ratio + A[2]*(1-ratio), B[3]*ratio + A[3]*(1-ratio)}
end

TRID.Vec3ToString = function (vec)
	if not vec then
		return ""
	end
	return tostring(vec[1]) .. " " .. tostring(vec[2]) .. " " .. tostring(vec[3])
end

TRID.Vec3RotateX = function (vec, radian)
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {vec[1], cos*vec[2] - sin*vec[3], sin*vec[2] + cos*vec[3]}
end

TRID.Vec3RotateXAxis = function (vec, angleInDegree)
	local radian = angleInDegree*TRID.ANG2RAD
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {vec[1], cos*vec[2] - sin*vec[3], sin*vec[2] + cos*vec[3]}
end

TRID.Vec3RotateY = function (vec, radian)
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {cos*vec[1] + sin*vec[3], vec[2], -sin*vec[1] + cos*vec[3]}
end

TRID.Vec3RotateYAxis = function (vec, angleInDegree)
	local radian = angleInDegree*TRID.ANG2RAD
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {cos*vec[1] + sin*vec[3], vec[2], -sin*vec[1] + cos*vec[3]}
end

TRID.Vec3RotateZ = function (vec, radian)
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {cos*vec[1] - sin*vec[2], sin*vec[1] + cos*vec[2], vec[3]}
end

TRID.Vec3RotateZAxis = function (vec, angleInDegree)
	local radian = angleInDegree*TRID.ANG2RAD
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	return {cos*vec[1] - sin*vec[2], sin*vec[1] + cos*vec[2], vec[3]}
end

TRID.Vec3RotateAxis = function (vec, axis, radian)
	local mat = TRID.Mat16FromQuaternion(axis, radian * TRID.RAD2ANG)
	return TRID.Mat16MultiplyVec3(mat, vec)
end

TRID.Vec3RotateAnyAxis = function (vec, axis, angleInDegree)
	local mat = TRID.Mat16FromQuaternion(axis, angleInDegree)
	return TRID.Mat16MultiplyVec3(mat, vec)
end

TRID.Vec3GetRotationVectorFromRotationMatrix16 = function (mat)
	local angle = {}
	-- singularity at north pole
	if (mat[9] > 0.998) then
		angle[3] = math.atan2(mat[2], mat[6]) * TRID.RAD2ANG
		angle[2] = 90
		angle[1] = 0
	-- singularity at south pole
	elseif (mat[9] < -0.998) then
		angle[3] = math.atan2(mat[2], mat[6]) * TRID.RAD2ANG
		angle[2] = -90
		angle[1] = 0
	else
		angle[1] = math.atan2(-mat[10], mat[11]) * TRID.RAD2ANG
		angle[3] = math.atan2(-mat[5], mat[1]) * TRID.RAD2ANG
		angle[2] = math.asin(mat[9]) * TRID.RAD2ANG
	end
	return angle
end

TRID.Vec3GetRotationVectorFromQuaternion = function (axis, angleInDegree)
	local mat = TRID.Mat16FromQuaternion(axis, angleInDegree)
	return TRID.Vec3GetRotationVectorFromRotationMatrix16(mat)
end

TRID.Vec6AddBox = function (box, newBox)
	if not (box and newBox and (#newBox == 6 or #newBox == 3)) then
		TRID.DebugPrint("TRID.Vec6AddBox - not (box and newBox and (#newBox == 6 or #newBox == 3)).", "error")
		return
	end
	box[1] = box[1] and math.min(box[1], newBox[1]) or newBox[1]
	box[2] = box[2] and math.min(box[2], newBox[2]) or newBox[2]
	box[3] = box[3] and math.min(box[3], newBox[3]) or newBox[3]
	if #newBox == 3 then
		box[4] = box[4] and math.max(box[4], newBox[1]) or newBox[1]
		box[5] = box[5] and math.max(box[5], newBox[2]) or newBox[2]
		box[6] = box[6] and math.max(box[6], newBox[3]) or newBox[3]
	else
		box[4] = box[4] and math.max(box[4], newBox[4]) or newBox[4]
		box[5] = box[5] and math.max(box[5], newBox[5]) or newBox[5]
		box[6] = box[6] and math.max(box[6], newBox[6]) or newBox[6]
	end
	return box
end

--====================================
-- matrix 4*4
--====================================
TRID.Mat16Multiply = function (m1, m2)
	if not (m1 and m2) then
		TRID.DebugPrint("TRID.Mat16Multiply - m1 or m2 is nil.")
		return nil
	end
	local out = {}
	out[1] = m1[1] * m2[1] + m1[5] * m2[2] + m1[9] * m2[3] + m1[13] * m2[4]
	out[5] = m1[1] * m2[5] + m1[5] * m2[6] + m1[9] * m2[7] + m1[13] * m2[8]
	out[9] = m1[1] * m2[9] + m1[5] * m2[10] + m1[9] * m2[11] +m1[13] * m2[12]
	out[13]= m1[1] * m2[13] +m1[5] * m2[14] +m1[9] * m2[15] +m1[13] * m2[16]

	out[2] = m1[2] * m2[1] + m1[6] * m2[2] + m1[10] * m2[3] + m1[14] * m2[4]
	out[6] = m1[2] * m2[5] + m1[6] * m2[6] + m1[10] * m2[7] + m1[14] * m2[8]
	out[10] = m1[2] * m2[9] + m1[6] * m2[10] + m1[10] * m2[11] +m1[14] * m2[12]
	out[14]= m1[2] * m2[13] +m1[6] * m2[14] +m1[10] * m2[15] +m1[14] * m2[16]

	out[3] = m1[3] * m2[1] + m1[7] * m2[2] + m1[11] * m2[3] + m1[15] * m2[4]
	out[7] = m1[3] * m2[5] + m1[7] * m2[6] + m1[11] * m2[7] + m1[15] * m2[8]
	out[11]= m1[3] * m2[9] + m1[7] * m2[10] + m1[11] * m2[11] +m1[15] * m2[12]
	out[15]= m1[3] * m2[13] +m1[7] * m2[14] +m1[11] * m2[15] +m1[15] * m2[16]

	out[4] = m1[4] * m2[1] + m1[8] * m2[2] + m1[12] * m2[3] + m1[16] * m2[4]
	out[8] = m1[4] * m2[5] + m1[8] * m2[6] + m1[12] * m2[7] + m1[16] * m2[8]
	out[12]= m1[4] * m2[9] + m1[8] * m2[10] + m1[12] * m2[11] +m1[16] * m2[12]
	out[16]= m1[4] * m2[13] +m1[8] * m2[14] +m1[12] * m2[15] +m1[16] * m2[16]
	return out
end

TRID.Mat16MultiplyVec3 = function (mat, v)
	local div = (mat[4]*v[1] + mat[8]*v[2] + mat[12]*v[3] + mat[16])
	if div == 0 then
		TRID.DebugPrint("TRID.Mat16MultiplyVec3 - div is zero.")
		return nil
	end
	local d = 1 / div
	return {	(mat[1]*v[1] + mat[5]*v[2] + mat[9]*v[3] + mat[13]) * d,
			(mat[2]*v[1] + mat[6]*v[2] + mat[10]*v[3] + mat[14]) * d,
			(mat[3]*v[1] + mat[7]*v[2] + mat[11]*v[3] + mat[15]) * d}
end

TRID.Mat16Identity = function ()
	return {1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1}
end

TRID.Mat16Invert = function (a)
	local calcFull = false
	if not (TRID.FloatEqual(a[4], 0) and TRID.FloatEqual(a[8], 0) and TRID.FloatEqual(a[12], 0) and TRID.FloatEqual(a[16], 1)) then
		calcFull = true
	end
	
	local q = TRID.Mat16Identity()
	if not calcFull then
		local invdet = a[1] * ( a[6] * a[11] - a[10] * a[7] ) - a[5] * ( a[2] * a[11] - a[10] * a[3] ) + a[9] * ( a[2] * a[7] - a[6] * a[3] )
		if invdet == 0 then
			TRID.DebugPrint("TRID.Mat16Invert - invdet is 0.")
			return q
		end
		
		local det =1 / invdet

		q[1] =  det * ( a[6] * a[11] - a[10] * a[7] )
		q[5] = -det * ( a[5] * a[11] - a[9]* a[7] )
		q[9] =  det * ( a[5] * a[10] - a[9] * a[6] )

		q[2] = -det * ( a[2] * a[11] - a[10] * a[3] )
		q[6] =  det * ( a[1] * a[11] - a[9] * a[3] )
		q[10] = -det * ( a[1] * a[10] - a[9] * a[2] )

		q[3] =  det * ( a[2] * a[7] - a[6] * a[3] )
		q[7] = -det * ( a[1] * a[7] - a[5] * a[3] )
		q[11] =  det * ( a[1] * a[6] - a[5] * a[2] )

		q[13] = -( a[13] * q[1] + a[14] * q[5] + a[15] * q[9] )
		q[14] = -( a[13] * q[2] + a[14] * q[6] + a[15] * q[10] )
		q[15] = -( a[13] * q[3] + a[14] * q[7] + a[15] * q[11] )
		q[16] = 1
	else
		local fA0 = a[ 1]*a[ 6] - a[ 5]*a[ 2]
		local fA1 = a[ 1]*a[10] - a[ 9]*a[ 2]
		local fA2 = a[ 1]*a[14] - a[13]*a[ 2]
		local fA3 = a[ 5]*a[10] - a[ 9]*a[ 6]
		local fA4 = a[ 5]*a[14] - a[13]*a[ 6]
		local fA5 = a[ 9]*a[14] - a[13]*a[10]
		local fB0 = a[ 3]*a[ 8] - a[ 7]*a[ 4]
		local fB1 = a[ 3]*a[12] - a[11]*a[ 4]
		local fB2 = a[ 3]*a[16] - a[15]*a[ 4]
		local fB3 = a[ 7]*a[12] - a[11]*a[ 8]
		local fB4 = a[ 7]*a[16] - a[15]*a[ 8]
		local fB5 = a[11]*a[16] - a[15]*a[12]

		local fDet = fA0*fB5-fA1*fB4+fA2*fB3+fA3*fB2-fA4*fB1+fA5*fB0
		if fDet == 0 then
			TRID.DebugPrint("TRID.Mat16Invert - fDet is 0.")
			return q
		end
		local fInvDet = 1/fDet

		q[ 1] = a[ 6]*fB5 - a[10]*fB4 + a[14]*fB3
		q[ 2] = -a[ 2]*fB5 + a[10]*fB2 - a[14]*fB1
		q[ 3] = a[ 2]*fB4 - a[ 6]*fB2 + a[14]*fB0
		q[ 4] = -a[ 2]*fB3 + a[ 6]*fB1 - a[10]*fB0
		q[ 5] = -a[ 5]*fB5 + a[ 9]*fB4 - a[13]*fB3
		q[ 6] = a[ 1]*fB5 - a[ 9]*fB2 + a[13]*fB1
		q[ 7] = -a[ 1]*fB4 + a[ 5]*fB2 - a[13]*fB0
		q[ 8] = a[ 1]*fB3 - a[ 5]*fB1 + a[ 9]*fB0
		q[ 9] = a[ 8]*fA5 - a[12]*fA4 + a[16]*fA3
		q[10] = -a[ 4]*fA5 + a[12]*fA2 - a[16]*fA1
		q[11] = a[ 4]*fA4 - a[ 8]*fA2 + a[16]*fA0
		q[12] = -a[ 4]*fA3 + a[ 8]*fA1 - a[12]*fA0
		q[13] = -a[ 7]*fA5 + a[11]*fA4 - a[15]*fA3
		q[14] = a[ 3]*fA5 - a[11]*fA2 + a[15]*fA1
		q[15] = -a[ 3]*fA4 + a[ 7]*fA2 - a[15]*fA0
		q[16] = a[ 3]*fA3 - a[ 7]*fA1 + a[11]*fA0
		
		q[ 1] = q[1] * fInvDet
		q[ 2] = q[2] * fInvDet
		q[ 3] = q[3] * fInvDet
		q[ 4] = q[4] * fInvDet
		q[ 5] = q[5] * fInvDet
		q[ 6] = q[6] * fInvDet
		q[ 7] = q[7] * fInvDet
		q[ 8] = q[8] * fInvDet
		q[ 9] = q[9] * fInvDet
		q[10] = q[10] * fInvDet
		q[11] = q[11] * fInvDet
		q[12] = q[12] * fInvDet
		q[13] = q[13] * fInvDet
		q[14] = q[14] * fInvDet
		q[15] = q[15] * fInvDet
		q[16] = q[16] * fInvDet
	end
	return q
end

TRID.Mat16FromQuaternion = function (axis, angleInDegree)
	local radian = angleInDegree * TRID.ANG2RAD
	local normalizedAxis = TRID.Vec3Normalize(axis)
	local cosineValue = math.cos(radian * 0.5)
	local sineValue = math.sin(radian * 0.5)
	local q = {normalizedAxis[1] * sineValue, normalizedAxis[2] * sineValue, normalizedAxis[3] * sineValue, cosineValue}
	
	local mat = TRID.Mat16Identity()
	mat[1] = 1 - 2 * q[2] * q[2] - 2 * q[3] * q[3]
	mat[2] = 2 * q[1] * q[2] + 2 * q[4] * q[3]
	mat[3] = 2 * q[1] * q[3] - 2 * q[4] * q[2]

	mat[5] = 2 * q[1] * q[2] - 2 * q[4] * q[3]
	mat[6] = 1 - 2 * q[1] * q[1] - 2 * q[3] * q[3]
	mat[7] = 2 * q[2] * q[3] + 2 * q[4] * q[1]

	mat[9] = 2 * q[1] * q[3] + 2 * q[4] * q[2]
	mat[10] = 2 * q[2] * q[3] - 2 * q[4] * q[1]
	mat[11] = 1 - 2 * q[1] * q[1] - 2 * q[2] * q[2]
	return mat
end

TRID.Mat16FromRotationVector = function (rotationVectorInDegree)
	if not rotationVectorInDegree then
		TRID.DebugPrint("TRID.Mat16FromRotationVector - rotationVectorInDegree is nil.")
		return {0,0,0}
	end
	local vec = TRID.Vec3Multiply(rotationVectorInDegree, TRID.ANG2RAD)
	
	local sinx = math.sin(vec[1])
	local cosx = math.cos(vec[1])
	local siny = math.sin(vec[2])
	local cosy = math.cos(vec[2])
	local sinz = math.sin(vec[3])
	local cosz = math.cos(vec[3])
	
	local mat = {}
	mat[1] = cosy*cosz
	mat[2] = sinx*siny*cosz + cosx*sinz
	mat[3] = -cosx*siny*cosz + sinx*sinz
	mat[4] = 0
	mat[5] = -cosy*sinz
	mat[6] = -sinx*siny*sinz + cosx*cosz
	mat[7] = cosx*siny*sinz + sinx*cosz
	mat[8] = 0
	mat[9] = siny
	mat[10] = -sinx*cosy
	mat[11] = cosx*cosy
	mat[12] = 0
	mat[13] = 0
	mat[14] = 0
	mat[15] = 0
	mat[16] = 1
	return mat
end

--====================================
-- utilities
--====================================
TRID.ReplacePathForDeploy = function (path)
	if not TRID.IsNullString(path) then
		return "$" .. "(_CURPATH_)" .. TRID.GetFileName(path)
	else
		return path
	end
end

TRID.RecursiveSaveData = function (tableDataList, scriptFile, indentation, onlyOneLine, replacePathToCurPath)
	local curIndentation = indentation
	if not curIndentation then
		curIndentation = 1
	end
	
	local newLineString = "\n"
	for i=1, curIndentation do
		newLineString = newLineString .. " "
	end
		
	local elementNewLineString = newLineString
	if onlyOneLine then
		if curIndentation == 1 then
			elementNewLineString = "\n"
			newLineString = ""
		else
			elementNewLineString = ""
			newLineString = ""
		end
	else
		-- for first indentation
		scriptFile:write(" ")
	end

	local tableData = tableDataList
	local count = 0
	for i,v in pairs(tableData) do 
		if v ~= nil then
			if type(v) == "string" then
				if type(i) == "number" then
					scriptFile:write("[" .. i .. "] = \"")
				else
					scriptFile:write("[\"" .. tostring(i) .. "\"] = \"")
				end
				local str = v
				if replacePathToCurPath then
					local next, nextEnd = string.find(str, ":/")
					if next then
						str = TRID.ReplacePathForDeploy(v)
					end
				end
				scriptFile:write(str .. "\", ")
			elseif type(v) == "table" then
				if type(i) == "number" then
					scriptFile:write("[" .. i .. "] = {" .. newLineString)
				else
					scriptFile:write("[\"" .. tostring(i) .. "\"] = {" .. newLineString)
				end
				local dataList = tableData[i]
				TRID.RecursiveSaveData(dataList, scriptFile, curIndentation+1, onlyOneLine, replacePathToCurPath)
				scriptFile:write(newLineString .. "}," .. elementNewLineString)
			else
				if type(i) == "number" then
					scriptFile:write("[" .. i .. "]" .. " = " .. tostring(v) .. ", ")
				else
					scriptFile:write("[\"" .. tostring(i) .. "\"] = " .. tostring(v) .. ", ")
				end
			end 
		end
	end
end

TRID.SaveTableData = function (tableData, tableName, scriptFile, onlyOneLine, replacePathToCurPath)
	if not (tableData and tableName and scriptFile) then
		TRID.DebugPrint("TRID.SaveTableData - tableData, tableName or scriptFile is nil.")
		return
	end
	scriptFile:write(tableName .. " = {\n")
	TRID.RecursiveSaveData(tableData, scriptFile, 1, onlyOneLine, replacePathToCurPath)
	scriptFile:write("\n}")
end

TRID.RecursiveCopyTable = function (tableData, resultData)
	local i,v
	for i,v in pairs(tableData) do
		if v ~= nil then
			if type(v) == "table" then
				if i == "_originalData" then
					return false
				end
				resultData[i] = {}
				if not TRID.RecursiveCopyTable(v, resultData[i]) then
					resultData[i] = v
				end
			else
				resultData[i] = v
			end
		end
	end
	return true
end

TRID.CopyTable = function (tableData)
	if not (tableData and type(tableData) == "table") then
		TRID.DebugPrint("TRID.CopyTable - tableData is nil or tableData is not a table.", "error")
		return
	end
	
	local resultData = {}
	TRID.RecursiveCopyTable(tableData, resultData)
	return resultData
end

TRID.AppendTable = function (baseTable, secondTable)
-- notice : baseTable += secondTable
	if not (baseTable and secondTable) then
		TRID.DebugPrint("TRID.AppendTable - baseTable or secondTable is nil.")
		return baseTable or secondTable
	end
	for k,l in pairs(secondTable) do 
		baseTable[k] = l
	end
	return baseTable
end

TRID.AppendArray = function (baseArray, secondArray)
	if not (baseArray and secondArray) then
		TRID.DebugPrint("TRID.AppendArray - baseArray or secondArray is nil.")
		return baseArray or secondArray
	end
	for k,l in ipairs(secondArray) do 
		table.insert(baseArray, l)
	end
	return baseArray
end

TRID.GetTableSize = function (tableData)
	if not tableData then
		return 0
	end
	local count = 0
	for k in pairs(tableData) do 
		count = count + 1
	end
	return count
end

-- if not found, return nil
TRID.GetTableIndex = function (tableData, value)
	if not tableData then
		return nil
	end
	for k,l in pairs(tableData) do 
		if l == value then
			return k
		end
	end
	return nil
end

TRID.ArrangeAngle = function (angle, minAngle, maxAngle)
	minAngle = minAngle or 0
	maxAngle = maxAngle or 360
	if (angle < minAngle) then
		local n = math.ceil((minAngle - angle) / 360)
		angle = angle + n*360
	end

	if (maxAngle < angle) then
		local n = math.ceil((angle - maxAngle) / 360)
		angle = angle - n*360
	end
	return angle
end

TRID.Angle2Byte = function (angle)
	local angle2 = TRID.ArrangeAngle(angle)
	
	return (angle2 * 255) / 360
end

TRID.Byte2Angle = function (byte)
	return (byte * 360) / 255
end

TRID.Vec3Compare = function (v1, v2)
	if not v1 or not v2 then
		return false
	end
	if v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3] then
		return true
	end
	return false
end

TRID.WORD_SIZE = 2^16

TRID.HiWord = function (dword)
--~ 	if not dword then
--~ 		TRID.DebugPrint('TRID.HiWord - traceback = ' .. debug.traceback())
--~ 	end
	return math.floor(dword/TRID.WORD_SIZE)
end

TRID.LoWord = function (dword)
	return math.floor(dword%TRID.WORD_SIZE)
end

TRID.MakeDWord = function (hiWord, loWord)
	return TRID.LoWord(hiWord)*TRID.WORD_SIZE + TRID.LoWord(loWord)
end

TRID.IsBitSet = function (value, bitValue)
	if value and bitValue and bitValue > 0 then
		return math.floor(value/bitValue)%2 == 1
	else
		TRID.DebugPrint("TRID.IsBitSet - not (value and bitValue and bitValue > 0).")
		return false
	end
end

TRID.SetBit = function (value, bitValue)
	local v = value
	if math.floor(v/bitValue)%2 == 0 then
		v = v + bitValue
	end
	
	return v
end

TRID.ResetBit = function (value, bitValue)
	local v = value
	if math.floor(v/bitValue)%2 == 1 then
		v = v - bitValue
	end
	
	return v
end

TRID.TableToString = function (t)
	if not t then
		return "nil"
	elseif type(t) ~= "table" then
		return tostring(t)
	end
	local s
	for k, v in pairs(t) do
		if type(k) == "number" then
			k = "[" .. k .. "]"
		else
			k = tostring(k)
		end
		
		if type(v) == "table" then
			if k == "_originalData" then
				return tostring(t)
			end
			v = TRID.TableToString(v)
		elseif type(v) == "string" then
			v = "\"" .. v .. "\""
		else
			v = tostring(v)
		end
		
		s = s and (s .. "," .. k .. "=" .. v) or (k .. "=" .. v)
	end
	return s and ("{" .. s .. "}") or "{}"
end

-- * TRID.CompareVec({1,2}, {1,2,3}) == true
-- * TRID.CompareVec({1,2,3}, {1,2}) == false
TRID.CompareArray = function (v1, v2)
	if v1 == nil or v2 == nil then
		return false
	end
	
	for i=1, #v1 do
		if v1[i] ~= v2[i] then
			return false
		end
	end
	
	return true
end

TRID.NumberToCommaSaparatedString = function (number)
	-- temporary implementation
	local unformatted = tostring(number)
	local count = #unformatted
	local css = ""
	if string.sub(unformatted, 1, 1) == "-" then
		css = "-"; count = count - 1
	end
	for d in string.gmatch(unformatted, "%d") do
		css = css .. d
		count = count - 1
		if count > 0 and count%3 == 0 then
			css = css .. ','
		end
	end
	return css
end

TRID.CommaSaparatedStringToNumber = function (css)
	-- temporary implementation
	local unformatted = ""
	for d in string.gmatch(css, "%d") do
		unformatted = unformatted .. d
	end
	return tonumber(unformatted)
end

TRID.GetInstanceFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		return TRID.GetInstance(tonumber(dataArray[1]), tonumber(dataArray[2]), nil, TRID.FOID_GRAPHIC_OBJECT)
	else
		TRID.DebugPrint("TRID.GetInstanceFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetKeyCodeFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		local wParam = tonumber(dataArray[3])
		return wParam
	else
		TRID.DebugPrint("TRID.GetKeyCodeFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetTouchDataFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		local totalTouch = dataArray[1]
		local touchList = {}
		for i=1, totalTouch do
			table.insert(touchList, {ID = dataArray[4*i-2], x = dataArray[4*i-1], y = dataArray[4*i], tapCount = dataArray[4*i+1]})
		end
		return touchList
	else
		TRID.DebugPrint("TRID.GetTouchDataFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetDropFilesFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data, "[\n]")
		local totalFiles = dataArray[1]
		local fileList = {}
		for i=1, totalFiles do
			table.insert(fileList, dataArray[1+i])
		end
		return fileList
	else
		TRID.DebugPrint("TRID.GetDropFilesFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.UWORD2WORD = function (uword)
	local word = uword
	if uword > 32767 then
		word = uword - 65536
	end
	return word
end

TRID.GetMouseDataFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		local lParam = tonumber(dataArray[2])
		local wParam = tonumber(dataArray[3])
-- 		return lParam % 65536, (math.floor(lParam/65536) % 65536), wParam
		return TRID.UWORD2WORD(lParam % 65536), TRID.UWORD2WORD((math.floor(lParam/65536) % 65536)), wParam
	else
		TRID.DebugPrint("TRID.GetMouseDataFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetCollisionDataFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		return TRID.GetInstance(tonumber(dataArray[1]), tonumber(dataArray[2])), (dataArray[3] == "1")
	else
		TRID.DebugPrint("TRID.GetCollisionDataFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetAnimationCurrentFrameChangedDataFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data, "[|]")
		return dataArray[1], dataArray[2]
	else
		TRID.DebugPrint("TRID.GetAnimationCurrentFrameChangedDataFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.GetListBoxDataFromMessageData = function (data)
	if type(data) == "string" then
		local dataArray = TRID.SplitBySeparator(data)
		return TRID.GetInstance(tonumber(dataArray[1]), tonumber(dataArray[2])), tonumber(dataArray[3])
	else
		TRID.DebugPrint("TRID.GetListBoxDataFromMessageData - data is a not string.", "error")
		return nil
	end
end

TRID.Counter = function (startCount)
	local counter = {}
	counter.currentCount = startCount or 0
	counter.GetCurrentCount = function (counter)
		return counter.currentCount
	end
	counter.Increase = function (counter)
		counter.currentCount = counter.currentCount + 1
		return counter.currentCount
	end
	return counter
end

TRID.GET_CURRENT_TIME_MAX = 2^32

--====================================
-- Funtion Object Properties
--====================================
TRID.MakeOnePropOfGraphicObject = function (data, boundingFOID, renderFOID, RENDER_ORDER_Type, renderOrder)
	data[#data + 1] = "CGraphicObject"
	data["CGraphicObject"] = {}
	local dataTable = data["CGraphicObject"]

	if RENDER_ORDER_Type == nil then
		dataTable[#dataTable + 1] = "1"
	else
		dataTable[#dataTable + 1] = "CGraphicObject-2"
	end

	dataTable[#dataTable + 1] = boundingFOID
	dataTable[#dataTable + 1] = renderFOID
	if RENDER_ORDER_Type ~= nil then
		dataTable[#dataTable + 1] = RENDER_ORDER_Type
		dataTable[#dataTable + 1] = renderOrder or 0
	end
	return data
end

TRID.MakeOnePropOfBoundingRect = function (data, left, top, right, bottom, color, fill, FLAG_BA_TypeFlag)
	data[#data + 1] = "CBoundingInterface"
	data["CBoundingInterface"] = {}
	local dataTable = data["CBoundingInterface"]

	if color == nil and fill == nil and FLAG_BA_TypeFlag == nil then
		dataTable[#dataTable + 1] = "1"
	else
		dataTable[#dataTable + 1] = "CBoundingInterface-2"
	end
	dataTable[#dataTable + 1] = left
	dataTable[#dataTable + 1] = top
	dataTable[#dataTable + 1] = right
	dataTable[#dataTable + 1] = bottom
	
	if not (color == nil and fill == nil and FLAG_BA_TypeFlag == nil) then
		dataTable[#dataTable + 1] = color or TRID.ARGB(255,0,0,0)
		dataTable[#dataTable + 1] = fill or false
		dataTable[#dataTable + 1] = FLAG_BA_TypeFlag or 0
	end
	return data
end

TRID.MakeOnePropOfBoundingInterfaceFor3D = function (data, color, fill, FLAG_BA_TypeFlag)
	data[#data + 1] = "CBoundingInterface"
	data["CBoundingInterface"] = 
	{
		"CBoundingInterface-2",	-- format version
		0, 0, 1, 1,	-- RECT4
		color or TRID.XRGB(0,0,0),
		fill or false,
		FLAG_BA_TypeFlag or 0,
	}
	return data
end

TRID.MakeOnePropOfBoundingSphere = function (data, radius, x,y,z, color, fill, FLAG_BA_TypeFlag)
	data[#data + 1] = "CBoundingSphere"
	data["CBoundingSphere"] = 
	{
		"1",	-- format version
		radius,	x,y,z
	}
	TRID.MakeOnePropOfBoundingInterfaceFor3D(data, color, fill, FLAG_BA_TypeFlag)
	return data
end

TRID.MakeOnePropOfBoundingBox = function (data, x1,y1,z1, x2,y2,z2, color, fill, FLAG_BA_TypeFlag, fixedLengthInPixel)
	data[#data + 1] = "CBoundingBox"
	data["CBoundingBox"] = 
	{
		"CBoundingBox-v001",	-- format version
		x1,y1,z1, x2,y2,z2, fixedLengthInPixel or 1
	}
	TRID.MakeOnePropOfBoundingInterfaceFor3D(data, color, fill, FLAG_BA_TypeFlag)
	return data
end

TRID.MakeOnePropOfRenderResource = function (data, hasAnim, hasModel, RENDER_TypeFlag, lightmapIntensity, selfPos, selfRot, selfSca)
	local hasMatrix = (selfPos ~= nil and selfRot ~= nil and selfSca ~= nil)
	
	data[#data + 1] = "CRenderResource"
	data["CRenderResource"] = {}
	local tableData = data["CRenderResource"]
	tableData[#tableData + 1] = "CRenderResource-4"	-- format version
	tableData[#tableData + 1] = hasAnim or false 	-- has animation
	tableData[#tableData + 1] = hasModel or false 	-- has model
	tableData[#tableData + 1] = lightmapIntensity or 1	-- lightmap intensity
	tableData[#tableData + 1] = hasMatrix	-- has 2d matrix
	if hasMatrix then
		tableData[#tableData + 1] = false -- is matrix format (float 16 array)
		tableData[#tableData + 1] = selfPos[1]
		tableData[#tableData + 1] = selfPos[2]
		tableData[#tableData + 1] = selfPos[3]
		tableData[#tableData + 1] = selfRot[1]
		tableData[#tableData + 1] = selfRot[2]
		tableData[#tableData + 1] = selfRot[3]
		tableData[#tableData + 1] = selfSca[1]
		tableData[#tableData + 1] = selfSca[2]
		tableData[#tableData + 1] = selfSca[3]
	end
	
	if RENDER_TypeFlag and RENDER_TypeFlag ~= 0 then
		TRID.MakeRenderObject(data, RENDER_TypeFlag)
	end	
	return data
end

TRID.MakeOnePropOfGUIObject = function (data, CURSOR_ORDER_Type, cursorPath)
	local order = CURSOR_ORDER_Type or TRID.CURSOR_ORDER_DEF
	if not (TRID.CURSOR_ORDER_DEF <= order and order < TRID.CURSOR_ORDER_LAST) then
		TRID.DebugPrint("TRID.MakeOnePropOfGUIObject - CURSOR_ORDER_Type is invalid.", "error")
		return data
	end
	data[#data + 1] = "CGUIObject"
	data["CGUIObject"] = 
	{
		"1",	-- format version
		order,
		cursorPath or "",
	}
	return data
end

TRID.MakeOnePropOfGUIObjectWithSystemCursor = function (data, CURSOR_ORDER_Type, SYS_CURSOR_Index)
	local cursorPath
	if SYS_CURSOR_Index then
		if not (TRID.SYS_CURSOR_START <= SYS_CURSOR_Index and SYS_CURSOR_Index < TRID.SYS_CURSOR_LAST) then
			TRID.DebugPrint("TRID.MakeOnePropOfGUIObjectWithSystemCursor - SYS_CURSOR_Index is invalid.", "error")
			return data
		end
		cursorPath = tostring(SYS_CURSOR_Index)
	end
	
	TRID.MakeOnePropOfGUIObject(data, CURSOR_ORDER_Type, cursorPath)
	return data
end

-- materialPropList = { {materialIndex, materialProp},  ... }
TRID.MakeOnePropOfTerrainObject = function (data, heightmapPath, heightmapSize, patchSize, patchInfoScriptPath, materialScale, materialPropList, blendmapPath, LODThresholdRatio, lightmapPath, lightmapIntensity)
	if not (heightmapPath and patchInfoScriptPath and materialPropList and blendmapPath) then
		TRID.DebugPrint("TRID.MakeOnePropOfTerrainObject - you must set (heightmapPath and patchInfoScriptPath and materialPropList and blendmapPath).", "error")
		return data
	end
	if not (heightmapPath ~= "" and patchInfoScriptPath ~= "" and heightmapSize > 0 and patchSize > 0 and blendmapPath ~= "" and #materialPropList > 0) then
		TRID.DebugPrint("TRID.MakeOnePropOfTerrainObject - you must set (heightmapPath and patchInfoScriptPath and heightmapSize > 0 and patchSize > 0 and blendmapPath and #materialPropList > 0).", "error")
		return data
	end
	
	data[#data + 1] = "CTerrainObject"
	data["CTerrainObject"] = {
		"CTerrainObject-v001",	-- format version
		heightmapPath,
		heightmapSize,
		patchSize,
		patchInfoScriptPath,
		materialScale or 1,
		#materialPropList,	-- total material
	}
	
	local tableData = data["CTerrainObject"]
	local i
	for i=1, #materialPropList do
		if not (type(materialPropList[i]) == "table" and #materialPropList[i] == 2) then
			data = {}
			TRID.DebugPrint("TRID.MakeOnePropOfTerrainObject - materialPropList has the following format : { {number materialIndex, table materialProp},  ... }", "error")
			return data
		end
		table.insert(tableData, materialPropList[i][1])
		table.insert(tableData, TRID.TABLE(materialPropList[i][2]))
	end
	
	table.insert(tableData, lightmapPath or "")
	table.insert(tableData, lightmapIntensity or 1)
	table.insert(tableData, blendmapPath)
	table.insert(tableData,  LODThresholdRatio or 1)
	return data
end

-- selfPos, selfRot, selfSca are nil or vector3 table
TRID.MakeOnePropOfPosition = function (data, x,y,z, rx,ry,rz, sx,sy,sz, hasMotion, addLAYOUT_TypeFlag, selfPos, selfRot, selfSca, delLAYOUT_TypeFlag)
	local hasAdjustedOriginalData = (selfPos ~= nil and selfRot ~= nil and selfSca ~= nil)
	local hasLayout = ((addLAYOUT_TypeFlag ~= nil and addLAYOUT_TypeFlag > 0) or (delLAYOUT_TypeFlag ~= nil))
	
	data[#data + 1] = "CPositionObject"
	data["CPositionObject"] = 
	{
		"CPositionObject-2",	-- format version
		x,y,z,
		rx,ry,rz,
		sx,sy,sz,
		hasMotion or false,
		hasLayout,
		hasAdjustedOriginalData,
	}
	
	if hasAdjustedOriginalData then
		TRID.AppendArray(data["CPositionObject"], selfPos)
		TRID.AppendArray(data["CPositionObject"], selfRot)
		TRID.AppendArray(data["CPositionObject"], selfSca)
	end
	
	-- in case of reset flag
--~ 	if hasLayout then
		data[#data + 1] = "CLayoutObject"
		data["CLayoutObject"] = 
		{
			"CLayoutObject-2",	-- format version
			delLAYOUT_TypeFlag or -1,
			addLAYOUT_TypeFlag or 0,
		}
--~ 	end
	return data
end

TRID.MakeOnePropOfMotion = function (data, baseAltitude, kneeHeight, gravity, timeSmooth, checkNoMoving, constraintBox)
	local checkFlag = 0
	if baseAltitude then
		checkFlag = checkFlag + TRID.COLLISION_CHECK_HAS_BASE_ALTITUDE
	end
	if kneeHeight then
		checkFlag = checkFlag + TRID.COLLISION_CHECK_AVATAR
	end
	if gravity then
		checkFlag = checkFlag + TRID.COLLISION_CHECK_HAS_GRAVITY
	end
	if checkNoMoving then
		checkFlag = checkFlag + TRID.COLLISION_CHECK_NOMOVING
	end
	if constraintBox then
		checkFlag = checkFlag + TRID.COLLISION_CHECK_BOX
	end
	
	data[#data + 1] = "CMotionObject"
	data["CMotionObject"] = {}
	local dataTable = data["CMotionObject"]
	
	-- format version
	table.insert(dataTable , "CMotionObject-v001")
	-- total motion values
	table.insert(dataTable , 0)
	table.insert(dataTable , checkFlag)
	if kneeHeight then
		table.insert(dataTable , kneeHeight)
	end
	if baseAltitude then
		if type(baseAltitude) == "table" then
			table.insert(dataTable , true)
			table.insert(dataTable , baseAltitude[1])
			table.insert(dataTable , baseAltitude[2])
			table.insert(dataTable , baseAltitude[3])
			table.insert(dataTable , baseAltitude[4])
		else
			table.insert(dataTable , false)
			table.insert(dataTable , baseAltitude)
		end
	end
	if gravity then
		-- vector3
		table.insert(dataTable , 0)
		table.insert(dataTable , 0)
		table.insert(dataTable , gravity)
	end
	if constraintBox then
		-- vector6
		table.insert(dataTable , constraintBox[1])
		table.insert(dataTable , constraintBox[2])
		table.insert(dataTable , constraintBox[3])
		table.insert(dataTable , constraintBox[4])
		table.insert(dataTable , constraintBox[5])
		table.insert(dataTable , constraintBox[6])
	end
	
	table.insert(dataTable , timeSmooth or false)
	return data
end

-- if you modify this, you must modify TRID.MakeRenderObject
TRID.MakeOnePropOfEffectColor = function (data, color, applyToAllChilds)
	local a = 1
	local r = 1
	local g = 1
	local b = 1
	if color then
		a = color[2]/255
		r = color[3]/255
		g = color[4]/255
		b = color[5]/255
	end
	if not data["CRenderObject"] then
		data[#data + 1] = "CRenderObject"
		data["CRenderObject"] = 
		{
			"1",	-- format version
			r,g,b,a,
			applyToAllChilds or false,
		}
	else
		data["CRenderObject"][2] = r
		data["CRenderObject"][3] = g
		data["CRenderObject"][4] = b
		data["CRenderObject"][5] = a
		data["CRenderObject"][6] = applyToAllChilds or false
	end
	return data
end

TRID.MakeOnePropOfRenderLine = function (data, lineColor, depthTest, fromInstance, toInstance)
	if not (fromInstance and toInstance) then
		TRID.DebugPrint("TRID.MakeOnePropOfRenderLine - you must set fromInstance and toInstance.", "error")
		return data
	end
	data[#data + 1] = "CRenderLine"
	data["CRenderLine"] = 
	{
		"1",	-- format version
		lineColor or TRID.WHITECOLOR, 
		2,
		fromInstance._baseID[1],fromInstance._baseID[2],
		toInstance._baseID[1],toInstance._baseID[2],
	}
	return data
end

-- lineListArray : {vec3 pt1, vec3 pt2, ...}
TRID.MakeOnePropOfRenderLines = function (data, lineColor, lineListArray)
	if not (lineListArray and #lineListArray >= 2 and #lineListArray % 2 == 0) then
		TRID.DebugPrint("TRID.MakeOnePropOfRenderLines - you must set lineListArray.", "error")
		return data
	end
	data[#data + 1] = "CRenderLine"
	data["CRenderLine"] = 
	{
		"CRenderLine-v001",	-- format version
		lineColor or TRID.WHITECOLOR, 
		#lineListArray,
		true,
	}
	
	local d = data["CRenderLine"]
	for i=1, #lineListArray do
		table.insert(d, lineListArray[i][1])
		table.insert(d, lineListArray[i][2])
		table.insert(d, lineListArray[i][3])
	end
	return data
end

-- if you modify this, you must modify TRID.MakeEffectColor
TRID.MakeOnePropOfRenderObject = function (data, RENDER_TypeFlag, applyToAllChilds)
	if not data["CRenderObject"] then
		data[#data + 1] = "CRenderObject"
		data["CRenderObject"] = 
		{
			"CRenderObject-2",	-- format version
			1,1,1,1, -- current effect color
			applyToAllChilds or false,		-- applyToAllChilds
			RENDER_TypeFlag or 0,
		}
	else
		data["CRenderObject"][1] = "CRenderObject-2"	-- format version
		data["CRenderObject"][6] = applyToAllChilds or false
		data["CRenderObject"][7] = RENDER_TypeFlag or 0
	end
	return data
end

TRID.MakeOnePropOfRender2DWithImage = function (data, imageName, opaName, clipToGUISize, color)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-2",	-- format version
		color or TRID.XRGB(255,255,255), 
		true,	-- drawFill
		false,	-- hasText
		true,	-- hasImage
		imageName,
		opaName or "",
		clipToGUISize or false,
	}
	return data
end

TRID.MakeOnePropOfRender2DWithImageStretch = function (data, imageName, opaName, clipToGUISize, widthStretchArray, heightStretchArray)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-v008",	-- format version
		TRID.XRGB(255,255,255), 
		true,	-- drawFill
		false,	-- hasText
		true,	-- hasImage
		clipToGUISize or false,
		1,
		imageName,
		opaName or "",
		true,	-- depth mask
		false,	-- has gradation color
		true, -- has stretch data
	}
	
	local InsertStretchFunc = function (array)
		local dataArray = {}
		local totalData = array and #array or 0 -- total strectch data
		if totalData > 0 then
			local i
			for i=1, #array do
				if #array[i] == 3 then
					table.insert(dataArray, array[i][1])
					table.insert(dataArray, array[i][2])
					table.insert(dataArray, array[i][3])
				else
					TRID.DebugPrint("TRID.MakeOnePropOfRender2DWithImageStretch - stretchArray is not valid. format : {{originalSize, strectchSize, fix}, ...}.", "error")
					totalData = 0
					break
				end
			end
		end
		return totalData, dataArray
	end
	
	local totalData, dataArray = InsertStretchFunc(widthStretchArray)

	table.insert(data["CRender2D"], totalData)
	if totalData > 0 then
		TRID.AppendArray(data["CRender2D"], dataArray)
	end
	
	totalData, dataArray = InsertStretchFunc(heightStretchArray)
	table.insert(data["CRender2D"], totalData)
	if totalData > 0 then
		TRID.AppendArray(data["CRender2D"], dataArray)
	end
	return data
end

TRID.MakeOnePropOfRender2DWithImageStretchText = function (data, imageName, opaName, clipToGUISize, widthStretchArray, heightStretchArray, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-v008",	-- format version
		TRID.XRGB(255,255,255), 
		true,	-- drawFill
		true,	-- hasText
		text or "",
		textColor,
		fontName or "", -- font name ("" = default)
		fontSize or 0, -- font size (0 = default)
		TEXTLAYOUT_TypeFlag or 0, -- text layout (0 = center)
		FONT_TypeStyle or 0,
		textGap or 0,
		lineGap or 0,
		false, -- highlight
		true,	-- hasImage
		clipToGUISize or false,
		1,
		imageName,
		opaName or "",
		true,	-- depth mask
		false,	-- has gradation color
		true, -- has stretch data
	}
	
	local InsertStretchFunc = function (array)
		local dataArray = {}
		local totalData = array and #array or 0 -- total strectch data
		if totalData > 0 then
			local i
			for i=1, #array do
				if #array[i] == 3 then
					table.insert(dataArray, array[i][1])
					table.insert(dataArray, array[i][2])
					table.insert(dataArray, array[i][3])
				else
					TRID.DebugPrint("TRID.MakeOnePropOfRender2DWithImageStretch - stretchArray is not valid. format : {{originalSize, strectchSize, fix}, ...}.", "error")
					totalData = 0
					break
				end
			end
		end
		return totalData, dataArray
	end
	
	local totalData, dataArray = InsertStretchFunc(widthStretchArray)

	table.insert(data["CRender2D"], totalData)
	if totalData > 0 then
		TRID.AppendArray(data["CRender2D"], dataArray)
	end
	
	totalData, dataArray = InsertStretchFunc(heightStretchArray)
	table.insert(data["CRender2D"], totalData)
	if totalData > 0 then
		TRID.AppendArray(data["CRender2D"], dataArray)
	end
	return data
end

TRID.MakeOnePropOfRender2DWithText = function (data, text, textColor, bgColor, fill, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize, highlightThick)
	local fillFlag = fill
	if fill == nil then
		fillFlag = true
	end
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-4",	-- format version
		bgColor,
		fillFlag,	-- drawFill
		true,	-- hasText
		text or "",
		textColor,
		fontName or "",
		fontSize or 0,
		TEXTLAYOUT_TypeFlag or 0, -- text layout (0 = center)
		FONT_TypeStyle or 0,
		textGap or 0,
		lineGap or 0,
	}
	local dataTable = data["CRender2D"]
	if highlightThick and highlightThick > 0 then
		table.insert(dataTable, true) -- highlight
		table.insert(dataTable, highlightThick)
	else
		table.insert(dataTable, false) -- highlight
	end
	table.insert(dataTable, false) -- hasImage
	return data
end

TRID.MakeOnePropOfRender2DWithImageText = function (data, imageName, opaName, clipToGUISize, text, textColor, bgColor, fill, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-4",	-- format version
		bgColor,
		fill,	-- drawFill
		true,	-- hasText
		text or "",
		textColor,
		fontName or "",
		fontSize or 0,
		TEXTLAYOUT_TypeFlag or 0, -- text layout (0 = center)
		FONT_TypeStyle or 0,
		textGap or 0,
		lineGap or 0,
		false, -- highlight
		true,	-- hasImage
		clipToGUISize or false,
		false,	-- hasPattern
		imageName,
		opaName or "",
	}
	return data
end

TRID.MakeOnePropOfRender2DWithColor = function (data, color, fill, depthMask)
	local depthMasking = depthMask
	if depthMask == nil then
		depthMasking = true
	end
	
	local fillFlag = fill
	if fill == nil then
		fillFlag = false
	end
		
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-5",	-- format version
		color,
		fillFlag,	-- drawFill
		false,	-- hasText
		false,	-- hasImage
		depthMasking,
		false, -- has gradation colors
	}
	return data
end

TRID.MakeOnePropOfRender2DWithRedirection = function (data, color, fill, depthMask, targetInstance)
	local depthMasking = depthMask
	if depthMask == nil then
		depthMasking = true
	end
	
	local hasRedirection = false
	if targetInstance then
		hasRedirection = true
	end

	local fillFlag = fill
	if fill == nil then
		fillFlag = true
	end
	
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-6",	-- format version
		color,
		fillFlag,	-- drawFill
		false,	-- hasText
		false,	-- hasImage
		depthMasking,
		false, -- has gradation colors
		hasRedirection,
	}
	
	if hasRedirection then
		local thisProp = data["CRender2D"] 
		thisProp[#thisProp+ 1] = targetInstance._baseID[1]
		thisProp[#thisProp+ 1] = targetInstance._baseID[2]
	end
	return data
end

TRID.MakeOnePropOfRender2DWithGradationColor = function (data, colorLeftTop, colorRightTop, colorLeftBottom, colorRightBottom, fill, depthMask)
	local depthMasking = depthMask
	if depthMask == nil then
		depthMasking = true
	end
	local fillFlag = fill
	if fill == nil then
		fillFlag = true
	end
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-5",	-- format version
		TRID.XRGB(255,255,255),
		fillFlag,	-- drawFill
		false,	-- hasText
		false,	-- hasImage
		depthMasking,
		true, -- has gradation colors
		4,	-- totVertex
		colorLeftTop,
		colorLeftBottom,
		colorRightTop,
		colorRightBottom,
	}
	return data
end

TRID.MakeOnePropOfRender2DWithImageGradationColor = function (data, imageName, opaName, clipToGUISize, colorLeftTop, colorRightTop, colorLeftBottom, colorRightBottom, colorCenter, depthMask)
	local depthMasking = depthMask
	if depthMask == nil then
		depthMasking = true
	end
	local totVertex = 4
	if colorCenter then
		totVertex = 5
	end
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-5",	-- format version
		colorLeftTop, 
		true,	-- drawFill
		false,	-- hasText
		true,	-- hasImage
		clipToGUISize or false,
		false, -- sliced
		imageName,
		opaName or "",
		depthMasking,
		true, -- has gradation colors
		totVertex,	-- totVertex
		colorLeftTop,
		colorLeftBottom,
		colorRightTop,
		colorRightBottom,
	}
	
	if colorCenter then
		local thisProp = data["CRender2D"] 
		thisProp[#thisProp+ 1] = colorCenter
	end
	return data
end

TRID.MakeOnePropOfRender2DWithPatternImage = function (data, clipToGUISize, imagePatternTable)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-3",	-- format version
		TRID.XRGB(255,255,255), 
		true,	-- drawFill
		false,	-- hasText
		true,	-- hasImage
		clipToGUISize,
		true,   -- has pattern
		imagePatternTable[1][1], imagePatternTable[1][2],   -- TOPLEFT img, opa
		imagePatternTable[2][1], imagePatternTable[2][2],   -- TOPMIDDLE img, opa
		imagePatternTable[3][1], imagePatternTable[3][2],   -- TOPRIGHT img, opa
		imagePatternTable[4][1], imagePatternTable[4][2],   -- MIDDLELEFT img, opa
		imagePatternTable[5][1], imagePatternTable[5][2],   -- MIDDLEMIDDLE img, opa
		imagePatternTable[6][1], imagePatternTable[6][2],   -- MIDDLERIGHT img, opa
		imagePatternTable[7][1], imagePatternTable[7][2],   -- BOTTOMLEFT img, opa
		imagePatternTable[8][1], imagePatternTable[8][2],   -- BOTTOMMIDDLE img, opa
		imagePatternTable[9][1], imagePatternTable[9][2],   -- BOTTOMRIGHT img, opa
	}
	return data
end

TRID.MakeOnePropOfRender2DWithPatternImageText = function (data, clipToGUISize, imagePatternTable, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	data[#data + 1] = "CRender2D"
	data["CRender2D"] = 
	{
		"CRender2D-4",	-- format version
		TRID.XRGB(255,255,255),
		true,	-- drawFill
		true,	-- hasText
		text or "",
		textColor,
		fontName or "", -- font name ("" = default)
		fontSize or 0, -- font size (0 = default)
		TEXTLAYOUT_TypeFlag or 0, -- text layout (0 = center)
		FONT_TypeStyle or 0,
		textGap or 0,
		lineGap or 0,
		false, --highlight
		true,	-- hasImage
		clipToGUISize,
		true,   -- has pattern
		imagePatternTable[1][1], imagePatternTable[1][2],   -- TOPLEFT img, opa
		imagePatternTable[2][1], imagePatternTable[2][2],   -- TOPMIDDLE img, opa
		imagePatternTable[3][1], imagePatternTable[3][2],   -- TOPRIGHT img, opa
		imagePatternTable[4][1], imagePatternTable[4][2],   -- MIDDLELEFT img, opa
		imagePatternTable[5][1], imagePatternTable[5][2],   -- MIDDLEMIDDLE img, opa
		imagePatternTable[6][1], imagePatternTable[6][2],   -- MIDDLERIGHT img, opa
		imagePatternTable[7][1], imagePatternTable[7][2],   -- BOTTOMLEFT img, opa
		imagePatternTable[8][1], imagePatternTable[8][2],   -- BOTTOMMIDDLE img, opa
		imagePatternTable[9][1], imagePatternTable[9][2],   -- BOTTOMRIGHT img, opa
	}
	return data
end

TRID.MakeOnePropOfRender3D = function (data, color, drawFill, depthTest)
	local curDepthTest = true
	if depthTest ~= nil then
		curDepthTest = depthTest
	end
	local fillFlag = drawFill
	if drawFill == nil then
		fillFlag = true
	end
	data[#data + 1] = "CRender3D"
	data["CRender3D"] = 
	{
		"CRender3D-2",	-- format version
		color or TRID.ARGB(0,0,0,0), 
		fillFlag,
		false,
		curDepthTest,
	}
	return data
end

TRID.MakeOnePropOfNodeObject = function (data, FLAG_TypeFlag)
	data[#data + 1] = "CNodeObject"
	data["CNodeObject"] = 
	{
		"1",	-- format version
		FLAG_TypeFlag,
	}
	return data
end

TRID.MakeOnePropOfBillboard = function (data,  x, y, z, width, height, color, materialProp)
	data[#data + 1] = "CBillboardSet"
	data["CBillboardSet"] = 
	{
		"CBillboardSet-1",	-- format version
		x, y, z,
		width, height,
		color or TRID.XRGB(255,255,255),
		TRID.TABLE(materialProp),
	}
	return data
end

TRID.MakeOnePropOfLensFlare = function (data,  screenWidth, screenHeight, flareSpots)
	data[#data + 1] = "CLensFlare"
	data["CLensFlare"] = {}
	
	local dataTable =  data["CLensFlare"]
	dataTable[#dataTable+1] = "CLensFlare-1"
	
	dataTable[#dataTable+1] =  screenWidth
	dataTable[#dataTable+1] =  screenHeight
	
	dataTable[#dataTable+1] = #flareSpots
	for i=1, #flareSpots do
	        dataTable[#dataTable+1] = flareSpots[i][1] --spotSize
		dataTable[#dataTable+1] = flareSpots[i][2] --linePos
		table.insert(dataTable, TRID.TABLE(flareSpots[i][3])) --material
	end	
	
	return data
end

TRID.MakeOnePropOfFrameBase = function (data, hasViewPort, clearScreen, clearColor)
	local clearMode = clearScreen
	if clearScreen ~= nil and type(clearScreen) == "boolean" then
		if clearScreen then
			clearMode = TRID.CLEAR_ALL
		end
	end
	data[#data + 1] = "CFrameBase"
	data["CFrameBase"] = 
	{
		"CFrameBase-v001",	-- format version
		hasViewPort,
		clearMode or 0,
		clearColor or TRID.XRGB(0,0,0),
		0,0,0,0,	-- offset rect
	}
	return data
end

TRID.MakeOnePropOfFrame = function (data, blockKeyMessage)
	data[#data + 1] = "CFrame"
	data["CFrame"] = 
	{
		"1",	-- format version
		blockKeyMessage or false,
	}
	return data
end

TRID.MakeOnePropOfRenderResourceWithSimpleStaticModel = function (data, modelName, RENDER_TypeFlag)
	TRID.MakeOnePropOfRenderResourceWithSimpleAnimatingModel(data, modelName, nil, nil, RENDER_TypeFlag)
	return data
end

TRID.MakePropsOf3DObjectWithSimpleStaticModel = function (data, x1,y1,z1, x2,y2,z2, modelFile, RENDER_TypeFlag, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_RESOURCE, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfBoundingBox(data, x1,y1,z1, x2,y2,z2)
	TRID.MakeOnePropOfRenderResourceWithSimpleStaticModel(data, modelFile, RENDER_TypeFlag)
	return data
end

TRID.MakePropsOf3DObjectWithSimpleAnimatingModel = function (data, x1,y1,z1, x2,y2,z2, modelFile, animFile, FPS, RENDER_TypeFlag, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_RESOURCE, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfBoundingBox(data, x1,y1,z1, x2,y2,z2)
	TRID.MakeOnePropOfRenderResourceWithSimpleAnimatingModel(data, modelFile, animFile, FPS, RENDER_TypeFlag)
	return data
end

TRID.MakePropsOfTerrainObject = function (data, x1,y1,z1, x2,y2,z2, heightmapPath, heightmapSize, patchSize, patchInfoScriptPath, materialScale, materialPropList, blendmapPath, LODThresholdRatio, lightmapPath, RENDER_ORDER_Type, renderOrder, lightmapIntensity)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_NULL, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfBoundingBox(data, x1,y1,z1, x2,y2,z2)
	TRID.MakeOnePropOfTerrainObject(data, heightmapPath, heightmapSize, patchSize, patchInfoScriptPath, materialScale, materialPropList, blendmapPath, LODThresholdRatio, lightmapPath, lightmapIntensity)
	return data
end

-- modelList has the following format.
-- { {slot, modelName},  {slot, modelName}, ... }
TRID.MakeOnePropOfBodyList = function (data, modelList)
	if not modelList or type(modelList) ~= "table" or #modelList == 0 then
		TRID.DebugPrint("TRID.MakeOnePropOfBodyList - modelList is not a table.", "error")
		return data
	end
	
	data[#data + 1] = "CBody"
	data["CBody"] = {}
	local dataTable = data["CBody"]
	
	dataTable[#dataTable+1] = "1"	-- format version
	dataTable[#dataTable+1] = #modelList	-- total model
	for i=1, #modelList do
		dataTable[#dataTable+1] = modelList[i][1]	-- slot
		dataTable[#dataTable+1] = modelList[i][2]	-- model name
		dataTable[#dataTable+1] = 0	-- total morphing
	end
	return data
end

-- animList has the following format.
-- { {slot, animName, FPS, looping},  {slot, animName, FPS, looping}, ... }
TRID.MakeOnePropOfAnimationList = function (data, animList)
	if not animList or type(animList) ~= "table" or #animList == 0 then
		TRID.DebugPrint("TRID.MakeOnePropOfAnimationList - animList is not a table.", "error")
		return data
	end
	
	data[#data + 1] = "CAnimationPlayer"
	data["CAnimationPlayer"] = {}
	local dataTable = data["CAnimationPlayer"]
	
	dataTable[#dataTable+1] = "1"	-- format version
	dataTable[#dataTable+1] = #animList	-- total anim
	for i=1, #animList do
		dataTable[#dataTable+1] = animList[i][1]	-- slot
		dataTable[#dataTable+1] = 1	-- total blending anim
		dataTable[#dataTable+1] = animList[i][2]	-- anim name
		dataTable[#dataTable+1] = 1	-- blend ratio
		dataTable[#dataTable+1] = true	-- has anim info
		dataTable[#dataTable+1] = animList[i][3] or 30	-- FPS
		dataTable[#dataTable+1] = animList[i][4] or false -- looping
	end
	return data
end

TRID.MakeOnePropOfRenderResourceWithSimpleAnimatingModel = function (data, modelName, animName, FPS, RENDER_TypeFlag)
	TRID.MakeOnePropOfRenderResource(data, (animName ~= nil), true, RENDER_TypeFlag)
	if modelName and modelName ~= "" then
		TRID.MakeOnePropOfBodyList(data, {{0,modelName}})
	end
	if animName and animName ~= "" then
		TRID.MakeOnePropOfAnimationList(data, {{0,animName,FPS,true}})
	end
	return data
end

TRID.MakeOnePropOfRenderResourceWithSimpleMorphingModel = function (data, modelName, morphAnimName, FPS, RENDER_TypeFlag)
	TRID.MakeOnePropOfRenderResource(data, false, true, RENDER_TypeFlag)
	
	data[#data + 1] = "CBody"
	data["CBody"] = 
	{
		"1",	-- format version
		1,	-- total model
		-- start iteration
			TRID.MODELSLOT_NONE, -- model part indesx
			modelName,		  -- model name
			1,	-- total morphing
			-- start iteration
				"defanim",	-- partname
				animName,
				FPS,
				true,	-- looping
				true,	-- is anim (false - customizing)
			-- end
		-- end
	}
	return data
end

TRID.MakeOnePropOfTerrain = function (data, heightmapName, modelName)
	data[#data + 1] = "CRenderTerrain"
	data["CRenderTerrain"] = 
	{
		"1",	-- format version
		heightmapName,
		modelName,
	}
	return data
end

TRID.MakeOnePropOfEditBox = function (data, defaultText, fontColor, fontSize, fontName, FONT_TypeStyle, limitWidth, limitTextInByte, boxSideGapW, boxSideGapH, boxLineGap, enableMultipleLine, caretColor, selColor, hiddenDisplayString)
	data[#data + 1] = "CEditBox"
	data["CEditBox"] = 
	{
		"CEditBox-3",	-- format version
		defaultText or "", 
		fontColor,
		fontSize or 10,
		fontName or "",
		FONT_TypeStyle or 0,
		limitWidth or -1,
		limitTextInByte or -1,
		boxSideGapW or 0,
		boxSideGapH or 0,
		boxLineGap or 0,
		enableMultipleLine or false,
		caretColor or TRID.XRGB(128,128,128),
		selColor or TRID.XRGB(128,128,128),
		hiddenDisplayString or "",
	}
	return data
end

TRID.MakeOnePropOfListBox = function (data, limitRow, limitColumn, itemWidth, itemHeight, boxEdgeGapW, boxEdgeGapH, boxColumnGap, boxRowGap, enableMultipleSelection, emptySlotProp, selectedProp, disabledProp, mouseOveredProp, listItemProp, hasViewport, mustHaveOneSelection, maxSlotSize, autoResizeRowColumn, fitViewport)
	if not (itemWidth and itemHeight and limitRow and limitColumn) then
		TRID.DebugPrint("TRID.MakeOnePropOfListBox - (itemWidth or itemHeight or limitRow or limitColumn) is nil.", "error")
		return data
	end
	data[#data + 1] = "CListBox"
	data["CListBox"] = {}
	local listBoxTable = data["CListBox"]

	listBoxTable[#listBoxTable + 1] = "CListBox-v002"
	listBoxTable[#listBoxTable + 1] = limitRow
	listBoxTable[#listBoxTable + 1] = limitColumn
	listBoxTable[#listBoxTable + 1] = itemWidth
	listBoxTable[#listBoxTable + 1] = itemHeight
	listBoxTable[#listBoxTable + 1] = boxEdgeGapW or 0
	listBoxTable[#listBoxTable + 1] = boxEdgeGapH or 0
	listBoxTable[#listBoxTable + 1] = boxColumnGap or 0
	listBoxTable[#listBoxTable + 1] = boxRowGap or 0
	listBoxTable[#listBoxTable + 1] = enableMultipleSelection or false
	listBoxTable[#listBoxTable + 1] = false
	listBoxTable[#listBoxTable + 1] = mustHaveOneSelection or false
	listBoxTable[#listBoxTable + 1] = maxSlotSize or -1

	local iconTotal = 0
	if emptySlotProp ~= nil then
		iconTotal = iconTotal + 1
	end
	if selectedProp ~= nil then
		iconTotal = iconTotal + 1
	end
	if disabledProp ~= nil then
		iconTotal = iconTotal + 1
	end
	if mouseOveredProp ~= nil then
		iconTotal = iconTotal + 1
	end

	listBoxTable[#listBoxTable + 1] = iconTotal

	if emptySlotProp ~= nil then
		listBoxTable[#listBoxTable + 1] = TRID.ICON_EMPTY_SLOT
		listBoxTable[#listBoxTable + 1] = false --load icon by base name
		listBoxTable[#listBoxTable + 1] = TRID.TABLE(emptySlotProp)
	end
	if selectedProp ~= nil then
		listBoxTable[#listBoxTable + 1] = TRID.ICON_SELECTED
		listBoxTable[#listBoxTable + 1] = false --load icon by base name
		listBoxTable[#listBoxTable + 1] = TRID.TABLE(selectedProp)
	end
	if disabledProp ~= nil then
		listBoxTable[#listBoxTable + 1] = TRID.ICON_DISABLED
		listBoxTable[#listBoxTable + 1] = false --load icon by base name
		listBoxTable[#listBoxTable + 1] = TRID.TABLE(disabledProp)
	end
	if mouseOveredProp ~= nil then
		listBoxTable[#listBoxTable + 1] = TRID.ICON_MOUSEOVERED
		listBoxTable[#listBoxTable + 1] = false --load icon by base name
		listBoxTable[#listBoxTable + 1] = TRID.TABLE(mouseOveredProp)
	end

	if listItemProp ~= nil then
		listBoxTable[#listBoxTable + 1] = #listItemProp
		for i=1, #listItemProp do
			listBoxTable[#listBoxTable + 1] = false --load icon by base name
			listBoxTable[#listBoxTable + 1] = listItemProp[i][1]
			listBoxTable[#listBoxTable + 1] = TRID.TABLE(listItemProp[i][2])
		end
	else
		listBoxTable[#listBoxTable + 1] = 0
	end
    
	local viewPort = true
	if hasViewport ~= nil then
		viewPort = hasViewport
	end
	
	listBoxTable[#listBoxTable + 1] = (autoResizeRowColumn == true)
	if (fitViewport == true) or (fitViewport == nil) then
		listBoxTable[#listBoxTable + 1] = true
	else
		listBoxTable[#listBoxTable + 1] = false
	end
	
	TRID.MakeFrameBase(data, viewPort, false, TRID.XRGB(0,0,0))
	return data
end

TRID.MakeOnePropOfLightDirectional = function (data, targetX, targetY, targetZ, ambi, diff, mainLight, lightIntensity, forLightmap)
	data[#data + 1] = "C3DLight"
	data["C3DLight"] = 
	{
		"C3DLight-v001",	-- format version
		targetX, targetY, targetZ,
		TRID.LIGHT_DIRECTIONAL,
		ambi or TRID.XRGB(255, 255, 255),
		diff or TRID.XRGB(255, 255, 255),
		diff or TRID.XRGB(255, 255, 255),   -- specular light
		mainLight or false,
		lightIntensity or 1,
		forLightmap or false,
	}
	return data
end

TRID.MakePointLight = function (data, targetX, targetY, targetZ, ambi, diff, attenZeroRange, attenRange, validCosine, lightIntensity)
	local angle = validCosine and math.acos(validCosine) * TRID.RAD2ANG
	return TRID.MakeOnePropOfLightPoint(data, targetX, targetY, targetZ, ambi, diff, attenRange, attenZeroRange, angle, angle,lightIntensity)
end

TRID.MakeOnePropOfLightPoint = function (data, targetX, targetY, targetZ, ambi, diff, attenStartRange, attenEndRange, attenStartAngleFromDir, attenEndAngleFromDir,lightIntensity, forLightmap)
	data[#data + 1] = "C3DLight"
	data["C3DLight"] = 
	{
		"C3DLight-v001",	-- format version
		targetX, targetY, targetZ,
		TRID.LIGHT_POINT,
		ambi,
		diff,
		diff,   -- specular light
		attenEndRange,
		attenStartRange,
		attenStartAngleFromDir and math.cos(attenStartAngleFromDir*TRID.ANG2RAD) or -1,
		attenEndAngleFromDir and math.cos(attenEndAngleFromDir*TRID.ANG2RAD) or -1,
		lightIntensity or 1,
		forLightmap or false,
	}
	return data
end

TRID.MakeOnePropOfMoveHeader = function (data, MSG_TypeGrabID, MSG_TypeReleaseID, MOVEHEADER_TypeFlag, targetInstance, enable)
	local enableFlag = enable and true
	if enable == nil then
		enableFlag = true
	end
	data[#data + 1] = "CMoveHeader"
	data["CMoveHeader"] = 
	{
		"CMoveHeader-v001",	-- format version
		MSG_TypeGrabID or TRID.MSG_LBUTTON_DOWN,
		MSG_TypeReleaseID or TRID.MSG_LBUTTON_UP,
		MOVEHEADER_TypeFlag or TRID.MOVEHEADER_WHOLE_IN_WINDOW,
		targetInstance and targetInstance._baseID[1] or 0, 
		targetInstance and targetInstance._baseID[2] or 0, 
		enableFlag,
	}
	return data
end

TRID.MakeOnePropOfFog = function (data, FOG_mode, fogColor, fogDensity)
	data[#data + 1] = "CFogObject"
	data["CFogObject"] = 
	{
		"1",	-- format version
		FOG_mode,
		fogColor,
		fogDensity,
	}
	return data
end

TRID.MakeOnePropOfScrollBar = function (data, targetInstance, stepSize, thumbProp, increaserProp, decreaserProp)
	local target = targetInstance
	if targetInstance and targetInstance._graphic then
		target = targetInstance._graphic
	end
	data[#data + 1] = "CScrollBar"
	data["CScrollBar"] = 
	{
		"1",	-- format version
		target and target._baseID[1] or 0,
		target and target._baseID[2] or 0,
		false,  -- is slider?
		stepSize,
		TRID.FOID_GUI_OBJECT, -- thumb FOID
		TRID.TABLE(thumbProp),
	}
	
	local tableData = data["CScrollBar"]
	if increaserProp then
		table.insert(tableData, TRID.FOID_BUTTON)
		table.insert(tableData, TRID.TABLE(increaserProp))
	else
		table.insert(tableData, TRID.FOID_NULL)
	end
	
	if decreaserProp then
		table.insert(tableData, TRID.FOID_BUTTON)
		table.insert(tableData, TRID.TABLE(decreaserProp))
	else
		table.insert(tableData, TRID.FOID_NULL)
	end
	return data
end

TRID.MakeScrollBar = function (data, targetID1, targetID2, stepSize, thumbProp, increaserProp, decreaserProp)
	TRID.MakeOnePropOfScrollBar(data, {_baseID = {targetID1, targetID2}}, stepSize, thumbProp, increaserProp, decreaserProp)
	return data
end

TRID.MakeHeadConstraints = function (headMinDegree, headMaxDegree, headSensitivity)
	return {headMinDegree, headMaxDegree, headSensitivity or 0.4}
end
TRID.MakePitchConstraints = function (pitchMinDegree, pitchMaxDegree, pitchSensitivity)
	return {pitchMinDegree, pitchMaxDegree, pitchSensitivity or 0.4}
end
TRID.MakePanConstraints = function (panSensitivity, noArgu1, noArgu2)
	local sense = panSensitivity
	-- for support to old function format : (panMinHeight, panMaxHeight, panSensitivity)
	if noArgu1 ~= nil or noArgu2 ~= nil then
		sense = noArgu2
	end
	return {sense or 0.3}
end
TRID.MakeZoomConstraints = function (zoomMinDistance, zoomMaxDistance, zoomSensitivity)
	return {zoomMinDistance, zoomMaxDistance, zoomSensitivity or 0.1}
end
TRID.MakeProjectionInfo = function (near, far, asp, fovV, left, top, right, bottom, perspective, backGroundNear, backGroundFar)
	return TRID.MakeProjectionData(near, far, asp, fovV * TRID.RAD2ANG, perspective == 1 and 0 or left, perspective == 1 and 0 or top, perspective == 1 and 0 or right, perspective == 1 and 0 or bottom, perspective, backGroundNear, backGroundFar)
end
TRID.MakeProjectionData = function (near, far, asp, fovVInDegree, left, top, right, bottom, perspective, backGroundNear, backGroundFar)
	return {near, far, asp, fovVInDegree * TRID.ANG2RAD, left, top, right, bottom, perspective, backGroundNear or 2, backGroundFar or 2000}
end
TRID.FovVToFovHInDegree = function (asp, fovV)
	if not (asp and fovV) then
		TRID.DebugPrint("TRID.FovVToFovHInDegree - asp or fovV is nil.", "error")
		return fovV
	end
	-- fovV = atan(h*0.5/d) * rad2ang * 2
	-- fovH = atan(w*0.5/d) * rad2ang * 2
	-- asp = w/h
	-- hence, fovH = atan(asp * tan(fovV*0.5*ang2rad)) * rad2ang * 2
	return math.atan(asp * math.tan(fovV * 0.5 * TRID.ANG2RAD)) * TRID.RAD2ANG * 2
end
TRID.FovHToFovVInDegree = function (asp, fovH)
	if not (asp and fovH) then
		TRID.DebugPrint("TRID.FovHToFovVInDegree - asp or fovH is nil.", "error")
		return fovH
	end
	-- fovV = atan(h*0.5/d) * rad2ang * 2
	-- fovH = atan(w*0.5/d) * rad2ang * 2
	-- asp = w/h
	-- hence, fovV = atan(tan(fovH*0.5*ang2rad) / asp) * rad2ang * 2
	return math.atan(math.tan(fovH * 0.5 * TRID.ANG2RAD) / asp) * TRID.RAD2ANG * 2
end
--~ TRID.MakeOnePropOfBaseController = function (data, rotationInputs, rotateTargetOrEye, headConstraints, pitchConstraints, panInputs, VK_TypePanUpDownKey, panConstraints, zoomInputs, zoomConstraints, headPitchSmoothMove, zoomAutoTarget, controlRange, offsetPos)
TRID.MakeOnePropOfBaseController = function (data, CONTROL_TypeFlag_RotationInputs, rotationInputs_RotateTargetOrEye, headConstraints, pitchConstraints, panInputs, VK_TypePanUpDownKey, panConstraints, zoomInputs, zoomConstraints, controlRange_HeadPitchSmoothMove, offsetPos_ZoomAutoTarget, none_controlRange)
	data[#data + 1] = "CBaseController"
	data["CBaseController"] = {}
	local dataTable = data["CBaseController"]

	local rotationInputs = nil
	local rotateTargetOrEye = nil
	local headPitchSmoothMove = nil
	local zoomAutoTarget = nil
	local controlRange = nil
	local offsetPos = nil
	if CONTROL_TypeFlag_RotationInputs and type(CONTROL_TypeFlag_RotationInputs) == "number" then
		dataTable[#dataTable + 1] = "CBaseController-v009"
		
		-- controlMode
		dataTable[#dataTable + 1] = CONTROL_TypeFlag_RotationInputs
		rotationInputs = rotationInputs_RotateTargetOrEye
		controlRange = controlRange_HeadPitchSmoothMove
		offsetPos = offsetPos_ZoomAutoTarget
	else
		dataTable[#dataTable + 1] = "CBaseController-v008"
		
		rotationInputs = CONTROL_TypeFlag_RotationInputs
		rotateTargetOrEye = rotationInputs_RotateTargetOrEye
		headPitchSmoothMove = controlRange_HeadPitchSmoothMove
		zoomAutoTarget = offsetPos_ZoomAutoTarget
		controlRange = none_controlRange
	end
	
	local hasRange = false
	if controlRange then
		if type(controlRange) == "table" and #controlRange == 6 then
			hasRange = true
			dataTable[#dataTable + 1] = true
			dataTable[#dataTable + 1] = controlRange[1] or -TRID.HUGE_NUMBER
			dataTable[#dataTable + 1] = controlRange[2] or -TRID.HUGE_NUMBER
			dataTable[#dataTable + 1] = controlRange[3] or -TRID.HUGE_NUMBER
			dataTable[#dataTable + 1] = controlRange[4] or TRID.HUGE_NUMBER
			dataTable[#dataTable + 1] = controlRange[5] or TRID.HUGE_NUMBER
			dataTable[#dataTable + 1] = controlRange[6] or TRID.HUGE_NUMBER
		else
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - controlRange is not a array table with 6 elements.", "error")
		end
	end
	
	if not hasRange then
		dataTable[#dataTable + 1] = false
	end
	
	local totRotation = 0
	if rotationInputs then
		if type(rotationInputs) == "table" then
			totRotation = #rotationInputs
		else
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - rotationInputs is not a table.", "error")
		end
	end
	dataTable[#dataTable + 1] = totRotation
	dataTable[#dataTable + 1] = rotateTargetOrEye or false
	for i=1, totRotation do
		if not rotationInputs[i] then
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - rotationInputs has a nil value.", "error")
		end
		dataTable[#dataTable + 1] = rotationInputs[i]
	end
	
	if totRotation > 0 then
		local hasHeadConstraint = false
		if headConstraints then
			if type(headConstraints) == "table" and #headConstraints == 3 then
				hasHeadConstraint = true
			else
				TRID.DebugPrint("TRID.MakeOnePropOfBaseController - headConstraints must be a table with [1] = headMinDegree, [2] = headMaxDegree and [3] = headSensitivity.", "error")
			end
		end
		dataTable[#dataTable + 1] = hasHeadConstraint
		if hasHeadConstraint then
			dataTable[#dataTable + 1] = headConstraints[1]
			dataTable[#dataTable + 1] = headConstraints[2]
			dataTable[#dataTable + 1] = headConstraints[3]
		end
		
		local hasPitchConstraint = false
		if pitchConstraints then
			if type(pitchConstraints) == "table" and #pitchConstraints == 3 then
				hasPitchConstraint = true
			else
				TRID.DebugPrint("TRID.MakeOnePropOfBaseController - pitchConstraints must be a table with [1] = pitchMinDegree, [2] = pitchMaxDegree and [3] = pitchSensitivity.", "error")
			end
		end
		dataTable[#dataTable + 1] = hasPitchConstraint
		if hasPitchConstraint then
			dataTable[#dataTable + 1] = pitchConstraints[1]
			dataTable[#dataTable + 1] = pitchConstraints[2]
			dataTable[#dataTable + 1] = pitchConstraints[3]
		end
		
		dataTable[#dataTable + 1] = headPitchSmoothMove or false
	end
	
	local totPan = 0
	if panInputs then
		if type(panInputs) == "table" then
			totPan = #panInputs
		else
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - panInputs is not a table.", "error")
		end
	end
	dataTable[#dataTable + 1] = totPan
	if totPan > 0 then
		dataTable[#dataTable + 1] = VK_TypePanUpDownKey or 0
		for i=1, totPan do
			if not panInputs[i] then
				TRID.DebugPrint("TRID.MakeOnePropOfBaseController - panInputs has a nil value.", "error")
			end
			dataTable[#dataTable + 1] = panInputs[i]
		end
		if panConstraints then
			dataTable[#dataTable + 1] = true
			if type(panConstraints) == "table" then
				local hasPanConstraint = false
				if #panConstraints == 1 then
					hasPanConstraint = true
				else
					TRID.DebugPrint("TRID.MakeOnePropOfBaseController - panConstraints must be a table with [1] = panSensitivity.", "error")
				end
				if hasPanConstraint then
					dataTable[#dataTable + 1] = panConstraints[1]	-- sensitivity
				else
					dataTable[#dataTable + 1] = 0.3	-- sensitivity
				end
			else
				dataTable[#dataTable + 1] = panConstraints	-- sensitivity
			end
		else
			dataTable[#dataTable + 1] = false
		end
	end
	
	local totZoom = 0
	if zoomInputs then
		if type(zoomInputs) == "table" then
			totZoom = #zoomInputs
		else
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - zoomInputs is not a table.", "error")
		end
	end
	dataTable[#dataTable + 1] = totZoom
	for i=1, totZoom do
		if not zoomInputs[i] then
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - zoomInputs has a nil value.", "error")
		end
		dataTable[#dataTable + 1] = zoomInputs[i]
	end
	if totZoom > 0 then
		local hasZoomConstraint = false
		if zoomConstraints then
			if type(zoomConstraints) == "table" and #zoomConstraints == 3 then
				hasZoomConstraint = true
			else
				TRID.DebugPrint("TRID.MakeOnePropOfBaseController - zoomConstraints must be a table with [1] = zoomMinDistance, [2] = zoomMaxDistance and [3] = zoomSensitivity.", "error")
			end
		end
		dataTable[#dataTable + 1] = hasZoomConstraint
		if hasZoomConstraint then
			dataTable[#dataTable + 1] = zoomConstraints[1]
			dataTable[#dataTable + 1] = zoomConstraints[2]
			dataTable[#dataTable + 1] = zoomConstraints[3]
		end
		dataTable[#dataTable + 1] = (zoomAutoTarget == true)
	end
	
	dataTable[#dataTable + 1] = false
	
	if offsetPos then
		if type(offsetPos) == "table" and #offsetPos == 3 then
			dataTable[#dataTable + 1] = true
			dataTable[#dataTable + 1] = offsetPos[1]
			dataTable[#dataTable + 1] = offsetPos[2]
			dataTable[#dataTable + 1] = offsetPos[3]
		else
			TRID.DebugPrint("TRID.MakeOnePropOfBaseController - offsetPos must be a vector3 table.", "error")
			dataTable[#dataTable + 1] = false
		end
	else
		dataTable[#dataTable + 1] = false
	end
	
	return data
end

TRID.MakeOnePropOfBoneBox = function (data, boneTargetInstance, boneLinkLineColor, boneBox3DProp)
	local targetID = boneTargetInstance
	if boneTargetInstance and boneTargetInstance._baseID then
		targetID = boneTargetInstance._baseID
	end
	data[#data + 1] = "CBoneBox"
	data["CBoneBox"] = 
	{
		"1",	-- format version
		targetID and targetID[1] or 0, targetID and targetID[2] or 0, -- target ID
		boneLinkLineColor or TRID.ARGB(255,128,128,128), -- color of line between parent and child bone.
		TRID.FOID_3D_OBJECT, -- bone box FOID
		TRID.TABLE(boneBox3DProp),
	}
	return data
end

TRID.MakeOnePropOfEnvironmentMapManager = function (data, clearColor, mapSize, shaderList)
	data[#data + 1] = "CEnvironmentMapManager"
	data["CEnvironmentMapManager"] = {}
	local dataTable = data["CEnvironmentMapManager"]
	table.insert(dataTable, "CEnvironmentMapManager-3")
	if clearColor then
		table.insert(dataTable, true)
		table.insert(dataTable, clearColor)
	else
		table.insert(dataTable, false)
	end
	table.insert(dataTable, mapSize or 1024)
	if shaderList then
		table.insert(dataTable, #shaderList)
		for i=1, #shaderList do
			table.insert(dataTable, shaderList[i][1])	-- add shader type index
			table.insert(dataTable, TRID.TABLE(shaderList[i][2]))	-- add post effector prop
		end
	else
		table.insert(dataTable, 0)
	end
	return data
end

TRID.MakeOnePropOfProjectionShadowManager = function (data, clearColor, mapSize)
	data[#data + 1] = "CProjectionShadowManager"
	data["CProjectionShadowManager"] = {}
	local dataTable = data["CProjectionShadowManager"]
	table.insert(dataTable, "1")
	if clearColor then
		table.insert(dataTable, true)
		table.insert(dataTable, clearColor)
	else
		table.insert(dataTable, false)
	end
	table.insert(dataTable, mapSize or 1024)
	return data
end

TRID.MakeOnePropOfShadowMapManager = function (data, enable, mapSize, sceneBox, makeShadowmapPixelCode, renderWithShadowmapDiffuseFactorCodeOrProp, softShadowEffectorProp, softShadowRenderCodeOrProp)
	data[#data + 1] = "CShadowMapManager"
	data["CShadowMapManager"] = {}
	local dataTable = data["CShadowMapManager"]
	table.insert(dataTable, "CShadowMapManager-v001")
	table.insert(dataTable, enable or false)
	if enable then
		table.insert(dataTable, mapSize or 1024)
		table.insert(dataTable, mapSize or 1024)
		
		table.insert(dataTable, sceneBox and sceneBox[1] or -1)
		table.insert(dataTable, sceneBox and sceneBox[2] or -1)
		table.insert(dataTable, sceneBox and sceneBox[3] or -1)
		table.insert(dataTable, sceneBox and sceneBox[4] or 1)
		table.insert(dataTable, sceneBox and sceneBox[5] or 1)
		table.insert(dataTable, sceneBox and sceneBox[6] or 1)
		
		table.insert(dataTable, true)
		local materialMaker = TRID.GetMaterialMakerInterface()
		materialMaker:Init("makeShadowmap")
		if makeShadowmapPixelCode then
			materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DEFAULT_MATERIAL_COLOR, makeShadowmapPixelCode)
		else
			materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DEFAULT_MATERIAL_COLOR, "FLOAT depth = SCREEN_POSITION.z/SCREEN_POSITION.w;\nreturn FLOAT4(depth,depth,depth,depth);")
		end
		table.insert(dataTable, TRID.TABLE(materialMaker:Build()))
		
		
		table.insert(dataTable, true)
		if ((not renderWithShadowmapDiffuseFactorCodeOrProp) or type(renderWithShadowmapDiffuseFactorCodeOrProp) == "string") then
			materialMaker = TRID.GetMaterialMakerInterface()
			materialMaker:Init("renderWithShadowmap")
			if renderWithShadowmapDiffuseFactorCodeOrProp then
				materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DIFFUSE_FACTOR, renderWithShadowmapDiffuseFactorCodeOrProp)
			else
				materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DIFFUSE_FACTOR, "FLOAT diffuseFactor = DOT(_NORMAL_IN_PIXEL, _LIGHT_DIRECTION_IN_PIXEL);\nFLOAT shadow = SHADOWMAP(SHADOWMAP_UV).x;\nreturn diffuseFactor * STEP(0.0, diffuseFactor) * (1.0 - STEP(0.0, SHADOWMAP_DEPTH.z/SHADOWMAP_DEPTH.w - shadow));")
			end
			table.insert(dataTable, TRID.TABLE(materialMaker:Build()))
		else
			table.insert(dataTable, TRID.TABLE(renderWithShadowmapDiffuseFactorCodeOrProp))
		end
		
		if softShadowEffectorProp and type(softShadowEffectorProp) == "table" then
			table.insert(dataTable, true)
			table.insert(dataTable, TRID.TABLE(softShadowEffectorProp))
		
			if ((not softShadowRenderCodeOrProp) or type(softShadowRenderCodeOrProp) == "string") then
				materialMaker = TRID.GetMaterialMakerInterface()
				materialMaker:Init("renderForSoftShadow")
				if softShadowRenderCodeOrProp and type(softShadowRenderCodeOrProp) == "string" then
					materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DIFFUSE_FACTOR, softShadowRenderCodeOrProp)
				else
					materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_DIFFUSE_FACTOR, "FLOAT diffuseFactor = MAX(0.0, DOT(_NORMAL_IN_PIXEL, _LIGHT_DIRECTION_IN_PIXEL)); return diffuseFactor * SCREENMAP(SCREENMAP_UV).r;")
				end
				table.insert(dataTable, TRID.TABLE(materialMaker:Build()))
			else
				table.insert(dataTable, TRID.TABLE(softShadowRenderCodeOrProp))
			end
		else
			if softShadowEffectorProp then
				TRID.DebugPrint("TRID.MakeOnePropOfShadowMapManager - softShadowEffectorProp must be a post effector property table.")
			end
			table.insert(dataTable, false)
		end
		
	end
	
	return data
end

TRID.InsertPostEffectData = function (data, texWidth, texHeight, POST_EFFECT_Type, materialProp)
	local flag = POST_EFFECT_Type or 0
	if not materialProp then
		flag = flag + TRID.POST_EFFECT_NO_SHADER
	end
	table.insert(data, {width = texWidth or 0, height = texHeight or 0, xScale = xScale or 1, yScale = yScale or 1, xExtent = xExtent or 1, yExtent = yExtent or 1, flag = flag, shader = materialProp})
	return data
end

TRID.InsertPostEffectData2 = function (data, texWidth, texHeight, xScale, yScale, xExtent, yExtent, POST_EFFECT_Type, materialProp)
	local flag = POST_EFFECT_Type or 0
	if not materialProp then
		flag = flag + TRID.POST_EFFECT_NO_SHADER
	end
	table.insert(data, {width = texWidth or 0, height = texHeight or 0, xScale = xScale or 1, yScale = yScale or 1, xExtent = xExtent or 1, yExtent = yExtent or 1, flag = flag, shader = materialProp})
	return data
end

TRID.MakeOnePropOfPostEffector = function (data, postEffectDataList, originalWidth, originalHeight, materialMask, POST_EFFECT_Type)
	data[#data + 1] = "CPostEffector"
	data["CPostEffector"] = {}
	local dataTable = data["CPostEffector"]
	table.insert(dataTable, "CPostEffector-v003")
	table.insert(dataTable, originalWidth or 0)
	table.insert(dataTable, originalHeight or 0)
	table.insert(dataTable, materialMask or TRID.MATERIAL_ALL_MASK)
	table.insert(dataTable, POST_EFFECT_Type or 0)
	if postEffectDataList then
		table.insert(dataTable, #postEffectDataList)
		local i
		for i=1, #postEffectDataList do
			table.insert(dataTable, postEffectDataList[i].width)
			table.insert(dataTable, postEffectDataList[i].height)
			table.insert(dataTable, postEffectDataList[i].xScale)
			table.insert(dataTable, postEffectDataList[i].yScale)		
			table.insert(dataTable, postEffectDataList[i].xExtent)
			table.insert(dataTable, postEffectDataList[i].yExtent)	
			table.insert(dataTable, postEffectDataList[i].flag)
			if postEffectDataList[i].shader then
				table.insert(dataTable, TRID.TABLE(postEffectDataList[i].shader))
			end
		end
	else
		table.insert(dataTable, 0)
	end
	return data
end

TRID.MakeOnePropOfMouseInputGenerator = function (data, wParamForMoveMessage)
	data[#data + 1] = "CMouseInputGenerator"
	data["CMouseInputGenerator"] = {}
	local dataTable = data["CMouseInputGenerator"]
	table.insert(dataTable, "1")
	table.insert(dataTable, wParamForMoveMessage or 0)
	return data
end

TRID.MakeOnePropOfAnimationFrameController = function (data, targetDataList)
	data[#data + 1] = "CAnimationFrameController"
	data["CAnimationFrameController"] = {}
	local dataTable = data["CAnimationFrameController"]
	table.insert(dataTable, "1")
	local total = targetDataList and #targetDataList or 0
	table.insert(dataTable, total)
	for i=1, total do
		local d = targetDataList[i]
		table.insert(dataTable, d[1]._baseID[1])
		table.insert(dataTable, d[1]._baseID[2])
		table.insert(dataTable, d[2])
	end
	return data
end

TRID.MakeOnePropOfShaderVariableController = function (data, targetDataList)
	data[#data + 1] = "CShaderVariableController"
	data["CShaderVariableController"] = {}
	local dataTable = data["CShaderVariableController"]
	table.insert(dataTable, "1")
	local total = targetDataList and #targetDataList or 0
	table.insert(dataTable, total)
	for i=1, total do
		local d = targetDataList[i]
		table.insert(dataTable, d[1]._baseID[1])
		table.insert(dataTable, d[1]._baseID[2])
		table.insert(dataTable, d[2])
		if type(d[3]) == "string" then
			table.insert(dataTable, false)
			table.insert(dataTable, d[3])
		else
			table.insert(dataTable, true)
			table.insert(dataTable, d[3])
		end
		table.insert(dataTable, d[4])
	end
	return data
end

TRID.MakeOnePropOfBoneCustomizingController = function (data, targetDataList)
	data[#data + 1] = "CBoneCustomizingController"
	data["CBoneCustomizingController"] = {}
	local dataTable = data["CBoneCustomizingController"]
	table.insert(dataTable, "1")
	local total = targetDataList and #targetDataList or 0
	table.insert(dataTable, total)
	for i=1, total do
		local d = targetDataList[i]
		table.insert(dataTable, d[1]._baseID[1])
		table.insert(dataTable, d[1]._baseID[2])
		local boneTable = d[2]
		local totBone = boneTable and #boneTable or 0
		table.insert(dataTable, totBone)
		for b=1, totBone do
			local d = boneTable[b]
			table.insert(dataTable, d[1])
			table.insert(dataTable, d[2])
			table.insert(dataTable, d[3])
			table.insert(dataTable, d[4])
			table.insert(dataTable, d[5])
		end
	end
	return data
end

TRID.MakeOnePropOfMotionController = function (data, targetDataList)
	data[#data + 1] = "CMotionController"
	data["CMotionController"] = {}
	local dataTable = data["CMotionController"]
	table.insert(dataTable, "CMotionController-v001")
	local total = targetDataList and #targetDataList or 0
	table.insert(dataTable, total)
	for i=1, total do
		local d = targetDataList[i]
		table.insert(dataTable, d[1]._baseID[1])
		table.insert(dataTable, d[1]._baseID[2])
		local boneTable = d[2]
		local totBone = boneTable and #boneTable or 0
		table.insert(dataTable, totBone)
		for b=1, totBone do
			local d = boneTable[b]
			table.insert(dataTable, d[1])
			local isSlider = false
			if d[2]~=nil and type(d[2]) == "boolean" then
				-- insert same as d[1]
				table.insert(dataTable, d[1])
				isSlider = (d[2] == true)
			else
				table.insert(dataTable, d[2])
			end
			if d[3] then
				table.insert(dataTable, d[3][1])
				table.insert(dataTable, d[3][2])
				table.insert(dataTable, d[3][3])
			else
				table.insert(dataTable, 0)
				table.insert(dataTable, 0)
				table.insert(dataTable, 0)
			end
			if d[4] then
				table.insert(dataTable, d[4][1])
				table.insert(dataTable, d[4][2])
				table.insert(dataTable, d[4][3])
			else
				table.insert(dataTable, 0)
				table.insert(dataTable, 0)
				table.insert(dataTable, 0)
			end
			if d[5] then
				table.insert(dataTable, d[5][1])
				table.insert(dataTable, d[5][2])
				table.insert(dataTable, d[5][3])
			else
				table.insert(dataTable, 1)
				table.insert(dataTable, 1)
				table.insert(dataTable, 1)
			end
			table.insert(dataTable, isSlider)
			-- adjust 
			if d[6] then
				table.insert(dataTable, d[6])
			else
				table.insert(dataTable, false)
			end
			-- source  original
			if d[7] then
				table.insert(dataTable, d[7])
			else
				table.insert(dataTable, false)
			end
		end
	end
	return data
end

TRID.MakeOnePropOfBoundingInterfaceController = function (data, targetDataList)
	data[#data + 1] = "CBoundingInterfaceController"
	data["CBoundingInterfaceController"] = {}
	local dataTable = data["CBoundingInterfaceController"]
	table.insert(dataTable, "1")
	local total = targetDataList and #targetDataList or 0
	table.insert(dataTable, total)
	for i=1, total do
		local d = targetDataList[i]
		table.insert(dataTable, d[1]._baseID[1])
		table.insert(dataTable, d[1]._baseID[2])
	end
	return data
end

TRID.MakeOnePropOfCameraPropertyController = function (data, targetCamera, PROJ_TypeID)
	data[#data + 1] = "CCameraPropertyController"
	data["CCameraPropertyController"] = {}
	local dataTable = data["CCameraPropertyController"]
	table.insert(dataTable, "1")
	table.insert(dataTable, targetCamera and targetCamera._baseID[1] or 0)
	table.insert(dataTable, targetCamera and targetCamera._baseID[2] or 0)
	table.insert(dataTable, PROJ_TypeID)
	return data
end

TRID.MakeOnePropOfLightPropertyController = function (data, targetLight, LIGHT_PROPERTY_TypeID)
	data[#data + 1] = "CLightPropertyController"
	data["CLightPropertyController"] = {}
	local dataTable = data["CLightPropertyController"]
	table.insert(dataTable, "1")
	table.insert(dataTable, targetLight and targetLight._baseID[1] or 0)
	table.insert(dataTable, targetLight and targetLight._baseID[2] or 0)
	table.insert(dataTable, LIGHT_PROPERTY_TypeID)
	return data
end

TRID.MakeOnePropOfScrollBarController = function (data, scrollBarInstance, isVertical, viewSize, contentsSize)
	local rot = isVertical and {0,0,-90} or {0,0,0}
	local scale = 1/(viewSize - contentsSize);
	local sca = {scale,scale,scale}
	return TRID.MakeOnePropOfMotionController(data, {{scrollBarInstance, {{TRID.MOTION_POSITION, true, nil, rot, sca}}}})
end

TRID.MakePropsOf3DView = function (data, x,y, width, height, clearColor, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_NULL)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfFrameBase(data, true, true, clearColor)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfFrameBase = function (data, x,y, width, height, color, fill, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfFrameBase(data, true, false, TRID.XRGB(0,0,0))
	TRID.MakePropsOfGUIWithColor(data, x,y, width, height, color, fill, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfFrameWithPatternImage = function (data, x,y, width, height, imagePatternTable, clipToGUISize, LAYOUT_TypeFlag, MOVEHEADER_TypeFlag, hasViewport, blockKeyMessage, enableMoveHeader, clearScreenMode)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfFrameBase(data, hasViewport, clearScreenMode, TRID.XRGB(0,0,0))
	TRID.MakeOnePropOfRender2DWithPatternImage(data, clipToGUISize, imagePatternTable)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfMoveHeader(data, TRID.MSG_LBUTTON_DOWN, TRID.MSG_LBUTTON_UP, MOVEHEADER_TypeFlag, nil, enableMoveHeader)
	TRID.MakeOnePropOfFrame(data, blockKeyMessage)
	return data
end

TRID.MakePropsOfFrameWithColor = function (data, x,y, width, height, color, fill, LAYOUT_TypeFlag, MOVEHEADER_TypeFlag, hasViewport, blockKeyMessage, enableMoveHeader, clearScreenMode)
	TRID.MakeOnePropOfFrameBase(data, hasViewport, clearScreenMode, TRID.XRGB(0,0,0))
	TRID.MakePropsOfGUIWithColor(data, x,y, width, height, color, fill, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfMoveHeader(data, TRID.MSG_LBUTTON_DOWN, TRID.MSG_LBUTTON_UP, MOVEHEADER_TypeFlag, nil, enableMoveHeader)
	TRID.MakeOnePropOfFrame(data, blockKeyMessage)
	return data
end

TRID.MakePropsOfCameraInSimple = function (data, radius, color)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_SPHERE, TRID.FOID_RENDER_3D)
	TRID.MakeOnePropOfBoundingSphere(data, radius, 0,0,0)
	TRID.MakeOnePropOfRender3D(data, color, false)
	TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_HIDE)
	return data
end

TRID.MakePropsOfCameraInDetail = function (data, targetVector, upVector, projectionInfo, CAMFLAG_TypeFlag, defaultRenderShaderProp)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_SPHERE, TRID.FOID_RENDER_3D)
	TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_HIDE)
	
	data[#data + 1] = "C3DCamera"
	data["C3DCamera"] = {}
	local dataTable = data["C3DCamera"]
	
	dataTable[#dataTable + 1] = "C3DCamera-v002"	-- format version
	dataTable[#dataTable + 1] = targetVector[1]
	dataTable[#dataTable + 1] = targetVector[2]
	dataTable[#dataTable + 1] = targetVector[3]
	dataTable[#dataTable + 1] = upVector[1]
	dataTable[#dataTable + 1] = upVector[2]
	dataTable[#dataTable + 1] = upVector[3]	
	if projectionInfo then
		dataTable[#dataTable + 1] = true
		for i=1, #projectionInfo do
			dataTable[#dataTable + 1] = projectionInfo[i]
		end
	else
		dataTable[#dataTable + 1] = false
	end
	dataTable[#dataTable + 1] = CAMFLAG_TypeFlag or 0
	
	if defaultRenderShaderProp then
		table.insert(dataTable, true)
		table.insert(dataTable, TRID.TABLE(defaultRenderShaderProp))
	else
		table.insert(dataTable, false)
	end
		
	return data
end

TRID.MakePropsOfLightDirectional = function (data, emitDirectionFromSource, ambiLight, diffLight, mainLight, lightIntensity, forLightmap)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_SPHERE, TRID.FOID_RENDER_3D)
	TRID.MakeOnePropOfBoundingSphere(data, 1, 0,0,0)
	TRID.MakeOnePropOfRender3D(data, ambiLight, false)
	TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_HIDE)
	TRID.MakeOnePropOfLightDirectional(data, emitDirectionFromSource[1], emitDirectionFromSource[2], emitDirectionFromSource[3], ambiLight, diffLight, mainLight, lightIntensity, forLightmap)
	return data
end

TRID.MakePropsOfLightPoint = function (data, emitDirectionFromSource, ambiLight, diffLight, attenStartRange, attenEndRange, attenStartAngleFromDir, attenEndAngleFromDir,lightIntensity, forLightmap)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_SPHERE, TRID.FOID_RENDER_3D)
	TRID.MakeOnePropOfBoundingSphere(data, 1, 0,0,0)
	TRID.MakeOnePropOfRender3D(data, ambiLight, false)
	TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_HIDE)
	TRID.MakeOnePropOfLightPoint(data, emitDirectionFromSource[1], emitDirectionFromSource[2], emitDirectionFromSource[3], ambiLight, diffLight, attenStartRange, attenEndRange, attenStartAngleFromDir, attenEndAngleFromDir,lightIntensity, forLightmap)
	return data
end

TRID.MakePropsOfBox = function (data, x1,y1,z1, x2,y2,z2, color, drawFill, depthTest)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_3D)
	TRID.MakeOnePropOfBoundingBox(data, x1,y1,z1, x2,y2,z2)
	TRID.MakeOnePropOfRender3D(data, color, drawFill)
	if depthTest == false then
		TRID.MakeOnePropOfRenderObject(data, TRID.RENDER_NO_DEPTH)
	end
	return data
end

--~ TRID.MakePropsOfEffector = funciton (data, asdasd)
--~ 	TRID.MakeOnePropsOfParticle(data, #emitterList, #affectorList)
--~ 	TRID.MakeOnePropOfEmitter(data, emitterList)
--~ 	TRID.MakeOnePropOfAffector(data, affectorList)
--~ end

--~ TRID.MakeOnePropOfEmitter = function (data, list)
--~ 	data[#data + 1] = "CEmiiter"
--~ 	data["CEmiiter"] = {}
--~ 	local dataTable = data["CEmiiter"]
--~ 	
--~ 	dataTable[#dataTable + 1] = "1"
--~ 	dataTable[#dataTable + 1] = #list
--~ 	for i=1, #list do
--~ 		dataTable[#dataTable + 1] = list[i].value1
--~ 		dataTable[#dataTable + 1] = list[i].value1
--~ 	end
--~ end

TRID.MakePropsOfLines = function (data, x1,y1,z1, x2,y2,z2, lineColor, lineListArray, RENDER_TypeFlag, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_LINE, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfBoundingBox(data, x1,y1,z1, x2,y2,z2)
	TRID.MakeOnePropOfRenderLines(data, lineColor, lineListArray)
	TRID.MakeOnePropOfRenderObject(data, RENDER_TypeFlag)
	return data
end

TRID.MakePropsOfBoneBox = function (data, boundingBox, boneTargetInstance, boneLinkLineColor, boneBox3DProp, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_3D, RENDER_ORDER_Type, renderOrder)
	TRID.MakeOnePropOfRender3D(data, TRID.ARGB(0,0,0,0), false)
	if boundingBox then	
		TRID.MakeOnePropOfBoundingBox(data, boundingBox[1], boundingBox[2], boundingBox[3], boundingBox[4], boundingBox[5], boundingBox[6])
	else
		TRID.MakeOnePropOfBoundingInterfaceFor3D(data, TRID.XRGB(0,0,0), false, TRID.FLAG_BA_GLOBAL_PLACEMENT)
	end
	TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_NOT_PICKUP)
	TRID.MakeOnePropOfBoneBox(data, boneTargetInstance, boneLinkLineColor, boneBox3DProp)
	return data
end

TRID.MakePropsOfGrid = function (data, sizeX, sizeY, unitSize, lineColor, enablePickup, materialFile, materialName)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_BOX, TRID.FOID_RENDER_GRID)
	if sizeX == 0 and sizeY == 0 then
		TRID.MakeOnePropOfBoundingBox(data, -1,-1,0, 1,1,1, lineColor, false, TRID.FLAG_BA_GLOBAL_PLACEMENT)
	else
		TRID.MakeOnePropOfBoundingBox(data, -sizeX/2,-sizeY/2,0, sizeX/2,sizeY/2,1)
	end
	
	local hasMaterial = (materialFile ~= nil)

	data[#data + 1] = "CGridObject"
	local unitX,unitY
	if type(unitSize) == "number" then
		unitX = unitSize
		unitY = unitSize
	elseif type(unitSize) == "table" then
		unitX = unitSize[1]
		unitY = unitSize[2]
	end
	
	data["CGridObject"] = 
	{
		"CGridObject-v001",	-- format version
		unitX,
		unitY,
		lineColor,
		hasMaterial,
	}
	
	if hasMaterial then
		table.insert(data["CGridObject"], materialFile)
		table.insert(data["CGridObject"], materialName)
	end

	if not enablePickup then
		TRID.MakeOnePropOfNodeObject(data, TRID.FLAG_NOT_PICKUP)
	end
	return data
end

TRID.MakeOnePropOfButton = function (data, mouseOverImageProp, pressedImageProp, toolTipProp, toggle, imageDownIfPressed, disabledImageProp)
	data[#data + 1] = "CButton"
	data["CButton"] = {}
	local buttonTable = data["CButton"]
	local toggleType = TRID.TOGGLE_NONE
	if toggle == true then
		toggleType = TRID.TOGGLE_AT_CLICK
	elseif toggle then
		toggleType = toggle
	end

	buttonTable[#buttonTable + 1] = "CButton-4"     -- format version
	buttonTable[#buttonTable + 1] = toggleType
	buttonTable[#buttonTable + 1] = (mouseOverImageProp ~= nil) -- has mouse over state
	if (mouseOverImageProp ~= nil) then
		buttonTable[#buttonTable + 1] = TRID.TABLE(mouseOverImageProp)
	end
	buttonTable[#buttonTable + 1] = (pressedImageProp ~= nil) -- has pressed state
	if (pressedImageProp ~= nil) then
		buttonTable[#buttonTable + 1] = TRID.TABLE(pressedImageProp)
	end
	buttonTable[#buttonTable + 1] = (toolTipProp ~= nil) -- has tooltip
	if (toolTipProp ~= nil) then
		buttonTable[#buttonTable + 1] = TRID.TABLE(toolTipProp)
	end
	buttonTable[#buttonTable + 1] = imageDownIfPressed or false -- place image down if pressed
	
	buttonTable[#buttonTable + 1] = (disabledImageProp ~= nil) -- has disabled state
	if (disabledImageProp ~= nil) then
		buttonTable[#buttonTable + 1] = TRID.TABLE(disabledImageProp)
	end
	return data
end

TRID.MakePropsOfButton = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, mouseOverImageProp, pressedImageProp, toolTipProp, toggle, imageDownIfPressed, disabledImageProp)
	TRID.MakePropsOfGUIWithImage(data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfButton(data, mouseOverImageProp, pressedImageProp, toolTipProp, toggle, imageDownIfPressed, disabledImageProp)
	return data
end

TRID.SetPosition = function (baseID1, baseID2, x,y,z, rx,ry,rz, sx,sy,sz, hasMotion, LAYOUT_TypeFlag)
	local data = {}
	TRID.MakeOnePropOfPosition(data, x,y,z, rx,ry,rz, sx,sy,sz, hasMotion, LAYOUT_TypeFlag)
	TRIDGLUE.SetProperty(baseID1, baseID2, TRID.FOID_POSITION, data)
end

TRID.SetDirectionalLightProperty = function (baseID1, baseID2, targetX, targetY, targetZ, ambi, diff, mainLight)
	local data = {}
	TRID.MakeDirectionalLight(data, targetX, targetY, targetZ, ambi, diff, mainLight)
	TRIDGLUE.SetProperty(baseID1, baseID2, TRID.FOID_3D_LIGHT, data)
end

TRID.SetPointLightProperty = function (baseID1, baseID2, targetX, targetY, targetZ, ambi, diff, attenZeroRange, attenRange, validCosine,lightIntensity)
	local data = {}
	TRID.MakePointLight(data, targetX, targetY, targetZ, ambi, diff, attenZeroRange, attenRange, validCosine,lightIntensity)
	TRIDGLUE.SetProperty(baseID1, baseID2, TRID.FOID_3D_LIGHT, data)
end

TRID.MakePropsOfGUIWithImage = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, color)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithImage(data, imageName, opaName, clipToGUISize, color)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithColor = function (data, x,y, width, height, color, fill, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithColor(data, color, fill)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithGradationColor = function (data, x,y, width, height, colorLeftTop, colorRightTop, colorLeftBottom, colorRightBottom, fill, LAYOUT_TypeFlag, depthMask)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithGradationColor(data, colorLeftTop, colorRightTop, colorLeftBottom, colorRightBottom, fill, depthMask)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithRedirection = function (data, x,y, width, height, color, fill, LAYOUT_TypeFlag, depthMask, targetInstance)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithRedirection(data, color, fill, depthMask, targetInstance)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithPatternImage = function (data, x,y, width, height, imagePatternTable, clipToGUISize, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithPatternImage(data, clipToGUISize, imagePatternTable)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithPatternImageText = function (data, x,y, width, height, imagePatternTable, clipToGUISize, LAYOUT_TypeFlag, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithPatternImageText(data, clipToGUISize, imagePatternTable, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithImageStretch = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, widthStretchArray, heightStretchArray)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithImageStretch(data, imageName, opaName, clipToGUISize, widthStretchArray, heightStretchArray)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfGUIWithImageStretchText = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, widthStretchArray, heightStretchArray, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithImageStretchText(data, imageName, opaName, clipToGUISize, widthStretchArray, heightStretchArray, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.Make2DGUIPatternWithText = function (data, x,y, width, height, imagePatternTable, clipToGUISize, LAYOUT_TypeFlag, text, textColor, fontName, fontSize, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap)
	TRID.MakePropsOfGUIWithPatternImageText(data, x,y, width, height, imagePatternTable, clipToGUISize, LAYOUT_TypeFlag, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	return data
end

TRID.MakePropsOfGUIWithImageText = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithImageText(data, imageName, opaName, clipToGUISize, text, textColor,TRID.XRGB(255,255,255), true, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.Make2DGUIWithText = function (data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, text, textColor, fontName, fontSize, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap)
	TRID.MakePropsOfGUIWithImageText(data, x,y, width, height, imageName, opaName, clipToGUISize, LAYOUT_TypeFlag, text, textColor, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize)
	return data
end

TRID.MakePropsOfGUIWithText = function (data, x,y, width, height, text, textColor, bgColor, fill, LAYOUT_TypeFlag, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize, highlightThick)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width, height)
	TRID.MakeOnePropOfRender2DWithText(data, text, textColor, bgColor, fill, TEXTLAYOUT_TypeFlag, FONT_TypeStyle, textGap, lineGap, fontName, fontSize, highlightThick)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	return data
end

TRID.MakePropsOfHorizontalSlider = function (data, x,y, width, height, bgColor, fill, LAYOUT_TypeFlag, stepSize, thumbProp)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, -height,0, 0,width)
	TRID.MakeOnePropOfRender2DWithColor(data, bgColor, fill)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,-90, 1,1,1, false, LAYOUT_TypeFlag)
	
	data[#data + 1] = "CScrollBar"
	data["CScrollBar"] = 
	{
		"1",	-- format version
		0, 0,	-- taget base id
		true,  -- is slider?
		stepSize,
		TRID.FOID_GUI_OBJECT, -- thumb FOID
		TRID.TABLE(thumbProp),
		TRID.FOID_NULL,   -- up FOID
		TRID.FOID_NULL,   -- down FOID
	}
	return data
end

TRID.MakePropsOfHorizontalScrollBar = function (data, x,y, width, height, bgColor, fill, LAYOUT_TypeFlag, targetInstance, stepSize, thumbProp, increaserProp, decreaserProp)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, -height,0, 0,width)
	TRID.MakeOnePropOfRender2DWithColor(data, bgColor, fill)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,-90, 1,1,1, false, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfScrollBar(data, targetInstance, stepSize, thumbProp, increaserProp, decreaserProp)
	return data
end

TRID.MakePropsOfVerticalSlider = function (data, x,y, width, height, bgColor, fill, LAYOUT_TypeFlag, stepSize, thumbProp)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width,height)
	TRID.MakeOnePropOfRender2DWithColor(data, bgColor, fill)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	
	data[#data + 1] = "CScrollBar"
	data["CScrollBar"] = 
	{
		"1",	-- format version
		0, 0,	-- taget base id
		true,  -- is slider?
		stepSize,
		TRID.FOID_GUI_OBJECT, -- thumb FOID
		TRID.TABLE(thumbProp),
		TRID.FOID_NULL,   -- up FOID
		TRID.FOID_NULL,   -- down FOID
	}
	return data
end

TRID.MakePropsOfVerticalScrollBar = function (data, x,y, width, height, bgColor, fill, LAYOUT_TypeFlag, targetInstance, stepSize, thumbProp, increaserProp, decreaserProp)
	TRID.MakeOnePropOfGraphicObject(data, TRID.FOID_BOUNDING_INTERFACE, TRID.FOID_RENDER_2D)
	TRID.MakeOnePropOfBoundingRect(data, 0,0, width,height)
	TRID.MakeOnePropOfRender2DWithColor(data, bgColor, fill)
	TRID.MakeOnePropOfPosition(data, x,y,0, 0,0,0, 1,1,1, false, LAYOUT_TypeFlag)
	TRID.MakeOnePropOfScrollBar(data, targetInstance, stepSize, thumbProp, increaserProp, decreaserProp)
	return data
end

TRID.StartMaterial = function (formatVersion, materialName, inModelFile)
	local data = {}
	if not inModelFile then
		table.insert(data, 4)	-- resource format version.
	end
	table.insert(data, formatVersion)
	table.insert(data, materialName)
	return data
end

TRID.MakeAmbiMaterial1 = function (floatR, floatG, floatB, floatA)
    return {
        -- start iteration
        TRID.MATERIAL_AMBI_BIT,
        "1",    -- element format version
        1,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_FLOAT4, -- param type
            "1",    -- param format version
            true,   -- is default shader variable
            TRID.VAR_TOTALAMBIENT,  -- shader var index
            floatR, floatG, floatB, floatA,    -- vector4
            -- end
        -- end
        }
end

TRID.MakeDiffMaterial1 = function (diffuseMap, TEXTURE_TypeFlag, floatR, floatG, floatB, floatA, useThisMapPath)
    return {
        -- start iteration
        TRID.MATERIAL_DIFF_BIT,
        "1",    -- element format version
        2,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_IMAGE, -- param type
            "3",    -- param format version
            true,   -- is default shader variable
            TRID.TEX_DEFAULTTEXTURE,  -- shader var index
            diffuseMap or "",  -- map name
            TEXTURE_TypeFlag or TRID.TEXTURE_2D,   -- map property
            "", -- alpha map name
            1,1,1,1, -- alpha ratio
            true,   -- set this texture property
	    useThisMapPath or false,
            -- end
            -- start iteration
            TRID.MATERIAL_PARAM_FLOAT4, -- param type
            "1",    -- param format version
            true,   -- is default shader variable
            TRID.VAR_TOTALDIFFUSE,  -- shader var index
            floatR, floatG, floatB, floatA,    -- vector4
            -- end            
        -- end
        }
end
TRID.MakeDiffMaterial2 = function (floatR, floatG, floatB, floatA)
    return {
        -- start iteration
        TRID.MATERIAL_DIFF_BIT,
        "1",    -- element format version
        1,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_FLOAT4, -- param type
            "1",    -- param format version
            true,   -- is default shader variable
            TRID.VAR_TOTALDIFFUSE,  -- shader var index
            floatR, floatG, floatB, floatA,    -- vector4
            -- end
        -- end
        }
end

TRID.MakeOpaMaterial1 = function (opaMap, TEXTURE_TypeFlag, useThisMapPath, opaRatio)
	if opaMap and opaMap ~= "" then
		local r = opaRatio or 1
		return {
		-- start iteration
		TRID.MATERIAL_OPA_BIT,
		"1",    -- element format version
		1,    -- total params
		    -- start iteration
		    TRID.MATERIAL_PARAM_IMAGE, -- param type
		    "3",    -- param format version
		    true,   -- is default shader variable
		    TRID.TEX_OPATEXTURE,  -- shader var index
		    opaMap,  -- map name
		    TEXTURE_TypeFlag or TRID.TEXTURE_2D,   -- map property
		    "", -- alpha map name
		    r,r,r,1, -- alpha ratio
		    false,   -- set this texture property
		    useThisMapPath or false,
		    -- end
		-- end
		}
	else
		return {
		-- start iteration
		TRID.MATERIAL_OPA_BIT,
		"1",    -- element format version
		0,    -- total params
		}
	end
end

TRID.MakeSpecLevelMaterial1 = function (specLevelMap, specLevelRatio, floatR, floatG, floatB, floatA, useThisMapPath)
	if specLevelMap and specLevelMap ~= "" then
		return {
		-- start iteration
		TRID.MATERIAL_SPECLEVEL_BIT,
		"1",    -- element format version
		2,    -- total params
		    -- start iteration
		    TRID.MATERIAL_PARAM_IMAGE, -- param type
		    "3",    -- param format version
		    true,   -- is default shader variable
		    TRID.TEX_SPECLEVELTEXTURE,  -- shader var index
		    specLevelMap,  -- map name
		    TRID.TEXTURE_HASLEVEL,   -- map property
		    "", -- alpha map name
		    specLevelRatio,specLevelRatio,specLevelRatio,1, -- alpha ratio
		    false,   -- set this texture property
		    useThisMapPath or false,
		    -- end
		    -- start iteration
		    TRID.MATERIAL_PARAM_FLOAT4, -- param type
		    "1",    -- param format version
		    true,   -- is default shader variable
		    TRID.VAR_TOTALSPECULAR,  -- shader var index
		    floatR, floatG, floatB, floatA,    -- vector4
		    -- end            
		-- end
		}
	else
		return {
		-- start iteration
		TRID.MATERIAL_SPECLEVEL_BIT,
		"1",    -- element format version
		1,    -- total params
		    -- start iteration
		    TRID.MATERIAL_PARAM_FLOAT4, -- param type
		    "1",    -- param format version
		    true,   -- is default shader variable
		    TRID.VAR_TOTALSPECULAR,  -- shader var index
		    floatR, floatG, floatB, floatA,    -- vector4
		    -- end            
		-- end
		}
	end
end

TRID.MakeNormalMaterial1 = function (normalMap, bumpy, useThisMapPath)
    return {
        -- start iteration
        TRID.MATERIAL_BUMP_BIT,
        "1",    -- element format version
        1,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_IMAGE, -- param type
            "3",    -- param format version
            true,   -- is default shader variable
            TRID.TEX_BUMPTEXTURE,  -- shader var index
            normalMap,  -- map name
            TRID.TEXTURE_BUMPMAP,   -- map property
            "", -- alpha map name
            bumpy,bumpy,bumpy,1, -- alpha ratio
            false,   -- set this texture property
	    useThisMapPath or false,
            -- end
        -- end
        }
end

TRID.MakeGlowMaterial1 = function (glowMap, useThisMapPath)
    return {
        -- start iteration
        TRID.MATERIAL_GLOW_BIT,
        "1",    -- element format version
        1,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_IMAGE, -- param type
            "3",    -- param format version
            true,   -- is default shader variable
            TRID.TEX_GLOWTEXTURE,  -- shader var index
            glowMap,  -- map name
            TRID.TEXTURE_2D,   -- map property
            "", -- alpha map name
            1,1,1,1, -- alpha ratio
            false,   -- set this texture property
	    useThisMapPath or false,
            -- end
        -- end
        }
end

TRID.MakeCubeMaterial1 = function (reflectionLevelMap, reflectionRatio, useThisMapPath, envType, shaderIndexOrMask)
	local data
	if reflectionLevelMap and reflectionLevelMap ~= "" then
		data = {
		-- start iteration
		envType and TRID.MATERIAL_ENV_BIT or TRID.MATERIAL_CUBE_BIT,
		envType and "3" or "1",    -- element format version
		3,    -- total params
		    -- start iteration
		    TRID.MATERIAL_PARAM_IMAGE, -- param type
		    "3",    -- param format version
		    true,   -- is default shader variable
		    TRID.TEX_ENVLEVELTEXTURE,  -- shader var index
		    reflectionLevelMap,  -- map name
		    TRID.TEXTURE_HASLEVEL,   -- map property
		    "", -- alpha map name
		    reflectionRatio,reflectionRatio,reflectionRatio,1, -- alpha ratio
		    false,   -- set this texture property
		    useThisMapPath or false,
		    -- end
		    
		    -- start iteration
		    TRID.MATERIAL_PARAM_TEXTUREID, -- param type
		    "2",    -- param format version
		    true,   -- is default shader variable
		    TRID.TEX_ENVTEXTURE,  -- shader var index
		    -- end
		    
		    -- start iteration
		    TRID.MATERIAL_PARAM_MATRIX, -- param type
		    "2",    -- param format version
		    true,   -- is default shader variable
		    TRID.VAR_CAMPROJ,  -- shader var index
		    1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,
		    -- end
		-- end
		}
	else
		data = {
		-- start iteration
		envType and TRID.MATERIAL_ENV_BIT or TRID.MATERIAL_CUBE_BIT,
		envType and "3" or "1",    -- element format version
		2,    -- total params
		    -- start iteration
		    TRID.MATERIAL_PARAM_TEXTUREID, -- param type
		    "2",    -- param format version
		    true,   -- is default shader variable
		    TRID.TEX_ENVTEXTURE,  -- shader var index
		    -- end
		    
		    -- start iteration
		    TRID.MATERIAL_PARAM_MATRIX, -- param type
		    "2",    -- param format version
		    true,   -- is default shader variable
		    TRID.VAR_CAMPROJ,  -- shader var index
		    1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,
		    -- end
		-- end
		}
	end
	if envType then
		table.insert(data, envType)
		table.insert(data, shaderIndexOrMask or 0)
	end
	return data
end

TRID.MakeLightMaterial = function (lightmap, intensity)
	local data = {
        -- start iteration
        TRID.MATERIAL_LIGHT_BIT,
        "2",    -- element format version
        3,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_TEXTUREID, -- param type
            "2",    -- param format version
            true,   -- is default shader variable
            TRID.TEX_LIGHTMAP,  -- shader var index
            -- end
	    
            -- start iteration
            TRID.MATERIAL_PARAM_FLOAT2, -- param type
            "2",    -- param format version
            true,   -- is default shader variable
            TRID.VAR_OFFSETLIGHTMAP,  -- shader var index
	    0,0,
            -- end
	    
            -- start iteration
            TRID.MATERIAL_PARAM_FLOAT, -- param type
            "2",    -- param format version
            true,   -- is default shader variable
            TRID.VAR_LIGHTMAPINTENSITY,  -- shader var index
	    intensity or 1,
            -- end
        -- end
	lightmap,
        }
	return data
end

TRID.MakeCustomMaterial = function (bit, varTex, mapPath, TEXTURE_TypeFlag, useThisMapPath)
    return {
        -- start iteration
        bit,
        "1",    -- element format version
        1,    -- total params
            -- start iteration
            TRID.MATERIAL_PARAM_IMAGE, -- param type
            "3",    -- param format version
            true,   -- is default shader variable
            varTex,  -- shader var index
            mapPath or "",  -- map name
            TEXTURE_TypeFlag or TRID.TEXTURE_2D,   -- map property
            "", -- alpha map name
            1,1,1,1, -- alpha ratio
            true,   -- set this texture property
	    useThisMapPath or false,
            -- end
        -- end
	bit,
        }
end

TRID.MakeOnePropOfFlash = function (data, contentsPath, FPS, width, height, startPlay, forceKeepFPS)
	data[#data + 1] = "CFlashControl"
	data["CFlashControl"] = 
	{
		"CFlashControl-v001",	-- format version
		contentsPath,
		FPS,
		width,
		height,
		startPlay or true,
		forceKeepFPS or false, 
	}
	return data
end

TRID.MakeOnePropOfX3D = function (data, contentsPath, FPS, width, height)
	data[#data + 1] = "CX3DControl"
	data["CX3DControl"] = 
	{
		"1",	-- format version
		contentsPath,
		FPS,
		width,
		height,
	}
	return data
end

--====================================
-- Particle 
--====================================

TRID.MakeOneBaseEmitter = function (data, type, angle, colorRangeStart, colorRangeEnd, direction, emissionRate, MaxTTL, MinTTL, MaxSpeed, MinSpeed, Position, DurationMax, DurationMin, RepeatDelayMax, RepeatDelayMin, ignoreAffector, EmitterName,  EmittedEmitterName)
	table.insert(data, type or TRID.PE_POINT)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, angle or 0)
	table.insert(data, colorRangeStart or TRID.XRGB(255,255,255))
	table.insert(data, colorRangeEnd or TRID.XRGB(255,255,255))
	table.insert(data, direction and direction[1] or 0)
	table.insert(data, direction and direction[2] or 0)
	table.insert(data, direction and direction[3] or 0)
	table.insert(data, emissionRate or 1)
	table.insert(data, MaxTTL or 1)
	table.insert(data, MinTTL or 1)
	table.insert(data, MaxSpeed or 1)
	table.insert(data, MinSpeed or 1)
	table.insert(data, Position and  Position[1] or 0)
	table.insert(data, Position and  Position[2] or 0)
	table.insert(data, Position and  Position[3] or 0)
	table.insert(data, DurationMax or 0)
	table.insert(data, DurationMin or 0)
	table.insert(data, RepeatDelayMax or 0)
	table.insert(data, RepeatDelayMin or 0)
	table.insert(data, EmitterName or "")
	table.insert(data, EmittedEmitterName or "")
	table.insert(data, ignoreAffector or 0)
end	

TRID.MakeOneAreaEmitter = function (data, size)
	table.insert(data, "1") -- format version
	table.insert(data, size and size[1] or 1)
	table.insert(data, size and size[2] or 1)
	table.insert(data, size and size[3] or 1)
end	

TRID.MakeOneRingEmitter = function (data, innerSizeX, innerSizeY)
	table.insert(data, "1") -- format version
	table.insert(data, innerSizeX or 1)
	table.insert(data, innerSizeY or 1)
end	


TRID.MakeOneColorFaderAffector = function (data, red, green, blue, alpha)
        table.insert(data, TRID.PA_COLORFADER)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, red or 0)
	table.insert(data, green or 0)
	table.insert(data, blue or 0)
	table.insert(data, alpha or 0)
end	

	
TRID.MakeOneDeflectorPlaneAffector = function (data, planePoint, planeNormal, bounce)
        table.insert(data, TRID.PA_DEFLECTORPLANE)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, planePoint and planePoint[1] or 0)
	table.insert(data, planePoint and planePoint[2] or 0)
	table.insert(data, planePoint and planePoint[3] or 0)
	
	table.insert(data, planeNormal and planeNormal[1] or 0)
	table.insert(data, planeNormal and planeNormal[2] or 0)
	table.insert(data, planeNormal and planeNormal[3] or 1)
	
	table.insert(data, bounce or 1)
end	

TRID.MakeOneDirectionRandomiserAffector = function (data, randomness, scope, keepVelocity)
        table.insert(data, TRID.PA_DIRECTIONRANDOMISER)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, randomness or 1)
	table.insert(data, scope or 1)
	table.insert(data, keepVelocity or false)
end	

TRID.MakeOneLinearForceAffector = function (data, forceVector, forceApplication)
        table.insert(data, TRID.PA_LINEARFORCE)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, forceVector and forceVector[1] or 0)
	table.insert(data, forceVector and forceVector[2] or 0)
	table.insert(data, forceVector and forceVector[3] or 0)
	table.insert(data, forceApplication or TRID.FA_ADD)
end	

TRID.MakeOneRotationAffector= function (data, rotSpeedRangeStart, rotSpeedRangeEnd, rotRangeStart, rotRangeEnd)
        table.insert(data, TRID.PA_ROTATION )
	
	table.insert(data, "1") -- format version
	
	table.insert(data, rotSpeedRangeStart or 0)
	table.insert(data, rotSpeedRangeEnd or 0)
	table.insert(data, rotRangeStart or 0)
	table.insert(data, rotRangeEnd or 0)
end	


TRID.MakeOneScaleAffector = function (data, scale)
        table.insert(data, TRID.PA_SCALE)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, scale or 0)
end	

TRID.MakeOneDeviantDirectionAffector = function (data, angle, scope)
        table.insert(data, TRID.PA_DEVIANTDIRECTION)
	
	table.insert(data, "1") -- format version
	
	table.insert(data, angle or 0)
	table.insert(data, scope or 0)
end	

TRID.MakeOnePropOfParticleSystem = function (data, particleWidth, particleHeight, quota, billboardType,  billboardRotationType, cull, emittedEmitterQuota, sort, emitterList, affectorList)
	if not emitterList or #emitterList == 0 then
		TRID.DebugPrint("TRID.MakeOnePropOfParticleSystem - no emitterList.", "error")
		return data
	end
	local affectors = affectorList or {}
	
	data[#data + 1] = "CParticleSystem"
	data["CParticleSystem"] = 
	{
		"CParticleSystem-v001",	-- format version
		particleWidth or 10,
		particleHeight or 10,
		quota or 10,
		billboardType or TRID.BBT_POINT,
		billboardRotationType or TRID.BBR_TEXCOORD,
		cull or false,
		emittedEmitterQuota or 3,
		sort or 0,
		#emitterList,
		#affectors,
	}
	
	for i=1, #emitterList do
		local oneEmitterProp = emitterList[i]
		for k=1, #oneEmitterProp do
			table.insert(data["CParticleSystem"], oneEmitterProp[k])
		end
	end	
		
	for i=1, #affectors do
		local oneAffectorProp = affectors[i]
		for k=1, #oneAffectorProp do
			table.insert(data["CParticleSystem"], oneAffectorProp[k])
		end
	end
	return data
end

----------------------------------------------------------------------------------- new partice data structure ------------------------------------------------------------------------------------------------------------------------

TRID.MakeOnePropOfParticleEmitter = function (data,  colourRangeStart, colourRangeEnd, minSize, maxSize, minEnergy, maxEnergy, minEmission, maxEmission, angle, velocity, randomVelocity, minAngular,maxAngular, playMode, 
                                                            duration, repeatDelayMin, repeatDelayMax, simulateInWorldSapce, emitterShape, emitterSize,  minEmitterSizeScale)
						  
	table.insert(data, "1") -- format version
	
	table.insert(data, colourRangeStart or TRID.XRGB(255,255,255))
	table.insert(data, colourRangeEnd or TRID.XRGB(255,255,255))
	table.insert(data, minSize or 0)
	table.insert(data, maxSize or 0)	
	table.insert(data, minEnergy or 0)
	table.insert(data, maxEnergy or 0)	
	table.insert(data, minEmission or 0)
	table.insert(data, maxEmission or 0)
	table.insert(data, angle or 0)	
	table.insert(data, velocity and velocity[1] or 0)
	table.insert(data, velocity and velocity[2] or 0)
	table.insert(data, velocity and velocity[3] or 0)
	table.insert(data, randomVelocity and randomVelocity[1] or 0)
	table.insert(data, randomVelocity and randomVelocity[2] or 0)
	table.insert(data, randomVelocity and randomVelocity[3] or 0)
	--table.insert(data, tangentVelocity and tangentVelocity[1] or 0)
	--table.insert(data, tangentVelocity and tangentVelocity[2] or 0)
	--table.insert(data, tangentVelocity and tangentVelocity[3] or 0)	
	table.insert(data, minAngular or 0)
	table.insert(data, maxAngular or 0)
	table.insert(data, playMode or 0)	
	table.insert(data, duration or 0)
	table.insert(data, repeatDelayMin or 0)
	table.insert(data, repeatDelayMax or 0)	
	table.insert(data, simulateInWorldSapce or 0)
	table.insert(data, emitterShape or 0)
	table.insert(data, emitterSize and emitterSize[1] or 0)
	table.insert(data, emitterSize and emitterSize[2] or 0)
	table.insert(data, emitterSize and emitterSize[3] or 0)
	table.insert(data, minEmitterSizeScale or 0)
end

TRID.MakeOnePropOfParticleAnimator = function (data, bColorAnimate, colors, times, rotationAxis, force, sizeGlow, damping)
        table.insert(data, "1") -- format version

	table.insert(data, bColorAnimate or 0)
	
	if bColorAnimate then
	    table.insert(data, colors and #colors or 0)	
	    for i=1, colors and #colors or 0 do
		table.insert(data, colors[i])
	    end
       
	    table.insert(data, times and #times or 0)	
	    for i=1, times and #times or 0 do
		table.insert(data, times[i])
	    end	    
	end

	table.insert(data, rotationAxis and rotationAxis[1] or 0)
	table.insert(data, rotationAxis and rotationAxis[2] or 0)
	table.insert(data, rotationAxis and rotationAxis[3] or 0)
	table.insert(data, force and force[1] or 0)
	table.insert(data, force and force[2] or 0)
	table.insert(data, force and force[3] or 0)	
	table.insert(data, sizeGlow or 0)
	table.insert(data, damping or 0)	
end	

TRID.MakeOnePropOfParticleRenderer = function (data, uvAnimation, cycle, billboardStyle, lengthScale, velocityScale, castShadow, receiveShadows)
        table.insert(data, "1") -- format version
	
	table.insert(data, uvAnimation or 0)
	table.insert(data, cycle or 0)
	table.insert(data, billboardStyle or 0)
	table.insert(data, lengthScale or 0)
	table.insert(data, velocityScale or 0)
	table.insert(data, castShadow or 0)
	table.insert(data, receiveShadows or 0)	
end	

TRID.MakeOnePropOfParticles = function (data, name, emitter, animator, renderer)

	data[#data + 1] = "CParticleSystem"
	data["CParticleSystem"] = 
	{
		"CParticleSystem-v002",	-- format version
		name or "default",
	}
	local t = data["CParticleSystem"]
	for k=1, #emitter do
 	     table.insert(t, emitter[k])
	end	
	
	for k=1, #animator do
 	     table.insert(t, animator[k])
	end		
	
	for k=1, #renderer do
 	     table.insert(t, renderer[k])
	end		
	
	return data
end	

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TRID.MakePropsOfParticlesDefault = function (data)
	data[#data + 1] = "CParticleSystem"
	data["CParticleSystem"] = 
	{
		"CParticleSystem-v001",	-- format version
		2 ,  --particleWidth 
		2, -- particleHeight 
		10, -- quota 
		TRID.BBT_POINT, -- billboardType
		TRID.BBR_TEXCOORD, -- billboardRotationType 
		false,  -- cull
		3, -- emittedEmitterQuota 
		true, --sort
		1,
		1,
	}	
	
	local PointEmitterProp = {}
	TRID.MakeOneBaseEmitter(PointEmitterProp, TRID.PE_POINT, 5, TRID.XRGB(255,255,255), TRID.XRGB(255,255,255), {0, 0, 1}, 100, 2, 3, 3, 4,{0,0,0})
	
	local LinearForceAffectorProp = {}
	TRID.MakeOneLinearForceAffector(LinearForceAffectorProp,  {0,0, -1}, TRID.FA_ADD)		
	
		
	for k=1, #PointEmitterProp do
		table.insert(data["CParticleSystem"], PointEmitterProp[k])
	end	
	
	for k=1, #LinearForceAffectorProp do
		table.insert(data["CParticleSystem"], LinearForceAffectorProp[k])
	end	

	return data
end



--====================================
-- instance interface
--====================================
TRID.MakeBaseIDToString = function (baseID1, baseID2)
	return baseID1 .. " " .. baseID2
end

TRID.IsSameBaseID = function (AID, BID)
	if AID == nil or BID == nil then
		return false
	end
	if AID[1] == BID[1] and AID[2] == BID[2] then
		return true
	end
	return false
end

TRID.CLASSMAP = {}
TRID.CLASSMAP = TRID.ProtectTableAdd(TRID.CLASSMAP)
 -- return class table with className
TRID.StartClassDefinition = function (className, superClassName, classVersion)
	if TRID.CLASSMAP[className] == nil then
		-- subclassing
		if not TRID.IsNullString(superClassName) then
			if TRID.CLASSMAP[superClassName] then
				TRID.CLASSMAP[className] = TRID.CLASSMAP[superClassName]:_NewSubClass()
			else
				TRID.DebugPrint("TRID.OpenClassDefinition - can not find superClass [" .. superClassName .. "] of [" .. className .. "]", "error")
				TRID.CLASSMAP[className] = {}
			end
		else
			TRID.CLASSMAP[className] = {}
		end
		
		TRID.CLASSMAP[className]._className = className
		TRID.CLASSMAP[className]._classVersion = classVersion
		-- for subclassing
		TRID.CLASSMAP[className]._NewSubClass = function (class) return setmetatable({_superClass = class}, {__index = class}) end
	end
	return TRID.CLASSMAP[className]
end

TRID.FinishClassDefinition = function (className)
	if TRID.CLASSMAP[className] ~= nil then
		PROTECT_CLASS = false
		TRID.CLASSMAP[className] = TRID.ProtectTable(TRID.CLASSMAP[className])
		PROTECT_CLASS = true
	end
end

-- return class table with className
-- version = 2 means call handler has argument senderInstance instead of (fromID1, fromID2).
TRID.OpenClassDefinition = function (className, superClassName)
	return TRID.StartClassDefinition(className, superClassName, 2)
end
TRID.CloseClassDefinition = TRID.FinishClassDefinition

TRID._NewInstance = function (baseID1, baseID2, instance)
	local oldInstance = TRID_DYNAMIC_DATA.INSTANCEMAP[baseID1]
	if oldInstance and oldInstance._baseID[2] ~= baseID2 then
		if oldInstance._class then
			if not TRID_DYNAMIC_DATA.DELETEDMAP[baseID1] then
				TRID_DYNAMIC_DATA.DELETEDMAP[baseID1] = {}
			end
			TRID_DYNAMIC_DATA.DELETEDMAP[baseID1][oldInstance._baseID[2]] = oldInstance
		end
		
--~ 		TRID.DebugPrint("TRID._NewInstance - " .. TRID.TableToString({baseID1, baseID2, oldInstance._baseID, oldInstance._class}))
	end
	TRID_DYNAMIC_DATA.INSTANCEMAP[baseID1] = instance
--~ 	TRID.DebugPrint("TRID._NewInstance - " .. TRID.TableToString({baseID1, baseID2}))
end

-- return new instance. if instance already exists, return nil
TRID.NewInstance = function (className, baseID1, baseID2)
	local thisInstance = {}
	thisInstance._baseID = {baseID1, baseID2}
	if className then
		thisInstance._class = TRID.CLASSMAP[className]
	end
	
	TRID._NewInstance(baseID1, baseID2, thisInstance)
	return thisInstance
end

TRID.GetClass = function (className)
	return TRID.CLASSMAP[className]
end

TRID.GetInstance = function (baseID1, baseID2, onlyLogicInstance, graphicFOID_TypeID)
	if type(baseID1) == "table" then
		return TRID.GetInstance(baseID1[1], baseID1[2])
	end
	local ID1 = tonumber(baseID1)
	local ID2 = tonumber(baseID2)
	if not ID1 or not ID2 then return nil end
	local instance = TRID_DYNAMIC_DATA.INSTANCEMAP[ID1]
	if instance and instance._baseID[2] ~= ID2 then
		instance = nil
	end
	if not instance then
		instance = TRID_DYNAMIC_DATA.DELETEDMAP[ID1] and TRID_DYNAMIC_DATA.DELETEDMAP[ID1][ID2] or nil
	end
	if instance or onlyLogicInstance then
		return instance
	end
	if ID1 == 0 and ID2 == 0 then return nil end
	return TRID.GetGraphicInstance({ID1, ID2}, graphicFOID_TypeID)
end

-- return delete instance
TRID.DeleteInstance = function (baseID1, baseID2)
	if not baseID1 or not baseID2 then return end
	local instance = TRID_DYNAMIC_DATA.INSTANCEMAP[baseID1]
	if instance and instance._baseID[2] == baseID2 then
		TRID_DYNAMIC_DATA.INSTANCEMAP[baseID1] = nil
--~ 		TRID.DebugPrint("TRID.DeleteInstance - from INSTANCEMAP1 " .. TRID.TableToString({baseID1, baseID2, TRID.GetTableSize(TRID_DYNAMIC_DATA.INSTANCEMAP)}))
	else
		instance = TRID_DYNAMIC_DATA.DELETEDMAP[baseID1] and TRID_DYNAMIC_DATA.DELETEDMAP[baseID1][baseID2] or nil
		if instance then
			TRID_DYNAMIC_DATA.DELETEDMAP[baseID1][baseID2] = nil
--~ 			local empty = true
--~ 			for i, v in pairs(TRID_DYNAMIC_DATA.DELETEDMAP[baseID1]) do
--~ 				empty = false
--~ 				break
--~ 			end
--~ 			if empty then
--~ 				TRID_DYNAMIC_DATA.DELETEDMAP[baseID1] = nil
--~ 			end
--~ 			TRID.DebugPrint("TRID.DeleteInstance - from DELETEDMAP2 " .. TRID.TableToString({baseID1, baseID2, TRID.GetTableSize(TRID_DYNAMIC_DATA.INSTANCEMAP)}))
		end
	end
	
	if instance then
		instance.__TRID_DELETED__ = true
	else
--~ 		TRID.DebugPrint("TRID.DeleteInstance - not found." .. TRID.TableToString({baseID1, baseID2}))
	end
end

-- return function, instance
TRID.GetMethod = function (functionName, baseID1, baseID2)
	local instance = TRID.GetInstance(baseID1, baseID2, true)
	if instance == nil then
		TRID.DebugPrint("TRID.GetMethod - " .. tostring(baseID1) .. "," .. tostring(baseID2) .. " doesn't exist. It calls " .. functionName)
		return nil
	end
	local memberArray = TRID.SplitBySeparator(functionName, "[.]")
	
	-- check reference from instance._class
	local funcPoint = instance._class
	for i=1, #memberArray do
		funcPoint = funcPoint[memberArray[i]]
		if not funcPoint then
			break
		end
	end
	
	if not funcPoint then
		-- check reference from instance
		funcPoint = instance
		for i=1, #memberArray do
			funcPoint = funcPoint[memberArray[i]]
			if not funcPoint then
				break
			end
		end
	end
	
	if type(funcPoint) ~= "function" then
		TRID.DebugPrint("TRID.GetMethod - " .. tostring(baseID1) .. "," .. tostring(baseID2) .. "." .. functionName .. " doesn't exist or isn't a function.")
		return nil
	end
	return funcPoint, instance
end

-- return result code
TRID.CallHandler = function (functionName, baseID1, baseID2, fromID1, fromID2, data)
	local funcPoint, instance = TRID.GetMethod(functionName, baseID1, baseID2)
	if not funcPoint then
		TRID.DebugPrint("TRID.CallHandler - can not find the function.")
		return TRID.RESULT_NOT_FOUND
	end
	if instance._classVersion and instance._classVersion >= 2 then
		local senderInstance = TRID.GetInstance(fromID1, fromID2)
		if not senderInstance then
			senderInstance = {_baseID = {fromID1, fromID2}}
		end
		return funcPoint(instance, senderInstance, data)
	else
		return funcPoint(instance, fromID1, fromID2, data)
	end
end

TRID.CallConstructor = function (baseID1, baseID2)
	local instance = TRID.GetInstance(baseID1, baseID2, true)
	if instance == nil then
		local baseIDString = TRID.MakeBaseIDToString(baseID1, baseID2)
		TRID.DebugPrint("TRID.CallConstructor - " .. baseIDString .. " doesn't exist.")
		return
	end
	
	local i
	local currentClass = instance._class
	local constructorSet = {}
	while currentClass ~= nil
	do
		if type(currentClass._Constructor) == "function" then
			-- check duplication
			local canInsert = true
			for i=1, #constructorSet do
				if constructorSet[i] == currentClass._Constructor then
					canInsert = false
					break
				end
			end
			if canInsert then
				constructorSet[#constructorSet+1] = currentClass._Constructor
			end
		end
		currentClass = currentClass._superClass
	end
	
	local initData = TRID_DYNAMIC_DATA.PopInitData(baseID1, baseID2)
	instance = TRID._SetLogicClass(instance, initData and initData[1] or nil)
	
	-- reverse call
	for i = #constructorSet, 1, -1 do
		constructorSet[i](instance, initData and initData[2] or nil)
	end
	
	if type(instance._class._Initializer) == "function" then
		instance._class._Initializer(instance, initData and initData[2] or nil)
	end
	
	if initData and initData[3] then
		TRID.DebugPrint("TRID.CallConstructor - callback after creation.")
		initData[3](instance)
	end
end

TRID.CallDestructor = function (baseID1, baseID2)
	local instance = TRID.GetInstance(baseID1, baseID2, true)
	if instance == nil then
		local baseIDString = TRID.MakeBaseIDToString(baseID1, baseID2)
		TRID.DebugPrint("TRID.CallDestructor - " .. baseIDString .. " doesn't exist.")
		return
	end
	
	local oldDestructor = nil
	local currentClass = instance._class
	while currentClass ~= nil
	do
		if type(currentClass._Destructor) == "function" then
			if oldDestructor ~= currentClass._Destructor then
				currentClass._Destructor(instance)
			end
			oldDestructor = currentClass._Destructor
		end
		currentClass = currentClass._superClass
	end
    
	TRID.DeleteInstance(baseID1, baseID2)
end

TRID.CallSuperClassMethod = function (curClassName, methodName, thisInstance, ...)
	if not methodName then
		TRID.DebugPrint("TRID.CallSuperClassMethod - can not find methodName.")
		return
	end
	local curClass = TRID.GetClass(curClassName)
	if not curClass then
		TRID.DebugPrint("TRID.CallSuperClassMethod - can not find current class." .. tostring(curClassName))
		return
	end
	if curClass._superClass and curClass._superClass[methodName] then
		return curClass._superClass[methodName](thisInstance, ...)
	else
		TRID.DebugPrint("TRID.CallSuperClassMethod - can not find curClass._superClass or curClass._superClass[methodName].")
		return
	end
end

TRID.SendDelete = function (baseID)
	if baseID then
		TRIDGLUE.SendMessage(0,0, baseID[1], baseID[2], TRID.MSG_DELETE)
	end
end

TRID.SetClassToInstance = function (_instance, _class)
return setmetatable ({_originalData = _instance},
    {
		__index = function (t, k)
			-- for optimization.
			local value = _class and _class[k]
			if value ~= nil then
				return value
			end
			return _instance and _instance[k]
		end,
		__metatable = "You can not modify metatable.",
		__newindex = function (t, k, v)
			if _class and _class[k] then
				error ("TRID.SetClassToInstance - attempting to change constant " .. tostring (k) .. " to " .. tostring (v), 2)
			else
				_instance[k] = v
			end
		end
    })
end
-- indexing order : _frameworkClass > _class > _instance
TRID._SetClassToInstance = function (_instance, _class, _frameworkClass)
return setmetatable ({_originalData = _instance, _frameworkClass = _frameworkClass},
    {
		__index = function (t, k)
			-- for optimization.
			local value = _class and _class[k]
			if value ~= nil then
				return value
			end
			value = _instance and _instance[k]
			if value ~= nil then
				return value
			end
			value = _frameworkClass and _frameworkClass[k]
			if value ~= nil then
				return value
			end
			return _instance and _instance._graphic and _instance._graphic._frameworkClass and _instance._graphic._frameworkClass[k]
			
--~ 			if _frameworkClass and _frameworkClass[k] then
--~ 				return _frameworkClass[k]
--~ 			elseif _instance and _instance._graphic and _instance._graphic._frameworkClass and _instance._graphic._frameworkClass[k] then
--~ 				return _instance._graphic._frameworkClass[k]
--~ 			elseif _class and _class[k] then
--~ 				return _class[k]
--~ 			elseif _instance and _instance[k] then
--~ 				return _instance[k]
--~ 			else
--~ 				return nil
--~ 			end
		end,
		__metatable = "You can not modify metatable.",
		__newindex = function (t, k, v)
			if _frameworkClass and _frameworkClass[k] then
				error ("attempting to change constant1 " .. tostring (k) .. " to " .. tostring (v), 2)
			elseif _instance and _instance._graphic and _instance._graphic._frameworkClass and _instance._graphic._frameworkClass[k] then
				error ("attempting to change constant2 " .. tostring (k) .. " to " .. tostring (v), 2)
			elseif _class and _class[k] then
				error ("attempting to change constant3 " .. tostring (k) .. " to " .. tostring (v), 2)
			else
				_instance[k] = v
			end
		end
    })
end
TRID._SetLogicClass = function (instance, objectType)
	if instance then
		if objectType == TRID.LOGIC_OBJECT_SPACE then
			instance = TRID._SetClassToInstance(instance, instance._class, TRID.Space)
		else
			instance = TRID._SetClassToInstance(instance, instance._class, TRID.Logic)
		end
		if instance._baseID then
			TRID._NewInstance(instance._baseID[1], instance._baseID[2], instance)
		end
	end
	return instance
end
TRID._CreateObject = function (objectType, script, name, initData, callBackAfterCreation)
	if TRIDGLUE then
		local loID = {TRIDGLUE.CreateLogicObject(name, "", objectType)}
		local instance = nil
		if script and script ~= "" then
			TRID_DYNAMIC_DATA.PushInitData(loID, objectType, initData, callBackAfterCreation)

			local propData = {}
			propData[#propData + 1] = "CScriptLoader"
			propData["CScriptLoader"] = 
			{
				"1",	-- format version
				script,
			}
			TRIDGLUE.SetProperty(loID[1], loID[2], TRID.FOID_SCRIPTLOADER, propData, true)
			instance = TRID.GetInstance(loID[1], loID[2], true)
			if not instance then
				TRID.DebugPrint("TRID.CreateObject - create this after loading script[" .. script .. "]")
				return nil
			end
		else
			instance = TRID._SetLogicClass({_baseID = loID}, objectType)
		end
		return instance
	else
		TRID.DebugPrint("[TEST] TRID.CreateObject - " .. tostring(script))
		return nil
	end
end
TRID.FindInstanceByName = function (globalName)
	if TRIDGLUE then
		local baseID = {TRIDGLUE.FindObject(globalName)}
		local instance = TRID.GetInstance(baseID[1], baseID[2])
		if not instance and baseID[1] then
			instance = {_baseID = baseID}
		end
		return instance
	else
		TRID.DebugPrint("[TEST] TRID.FindInstanceByName - " .. tostring(globalName))
		return nil
	end
end
TRID.LoadScript = function (scriptPath, ignoreDownloadFail, reload)
	if TRIDGLUE then
		return TRIDGLUE.LoadScript(scriptPath, ignoreDownloadFail, reload)
	else
		TRID.DebugPrint("[TEST] TRID.LoadScript - " .. tostring(scriptPath))
	end
	return nil
end
TRID.GetGraphicInstance = function (baseID, FOID_TypeID)
	if not (baseID and baseID[1] and not (baseID[1] == 0 and baseID[2] == 0)) then
		return nil
	end
	local graphicInstance = {}
	graphicInstance._baseID = baseID
	if not FOID_TypeID then
		if TRIDGLUE.GetGraphicFOID then
			FOID_TypeID = TRIDGLUE.GetGraphicFOID(baseID[1], baseID[2])
		end
		if not FOID_TypeID then
			return nil
		end
	end
	
	if FOID_TypeID == TRID.FOID_GUI_OBJECT then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.GUI)
	elseif FOID_TypeID == TRID.FOID_3D_OBJECT then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Graphic)
	elseif FOID_TypeID == TRID.FOID_BUTTON then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Button)
	elseif FOID_TypeID == TRID.FOID_VIEW then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.View)
	elseif FOID_TypeID == TRID.FOID_LIST_BOX then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.ListBox)
	elseif FOID_TypeID == TRID.FOID_SCROLL_BAR then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.ScrollBar)
	elseif TRID.IsGUI(FOID_TypeID) then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.GUI)
	elseif FOID_TypeID == TRID.FOID_3D_CAMERA then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Camera)
	elseif FOID_TypeID == TRID.FOID_3D_LIGHT then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Light)
	elseif FOID_TypeID == TRID.FOID_TERRAIN_OBJECT then
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Terrain)
	else
		graphicInstance = TRID._SetClassToInstance(graphicInstance, nil, TRID.Graphic)
	end
	return graphicInstance
end
TRID.CreateGraphic = function (FOID_TypeID, propData, ownerInstance)
	if TRIDGLUE then
		local baseID = {TRIDGLUE.CreateGraphicObject("", "", 0, 0, FOID_TypeID, propData)}
		local graphicInstance = TRID.GetGraphicInstance(baseID, FOID_TypeID)
		if ownerInstance then
			if ownerInstance.GlueSetGraphic then
				ownerInstance:GlueSetGraphic(graphicInstance)
			else
				TRID.DebugPrint("TRID.CreateGraphic - ownerInstance must be a logic instance.", "error")
			end
		end
		return graphicInstance
	else
		TRID.DebugPrint("[TEST] TRID.CreateGraphic - " .. tostring(FOID_TypeID))
		return nil
	end
end
TRID.CreateObject = function (script, globalName, initData, callBackFunctionAfterCreation)
	return TRID._CreateObject(TRID.LOGIC_OBJECT_DEFAULT, script, globalName, initData, callBackFunctionAfterCreation)
end
TRID.CreateSpace = function (script, globalName, initData, callBackFunctionAfterCreation)
	return TRID._CreateObject(TRID.LOGIC_OBJECT_SPACE, script, globalName, initData, callBackFunctionAfterCreation)
end
TRID.MessageBox = function (header, strMessage, MESSAGEBOX_Type)
	if TRIDGLUE then
		return TRIDGLUE.MessageBox(header, strMessage, MESSAGEBOX_Type)
	else
		TRID.DebugPrint("[TEST] TRID.MessageBox")
	end
	return nil
end
TRID.ShowOpenDialog = function (title, defaultFile, filter, multiSelection, checkExistence)
	if TRIDGLUE then
		return TRIDGLUE.ShowOpenDialog(title, defaultFile, filter, multiSelection, checkExistence)
	else
		TRID.DebugPrint("[TEST] TRID.ShowOpenDialog")
		return nil
	end
end
TRID.ShowSaveDialog = function (title, defaultFile, filter)
	if TRIDGLUE then
		return TRIDGLUE.ShowOpenDialog(title, defaultFile, filter, false, false, true)
	else
		TRID.DebugPrint("[TEST] TRID.ShowSaveDialog")
		return nil
	end
end
TRID.ShowFolderDialog = function (title)
	if TRIDGLUE then
		return TRIDGLUE.ShowFolderDialog(title)
	else
		TRID.DebugPrint("[TEST] TRID.ShowFolderDialog")
		return nil
	end
end
TRID.ShowColorDialog = function (color)
	if TRIDGLUE then
		local r,g,b,ok = TRIDGLUE.ShowColorDialog(TRID.COLOR_R(color), TRID.COLOR_G(color), TRID.COLOR_B(color))
		return TRID.XRGB(r,g,b), ok
	else
		TRID.DebugPrint("[TEST] TRID.ShowColorDialog")
		return nil
	end
end
TRID.SetMaterialMask = function (set, MATERIAL_TypeMask, setAfterClear)
	if TRIDGLUE then
		TRIDGLUE.SetMaterialMask(set, MATERIAL_TypeMask, setAfterClear)
	else
		TRID.DebugPrint("[TEST] TRID.SetMaterialMask")
	end
end
TRID.GetAnimationFrame = function (aniName)
	if TRIDGLUE then
		return TRIDGLUE.GetAnimationFrame(aniName)
	else
		TRID.DebugPrint("[TEST] TRID.GetAnimationFrame")
		return nil
	end
end
TRID.Assert = function (condition, text)
	if TRIDGLUE then
		return TRIDGLUE.Assert(condition, text)
	else
		TRID.DebugPrint("[TEST] TRID.Assert")
		return nil
	end
end
TRID.SetContentsTime = function (velocity)
	if TRIDGLUE then
		TRIDGLUE.SetContentsTime(velocity)
	else
		TRID.DebugPrint("[TEST] TRID.SetContentsTime")
	end
end
TRID.GetCurrentTime = function (resolutionInSecond)
	if TRIDGLUE then
		return TRIDGLUE.GetCurrentTime(resolutionInSecond)
	else
		TRID.DebugPrint("[TEST] TRID.GetCurrentTime")
	end
end
TRID.GetSystemTime = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetCurrentTime(nil, true)
	else
		TRID.DebugPrint("[TEST] TRID.GetSystemTime")
	end
end
TRID.DoResourceGarbageCollection = function (instance, funcName)
    if TRIDGLUE then
        if instance and instance._baseID then
            TRIDGLUE.DoResourceGarbageCollection(instance._baseID[1], instance._baseID[2], funcName)
        else
            TRIDGLUE.DoResourceGarbageCollection()
        end
    else
        TRID.DebugPrint("[TEST] TRID.DoResourceGarbageCollection")
end
end
TRID.ResetModal = function ()
	if TRIDGLUE then
		TRIDGLUE.DoModal(0,0)
	else
		TRID.DebugPrint("[TEST] TRID.ResetModal")
	end
end
TRID.GetPickupData = function (getResourceName, getCollisionData)
	if TRIDGLUE then
		return TRIDGLUE.GetPickupData(getResourceName, getCollisionData)
	else
		TRID.DebugPrint("[TEST] TRID.GetPickupData")
	end
end
TRID.PickupData = function (getResourceName, getCollisionData)
	if TRIDGLUE then
		local result = {TRIDGLUE.GetPickupData(getResourceName, getCollisionData)}
		local pickedInstance = TRID.GetInstance(result[6], result[7])
		local newResult = {}
		newResult[1] = result[1]
		newResult[2] = result[2]
		newResult[3] = {result[3], result[4], result[5]}
		newResult[4] = pickedInstance
		for i=8, #result do
			table.insert(newResult, result[i])
		end
		return table.unpack(newResult)
	else
		TRID.DebugPrint("[TEST] TRID.PickupData")
	end
end
TRID.PlaySound = function (filename, fileVolume, background, noLoop, noStream, noGarbage, playRate)
	if TRIDGLUE then
		TRIDGLUE.PlaySound(filename, background, fileVolume, noLoop, noStream,noGarbage or false, playRate or 1)
	else
		TRID.DebugPrint("[TEST] TRID.PlaySound")
	end
end
TRID.StopSound = function (filename)
	if TRIDGLUE then
		TRIDGLUE.StopSound(filename)
	else
		TRID.DebugPrint("[TEST] TRID.StopSound")
	end
end
TRID.PauseSound = function (filename, pause)
	if TRIDGLUE then
		TRIDGLUE.PauseSound(filename, pause)
	else
		TRID.DebugPrint("[TEST] TRID.PauseSound")
	end
end
TRID.PlayEffectSound = function (filename, fileVolume, background, noLoop, noStream, playRate)
    if TRIDGLUE then
        TRIDGLUE.PlaySound(filename, background, fileVolume, noLoop, noStream, playRate or 1)
    else
        TRID.DebugPrint("[TEST] TRID.PlaySound")
    end
end
TRID.StopEffectSound = function (filename)
    if TRIDGLUE then
        TRIDGLUE.StopSound(filename)
    else
        TRID.DebugPrint("[TEST] TRID.StopSound")
    end
end
TRID.SetSoundVolume = function (volume, filename)
	if TRIDGLUE then
		TRIDGLUE.SetSoundVolume(volume, filename)
	else
		TRID.DebugPrint("[TEST] TRID.SetSoundVolume")
	end
end
TRID.GetBinaryInterface = function (data)
	local binInterface = {pointer = data}
	return TRID._SetClassToInstance(binInterface, nil, TRID.Binary)
end
TRID.GetStringArrayInterface = function (data)
	local stringArrayInterface = {array = data, curPos = 1}
	return TRID._SetClassToInstance(stringArrayInterface, nil, TRID.Binary)
end
TRID.GetConnection = function (baseID, new)
	if baseID and baseID[1] and baseID[2] then
		local connection = {_baseID = baseID}
		connection = TRID._SetClassToInstance(connection, nil, TRID.Network)
		
		if new then
			TRID._NewInstance(baseID[1], baseID[2], connection)
		end
		return connection
	else
		TRID.DebugPrint("TRID.GetConnection - baseID is invalid.", "error")
		return nil
	end
end
TRID.CreateConnector = function (channelName, NETWORK_TypeID, host, port, tryCount, NETWORK_TypeFlag, certFile)
	if TRIDGLUE then
		if NETWORK_TypeID and host then
			local channelID1, channelID2, errResult = TRIDGLUE.CreateConnector(channelName, NETWORK_TypeID, host, port, tryCount, NETWORK_TypeFlag, certFile)
			if channelID1 == 0 and channelID2 == 0 then
				TRID.DebugPrint("TRID.CreateConnector - error : " .. tostring(errResult))
			else
				return TRID.GetConnection({channelID1, channelID2}, true)
			end
		else
			TRID.DebugPrint("TRID.CreateConnector - NETWORK_TypeID or host is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.CreateConnector")
	end
	return nil
end
TRID.CreateAcceptor = function (channelName, NETWORK_TypeID, port, tryRandomPort, NETWORK_TypeFlag, numThread, certFile, privKeyFile, dhFile, sslPassword)
	if TRIDGLUE then
		if NETWORK_TypeID and port then
			local channelID1, channelID2, openedPort, errResult = TRIDGLUE.CreateAcceptor(channelName, NETWORK_TypeID, port, tryRandomPort, NETWORK_TypeFlag, numThread, certFile, privKeyFile, dhFile, sslPassword)
			if channelID1 == 0 and channelID2 == 0 then
				TRID.DebugPrint("TRID.CreateAcceptor - error : " .. tostring(errResult))
			else
				local connection = TRID.GetConnection({channelID1, channelID2}, true)
				connection.port = openedPort
				return connection
			end
		else
			TRID.DebugPrint("TRID.CreateAcceptor - NETWORK_TypeID or port is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.CreateAcceptor")
	end
	return nil
end
TRID.CreateHandlerThread = function (luaScript, totalThread, maxPacketStringLength)
	if TRIDGLUE then
		if luaScript then
			TRIDGLUE.CreateHandlerThread(luaScript, totalThread or 1, maxPacketStringLength)
		else
			TRID.DebugPrint("TRID.CreateHandlerThread - luaScript is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.CreateHandlerThread")
	end
end
TRID.SetConnectorThread = function (totalThread)
	if TRIDGLUE then
		TRIDGLUE.SetConnectorThread(totalThread)
	else
		TRID.DebugPrint("[TEST] TRID.CreateHandlerThread")
	end
end
TRID.GetDBConnection = function (baseID, new)
	if baseID and baseID[1] and baseID[2] then
		local connection = {_baseID = baseID}
		connection = TRID._SetClassToInstance(connection, nil, TRID.DBConn)
		
		if new then
			TRID._NewInstance(baseID[1], baseID[2], connection)
		end
		return connection
	else
		TRID.DebugPrint("TRID.GetDBConnection - baseID is invalid.")
		return nil
	end
end
TRID.CreateDBConnector = function (globalName, TNSName, user, password)
	if TRIDGLUE then
		local channelID1, channelID2 = TRIDGLUE.CreateDBConnector(globalName, TNSName, user, password)
		return TRID.GetDBConnection({channelID1, channelID2}, true)
	else
		TRID.DebugPrint("[TEST] TRID.CreateDBConnector")
	end
	return nil
end
TRID.SetNetworkUpdateTime = function (timeInMillisec)
	if TRIDGLUE then
		TRIDGLUE.SetNetworkUpdateTime(timeInMillisec)
	else
		TRID.DebugPrint("[TEST] TRID.SetNetworkUpdateTime")
	end
end
TRID.Sleep = function (timeInMillisec)
	if TRIDGLUE then
		TRIDGLUE.Sleep(timeInMillisec)
	else
		TRID.DebugPrint("[TEST] TRID.Sleep")
	end
end
TRID.GetLocalPath = function (realpath)
	if TRIDGLUE then
		return TRIDGLUE.GetLocalPath(realpath)
	else
		TRID.DebugPrint("[TEST] TRID.GetLocalPath")
	end
	return nil
end
TRID.ShowWeb = function (url)
	if TRIDGLUE then
		TRIDGLUE.ShowWeb(url)
	else
		TRID.DebugPrint("[TEST] TRID.ShowWeb")
	end
end
TRID.MD5Encode = function (str)
	if TRIDGLUE then
		return TRIDGLUE.MD5Encode(str)
	else
		TRID.DebugPrint("[TEST] TRID.MD5Encode")
	end
	return nil
end
TRID.SHA1Encode = function (str)
	if TRIDGLUE then
		return TRIDGLUE.MD5Encode(str, 1)
	else
		TRID.DebugPrint("[TEST] TRID.SHA1Encode")
	end
	return nil
end
TRID.GetFileSize = function (filePath)
	if TRIDGLUE then
		return TRIDGLUE.GetFileSize(filePath)
	else
		TRID.DebugPrint("[TEST] TRID.GetFileSize")
	end
	return nil
end
TRID.GetReferencedImages = function (modelPath)
	if TRIDGLUE then
		return TRIDGLUE.GetRelativeImages(modelPath)
	else
		TRID.DebugPrint("[TEST] TRID.GetReferencedImages")
	end
	return nil
end
TRID.GetImageSize = function (imagePath)
	if TRIDGLUE then
		return TRIDGLUE.GetImageSize(imagePath)
	else
		TRID.DebugPrint("[TEST] TRID.GetImageSize")
	end
	return nil
end
TRID.GetImagePixel = function (imagePath, vec2UV)
	if TRIDGLUE then
		local color = {TRIDGLUE.GetImagePixel(imagePath, vec2UV[1], vec2UV[2])}
		if color[1] then
			return TRID.ARGB(color[4], color[1], color[2], color[3])
		else
			TRID.DebugPrint("TRID.GetImagePixel - no data.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetImagePixel")
	end
	return nil
end
TRID.CopyStringToClipboard = function (text)
	if TRIDGLUE then
		TRIDGLUE.CopyStringToClipboard(text)
	else
		TRID.DebugPrint("[TEST] TRID.CopyStringToClipboard")
	end
end
TRID.GetMousePoint = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetCurrPoint()
	else
		TRID.DebugPrint("[TEST] TRID.GetMousePoint")
	end
	return nil
end
TRID.CalcLeftSecond = function (startYear, startMonth, startDay, startHour, startMin, startSec, endYear, endMonth, endDay, endHour, endMin, endSec)
	if TRIDGLUE then
		return TRIDGLUE.CalcLeftTime(startYear, startMonth, startDay, startHour, startMin, startSec, endYear, endMonth, endDay, endHour, endMin, endSec)
	else
		TRID.DebugPrint("[TEST] TRID.CalcLeftSecond")
	end
	return nil
end
TRID.CalcLeftDay = function (startYear, startMonth, startDay, startHour, startMin, startSec, endYear, endMonth, endDay, endHour, endMin, endSec)
	if TRIDGLUE then
		return TRIDGLUE.CalcLeftDay(startYear, startMonth, startDay, startHour, startMin, startSec, endYear, endMonth, endDay, endHour, endMin, endSec)
	else
		TRID.DebugPrint("[TEST] TRID.CalcLeftSecond")
	end
	return nil
end
TRID.ChangeIMEMode = function (toNative)
	if TRIDGLUE then
		TRIDGLUE.ChangeIMEMode(toNative)
	else
		TRID.DebugPrint("[TEST] TRID.ChangeIMEMode")
	end
end
TRID.SetShaderFlag = function (useVertexShader, usePixelShader)
	if TRIDGLUE then
		TRIDGLUE.SetShaderFlag(useVertexShader, usePixelShader)
	else
		TRID.DebugPrint("[TEST] TRID.SetShaderFlag")
	end
end
TRID.EnableLog = function (enable)
	MODE_DEBUG = enable
	if TRIDGLUE then
		TRIDGLUE.EnableLog(enable)
	else
		TRID.DebugPrint("[TEST] TRID.EnableLog")
	end
	if TRID.GetSystemInfo() == TRID.OS_IOS then
		DEBUG_FILE = nil
	end
end
TRID.GetTextSize = function (text, fontName, fontSize, FONT_TypeFlag, lineGap, limitWidth)
	if TRIDGLUE then
		return TRIDGLUE.GetTextSize(text, fontName, fontSize, FONT_TypeFlag, lineGap, limitWidth)
	else
		TRID.DebugPrint("[TEST] TRID.GetTextSize")
	end
	return nil
end
TRID.SetRegistry = function (name, REG_Type, value)
	if TRIDGLUE then
		TRIDGLUE.SetGlobalRegistry(name, REG_Type, value)
	else
		TRID.DebugPrint("[TEST] TRID.SetRegistry")
	end
end
TRID.GetRegistry = function (name, REG_Type)
	if TRIDGLUE then
		return TRIDGLUE.GetGlobalRegistry(name, REG_Type)
	else
		TRID.DebugPrint("[TEST] TRID.GetRegistry")
	end
	return nil
end


TRID.GetSequence = function (sequenceName)
	if TRIDGLUE then
		return TRIDGLUE.GetSequence(sequenceName)
	else
		TRID.DebugPrint("[TEST] TRID.GetSequence")
	end
	return nil
end
TRID.GetHostName = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetHostName()
	else
		TRID.DebugPrint("[TEST] TRID.GetHostName")
	end
	return nil
end
TRID.RegisterModel = function (modelName, modelProp, doNotRelease)
	if TRIDGLUE then
		if modelName and modelProp then
			return TRIDGLUE.RegisterModel(modelName, modelProp, doNotRelease)
		else
			TRID.DebugPrint("TRID.RegisterModel - no (modelName and modelProp).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.RegisterModel")
	end
	return nil
end
TRID.SplitAlphaChannel = function (imagePath, rgbPath, alphaPath)
	if TRIDGLUE then
		if imagePath and rgbPath and alphaPath then
			return TRIDGLUE.SplitAlphaChannel(imagePath, rgbPath, alphaPath)
		else
			TRID.DebugPrint("TRID.SplitAlphaChannel - no (imagePath and rgbPath and alphaPath).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.SplitAlphaChannel")
	end
	return nil
end

TRID.GetScreenSize = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetScreenSize()
	else
		TRID.DebugPrint("[TEST] TRID.GetScreenSize")
	end
	return nil
end
TRID.ChangeMaterialProperty = function (materialFile, materialName, materialProperty)
	if TRIDGLUE then
		return TRIDGLUE.ChangeMaterialProperty(materialFile, materialName, materialProperty)
	else
		TRID.DebugPrint("[TEST] TRID.ChangeMaterialProperty")
	end
	return nil
end
TRID.GetSystemInfo = function (detail)
	if TRIDGLUE then
		return TRIDGLUE.GetSystemInfo(detail)
	else
		TRID.DebugPrint("[TEST] TRID.GetSystemInfo")
	end
	return nil
end
TRID.GetUserAccount = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetUserAccountInfo()
	else
		TRID.DebugPrint("[TEST] TRID.GetUserAccount")
	end
end
TRID.SetUserAccount = function (userID, userPassword)
	if TRIDGLUE then
		TRIDGLUE.SetUserAccountInfo(userID, userPassword)
	else
		TRID.DebugPrint("[TEST] TRID.SetUserAccount")
	end
end
TRID.GetUserDataPath = function (subPath, backup, mustInternal)
	if TRIDGLUE then
		return TRIDGLUE.GetUserDataPath(subPath, backup, mustInternal)
	else
		TRID.DebugPrint("[TEST] TRID.GetUserDataPath")
	end
	return nil
end
TRID.IsKeyDown = function (VK_Type)
	if TRIDGLUE then
		if VK_Type then
			return TRIDGLUE.IsKeyDown(VK_Type)
		else
			TRID.DebugPrint("TRID.IsKeyDown - no VK_Type.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.IsKeyDown")
	end
	return false
end

TRID.ReplaceImage = function (source, dest, replaceResource, restore, TEXTURE_TypeProp1, alphaMapPath1, TEXTURE_TypeProp2, alphaMapPath2)
	if TRIDGLUE then
		if source and dest then
			TRIDGLUE.ReplaceImage(source, dest, replaceResource, restore, TEXTURE_TypeProp1, alphaMapPath1, TEXTURE_TypeProp2, alphaMapPath2)
		else
			TRID.DebugPrint("TRID.ReplaceImage - no (source and dest).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ReplaceImage")
	end
	return nil
end

TRID.GetImageContainer = function ()
	local imageBuilder = {}
	return TRID._SetClassToInstance(imageBuilder, nil, TRID.ImageContainer)
end

TRID.SetImageContainerInfo = function (imageData)
	if not (imageData and TRIDGLUE) then
		TRID.DebugPrint("TRID.SetImageContainerInfo - imageData or TRIDGLUE is nil.", "error")
		return
	end
	for i, imgInfo in pairs(imageData.imageList) do
--~ 		TRID.DebugPrint("SetImageContainerInfo - " .. i)
		TRIDGLUE.SetImageContainer(imgInfo.path, imgInfo.sx,imgInfo.sy,imgInfo.ex,imgInfo.ey, imageData.containerImage.path,imageData.containerImage.width,imageData.containerImage.height)
	end
end

TRID.GetModelContainer = function ()
	local modelBuilder = {}
	return TRID._SetClassToInstance(modelBuilder, nil, TRID.ModelContainer)
end

TRID.ReleaseResource = function (filePath, RESOURCE_TypeID, TEXTURE_TypeProp, alphaMapPath, alphaRatioVec4, referenceCount)
	if TRIDGLUE then
		if RESOURCE_TypeID then
			TRIDGLUE.ReleaseResource(filePath, RESOURCE_TypeID, referenceCount, TEXTURE_TypeProp, alphaMapPath,
				alphaRatioVec4 and alphaRatioVec4[1] or 1, alphaRatioVec4 and alphaRatioVec4[2] or 1, alphaRatioVec4 and alphaRatioVec4[3] or 1, alphaRatioVec4 and alphaRatioVec4[4] or 1)
		else
			TRID.DebugPrint("TRID.ReleaseResource - RESOURCE_TypeID is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ReleaseResource")
	end
end

TRID.ReserveTexture = function (width, height, FOID_TypeID)
	if TRIDGLUE then
		if width and height and FOID_TypeID then
			TRIDGLUE.ReserveTexture(width, height, FOID_TypeID)
		else
			TRID.DebugPrint("TRID.ReserveTexture - no (width and height and FOID_TypeID).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ReserveTexture")
	end
end

TRID.SetGraphicOption = function (option, clear)
	if TRIDGLUE then
		TRIDGLUE.SetGraphicOption(true, option, clear)
	else
		TRID.DebugPrint("[TEST] TRID.SetGraphicOption")
	end
end

TRID.ResetGraphicOption = function (option)
	if TRIDGLUE then
		TRIDGLUE.SetGraphicOption(false, option)
	else
		TRID.DebugPrint("[TEST] TRID.ResetGraphicOption")
	end
end

TRID.SetETCOption = function (ETC_OPTION_Flag, clear)
	if TRIDGLUE then
		TRIDGLUE.SetETCOption(true, ETC_OPTION_Flag, clear)
	else
		TRID.DebugPrint("[TEST] TRID.SetETCOption")
	end
end

TRID.ResetETCOption = function (ETC_OPTION_Flag)
	if TRIDGLUE then
		TRIDGLUE.SetETCOption(false, ETC_OPTION_Flag)
	else
		TRID.DebugPrint("[TEST] TRID.ResetETCOption")
	end
end

TRID.GetFPS = function ()
	if TRIDGLUE then
		return TRIDGLUE.GetFPS()
	else
		TRID.DebugPrint("[TEST] TRID.GetFPS")
	end
	return 0
end

TRID.DeleteFile = function (filePath)
	if TRIDGLUE then
		return TRIDGLUE.DeleteFile(filePath)
	else
		TRID.DebugPrint("[TEST] TRID.DeleteFile")
	end
	return nil
end

TRID.RemoveFolder = function (folderPath)
	if TRIDGLUE then
		return TRIDGLUE.RemoveFolder(folderPath)
	else
		TRID.DebugPrint("[TEST] TRID.RemoveFolder")
	end
	return nil
end

TRID.AddFont = function (fontName, fontURL)
	if TRIDGLUE then
		if fontURL and fontName then
			TRIDGLUE.AddFont(fontURL, fontName)
		else
			TRID.DebugPrint("TRID.AddFont - no (fontURL and fontName).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.AddFont")
	end
end
TRID.GetSpecificFolder = function (FOLDER_Type, subPath)
	if TRIDGLUE then
		if FOLDER_Type then
			return TRIDGLUE.GetSpecificFolder(FOLDER_Type, subPath)
		else
			TRID.DebugPrint("TRID.GetSpecificFolder - invalid FOLDER_Type.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetSpecificFolder")
	end
	return nil
end
TRID.CopyFile = function (sourcePath, destPath, failIfExists)
	if TRIDGLUE then
		if sourcePath and destPath then
			return TRIDGLUE.CopyFile(sourcePath, destPath, failIfExists)
		else
			TRID.DebugPrint("[TEST] TRID.CopyFile - no (sourcePath and destPath).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.CopyFile")
	end
	return nil
end

TRID._SaveScreen = function (instance, savePath, xOrWidth, yOrHeight, widthOrBlurSize, height, blurSize)
	if TRIDGLUE then
		local baseID = {}
		if instance and instance._baseID then
			baseID = instance._baseID
		end
		if savePath and xOrWidth and yOrHeight then
			if height then
				local blur, jpgQuality, appScreenShot
				if type(blurSize) == "table" then
					blur = blurSize[1]
					jpgQuality = blurSize[2]
					appScreenShot = blurSize[3]
				else
					blur = blurSize
				end
				return TRIDGLUE.SaveScreen(baseID[1], baseID[2], savePath, widthOrBlurSize, height, xOrWidth, yOrHeight, blur, jpgQuality, appScreenShot)
			else
				local blur, jpgQuality, appScreenShot
				if type(widthOrBlurSize) == "table" then
					blur = widthOrBlurSize[1]
					jpgQuality = widthOrBlurSize[2]
					appScreenShot = widthOrBlurSize[3]
				else
					blur = widthOrBlurSize
				end
				return TRIDGLUE.SaveScreen(baseID[1], baseID[2], savePath, xOrWidth, yOrHeight, nil, nil, blur, jpgQuality, appScreenShot)
			end
		else
			TRID.DebugPrint("TRID._SaveScreen - savePath or width or height is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID._SaveScreen")
		return nil
	end
end

TRID.SaveScreen = function (savePath, xOrWidth, yOrHeight, widthOrBlurSize, height, blurSize)
	return TRID._SaveScreen(nil, savePath, xOrWidth, yOrHeight, widthOrBlurSize, height, blurSize)
end

TRID.GetCurrentCameraView = function ()
	if TRIDGLUE then
		local camID1, camID2, viewID1, viewID2 = TRIDGLUE.GetCurrentCameraView()
		if camID1 then
			local cameraInstance = TRID.GetInstance(camID1, camID2, nil, TRID.FOID_3D_CAMERA)
			local viewInstance
			if viewID1 then
				viewInstance = TRID.GetInstance(viewID1, viewID2, nil, TRID.FOID_VIEW)
			else
				TRID.DebugPrint("TRID.GetCurrentCameraView - no view.", "warning")
			end
			return cameraInstance, viewInstance
		else
			TRID.DebugPrint("TRID.GetCurrentCameraView - no camera.", "warning")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetCurrentCameraView")
	end
	return nil
end

TRID.ChangeImage = function (sourceLocalPath, width, height, destLocalPath, jpgQuality)
	if TRIDGLUE then
		if sourceLocalPath and destLocalPath then
			TRIDGLUE.ChangeImage(sourceLocalPath, width, height, destLocalPath, jpgQuality)
		else
			TRID.DebugPrint("[TEST] TRID.ChangeImage - no (sourceLocalPath and destLocalPath).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ChangeImage")
	end
end
TRID.GetAnimationBoneData = function (animRealPath)
	if TRIDGLUE then
		local result = {}
		local boneData = {TRIDGLUE.GetAnimationBoneData(animRealPath)}
		if #boneData > 0 then
			local index = 0
			for i=1, #boneData, 2 do
				result[index] = {name = boneData[i], parentIndex = boneData[i+1]}
				index = index + 1
			end
			return result
		else
			TRID.DebugPrint("TRID.GetAnimationBoneData - no bone data.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetAnimationBoneData")
	end
	return nil
end
TRID.GetAnimationData = function (animRealPath, frame)
	if TRIDGLUE then
		local result = {}
		local a = {TRIDGLUE.GetAnimationData(animRealPath, frame)}
		if #a > 0 then
			local index = 0
			for i=1, #a, 9 do
				result[index] = {position = {a[i],a[i+1],a[i+2]}, rotation = {a[i+3],a[i+4],a[i+5]}, scale = {a[i+6],a[i+7],a[i+8]}}
				index = index + 1
			end
			return result
		else
			TRID.DebugPrint("TRID.GetAnimationData - no anim data.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetAnimationData")
	end
	return nil
end
TRID.SetAnimationFrame = function (animRealPath, frame)
	if TRIDGLUE then
		return TRIDGLUE.SetAnimationFrame(animRealPath, frame)
	else
		TRID.DebugPrint("[TEST] TRID.SetAnimationFrame")
	end
	return nil
end
TRID.SetAnimationData = function (animRealPath, frame, boneIndex, pos, rot, sca)
	if TRIDGLUE then
		return TRIDGLUE.SetAnimationData(animRealPath, frame, boneIndex, pos[1], pos[2], pos[3], rot[1], rot[2], rot[3], sca[1], sca[2], sca[3])
	else
		TRID.DebugPrint("[TEST] TRID.SetAnimationData")
	end
	return nil
end
TRID.SaveAnimation = function (animRealPath)
	if TRIDGLUE then
		return TRIDGLUE.SaveAnimation(animRealPath)
	else
		TRID.DebugPrint("[TEST] TRID.SaveAnimation")
	end
	return nil
end
TRID.NotifyToBrowser = function (msgType, msgData)
	if TRIDGLUE then
		return TRIDGLUE.NotifyToBrowser(msgType, msgData)
	else
		TRID.DebugPrint("[TEST] TRID.NotifyToBrowser")
	end
	return nil
end
TRID.GetUsedImageList = function (modelPath)
	if TRIDGLUE then
		local data = {TRIDGLUE.GetUsedImageList(modelPath)}
		local total = data[1]
		if total then
			local result = {}
			for i=2, #data, 9 do
				local image = data[i]
				local prop = data[i+1]
				local alphamap = data[i+2]
				local ratio = {data[i+3], data[i+4], data[i+5], data[i+6]}
				local mesh = data[i+7]
				local bit = data[i+8]
				table.insert(result, {image, prop, alphamap, ratio, mesh, bit})
			end
			return result
		else
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.GetUsedImageList")
	end
	return nil
end
TRID.GetModelBoundingBox = function (modelPath)
	if TRIDGLUE then
		local data = {TRIDGLUE.GetBoundingBoxOfModel(modelPath)}
		return data[1] and data or nil
	else
		TRID.DebugPrint("[TEST] TRID.GetModelBoundingBox")
	end
	return nil
end
TRID.CropImage = function (fileName, destName, scaledWidth, scaledHeight, cropX, cropY, cropW, cropH, backColor, jpgQuality)
	if TRIDGLUE then
		local c = backColor or TRID.ARGB(0,0,0,0)
		return TRIDGLUE.CropImage(fileName, destName, scaledWidth, scaledHeight, cropX, cropY, cropW, cropH, TRID.COLOR_R(c), TRID.COLOR_G(c), TRID.COLOR_B(c), TRID.COLOR_A(c), jpgQuality)
	else
		TRID.DebugPrint("[TEST] TRID.CropImage")
	end
	return nil
end
TRID.ReadTextFile = function (filePath)
	if TRIDGLUE then
		return TRIDGLUE.ReadTextFile(filePath)
	else
		TRID.DebugPrint("[TEST] TRID.ReadTextFile")
	end
	return nil
end
TRID.WriteTextFile = function (filePath, str, append)
	if TRIDGLUE then
		return TRIDGLUE.WriteTextFile(filePath, str, append)
	else
		TRID.DebugPrint("[TEST] TRID.WriteTextFile")
	end
	return false
end
TRID.GetFiles = function (filePath, FIND_TypeMode)
	if TRIDGLUE then
		return {TRIDGLUE.GetFiles(filePath, FIND_TypeMode)}
	else
		TRID.DebugPrint("[TEST] TRID.GetFiles")
	end
	return {}
end
TRID.GetDownloadingSize = function (realPath)
	if TRIDGLUE then
		return TRIDGLUE.GetDownloadingSize(realPath)
	else
		TRID.DebugPrint("[TEST] TRID.GetDownloadingSize")
	end
	return -1
end
TRID.CheckHitTest = function (check)
	-- _CHECK_HIT_TEST is shared with AppScriptManagerInitializer.cpp,TriDBrowser.java, TriDAppEAGLView.mm
	TRID.NotifyToBrowser("_CHECK_HIT_TEST", tostring(check))
end

TRID.GetCurrentApplication = function ()
	if TRIDGLUE then
		local baseID = {TRIDGLUE.GetCurrentApplication()}
		return TRID.GetInstance(baseID)
	else
		TRID.DebugPrint("[TEST] TRID.GetCurrentApplication")
	end
end

--====================================
-- ImageContainer class.
--====================================
TRID.ImageContainer = TRID.StartClassDefinition("TRID.ImageContainer")
TRID.ImageContainer.Init = function (instance, width, height)
	if TRIDGLUE then
		if instance then
			instance.builder = TRIDGLUE.OpenImageContainer(width, height)
		else
			TRID.DebugPrint("TRID.ImageContainer.Init - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ImageContainer.Init")
	end
end
TRID.ImageContainer.InsertImage = function (instance, imagePath, uvRect)
	if TRIDGLUE then
		if instance and instance.builder and imagePath then
			TRIDGLUE.InsertImageIntoContainer(instance.builder, imagePath, uvRect and uvRect[1], uvRect and uvRect[2], uvRect and uvRect[3], uvRect and uvRect[4])
		else
			TRID.DebugPrint("TRID.ImageContainer.InsertImage - instance or builder or path is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ImageContainer.InsertImage")
	end
end
TRID.ImageContainer.Build = function (instance, outputImagePath, extraSpace, cropUnusedArea, jpgQuality)
	if TRIDGLUE then
		if instance and instance.builder and outputImagePath then
			return TRIDGLUE.CloseImageContainer(instance.builder, outputImagePath, extraSpace, cropUnusedArea, jpgQuality)
		else
			TRID.DebugPrint("TRID.ImageContainer.Build - instance or builder or path is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ImageContainer.Build")
	end
end

TRID.FinishClassDefinition("TRID.ImageContainer")

--====================================
-- ModelContainer class.
--====================================
TRID.ModelContainer = TRID.StartClassDefinition("TRID.ModelContainer")
TRID.ModelContainer.Init = function (instance, limitBone, eyePosForReorderFace, renderFirstFarFromEye)
	if TRIDGLUE then
		if instance then
			instance.builder = TRIDGLUE.OpenModelContainer(limitBone, eyePosForReorderFace and eyePosForReorderFace[1], eyePosForReorderFace and eyePosForReorderFace[2], eyePosForReorderFace and eyePosForReorderFace[3], renderFirstFarFromEye)
		else
			TRID.DebugPrint("TRID.ModelContainer.Init - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.Init")
	end
end
TRID.ModelContainer.InsertMaterial = function (instance, materialProp)
	if TRIDGLUE then
		if instance and instance.builder and materialProp then
			TRIDGLUE.InsertMaterialIntoModelContainer(instance.builder, materialProp)
		else
			TRID.DebugPrint("TRID.ModelContainer.InsertMaterial - instance or builder or materialProp is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.InsertMaterial")
	end
end
TRID.ModelContainer.InsertMesh = function (instance, modelPath, meshIndex, uvRect)
	if TRIDGLUE then
		if instance and instance.builder and modelPath and meshIndex and uvRect then
			TRIDGLUE.InsertMeshIntoModelContainer(instance.builder, modelPath, meshIndex, uvRect[1], uvRect[2], uvRect[3], uvRect[4])
		else
			TRID.DebugPrint("TRID.ModelContainer.InsertMesh - instance or builder or modelPath, meshIndex, uvRect is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.InsertMaterial")
	end
end
TRID.ModelContainer.Build = function (instance, outputPath, animFileForBoneOptimization)
	if TRIDGLUE then
		if instance and instance.builder and outputPath then
			return TRIDGLUE.CloseModelContainer(instance.builder, outputPath, animFileForBoneOptimization)
		else
			TRID.DebugPrint("TRID.ModelContainer.Build - instance or builder or path is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.Build")
	end
end
TRID.ModelContainer.SplitByBone = function (instance, modelPath, outputPath)
	if TRIDGLUE then
		if instance and instance.builder and modelPath and outputPath then
			return TRIDGLUE.SplitModelByBone(instance.builder, modelPath, outputPath)
		else
			TRID.DebugPrint("TRID.ModelContainer.SplitByBone - instance or builder or path is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.SplitByBone")
	end
end
TRID.ModelContainer.ChangeFaceOrder = function (instance, modelPath, outputPath)
	if TRIDGLUE then
		if instance and instance.builder and modelPath and outputPath then
			return TRIDGLUE.ChangeFaceOrder(instance.builder, modelPath, outputPath)
		else
			TRID.DebugPrint("TRID.ModelContainer.ChangeFaceOrder - instance or builder or path is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ModelContainer.ChangeFaceOrder")
	end
end

TRID.FinishClassDefinition("TRID.ModelContainer")

--====================================
-- Binary class.
--====================================
TRID.Binary = TRID.StartClassDefinition("TRID.Binary")
TRID.Binary.GetInt32 = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetInt32(instance.pointer)
		elseif instance and instance.array then
			local value = tonumber(instance.array[instance.curPos])
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetInt32 - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetInt32")
	end
	return nil
end
TRID.Binary.GetInt16 = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetInt16(instance.pointer)
		elseif instance and instance.array then
			local value = tonumber(instance.array[instance.curPos])
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetInt16 - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetInt16")
	end
	return nil
end
TRID.Binary.GetInt8 = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetInt8(instance.pointer)
		elseif instance and instance.array then
			local value = tonumber(instance.array[instance.curPos])
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetInt8 - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetInt8")
	end
	return nil
end
TRID.Binary.GetFloat = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetFloat(instance.pointer)
		elseif instance and instance.array then
			local value = tonumber(instance.array[instance.curPos])
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetFloat - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetFloat")
	end
	return nil
end
TRID.Binary.GetString = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetString(instance.pointer)
		elseif instance and instance.array then
			local value = instance.array[instance.curPos]
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetString - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetString")
	end
	return nil
end
TRID.Binary.GetBinary = function (instance, size)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetBinaryBylstring(instance.pointer, size)
		elseif instance and instance.array then
			local value = instance.array[instance.curPos]
			instance.curPos = instance.curPos + 1
			return value
		else
			TRID.DebugPrint("TRID.Binary.GetBinary - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetBinary")
	end
	return nil
end
TRID.Binary.GetFullData = function (instance)
	if TRIDGLUE then
		if instance and instance.pointer then
			return TRIDGLUE.GetBinaryBylstring(instance.pointer, -1)
		elseif instance and instance.array then
			TRID.DebugPrint("TRID.Binary.GetFullData - this string array can not return full data.", "error")
		else
			TRID.DebugPrint("TRID.Binary.GetFullData - instance or pointer is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Binary.GetFullData")
	end
	return nil
end

TRID.FinishClassDefinition("TRID.Binary")


--====================================
-- base class as top parent class of graphic and logic classes.
--====================================
TRID.Base = TRID.StartClassDefinition("TRID.Base")
TRID.Base.GlueSetProperty = function (instance, FOID_TypeID, propData, create)
	if TRIDGLUE then
		if instance and instance._baseID then
			local baseID = instance._baseID
			if instance.GlueIsLogicObject and instance:GlueIsLogicObject() and instance._graphic and (FOID_TypeID == TRID.FOID_SHADOWMAP_MANAGER or FOID_TypeID == TRID.FOID_ENVMAP_MANAGER or FOID_TypeID == TRID.FOID_POST_EFFECTOR or FOID_TypeID == TRID.FOID_RENDER_CUBEMAP or FOID_TypeID == TRID.FOID_PROJECTION_SHADOW) then
				baseID = instance._graphic._baseID
			end
			TRIDGLUE.SetProperty(baseID[1], baseID[2], FOID_TypeID, propData or {}, create)
		else
			TRID.DebugPrint("TRID.Base.SetProperty - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.SetProperty")
	end
end
TRID.Base.GlueSendMessage = function (targetInstance, MSG_TypeIDorString, strData, delayTimeInMillisec)
	if TRIDGLUE then
		if targetInstance and targetInstance._baseID and MSG_TypeIDorString then
			if type(MSG_TypeIDorString) == "number" then
				TRIDGLUE.SendMessage(0, 0, targetInstance._baseID[1], targetInstance._baseID[2], MSG_TypeIDorString, strData, delayTimeInMillisec)
			elseif type(MSG_TypeIDorString) == "string" then
				TRIDGLUE.SendStringMessage(0, 0, targetInstance._baseID[1], targetInstance._baseID[2], MSG_TypeIDorString, strData, delayTimeInMillisec)
			else
				TRID.DebugPrint("TRID.Base.GlueSendMessage - MSG_TypeIDorString is not number or string.", "error")
			end
		else
			TRID.DebugPrint("TRID.Base.GlueSendMessage - targetInstance or MSG_TypeIDorString is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSendMessage")
	end
end
TRID.Base.GlueSetMessageHandler = function (senderInstance, MSG_TypeIDorString, receiverInstance, functionName, useSenderIDAsFromID)
	if TRIDGLUE then
		if senderInstance and senderInstance._baseID and MSG_TypeIDorString and receiverInstance and receiverInstance._baseID then
			if type(MSG_TypeIDorString) == "number" then
				TRIDGLUE.RegisterMessage2(senderInstance._baseID[1], senderInstance._baseID[2], MSG_TypeIDorString, receiverInstance._baseID[1], receiverInstance._baseID[2], functionName, useSenderIDAsFromID)
			elseif type(MSG_TypeIDorString) == "string" then
				TRIDGLUE.RegisterStringMessage2(senderInstance._baseID[1], senderInstance._baseID[2], MSG_TypeIDorString, receiverInstance._baseID[1], receiverInstance._baseID[2], functionName, useSenderIDAsFromID)
			else
				TRID.DebugPrint("TRID.Base.GlueSetMessageHandler - MSG_TypeIDorString is not number or string.", "error")
			end
		else
			TRID.DebugPrint("TRID.Base.GlueSetMessageHandler - senderInstance or MSG_TypeIDorString or receiverInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetMessageHandler")
	end
end
TRID.Base.GlueResetMessageHandler = function (senderInstance, MSG_TypeIDorString, receiverInstance)
	if TRIDGLUE then
		if senderInstance and senderInstance._baseID and receiverInstance and receiverInstance._baseID and MSG_TypeIDorString then
			if type(MSG_TypeIDorString) == "number" then
				TRIDGLUE.UnregisterMessage(senderInstance._baseID[1], senderInstance._baseID[2], MSG_TypeIDorString, receiverInstance._baseID[1], receiverInstance._baseID[2])
			elseif type(MSG_TypeIDorString) == "string" then
				TRIDGLUE.UnregisterStringMessage(senderInstance._baseID[1], senderInstance._baseID[2], MSG_TypeIDorString, receiverInstance._baseID[1], receiverInstance._baseID[2])
			else
				TRID.DebugPrint("TRID.Base.GlueResetMessageHandler - MSG_TypeIDorString is not number or string.", "error")
			end
		else
			TRID.DebugPrint("TRID.Base.GlueResetMessageHandler - senderInstance or MSG_TypeIDorString or receiverInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetMessageHandler")
	end
end
TRID.Base.GlueCallFunctionWithDelay = function (targetInstance, functionName, argument, delayTimeInMillisec)
	if TRIDGLUE then
		if targetInstance and targetInstance._baseID and functionName then
			local tempTimerName = "__TriD_Delay_Timer_" .. tostring(__TEMP_TIMER_INDEX)
			__TEMP_TIMER_INDEX = __TEMP_TIMER_INDEX + 1
			
			if targetInstance[tempTimerName] then
				TRID.DebugPrint("TRID.Base.GlueCallFunctionWithDelay - targetInstance already has " .. tempTimerName, "error")
				return
			end
			
			targetInstance[tempTimerName] = function (targetInstance)
				local method = TRID.GetMethod(functionName, targetInstance._baseID[1], targetInstance._baseID[2])
				if method then
					method(targetInstance, argument)
				else
					TRID.DebugPrint("TRID.Base.GlueCallFunctionWithDelay - method is nil.")
				end
				targetInstance[tempTimerName] = nil
				return TRID.RESULT_NOT_FOUND
			end
			
			TRIDGLUE.SetLoopTimer(targetInstance._baseID[1], targetInstance._baseID[2], tempTimerName, delayTimeInMillisec, tempTimerName)
			return tempTimerName
		else
			TRID.DebugPrint("TRID.Base.GlueCallFunctionWithDelay - targetInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueCallFunctionWithDelay")
	end
end
TRID.Base.GlueCallMethodWithDelay = function (targetInstance, functionName, delayTimeInMillisec, ...)
	return TRID.Base.GlueCallMethodWithDelayNFlag(targetInstance, functionName, nil, delayTimeInMillisec, ...)
end
TRID.Base.GlueCallMethodWithDelayNFlag = function (targetInstance, functionName, TIMER_TypeFlag, delayTimeInMillisec, ...)
	if TRIDGLUE then
		if targetInstance and targetInstance._baseID and functionName then
			local tempTimerName = "__TriD_Delay_Timer_" .. tostring(__TEMP_TIMER_INDEX)
			__TEMP_TIMER_INDEX = __TEMP_TIMER_INDEX + 1
			
			if targetInstance[tempTimerName] then
				TRID.DebugPrint("TRID.Base.GlueCallMethodWithDelayNFlag - targetInstance already has " .. tempTimerName, "error")
				return
			end
			local arguments = {...}
			targetInstance[tempTimerName] = function (targetInstance)
				local method = TRID.GetMethod(functionName, targetInstance._baseID[1], targetInstance._baseID[2])
				if method then
					TRID.TryAndCatchException(
						function ()
							method(targetInstance, table.unpack(arguments))
						end)
				else
					TRID.DebugPrint("TRID.Base.GlueCallMethodWithDelayNFlag - method is nil.")
				end
				targetInstance[tempTimerName] = nil
				return TRID.RESULT_NOT_FOUND
			end
			
			TRIDGLUE.SetLoopTimer(targetInstance._baseID[1], targetInstance._baseID[2], tempTimerName, delayTimeInMillisec, tempTimerName, TIMER_TypeFlag)
			return tempTimerName
		else
			TRID.DebugPrint("TRID.Base.GlueCallMethodWithDelayNFlag - targetInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueCallMethodWithDelayNFlag")
	end
end
TRID.Base.GlueSetName = function (instance, name)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetInstanceName(instance._baseID[1], instance._baseID[2], name)
		else
			TRID.DebugPrint("TRID.Base.GlueSetName - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetName")
	end
end
TRID.Base.GlueGetName = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.GetInstanceName(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Base.GlueGetName - instance is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueGetName")
		return nil
	end
end
TRID.Base.GlueSetTimer = function (instance, timerName, timeInMillisec, functionName, TIMER_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID and functionName then
			TRIDGLUE.SetLoopTimer(instance._baseID[1], instance._baseID[2], timerName, timeInMillisec, functionName, TIMER_TypeFlag)
			return timerName
		else
			TRID.DebugPrint("TRID.Base.GlueSetTimer - instance or functionName is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetTimer")
	end
	return nil
end
TRID.Base.GlueResetTimer = function (instance, timerName)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ResetLoopTimer(instance._baseID[1], instance._baseID[2], timerName)
		else
			TRID.DebugPrint("TRID.Base.GlueResetTimer - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetTimer")
	end
end
TRID.Base.GlueGetObjectsAround = function (instance, boxMinVec3, boxMaxVec3)
	if TRIDGLUE then
		if instance and instance._baseID and boxMinVec3 and boxMaxVec3 then
			local strBaseIDList = TRIDGLUE.GetObjectsAround(instance._baseID[1], instance._baseID[2], boxMinVec3[1],boxMinVec3[2],boxMinVec3[3], boxMaxVec3[1],boxMaxVec3[2],boxMaxVec3[3])
			local IDArray = TRID.SplitBySeparator(strBaseIDList)
			local instanceList = {}
			local baseID1 = nil
			for i=1, #IDArray do
				if i%2 == 0 then
					local instance = TRID.GetInstance(baseID1, IDArray[i])
					if instance then
						table.insert(instanceList, instance)
					else
						TRID.DebugPrint("TRID.Base.GlueGetObjectsAround - [" .. tostring(baseID1) .. "][" .. tostring(IDArray[i]) .. "] is not found.")
					end
				else
					baseID1 = IDArray[i]
				end
			end
			return instanceList
		else
			TRID.DebugPrint("TRID.Base.GlueGetObjectsAround - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueGetObjectsAround")
	end
	return nil
end
TRID.Base.GlueNotifyAllChilds = function (instance, MSG_TypeID, stringData)
	if TRIDGLUE then
		if instance and instance._baseID and MSG_TypeID then
			TRIDGLUE.NotifyAllChilds(instance._baseID[1], instance._baseID[2], MSG_TypeID, stringData)
		else
			TRID.DebugPrint("TRID.Base.GlueNotifyAllChilds - instance or MSG_TypeID is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueNotifyAllChilds")
	end
end
TRID.Base.GlueDelete = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SendMessage(0,0, instance._baseID[1], instance._baseID[2], TRID.MSG_DELETE)
		else
			TRID.DebugPrint("TRID.Base.GlueDelete - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueDelete")
	end
end
TRID.Base.GlueRemoveNode = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.RemoveNode(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Base.GlueRemoveNode - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueRemoveNode")
	end
end
TRID.Base.GlueLoadManually = function (instance, filePath, RESOURCE_TypeID, funcName, LOAD_MANUALLY_Flag, failedFuncName)
	if TRIDGLUE then
		if instance and instance._baseID and filePath and RESOURCE_TypeID then
			if LOAD_MANUALLY_Flag and type(LOAD_MANUALLY_Flag) == "boolean" then
				LOAD_MANUALLY_Flag = TRID.LOAD_MANUALLY_PERMANENT
			end
			return TRIDGLUE.LoadManually(filePath, RESOURCE_TypeID, instance._baseID[1], instance._baseID[2], funcName, LOAD_MANUALLY_Flag or 0, failedFuncName)
		else
			TRID.DebugPrint("TRID.Base.GlueLoadManually - instance or loading data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueLoadManually")
	end
	return false
end
TRID.Base.GlueLoadPuppyredExternModelManually = function (instance, filePath, index, funcName, LOAD_MANUALLY_Flag, failedFuncName)
	if TRIDGLUE then
		if instance and instance._baseID and filePath and funcName and index then
			if LOAD_MANUALLY_Flag and type(LOAD_MANUALLY_Flag) == "boolean" then
				LOAD_MANUALLY_Flag = TRID.LOAD_MANUALLY_PERMANENT
			end
			return TRIDGLUE.LoadManually(filePath, TRID.RESOURCE_PUPPYRED_EXTERN_MODEL_RESOURCE, instance._baseID[1], instance._baseID[2], funcName, index, LOAD_MANUALLY_Flag or 0, failedFuncName)
		else
			TRID.DebugPrint("TRID.Base.GlueLoadPuppyredExternModelManually - instance or loading data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueLoadManually")
	end
	return false
end
TRID.Base.GlueLoadPuppyredExternAnimationManually = function (instance, filePath, index, funcName, LOAD_MANUALLY_Flag, failedFuncName)
	if TRIDGLUE then
		if instance and instance._baseID and filePath and funcName and index then
			if LOAD_MANUALLY_Flag and type(LOAD_MANUALLY_Flag) == "boolean" then
				LOAD_MANUALLY_Flag = TRID.LOAD_MANUALLY_PERMANENT
			end
			return TRIDGLUE.LoadManually(filePath, TRID.RESOURCE_PUPPYRED_EXTERN_ANIMATION_RESOURCE, instance._baseID[1], instance._baseID[2], funcName, index, LOAD_MANUALLY_Flag or 0, failedFuncName)
		else
			TRID.DebugPrint("TRID.Base.GlueLoadPuppyredExternAnimationManually - instance or loading data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueLoadManually")
	end
	return false
end
TRID.Base.GlueLoadImageManually = function (instance, filePath, funcName, TEXTURE_TypeProp, alphaMapPath, alphaRatioVec4, LOAD_MANUALLY_Flag, failedFuncName)
	if TRIDGLUE then
		if instance and instance._baseID and filePath and funcName then
			if LOAD_MANUALLY_Flag and type(LOAD_MANUALLY_Flag) == "boolean" then
				LOAD_MANUALLY_Flag = TRID.LOAD_MANUALLY_PERMANENT
			end
			return TRIDGLUE.LoadManually(filePath, TRID.RESOURCE_BITMAPIMAGE, instance._baseID[1], instance._baseID[2], funcName, TEXTURE_TypeProp, alphaMapPath, 
				alphaRatioVec4 and alphaRatioVec4[1] or 1, alphaRatioVec4 and alphaRatioVec4[2] or 1, alphaRatioVec4 and alphaRatioVec4[3] or 1, alphaRatioVec4 and alphaRatioVec4[4] or 1, 
				LOAD_MANUALLY_Flag or 0, failedFuncName)
		else
			TRID.DebugPrint("TRID.Base.GlueLoadImageManually - instance or loading data or funcName is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueLoadImageManually")
	end
	return false
end
TRID.Base.GlueIsSame = function (instance, targetInstance)
	if TRIDGLUE then
		if instance and instance._baseID and targetInstance and targetInstance._baseID then
			return TRID.IsSameBaseID(instance._baseID, targetInstance._baseID)
		else
			TRID.DebugPrint("TRID.Base.GlueIsSame - instance or targetInstance data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueIsSame")
	end
	return false
end
TRID.Base.GlueGetStringID = function (instance, delimiter)
	if TRIDGLUE then
		if instance and instance._baseID then
			local char = delimiter and tostring(delimiter) or TRID.DEFAULT_DELIMITER
			return tostring(instance._baseID[1]) .. char .. tostring(instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Base.GlueGetStringID - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueGetStringID")
	end
	return nil
end
TRID.Base.GlueIsDeleted = function (instance)
	return instance and instance.__TRID_DELETED__
end
TRID.Base.GlueSetMoveTarget = function (instance, targetInstance, boneName, preOffsetPosVec3, preOffsetRotVec3, preOffsetScaVec3, postOffsetPosVec3, postOffsetRotVec3, postOffsetScaVec3)
	if TRIDGLUE then
		if instance and instance._baseID and targetInstance and targetInstance._baseID then
			TRIDGLUE.SetMoveTarget(instance._baseID[1], instance._baseID[2], 
				targetInstance._baseID[1], targetInstance._baseID[2], boneName, 
				preOffsetPosVec3 and preOffsetPosVec3[1] or 0, preOffsetPosVec3 and preOffsetPosVec3[2] or 0, preOffsetPosVec3 and preOffsetPosVec3[3] or 0, 
				preOffsetRotVec3 and preOffsetRotVec3[1] or 0, preOffsetRotVec3 and preOffsetRotVec3[2] or 0, preOffsetRotVec3 and preOffsetRotVec3[3] or 0, 
				preOffsetScaVec3 and preOffsetScaVec3[1] or 1, preOffsetScaVec3 and preOffsetScaVec3[2] or 1, preOffsetScaVec3 and preOffsetScaVec3[3] or 1,
				postOffsetPosVec3 and postOffsetPosVec3[1] or 0, postOffsetPosVec3 and postOffsetPosVec3[2] or 0, postOffsetPosVec3 and postOffsetPosVec3[3] or 0, 
				postOffsetRotVec3 and postOffsetRotVec3[1] or 0, postOffsetRotVec3 and postOffsetRotVec3[2] or 0, postOffsetRotVec3 and postOffsetRotVec3[3] or 0, 
				postOffsetScaVec3 and postOffsetScaVec3[1] or 1, postOffsetScaVec3 and postOffsetScaVec3[2] or 1, postOffsetScaVec3 and postOffsetScaVec3[3] or 1)
		else
			TRID.DebugPrint("TRID.Base.GlueSetMoveTarget - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetMoveTarget")
	end
end
TRID.Base.GlueResetMoveTarget = function (instance, targetInstance)
	if TRIDGLUE then
		if instance and instance._baseID and targetInstance and targetInstance._baseID then
			TRIDGLUE.ResetMoveTarget(instance._baseID[1], instance._baseID[2], targetInstance._baseID[1], targetInstance._baseID[2])
		else
			TRID.DebugPrint("TRID.Base.GlueResetMoveTarget - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetMoveTarget")
	end
end
TRID.Base.GlueSetAnimation = function (instance, animSlot, animFile, FPS, looping, restartAnimation, interpolationTimeInMillisec, applyAbsolutely, animAlias, animIndexForModelSet, startFrame, endFrame)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetAnimation(instance._baseID[1], instance._baseID[2], animSlot, animFile, FPS, looping, not restartAnimation, interpolationTimeInMillisec or 200, animIndexForModelSet, applyAbsolutely, animAlias, startFrame, endFrame)
		else
			TRID.DebugPrint("TRID.Base.GlueSetAnimation - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetAnimation")
	end
end
TRID.Base.GlueResetAnimation = function (instance, animSlot)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.StopAnimation(instance._baseID[1], instance._baseID[2], animSlot)
		else
			TRID.DebugPrint("TRID.Base.GlueResetAnimation - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetAnimation")
	end
end
TRID.Base.GluePauseAnimation = function (instance, pause)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.PauseAnimation(instance._baseID[1], instance._baseID[2], pause)
		else
			TRID.DebugPrint("TRID.Base.GluePauseAnimation - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GluePauseAnimation")
	end
end
TRID.Base.GlueSetAnimationNotification = function (instance, animFile, frameTime)
	if TRIDGLUE then
		if instance and instance._baseID and animFile and frameTime then
			TRIDGLUE.SetAnimationNotification(instance._baseID[1], instance._baseID[2], animFile, frameTime, true)
		else
			TRID.DebugPrint("TRID.Base.GlueSetAnimationNotification - (instance or animFile or frameTime) is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetAnimationNotification")
	end
end
TRID.Base.GlueResetAnimationNotification = function (instance, animFile, frameTime)
	if TRIDGLUE then
		if instance and instance._baseID and animFile then
			TRIDGLUE.SetAnimationNotification(instance._baseID[1], instance._baseID[2], animFile, frameTime, false)
		else
			TRID.DebugPrint("TRID.Base.GlueResetAnimationNotification - (instance or animFile) is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetAnimationNotification")
	end
end
TRID.Base.GlueGetCurrentAnimationFrameTime = function (instance, animSlot)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.GetCurrentAnimationFrameTime(instance._baseID[1], instance._baseID[2], animSlot)
		else
			TRID.DebugPrint("TRID.Base.GlueGetCurrentAnimationFrameTime - instance is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueGetCurrentAnimationFrameTime")
		return nil
	end
end
TRID.Base.GlueSetAnimationFrameTime = function (instance, animSlot, fTime, calcLooping)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetAnimationFrameTime(instance._baseID[1], instance._baseID[2], animSlot, fTime, calcLooping)
		else
			TRID.DebugPrint("TRID.Base.GlueSetAnimationFrameTime - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetAnimationFrameTime")
	end
end
TRID.Base.GlueSetBoneCustomizingData = function (instance, customizingName, boneName, BONE_CUSTOM_TypeID, vec3, applyToAllChild, applyBefore)
	if TRIDGLUE then
		if instance and instance._baseID and customizingName and BONE_CUSTOM_TypeID and vec3 then
			TRIDGLUE.SetBoneCustomizingData(instance._baseID[1], instance._baseID[2], customizingName, boneName, BONE_CUSTOM_TypeID, vec3[1],vec3[2],vec3[3], applyToAllChild, applyBefore == nil and true or applyBefore)
		else
			TRID.DebugPrint("TRID.Base.GlueSetBoneCustomizingData - instance or customizingName or BONE_CUSTOM_TypeID or vec3 is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetBoneCustomizingData")
	end
end
TRID.Base.GlueResetBoneCustomizingData = function (instance, customizingName)
	if TRIDGLUE then
		if instance and instance._baseID and customizingName then
			TRIDGLUE.ResetBoneCustomizingData(instance._baseID[1], instance._baseID[2], customizingName)
		else
			TRID.DebugPrint("TRID.Base.GlueResetBoneCustomizingData - instance or customizingName is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueResetBoneCustomizingData")
	end
end
TRID.Base.GlueSetBillboard = function (instance, boneName, BILLBOARD_TypeID, normalVector, axisOrUpVector)
	if TRIDGLUE then
		if instance and instance._baseID and BILLBOARD_TypeID and normalVector and axisOrUpVector then
			TRIDGLUE.SetBoneCustomizingData(instance._baseID[1], instance._baseID[2], boneName, boneName, TRID.MakeDWord(BILLBOARD_TypeID, TRID.BONE_CUSTOM_BILLBOARD), normalVector[1],normalVector[2],normalVector[3], false, true, axisOrUpVector[1], axisOrUpVector[2], axisOrUpVector[3])
		else
			TRID.DebugPrint("TRID.Base.GlueSetBillboard - instance or BILLBOARD_TypeID or normalVector or axisOrUpVector is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetBillboard")
	end
end
TRID.Base.GlueResetBillboard = function (instance, boneName)
	TRID.Base.GlueResetBoneCustomizingData(instance, boneName)
end

TRID.Base.GlueAttachBillboard = function (instance, pos, width, height, color, materialProp)
	if TRIDGLUE then
		if instance and instance._baseID and  pos then
		
		
			TRIDGLUE.AttachBillboard(instance._baseID[1], instance._baseID[2], pos[1], pos[2], pos[3], width or 1, height or 1, color and TRID.COLOR_R(color) or nil, color and TRID.COLOR_G(color) or nil, color and TRID.COLOR_B(color) or nil, materialProp or nil)
		else
			TRID.DebugPrint("TRID.Base.GlueAttachBillboard - instance or  pos is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueAttachBillboard")
	end
end

TRID.Base.GlueSetMotionByContentsTime = function (instance, set, CONTENTS_TIME_APPLY_Mode)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetMotionByContentsTime(instance._baseID[1], instance._baseID[2], set, CONTENTS_TIME_APPLY_Mode or TRID.CONTENTS_TIME_APPLY_MOTION)
		else
			TRID.DebugPrint("TRID.Base.GlueSetMotionByContentsTime - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Base.GlueSetMotionByContentsTime")
	end
end


TRID.FinishClassDefinition("TRID.Base")

--====================================
-- graphic class.
--====================================
TRID.Graphic = TRID.StartClassDefinition("TRID.Graphic", "TRID.Base")
TRID.Graphic.GlueIsGraphicObject = function (instance)
	return true
end
TRID.Graphic.GlueAddChild = function (instance, childInstance)
	if TRIDGLUE then
		if instance and instance._baseID and childInstance and childInstance._baseID then
			if TRIDGLUE.Assert(childInstance:GlueIsGraphicObject(), "TRID.Graphic.GlueAddChild - childInstance is not a graphic object.") then
				TRIDGLUE.AddGraphicChild(instance._baseID[1], instance._baseID[2], childInstance._baseID[1], childInstance._baseID[2])
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueAddChild - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueAddChild")
	end
end
-- this method is for only logic objedt.
--[[
TRID.Graphic.GlueGetParent = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			local parentID1, parentID2 = TRIDGLUE.GetGraphicParent(instance._baseID[1], instance._baseID[2])
			if parentID1 then
				return TRID.GetInstance(parentID1, parentID2, nil, TRID.FOID_GRAPHIC_OBJECT)
			else
				return nil
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetParent - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetParent")
	end
end
--]]
TRID.Graphic.GlueSetFlag = function (instance, FLAG_TypeFlag, enableMultiSet)
	if TRIDGLUE then
		if instance and instance._baseID and FLAG_TypeFlag then
			TRIDGLUE.SetNodeFlag(instance._baseID[1], instance._baseID[2], FLAG_TypeFlag, true, enableMultiSet)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetFlag - instance or flag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetFlag")
	end
end
TRID.Graphic.GlueResetFlag = function (instance, FLAG_TypeFlag, enableMultiSet)
	if TRIDGLUE then
		if instance and instance._baseID and FLAG_TypeFlag then
			TRIDGLUE.SetNodeFlag(instance._baseID[1], instance._baseID[2], FLAG_TypeFlag, false, enableMultiSet)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetFlag - instance or flag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetFlag")
	end
end
TRID.Graphic.GlueSetMaterial = function (instance, modelSlot, materialGroup, materialFile, materialName, renderPass)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetMaterial(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, materialFile, materialName, renderPass or 0)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetSetMaterial - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetSetMaterial")
	end
end
TRID.Graphic.GlueSetMaterialWithProperty = function (instance, modelSlot, materialGroup, materialProp, useMaterialNameAsKey, renderPass, frameInstance, renderFrameAlways)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup and materialProp then
			TRIDGLUE.SetMaterialWithProperty(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, materialProp, useMaterialNameAsKey, renderPass or 0, frameInstance and frameInstance._baseID[1] or nil, frameInstance and frameInstance._baseID[2] or nil, renderFrameAlways)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMaterialWithProperty - instance or material data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMaterialWithProperty")
	end
end
TRID.Graphic.GlueSetParticleMaterial = function (instance, materialProp)
	if TRIDGLUE then
		if instance and instance._baseID and materialProp then
			TRIDGLUE.SetParticleMaterial(instance._baseID[1], instance._baseID[2], materialProp)
		else
			TRID.DebugPrint("TRID.Graphic.SetParticleMaterial - instance or material data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.SetParticleMaterial")
	end
end
TRID.Graphic.GluePlayParticleSystem = function (instance, play, restart)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.PlayParticleSystem(instance._baseID[1], instance._baseID[2], play, restart or true)
		else
			TRID.DebugPrint("TRID.Graphic.GluePlayParticleSystem - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GluePlayParticleSystem")
	end
end

TRID.Graphic.GlueAttachToSocket = function (instance, target, boneName)
	if TRIDGLUE then
		if instance and instance._baseID and target and target._baseID then
			TRIDGLUE.AttachToSocket(instance._baseID[1], instance._baseID[2], target._baseID[1], target._baseID[2], boneName)
		else
			TRID.DebugPrint("TRID.Graphic.GlueAttachToSocket - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueAttachToSocket")
	end
end


TRID.Graphic.GlueSetMaterialWithRedirection = function (instance, modelSlot, materialGroup, targetInstance)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup and targetInstance and targetInstance._baseID then
			TRIDGLUE.SetMaterialWithRedirection(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, targetInstance._baseID[1], targetInstance._baseID[2])
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMaterialWithRedirection - instance or material data or targetInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMaterialWithRedirection")
	end
end
TRID.Graphic.GlueResetMaterial = function (instance, modelSlot, materialGroup, renderPass)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ResetMaterial(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, renderPass or 0)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetMaterial - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetMaterial")
	end
end
TRID.Graphic.GlueSetModel = function (instance, modelSlot, modelName, modelIndexForModelSet)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetModel(instance._baseID[1], instance._baseID[2], modelSlot, modelName, modelIndexForModelSet)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetModel - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetModel")
	end
end
TRID.Graphic.GlueResetModel = function (instance, modelSlot)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ResetModel(instance._baseID[1], instance._baseID[2], modelSlot)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetModel - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetModel")
	end
end
TRID.Graphic.GlueShowModel = function (instance, modelSlot, show)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ShowModel(instance._baseID[1], instance._baseID[2], modelSlot, show)
		else
			TRID.DebugPrint("TRID.Graphic.GlueShowModel - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueShowModel")
	end
end
TRID.Graphic.GlueHasModel = function (instance, modelName, modelIndexForModelSet)
	if TRIDGLUE then
		if instance and instance._baseID and modelName then
			return TRIDGLUE.HasModel(instance._baseID[1], instance._baseID[2], modelName, modelIndexForModelSet)
		else
			TRID.DebugPrint("TRID.Graphic.GlueHasModel - instance or modelName is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueHasModel")
	end
	return nil
end
TRID.Graphic.GlueShowBoundingArea = function (instance, show)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ShowBoundingArea(instance._baseID[1], instance._baseID[2], show)
		else
			TRID.DebugPrint("TRID.Graphic.GlueShowBoundingArea - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueShowBoundingArea")
	end
end
TRID.Graphic.GlueGetBoundingArea = function (instance, isLocal)
	if TRIDGLUE then
		if instance and instance._baseID then
			return {TRIDGLUE.GetBoundingArea(instance._baseID[1], instance._baseID[2], isLocal)}
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetBoundingArea - instance is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetBoundingArea")
		return nil
	end
end
TRID.Graphic.GlueSetDestination = function (instance, posVec3OrTarget, rotVec3OrMOTION_FLAG_Type, scaVec3, LAYOUT_TypeFlag, MOTION_FLAG_Type, easeTimeInMillisec)
	if TRIDGLUE then
		if instance and instance._baseID then
			if posVec3OrTarget and posVec3OrTarget._baseID then
				TRIDGLUE.SetDestinationTarget(instance._baseID[1], instance._baseID[2], posVec3OrTarget._baseID[1], posVec3OrTarget._baseID[2], rotVec3OrMOTION_FLAG_Type)
			else
				TRIDGLUE.SetDestination(instance._baseID[1], instance._baseID[2], 
					posVec3OrTarget and posVec3OrTarget[1] or nil, posVec3OrTarget and posVec3OrTarget[2] or nil, posVec3OrTarget and posVec3OrTarget[3] or nil, 
					rotVec3OrMOTION_FLAG_Type and rotVec3OrMOTION_FLAG_Type[1] or nil, rotVec3OrMOTION_FLAG_Type and rotVec3OrMOTION_FLAG_Type[2] or nil, rotVec3OrMOTION_FLAG_Type and rotVec3OrMOTION_FLAG_Type[3] or nil, 
					scaVec3 and scaVec3[1] or nil, scaVec3 and scaVec3[2] or nil, scaVec3 and scaVec3[3] or nil, false, LAYOUT_TypeFlag, MOTION_FLAG_Type, easeTimeInMillisec)
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetDestination - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetDestination")
	end
end
TRID.Graphic.GlueGetDestination = function (instance, MOTION_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and MOTION_TypeID then
			local x,y,z,success = TRIDGLUE.GetDestination(instance._baseID[1], instance._baseID[2], MOTION_TypeID)
			return {x,y,z}, success
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetDestination - instance or motionType is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetDestination")
		return nil
	end
end
TRID.Graphic.GlueSetDirection = function (instance, targetVec3, isLocalPosition)
	if TRIDGLUE then
		if instance and instance._baseID and targetVec3 then
			TRIDGLUE.SetDirection(instance._baseID[1], instance._baseID[2], targetVec3[1],targetVec3[2],targetVec3[3], isLocalPosition)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetDirection - instance or targetVec3 is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetDirection")
	end
end
TRID.Graphic.GlueStopMoving = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.StopMoving(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Graphic.GlueStopMoving - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueStopMoving")
	end
end
TRID.Graphic.GlueSetSendMovingTimer = function (instance, timerInMillisec)
	if TRIDGLUE then
		if instance and instance._baseID and timerInMillisec then
			TRIDGLUE.SetSendMovingTimer(instance._baseID[1], instance._baseID[2], timerInMillisec)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetSendMovingTimer - instance or timerInMillisec is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetSendMovingTimer")
	end
end
TRID.Graphic.GlueSetMotionData = function (instance, MOTION_TypeID, vec3)
	if TRIDGLUE then
		if instance and instance._baseID and vec3 and MOTION_TypeID then
			TRIDGLUE.SetMotionData(instance._baseID[1], instance._baseID[2], MOTION_TypeID, vec3[1], vec3[2], vec3[3])
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMotionData - instance or vec3 or motionType is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMotionData")
	end
end
TRID.Graphic.GlueGetMotionData = function (instance, MOTION_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and MOTION_TypeID then
			return {TRIDGLUE.GetMotionData(instance._baseID[1], instance._baseID[2], MOTION_TypeID)}
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetMotionData - instance or motionType is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetMotionData")
		return nil
	end
end
TRID.Graphic.GlueSetLookat = function (instance, targetInstance, offsetVec3, offsetRotVec3,offsetScalVec3 )
	if TRIDGLUE then
		if instance and instance._baseID and targetInstance and targetInstance._baseID then
			TRIDGLUE.SetLookatTarget(instance._baseID[1], instance._baseID[2], targetInstance._baseID[1], targetInstance._baseID[2], 
				offsetVec3 and offsetVec3[1] or 0, offsetVec3 and offsetVec3[2] or 0, offsetVec3 and offsetVec3[3] or 0,
                                offsetRotVec3 and offsetRotVec3[1] or 0, offsetRotVec3 and offsetRotVec3[2] or 0, offsetRotVec3 and offsetRotVec3[3] or 0 ,
				offsetScalVec3 and offsetScalVec3[1] or 1, offsetScalVec3 and offsetScalVec3[2] or 1, offsetScalVec3 and offsetScalVec3[3] or 1 )
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetLookat - instance or targetInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetLookat")
	end
end
TRID.Graphic.GlueResetLookat = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetLookatTarget(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetLookat - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetLookat")
	end
end
TRID.Graphic.GlueSetEffect = function (instance, EFFECT_TypeID, floatVec4OrColor)
	if TRIDGLUE then
		if instance and instance._baseID and EFFECT_TypeID and floatVec4OrColor then
			local floatVec4 = floatVec4OrColor
			if floatVec4OrColor[1] == TRID.COLOR_MARK then
				floatVec4 = {TRID.COLOR_R(floatVec4OrColor)/255, TRID.COLOR_G(floatVec4OrColor)/255, TRID.COLOR_B(floatVec4OrColor)/255, TRID.COLOR_A(floatVec4OrColor)/255}
			end
			TRIDGLUE.SetEffectMotion(instance._baseID[1], instance._baseID[2], EFFECT_TypeID, floatVec4[1], floatVec4[2], floatVec4[3], floatVec4[4])
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetEffect - instance or colorType or floatVec4 is nil.", "warning")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetEffect")
	end
end
TRID.Graphic.GlueGetEffect = function (instance, EFFECT_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and EFFECT_TypeID then
			return {TRIDGLUE.GetEffectMotion(instance._baseID[1], instance._baseID[2], EFFECT_TypeID)}
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetEffect - instance or colorType is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetEffect")
		return nil
	end
end
TRID.Graphic.GlueSetFocus = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetFocus(instance._baseID[1], instance._baseID[2], true)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetFocus - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetFocus")
	end
end
TRID.Graphic.GlueResetFocus = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetFocus(instance._baseID[1], instance._baseID[2], false)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetFocus - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetFocus")
	end
end
TRID.Graphic.GlueSetCubemap = function (instance, cubemapPath)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetCubeMap(instance._baseID[1], instance._baseID[2], cubemapPath)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetCubemap - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetCubemap")
	end
end
TRID.Graphic.GlueResetCubemap = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetCubeMap(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetCubemap - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetCubemap")
	end
end
TRID.Graphic.GlueSetLightmap = function (instance, lightmapPath, intensity)
	if TRIDGLUE then
		if instance and instance._baseID and lightmapPath then
			TRIDGLUE.SetLightmap(instance._baseID[1], instance._baseID[2], lightmapPath, intensity or 1)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetLightmap - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetLightmap")
	end
end
TRID.Graphic.GlueSetMorphing = function (instance, baseModelName, partName, morphingFile)
	if TRIDGLUE then
		if instance and instance._baseID and baseModelName and partName and morphingFile then
			TRIDGLUE.SetMorphing(instance._baseID[1], instance._baseID[2], baseModelName, partName, morphingFile)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMorphing - instance or morphing data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMorphing")
	end
end
TRID.Graphic.GlueSetMorphAnimation = function (instance, baseModelName, partName, morphingFile, FPS, looping)
	if TRIDGLUE then
		if instance and instance._baseID and baseModelName and partName and morphingFile and FPS then
			TRIDGLUE.SetMorphing(instance._baseID[1], instance._baseID[2], baseModelName, partName, morphingFile, true, FPS, looping)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMorphAnimation - instance or morphing data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMorphAnimation")
	end
end
TRID.Graphic.GlueResetMorphing = function (instance, baseModelName, partName)
	if TRIDGLUE then
		if instance and instance._baseID and baseModelName and partName then
			TRIDGLUE.ResetMorphing(instance._baseID[1], instance._baseID[2], baseModelName, partName)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetMorphing - instance or morphing data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetMorphing")
	end
end
TRID.Graphic.GlueSetMorphingFrame = function (instance, baseModelName, partName, fTime)
	if TRIDGLUE then
		if instance and instance._baseID and baseModelName and partName and fTime then
			TRIDGLUE.SetMorphingFrame(instance._baseID[1], instance._baseID[2], baseModelName, partName, fTime)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetMorphingFrame - instance or morphing data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetMorphingFrame")
	end
end
TRID.Graphic.GlueSetPosition = function (instance, posVec3, rotVec3, scaVec3, hasMotion, addLAYOUT_TypeFlag, delLAYOUT_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID then
			local data = {}
			TRID.MakeOnePropOfPosition(data, 
				posVec3 and posVec3[1] or 0, posVec3 and posVec3[2] or 0, posVec3 and posVec3[3] or 0, 
				rotVec3 and rotVec3[1] or 0, rotVec3 and rotVec3[2] or 0, rotVec3 and rotVec3[3] or 0, 
				scaVec3 and scaVec3[1] or 1, scaVec3 and scaVec3[2] or 1, scaVec3 and scaVec3[3] or 1, hasMotion, addLAYOUT_TypeFlag, nil, nil, nil, delLAYOUT_TypeFlag)
			TRIDGLUE.SetProperty(instance._baseID[1], instance._baseID[2], TRID.FOID_POSITION, data)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetPosition - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetPosition")
	end
end
TRID.Graphic.GlueSetColorAdjust = function (instance, modelSlot, materialGroup, hue, saturation, intensityRatio, keepTempData, maskImagePath)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup and hue and saturation and intensityRatio then
			TRIDGLUE.SetColorAdjust(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, true, hue, saturation, intensityRatio, keepTempData, maskImagePath)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetColorAdjust - instance or adjust data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetColorAdjust")
	end
end
TRID.Graphic.GlueResetColorAdjust = function (instance, modelSlot, materialGroup)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup then
			TRIDGLUE.SetColorAdjust(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, false)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetColorAdjust - instance or adjust data is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetColorAdjust")
	end
end
TRID.Graphic.GlueSetRenderFlag = function (instance, RENDER_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID and RENDER_TypeFlag then
			TRIDGLUE.SetRenderObjectFlag(instance._baseID[1], instance._baseID[2], true, RENDER_TypeFlag)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetRenderFlag - instance or RENDER_TypeFlag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetRenderFlag")
	end
end
TRID.Graphic.GlueResetRenderFlag = function (instance, RENDER_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID and RENDER_TypeFlag then
			TRIDGLUE.SetRenderObjectFlag(instance._baseID[1], instance._baseID[2], false, RENDER_TypeFlag)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetRenderFlag - instance or RENDER_TypeFlag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetRenderFlag")
	end
end
TRID.Graphic.GlueGetModelSlotList = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return {TRIDGLUE.GetModelSlotList(instance._baseID[1], instance._baseID[2])}
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetModelSlotList - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetModelSlotList")
	end
end
TRID.Graphic.GlueGetTotalMaterialGroupList = function (instance, modelSlot)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot then
			return {TRIDGLUE.GetTotalMaterialGroupList(instance._baseID[1], instance._baseID[2], modelSlot)}
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetTotalMaterialGroupList - instance or modelSlot is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetTotalMaterialGroupList")
	end
end
TRID.Graphic.GlueGetUsedMaterialBitList = function (instance, modelSlot, materialGroup)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup then
			local result = {TRIDGLUE.GetUsedMaterialBitList(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup)}
			if #result == 0 then
				return nil
			else
				return result
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetUsedMaterialBitList - instance or modelSlot or materialGroup is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetUsedMaterialBitList")
	end
end
TRID.Graphic.GlueGetMaterialData = function (instance, modelSlot, materialGroup, materialBit)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup and materialBit then
			local result = {TRIDGLUE.GetMaterialData(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, materialBit)}
			if #result == 0 then
				return nil
			else
				local color = TRID.ARGB(result[4]*255, result[1]*255, result[2]*255, result[3]*255)
				local dd = {color, result[5], result[6], result[7]}
--~ 				TRID.DebugPrint("GlueGetMaterialData - " .. TRID.TableToString(dd))
				return dd
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetMaterialData - instance or modelSlot or materialGroup or materialBit is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetMaterialData")
	end
end
TRID.Graphic.GlueSetCustomShaderVariable = function (instance, modelSlot, materialGroup, varName, varData)
	if TRIDGLUE then
		if instance and instance._baseID and modelSlot and materialGroup and varName and varData then
			local total = 1
			local dataArray = {}
			if type(varData) == "table" then
				total = #varData
				if total == 0 then
					TRID.DebugPrint("TRID.Graphic.GlueSetCustomShaderVariable - varData has no elements or is not array.", "error")
					return nil
				end
				dataArray = varData
			elseif type(varData) == "number" then
				total = 1
				dataArray = {varData}
			else
				TRID.DebugPrint("TRID.Graphic.GlueSetCustomShaderVariable - varData is invalid.", "error")
				return nil
			end
			return TRIDGLUE.SetCustomShaderVariable(instance._baseID[1], instance._baseID[2], modelSlot, materialGroup, varName, total, table.unpack(dataArray))
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetCustomShaderVariable - instance or modelSlot or materialGroup or varName or varData is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetCustomShaderVariable")
	end
	return nil
end
TRID.Graphic.GlueCheckOcclusion = function (instance, direction, isLocal)
	if TRIDGLUE then
		if instance and instance._baseID and direction then
			local ratio,pickedID1,pickedID2 = TRIDGLUE.CheckOcclusion(instance._baseID[1], instance._baseID[2], direction[1], direction[2], direction[3], isLocal)
			if ratio == nil then
				return nil
			else
				local occludedInstance = TRID.GetInstance(pickedID1,pickedID2)
				return ratio, occludedInstance
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueCheckOcclusion - instance or directionInWorld is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueCheckOcclusion")
	end
	return nil
end
TRID.Graphic.GlueGetModelDataInterface = function (instance)
	if instance and instance._baseID then
		local interface = {}
		interface = TRID._SetClassToInstance(interface, nil, TRID.ModelData)
		interface:Init(instance)
		return interface
	else
		TRID.DebugPrint("TRID.Graphic.GlueGetModelDataInterface - instance is nil.", "error")
	end
	return nil
end
TRID.Graphic.GlueSetController = function (instance, controlProp)
	if TRIDGLUE then
		if instance and instance._baseID and controlProp then
			TRIDGLUE.SetController(instance._baseID[1], instance._baseID[2], true, controlProp)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetController - instance or controlProp is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetController")
	end
end
TRID.Graphic.GlueResetController = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetController(instance._baseID[1], instance._baseID[2], false)
		else
			TRID.DebugPrint("TRID.Graphic.GlueResetController - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueResetController")
	end
end
TRID.Graphic.GlueSetSilhouette = function (instance, enableOrMaterialProp, color, thick)
	if TRIDGLUE then
		if instance and instance._baseID then
			local enable = (enableOrMaterialProp ~= nil and enableOrMaterialProp ~= false)
			TRID.DebugPrint("TRID.Graphic.GlueSetSiluouette -" .. tostring(enable))
			local materialProp = enableOrMaterialProp
			if enableOrMaterialProp and type(enableOrMaterialProp) == "boolean" then
				enable = enableOrMaterialProp
				
				if enable then
					local materialMaker = TRID.GetMaterialMakerInterface()
					materialMaker:Init("silhouetteMat")
					materialMaker:AddAmbient(color or TRID.WHITECOLOR)
					materialMaker:AddVariable(TRID.MATERIAL_PARAM_FLOAT, "thickness", {thick and (thick * 0.1) or 1.0})
					materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_INPUT_POSITION, "FLOAT3 Pos = IN_POSITION + IN_NORMAL * thickness; return Pos;")
					materialMaker:SetCustomShaderCode(TRID.CUSTOM_SHADER_CODE_COLOR_ADJUST, "return AMBIENT_COLOR;")
					materialProp = materialMaker:Build()
				else
					materialProp = nil
				end
			end
			TRIDGLUE.SetSilhouette(instance._baseID[1], instance._baseID[2], enable,  materialProp)
--~ 			TRIDGLUE.SetSilhouette(instance._baseID[1], instance._baseID[2], enable,  color and TRID.COLOR_A(color) or nil, color and TRID.COLOR_R(color) or nil, color and TRID.COLOR_G(color) or nil, color and TRID.COLOR_B(color) or nil, thick)
		else
			TRID.DebugPrint("TRID.Graphic.GlueSetSiluouette - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueSetSiluouette")
	end
end

TRID.FinishClassDefinition("TRID.Graphic")


--====================================
-- GUI class.
--====================================
TRID.GUI = TRID.StartClassDefinition("TRID.GUI", "TRID.Graphic")
TRID.GUI.GlueSetText = function (instance, text, color)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetGUIText(instance._baseID[1], instance._baseID[2], text, color and TRID.COLOR_R(color) or nil, color and TRID.COLOR_G(color) or nil, color and TRID.COLOR_B(color) or nil)
		else
			TRID.DebugPrint("TRID.GUI.GlueSetText - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GUI.GlueSetText")
	end
end
TRID.GUI.GlueSetImage = function (instance, image, opaImage, clipToSize)
	if TRIDGLUE then
		if instance and instance._baseID and image then
			TRIDGLUE.SetGUIImage(instance._baseID[1], instance._baseID[2], image, opaImage, clipToSize)
		else
			TRID.DebugPrint("TRID.GUI.GlueSetImage - instance or image is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GUI.GlueSetImage")
	end
end
TRID.GUI.GlueGetText = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.GetGUIText(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.GUI.GlueGetText - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GUI.GlueGetText")
	end
	return nil
end
TRID.GUI.GlueSetModal = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.DoModal(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.GUI.GlueSetModal - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.GUI.GlueSetModal")
	end
end

TRID.FinishClassDefinition("TRID.GUI")

--====================================
-- ListBox class.
--====================================
TRID.ListBox = TRID.StartClassDefinition("TRID.ListBox", "TRID.GUI")
TRID.ListBox.GlueAppendItem = function (instance, itemInstance, deleteAtRemoveItem)
	if TRIDGLUE then
		if instance and instance._baseID and itemInstance and itemInstance._baseID then
			TRIDGLUE.AppendListItem(instance._baseID[1], instance._baseID[2], itemInstance._baseID[1], itemInstance._baseID[2], deleteAtRemoveItem)
		else
			TRID.DebugPrint("TRID.ListBox.GlueAppendItem - instance or itemInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueAppendItem")
	end
end
TRID.ListBox.GlueInsertItem = function (instance, itemInstance, zeroBasedIndex, deleteAtRemoveItem)
	if TRIDGLUE then
		if instance and instance._baseID and itemInstance and itemInstance._baseID then
			TRIDGLUE.InsertListItem(instance._baseID[1], instance._baseID[2], itemInstance._baseID[1], itemInstance._baseID[2], zeroBasedIndex, deleteAtRemoveItem)
		else
			TRID.DebugPrint("TRID.ListBox.GlueInsertItem - instance or itemInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueInsertItem")
	end
end
TRID.ListBox.GlueRemoveItem = function (instance, itemInstance, setEmptyIconAfterRemoval)
	if TRIDGLUE then
		if instance and instance._baseID and itemInstance and itemInstance._baseID then
			TRIDGLUE.RemoveListItem(instance._baseID[1], instance._baseID[2], itemInstance._baseID[1], itemInstance._baseID[2], setEmptyIconAfterRemoval)
		else
			TRID.DebugPrint("TRID.ListBox.GlueRemoveItem - instance or itemInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueRemoveItem")
	end
end
TRID.ListBox.GlueRemoveAll = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.RemoveAllListItems(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.ListBox.GlueRemoveAll - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueRemoveAll")
	end
end
TRID.ListBox.GlueSelectItem = function (instance, zeroBasedIndex, selectOrDeselect, showThisItem)
	if TRIDGLUE then
		if instance and instance._baseID and zeroBasedIndex then
			TRIDGLUE.SelectListItem(instance._baseID[1], instance._baseID[2], zeroBasedIndex, selectOrDeselect, showThisItem)
		else
			TRID.DebugPrint("TRID.ListBox.GlueSelectItem - instance or zeroBasedIndex is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueSelectItem")
	end
end
TRID.ListBox.GlueGetItem = function (instance, zeroBasedIndex)
	if TRIDGLUE then
		if instance and instance._baseID and zeroBasedIndex then
			local baseID = {TRIDGLUE.GetListItemID(instance._baseID[1], instance._baseID[2], zeroBasedIndex)}
			return TRID.GetInstance(baseID[1], baseID[2])
		else
			TRID.DebugPrint("TRID.ListBox.GlueGetItem - instance or zeroBasedIndex is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueGetItem")
	end
	return nil
end
TRID.ListBox.GlueGetItemIndex = function (instance, itemInstance)
	if TRIDGLUE then
		if instance and instance._baseID and itemInstance and itemInstance._baseID then
			return TRIDGLUE.GetListItemIndex(instance._baseID[1], instance._baseID[2], itemInstance._baseID[1], itemInstance._baseID[2])
		else
			TRID.DebugPrint("TRID.ListBox.GlueGetItemIndex - instance or itemInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueGetItemIndex")
	end
	return nil
end
TRID.ListBox.GlueEnableItem = function (instance, zeroBasedIndex, enableOrDisable)
	if TRIDGLUE then
		if instance and instance._baseID and zeroBasedIndex then
			TRIDGLUE.EnableListItem(instance._baseID[1], instance._baseID[2], zeroBasedIndex, enableOrDisable)
		else
			TRID.DebugPrint("TRID.ListBox.GlueEnableItem - instance or zeroBasedIndex is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueEnableItem")
	end
end
TRID.ListBox.GlueGetTotalItem = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.GetTotalListItem(instance._baseID[1], instance._baseID[2]) or 0
		else
			TRID.DebugPrint("TRID.ListBox.GlueGetTotalItem - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ListBox.GlueGetTotalItem")
	end
	return 0
end

TRID.FinishClassDefinition("TRID.ListBox")


--====================================
-- view class.
--====================================
TRID.View = TRID.StartClassDefinition("TRID.View", "TRID.GUI")
TRID.View.GlueSetCamera = function (instance, cameraInstance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.AttachCamera(instance._baseID[1], instance._baseID[2], cameraInstance and cameraInstance._baseID[1], cameraInstance and cameraInstance._baseID[2])
		else
			TRID.DebugPrint("TRID.View.GlueSetCamera - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.View.GlueSetCamera")
	end
end
TRID.View.GluePickup = function (instance, wndX, wndY, convertToInstance, getResourceName, getCollisionData)
	if TRIDGLUE then
		if instance and instance._baseID then
			local result = {TRIDGLUE.GetPickupDataFromView(instance._baseID[1], instance._baseID[2], wndX, wndY, getResourceName, getCollisionData)}
			if convertToInstance then
				local pickedInstance = TRID.GetInstance(result[6], result[7])
				local newResult = {}
				newResult[1] = result[1]
				newResult[2] = result[2]
				newResult[3] = {result[3], result[4], result[5]}
				newResult[4] = pickedInstance
				for i=8, #result do
					table.insert(newResult, result[i])
				end
				return table.unpack(newResult)
			else
				return table.unpack(result)
			end
		else
			TRID.DebugPrint("TRID.View.GluePickup - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.View.GluePickup")
	end
end
TRID.View.GluePickupData = function (instance, wndX, wndY, getResourceName, getCollisionData)
	return TRID.View.GluePickup(instance, wndX, wndY, true, getResourceName, getCollisionData)
end

TRID.FinishClassDefinition("TRID.View")

--====================================
-- scrollbar class.
--====================================
TRID.ScrollBar = TRID.StartClassDefinition("TRID.ScrollBar", "TRID.GUI")
TRID.ScrollBar.GlueGetScrollBarPos = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.GetScrollbarPos(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.ScrollBar.GlueGetScrollBarPos - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ScrollBar.GlueGetScrollBarPos")
	end
	return nil
end
TRID.ScrollBar.GlueGetScrollbarButton = function (instance, SCROLLBAR_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and SCROLLBAR_TypeID then
			local buttonID = {TRIDGLUE.GetScrollbarButton(instance._baseID[1], instance._baseID[2], SCROLLBAR_TypeID)}
			return TRID.GetInstance(buttonID[1], buttonID[2])
		else
			TRID.DebugPrint("TRID.ScrollBar.GlueGetScrollBarPos - instance or SCROLLBAR_TypeID is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.ScrollBar.GlueGetScrollBarPos")
	end
	return nil
end

TRID.FinishClassDefinition("TRID.ScrollBar")


--====================================
-- button class.
--====================================
TRID.Button = TRID.StartClassDefinition("TRID.Button", "TRID.GUI")
TRID.Button.GlueSetTooltip = function (instance, propData)
	if TRIDGLUE then
		if instance and instance._baseID and propData then
			TRIDGLUE.SetTooltip(instance._baseID[1], instance._baseID[2], true, propData)
		else
			TRID.DebugPrint("TRID.Button.GlueSetTooltip - instance or propData is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Button.GlueSetTooltip")
	end
end
TRID.Button.GlueResetTooltip = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetTooltip(instance._baseID[1], instance._baseID[2], false)
		else
			TRID.DebugPrint("TRID.Button.GlueResetTooltip - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Button.GlueResetTooltip")
	end
end
TRID.Button.GlueEnable = function (instance, enable)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.EnableButton(instance._baseID[1], instance._baseID[2], enable)
		else
			TRID.DebugPrint("TRID.Button.GlueEnable - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Button.GlueEnable")
	end
end
TRID.Button.GlueSetStateProperty = function (instance, state, propData)
	if TRIDGLUE then
		if instance and instance._baseID and state and propData then
			TRIDGLUE.SetStateProperty(instance._baseID[1], instance._baseID[2], state, propData)
		else
			TRID.DebugPrint("TRID.Button.GlueSetStateProperty - instance, state, propData is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Button.GlueSetStateProperty")
	end
end
TRID.FinishClassDefinition("TRID.Button")

--====================================
-- camera class.
--====================================
TRID.Camera = TRID.StartClassDefinition("TRID.Camera", "TRID.Graphic")
TRID.Camera.GlueSetCameraVector = function (instance, eyeVec3, tarVec3, upVec3)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetCameraVector(instance._baseID[1], instance._baseID[2], 
				eyeVec3 and eyeVec3[1] or 0, eyeVec3 and eyeVec3[2] or 0, eyeVec3 and eyeVec3[3] or 0, 
				tarVec3 and tarVec3[1] or 0, tarVec3 and tarVec3[2] or 0, tarVec3 and tarVec3[3] or 0, 
				upVec3 and upVec3[1] or 0, upVec3 and upVec3[2] or 0, upVec3 and upVec3[3] or 1)
		else
			TRID.DebugPrint("TRID.Camera.GlueSetCameraVector - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueSetCameraVector")
	end
end
TRID.Camera.GluePickupOnPlane = function (instance, normalVec3, d, x,y)
	if TRIDGLUE then
		if instance and instance._baseID and normalVec3 then
			return {TRIDGLUE.PickupPositionOnPlane(instance._baseID[1], instance._baseID[2], normalVec3[1], normalVec3[2], normalVec3[3], d, x,y)}
		else
			TRID.DebugPrint("TRID.Camera.GlueSetCameraVector - instance or normalVec3 is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueSetCameraVector")
		return nil
	end
end
TRID.Camera.GlueGetCameraVector = function (instance, CAM_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and CAM_TypeID then
			return {TRIDGLUE.GetCameraVector(instance._baseID[1], instance._baseID[2], CAM_TypeID)}
		else
			TRID.DebugPrint("TRID.Camera.GlueGetCameraVector - instance or CAM_Type is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueGetCameraVector")
		return nil
	end
end
TRID.Camera.GlueSetCameraFlag = function (instance, CAMFLAG_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID and CAMFLAG_TypeFlag then
			TRIDGLUE.SetCameraFlag(instance._baseID[1], instance._baseID[2], true, CAMFLAG_TypeFlag)
		else
			TRID.DebugPrint("TRID.Camera.GlueSetCameraFlag - instance or CAMFLAG_TypeFlag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueSetCameraFlag")
	end
end
TRID.Camera.GlueResetCameraFlag = function (instance, CAMFLAG_TypeFlag)
	if TRIDGLUE then
		if instance and instance._baseID and CAMFLAG_TypeFlag then
			TRIDGLUE.SetCameraFlag(instance._baseID[1], instance._baseID[2], false, CAMFLAG_TypeFlag)
		else
			TRID.DebugPrint("TRID.Camera.GlueResetCameraFlag - instance or CAMFLAG_TypeFlag is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueResetCameraFlag")
	end
end
TRID.Camera.GlueSetFollowShot = function (instance, targetInstance, offsetVec3)
	if TRIDGLUE then
		if instance and instance._baseID and targetInstance then
			TRIDGLUE.SetFollowCamera(instance._baseID[1], instance._baseID[2], targetInstance._baseID[1], targetInstance._baseID[2], 
				offsetVec3 and offsetVec3[1] or 0, offsetVec3 and offsetVec3[2] or 0, offsetVec3 and offsetVec3[3] or 0)
		else
			TRID.DebugPrint("TRID.Camera.GlueSetFollowShot - instance or targetInstance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueSetFollowShot")
	end
end
TRID.Camera.GlueResetFollowShot = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetFollowCamera(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Camera.GlueResetFollowShot - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueResetFollowShot")
	end
end
TRID.Camera.GlueGetProjectionInfo = function (instance, PROJ_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and PROJ_TypeID then
			return TRIDGLUE.GetProjectionInfo(instance._baseID[1], instance._baseID[2], PROJ_TypeID)
		else
			TRID.DebugPrint("TRID.Camera.GlueGetProjectionInfo - instance or PROJ_TypeID is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueGetProjectionInfo")
		return nil
	end
end
TRID.Camera.GlueGetProjectionData = function (instance, PROJ_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and PROJ_TypeID then
			local value = TRIDGLUE.GetProjectionInfo(instance._baseID[1], instance._baseID[2], PROJ_TypeID)
			if PROJ_TypeID == TRID.PROJ_FOV then
				return value * TRID.RAD2ANG
			else
				return value
			end
		else
			TRID.DebugPrint("TRID.Camera.GlueGetProjectionData - instance or PROJ_TypeID is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GlueGetProjectionData")
		return nil
	end
end
TRID.Camera.GlueSaveScreen = function (instance, savePath, xOrWidth, yOrHeight, widthOrBlurSize, height, blurSize)
	return TRID._SaveScreen(instance, savePath, xOrWidth, yOrHeight, widthOrBlurSize, height, blurSize)
end
TRID.Camera.GlueGetFullMatrix = function (instance, objectInstance)
	if TRIDGLUE then
		if instance and instance._baseID and objectInstance and objectInstance._baseID then
			local mat = {TRIDGLUE.GetFullMatrix(instance._baseID[1], instance._baseID[2], objectInstance._baseID[1], objectInstance._baseID[2])}
			if mat[1] then
				return mat
			end
		else
			TRID.DebugPrint("TRID.Camera.GlueGetFullMatrix - instance or objectInstance is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.objectInstance")
		return nil
	end
end
TRID.Camera.GluePickupDataWithLine = function (instance, startVec3, endVec3, getResourceName, getCollisionData)
	if TRIDGLUE then
		if instance and instance._baseID and startVec3 and endVec3 then
			local result = {TRIDGLUE.GetPickupDataWith3DLine(instance._baseID[1], instance._baseID[2], startVec3[1], startVec3[2], startVec3[3], endVec3[1], endVec3[2], endVec3[3], getResourceName, getCollisionData)}
			local pickedInstance = TRID.GetInstance(result[4], result[5])
			local newResult = {}
			newResult[1] = {result[1], result[2], result[3]}
			newResult[2] = pickedInstance
			for i=6, #result do
				table.insert(newResult, result[i])
			end
			return table.unpack(newResult)
		else
			TRID.DebugPrint("TRID.Camera.GluePickupDataWithLine - (instance or startVec3 or endVec3) is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Camera.GluePickupDataWithLine")
	end
end

TRID.Camera.GlueDumpOctree = function (instance)
	TRIDGLUE.DumpOctree(instance._baseID[1], instance._baseID[2])
end

TRID.Camera.GlueFindOctree = function (instance, radius)
	TRIDGLUE.FindOctree(instance._baseID[1], instance._baseID[2],  radius )
end

TRID.Camera.GlueSnapShotOctree = function (instance)
	TRIDGLUE.SnapShotOctree(instance._baseID[1], instance._baseID[2])
end

TRID.FinishClassDefinition("TRID.Camera")


--====================================
-- light class.
--====================================
TRID.Light = TRID.StartClassDefinition("TRID.Light", "TRID.Graphic")
TRID.Light.GlueSetLightVector = function (instance, eyeVec3, tarVec3, upVec3)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetLightVector(instance._baseID[1], instance._baseID[2], 
				eyeVec3 and eyeVec3[1] or 0, eyeVec3 and eyeVec3[2] or 0, eyeVec3 and eyeVec3[3] or 0, 
				tarVec3 and tarVec3[1] or 0, tarVec3 and tarVec3[2] or 0, tarVec3 and tarVec3[3] or 0, 
				upVec3 and upVec3[1] or 0, upVec3 and upVec3[2] or 0, upVec3 and upVec3[3] or 1)
		else
			TRID.DebugPrint("TRID.Light.GlueSetLightVector - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueSetLightVector")
	end
end
TRID.Light.GlueGetLightVector = function (instance, LIGHT_TypeID)
	if TRIDGLUE then
		if instance and instance._baseID and LIGHT_TypeID then
			return {TRIDGLUE.GetLightVector(instance._baseID[1], instance._baseID[2], LIGHT_TypeID)}
		else
			TRID.DebugPrint("TRID.Light.GlueGetLightVector - instance or LIGHT_TypeID is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueGetLightVector")
		return nil
	end
end
TRID.Light.GlueGetLightColor = function (instance, LIGHT_ColorTypeID)
	if TRIDGLUE then
		if instance and instance._baseID and LIGHT_ColorTypeID then
			local rgb = {TRIDGLUE.GetLightColor(instance._baseID[1], instance._baseID[2], LIGHT_ColorTypeID)}
			return TRID.XRGB(rgb[1],rgb[2],rgb[3])
		else
			TRID.DebugPrint("TRID.Light.GlueGetLightColor - instance or LIGHT_ColorTypeID is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueGetLightColor")
		return nil
	end
end
TRID.Light.GlueGetLightProperties = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			return {TRIDGLUE.GetLightProperties(instance._baseID[1], instance._baseID[2])}
		else
			TRID.DebugPrint("TRID.Light.GlueGetLightProperties - instance is nil.", "error")
			return nil
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueGetLightProperties")
		return nil
	end
end
TRID.Light.GlueSetDirectionalLight = function (instance, tarVec3, ambiColor, diffColor, isMainLight, lightIntensity, forLightmap)
	if TRIDGLUE then
		if instance and instance._baseID then
			local data = {}
			TRID.MakeDirectionalLight(data, tarVec3 and tarVec3[1] or 0, tarVec3 and tarVec3[2] or 0, tarVec3 and tarVec3[3] or 0, ambiColor, diffColor, isMainLight, lightIntensity, forLightmap)
			TRIDGLUE.SetProperty(instance._baseID[1], instance._baseID[2], TRID.FOID_3D_LIGHT, data)
		else
			TRID.DebugPrint("TRID.Light.GlueSetDirectionalLight - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueSetDirectionalLight")
	end
end
TRID.Light.GlueSetPointLight = function (instance, tarVec3, ambiColor, diffColor, attenStartRange, attenEndRange, attenStartAngleFromDir, attenEndAngleFromDir,lightIntensity, forLightmap)
	if TRIDGLUE then
		if instance and instance._baseID then
			local data = {}
			TRID.MakeOnePropOfLightPoint(data, tarVec3 and tarVec3[1] or 0, tarVec3 and tarVec3[2] or 0, tarVec3 and tarVec3[3] or 0, ambiColor, diffColor, attenStartRange, attenEndRange, attenStartAngleFromDir, attenEndAngleFromDir,lightIntensity, forLightmap)
			TRIDGLUE.SetProperty(instance._baseID[1], instance._baseID[2], TRID.FOID_3D_LIGHT, data)
		else
			TRID.DebugPrint("TRID.Light.GlueSetPointLight - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Light.GlueSetPointLight")
	end
end


TRID.FinishClassDefinition("TRID.Light")


--====================================
-- terrain class.
--====================================
TRID.Terrain = TRID.StartClassDefinition("TRID.Terrain", "TRID.Graphic")
TRID.Terrain.GlueModifyHeight = function (instance, centerInWorld, radius, intensity, attenuation, MODIFY_HEIGHT_Mode, constraintHeightRatio)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.ModifyHeight(instance._baseID[1], instance._baseID[2], centerInWorld[1], centerInWorld[2], centerInWorld[3], radius, intensity, attenuation, MODIFY_HEIGHT_Mode, constraintHeightRatio or 1)
		else
			TRID.DebugPrint("TRID.Terrain.GlueModifyHeight - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueModifyHeight")
	end
end
TRID.Terrain.GlueBrushMaterial = function (instance, centerInWorld, radius, intensity, attenuation, BRUSH_Mode, materialIndex)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.BrushMaterial(instance._baseID[1], instance._baseID[2], centerInWorld[1], centerInWorld[2], centerInWorld[3], radius, intensity, attenuation, BRUSH_Mode, materialIndex)
		else
			TRID.DebugPrint("TRID.Terrain.GlueBrushMaterial - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueBrushMaterial")
	end
	return nil
end
TRID.Terrain.GlueSave = function (instance, saveAsHeightmapPath, saveAsPatchInfoPath, saveAsBlendmapPath, saveAsLightmapPath)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.SaveTerrain(instance._baseID[1], instance._baseID[2], saveAsHeightmapPath, saveAsPatchInfoPath, saveAsBlendmapPath, saveAsLightmapPath)
		else
			TRID.DebugPrint("TRID.Terrain.GlueSave - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueSave")
	end
	return nil
end
TRID.Terrain.GlueSaveTemporarily = function (instance, name, all)
	if TRIDGLUE then
		if instance and instance._baseID and name and type(name) == "string" and name ~= "" then
			return TRIDGLUE.SaveTerrainTemporarily(instance._baseID[1], instance._baseID[2], name, all)
		else
			TRID.DebugPrint("TRID.Terrain.GlueSaveTemporarily - instance is nil. Or name is invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueSaveTemporarily")
	end
	return nil
end
TRID.Terrain.GlueLoadTemporarily = function (instance, name)
	if TRIDGLUE then
		if instance and instance._baseID and name and type(name) == "string" and name ~= "" then
			return TRIDGLUE.LoadTerrainTemporarily(instance._baseID[1], instance._baseID[2], name)
		else
			TRID.DebugPrint("TRID.Terrain.GlueLoadTemporarily - instance is nil. Or name is invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueLoadTemporarily")
	end
	return nil
end
TRID.Terrain.GlueDeleteTemporarily = function (instance, name)
	if TRIDGLUE then
		if instance and instance._baseID then
			return TRIDGLUE.DeleteTerrainTemporarily(instance._baseID[1], instance._baseID[2], name)
		else
			TRID.DebugPrint("TRID.Terrain.GlueDeleteTemporarily - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueDeleteTemporarily")
	end
	return nil
end
TRID.Terrain.GlueSetCursorMaterial = function (instance, cursorName, materialProp)
	if TRIDGLUE then
		if instance and instance._baseID and cursorName and materialProp then
			TRIDGLUE.SetTerrainCursorMaterial(instance._baseID[1], instance._baseID[2], cursorName, materialProp)
		else
			TRID.DebugPrint("TRID.Terrain.GlueSetCursorMaterial - instance is nil. or arguments are invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueSetCursorMaterial")
	end
end
TRID.Terrain.GlueShowCursor = function (instance, cursorName, centerInWorldVec3, radiusInWorld)
	if TRIDGLUE then
		if instance and instance._baseID and cursorName and centerInWorldVec3 and radiusInWorld then
			TRIDGLUE.ShowTerrainCursor(instance._baseID[1], instance._baseID[2], cursorName, true, centerInWorldVec3[1], centerInWorldVec3[2], centerInWorldVec3[3], radiusInWorld)
		else
			TRID.DebugPrint("TRID.Terrain.GlueShowCursor - instance is nil. or arguments are invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueShowCursor")
	end
end
TRID.Terrain.GlueHideCursor = function (instance, cursorName)
	if TRIDGLUE then
		if instance and instance._baseID and cursorName then
			TRIDGLUE.ShowTerrainCursor(instance._baseID[1], instance._baseID[2], cursorName, false)
		else
			TRID.DebugPrint("TRID.Terrain.GlueHideCursor - instance is nil. or arguments are invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueHideCursor")
	end
end
TRID.Terrain.GlueGetHeight = function (instance, worldX, worldY)
	if TRIDGLUE then
		if instance and instance._baseID and worldX and worldY then
			return TRIDGLUE.GetTerrainHeight(instance._baseID[1], instance._baseID[2], worldX, worldY)
		else
			TRID.DebugPrint("TRID.Terrain.GlueGetHeight - instance is nil. or arguments are invalid.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Terrain.GlueGetHeight")
	end
end

TRID.FinishClassDefinition("TRID.Terrain")


--====================================
-- logic class.
--====================================
TRID.Logic = TRID.StartClassDefinition("TRID.Logic", "TRID.Base")
TRID.Logic.GlueIsLogicObject = function (instance)
	return true
end
TRID.Logic.GlueSetGraphic = function (instance, graphicInstance, useOldOne)
	if TRIDGLUE then
		if instance and instance._baseID and graphicInstance and graphicInstance._baseID then
			if graphicInstance.GlueIsGraphicObject and graphicInstance:GlueIsGraphicObject() then
				TRIDGLUE.SetGraphicObject(instance._baseID[1], instance._baseID[2], graphicInstance._baseID[1], graphicInstance._baseID[2], useOldOne)
				instance._graphic = graphicInstance
			else
				TRID.DebugPrint("TRID.Logic.GlueSetGraphic - graphicInstance is not a graphic object.", "error")
			end
		else
			TRID.DebugPrint("TRID.Logic.GlueSetGraphic - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Logic.GlueSetGraphic")
	end
end
TRID.Logic.GlueAddChild = function (instance, childInstance)
	if TRIDGLUE then
		if instance and instance._baseID and childInstance and childInstance._baseID then
			if childInstance.GlueIsLogicObject and childInstance:GlueIsLogicObject() then
				if not childInstance._graphic then
					TRID.DebugPrint("TRID.Logic.GlueAddChild - no child graphic : ") --  .. debug.traceback())
				end
				TRIDGLUE.AddLogicChild(instance._baseID[1], instance._baseID[2], childInstance._baseID[1], childInstance._baseID[2])
			elseif childInstance.GlueIsGraphicObject and childInstance:GlueIsGraphicObject() then
				TRIDGLUE.AddGraphicChild(instance._baseID[1], instance._baseID[2], childInstance._baseID[1], childInstance._baseID[2])
			else
				TRID.DebugPrint("TRID.Logic.GlueAddChild - childInstance is not logic or graphic.", "error")
			end
		else
			TRID.DebugPrint("TRID.Logic.GlueAddChild - instance is nil." .. debug.traceback(), "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Logic.GlueAddChild")
	end
end
TRID.Logic.GlueGetParent = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			local parentID1, parentID2 = TRIDGLUE.GetLogicParent(instance._baseID[1], instance._baseID[2])
			if parentID1 then
				return TRID.GetInstance(parentID1, parentID2, true)
			else
				return nil
			end
		else
			TRID.DebugPrint("TRID.Graphic.GlueGetParent - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Graphic.GlueGetParent")
	end
end
TRID.Logic.GlueAddToMainWindow = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.AddToMainWindow(instance._baseID[1], instance._baseID[2])
		else
			TRID.DebugPrint("TRID.Logic.GlueAddToMainWindow - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Logic.GlueAddToMainWindow")
	end
end

TRID.FinishClassDefinition("TRID.Logic")


--====================================
-- space class.
--====================================
TRID.Space = TRID.StartClassDefinition("TRID.Space", "TRID.Logic")
TRID.Space.GlueSetBlockSize = function (instance, sizeX,sizeY,sizeZ, depth)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetClientBlockSize(instance._baseID[1], instance._baseID[2], sizeX,sizeY,sizeZ, depth)
		else
			TRID.DebugPrint("TRID.Space.GlueSetBlockSize - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Space.GlueSetBlockSize")
	end
end

TRID.Space.GlueSetOctreeSize = function (instance, sizeX,sizeY,sizeZ, depth)
	if TRIDGLUE then
		if instance and instance._baseID then
			TRIDGLUE.SetClientOctreeSize(instance._baseID[1], instance._baseID[2], sizeX,sizeY,sizeZ, depth)
		else
			TRID.DebugPrint("TRID.Space.GlueSetOctreeSize - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Space.GlueSetOctreeSize")
	end
end

TRID.FinishClassDefinition("TRID.Space")


--====================================
-- Network class.
--====================================
TRID.Network = TRID.StartClassDefinition("TRID.Network", "TRID.Base")
TRID.Network.GlueRequest = function (instance, packetData)
	if TRIDGLUE then
		if instance and instance._baseID and packetData then
			TRIDGLUE.SendRequest(instance._baseID[1], instance._baseID[2], packetData)
		else
			TRID.DebugPrint("TRID.Network.GlueSendRequest - instance or packetData is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Network.GlueSendRequest")
	end
end
TRID.Network.GlueURLRequest = function (instance, url, packetData, stringMessageIDForResultFromURL, postVarName)
	if TRIDGLUE then
		if instance and instance._baseID and url then
			TRIDGLUE.SendRequest(instance._baseID[1], instance._baseID[2], packetData, url, stringMessageIDForResultFromURL, nil, nil, postVarName or "data")
		else
			TRID.DebugPrint("TRID.Network.GlueURLRequest - instance or url is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Network.GlueURLRequest")
	end
end
TRID.Network.GlueUploadFile = function (instance, url, uploadFilePath, packetData, stringMessageIDForResultFromURL, postVarName)
	if TRIDGLUE then
		if instance and instance._baseID and uploadFilePath and url and packetData then
			TRIDGLUE.SendRequest(instance._baseID[1], instance._baseID[2], packetData, url, stringMessageIDForResultFromURL, 0, uploadFilePath, postVarName or "data")
		else
			TRID.DebugPrint("TRID.Network.GlueUploadFile - instance or uploadFilePath or url or packetData is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Network.GlueUploadFile")
	end
end 
TRID.Network.GlueSetCryptorKey = function (instance, numberKey)
	if TRIDGLUE then
		if instance and instance._baseID and numberKey then
			TRIDGLUE.SetCryptorKey(instance._baseID[1], instance._baseID[2], numberKey)
		else
			TRID.DebugPrint("TRID.Network.GlueSetCryptorKey - instance or numberKey is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Network.GlueSetCryptorKey")
	end
end
TRID.Network.GlueGetStringID = function (instance, delimiter)
	if TRIDGLUE then
		if instance and instance._baseID then
			local char = delimiter and tostring(delimiter) or TRID.DEFAULT_DELIMITER
			if TRIDGLUE.GetConnectionStringID then
				return TRIDGLUE.GetConnectionStringID(instance._baseID[1], instance._baseID[2], char)
			else
				return TRID.Base.GlueGetStringID(instance, delimiter)
			end
			TRIDGLUE.SetCryptorKey(instance._baseID[1], instance._baseID[2], numberKey)
		else
			TRID.DebugPrint("TRID.Network.GlueGetStringID - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.Network.GlueGetStringID")
	end
end



TRID.FinishClassDefinition("TRID.Network")

--====================================
-- DBConn class.
--====================================
TRID.DBConn = TRID.StartClassDefinition("TRID.DBConn", "TRID.Base")
TRID.DBConn.GlueCreateQuery = function (instance, query)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.CreateQuery(instance._baseID[1], instance._baseID[2], query)
		else
			TRID.DebugPrint("TRID.DBConn.GlueCreateQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueCreateQuery")
	end
	return nil
end
TRID.DBConn.GlueDropQuery = function (instance, query)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.CreateQuery(instance._baseID[1], instance._baseID[2], query)
		else
			TRID.DebugPrint("TRID.DBConn.GlueDropQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueDropQuery")
	end
	return nil
end
TRID.DBConn.GlueSelectQuery = function (instance, query, ...)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.SelectQuery(instance._baseID[1], instance._baseID[2], query, ...)
		else
			TRID.DebugPrint("TRID.DBConn.GlueSelectQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueSelectQuery")
	end
	return nil
end
TRID.DBConn.GlueInsertQuery = function (instance, query, ...)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.DMLQuery(instance._baseID[1], instance._baseID[2], query, ...)
		else
			TRID.DebugPrint("TRID.DBConn.GlueInsertQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueInsertQuery")
	end
	return nil
end
TRID.DBConn.GlueUpdateQuery = function (instance, query, ...)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.DMLQuery(instance._baseID[1], instance._baseID[2], query, ...)
		else
			TRID.DebugPrint("TRID.DBConn.GlueUpdateQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueUpdateQuery")
	end
	return nil
end
TRID.DBConn.GlueDeleteQuery = function (instance, query, ...)
	if TRIDGLUE then
		if instance and instance._baseID and query then
			return TRIDGLUE.DMLQuery(instance._baseID[1], instance._baseID[2], query, ...)
		else
			TRID.DebugPrint("TRID.DBConn.GlueDeleteQuery - instance or query is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueDeleteQuery")
	end
	return nil
end
TRID.DBConn.GlueBeginTransaction = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			if not instance._beginTransaction then
				instance._beginTransaction = true
				return TRIDGLUE.BeginTransaction(instance._baseID[1], instance._baseID[2])
			else
				TRID.DebugPrint("TRID.DBConn.GlueBeginTransaction - transaction was already begun.", "error")
			end
		else
			TRID.DebugPrint("TRID.DBConn.GlueBeginTransaction - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueBeginTransaction")
	end
	return nil
end
TRID.DBConn.GlueCommit = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			if instance._beginTransaction then
				instance._beginTransaction = nil
				return TRIDGLUE.Commit(instance._baseID[1], instance._baseID[2])
			else
				TRID.DebugPrint("TRID.DBConn.GlueCommit - transaction is not begun.", "error")
			end
		else
			TRID.DebugPrint("TRID.DBConn.GlueCommit - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueCommit")
	end
	return nil
end
TRID.DBConn.GlueRollback = function (instance)
	if TRIDGLUE then
		if instance and instance._baseID then
			if instance._beginTransaction then
				instance._beginTransaction = nil
				return TRIDGLUE.Rollback(instance._baseID[1], instance._baseID[2])
			else
				TRID.DebugPrint("TRID.DBConn.GlueRollback - transaction is not begun.", "error")
			end
		else
			TRID.DebugPrint("TRID.DBConn.GlueRollback - instance is nil.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.DBConn.GlueRollback")
	end
	return nil
end

TRID.FinishClassDefinition("TRID.DBConn")


--====================================
-- material maker
--====================================
TRID.GetMaterialMakerInterface = function ()
	local materialInterface = {}
	return TRID._SetClassToInstance(materialInterface, nil, TRID.MaterialMaker)
end

TRID.MaterialMaker = TRID.StartClassDefinition("TRID.MaterialMaker")
TRID.MaterialMaker.Init = function (instance, materialName)
	if instance and materialName then
		instance.materialName = materialName
		instance.materials = {}
		instance.shaderVarList = {}
		instance.getCustomShaderCode = {}
	else
		TRID.DebugPrint("TRID.MaterialMaker.Init - instance or materialName is nil.", "error")
	end
end
TRID.MaterialMaker.Build = function (instance, materialsPropData, inModelFile)
	if instance and instance.materialName then
		local customShaderCodesCount = TRID.GetTableSize(instance.getCustomShaderCode)
		local hasCustomShader = (instance.specPowerConstant or #instance.shaderVarList > 0 or instance.customMode or customShaderCodesCount > 0)
		  
		local total = TRID.GetTableSize(instance.materials)
		if total == 0 and not hasCustomShader then
			TRID.DebugPrint("TRID.MaterialMaker.Build - material is nil or no custom shader.", "error")
			return nil
		end
		
		local data = materialsPropData
		if not materialsPropData then
			data = {}
		elseif inModelFile then
			materialsPropData = {}
		end
		local propData = data
		if not inModelFile then
			data[#data + 1] = instance.materialName
			data[instance.materialName] = {}
			propData = data[instance.materialName]
		end
		
		local CURRENT_CMATERIALDATA_FORMAT = "CMaterialData-v001"
		table.insert(propData, TRID.UNPACKTABLE(TRID.StartMaterial(CURRENT_CMATERIALDATA_FORMAT, instance.materialName, inModelFile)))
		table.insert(propData, TRID.GetTableSize(instance.materials))
		for k,v in pairs(instance.materials) do
			table.insert(propData, TRID.UNPACKTABLE(v))
		end
		
		-- add custom shader data
		local CURRENT_SSHADERINFO_FORMAT = "SShaderInfo-v001"
		if hasCustomShader then
			table.insert(propData, true)	-- has custom shader
			table.insert(propData, CURRENT_SSHADERINFO_FORMAT)
			table.insert(propData, instance.specPowerConstant or 2)
			table.insert(propData, #instance.shaderVarList)
			local i
			for i=1, #instance.shaderVarList do
				local varData = instance.shaderVarList[i]
				table.insert(propData, varData.MATERIAL_PARAM_Type)
				table.insert(propData, varData.varName)
				if varData.initValue then
					table.insert(propData, #varData.initValue)
					local k
					for k=1, #varData.initValue do
						table.insert(propData, varData.initValue[k])
					end
				else
					table.insert(propData, 0)
				end
				table.insert(propData, varData.totalArray or 0)
			end
			table.insert(propData, instance.customMode or 0)
			
			table.insert(propData, customShaderCodesCount)
			for k,v in pairs(instance.getCustomShaderCode) do
				table.insert(propData, k)
				table.insert(propData, v)
			end
		else
			table.insert(propData, false)	-- has no custom shader
		end
		
		return data
	else
		TRID.DebugPrint("TRID.MaterialMaker.Build - instance or instance.materialName is nil.", "error")
	end
	return nil
end
TRID.MaterialMaker.AddAmbient = function (instance, floatROrColorTable, floatG, floatB, floatA)
	if instance then
		if type(floatROrColorTable) == "table" then
			instance.materials[TRID.MATERIAL_AMBI_BIT] = TRID.MakeAmbiMaterial1(TRID.COLOR_R(floatROrColorTable)/255, TRID.COLOR_G(floatROrColorTable)/255, TRID.COLOR_B(floatROrColorTable)/255, TRID.COLOR_A(floatROrColorTable)/255)
		else
			instance.materials[TRID.MATERIAL_AMBI_BIT] = TRID.MakeAmbiMaterial1(floatROrColorTable, floatG, floatB, floatA)
		end
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddAmbient - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddDiffuse = function (instance, diffuseMap, TEXTURE_TypeFlag, floatROrColorTable, floatGOrUseThisMapPath, floatB, floatA, useThisMapPath)
	if instance then
		local r = floatROrColorTable
		local g = floatGOrUseThisMapPath
		local b = floatB
		local a = floatA
		local usePath = useThisMapPath
		if type(floatROrColorTable) == "table" then
			r = TRID.COLOR_R(floatROrColorTable)/255
			g = TRID.COLOR_G(floatROrColorTable)/255
			b = TRID.COLOR_B(floatROrColorTable)/255
			a = TRID.COLOR_A(floatROrColorTable)/255
			if floatGOrUseThisMapPath == nil or type(floatGOrUseThisMapPath) == "boolean" then
				usePath = floatGOrUseThisMapPath or true
			else
				TRID.DebugPrint("TRID.MaterialMaker.AddDiffuse - useThisMapPath is invalid.", "error")
				usePath = true
			end
		end
		if diffuseMap and diffuseMap ~= "" then
			instance.materials[TRID.MATERIAL_DIFF_BIT] = TRID.MakeDiffMaterial1(diffuseMap, TEXTURE_TypeFlag, r,g,b,a,usePath)
		else
			instance.materials[TRID.MATERIAL_DIFF_BIT] = TRID.MakeDiffMaterial2(r,g,b,a)
		end
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddDiffuse - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddOpacity = function (instance, opaMap, opaRatio, useThisMapPath)
	if instance then
		local ratio
		local usePath = opaRatio
		if opaRatio and type(opaRatio) == "number" then
			ratio = opaRatio
			usePath = useThisMapPath
		end
		instance.materials[TRID.MATERIAL_OPA_BIT] = TRID.MakeOpaMaterial1(opaMap, TRID.TEXTURE_2D + TRID.TEXTURE_HASLEVEL, usePath, ratio)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddOpacity - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddSpecularLevel = function (instance, specLevelMap, specLevelRatio, floatROrColorTable, floatGOrUseThisMapPath, floatBOrSpecPower, floatA, useThisMapPath, specPower)
	if instance then
		local r = floatROrColorTable
		local g = floatGOrUseThisMapPath
		local b = floatBOrSpecPower
		local a = floatA
		local usePath = useThisMapPath
		local spower = specPower
		if type(floatROrColorTable) == "table" then
			r = TRID.COLOR_R(floatROrColorTable)/255
			g = TRID.COLOR_G(floatROrColorTable)/255
			b = TRID.COLOR_B(floatROrColorTable)/255
			a = TRID.COLOR_A(floatROrColorTable)/255
			if floatGOrUseThisMapPath == nil or type(floatGOrUseThisMapPath) == "boolean" then
				usePath = floatGOrUseThisMapPath or true
			else
				TRID.DebugPrint("TRID.MaterialMaker.AddSpecularLevel - useThisMapPath is invalid.", "error")
				usePath = true
			end
			if floatBOrSpecPower == nil or type(floatBOrSpecPower) == "number" then
				spower = floatBOrSpecPower
			else
				TRID.DebugPrint("TRID.MaterialMaker.AddSpecularLevel - specPower is invalid.", "error")
				spower = nil
			end
		end
		instance.materials[TRID.MATERIAL_SPECLEVEL_BIT] = TRID.MakeSpecLevelMaterial1(specLevelMap, specLevelRatio, r,g,b,a,usePath)
		instance.specPowerConstant = spower
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddSpecularLevel - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddNormal = function (instance, normalMap, bumpy, useThisMapPath)
	if instance and normalMap then
		instance.materials[TRID.MATERIAL_BUMP_BIT] = TRID.MakeNormalMaterial1(normalMap, bumpy, useThisMapPath)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddNormal - instance or normalMap is nil.", "error")
	end
end
TRID.MaterialMaker.AddGlow = function (instance, glowMap, useThisMapPath)
	if instance and glowMap then
		instance.materials[TRID.MATERIAL_GLOW_BIT] = TRID.MakeGlowMaterial1(glowMap, useThisMapPath)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddGlow - instance or glowMap is nil.", "error")
	end
end
TRID.MaterialMaker.AddCube = function (instance, reflectionLevelMap, reflectionRatio, useThisMapPath)
	if instance then
		instance.materials[TRID.MATERIAL_CUBE_BIT] = TRID.MakeCubeMaterial1(reflectionLevelMap, reflectionRatio, useThisMapPath)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddCube - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddMirror = function (instance, reflectionLevelMap, reflectionRatio, useThisMapPath, envType, shaderIndexOrMask)
	if instance then
		local envData = shaderIndexOrMask
		if envType == TRID.ENVTYPE_STENCIL then
			envData = shaderIndexOrMask or TRID.MATERIAL_ALL_MASK
		end
		instance.materials[TRID.MATERIAL_ENV_BIT] = TRID.MakeCubeMaterial1(reflectionLevelMap, reflectionRatio, useThisMapPath, envType or TRID.ENVTYPE_MIRROR, envData)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddMirror - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddLightmap = function (instance, lightmap, intensity)
	if instance then
		instance.materials[TRID.MATERIAL_LIGHT_BIT] = TRID.MakeLightMaterial(lightmap, intensity)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddLightmap - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddCustomMap = function (instance, customBit, customMap, TEXTURE_TypeFlag, useThisMapPath)
	if instance then
		local varTex
		if TRID.MATERIAL_CUSTOM1_BIT == customBit then
			varTex = TRID.TEX_CUSTOM1MAP
		elseif TRID.MATERIAL_CUSTOM2_BIT == customBit then
			varTex = TRID.TEX_CUSTOM2MAP
		elseif TRID.MATERIAL_CUSTOM3_BIT == customBit then
			varTex = TRID.TEX_CUSTOM3MAP
		elseif TRID.MATERIAL_CUSTOM4_BIT == customBit then
			varTex = TRID.TEX_CUSTOM4MAP
		elseif TRID.MATERIAL_CUSTOM5_BIT == customBit then
			varTex = TRID.TEX_CUSTOM5MAP
		elseif TRID.MATERIAL_CUSTOM6_BIT == customBit then
			varTex = TRID.TEX_CUSTOM6MAP
		elseif TRID.MATERIAL_CUSTOM7_BIT == customBit then
			varTex = TRID.TEX_CUSTOM7MAP
		elseif TRID.MATERIAL_CUSTOM8_BIT == customBit then
			varTex = TRID.TEX_CUSTOM8MAP
		else
			TRID.DebugPrint("TRID.MaterialMaker.AddCustomMap - invalid customBit.", "error")
			return
		end
		  
		instance.materials[customBit] = TRID.MakeCustomMaterial(customBit, varTex, customMap, TEXTURE_TypeFlag, useThisMapPath)
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddCustomMap - instance is nil.", "error")
	end
end
TRID.MaterialMaker.AddVariable = function (instance, MATERIAL_PARAM_Type, varName, initValue)
	if instance and MATERIAL_PARAM_Type and varName and initValue then
		if type(MATERIAL_PARAM_Type) ~= "number" then
			TRID.DebugPrint("TRID.MaterialMaker.AddVariable - MATERIAL_PARAM_Type must be number type.", "error")
			return
		end
		if type(varName) ~= "string" then
			TRID.DebugPrint("TRID.MaterialMaker.AddVariable - varName must be string type.", "error")
			return
		end
		
		local initData = initValue
		if type(initValue) == "number" then
			initData = {initValue}
		elseif type(initValue) ~= "table" then
			TRID.DebugPrint("TRID.MaterialMaker.AddVariable - initValue must be table or number type.", "error")
			return
		end
--~ 		if (not totalArray or (type(totalArray) == "number" and totalArray >= 0)) then
--~ 			TRID.DebugPrint("TRID.MaterialMaker.AddVariable - totalArray must be nil or non-negative number.")
--~ 			return
--~ 		end
		-- TO DO : check valid : duplcation of variable names
		table.insert(instance.shaderVarList, {MATERIAL_PARAM_Type=MATERIAL_PARAM_Type, varName=varName, initValue=initData, totalArray=0})
	else
		TRID.DebugPrint("TRID.MaterialMaker.AddVariable - instance is nil or (varType, varName or initValue) is nil.", "error")
	end
end
TRID.MaterialMaker.SetCustomMode = function (instance, USE_CUSTOM_Flag)
	if instance then
		instance.customMode = USE_CUSTOM_Flag
	else
		TRID.DebugPrint("TRID.MaterialMaker.SetCustomMode - instance is nil.", "error")
	end
end
TRID.MaterialMaker.SetCustomShaderCode = function (instance, CUSTOM_SHADER_CODE_Index, code)
	if instance and (not code or (type(code) == "string" and code ~= "")) and (CUSTOM_SHADER_CODE_Index and type(CUSTOM_SHADER_CODE_Index) == "number" and 0 <= CUSTOM_SHADER_CODE_Index and CUSTOM_SHADER_CODE_Index < TRID.CUSTOM_SHADER_CODE_LAST) then
		instance.getCustomShaderCode[CUSTOM_SHADER_CODE_Index] = code
	else
		TRID.DebugPrint("TRID.MaterialMaker.SetCustomShaderCode - instance is nil or code is invalid.", "error")
	end
end

TRID.FinishClassDefinition("TRID.MaterialMaker")

--====================================
-- shader info maker
--====================================
TRID.GetShaderInfoMakerInterface = function ()
	local shaderInfoInterface = {}
	return TRID._SetClassToInstance(shaderInfoInterface, nil, TRID.ShaderInfoMaker)
end
TRID.SaveGLES2Shader = function (saveFilePath)
	if TRIDGLUE then
		if saveFilePath then
			TRIDGLUE.SaveGLES2Shader(saveFilePath)
		else
			TRID.DebugPrint("TRID.SaveGLES2Shader - no (saveFilePath).", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.SaveGLES2Shader")
	end
end
TRID.RegisterShaderInfo = function (savedData, buildNow, formatVersion)
	if TRIDGLUE then
		if savedData then
			local shaderInfoMaker = TRID.GetShaderInfoMakerInterface()
			shaderInfoMaker:Init(savedData.materialBit, savedData.texUsedBit, savedData.vertexData, savedData.totalBoneSkinned, savedData.calcMode, savedData.totalLight, savedData.specPower)
			if savedData.shaderVarList then
				for k,v in pairs(savedData.shaderVarList) do
					shaderInfoMaker:AddVariable(v.MATERIAL_PARAM_Type, v.varName, v.initValue)
				end
			end
			if savedData.customMode then
				shaderInfoMaker:SetCustomMode(savedData.customMode)
			end
			if savedData.getCustomShaderCode then
				for k,v in pairs(savedData.getCustomShaderCode) do
					shaderInfoMaker:SetCustomShaderCode(k,v)
				end
			end
			return TRIDGLUE.RegisterShaderInfo(shaderInfoMaker:Build(), savedData.vertexShaderCode, savedData.pixelShaderCode, savedData.inputFlag, buildNow, formatVersion)
		else
			TRID.DebugPrint("TRID.RegisterShaderInfo - no savedData.", "error")
		end
	else
		TRID.DebugPrint("[TEST] TRID.RegisterShaderInfo")
	end
	return nil
end

TRID.ShaderInfoMaker = TRID.StartClassDefinition("TRID.ShaderInfoMaker")
TRID.ShaderInfoMaker.Init = function (instance, materialBit, texUsedBit, vertexData, totalBoneSkinned, calcMode, totalLight, specPower)
	if instance then
		instance.materialBit = materialBit
		instance.texUsedBit = texUsedBit
		instance.vertexData = vertexData
		instance.totalBoneSkinned = totalBoneSkinned
		instance.calcMode = calcMode
		instance.totalLight = totalLight
		instance.specPowerConstant = specPower
		
		instance.shaderVarList = {}
		instance.getCustomShaderCode = {}
	else
		TRID.DebugPrint("TRID.ShaderInfoMaker.Init - instance is nil.", "error")
	end
end
TRID.ShaderInfoMaker.Build = function (instance)
	if instance then
		local customShaderCodesCount = TRID.GetTableSize(instance.getCustomShaderCode)
		local hasCustomShader = (instance.specPowerConstant or #instance.shaderVarList > 0 or instance.customMode or customShaderCodesCount > 0)
		
		local name = "SShaderInfo"
		local data = {}
		data[#data + 1] = name
		data[name] = {}
		local propData = data[name]
		local CURRENT_SSHADERINFO_FORMAT = "SShaderInfo-v001"
		table.insert(propData, CURRENT_SSHADERINFO_FORMAT)
		table.insert(propData, instance.materialBit)
		table.insert(propData, instance.texUsedBit)
		table.insert(propData, instance.vertexData)
		table.insert(propData, instance.totalBoneSkinned)
		table.insert(propData, instance.calcMode)
		table.insert(propData, instance.totalLight)
		
		-- add custom shader data
		if hasCustomShader then
			table.insert(propData, true)	-- has custom shader
			table.insert(propData, CURRENT_SSHADERINFO_FORMAT)
			table.insert(propData, instance.specPowerConstant or 2)
			table.insert(propData, #instance.shaderVarList)
			local i
			for i=1, #instance.shaderVarList do
				local varData = instance.shaderVarList[i]
				table.insert(propData, varData.MATERIAL_PARAM_Type)
				table.insert(propData, varData.varName)
				if varData.initValue then
					table.insert(propData, #varData.initValue)
					local k
					for k=1, #varData.initValue do
						table.insert(propData, varData.initValue[k])
					end
				else
					table.insert(propData, 0)
				end
				table.insert(propData, varData.totalArray or 0)
			end
			table.insert(propData, instance.customMode or 0)
			
			table.insert(propData, customShaderCodesCount)
			for k,v in pairs(instance.getCustomShaderCode) do
				table.insert(propData, k)
				table.insert(propData, v)
			end
		else
			table.insert(propData, false)	-- has no custom shader
		end
		
		return data
	else
		TRID.DebugPrint("TRID.ShaderInfoMaker.Build - instance is nil.", "error")
	end
	return nil
end
TRID.ShaderInfoMaker.AddVariable = function (instance, MATERIAL_PARAM_Type, varName, initValue)
	if instance and MATERIAL_PARAM_Type and varName and initValue then
		if type(MATERIAL_PARAM_Type) ~= "number" then
			TRID.DebugPrint("TRID.ShaderInfoMaker.AddVariable - MATERIAL_PARAM_Type must be number type.", "error")
			return
		end
		if type(varName) ~= "string" then
			TRID.DebugPrint("TRID.ShaderInfoMaker.AddVariable - varName must be string type.", "error")
			return
		end
		
		local initData = initValue
		if type(initValue) == "number" then
			initData = {initValue}
		elseif type(initValue) ~= "table" then
			TRID.DebugPrint("TRID.ShaderInfoMaker.AddVariable - initValue must be table or number type.", "error")
			return
		end
--~ 		if (not totalArray or (type(totalArray) == "number" and totalArray >= 0)) then
--~ 			TRID.DebugPrint("TRID.ShaderInfoMaker.AddVariable - totalArray must be nil or non-negative number.")
--~ 			return
--~ 		end
		-- TO DO : check valid : duplcation of variable names
		table.insert(instance.shaderVarList, {MATERIAL_PARAM_Type=MATERIAL_PARAM_Type, varName=varName, initValue=initData, totalArray=0})
	else
		TRID.DebugPrint("TRID.ShaderInfoMaker.AddVariable - instance is nil or (varType, varName or initValue) is nil.", "error")
	end
end
TRID.ShaderInfoMaker.SetCustomMode = function (instance, USE_CUSTOM_Flag)
	if instance then
		instance.customMode = USE_CUSTOM_Flag
	else
		TRID.DebugPrint("TRID.ShaderInfoMaker.SetCustomMode - instance is nil.", "error")
	end
end
TRID.ShaderInfoMaker.SetCustomShaderCode = function (instance, CUSTOM_SHADER_CODE_Index, code)
	if instance and (not code or (type(code) == "string" and code ~= "")) and (CUSTOM_SHADER_CODE_Index and type(CUSTOM_SHADER_CODE_Index) == "number" and 0 <= CUSTOM_SHADER_CODE_Index and CUSTOM_SHADER_CODE_Index < TRID.CUSTOM_SHADER_CODE_LAST) then
		instance.getCustomShaderCode[CUSTOM_SHADER_CODE_Index] = code
	else
		TRID.DebugPrint("TRID.ShaderInfoMaker.SetCustomShaderCode - instance is nil or code is invalid.", "error")
	end
end

TRID.FinishClassDefinition("TRID.ShaderInfoMaker")

--====================================
-- model maker
--====================================
TRID.GetModelMakerInterface = function ()
	local modelInterface = {}
	return TRID._SetClassToInstance(modelInterface, nil, TRID.ModelMaker)
end

TRID.ModelMaker = TRID.StartClassDefinition("TRID.ModelMaker")
TRID.ModelMaker.Init = function (instance, resourceVersion)
	if instance and resourceVersion then
		instance.resourceVersion = resourceVersion
		instance.nodes = {}
		instance.materials = {}
		instance.meshes = {}
		instance.boundingBox = nil
	else
		TRID.DebugPrint("TRID.ModelMaker.Init - instance or resourceVersion is nil.", "error")
	end
end

TRID.ModelMaker.AddNode = function (instance, nodeIndex, nodeName, parentIndex, nodeLocalMatrix16)
	if instance and nodeIndex and nodeName then
		local oneNode = {}
		oneNode.result = {nodeIndex, nodeName, parentIndex, TRID.UNPACKTABLE(nodeLocalMatrix16 or TRID.IDENTITY_MAT)}
		oneNode.fullMatrix = nodeLocalMatrix16
		if parentIndex and parentIndex >=0 then
			if not TRID.Assert(instance.nodes[parentIndex], "TRID.ModelMaker.AddNode - you must add parent node before this.") then
				return
			end
			oneNode.fullMatrix = TRID.Mat16Multiply(instance.nodes[parentIndex].fullMatrix, nodeLocalMatrix16)
		end
		-- insert offset matrix.
		table.insert(oneNode.result, TRID.Mat16Invert(oneNode.fullMatrix))
		
		instance.nodes[nodeIndex] = oneNode
	else
		TRID.DebugPrint("TRID.ModelMaker.AddNode - instance or nodeIndex or nodeName is nil.", "error")
	end
end

TRID.ModelMaker.AddMaterial = function (instance, materialProp)
	if instance and materialProp then
		table.insert(instance.materials, materialProp)
		return #instance.materials - 1
	else
		TRID.DebugPrint("TRID.ModelMaker.AddMaterial - instance or materialProp is nil.", "error")
	end
	return nil
end

TRID.ModelMaker._MakeOneMeshHeader = function (materialIndex, vertexFormat, totalVertex)
	return {
		"1",	-- mesh format
		materialIndex, 
		3, 	-- mesh data type (have vertex and face data)
		"1",	-- vertex data format
		vertexFormat,	-- vertex format
		totalVertex, -- total vertex
	}
end

TRID.ModelMaker._MakeOneMeshFaceData = function (oneMesh, totalVertex, faceArray, faceNormalArray)
	-- insert face data
	table.insert(oneMesh, "CFaceData-2") -- face data format
	table.insert(oneMesh, 0) -- face index is int16
	table.insert(oneMesh, #faceArray)
	table.insert(oneMesh, totalVertex)
	for i=1, #faceArray do
		if #faceArray[i] ~= 3 then
			TRID.DebugPrint("TRID.ModelMaker._MakeOneMeshFaceData - faceArry error " .. TRID.TableToString(faceArray[i]), "error")
		end
		TRID.AppendArray(oneMesh, faceArray[i])
	end
	
	-- insert facenormal data
	table.insert(oneMesh, #faceArray)
	if #faceNormalArray == 3 and type(faceNormalArray[1]) == "number" then
		for i=1, #faceArray do
			TRID.AppendArray(oneMesh, faceNormalArray)
		end
	elseif #faceArray == #faceNormalArray then
		for i=1, #faceArray do
			TRID.AppendArray(oneMesh, faceNormalArray[i])
		end
	else
		TRID.DebugPrint("ModelMaker._MakeOneMeshFaceData - faceNormalArray has a wrong format.", "error")
	end
end

-- only support one bone skin.
-- if you modify this logic, YOU MUST MODIFY AddMeshWithColor and AddMeshWithVertexStream
TRID.ModelMaker.AddMesh = function (instance, materialIndex, vertexPositionArray, vertexNormalArray, vertexTexCoordArray, vertexTangentArray, vertexBoneArray, faceArray, faceNormalArray)
	if instance and materialIndex and vertexPositionArray and vertexNormalArray and vertexTexCoordArray and vertexTangentArray and faceArray and faceNormalArray 
		and #vertexPositionArray == #vertexNormalArray and #vertexPositionArray == #vertexTexCoordArray and #vertexPositionArray == #vertexTangentArray 
		and ((#faceArray == #faceNormalArray) or (#faceNormalArray == 3 and type(faceNormalArray[1]) == "number")) then
		
		if not instance.boundingBox then
			instance.boundingBox = {}
		end
		local oneMesh = TRID.ModelMaker._MakeOneMeshHeader(materialIndex,  vertexBoneArray and 163 or 161, #vertexPositionArray)
	
		for i=1, #vertexPositionArray do
			TRID.AppendArray(oneMesh, vertexPositionArray[i])
			if vertexBoneArray then
				table.insert(oneMesh, vertexBoneArray[i])
			end
			TRID.AppendArray(oneMesh, vertexNormalArray[i])
			TRID.AppendArray(oneMesh, vertexTexCoordArray[i])
			TRID.AppendArray(oneMesh, vertexTangentArray[i])
			
			TRID.Vec6AddBox(instance.boundingBox, vertexPositionArray[i])
		end
		
		-- insert face data
		TRID.ModelMaker._MakeOneMeshFaceData(oneMesh, #vertexPositionArray, faceArray, faceNormalArray)
		
		table.insert(instance.meshes, oneMesh)
	else
		TRID.DebugPrint("TRID.ModelMaker.AddMaterial - instance or some mesh data is nil.", "error")
	end
end

-- if you modify this logic, YOU MUST MODIFY AddMesh and AddMeshWithVertexStream
TRID.ModelMaker.AddMeshWithColor = function (instance, materialIndex, vertexPositionArray, vertexNormalArray, vertexTexCoordArray, vertexColorArray, faceArray, faceNormalArray)
	if instance and materialIndex and vertexPositionArray and vertexNormalArray and vertexTexCoordArray and vertexColorArray and faceArray and faceNormalArray 
		and #vertexPositionArray == #vertexNormalArray and #vertexPositionArray == #vertexTexCoordArray and #vertexPositionArray == #vertexColorArray 
		and ((#faceArray == #faceNormalArray) or (#faceNormalArray == 3 and type(faceNormalArray[1]) == "number")) then
		
		if not instance.boundingBox then
			instance.boundingBox = {}
		end
		
		local oneMesh = TRID.ModelMaker._MakeOneMeshHeader(materialIndex,  1121, #vertexPositionArray)
		
		for i=1, #vertexPositionArray do
			TRID.AppendArray(oneMesh, vertexPositionArray[i])
			TRID.AppendArray(oneMesh, vertexNormalArray[i])
			TRID.AppendArray(oneMesh, {vertexColorArray[i]})
			TRID.AppendArray(oneMesh, vertexTexCoordArray[i])
			
			instance.boundingBox[1] = instance.boundingBox[1] and math.min(instance.boundingBox[1], vertexPositionArray[i][1]) or vertexPositionArray[i][1]
			instance.boundingBox[2] = instance.boundingBox[2] and math.min(instance.boundingBox[2], vertexPositionArray[i][2]) or vertexPositionArray[i][2]
			instance.boundingBox[3] = instance.boundingBox[3] and math.min(instance.boundingBox[3], vertexPositionArray[i][3]) or vertexPositionArray[i][3]
			instance.boundingBox[4] = instance.boundingBox[4] and math.max(instance.boundingBox[4], vertexPositionArray[i][1]) or vertexPositionArray[i][1]
			instance.boundingBox[5] = instance.boundingBox[5] and math.max(instance.boundingBox[5], vertexPositionArray[i][2]) or vertexPositionArray[i][2]
			instance.boundingBox[6] = instance.boundingBox[6] and math.max(instance.boundingBox[6], vertexPositionArray[i][3]) or vertexPositionArray[i][3]
		end
		
		-- insert face data
		TRID.ModelMaker._MakeOneMeshFaceData(oneMesh, #vertexPositionArray, faceArray, faceNormalArray)
		
		table.insert(instance.meshes, oneMesh)
	else
		TRID.DebugPrint("TRID.ModelMaker.AddMeshWithColor - instance or some mesh data is nil.", "error")
	end
end

-- if you modify this logic, YOU MUST MODIFY AddMesh and AddMeshWithColor
TRID.ModelMaker.AddMeshWithVertexStream = function (instance, materialIndex, vertexFormat, vertexStream, faceArray, faceNormalArray, boundingBox)
	if instance and materialIndex and vertexFormat and vertexStream and faceArray and faceNormalArray 
		and ((#faceArray == #faceNormalArray) or (#faceNormalArray == 3 and type(faceNormalArray[1]) == "number")) then
		
		instance.boundingBox = boundingBox
		
		local oneMesh = TRID.ModelMaker._MakeOneMeshHeader(materialIndex,  vertexFormat, #vertexStream)
	
		for i=1, #vertexStream do
			TRID.AppendArray(oneMesh, vertexStream[i])
		end
		
		-- insert face data
		TRID.ModelMaker._MakeOneMeshFaceData(oneMesh, #vertexStream, faceArray, faceNormalArray)
		
		table.insert(instance.meshes, oneMesh)
	else
		TRID.DebugPrint("TRID.ModelMaker.AddMeshWithVertexStream - instance or some mesh data is nil.", "error")
	end
end

TRID.ModelMaker.Build = function (instance)
	if instance then
		local data = {4, "CModel-3", instance.resourceVersion or 0}
		
		-- insert node data
		table.insert(data, "1")	-- insert node format
		table.insert(data, TRID.GetTableSize(instance.nodes))
		for k,v in pairs(instance.nodes) do
			table.insert(data, TRID.UNPACKTABLE(v.result))
		end
		
		-- insert material data
		table.insert(data, #instance.materials)
		for i=1, #instance.materials do
			table.insert(data, TRID.UNPACKTABLE(instance.materials[i]))
		end
		
		-- insert material group data
		table.insert(data, #instance.materials)
		for i=1, #instance.materials do
			table.insert(data, i-1)
		end
		
		-- insert mesh data
		table.insert(data, #instance.meshes)
		for i=1, #instance.meshes do
			table.insert(data, TRID.UNPACKTABLE(instance.meshes[i]))
		end
		
		-- insert bounding box
		TRID.AppendArray(data, instance.boundingBox or {0,0,0, 0,0,0})
	
		-- insert heightmap
		table.insert(data, "")
		return data
	else
		TRID.DebugPrint("TRID.ModelMaker.Build - instance is nil.", "error")
	end
	return nil
end

TRID.FinishClassDefinition("TRID.ModelMaker")



TRID.ModelData = TRID.StartClassDefinition("TRID.ModelData")
TRID.ModelData.POSITION = 1
TRID.ModelData.NORMAL = 2
TRID.ModelData.COLOR = 4
TRID.ModelData.BONEINDEX = 8
TRID.ModelData.WEIGHT = 16
TRID.ModelData.TEX0 = 32
TRID.ModelData.TANGENT = 64
TRID.ModelData.TEX1 = 128
TRID.ModelData.TEX2 = 1024
TRID.ModelData.Init = function (instance, targetInstance)
	if instance and targetInstance then
		instance.targetInstance = targetInstance
		-- materialList[modelSlot][materialGroup][materialBit] = {table color=?, string image=?, number textureProp=?, number ratio=?}
		instance.materialList = {}
		-- meshList[modelSlot][meshIndex] = {number totalVertex=?, number totalFace=?, number vertexDataFlag=?, number totalBoneSkinned=?}
		instance.meshList = {}
		-- uvRectList[modelSlot][meshIndex] = vec4 rect
		instance.uvRectList = {}
		-- boneList[boneIndex] = {name=?, parentIndex=?}
		instance.boneList = {}
		-- boundingBoxList[modelSlot] = vec6 box
		instance.boundingBoxList = {}
		instance.boundingBox = nil
	else
		TRID.DebugPrint("TRID.ModelData.Init - instance or targetInstance is nil.", "error")
	end
end
TRID.ModelData.PrepareMaterials = function (instance)
	if instance and instance.targetInstance then
		instance.materialList = {}
		local modelSlotList = {TRIDGLUE.GetModelSlotList(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2])}
		if modelSlotList[1] then
			for i, modelSlot in ipairs(modelSlotList) do
				local materialGroupList = {TRIDGLUE.GetTotalMaterialGroupList(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot)}
				if materialGroupList[1] then
					instance.materialList[modelSlot] = {}
					for i2, materialGroup in ipairs(materialGroupList) do
						local usedBitList = {TRIDGLUE.GetUsedMaterialBitList(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, materialGroup)}
						if usedBitList[1] then
							instance.materialList[modelSlot][materialGroup] = {}
							for i3, materialBit in ipairs(usedBitList) do
								if materialBit ~= TRID.MATERIAL_ENVLEVEL_BIT then
									local materialData = {TRIDGLUE.GetMaterialData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, materialGroup, materialBit)}
									if materialData[1] then
										instance.materialList[modelSlot][materialGroup][materialBit] = {}
										local d = instance.materialList[modelSlot][materialGroup][materialBit]
										d.color = TRID.ARGB(materialData[4]*255, materialData[1]*255, materialData[2]*255, materialData[3]*255)
										d.image = materialData[5]
										d.textureProp = materialData[6]
										d.ratio = materialData[7]
									else
										TRID.DebugPrint("TRID.ModelData.PrepareMaterials - materialData is nil.[" .. tostring(modelSlot) .. "][" .. tostring(materialGroup) .. "][" .. tostring(materialBit) .. "]", "error")
									end
								end
							end
						else
							TRID.DebugPrint("TRID.ModelData.PrepareMaterials - usedBitList is nil.[" .. tostring(modelSlot) .. "][" .. tostring(materialGroup) .. "]", "error")
						end
					end
				else
					TRID.DebugPrint("TRID.ModelData.PrepareMaterials - materialGroupList is nil.[" .. tostring(modelSlot) .. "]", "error")
				end
			end
		else
			TRID.DebugPrint("TRID.ModelData.PrepareMaterials - modelSlotList is nil.", "error")
		end
	else
		TRID.DebugPrint("TRID.ModelData.PrepareMaterials - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.PrepareMeshes = function (instance)
	if instance and instance.targetInstance then
		if #instance.materialList == 0 then
			instance:PrepareMaterials()
		end
		instance.meshList = {}
		for modelSlot, modelSlotData in pairs(instance.materialList) do
			instance.meshList[modelSlot] = {}
			for materialGroup, materialGroupData in pairs(modelSlotData) do
				local totalFace = TRIDGLUE.GetTotalFace(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, materialGroup)
				local totalVertex, dataFlag, totalBoneSkinned = TRIDGLUE.GetTotalVertex(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, materialGroup)
				if totalFace and totalVertex then
					instance.meshList[modelSlot][materialGroup] = {}
					local d = instance.meshList[modelSlot][materialGroup]
					d.totalVertex = totalVertex
					d.totalFace = totalFace
					d.vertexDataFlag = dataFlag
					d.totalBoneSkinned = totalBoneSkinned
				else
					TRID.DebugPrint("TRID.ModelData.PrepareMeshes - totalFace or totalVertex is nil.[" .. tostring(modelSlot) .. "][" .. tostring(materialGroup) .. "]", "error")
				end
			end
		end
	else
		TRID.DebugPrint("TRID.ModelData.PrepareMeshes - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.PrepareBones = function (instance)
	if instance and instance.targetInstance then
		instance.boneList = {}
		local boneData = {TRIDGLUE.GetBoneData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2])}
		if #boneData > 0 then
			local index = 0
			for i=1, #boneData, 2 do
				instance.boneList[index] = {name = boneData[i], parentIndex = boneData[i+1]}
				index = index + 1
			end
		else
			TRID.DebugPrint("TRID.ModelData.PrepareBones - no bone data.", "error")
		end
	else
		TRID.DebugPrint("TRID.ModelData.PrepareBones - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.GetBoundingBox = function (instance, modelSlot)
	if instance and instance.targetInstance then
		if not instance.boundingBox then
			local modelSlotList = {TRIDGLUE.GetModelSlotList(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2])}
			if modelSlotList[1] then
				local box = {}
				for i, modelSlot in pairs(modelSlotList) do
					local modelBox = {TRIDGLUE.GetModelBoundingBox(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot)}
					instance.boundingBoxList[modelSlot] = modelBox
					
					TRID.Vec6AddBox(box, modelBox)
				end
				instance.boundingBox = box
			else
				TRID.DebugPrint("TRID.ModelData.GetBoundingBox - no model.", "error")
			end
		end
		return (modelSlot and instance.boundingBoxList[modelSlot] or instance.boundingBox)
	else
		TRID.DebugPrint("TRID.ModelData.GetBoneData - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.GetUVRect = function (instance, modelSlot, materialGroup)
	if instance and instance.targetInstance then
		if not instance.uvRectList[modelSlot] then
			instance.uvRectList[modelSlot] = {}
		end
		if not instance.uvRectList[modelSlot][materialGroup] then
			local uvRect = {TRIDGLUE.GetUVRect(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, materialGroup)}
			if uvRect[1] then
				instance.uvRectList[modelSlot][materialGroup] = uvRect
			else
				TRID.DebugPrint("TRID.ModelData.GetUVRect - can not get uv rect.", "error")
			end
		end
		return instance.uvRectList[modelSlot][materialGroup]
	else
		TRID.DebugPrint("TRID.ModelData.GetUVRect - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.SplitOpaqueMesh = function (instance)
	if instance and instance.targetInstance then
		TRIDGLUE.SplitOpaqueMesh(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2])
	else
		TRID.DebugPrint("TRID.ModelData.SplitOpaqueMesh - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.GetBoneData = function (instance)
	if instance and instance.targetInstance then
		if #instance.boneList == 0 then
			instance:PrepareBones()
		end
		return instance.boneList
	else
		TRID.DebugPrint("TRID.ModelData.GetBoneData - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.GetMaterialData = function (instance)
	if instance and instance.targetInstance then
		if #instance.materialList == 0 then
			instance:PrepareMaterials()
		end
		return instance.materialList
	else
		TRID.DebugPrint("TRID.ModelData.GetMaterialData - instance or instance.targetInstance is nil.", "error")
	end
end
TRID.ModelData.GetMeshData = function (instance)
	if instance and instance.targetInstance then
		if #instance.meshList == 0 then
			instance:PrepareMeshes()
		end
		return instance.meshList
	else
		TRID.DebugPrint("TRID.ModelData.GetMeshData - instance or instance.targetInstance is nil.", "error")
	end
end
-- result = {vec3 position=?, vec3 normal=?, table color=?, table boneIndex=?, table weight=?, vec2 tex0=?, vec4 tangent=?, vec2 tex1=?, vec2 tex2=?}
TRID.ModelData.GetOneVertexData = function (instance, modelSlot, meshIndex, vertexIndex)
	local meshData = instance.meshList[modelSlot][meshIndex]
	local v = {TRIDGLUE.GetVertexData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, vertexIndex)}
	local result = {}
	local lastIndex = 1
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.POSITION) then
		result.position = {v[lastIndex], v[lastIndex+1], v[lastIndex+2]}
		lastIndex = lastIndex + 3
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.NORMAL) then
		result.normal = {v[lastIndex], v[lastIndex+1], v[lastIndex+2]}
		lastIndex = lastIndex + 3
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.COLOR) then
		result.color = TRID.ARGB(v[lastIndex+3], v[lastIndex], v[lastIndex+1], v[lastIndex+2])
		lastIndex = lastIndex + 4
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.BONEINDEX) and meshData.totalBoneSkinned > 0 then
		result.boneIndex = {}
		for i=1, meshData.totalBoneSkinned do
			result.boneIndex[i] = v[lastIndex+i]
		end
		lastIndex = lastIndex + meshData.totalBoneSkinned
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.WEIGHT) and meshData.totalBoneSkinned > 1 then
		result.weight = {}
		for i=1, meshData.totalBoneSkinned-1 do
			result.weight[i] = v[lastIndex+i]
		end
		lastIndex = lastIndex + meshData.totalBoneSkinned-1
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.TEX0) then
		result.tex0 = {v[lastIndex], v[lastIndex+1]}
		lastIndex = lastIndex + 2
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.TANGENT) then
		result.tangent = {v[lastIndex], v[lastIndex+1], v[lastIndex+2], v[lastIndex+3]}
		lastIndex = lastIndex + 4
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.TEX1) then
		result.tex1 = {v[lastIndex], v[lastIndex+1]}
		lastIndex = lastIndex + 2
	end
	if TRID.IsBitSet(meshData.vertexDataFlag, TRID.ModelData.TEX2) then
		result.tex2 = {v[lastIndex], v[lastIndex+1]}
		lastIndex = lastIndex + 2
	end
	return result
end
TRID.ModelData.GetOneFaceData = function (instance, modelSlot, meshIndex, faceIndex)
	local meshData = instance.meshList[modelSlot][meshIndex]
	return {TRIDGLUE.GetFaceData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, faceIndex)}
end
-- return {vertexData1, vertexData2, vertexData3}
-- vertexData# : {vec3 position=?, vec3 normal=?, table color=?, table boneIndex=?, table weight=?, vec2 tex0=?, vec4 tangent=?, vec2 tex1=?, vec2 tex2=?}
TRID.ModelData.GetVertexData = function (instance, modelSlot, meshIndex, faceIndex)
	if instance and instance.targetInstance then
		if #instance.meshList == 0 then
			instance:PrepareMeshes()
		end
		if (instance.meshList[modelSlot] and instance.meshList[modelSlot][meshIndex]) then
			local vertexList = instance:GetOneFaceData(modelSlot, meshIndex, faceIndex)
			if #vertexList == 3 then
				local result = {}
				for i=1, #vertexList do
					result[i] = instance:GetOneVertexData(modelSlot, meshIndex, vertexList[i])
				end
				return result
			else
				TRID.DebugPrint("TRID.ModelData.GetVertexData - no vertex data.", "error")
			end
		else
			TRID.DebugPrint("TRID.ModelData.GetVertexData - no mesh data.", "error")
		end
	else
		TRID.DebugPrint("TRID.ModelData.GetVertexData - instance or instance.targetInstance is nil.", "error")
	end
end

TRID.ModelData.GetMeshPlane = function (instance, modelSlot, meshIndex, isLocal)
	if instance and instance.targetInstance then
		local c1, c2, c3, n1, n2, n3 = TRIDGLUE.GetMeshPlane(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, isLocal)
		if c1 then
			return {c1, c2, c3}, {n1, n2, n3}
		else
			TRID.DebugPrint("TRID.ModelData.GetMeshPlane - no data.", "error")
		end
	else
		TRID.DebugPrint("TRID.ModelData.GetMeshPlane - instance or instance.targetInstance is nil.", "error")
	end
end

TRID.ModelData.ModifyOnePosition = function (instance, modelSlot, meshIndex, vertexIndex, pos)
	if instance and instance.targetInstance and modelSlot and meshIndex and vertexIndex and pos then
		TRIDGLUE.ModifyVertexData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, vertexIndex, TRID.ModelData.POSITION, pos[1], pos[2], pos[3])
	else
		TRID.DebugPrint("TRID.ModelData.ModifyOnePosition - instance or instance.targetInstance or other data is nil.", "error")
	end
end

TRID.ModelData.ModifyOneNormal = function (instance, modelSlot, meshIndex, vertexIndex, norm)
	if instance and instance.targetInstance and modelSlot and meshIndex and vertexIndex and norm then
		TRIDGLUE.ModifyVertexData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, vertexIndex, TRID.ModelData.NORMAL, norm[1], norm[2], norm[3])
	else
		TRID.DebugPrint("TRID.ModelData.ModifyOneNormal - instance or instance.targetInstance or other data is nil.", "error")
	end
end

TRID.ModelData.ModifyOneTexCoord = function (instance, modelSlot, meshIndex, vertexIndex, tex)
	if instance and instance.targetInstance and modelSlot and meshIndex and vertexIndex and tex then
		TRIDGLUE.ModifyVertexData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, vertexIndex, TRID.ModelData.TEX0, tex[1], tex[2])
	else
		TRID.DebugPrint("TRID.ModelData.ModifyOneTexCoord - instance or instance.targetInstance or other data is nil.", "error")
	end
end

TRID.ModelData.ModifyOneTangent = function (instance, modelSlot, meshIndex, vertexIndex, tangent)
	if instance and instance.targetInstance and modelSlot and meshIndex and vertexIndex and tangent then
		TRIDGLUE.ModifyVertexData(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot, meshIndex, vertexIndex, TRID.ModelData.TANGENT, tangent[1], tangent[2], tangent[3], tangent[4])
	else
		TRID.DebugPrint("TRID.ModelData.ModifyOneTangent - instance or instance.targetInstance or other data is nil.", "error")
	end
end

TRID.ModelData.SaveModel = function (instance, modelSlot)
	if instance and instance.targetInstance and modelSlot then
		TRIDGLUE.SaveModel(instance.targetInstance._baseID[1], instance.targetInstance._baseID[2], modelSlot)
	else
		TRID.DebugPrint("TRID.ModelData.SaveModel - instance or instance.targetInstance or other data is nil.", "error")
	end
end

TRID.FinishClassDefinition("TRID.ModelData")

TRID.JSON = json

--====================================
-- obsolete definitions
--====================================
TRID.MSG_CHANGE_BOUNDING_AREA = TRID.MSG_BOUNDING_AREA_CHANGED
TRID.MSG_CHANGE_BOUNDING_AREA_3D = TRID.MSG_3D_BOUNDING_AREA_CHANGED
TRID.MSG_LISTBOX_SELECT_ITEM = TRID.MSG_LISTBOX_ITEM_SELECTED
TRID.MSG_LISTBOX_DESELECT_ITEM = TRID.MSG_LISTBOX_ITEM_DESELECTED
TRID.MSG_LISTBOX_ENTER_ITEM = TRID.MSG_LISTBOX_ITEM_ENTERED
TRID.MSG_LISTBOX_LEAVE_ITEM = TRID.MSG_LISTBOX_ITEM_LEFT
TRID.MSG_LISTBOX_CLICK_ITEM = TRID.MSG_LISTBOX_ITEM_CLICKED
TRID.MSG_LISTBOX_DBCLICK_ITEM = TRID.MSG_LISTBOX_ITEM_DBCLICKED
TRID.MSG_RETURN_ON_EDITBOX = TRID.MSG_EDITBOX_SUBMITTED
TRID.MSG_COLLISION = TRID.MSG_COLLISION_TO_TARGET
TRID.MSG_COLLIDED_BY_OTHER = TRID.MSG_COLLISION_TO_ME
TRID.MSG_MOVE_IN_OUT_MYOBB = TRID.MSG_COLLIDED_BY_OTHER
TRID.MSG_NOTIFY_SET_FOCUSED = TRID.MSG_FOCUSED
TRID.MSG_NOTIFY_RESET_FOCUSED = TRID.MSG_UNFOCUSED

TRID.FOID_RENDER_SCREEN = TRID.FOID_POST_EFFECTOR

TRID.RENDER_NOT_GENERATING_LIGHTMAP = TRID.RENDER_NO_LIGHTMAP_GENERATION
TRID.RENDER_HAS_NO_SHADOW = TRID.RENDER_NO_SHADOW
TRID.FLAG_HIDE_NOT_PICKUP = TRID.FLAG_HIDE_BUT_PICKUP

TRID.TL_LEFT = TRID.TEXTLAYOUT_LEFT
TRID.TL_RIGHT = TRID.TEXTLAYOUT_RIGHT
TRID.TL_TOP = TRID.TEXTLAYOUT_TOP
TRID.TL_BOTTOM = TRID.TEXTLAYOUT_BOTTOM
TRID.TL_RECT_FIT_TEXT = TRID.TEXTLAYOUT_WRAP_TEXT

TRID.WHITERGB = TRID.WHITECOLOR
TRID.BLACKRGB = TRID.BLACKCOLOR

TRID.TableCount = TRID.GetTableSize
TRID.IsSetBit = TRID.IsBitSet
TRID.CompareVec3 = TRID.Vec3Compare
TRID.CompareVec = TRID.CompareArray

TRID.MakeGraphicObject = TRID.MakeOnePropOfGraphicObject
TRID.MakeBoundingRect = TRID.MakeOnePropOfBoundingRect
TRID.MakeBoundingInterfaceFor3D = TRID.MakeOnePropOfBoundingInterfaceFor3D
TRID.MakeBoundingSphere = TRID.MakeOnePropOfBoundingSphere
TRID.MakeBoundingBox = TRID.MakeOnePropOfBoundingBox
TRID.MakeRenderResource = TRID.MakeOnePropOfRenderResource
TRID.MakePosition = TRID.MakeOnePropOfPosition
TRID.MakeMotionObject = TRID.MakeOnePropOfMotion
TRID.MakeEffectColor = TRID.MakeOnePropOfEffectColor
TRID.MakeRenderObject = TRID.MakeOnePropOfRenderObject
TRID.MakeRender2DDefault = TRID.MakeOnePropOfRender2DWithImage
TRID.MakeRender2DTextDefault = TRID.MakeOnePropOfRender2DWithText
TRID.MakeRender2DWithText = TRID.MakeOnePropOfRender2DWithImageText
TRID.MakeRender2DColor = TRID.MakeOnePropOfRender2DWithColor
TRID.MakeRender2DRedirection = TRID.MakeOnePropOfRender2DWithRedirection
TRID.MakeRender2DGradationColor = TRID.MakeOnePropOfRender2DWithGradationColor
TRID.MakeRender2DImageWithGradationColor = TRID.MakeOnePropOfRender2DWithImageGradationColor
TRID.MakeRender2DPattern = TRID.MakeOnePropOfRender2DWithPatternImage
TRID.MakeRender2DPatternWithText = TRID.MakeOnePropOfRender2DWithPatternImageText
TRID.MakeRender3D = TRID.MakeOnePropOfRender3D
TRID.MakeNodeObject = TRID.MakeOnePropOfNodeObject
TRID.MakeFrameBase = TRID.MakeOnePropOfFrameBase
TRID.MakeStaticResource = TRID.MakeOnePropOfRenderResourceWithSimpleStaticModel
TRID.MakeBodyList = TRID.MakeOnePropOfBodyList
TRID.MakeAnimationList = TRID.MakeOnePropOfAnimationList
TRID.MakeSimpleAnimResource = TRID.MakeOnePropOfRenderResourceWithSimpleAnimatingModel
TRID.MakeSimpleMorphingAnimResource = TRID.MakeOnePropOfRenderResourceWithSimpleMorphingModel
TRID.MakeTerrain = TRID.MakeOnePropOfTerrain
TRID.MakeEditBox = TRID.MakeOnePropOfEditBox
TRID.MakeListBox = TRID.MakeOnePropOfListBox
TRID.MakeDirectionalLight = TRID.MakeOnePropOfLightDirectional
TRID.MakeMoveHeader = TRID.MakeOnePropOfMoveHeader
TRID.Make3DView = TRID.MakePropsOf3DView
TRID.MakePatternFrame = TRID.MakePropsOfFrameWithPatternImage
TRID.MakeColorFrame = TRID.MakePropsOfFrameWithColor
TRID.Make2DGUIColor = TRID.MakePropsOfGUIWithColor
TRID.MakeCamera = TRID.MakePropsOfCameraInSimple
TRID.MakeDetailCamera = TRID.MakePropsOfCameraInDetail
TRID.MakeBox = TRID.MakePropsOfBox
TRID.MakeGrid = TRID.MakePropsOfGrid
TRID.MakeButtonOnly = TRID.MakeOnePropOfButton
TRID.MakeButton = TRID.MakePropsOfButton
TRID.Make2DGUISimple = TRID.MakePropsOfGUIWithImage
TRID.Make2DGUIGradationColor = TRID.MakePropsOfGUIWithGradationColor
TRID.Make2DGUIRedirection = TRID.MakePropsOfGUIWithRedirection
TRID.Make2DGUIPattern = TRID.MakePropsOfGUIWithPatternImage
TRID.Make2DTextSimple = TRID.MakePropsOfGUIWithText
TRID.MakeHorizontalSlider = TRID.MakePropsOfHorizontalSlider
TRID.MakeFlash = TRID.MakeOnePropOfFlash
TRID.MakeX3D = TRID.MakeOnePropOfX3D
TRID.MakeEnvironmentMapManager = TRID.MakeOnePropOfEnvironmentMapManager
TRID.MakeOneTridParticleEmitter = TRID.MakeOnePropOfParticleEmitter
TRID.MakeOneTridParticleAnimator = TRID.MakeOnePropOfParticleAnimator
TRID.MakeOneTridParticleRenderer = TRID.MakeOnePropOfParticleRenderer
TRID.MakeTridParticleSystem = TRID.MakeOnePropOfParticles
TRID.MakeDefaultParticleSystem = TRID.MakePropsOfParticleSystemDefault

--====================================
-- protect important data
-- so you must set any code before this.
--====================================
TRID = TRID.ProtectTable(TRID)
