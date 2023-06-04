import "Turbine.UI";

sliderWidget = Turbine.UI.Graphic(0x41007e0c);
sliderWidgetDisabled = Turbine.UI.Graphic(string.gsub(Path.Utils, "%.", "/") .. "/UI/Controls/Resources/slider_widget_ghosted.tga");
sliderBackground = Turbine.UI.Graphic(0x41007e0b);
sliderLeftArrow = Turbine.UI.Graphic(0x41007e0e);
sliderLeftArrowPressed = Turbine.UI.Graphic(0x41007e0d);
sliderRightArrow = Turbine.UI.Graphic(0x41007e11);
sliderRightArrowPressed = Turbine.UI.Graphic(0x41007e10);

_G.Slider = class(Turbine.UI.Control);

function Slider:Constructor()
    Turbine.UI.Control.Constructor(self);
    
    self.step = 1;
    self.min = 0;
    self.max = 0;
    self.value = 0;
    self.format = "%d";

    -- text label
    self.label = Turbine.UI.Label();
    self.label:SetParent(self);
    self.label:SetPosition(12, 0);
    self.label:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.label:SetForeColor(control2LightColor);
    self.label:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    --self.label:SetMouseVisible(false);

    -- value label
    self.valueLabel = Turbine.UI.Label();
    self.valueLabel:SetParent(self);
    self.valueLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
    self.valueLabel:SetForeColor(control2LightColor);
    self.valueLabel:SetTextAlignment(Turbine.UI.ContentAlignment.TopRight);
    self.valueLabel:SetMouseVisible(false);

    -- left arrow
    self.leftArrow = Turbine.UI.Control();
    self.leftArrow:SetParent(self);
    self.leftArrow:SetBackground(sliderLeftArrow);
    self.leftArrow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.leftArrow:SetSize(16,16);
    self.leftArrow.MouseDown = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end
    
        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.leftArrow:SetWantsUpdates(true);
            self.leftArrow:SetBackground(sliderLeftArrowPressed);
            self.leftArrow.tick = Turbine.Engine.GetGameTime();
            self.leftArrow.wait = true;
        end
    end
    self.leftArrow.MouseUp = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.leftArrow:SetWantsUpdates(false);
            self.leftArrow:SetBackground(sliderLeftArrow);
            self:Decrement();
        end
    end
    self.leftArrow.Update = function(sender, args)
        local gameTime = Turbine.Engine.GetGameTime();
        if (self.leftArrow.wait) then
            if ((gameTime - self.leftArrow.tick) > .5) then
                self.leftArrow.wait = false;
            end        
        else
            if ((gameTime - self.leftArrow.tick) > .05) then
                self:Decrement();
                self.leftArrow.tick = gameTime;
            end
        end
    end

    -- right arrow
    self.rightArrow = Turbine.UI.Control();
    self.rightArrow:SetParent(self);
    self.rightArrow:SetBackground(sliderRightArrow);
    self.rightArrow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.rightArrow:SetSize(16,16);
    self.rightArrow.MouseDown = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.rightArrow:SetWantsUpdates(true);
            self.rightArrow:SetBackground(sliderRightArrowPressed);
            self.rightArrow.tick = Turbine.Engine.GetGameTime();
            self.rightArrow.wait = true;
        end
    end
    self.rightArrow.MouseUp = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.rightArrow:SetWantsUpdates(false);
            self.rightArrow:SetBackground(sliderRightArrow);
            self:Increment();
        end
    end
    self.rightArrow.Update = function(sender, args)
        local gameTime = Turbine.Engine.GetGameTime();
        if (self.rightArrow.wait) then
            if ((gameTime - self.rightArrow.tick) > .5) then
                self.rightArrow.wait = false;
            end        
        else
            if ((gameTime - self.rightArrow.tick) > .05) then
                self:Increment();
                self.rightArrow.tick = gameTime;
            end
        end
    end

    -- slider area
    self.sliderBox = Turbine.UI.Control();
    self.sliderBox:SetParent(self);
    self.sliderBox:SetBackground(sliderBackground);
    self.sliderBox:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.sliderBox.MouseClick = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            local width = self.sliderBox:GetWidth() - 16;
            local x = args.X - 8;
            if (x < 0) then
                x = 0;
            end
            if(x > width) then
                x = width;
            end
            self.slider:SetPosition(x, 0);
            self:UpdateValueFromPosition();
        end
    end

    -- slider widget
    self.slider = Turbine.UI.Control();
    self.slider:SetParent(self.sliderBox);
    self.slider:SetBackground(sliderWidget);
    self.slider:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.slider:SetSize(16,16)
    self.slider.MouseDown = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.slider.dragStartX = args.X;
            self.slider.dragging = true;
        end
    end
    self.slider.MouseUp = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (args.Button == Turbine.UI.MouseButton.Left) then
            self.slider.dragging = false;
        end
    end
    self.slider.MouseMove = function(sender, args)
        if (not self:IsEnabled()) then
            return;
        end

        if (self.slider.dragging) then
            local left, top = self.slider:GetPosition();
            local width = self.sliderBox:GetWidth() - 16;
            
            local x = left - self.slider.dragStartX + args.X;
            if (x < 0) then
                x = 0;
            end
            if(x > width) then
                x = width;
            end
            self.slider:SetPosition(x, 0);
            self:UpdateValueFromPosition();
        end
    end    
