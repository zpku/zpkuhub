--[[
    Zpk Hub v1.0
    Interface compacta
    Tema: Roxo / Preto
    Criado para: Zpk
    Funções desta versão: interface e preferências locais
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove versão anterior
local old = PlayerGui:FindFirstChild("ZpkHub")
if old then old:Destroy() end

-- Cores
local Purple = Color3.fromRGB(145, 35, 255)
local Dark = Color3.fromRGB(15, 12, 23)
local Panel = Color3.fromRGB(25, 20, 36)
local White = Color3.fromRGB(245, 240, 255)
local Gray = Color3.fromRGB(170, 155, 190)

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ZpkHub"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(440, 290)
Main.Position = UDim2.new(0.5, -220, 0.5, -145)
Main.BackgroundColor3 = Dark
Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Purple
Stroke.Thickness = 1.5
Stroke.Parent = Main

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = Panel
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -95, 1, 0)
Title.Position = UDim2.fromOffset(14, 0)
Title.BackgroundTransparency = 1
Title.Text = "♛  Zpk Hub"
Title.TextColor3 = White
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(32, 30)
Minimize.Position = UDim2.new(1, -76, 0, 9)
Minimize.BackgroundColor3 = Purple
Minimize.Text = "—"
Minimize.TextColor3 = White
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.Parent = Header
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 7)

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(32, 30)
Close.Position = UDim2.new(1, -38, 0, 9)
Close.BackgroundColor3 = Color3.fromRGB(90, 25, 110)
Close.Text = "X"
Close.TextColor3 = White
Close.Font = Enum.Font.GothamBold
Close.TextSize = 15
Close.Parent = Header
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 7)

-- Arrastar janela (pelo cabeçalho)
local dragging = false
local dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

local moveConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local endConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Desconecta os eventos se a GUI for removida
Gui.Destroying:Connect(function()
    moveConn:Disconnect()
    endConn:Disconnect()
end)

-- Menu lateral
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 112, 1, -58)
Sidebar.Position = UDim2.fromOffset(8, 54)
Sidebar.BackgroundColor3 = Panel
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

-- Conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -138, 1, -66)
Content.Position = UDim2.fromOffset(128, 56)
Content.BackgroundColor3 = Panel
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local PageTitle = Instance.new("TextLabel")
PageTitle.Size = UDim2.new(1, -20, 0, 36)
PageTitle.Position = UDim2.fromOffset(12, 8)
PageTitle.BackgroundTransparency = 1
PageTitle.Text = "Início"
PageTitle.TextColor3 = White
PageTitle.Font = Enum.Font.GothamBold
PageTitle.TextSize = 18
PageTitle.TextXAlignment = Enum.TextXAlignment.Left
PageTitle.Parent = Content

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1, -24, 1, -60)
Description.Position = UDim2.fromOffset(12, 52)
Description.BackgroundTransparency = 1
Description.TextWrapped = true
Description.TextYAlignment = Enum.TextYAlignment.Top
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.TextColor3 = Gray
Description.Font = Enum.Font.Gotham
Description.TextSize = 13
Description.Parent = Content

local pages = {
    ["Início"] = "Bem-vindo ao Zpk Hub!\n\nVersão: 1.0\nCriado especialmente para você.\n\nStatus: Interface carregada.",
    ["Player"] = "PLAYER\n\nConfigurações de movimento e personagem.\n\nAlterações de velocidade e pulo ficam disponíveis apenas em experiências próprias ou autorizadas.",
    ["Farm"] = "FARM\n\nPainel de automação.\n\nNenhuma ação automática será executada sem integração autorizada com o jogo.",
    ["Poderes"] = "PODERES\n\nÁrea para consultar e organizar seus poderes.\n\nSem interferir nos dados de outros jogadores.",
    ["Visual"] = "VISUAL\n\nPersonalize as opções visuais do Zpk Hub.",
    ["Config"] = "CONFIGURAÇÕES\n\nZpk Hub v1.0\nInterface compacta\nTema roxo."
}

local function ShowPage(name)
    PageTitle.Text = name
    Description.Text = pages[name] or "Página não encontrada."
end

-- Botões das abas
local tabs = {"Início", "Player", "Farm", "Poderes", "Visual", "Config"}
local tabButtons = {}

local function SelectTab(name)
    for tabName, button in pairs(tabButtons) do
        button.BackgroundColor3 = (tabName == name) and Purple or Dark
    end
    ShowPage(name)
end

for i, name in ipairs(tabs) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -12, 0, 32)
    Button.Position = UDim2.fromOffset(6, 8 + (i - 1) * 38)
    Button.BackgroundColor3 = Dark
    Button.Text = name
    Button.TextColor3 = White
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 12
    Button.Parent = Sidebar

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    tabButtons[name] = Button

    Button.MouseButton1Click:Connect(function()
        SelectTab(name)
    end)
end

SelectTab("Início")

-- Botão flutuante para reabrir
local Reopen = Instance.new("TextButton")
Reopen.Size = UDim2.fromOffset(105, 38)
Reopen.Position = UDim2.new(0, 15, 0.5, 0)
Reopen.BackgroundColor3 = Dark
Reopen.Text = "♛ Zpk Hub"
Reopen.TextColor3 = White
Reopen.Font = Enum.Font.GothamBold
Reopen.TextSize = 13
Reopen.Visible = false
Reopen.Parent = Gui

Instance.new("UICorner", Reopen).CornerRadius = UDim.new(0, 9)

local ReopenStroke = Instance.new("UIStroke")
ReopenStroke.Color = Purple
ReopenStroke.Thickness = 1.5
ReopenStroke.Parent = Reopen

-- Minimizar e restaurar
local minimized = false

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    Sidebar.Visible = not minimized
    Content.Visible = not minimized

    Main.Size = minimized
        and UDim2.fromOffset(220, 48)
        or UDim2.fromOffset(440, 290)

    Minimize.Text = minimized and "+" or "—"
end)

-- Fechar (esconde a janela e mostra o botão flutuante)
Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Reopen.Visible = true
end)

-- Reabrir
Reopen.MouseButton1Click:Connect(function()
    Main.Visible = true
    Reopen.Visible = false
    minimized = false
    Sidebar.Visible = true
    Content.Visible = true
    Main.Size = UDim2.fromOffset(440, 290)
    Minimize.Text = "—"
end)

print("Zpk Hub v1.0 carregado com sucesso!")
