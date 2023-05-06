ESX = exports["es_extended"]:getSharedObject()

-- MODELLO PED --
Citizen.CreateThread(function()
  if not HasModelLoaded('ig_bankman') then
     RequestModel('ig_bankman')
     while not HasModelLoaded('ig_bankman') do
        Citizen.Wait(5)
     end
  end

npc = CreatePed(4, 'ig_bankman', 212.6511, -811.3740, 29.7638, 159.5678, false, true)
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)
end)

-- CODICE BLIP GRIDSYSTEM --
Citizen.CreateThread(function()
  for yd,noleggio in pairs(Config.noleggioveicoli) do
      TriggerEvent('gridsystem:registerMarker', {
          name = 'noleggioveicoli'..noleggio.x,
          pos = vector3(noleggio.x, noleggio.y, noleggio.z),
          size = vector3(2.1,2.1,2.1),
          scale = vector3(0.4, 0.4, 0.4),
          color =  { r = 241, g = 101, b = 34 },
          drawDistance = 10.0,
          msg = '',
          control = 'E',
          type = 2,
          action = function()
            lib.registerContext({
              id = 'menu',
              title = 'YD DEV NOLEGGIO',
              options = {
                {
                  title = 'COPYRIGHT YD DEV',
                },
                {
                  title = 'Noloeggio Bici',
                  description = 'Scegli la bici che vuoi noleggiare',
                  onSelect = function()
                    menu2()
                  end,
                  icon = 'bars'
                },
                {
                  title = 'Noloeggio Moto',
                  description = 'Scegli la moto che vuoi noleggiare',
                  onSelect = function()
                    menu3()
                  end,
                  icon = 'bars'
                },
              }
            })
            lib.showContext('menu')
          end,
          onEnter = function()
            lib.showTextUI('[E] - Noleggio Veicoli', {
              position = "right-center",
              icon = 'car',
              style = {
                  borderRadius = 12,
                  backgroundColor = '#FF8C00',
                  color = 'white'
              }
          })
          end,
          onExit = function()
            lib.hideTextUI()
          end
      })
  end
  end)

-- CODICE NOLEGGIO --
function menu2()
  lib.registerContext({
    id = 'menu',
    title = 'NOLEGGIO BICI',
    options = {
      {
        title = 'Bici Scorcher',
        icon = 'bicycle',
        onSelect = function()
          bici1()
        end,
      },
      {
        title = 'Bici BMX',
        icon = 'bicycle',
        onSelect = function()
          bici2()
        end,
      },
    }
  })
  lib.showContext('menu')
end

function menu3()
  lib.registerContext({
    id = 'menu',
    title = 'NOLEGGIO MOTO',
    options = {
      {
        title = 'Moto Sanchez',
        icon = 'motorcycle',
        onSelect = function()
          moto1()
        end,
      },
      {
        title = 'Moto Bf400',
        icon = 'motorcycle',
        onSelect = function()
          moto2()
        end,
      },
    }
  })
  lib.showContext('menu')
end

function bici1()
  local soldi = exports.ox_inventory:Search('count', 'money')

  local input = lib.inputDialog('YD DEV NOLEGGIO', {
    {type = 'input', label = 'Inserisci Il Tempo', description = 'Quanto tempo vuoi noleggiare il tuo veicolo ?'},
    {type = 'checkbox', label = 'Conferma Acquisto'},
  })
  local tempo = input[1] * 60000

if input[2] then
  if soldi >= Config.PrezzoBici.bici1 then
      if ESX.Game.IsSpawnPointClear(vector3(214.1801, -793.3534, 30.8486), 1) then
          ESX.Game.SpawnVehicle(Config.NomiBici.bici1, vector3(214.1801, -793.3534, 30.8486), 157.0892, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Hai pagato '..Config.PrezzoBici.bici1..'$',
              type = 'success'
            })
            print('hai pagato '..Config.PrezzoBici.bici1..'$')
            TriggerServerEvent('paga', Config.PrezzoBici.bici1)
            if lib.progressCircle({
              duration = tempo,
              position = 'botton',
              useWhileDead = false,
              canCancel = true,
            }) then DeleteEntity(vehicle) end
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Il tuo tempo è terminato',
              type = 'info'
          })
          print('hai terminato il tempo')
          end)
      else
            lib.notify({
                title = 'YD DEV NOLEGGIO',
                description = 'Posto Occupato',
                type = 'error'
            })
            print('il posto è occupato')
      end
  else
      lib.notify({
          title = 'YD DEV NOLEGGIO',
          description = 'Non hai abbastanza soldi',
          type = 'error'
      })
      print('non hai abbastanza soldi')
  end
end
end

function bici2()
  local soldi = exports.ox_inventory:Search('count', 'money')

  local input = lib.inputDialog('YD DEV NOLEGGIO', {
    {type = 'input', label = 'Inserisci Il Tempo', description = 'Quanto tempo vuoi noleggiare il tuo veicolo ?'},
    {type = 'checkbox', label = 'Conferma Acquisto'},
  })
  local tempo = input[1] * 60000

