import "Turbine.UI";

_G.ComboBox = class(Turbine.UI.Control);

function ComboBox:Constructor()
    Turbine.UI.Control.Constructor(self);
    
    self:SetBackColor(control2DisabledColor);
    --self:SetZOrder(5);
    
    -- state
    self.dropped = false;
    self.selection = -1;
    self.dropDownHeight = 0;
    self.mouse = false;
    
    -- text label
    self.label = Turbine.UI.Label();
    self.label:SetParent(self);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(control2LightColor);
    self.label:SetBackColor(blackColor);
    self.label:SetOutlineColor(controlColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.label:SetMouseVisible(false);
    
    -- arrow
    self.arrow = Turbine.UI.Control();
    self.arrow:SetParent(self);
    self.arrow:SetSize(16, 16);
    self.arrow:SetZOrder(6);
    self.arrow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.arrow:SetBackground(dropDownArrow);
    self.arrow:SetMouseVisible(false);
    
    -- drop down window
    self.dropDownWindow = Turbine.UI.Window();
    self.dropDownWindow:SetBackColor(control2DisabledColor);
    self.dropDownWindow:SetZOrder(10);
    self.dropDownWindow:SetVisible(false);
    self.dropDownWindow.Deactivated = function(sender, args)
    	if (not self.mouse) then
    		self:CloseDropDown();
    	end
    end
    
    -- list scroll bar        
    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self.dropDownWindow);
    self.scrollBar:SetBackColor(blackColor);

    -- list to contain the drop down items
    self.listBox = Turbine.UI.ListBox();
    self.listBox:SetParent(self.dropDownWindow);
    self.listBox:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.listBox:SetVerticalScrollBar(self.scrollBar);
    self.listBox:SetMaxItemsPerLine(1);
    self.listBox:SetMouseVisible(false);
    self.listBox:SetPosition(2, 2);
    self.listBox:SetBackColor(blackColor);
end

function ComboBox:MouseEnter(args)
    self.mouse = true;
    if (not self:IsEnabled()) then
        return;
    end
    
    self.label:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.label:SetForeColor(control2LightColor);
    self.label:SetText(self.label:GetText());

    self.arrow:SetBackground(self.dropped and dropDownArrowPressedHighlight or dropDownArrowHighlight);
end

function ComboBox:MouseLeave(args)
	self.mouse = false;
    if (not self:IsEnabled()) then
        return;
    end
    
    self.label:SetFontStyle(Turbine.UI.FontStyle.None);
    if (self.dropped) then
        self.label:SetForeColor(yellowColor);
    end
    self.label:SetText(self.label:GetText());

    self.arrow:SetBackground(self.dropped and dropDownArrowPressed or dropDownArrow);
end

function ComboBox:MouseClick(args)
    if (not self:IsEnabled()) then
        return;
    end
    
    if (args.Button == Turbine.UI.MouseButton.Left) then
        if (self.dropped) then
            self:CloseDropDown();
        else
            self:ShowDropDown();
        end
    end
end
    
function ComboBox:FireEvent()
    if (type(self.ItemChanged) == "function") then
        self:ItemChanged({selection=self:GetSelection()}); --Pass value to args.selection
    end
end

function ComboBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.listBox:GetItem(self.selection);
        old:SetForeColor(control2LightColor);
    end
    
    local item = self.listBox:GetItem(index);
    self.selection = index;
    item:SetForeColor(yellowColor);
    self.label:SetText(item:GetText());
    
    self:CloseDropDown();
end

function ComboBox:AddItem(text, value)
    local width, height = self.listBox:GetSize();

    local listItem = Turbine.UI.Label();
    listItem:SetSize(width, 20);
    listItem:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    listItem:SetForeColor(control2LightColor);
    listItem:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    listItem:SetOutlineColor(controlColor);
    listItem:SetText(text);
    
    listItem.MouseEnter = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.Outline);
        sender:SetForeColor(control2LightColor);
        sender:SetText(sender:GetText());
    end
    listItem.MouseLeave = function(sender, args)
        sender:SetFontStyle(Turbine.UI.FontStyle.None);
        if (self.listBox:IndexOfItem(sender) == self.selection) then
            sender:SetForeColor(yellowColor);
        end
        sender:SetText(sender:GetText());
    end
    listItem.MouseClick = function(sender, args)
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self:ItemSelected(self.listBox:GetSelectedIndex());
            self:FireEvent();
        end
    end
    listItem.value = value;
    self.listBox:AddItem(listItem);
