--====================================
-- file : _TriDStartup.lua
-- author : ulralra
-- date : 2009-09-04
-- description : start up codes
-- Tri-d communications, Co., Ltd.
--====================================

-- use _LoadLuaScript instead of dofile since encoded lua scripts.
_LoadLuaScript("json.lua")
_LoadLuaScript("_TriDCommon.lua")
_LoadLuaScript("_TriDDynamicData.lua")

--__TRID_DEFAULT_PAGE = "BrowsingTool/_TriDBrowsingToolMain.lua"

-- for test debugging
MODE_DEBUG = false
DEBUG_FILE = "debug_lua.txt"
MODE_ASSERT = false