if input[2] then
  if soldi >= Config.PrezzoBici.bici2 then
      if ESX.Game.IsSpawnPointClear(vector3(214.1801, -793.3534, 30.8486), 1) then
          ESX.Game.SpawnVehicle(Config.NomiBici.bici2, vector3(214.1801, -793.3534, 30.8486), 157.0892, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Hai pagato '..Config.PrezzoBici.bici1..'$',
              type = 'success'
            })
            print('Hai pagato '..Config.PrezzoBici.bici1..'$')
            TriggerServerEvent('paga', Config.PrezzoBici.bici2)
            if lib.progressCircle({
              duration = tempo,
              position = 'bottom',
              useWhileDead = false,
              canCancel = true,
            }) then DeleteEntity(vehicle) end
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Il tuo tempo è terminato',
              type = 'info'
          })
          print('hai terminato il tempo')
          end)
      else
            lib.notify({
                title = 'YD DEV NOLEGGIO',
                description = 'Posto Occupato',
                type = 'error'
            })
            print('il posto è occupato')
      end
  else
      lib.notify({
          title = 'YD DEV NOLEGGIO',
          description = 'Non hai abbastanza soldi',
          type = 'error'
      })
      print('non hai abbastanza soldi')
  end
end
end

function moto1()
  local soldi = exports.ox_inventory:Search('count', 'money')

  local input = lib.inputDialog('YD DEV NOLEGGIO', {
    {type = 'input', label = 'Inserisci Il Tempo', description = 'Quanto tempo vuoi noleggiare il tuo veicolo ?'},
    {type = 'checkbox', label = 'Conferma Acquisto'},
  })
  local tempo = input[1] * 60000

if input[2] then
  if soldi >= Config.PrezzoMoto.moto1 then
      if ESX.Game.IsSpawnPointClear(vector3(214.1801, -793.3534, 30.8486), 1) then
          ESX.Game.SpawnVehicle(Config.NomiMoto.moto1, vector3(214.1801, -793.3534, 30.8486), 157.0892, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Hai pagato '..Config.PrezzoMoto.moto1..'$',
              type = 'success'
            })
            print('Hai pagato '..Config.PrezzoMoto.moto1..'$')
            TriggerServerEvent('paga', Config.PrezzoMoto.moto1)
            if lib.progressCircle({
              duration = tempo,
              position = 'bottom',
              useWhileDead = false,
              canCancel = true,
            }) then DeleteEntity(vehicle) end
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Il tuo tempo è terminato',
              type = 'info'
          })
          print('hai terminato il tempo')
          end)
      else
            lib.notify({
                title = 'YD DEV NOLEGGIO',
                description = 'Posto Occupato',
                type = 'error'
            })
            print('il posto è occupato')
      end
  else
      lib.notify({
          title = 'YD DEV NOLEGGIO',
          description = 'Non hai abbastanza soldi',
          type = 'error'
      })
      print('non hai abbastanza soldi')
  end
end
end

function moto2()
  local soldi = exports.ox_inventory:Search('count', 'money')

  local input = lib.inputDialog('YD DEV NOLEGGIO', {
    {type = 'input', label = 'Inserisci Il Tempo', description = 'Quanto tempo vuoi noleggiare il tuo veicolo ?'},
    {type = 'checkbox', label = 'Conferma Acquisto'},
  })
  local tempo = input[1] * 60000

if input[2] then
  if soldi >= Config.PrezzoMoto.moto2 then
      if ESX.Game.IsSpawnPointClear(vector3(214.1801, -793.3534, 30.8486), 1) then
          ESX.Game.SpawnVehicle(Config.NomiMoto.moto2, vector3(214.1801, -793.3534, 30.8486), 157.0892, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Hai pagato '..Config.PrezzoMoto.moto2..'$',
              type = 'success'
            })
            print('Hai pagato '..Config.PrezzoMoto.moto2..'$')
            TriggerServerEvent('paga', Config.PrezzoMoto.moto2)
            if lib.progressCircle({
              duration = tempo,
              position = 'bottom',
              useWhileDead = false,
              canCancel = true,
            }) then DeleteEntity(vehicle) end
            lib.notify({
              title = 'YD DEV NOLEGGIO',
              description = 'Il tuo tempo è terminato',
              type = 'info'
          })
          print('hai terminato il tempo')
          end)
      else
            lib.notify({
                title = 'YD DEV NOLEGGIO',
                description = 'Posto Occupato',
                type = 'error'
            })
            print('il posto è occupato')
      end
  else
      lib.notify({
          title = 'YD DEV NOLEGGIO',
          description = 'Non hai abbastanza soldi',
          type = 'error'
      })
      print('non hai abbastanza soldi')
  end
end
end