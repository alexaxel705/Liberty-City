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



function CreateVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2)
	local theVehicle = createVehicle(model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2)
	setElementDimension(theVehicle, 1)
	return theVehicle
end





function Go_LC(thePlayer)
	setCameraTarget(thePlayer, thePlayer)
	setElementPosition(thePlayer, 787.5, 691.2, 18.5)
	setElementRotation(thePlayer, 0,0,180)
	setElementDimension(thePlayer, 1)
	setElementInterior(thePlayer, 0)
	setElementFrozen(thePlayer, false)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if(theVehicle) then
		setElementPosition(theVehicle, 787.5, 691.2, 20.5)
		setElementRotation(theVehicle, 0,0,180)
		setElementDimension(theVehicle, 1)
		setElementInterior(theVehicle, 0)
	end
	outputChatBox("Welcome to Liberty City!", thePlayer)
	checkVC[thePlayer] = "lc"
end
addEvent("Go_LC", true)
addEventHandler("Go_LC", root, Go_LC)


function CheckEnd(thePlayer)
	triggerClientEvent(thePlayer, "LibertyRadar", thePlayer)
	checkVC[thePlayer] = "lc"
	setElementFrozen(thePlayer, true)
	
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