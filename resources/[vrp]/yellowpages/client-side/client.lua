-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("yellowpages",cnVRP)
vSERVER = Tunnel.getInterface("yellowpages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local isOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("yellowpages:Command")
AddEventHandler("yellowpages:Command",function()
    if not isOpen then
        isOpen = true
        SetNuiFocus(true,true)
        SendNUIMessage({ action = "show" })
        vRP.createObjects("cellphone@","cellphone_text_in","prop_npc_phone_02",50,28422)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEAPP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CloseApp",function(data,cb)
	vRP.removeObjects("one")
	SetNuiFocus(false)
	isOpen = false
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("AddPost",function(data,cb)
	local array = vSERVER.updatePost(data.text)
	cb(array)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPOSTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetPosts",function(data,cb)
	local array = vSERVER.getPosts()
	cb(array)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CallAd",function(data)
    SetNuiFocus(false)
    isOpen = false
	local number = vSERVER.getNumber()
	if data.number ~= number then
		Citizen.Wait(1000)
		TriggerEvent("gcPhone:callNotifyPush",data.number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("yellowpages:Update")
AddEventHandler("yellowpages:Update",function()
	SendNUIMessage({ action = "update" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false)
end)