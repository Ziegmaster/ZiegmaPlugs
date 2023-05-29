
-- version 1.3b
-- Change in how resource filenames are stored and allow overriding.
-- Added support for DeltaButton / a button to rotate the target window
-- Added Z order correction for Rotator when dragging.

import "Turbine.UI";
import "Turbine.UI.Lotro";
local deltaButtonAvailable = pcall( function( ) import (DeusdictumElements .. ".DeltaButton"); end );

local defaultDragBarResources = {
	  Bar = {
				  Normal = DeusdictumResources .. "/DragBarBar.tga"
				, Dragged = DeusdictumResources .. "/DragBarBar_Dragged.tga"
			}
	, Corner = {
				  Normal = DeusdictumResources .. "/DragBarCorner.tga"
				, Dragged = DeusdictumResources .. "/DragBarCorner_Dragged.tga"
			   }
	, Hover = {
				  TopLeft = DeusdictumResources .. "/DragBarHoverBox_TopLeft.tga"
				, Top = DeusdictumResources .. "/DragBarHoverBox_Top.tga"
				, TopRight = DeusdictumResources .. "/DragBarHoverBox_TopRight.tga"
				, Left = DeusdictumResources .. "/DragBarHoverBox_Left.tga"
				, Right = DeusdictumResources .. "/DragBarHoverBox_Right.tga"
				, BottomLeft = DeusdictumResources .. "/DragBarHoverBox_BottomLeft.tga"
				, Bottom = DeusdictumResources .. "/DragBarHoverBox_Bottom.tga"
				, BottomRight = DeusdictumResources .. "/DragBarHoverBox_BottomRight.tga"
			  }
};

local defaultRotatorResources = {
	  Normal="Turbine/Resources/rotate_button_normal.tga"
	, Hover="Turbine/Resources/rotate_button_rollover.tga"
	, Pressed="Turbine/Resources/rotate_button_pressed.tga"
	, Disabled="Turbine/Resources/rotate_button_ghosted.tga"
};

_G.DragBar = class( Turbine.UI.Window );

function DragBar:Constructor( ctlAttachTo, sName, bBarOnTop, tResources )
	Turbine.UI.Window.Constructor( self );

	self.wndTarget = ctlAttachTo;
	if type(sName) ~= "string" then
		self.sName = "";
	else
		self.sName = sName;
	end
	if type(bBarOnTop) ~= "boolean" then
		bBarOnTop = true;
	end
	if type(tResources) == "table" then
		self.resource = tResources;
	else
		self.resource = defaultDragBarResources;
	end

	self:SetSize( self.wndTarget:GetWidth(), 19 );
	self:SetPosition( math.max( self.wndTarget:GetLeft(), 0 )
					, math.max( self.wndTarget:GetTop() - 19, 0 ) );
	self:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self:SetVisible( false );
	self:SetOpacity( 1 );

	self.Bar = Turbine.UI.Control();
	self.Bar:SetParent( self );
	self.Bar:SetSize( self:GetWidth() - 19, 19 );
	self.Bar:SetPosition( 19, 0 );
	self.Bar:SetBackground( self.resource.Bar.Normal );
	self.Bar:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.Bar:SetMouseVisible(false);
	self.Bar:SetVisible( true );
	self.Bar:SetOpacity( 1 );

	self.Corner = Turbine.UI.Control();
	self.Corner:SetParent( self );
	self.Corner:SetSize( 19, 19 );
	self.Corner:SetPosition( 0, 0 );
	self.Corner:SetBackground( self.resource.Corner.Normal );
	self.Corner:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.Corner:SetMouseVisible(false);
	self.Corner:SetVisible( true );
	self.Corner:SetOpacity( 1 );

	self.Label = Turbine.UI.Label();
	self.Label:SetParent( self );
	self.Label:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.Label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.Label:SetFont( Turbine.UI.Lotro.Font.Verdana12 );
	self.Label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.Label:SetMouseVisible(false);
	self.Label:SetSize( self:GetWidth(), 18 );
	self.Label:SetPosition( 0, 1 );
	self.Label:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
	self.Label:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.Label:SetText( self.sName );

	self:SetDraggable( false );
	self:SetBeingDragged( false );
	self:SetBarOnTop( bBarOnTop );
	self:SetHUDVisible( true );
	self:SetAllowsDragging( true );
	self:SetAllowsHUDHiding( true, true );

	self.KeyDown = function( sender, args )
		if args.Action == 0x1000007B and self:GetAllowsDragging() then
			self:ToggleDraggable();
		elseif args.Action == 0x100000B3 and self:GetAllowsHUDHiding() then
			self:ToggleHUDVisible();
		end
	end

	self:SetWantsKeyEvents( true );

	self.MouseDown = function( sender, args )
		if self:IsDraggable() then
			self:SetBeingDragged( true, args );
		end
	end

	self.MouseMove = function( sender, args )
		if ( self:IsBeingDragged() ) then
			local left, top = self.wndTarget:GetPosition();
			self.wndTarget:SetPosition( math.min( math.max( left + ( args.X - self.dragStartX ), 0 ), Turbine.UI.Display:GetWidth() - self.wndTarget:GetWidth() )
									  , math.min( math.max( top + ( args.Y - self.dragStartY ), 0 ), Turbine.UI.Display:GetHeight() - self.wndTarget:GetHeight()) );
			self:RecalculatePosition();

			if type( self.wndTarget.Dragged ) == "function" then
				self.wndTarget:Dragged();
			end

			if type( self.Rotator ) == "table" then
				self.Rotator:SetZOrder( self:GetZOrder() + 1 );
			end
		end
	end

	self.MouseUp = function( sender, args )
		self:SetBeingDragged( false, args );
	end

	self.MouseEnter = function( sender, args )
		self:CreateHoverBox();
	end

	self.MouseLeave = function( sender, args )
		if not self:IsBeingDragged() then
			self:DestroyHoverBox();
		end
	end

	if deltaButtonAvailable then
		self.VisibleChanged = function( sender, args )
			if type( self.Rotator ) == "table" then
				self.Rotator:SetVisible( self:IsVisible() );
			end
		end

		self.PositionChanged = function( sender, args )
			if type( self.Rotator ) == "table" then
				self.Rotator:RecalculatePosition();
			end
		end
	end