end

function ComboBox:RemoveItem(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            item:SetVisible(false);
            self.listBox:RemoveItemAt(i);

            -- if the removed item is the selection update it
            if (self.selection == i) then
                self.selection = -1;
                if (self.listBox:GetItemCount() > 0) then
                    self:ItemSelected(1);
                    self:FireEvent();
                else
                    self.label:SetText("");
                end
            end
            break;
        end
    end
end

function ComboBox:ClearItems()
    self.listBox:ClearItems(); -- does this work now?
    self.selection = -1;
    self:FireEvent();
end

function ComboBox:SetSelection(value)
    for i = 1, self.listBox:GetItemCount() do
        local item = self.listBox:GetItem(i);
        if (item.value == value) then
            self:ItemSelected(i);
            self:FireEvent();
            break;
        end
    end
end

function ComboBox:GetSelection()
    if (self.selection == -1) then
        return nil;
    else
        local item = self.listBox:GetItem(self.selection);
        return item.value;
    end
end

function ComboBox:UpdateSelectionText(text)
    if (self.selection ~= -1) then
        local item = self.listBox:GetItem(self.selection);
        item:SetText(text);
        self.label:SetText(text);
    end
end

function ComboBox:GetItemCount()
    return self.listBox:GetItemCount();
end

function ComboBox:GetItem(index)
    local item = self.listBox:GetItem(index);
    return item.value;
end

function ComboBox:SetDropDownHeight(height)
    self.dropDownHeight = height;
end

function ComboBox:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function ComboBox:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    if (enabled) then
        self.label:SetForeColor(control2LightColor);
        self.arrow:SetBackground(dropDownArrow);
    else
        self:CloseDropDown();
        self.label:SetForeColor(controlDisabledColor);
        self.arrow:SetBackground(dropDownArrowDisabled);
    end
end

function ComboBox:Layout()
    local width, height = self:GetSize();
    self.label:SetSize(width - 4, height - 4);
    self.label:SetPosition(2, 2);
    self.arrow:SetPosition(width - 2 - 16, 2 + ((height - 4 - 16) / 2));
end

function ComboBox:ShowDropDown()
    local itemCount = self.listBox:GetItemCount();
    if ((itemCount > 0) and not (self.dropped)) then
        self.dropped = true;
        self.label:SetForeColor(yellowColor);
        self.arrow:SetBackground(dropDownArrowPressedHighlight);
        local width, height = self:GetSize();
        --width = width + 10;
        
        -- max size
        local maxItems = itemCount;
        local scrollSize = 0;
        if (maxItems > 10) then
            maxItems = 10;
            scrollSize = 10;
        end

        -- list item sizes
        local listHeight = 0;
        for i = 1, self.listBox:GetItemCount() do
            local item = self.listBox:GetItem(i);
            item:SetWidth(width - 14);
            if (i <= maxItems) then
                listHeight = listHeight + item:GetHeight();
            end
        end
        
        -- check for a set drop down size
        if (self.dropDownHeight > 0) then
            listHeight = self.dropDownHeight;
        end
        
        -- window size
        self.listBox:SetSize(width - 4 - scrollSize, listHeight);
        self.dropDownWindow:SetSize(width, listHeight + 4);
        
        -- scrollbar
        self.scrollBar:SetSize(10, listHeight);
        self.scrollBar:SetPosition(width - 12, 2);

        -- position
        local x, y = self:GetParent():PointToScreen(self:GetPosition());
        self.dropDownWindow:SetPosition(x, y + height + 3);
        
        self.dropDownWindow:SetVisible(true);
        self.dropDownWindow:Activate();
        self.dropDownWindow:Focus();
    end
end

function ComboBox:CloseDropDown()
    if (self.dropped) then
        self.dropped = false;
        self.dropDownWindow:SetVisible(false);
        self.label:SetForeColor(control2LightColor);
        self.arrow:SetBackground(dropDownArrowHighlight);
    end
end
