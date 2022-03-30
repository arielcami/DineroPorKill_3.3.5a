--[[ 
		Ariel Camilo // ariel.cami@gmail.com // 13 de noviembre 2021

		Funcionamiento bastante simple, modifica el valor de la X para que aporte esa cantidad en monedas de cobre:
		X=1: 1 de cobre por cada muerte.  X=10000: 1 de oro.

		No se recompensan los niveles que el jugador ve color gris o calavera.

		Se paga dos veces por muertes de élite.

		El dinero cae de manera individual, se lo lleva quien de el golpe de gracia 
		y los miembros del grupo no se benefician. (Pensando más en farmeo de oro particular.)
]]

local X = 25  -- Por defecto le dejo 25 de cobre por muerte, pero puedes poner el valor que quieras.

local function kill (evento, pj, npc)
local nivel = npc:GetLevel()
local reward = nivel*X -- Nivel del jugador multiplicado por la X del principio.
local resta, elite = (pj:GetLevel() - npc:GetLevel()), (reward*2)

	if npc:GetCreatureType() == 8 then pj:SendBroadcastMessage("|cffff0000No se recompensa matar alimañas.") return end --> No se recompensa matar alimañas.
	if kill then if (npc:IsWorldBoss() == true) then return else --> No hacer nada si muere un jefe. Esto para que se pueda tener un BossAnnouncer por separado.	

		if resta > 5 then pj:SendBroadcastMessage("|cffff0000No se recompensan las muertes fáciles...") return
	elseif resta < -9 then pj:SendBroadcastMessage("|cffff0000No se recompensan las muertes fuera de rango.") return 
		end	

	if pj:IsHonorOrXPTarget(npc) then
		if npc:IsElite() then
			if elite <= 99 then		
				pj:ModifyMoney(elite) pj:SendBroadcastMessage("|cff739affMuerte élite: |cfff2bb61+"..(elite).." de cobre.")
			elseif 
				elite >= 100 and elite <= 9999 then
				pj:ModifyMoney(elite) pj:SendBroadcastMessage("|cff739affMuerte élite: |cfff2bb61+"..(elite/100).." de plata.")
			elseif elite >= 10000 then
				pj:ModifyMoney(elite) pj:SendBroadcastMessage("|cff739affMuerte élite: |cfff2bb61+"..(elite/10000).." de oro.")
			end
		else
			if reward <= 99 then
				pj:ModifyMoney(reward) pj:SendBroadcastMessage("|cffd9d9d9Muerte normal: |cfff2bb61+"..(reward).." de cobre.")
			elseif 
				reward >= 100 and reward <= 9999 then
				pj:ModifyMoney(reward) pj:SendBroadcastMessage("|cffd9d9d9Muerte normal: |cfff2bb61+"..(reward/100).." de plata.")
			elseif reward >= 10000 then
				pj:ModifyMoney(reward) pj:SendBroadcastMessage("|cffd9d9d9Muerte normal: |cfff2bb61+"..(reward/10000).." de oro.")
				end 
			end
		end 
	end
	end  
end 
RegisterPlayerEvent (7, kill)
