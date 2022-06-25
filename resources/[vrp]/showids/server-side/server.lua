-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP UTILS
-----------------------------------------------------------------------------------------------------------------------------------------	
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
cRP = {}
Tunnel.bindInterface("showids",cRP)
Proxy.addInterface("showids",cRP)
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookids = "https://discord.com/api/webhooks/989702837095252030/1FSnIcLuM-jNC_D_CwBsmkS7O3nIPJtp0PQH9vFKuFW9VcrH9op_9jK7SBa5tUI3bV8q"
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER ADMIN PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------	
function cRP.isAdmin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return (vRP.hasPermission(user_id,"Admin"))
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER ID AND STEAMHEX
-----------------------------------------------------------------------------------------------------------------------------------------	
function cRP.getId(sourceplayer)
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			local userIdentity = vRP.getUserIdentity(user_id)
			return user_id, userIdentity
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORT LOG WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reportLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.createWeebHook(webhookids,"```prolog\n[ID]: "..user_id.." \n[STATUS]: ".. toggle ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end