end

function DragBar:CanHaveRotator( )
	if deltaButtonAvailable then
		return true;
	end

	return false;
end

function DragBar:SetRotatorOffset( oX, oY )
	if type( self.Rotator ) == "table" then
		self.Rotator:SetOffset( oX, oY );
	end
end

function DragBar:SetRotator( bEnabled, tResources, bfZoneTest )
	if deltaButtonAvailable then
		if bEnabled then
			if type(tResources) ~= "table" then
				tResources = defaultRotatorResources;
			end
			self.Rotator = Deusdictum.UI.DeltaButton( tResources, bfZoneTest, self );

			self.Rotator.DeltaStart = function( sender, args )
				if type( self.wndTarget.RotateStart ) == "function" then
					self.wndTarget:RotateStart( args );
				end
			end

			self.Rotator.DeltaEnd = function( sender, args )
				if type( self.wndTarget.RotateEnd ) == "function" then
					self.wndTarget:RotateEnd( args );
				end
			end

			self.Rotator.Delta = function( sender, args )
				if type( self.wndTarget.Rotating ) == "function" then
					self.wndTarget:Rotating( args );
				end
			end

			self.Rotator.Click = function( sender, args )
				if type( self.wndTarget.Rotate ) == "function" then
					self.wndTarget:Rotate( args );
				end
			end

			return true;
		else
			self.Rotator = nil;
			return false;
		end
	end

	return nil;
end

function DragBar:SetAllowsDragging( bValue )
	if self.bAllowDragging == bValue then
		return;
	end

	self.bAllowDragging = bValue;

	if ( not self:GetAllowsDragging() ) and self:IsBeingDragged() then
		self:SetDraggable( false );
	end
end

function DragBar:SetAllowsHUDHiding( bValue, bShowHUDIfHidden )
	if self.bAllowHUDHiding == bValue then
		return;
	end

	self.bAllowHUDHiding = bValue;

	if bShowHUDIfHidden then
		if ( not self:GetAllowsHUDHiding() ) and not self:IsHUDVisible() then
			self:SetHUDVisible( true );
		end
	end
end

function DragBar:GetAllowsDragging( )
	return self.bAllowDragging;
end

function DragBar:GetAllowsHUDHiding( )
	return self.bAllowHUDHiding;
end

function DragBar:HideTargetIfHUDHidden( )
	if self.wndTarget:IsVisible() and not self:IsHUDVisible() then
		self.wndTarget:SetVisible( false );
	end
end

function DragBar:SetDraggable( bValue )
	if self.bReposUI == bValue then
		return;
	end

	self.bReposUI = bValue;

	if self:IsDraggable() then
		self:SetVisible( self:IsHUDVisible() );

		if type( self.wndTarget.DragEnable ) == "function" then
			self.wndTarget:DragEnable();
		end
	else
		self:SetVisible( false );

		if type( self.wndTarget.DragDisable ) == "function" then
			self.wndTarget:DragDisable();
		end
	end
