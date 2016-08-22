--====================================
-- file : _TriDDynamicData.lua
-- author : ulralra
-- date : 2009-09-02
-- description : dynamic data such as class, instance
-- Tri-d communications, Co., Ltd.
--====================================

--====================================
-- Instance Data
--====================================
GLOBALDATA = 0

TRID_DYNAMIC_DATA = {}
TRID_DYNAMIC_DATA.INSTANCEMAP = {}
TRID_DYNAMIC_DATA.DELETEDMAP = {}
TRID_DYNAMIC_DATA.PATHSTACK = {}

TRID_DYNAMIC_DATA.PushPath = function (realPath, luaName)
	TRID_DYNAMIC_DATA.PATHSTACK[#TRID_DYNAMIC_DATA.PATHSTACK + 1] = { [1] = realPath, [2] = luaName }
end

TRID_DYNAMIC_DATA.PopPath = function ()
	if #TRID_DYNAMIC_DATA.PATHSTACK > 0 then
		TRID_DYNAMIC_DATA.PATHSTACK[#TRID_DYNAMIC_DATA.PATHSTACK] = nil
	else
		TRID.DebugPrint("stack of path is broken.")
	end
end

TRID_DYNAMIC_DATA.GetCurrentPath  = function ()
	if #TRID_DYNAMIC_DATA.PATHSTACK > 0 then
		local paths = TRID_DYNAMIC_DATA.PATHSTACK[#TRID_DYNAMIC_DATA.PATHSTACK]
		return paths[1], paths[2]
	else
		return "", ""
	end
end

-- data for instance constructor
TRID_DYNAMIC_DATA.INITDATAMAP = {}

TRID_DYNAMIC_DATA.PushInitData = function (baseID, objectType, initData, callBackAfterCreation)
	if baseID then
		if not TRID_DYNAMIC_DATA.INITDATAMAP[baseID[1]] then
			TRID_DYNAMIC_DATA.INITDATAMAP[baseID[1]] = {}
		end
		TRID_DYNAMIC_DATA.INITDATAMAP[baseID[1]][baseID[2]] = {objectType, initData, callBackAfterCreation}
	else
		TRID.DebugPrint("TRID_DYNAMIC_DATA.PushInitData - baseID is nil")
	end
end

TRID_DYNAMIC_DATA.PopInitData = function (baseID1, baseID2)
	if baseID1 and baseID2 then
		local initMap1 = TRID_DYNAMIC_DATA.INITDATAMAP[baseID1]
		if initMap1 then
			local result = initMap1[baseID2]
			if result then
				initMap1[baseID2] = nil
				return result
			end
		end
		return nil
	else
		TRID.DebugPrint("TRID_DYNAMIC_DATA.PopInitData - baseID is nil")
	end
end

--====================================
-- protect important data
-- so you must set any code before this.
--====================================
TRID_DYNAMIC_DATA = TRID.ProtectTable(TRID_DYNAMIC_DATA)
