-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dynamic",cRP)
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local animalHahs = nil
local animalFollow = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SetNuiFocus(true,true)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,menuid)
	SetNuiFocus(true,true)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = menuid })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data,cb)
	if data["server"] == "true" then
		TriggerServerEvent(data["trigger"],data["param"])
	else
		TriggerEvent(data["trigger"],data["param"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data,cb)
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			menuOpen = true

			exports["dynamic"]:AddButton("Remover","Remover a roupa atual.","player:outfitFunctions","remover","outfit",true) 

			exports["dynamic"]:AddButton("Informa????es","Todas as informa????es de sua identidade.","player:identityFunctions","","others",true)
			exports["dynamic"]:AddButton("Desmanche","Listagem dos ve??culos.","dismantle:invokeDismantle","","others",true)
			exports["dynamic"]:AddButton("Comercializa????o","Iniciar/Finalizar venda de drogas.","drugs:toggleService","","others",false)

			if not IsPedInAnyVehicle(ped) then
				exports["dynamic"]:AddButton("Rebocar","Colocar ve??culo na prancha do reboque.","towdriver:invokeTow","","others",false)

				exports["dynamic"]:AddButton("Colocar no Ve??culo","Colocar no ve??culo mais pr??ximo.","player:cvFunctions","cv","otherPlayers",true)
				exports["dynamic"]:AddButton("Remover do Ve??culo","Remover do ve??culo mais pr??ximo.","player:cvFunctions","rv","otherPlayers",true)
				exports["dynamic"]:AddButton("Checar Porta-Malas","Vericar pessoa dentro do mesmo.","player:checkTrunk","","otherPlayers",true)

				exports["dynamic"]:SubMenu("Jogador","Pessoa mais pr??xima de voc??.","otherPlayers")
			else
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seatPlayer","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)

				exports["dynamic"]:SubMenu("Ve??culo","Fun????es do ve??culo.","vehicle")
			end

			exports["dynamic"]:AddButton("Propriedades","Ativa/Desativa as propriedades no mapa.","homes:togglePropertys","","propertys",false)

			exports["dynamic"]:SubMenu("Roupas","Mudan??a de roupas r??pidas.","outfit")
			
			exports["dynamic"]:SubMenu("Propriedades","Todas as fun????es das propriedades.","propertys")

			exports["dynamic"]:SubMenu("Outros","Todas as fun????es do personagem.","others")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function(source,args)
	if policeService or paramedicService then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				menuOpen = true

				exports["dynamic"]:AddButton("Servi??o","Verificar companheiros em servi??o.","player:servicoFunctions","","utilitys",true)

				if not IsPedInAnyVehicle(ped) then
					exports["dynamic"]:AddButton("Carregar pelos Bra??os","Carregar a pessoa mais pr??xima.","player:carryFunctions","bracos","player",true)
					exports["dynamic"]:AddButton("Carregar nos Ombros","Carregar a pessoa mais pr??xima.","player:carryFunctions","ombros","player",true)
					exports["dynamic"]:AddButton("Colocar no Ve??culo","Colocar no ve??culo mais pr??ximo.","player:cvFunctions","cv","player",true)
					exports["dynamic"]:AddButton("Remover do Ve??culo","Remover do ve??culo mais pr??ximo.","player:cvFunctions","rv","player",true)

					exports["dynamic"]:SubMenu("Jogador","Pessoa mais pr??xima de voc??.","player")
				end

				if policeService then
					exports["dynamic"]:AddButton("Computador","Abrir o dispositivo m??vel.","police:openSystem","","utilitys",false)
					exports["dynamic"]:AddButton("Barreira","Colocar barreira na frente.","police:insertBarrier","","utilitys",false)
					exports["dynamic"]:AddButton("Invadir","Invadir a resid??ncia.","homes:invadeSystem","","utilitys",true)

					exports["dynamic"]:AddButton("Remover Chap??u","Remover da pessoa mais pr??xima.","skinshop:removeProps","hat","player",true)
					exports["dynamic"]:AddButton("Remover M??scara","Remover da pessoa mais pr??xima.","skinshop:removeProps","mask","player",true)
					exports["dynamic"]:AddButton("Defusar","Desativar bomba do ve??culo.","races:defuseBomb","","player",true)

					exports["dynamic"]:AddButton("Sheriff","Fardamento de oficial.","player:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("State Police","Fardamento de oficial.","player:presetFunctions","2","prePolice",true)
					exports["dynamic"]:AddButton("State Park","Fardamento de oficial.","player:presetFunctions","3","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","player:presetFunctions","4","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","player:presetFunctions","5","prePolice",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:SubMenu("Utilidades","Todas as fun????es dos policiais.","utilitys")
				elseif paramedicService then
					exports["dynamic"]:AddButton("Medical Center","Fardamento de doutor.","player:presetFunctions","6","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de param??dico.","player:presetFunctions","7","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de param??dico interno.","player:presetFunctions","8","preMedic",true)
					exports["dynamic"]:AddButton("Fire Departament","Fardamento de atendimentos.","player:presetFunctions","9","preMedic",true)
					exports["dynamic"]:AddButton("Fire Departament","Fardamento de mergulhador.","player:presetFunctions","10","preMedic",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos m??dicos.","preMedic")
					exports["dynamic"]:SubMenu("Utilidades","Todas as fun????es dos param??dicos.","utilitys")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emerg??ncia.","keyboard","F10")