end

function DragBar:IsDraggable( )
	return self.bReposUI;
end

function DragBar:SetHUDVisible( bValue )
	if self.bHUDVisible == bValue then
		return;
	end

	self.bHUDVisible = bValue;

	if self:IsHUDVisible() then
		self.wndTarget:SetVisible( true );
		self:SetVisible( self:IsDraggable() );
		if type( self.wndTarget.HUDShow ) == "function" then
			self.wndTarget:HUDShow();
		end
	else
		self.wndTarget:SetVisible( false );
		self:SetVisible( false );
		if type( self.wndTarget.HUDHide ) == "function" then
			self.wndTarget:HUDHide();
		end
	end
end

function DragBar:IsHUDVisible( )
	return self.bHUDVisible;
end

function DragBar:SetBeingDragged( bValue, args )
	local oldValue = self.bDragging;

	self.bDragging = bValue;

	if self:IsBeingDragged() then
		self.dragStartX = args.X;
		self.dragStartY = args.Y;
		self.Corner:SetBackground( self.resource.Corner.Dragged );
		self.Bar:SetBackground( self.resource.Bar.Dragged );

		if not oldValue then
			if type( self.wndTarget.DragStart ) == "function" then
				self.wndTarget:DragStart();
			end
		end
	else
		self.Corner:SetBackground( self.resource.Corner.Normal );
		self.Bar:SetBackground( self.resource.Bar.Normal );

		local mx, my = self:GetMousePosition();
		if  mx < 0 or my < 0 or mx > self:GetWidth() or my > self:GetHeight() then
			self:DestroyHoverBox();
		end

		if oldValue then
			if type( self.wndTarget.DragEnd ) == "function" then
				self.wndTarget:DragEnd();
			end
		end
	end
end

function DragBar:IsBeingDragged( )
	return self.bDragging;
end

function DragBar:ToggleDraggable( )
	self:SetDraggable( not self:IsDraggable() );
end

function DragBar:ToggleHUDVisible( )
	self:SetHUDVisible( not self:IsHUDVisible() );
end

function DragBar:CreateHoverBox( )
	if self.hoverBox == nil then
		self.hoverBox = Turbine.UI.Window();
		self.hoverBox:SetSize( self.wndTarget:GetSize() );
		self.hoverBox:SetPosition( self.wndTarget:GetPosition() );
		self.hoverBox:SetMouseVisible( false );
		self.hoverBox:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0 ) );
		self.hoverBox:SetVisible( true );
		self.hoverBox:SetOpacity( 1 );

		self.hoverTL = Turbine.UI.Control();
		self.hoverTL:SetParent( self.hoverBox );
		self.hoverTL:SetSize( 8, 8 );
		self.hoverTL:SetPosition( 0, 0 );
		self.hoverTL:SetMouseVisible( false );
		self.hoverTL:SetBackground( self.resource.Hover.TopLeft );
		self.hoverTL:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverTL:SetVisible( true );
		self.hoverTL:SetOpacity( 1 );

		self.hoverTR = Turbine.UI.Control();
		self.hoverTR:SetParent( self.hoverBox );
		self.hoverTR:SetSize( 8, 8 );
		self.hoverTR:SetPosition( self.hoverBox:GetWidth() - 8, 0 );
		self.hoverTR:SetMouseVisible( false );
		self.hoverTR:SetBackground( self.resource.Hover.TopRight );
		self.hoverTR:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverTR:SetVisible( true );
		self.hoverTR:SetOpacity( 1 );

		self.hoverBL = Turbine.UI.Control();
		self.hoverBL:SetParent( self.hoverBox );
		self.hoverBL:SetSize( 8, 8 );
		self.hoverBL:SetPosition( 0, self.hoverBox:GetHeight() - 8 );
		self.hoverBL:SetMouseVisible( false );
		self.hoverBL:SetBackground( self.resource.Hover.BottomLeft );
		self.hoverBL:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverBL:SetVisible( true );
		self.hoverBL:SetOpacity( 1 );

		self.hoverBR = Turbine.UI.Control();
		self.hoverBR:SetParent( self.hoverBox );
		self.hoverBR:SetSize( 8, 8 );
		self.hoverBR:SetPosition( self.hoverBox:GetWidth() - 8, self.hoverBox:GetHeight() - 8 );
		self.hoverBR:SetMouseVisible( false );
		self.hoverBR:SetBackground( self.resource.Hover.BottomRight );
		self.hoverBR:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverBR:SetVisible( true );
		self.hoverBR:SetOpacity( 1 );

		self.hoverT = Turbine.UI.Control();
		self.hoverT:SetParent( self.hoverBox );
		self.hoverT:SetSize( self.hoverBox:GetWidth() - 16, 8 );
		self.hoverT:SetPosition( 8, 0 );
		self.hoverT:SetMouseVisible( false );
		self.hoverT:SetBackground( self.resource.Hover.Top );
		self.hoverT:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverT:SetVisible( true );
		self.hoverT:SetOpacity( 1 );

		self.hoverL = Turbine.UI.Control();
		self.hoverL:SetParent( self.hoverBox );
		self.hoverL:SetSize( 8, self.hoverBox:GetHeight() - 16 );
		self.hoverL:SetPosition( 0, 8 );
		self.hoverL:SetMouseVisible( false );
		self.hoverL:SetBackground( self.resource.Hover.Left );
		self.hoverL:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverL:SetVisible( true );
		self.hoverL:SetOpacity( 1 );

		self.hoverB = Turbine.UI.Control();
		self.hoverB:SetParent( self.hoverBox );
		self.hoverB:SetSize( self.hoverBox:GetWidth() - 16, 8 );
		self.hoverB:SetPosition( 8, self.hoverBox:GetHeight() - 8 );
		self.hoverB:SetMouseVisible( false );
		self.hoverB:SetBackground( self.resource.Hover.Bottom );
		self.hoverB:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverB:SetVisible( true );
		self.hoverB:SetOpacity( 1 );

		self.hoverR = Turbine.UI.Control();
		self.hoverR:SetParent( self.hoverBox );
		self.hoverR:SetSize( 8, self.hoverBox:GetHeight() - 16 );
		self.hoverR:SetPosition( self.hoverBox:GetWidth() - 8, 8 );
		self.hoverR:SetMouseVisible( false );
		self.hoverR:SetBackground( self.resource.Hover.Right );
		self.hoverR:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
		self.hoverR:SetVisible( true );
		self.hoverR:SetOpacity( 1 );
	end