end

function Slider:SetText(text)
    self.label:SetText(text);
end

function Slider:SetSize(width, height)
    Turbine.UI.Control.SetSize(self, width, height);
    self:Layout();
end

function Slider:SetEnabled(enabled)
    Turbine.UI.Control.SetEnabled(self, enabled);
    if (enabled) then
        self.label:SetForeColor(control2LightColor);
        self.valueLabel:SetForeColor(control2LightColor);
        self.slider:SetBackground(sliderWidget);
    else
        self.label:SetForeColor(controlDisabledColor);
        self.valueLabel:SetForeColor(controlDisabledColor);
        self.slider:SetBackground(sliderWidgetDisabled);
    end
end

function Slider:Layout()
    local width, height = self:GetSize();
    
    self.label:SetSize(width * .75, 20);
    self.valueLabel:SetSize(width * .25, 20);
    self.valueLabel:SetPosition(width - (width * .25) - 12, 0);

    self.sliderBox:SetSize(width - 56, 16);
    self.sliderBox:SetPosition(28, 21);
    
    self.leftArrow:SetPosition(12, 21);
    self.rightArrow:SetPosition(width - 28, 21);
    
    -- update the slider position from the value now that our size has changed
    self:UpdatePositionFromValue();
end

function Slider:UpdateValueFromPosition()
    local x, y = self.slider:GetPosition();
    local width = self.sliderBox:GetWidth() - 16;
    local ppv = width / ((self.max - self.min) / self.step);

    self.value = (math.floor(x / ppv) * self.step) + self.min;
    self.valueLabel:SetText(string.format(self.format, self.value));
    
    ExecuteListener(self, "ValueChanged", {value=self.value});
end

function Slider:UpdatePositionFromValue()
    local width = self.sliderBox:GetWidth() - 16;
    local ppv = width / ((self.max - self.min) / self.step);

    local x = (self.value - self.min) * ppv / self.step;
    self.slider:SetPosition(x, 0);
end

function Slider:SetValue(value)
    self.value = value;
    self.valueLabel:SetText(string.format(self.format, self.value));
    self:UpdatePositionFromValue();

    ExecuteListener(self, "ValueChanged", {value=self.value});
end

function Slider:GetValue()
    return self.value;
end

function Slider:SetStep(step)
    self.step = step;
end

function Slider:SetMin(min)
    self.min = min;
end

function Slider:SetMax(max)
    self.max = max;
end

function Slider:SetFormat(format)
    self.format = format;
end

function Slider:Increment()
    local value = self.value + self.step;
    if (value > self.max) then
        value = self.max;
    end
    self:SetValue(value);
end

function Slider:Decrement()
    local value = self.value - self.step;
    if (value < self.min) then
        value = self.min;
    end
    self:SetValue(value);
end