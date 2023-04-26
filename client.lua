local elements = {
  {label = "¿Cómo te llamas?", value = 1},
  {label = "¿Qué edad tienes Hung?", value = 2},
  {label = "¿Puedo golpearte?", value = 3},
}

RegisterCommand('testing_ia',function()
  local npc = exports['rep-talkNPC']:CreateNPC({
		npc = 'u_m_y_abner',
		coords =  GetEntityCoords(PlayerPedId()) - vector3(0.5, 0.5, 1.0),
		heading = 160.0,
		name = 'Hung Ngo',
		animName ="mini@strip_club@idles@bouncer@base",
		animDist = "base",
        startMSG = 'Hola soy desarrollador Front End'
	}, elements, function(ped, data, menu)
        Boss = ped
        if data then
          if data.value == 1 then
            local response_ia = lib.callback.await('mk-npcIA:getResponse', false,elements[data.value].label)
            menu.addMessage({msg = response_ia, from = "npc"})
          elseif data.value == 2 then
            local response_ia = lib.callback.await('mk-npcIA:getResponse', false,elements[data.value].label)
            menu.addMessage({msg = response_ia, from = "npc"})
          elseif data.value == 3 then
            local response_ia = lib.callback.await('mk-npcIA:getResponse', false,elements[data.value].label)
            menu.addMessage({msg = response_ia, from = "npc"})
          end
        end
    end)
end)
