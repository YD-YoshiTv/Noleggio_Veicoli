ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("paga", function(prezzo)
    print(prezzo)
    exports.ox_inventory:RemoveItem(source, 'money', prezzo - 100, false, false)
end)
