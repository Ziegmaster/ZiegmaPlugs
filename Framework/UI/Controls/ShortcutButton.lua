--Shortcut Button By Ziegmaster

import "Turbine.UI";

Framework.UI.Controls.ShortcutButton = class (Turbine.UI.Control);

function Framework.UI.Controls.ShortcutButton:Constructor()

    Turbine.UI.Control.Constructor(self);

	self.enabledForeColor = Framework.UI.Controls.Colors.controlColor;

	self.enabledBackColorPressed = Turbine.UI.Color(.4, 40/255, 67/255, 200/255);
	self.enabledBackColorDefault = Turbine.UI.Color(1, 40/255, 67/255, 122/255);
	self.enabledBackColorHover = Turbine.UI.Color(.7, 180/255, 67/255, 200/255);

	self:SetSize(100, 20);

	self.Background = Turbine.UI.Control();
	self.Background:SetParent(self);
	self.Background:SetSize(100, 20);
	self.Background:SetBackColor(Turbine.UI.Color(.2, .2, .2));
	self.Background:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

	self.Button = Turbine.UI.Control();
	self.Button:SetSize(100, 20);
	self.Button:SetParent(self);
	self.Button:SetBackColor(self.enabledBackColorDefault);
	self.Button:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

	self.Button.Label = Turbine.UI.Label();
	self.Button.Label:SetParent(self);
	self.Button.Label:SetSize(100, 20);
	self.Button.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.Button.Label:SetMultiline(false);
	self.Button.Label:SetMouseVisible(false);
	self.Button.Label:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	self.Button.Label:SetForeColor(Turbine.UI.Color(0.95, 0.85, 0.55));
	
	self.MouseEnter = function(sender, args)
		self:SyncControls();
	end
	
	self.chatSendWindow = Turbine.UI.Window();
	self.chatSendWindow:SetSize(100, 20);
	self.chatSendWindow:SetOpacity(0);
	self.chatSendWindow:SetMouseVisible(true);
	self.chatSendWindow:SetVisible(true);
	
	self.chatSend = Turbine.UI.Lotro.Quickslot();
	self.chatSend:SetParent(self.chatSendWindow);
	self.chatSend:SetSize(100, 20);
	self.chatSend:SetMouseVisible(true);

	self:SetShortcut(Turbine.UI.Lotro.ShortcutType.Alias, nil);

	self.chatSend.MouseEnter = function(sender, args)
		if self:SyncControls() then self.Button:SetBackColor(self.enabledBackColorHover) end;
	end
	self.chatSend.MouseLeave = function(sender, args)
		self.Button:SetBackColor(self.enabledBackColorDefault);
	end
	self.chatSend.MouseDown = function(sender, args)
		self.Button:SetBackColor(self.enabledBackColorPressed);
	end
	self.chatSend.MouseUp = function(sender, args)
		self.Button:SetBackColor(self.enabledBackColorHover);
	end

    self.chatSend.DragDrop=function()
        self.chatSend:SetShortcut(self.chatSendShortcut);
    end

end

function Framework.UI.Controls.ShortcutButton:SyncControls()
	self:SetZOrder(1);
	self.chatSendWindow:SetZOrder(2);
	local x, y = self.chatSendWindow:GetPosition();
	local x1, y1 = self:PointToScreen(self:GetPosition());
	local x2, y2 = self:GetPosition();
	local x3, y3 = -(x2 - x1), -(y2 - y1);
	if x ~= x3 or y ~= y3 then
		self.chatSendWindow:SetPosition(x3, y3);
		return false;
	else
		return true;
	end
end

function Framework.UI.Controls.ShortcutButton:SetText(msg)
	self.Button.Label:SetText(msg);
end

function Framework.UI.Controls.ShortcutButton:SetShortcut(type, shortcut)
	self.chatSendShortcut = Turbine.UI.Lotro.Shortcut(type, shortcut);
	self.chatSend:SetShortcut(self.chatSendShortcut);
end

function Framework.UI.Controls.ShortcutButton:Destroy()
	self.Background = nil;
	self.Button.Label = nil;
	self.Button = nil;
	self.chatSend = nil;
	self.chatSendWindow = nil;
	self = nil;
end