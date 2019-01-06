local checkVC = {}
local xml = xmlLoadFile("meta.xml")
local DownloadList = {}
local ind = 0
local Completed = false


repeat
	local chld = xmlFindChild(xml, "file", ind)
	if(chld) then
		local str = xmlNodeGetAttribute(chld, "src")   
		table.insert(DownloadList, str)
		ind = ind + 1
	else
		Completed = true
		outputServerLog("Resource Liberty City is ready to use")
	end
until Completed; 





function Go_LC(thePlayer)
	setCameraTarget(thePlayer, thePlayer)
	setElementPosition(thePlayer, 787.5, 691.2, 18.5)
	setElementDimension(thePlayer, 1)
	setElementInterior(thePlayer, 0)
	setElementFrozen(thePlayer, false)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if(theVehicle) then
		setElementPosition(theVehicle, 788.5, 689, 20)
		setElementDimension(theVehicle, 1)
		setElementInterior(theVehicle, 0)
	end
	outputChatBox("Welcome to Liberty City!", thePlayer)
	checkVC[thePlayer] = "lc"
end
addEvent("Go_LC", true)
addEventHandler("Go_LC", root, Go_LC)


function CheckEnd(thePlayer)
	checkVC[thePlayer] = "lc"
	setElementFrozen(thePlayer, true)
	
	setCameraMatrix(thePlayer, 7968.64-7850, 8394.292-7850, 23.1283+150, 7968.64-8000, 8394.292-8000, 23.1283+50) -- 1288.5, 1189, 75.7, 788.5, 689, 25.7)
	
	setElementDimension(thePlayer, 1)
	setElementInterior(thePlayer, 0)
	if(theVehicle) then
		setElementDimension(theVehicle, 1)
		setElementInterior(theVehicle, 0)
	end
end
addEvent("CheckEnd", true)
addEventHandler("CheckEnd", root, CheckEnd)





function lc(thePlayer, command, h)
	if(not checkVC[thePlayer]) then
		triggerClientEvent(thePlayer, "CheckFiles", thePlayer, DownloadList)
		checkVC[thePlayer] = "check"
	else
		if(checkVC[thePlayer] == "lc") then
			Go_LC(thePlayer)
		end
	end
end
addCommandHandler("lc", lc)

function worldtime()
	--for thePlayer, theKey in pairs(checkVC) do
	--	local x, y, z = getElementPosition(thePlayer)
	--	if(x < 6000 or x > 9000) then
	--		if(y > -7000 or y < -10000) then
	--			triggerClientEvent(thePlayer, "ClearObj", thePlayer)
	--			checkVC[thePlayer] = nil
	--		end
	--	end
	--end
end
setTimer(worldtime, 1000, 0)