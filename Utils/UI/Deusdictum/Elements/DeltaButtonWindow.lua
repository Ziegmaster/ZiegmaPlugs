
-- version 1.0
-- Initial version.

import "Turbine.UI";
import "Turbine.UI.Lotro";

_G.DeltaButtonWindow = class( Turbine.UI.Window );

local defaultResources = {
	  Normal=nil
	, Hover=nil
	, Pressed=nil
	, Disabled=nil
};

function DeltaButtonWindow:Constructor( tResources, bfZoneTest, ctlAttachTo )
	Turbine.UI.Window.Constructor( self );

	self.wndTarget = ctlAttachTo;
	if type(tResources) ~= "table" then
		self.resource = defaultResources;
	else
		self.resource = tResources;
	end
	if type(bfZoneTest) ~= "function" then
		self.InTheZone = function( sender, mx, my )
			if mx < 0 or my < 0 or mx > self:GetWidth() or my > self:GetHeight() then
				return false;
			end

			return true;
		end
	else
		self.InTheZone = bfZoneTest;
	end

	self.bEnabled = true;
	self.bMouseMoving = false;

	self.offsetX = 0;
	self.offsetY = 0;

	self:SetSize( 20, 20 );
	self:SetBackground( self.resource.Normal );
	self:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self:SetPosition( math.max( self.wndTarget:GetLeft(), 0 )
					, math.max( self.wndTarget:GetTop(), 0 ) );
	self:SetVisible( self.wndTarget:IsVisible() );
	self:SetOpacity( 1 );

	self.MouseEnter = function( sender, args )
		self:RefreshImage();
	end

	self.MouseLeave = function( sender, args )
		self:RefreshImage();
	end

	self.MouseDown = function( sender, args )
		if self:IsEnabled() then
			self:SetMouseMoving( true, args );
		end
	end

	self.MouseUp = function( sender, args )
		self:SetMouseMoving( false, args );
	end

	self.MouseMove = function( sender, args )
		if self:IsMouseMoving() then
			if type( self.Delta ) == "function" then
				local t = { };
				t.X = args.X;
				t.Y = args.Y;
				t.deltaX = args.X - self.deltaStartX;
				t.deltaY = args.Y - self.deltaStartY;
				self:Delta(t);
			end
		end

		self:RefreshImage();
	end
end

function DeltaButtonWindow:IsEnabled( )
	return self.bEnabled;
end

function DeltaButtonWindow:IsMouseMoving( )
	return self.bMouseMoving;
end

function DeltaButtonWindow:SetMouseMoving( bValue, args )
	if self.bMouseMoving == bValue then
		return;
	end

	self.bMouseMoving = bValue;

	local t = { };
	t.X = args.X;
	t.Y = args.Y;

	if self:IsMouseMoving() then
		self.deltaStartX = args.X;
		self.deltaStartY = args.Y;

		if type( self.DeltaStart ) == "function" then
			t.deltaX = 0;
			t.deltaY = 0;
			self:DeltaStart(t);
		end
	else
		t.deltaX = args.X - self.deltaStartX;
		t.deltaY = args.Y - self.deltaStartY;

		if type( self.DeltaEnd ) == "function" then
			self:DeltaEnd(t);
		end
		if self:InTheZone( args.X, args.Y ) then
			if type( self.Click ) == "function" then
				self:Click(t);
			end
		end
	end

	self:RefreshImage();
end

function DeltaButtonWindow:SetEnabled( bValue )
	if self.bEnabled == bValue then
		return;
	elseif type( bValue ) ~= "boolean" then
		self.bEnabled = true;
	else
		self.bEnabled = bValue;
	end

	self:RefreshImage();
end

function DeltaButtonWindow:SetOffset( oX, oY )
	self.offsetX, self.offsetY = oX, oY;
end

function DeltaButtonWindow:RecalculatePosition( )
	local X, Y;

	X = math.min( math.max( self.wndTarget:GetLeft() + self.offsetX, 0 ), Turbine.UI.Display:GetWidth() - self:GetWidth() );
	Y = math.min( math.max( self.wndTarget:GetTop() + self.offsetY, 0 ), Turbine.UI.Display:GetHeight() - self:GetHeight() );
	self:SetPosition( X, Y );
end

function DeltaButtonWindow:RefreshImage( )
	local mx, my = self:GetMousePosition();

	if not self:IsEnabled() then
		self:SetBackground( self.resource.Disabled );
	elseif self:InTheZone( mx, my ) and self:IsMouseMoving() then
		self:SetBackground( self.resource.Pressed );
	elseif self:InTheZone( mx, my ) then
		self:SetBackground( self.resource.Hover );
	else
		self:SetBackground( self.resource.Normal );
	end

	self:SetZOrder(self.wndTarget:GetZOrder() + 1);
end