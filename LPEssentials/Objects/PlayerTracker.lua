--This object grabs all actual data from current session party members
--It can be displayed somewhere in UI or Shell

Objects.PlayerTracker = class();

function Objects.PlayerTracker:Constructor()

    self.TrackSlots = {};

    for i = 1, 6 do

        local track_slot = Turbine.UI.Control();

        track_slot.AccelerationEffect = nil;
        track_slot.AccelerationTime = 0;
        track_slot.TFA = nil;

        track_slot.Update = function ()
            if CurrentSession then
                local player = CurrentSession.PlayerGroup[i];
                if player then
                    track_slot.TFA = player:GetRace() == 0;
                    if not track_slot.AccelerationEffect then
                        local effect_list = player:GetEffects();
                        for index = 1, effect_list:GetCount() do
                            local effect = effect_list:Get(index);
                            if effect:GetName() == Texts.UI.EffectTracker.SlayerDeedAcceleration then
                                track_slot.AccelerationEffect = effect;
                                return;
                            end
                        end
                    else
                        track_slot.AccelerationTime = track_slot.AccelerationEffect:GetDuration() - (Turbine.Engine.GetGameTime() - track_slot.AccelerationEffect:GetStartTime());
                        if not (track_slot.AccelerationTime > 0) then
                            track_slot.AccelerationEffect = nil;
                        end
                    end
                else
                    track_slot.AccelerationEffect = nil;
                    track_slot.AccelerationTime = 0;
                    track_slot.TFA = nil;
                end
            end
        end

        track_slot:SetWantsUpdates(true);
        table.insert(self.TrackSlots, track_slot);
    end
end