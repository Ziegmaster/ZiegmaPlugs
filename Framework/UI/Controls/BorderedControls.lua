--This is designed for static UI elements so no change size functionality

Framework.UI.Controls.BorderedControl = class(Turbine.UI.Control);

function Framework.UI.Controls.BorderedControl:Constructor(size_x, size_y, border_width, border_color)

    Turbine.UI.Control.Constructor(self);

    self:SetSize(size_x, size_y);

    self.BorderColor = border_color;

    self.BorderLeft = Turbine.UI.Control();
    self.BorderLeft:SetParent(self);
    self.BorderLeft:SetSize(border_width, size_y);
    self.BorderLeft:SetPosition(0, 0);
    self.BorderLeft:SetBackColor(self.BorderColor);

    self.BorderRight = Turbine.UI.Control();
    self.BorderRight:SetParent(self);
    self.BorderRight:SetSize(border_width, size_y);
    self.BorderRight:SetPosition(size_x - border_width, 0);
    self.BorderRight:SetBackColor(self.BorderColor);

    self.BorderTop = Turbine.UI.Control();
    self.BorderTop:SetParent(self);
    self.BorderTop:SetSize(size_x, border_width);
    self.BorderTop:SetPosition(0, 0);
    self.BorderTop:SetBackColor(self.BorderColor);

    self.BorderBottom = Turbine.UI.Control();
    self.BorderBottom:SetParent(self);
    self.BorderBottom:SetSize(size_x, border_width);
    self.BorderBottom:SetPosition(0, size_y - border_width);
    self.BorderBottom:SetBackColor(self.BorderColor);

end

Framework.UI.Controls.BorderedWindow = class(Turbine.UI.Window);

function Framework.UI.Controls.BorderedWindow:Constructor(size_x, size_y, border_width, border_color)

    Turbine.UI.Window.Constructor(self);

    self:SetSize(size_x, size_y);

    self.BorderColor = border_color;

    self.BorderLeft = Turbine.UI.Control();
    self.BorderLeft:SetParent(self);
    self.BorderLeft:SetSize(border_width, size_y);
    self.BorderLeft:SetPosition(0, 0);
    self.BorderLeft:SetBackColor(self.BorderColor);

    self.BorderRight = Turbine.UI.Control();
    self.BorderRight:SetParent(self);
    self.BorderRight:SetSize(border_width, size_y);
    self.BorderRight:SetPosition(size_y - border_width, 0);
    self.BorderRight:SetBackColor(self.BorderColor);

    self.BorderTop = Turbine.UI.Control();
    self.BorderTop:SetParent(self);
    self.BorderTop:SetSize(size_x, border_width);
    self.BorderTop:SetPosition(0, 0);
    self.BorderTop:SetBackColor(self.BorderColor);

    self.BorderBottom = Turbine.UI.Control();
    self.BorderBottom:SetParent(self);
    self.BorderBottom:SetSize(size_x, border_width);
    self.BorderBottom:SetPosition(0, size_y - border_width);
    self.BorderBottom:SetBackColor(self.BorderColor);

end

