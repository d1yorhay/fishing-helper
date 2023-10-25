script_name('Fishing Helper')
script_author('d1yorhay')
script_description('Ñêðèïò êîòîðûé óïðîùàåò ðàáîòó ðûáîëîâàì')

local sampev = require "lib.samp.events"
local imgui = require "imgui"
local encoding = require 'encoding'
local fish = ""
local ehoid = 0
local idbait = 0
local ShowCursor = true


local word_actions = {
    Õëåá = function()
        idbait = 0
        fishrod()
    end,
    ×åðâü = function()
        idbait = 1
        fishrod()
    end,
    Îïàðûø = function()
        idbait = 2
        fishrod()
    end,
    Ëÿãóøêà = function()
        idbait = 3
        fishrod()
    end,
    Êóêóðóçà = function()
        idbait = 4
        fishrod()
    end,
    Êóçíå÷èê = function()
        idbait = 5
        fishrod()
    end,
    Ìîòûëü = function()
        idbait = 6
        fishrod()
    end,
    Ìóõà = function()
        idbait = 7
        fishrod()
    end,
    Òåñòî = function()
        idbait = 8
        fishrod()
    end,
    Æèâåö = function()
        idbait = 9
        fishrod()
    end,
    Èêðà = function()
        idbait = 10
        fishrod()
    end,
    Ãîðîõ = function()
        idbait = 11
        fishrod()
    end,
    Ëè÷èíêà_êîðîåäà = function()
        idbait = 12
        fishrod()
    end,
    Ïîä¸íêà = function()
        idbait = 13
        fishrod()
    end,
    Ñûð = function()
        idbait = 14
        fishrod()
    end,
    Ïåðëîâàÿ_êàøà = function()
        idbait = 15
        fishrod()
    end,
    Ìàííàÿ_êàøà = function()
        idbait = 16
        fishrod()
    end,
    Ëè÷èíêà_ìàéñêîãî_æóêà = function()
        idbait = 17
        fishrod()
    end,
    Ëè÷èíêà_ðó÷åéíèêà = function()
        idbait = 18
        fishrod()
    end,
    Ïèÿâêà = function()
        idbait = 19
        fishrod()
    end,
    Îâîä = function()
        idbait = 20
        fishrod()
    end,
    Ìàéñêèé_æóê = function()
        idbait = 21
        fishrod()
    end,
    Ìåäâåäêà = function()
        idbait = 22
        fishrod()
    end,
    Ñâåð÷îê = function()
        idbait = 23
        fishrod()
    end,
    Êðåâåòêà = function()
        idbait = 24
        fishrod()
    end
}
function fishinghelp()
    if imgui.Process == false then
        imgui.Process = true
    elseif imgui.Process == true then
        imgui.Process = false
    end
end
function fishrod()
    lua_thread.create(function()
        sampSendChat('/fishrod')
            sampSendDialogResponse(25286, 1, 6, 0)
            wait(200)
            sampSendDialogResponse(25287, 1, idbait, 0)
            wait(200)
            sampCloseCurrentDialogWithButton()
            wait(200)
            sampCloseCurrentDialogWithButton()
            wait(200)
            sampCloseCurrentDialogWithButton()
            wait(200)
            sampCloseCurrentDialogWithButton()
    end)
end

encoding.default = 'CP1251'
u8 = encoding.UTF8
local bait_variation = {
    "Õëåá",
    "×åðâü",
    "Îïàðûø",
    "Ëÿãóøêà",
    "Êóêóðóçà",
    "Êóçíå÷èê",
    "Ìîòûëü",
    "Ìóõà",
    "Òåñòî",
    "Æèâåö",
    "Èêðà",
    "Ãîðîõ",
    "Ëè÷èíêà_êîðîåäà",
    "Ïîä¸íêà",
    "Ñûð",
    "Ïåðëîâàÿ_êàøà",
    "Ìàííàÿ_êàøà",
    "Ëè÷èíêà_ìàéñêîãî_æóêà",
    "Ëè÷èíêà_ðó÷åéíèêà",
    "Ïèÿâêà",
    "Îâîä",
    "Ìàéñêèé_æóê",
    "Ìåäâåäêà",
    "Ñâåð÷îê",
    "Êðåâåòêà"
}

