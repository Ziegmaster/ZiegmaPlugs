DebugWindow = class (LPELotroWindow);

function DebugWindow:Constructor()

    LPELotroWindow.Constructor(self);

    self:SetSize(500, 400);
    self:SetText(Texts.UI.Buttons.Debug);
    local sizeX, sizeY = self:GetSize();
    self:SetPosition(Turbine.UI.Display:GetWidth()/2 - sizeX/2, Turbine.UI.Display:GetHeight()/2 - sizeY/2);
    self:SetVisible(false);

    self.Label = Turbine.UI.Label();
    self.Label:SetSize(450, 350);
    self.Label:SetParent(self);
    self.Label:SetPosition(25, 25);
    self.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Label:SetWantsUpdates(true);
    self.Label:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
    self:SetResizable(true);

    AddListener(self, "SizeChanged", function ()
        local x, y = self:GetSize();
        self.Label:SetSize(x - 50, y - 50);
    end);

end

UI.DebugWindow = DebugWindow();