Objects.DeedSlayerRacial = class(Objects.DeedSlayer);

function Objects.DeedSlayerRacial:Constructor(name, location, level, objective)

    Objects.DeedSlayer.Constructor(self, name, location, level, objective);

end

--Increments progress value for each group member in session data.
function Objects.DeedSlayerRacial:IncrementProgress()
    local players_progressed = false;
    local local_player_progressed = false;
    for i, player in pairs(CurrentSession.PlayerGroup) do
        local player_name = player:GetName();
        local player_race = player:GetRace();
        local player_is_local = table.equal(player_name, Plugin.LocalPlayer:GetName());
        --Checking if player has not completed the deed and stays in range for the progress to be achieved.
        if not table.indexOf(self.PlayersCompleted, player_name) and (Plugin.Settings.Flags.AnyDist or player_race ~= 0) then
            local multiplier = ((player_is_local and Plugin.Settings.Flags.SimulateAcceleration) or Plugin.PlayerTracker.TrackSlots[i].AccelerationEffect) and 2 or 1;
            local progress = self.PlayersProgress[player_name];
            --Checking if player's progress found in list.
            if progress then
                local index = #progress;
                --Checking if current progress is less than deed's objective.
                if progress[index] < self.Objective * index then
                    local value = progress[index] + multiplier;
                    local exceed = value - self.Objective * index >= 0;
                    --Checking if new progress value exceeds deed's objective.
                    if exceed then
                        value = self.Objective * index;
                        --Checking there is an advancement.
                        if self.Level[index+1] then
                            --Checking if player's level is enough for next stage.
                            if player:GetLevel() >= self.Level[index+1] then
                                --Add new index to the progress.
                                table.insert(self.PlayersProgress[player_name], 0);
                            end
                        else
                            --Set deed as completed. 
                            table.insert(self.PlayersCompleted, player:GetName());
                        end
                    end
                    self.PlayersProgress[player_name][index] = value;
                    players_progressed = true;
                    if player_is_local then local_player_progressed = true end;
                else
                    --Checking if player's level is enough for next stage.
                    if player:GetLevel() >= self.Level[index+1] then
                        --Add new index to the progress.
                        table.insert(self.PlayersProgress[player_name], multiplier);
                        players_progressed = true;
                        if player_is_local then local_player_progressed = true end;
                    end
                end
            else
                --Checking if player's race is compatible and his level is enough to start progressing the deed.
                if Objects.Races[player_race] == self.Location and player:GetLevel() >= self.Level[1] then
                    --Init a progress for the player.
                    self.PlayersProgress[player_name] = {multiplier};
                    players_progressed = true;
                    if player_is_local then local_player_progressed = true end;
                end
            end
        end
    end
    return players_progressed, local_player_progressed;
end