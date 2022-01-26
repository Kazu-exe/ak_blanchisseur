Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local mainMenu = RageUI.CreateMenu("Taylor", "Oe c'est moi pour blanchir !")

function OpenMenu()
     if open then 
         open = false
         RageUI.Visible(mainMenu, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu, true)
         CreateThread(function()
         while open do 


            RageUI.IsVisible(mainMenu,function() 

				RageUI.Button("Blanchir de l'argent sale", "Jte prend ~r~50%~s~ de ton blanchiment !", {RightLabel = "→"}, true , {
					onSelected = function()
						local argent = KeyboardInput("Ta combien ?", '' , '', 8)
						TriggerServerEvent('akira:blanchiment', argent)	
					end
				})

            end)
          Wait(0)
         end
      end)
   end
end


Citizen.CreateThread(function()
    while true do
        NearZone = false

        for k,v in pairs(Config.position) do

				local interval = 1
            	local pos = GetEntityCoords(GetPlayerPed(-1), false)
            	local dest = vector3(v.x, v.y, v.z)
            	local distance = GetDistanceBetweenCoords(pos, dest, true)
            	if distance > 2 then
                	interval = 1
            	else
                	interval = 1

                	local dist = Vdist(pos.x, pos.y, pos.z, Config.position[k].x, Config.position[k].y, Config.position[k].z)
                	NearZone = true 

                	if distance < 3 then
                    	if not InAction then 
						Visual.Subtitle("Appuyer sur ~r~[E]~s~ pour parler a ~r~Taylor", 0) 
                    end
                    if IsControlJustReleased(1,51) then
                        OpenMenu()
                    end
                end
                break
            end
        end
        if not NearZone then 
            Wait(500)
        else
            Wait(1)
        end
    end
end)


Citizen.CreateThread(function()
    local hash = GetHashKey(Config.ped.pedtype)
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    for k,v in pairs(Config.ped) do
    ped = CreatePed("PED_TYPE_CIVMALE", Config.ped.pedtype, v.x, v.y, v.z, v.a, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    end
end)
