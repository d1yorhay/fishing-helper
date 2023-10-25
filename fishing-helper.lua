script_name('Fishing Helper')
script_author('d1yorhay')
script_description('������ ������� �������� ������ ���������')

local sampev = require "lib.samp.events"
local imgui = require "imgui"
local encoding = require 'encoding'
local fish = ""
local ehoid = 0
local idbait = 0
local ShowCursor = true


local word_actions = {
    ���� = function()
        idbait = 0
        fishrod()
    end,
    ����� = function()
        idbait = 1
        fishrod()
    end,
    ������ = function()
        idbait = 2
        fishrod()
    end,
    ������� = function()
        idbait = 3
        fishrod()
    end,
    �������� = function()
        idbait = 4
        fishrod()
    end,
    �������� = function()
        idbait = 5
        fishrod()
    end,
    ������ = function()
        idbait = 6
        fishrod()
    end,
    ���� = function()
        idbait = 7
        fishrod()
    end,
    ����� = function()
        idbait = 8
        fishrod()
    end,
    ����� = function()
        idbait = 9
        fishrod()
    end,
    ���� = function()
        idbait = 10
        fishrod()
    end,
    ����� = function()
        idbait = 11
        fishrod()
    end,
    �������_������� = function()
        idbait = 12
        fishrod()
    end,
    ������ = function()
        idbait = 13
        fishrod()
    end,
    ��� = function()
        idbait = 14
        fishrod()
    end,
    ��������_���� = function()
        idbait = 15
        fishrod()
    end,
    ������_���� = function()
        idbait = 16
        fishrod()
    end,
    �������_��������_���� = function()
        idbait = 17
        fishrod()
    end,
    �������_��������� = function()
        idbait = 18
        fishrod()
    end,
    ������ = function()
        idbait = 19
        fishrod()
    end,
    ���� = function()
        idbait = 20
        fishrod()
    end,
    �������_��� = function()
        idbait = 21
        fishrod()
    end,
    �������� = function()
        idbait = 22
        fishrod()
    end,
    ������� = function()
        idbait = 23
        fishrod()
    end,
    �������� = function()
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
    "����",
    "�����",
    "������",
    "�������",
    "��������",
    "��������",
    "������",
    "����",
    "�����",
    "�����",
    "����",
    "�����",
    "�������_�������",
    "������",
    "���",
    "��������_����",
    "������_����",
    "�������_��������_����",
    "�������_���������",
    "������",
    "����",
    "�������_���",
    "��������",
    "�������",
    "��������"
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
        sampAddChatMessage("���������� ������� �� ������ {006400}������� ������", -1)
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
            sampAddChatMessage('{640a64}������ {ffffff}������ {00ffff}ID TextDraw: {ff0000}'..ehoid, -1)
            sampAddChatMessage('������ ������ ������ �� ������ {006400}�������� {ffffff}����� �������� ������ ���� � ����.', -1)
            sampSendClickTextdraw(2111)
        end
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if title == "{BFBBBA}{73B461}���������� � ����" then
        fish1 = text:gsub("{.-}", ""):gsub("/", ""):gsub("�����������", "")
        fish = fish1:gsub("������ ����", "������_����"):gsub("������� �������", "�������_�������"):gsub("�������� ����", "��������_����"):gsub("������� �������� ����", "�������_��������_����"):gsub("������� ���������", "�������_���������"):gsub("������� ���", "�������_���")
    end
end

function sampev.onServerMessage(color, text)
    if string.find(text, "������%(�%) ����") ~= nil then
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
    if imgui.Button(u8"��������") then
        Refresh()
        imgui.Process = false
        imgui.Process = true
    end
    if imgui.Button(u8("������� ������")) then
        modelidget()
        sampAddChatMessage("������ ������� �� {640a64}������ {ffffff}� ����� ���������", -1)
        sampSendChat("/invent")
    end
    imgui.Text(u8("���������/���������� ����� /mouse"))
    imgui.Text(u8("��������� ����������� ������� /fishinghelp"))
    imgui.End()
end