function main()
    imgui.Process = true
    sampRegisterChatCommand('mouse', mouse)
    sampRegisterChatCommand('fishinghelp', fishinghelp)
end

function mouse()
    if ShowCursor == false then
        imgui.ShowCursor = true
        ShowCursor = true
        print("mouse on")
    elseif ShowCursor == true then
        imgui.ShowCursor = false
        ShowCursor = false
        print("mouse off")
    end
end

function Refresh()
    if ehoid == 0 then
        sampAddChatMessage("Ïîæàëóéñòà íàæìèòå íà êíîïêó {006400}Óêàæèòå ýõîëîò", -1)
    else
        lua_thread.create(function()
            sampSendChat('/invent')
            wait(200)
            sampSendClickTextdraw(ehoid)
            wait(200)
            sampSendClickTextdraw(2302)
            wait(200)
            sampSendClickTextdraw(2111)
            wait(200)
            sampSendDialogResponse(26123, 1, 0, 0)
            wait(200)
            sampCloseCurrentDialogWithButton()
        end)
    end
    
end



function modelidget()
    function sampev.onSendClickTextDraw(id)
        local model = sampTextdrawGetModelRotationZoomVehColor(id)
        if model == 18875 then
            ehoid = id
            sampAddChatMessage('{640a64}Ýõîëîò {ffffff}óêàçàí {00ffff}ID TextDraw: {ff0000}'..ehoid, -1)
            sampAddChatMessage('Òåïåðü ìîæåòå íàæàòü íà êíîïêó {006400}Îáíîâèòü {ffffff}÷òîáû îáíîâèòü ñïèñîê ðûáû â âîäå.', -1)
            sampSendClickTextdraw(2111)
        end
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if title == "{BFBBBA}{73B461}Èíôîðìàöèÿ î ðûáå" then
        fish1 = text:gsub("{.-}", ""):gsub("/", ""):gsub("Îòñóòñòâóåò", "")
        fish = fish1:gsub("Ìàííàÿ êàøà", "Ìàííàÿ_êàøà"):gsub("Ëè÷èíêà êîðîåäà", "Ëè÷èíêà_êîðîåäà"):gsub("Ïåðëîâàÿ êàøà", "Ïåðëîâàÿ_êàøà"):gsub("Ëè÷èíêà ìàéñêîãî æóêà", "Ëè÷èíêà_ìàéñêîãî_æóêà"):gsub("Ëè÷èíêà ðó÷åéíèêà", "Ëè÷èíêà_ðó÷åéíèêà"):gsub("Ìàéñêèé æóê", "Ìàéñêèé_æóê")
    end 
end

function sampev.onServerMessage(color, text)
    if string.find(text, "ïîéìàë%(à%) ðûáó") ~= nil then
        Refresh()
    end
      
end

function imgui.OnDrawFrame()
    
    imgui.Begin("Fishing Helper by d1yorhay", variable, imgui.WindowFlags.AlwaysAutoResize)
    
    local words_in_fish = {}
    for word in string.gmatch(fish, "%S+") do
      table.insert(words_in_fish, word)
    end
    
    for i, word in ipairs(words_in_fish) do
      local found = false
      for j, w in ipairs(bait_variation) do
        if string.find(word, w) then
          found = true
          break
        end
      end
      
      if found or string.find(word, "%s") then
        imgui.SameLine()
        if imgui.Button(u8(word)) then
            word_actions[word]()
        end
      else
        if string.find(word, ":") then
        elseif string.find(word, "%d+%.") then
          imgui.Text(u8(word))
        else
          imgui.SameLine()
          imgui.Text(u8(word))
        end
      end
    end
    if imgui.Button(u8"Îáíîâèòü") then
        Refresh()
        imgui.Process = false
        imgui.Process = true
    end
    if imgui.Button(u8("Óêàæèòå ýõîëîò")) then
        modelidget()
        sampAddChatMessage("Òåïåðü íàæìèòå íà {640a64}Ýõîëîò {ffffff}â âàøåì èíâåíòàðå", -1)
        sampSendChat("/invent")
    end
    imgui.Text(u8("Âêëþ÷åíèå/âûêëþ÷åíèå ìûøêè /mouse"))
    imgui.Text(u8("Àêòèâàöèÿ äåàêòèâàöèÿ ñêðèïòà /fishinghelp"))
    imgui.End()
end
