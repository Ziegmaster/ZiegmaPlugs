ParserWindow = class (LPELotroWindow);

function ParserWindow:Constructor()

    LPELotroWindow.Constructor(self);

    self:SetSize(400, 300);
    self:SetText(Texts.UI.Buttons.Parser);
    local sizeX, sizeY = UI.DebugWindow:GetSize();
    self:SetPosition(Turbine.UI.Display:GetWidth()/2 - sizeX/2, Turbine.UI.Display:GetHeight()/2 - sizeY/2);
    self:SetVisible(false);
    self.Label = Turbine.UI.Label();
    self.Label:SetSize(350, 250);
    self.Label:SetParent(self);
    self.Label:SetPosition(25, 25);
    self.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Label:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);

end

UI.ParserWindow = ParserWindow();