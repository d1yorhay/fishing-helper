script_name('Fishing Helper')
script_author('d1yorhay')
script_description('Скрипт который упрощает работу рыболовам')

local sampev = require "lib.samp.events"
local imgui = require "imgui"
local encoding = require 'encoding'
local fish = ""
local ehoid = 0
local idbait = 0
local ShowCursor = true


local word_actions = {
    Хлеб = function()
        idbait = 0
        fishrod()
    end,
    Червь = function()
        idbait = 1
        fishrod()
    end,
    Опарыш = function()
        idbait = 2
        fishrod()
    end,
    Лягушка = function()
        idbait = 3
        fishrod()
    end,
    Кукуруза = function()
        idbait = 4
        fishrod()
    end,
    Кузнечик = function()
        idbait = 5
        fishrod()
    end,
    Мотыль = function()
        idbait = 6
        fishrod()
    end,
    Муха = function()
        idbait = 7
        fishrod()
    end,
    Тесто = function()
        idbait = 8
        fishrod()
    end,
    Живец = function()
        idbait = 9
        fishrod()
    end,
    Икра = function()
        idbait = 10
        fishrod()
    end,
    Горох = function()
        idbait = 11
        fishrod()
    end,
    Личинка_короеда = function()
        idbait = 12
        fishrod()
    end,
    Подёнка = function()
        idbait = 13
        fishrod()
    end,
    Сыр = function()
        idbait = 14
        fishrod()
    end,
    Перловая_каша = function()
        idbait = 15
        fishrod()
    end,
    Манная_каша = function()
        idbait = 16
        fishrod()
    end,
    Личинка_майского_жука = function()
        idbait = 17
        fishrod()
    end,
    Личинка_ручейника = function()
        idbait = 18
        fishrod()
    end,
    Пиявка = function()
        idbait = 19
        fishrod()
    end,
    Овод = function()
        idbait = 20
        fishrod()
    end,
    Майский_жук = function()
        idbait = 21
        fishrod()
    end,
    Медведка = function()
        idbait = 22
        fishrod()
    end,
    Сверчок = function()
        idbait = 23
        fishrod()
    end,
    Креветка = function()
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
    "Хлеб",
    "Червь",
    "Опарыш",
    "Лягушка",
    "Кукуруза",
    "Кузнечик",
    "Мотыль",
    "Муха",
    "Тесто",
    "Живец",
    "Икра",
    "Горох",
    "Личинка_короеда",
    "Подёнка",
    "Сыр",
    "Перловая_каша",
    "Манная_каша",
    "Личинка_майского_жука",
    "Личинка_ручейника",
    "Пиявка",
    "Овод",
    "Майский_жук",
    "Медведка",
    "Сверчок",
    "Креветка"
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
        sampAddChatMessage("Пожалуйста нажмите на кнопку {006400}Укажите эхолот", -1)
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
            sampAddChatMessage('{640a64}Эхолот {ffffff}указан {00ffff}ID TextDraw: {ff0000}'..ehoid, -1)
            sampAddChatMessage('Теперь можете нажать на кнопку {006400}Обновить {ffffff}чтобы обновить список рыбы в воде.', -1)
            sampSendClickTextdraw(2111)
        end
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if title == "{BFBBBA}{73B461}Информация о рыбе" then
        fish1 = text:gsub("{.-}", ""):gsub("/", ""):gsub("Отсутствует", "")
        fish = fish1:gsub("Манная каша", "Манная_каша"):gsub("Личинка короеда", "Личинка_короеда"):gsub("Перловая каша", "Перловая_каша"):gsub("Личинка майского жука", "Личинка_майского_жука"):gsub("Личинка ручейника", "Личинка_ручейника"):gsub("Майский жук", "Майский_жук")
    end
end

function sampev.onServerMessage(color, text)
    if string.find(text, "поймал%(а%) рыбу") ~= nil then
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
    if imgui.Button(u8"Обновить") then
        Refresh()
        imgui.Process = false
        imgui.Process = true
    end
    if imgui.Button(u8("Укажите эхолот")) then
        modelidget()
        sampAddChatMessage("Теперь нажмите на {640a64}Эхолот {ffffff}в вашем инвентаре", -1)
        sampSendChat("/invent")
    end
    imgui.Text(u8("Включение/выключение мышки /mouse"))
    imgui.Text(u8("Активация деактивация скрипта /fishinghelp"))
    imgui.End()
end