end

function DragBar:DestroyHoverBox( )
	if self.hoverBox ~= nil then 
		self.hoverBox:SetVisible( false );
		self.hoverBox = nil;
		self.hoverTL = nil;
		self.hoverTR = nil;
		self.hoverBL = nil;
		self.hoverBR = nil;
		self.hoverT = nil;
		self.hoverL = nil;
		self.hoverB = nil;
		self.hoverR = nil;
	end
end

function DragBar:IsBarOnTop( )
	return self.bOnTop;
end

function DragBar:SetBarOnTop( bValue )
	self.bOnTop = bValue;

	self:RecalculatePosition();
end

function DragBar:RecalculatePosition( )
	local X, Y;

	if self.hoverBox ~= nil then
		self.hoverBox:SetPosition( self.wndTarget:GetPosition() );
	end

	if self.bOnTop then
		X = self.wndTarget:GetLeft();
		Y = math.max( self.wndTarget:GetTop() - 19, 0 );
	else
		X = self.wndTarget:GetLeft();
		Y = math.min( self.wndTarget:GetTop() + self.wndTarget:GetHeight(), Turbine.UI.Display:GetHeight() - 19 );
	end

	self:SetPosition( X, Y );
end

function DragBar:RecalculateSize()
	self:SetSize( self.wndTarget:GetWidth(), 19 );
	self.Bar:SetSize( self:GetWidth() - 19, 19 );
	self.Label:SetSize( self:GetWidth(), 18 );

	if self.hoverBox ~= nil then
		self.hoverBox:SetSize( self.wndTarget:GetSize() );
		self.hoverTR:SetPosition( self.hoverBox:GetWidth() - 8, 0 );
		self.hoverBL:SetPosition( 0, self.hoverBox:GetHeight() - 8 );
		self.hoverBR:SetPosition( self.hoverBox:GetWidth() - 8, self.hoverBox:GetHeight() - 8 );
		self.hoverT:SetSize( self.hoverBox:GetWidth() - 16, 8 );
		self.hoverL:SetSize( 8, self.hoverBox:GetHeight() - 16 );
		self.hoverB:SetSize( self.hoverBox:GetWidth() - 16, 8 );
		self.hoverB:SetPosition( 8, self.hoverBox:GetHeight() - 8 );
		self.hoverR:SetSize( 8, self.hoverBox:GetHeight() - 16 );
		self.hoverR:SetPosition( self.hoverBox:GetWidth() - 8, 8 );
	end
end

function DragBar:Refresh( )
	self:RecalculateSize();
	self:RecalculatePosition();
end