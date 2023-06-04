_G.DeedSlayer = class(Deed);

function DeedSlayer:Constructor(Name, Location, Level, Objective)

    Deed.Constructor(self, Name, Location, Level);

    self.Objective = Objective;
    self.PlayerProgress = {};

end

--Gets LocalPlayer's deed progress.
function DeedSlayer:GetLocalProgress()
    local progress = self.PlayerProgress[SessionInstance.LocalPlayer:GetName()];
    if progress then
        local index = #progress;
        return {
            Objective = self.Objective * index,
            Progress = self.PlayerProgress[SessionInstance.LocalPlayer:GetName()][index],
        }
    else
        return nil;
    end
end

--Increments progress value for each group member in session data.
function DeedSlayer:IncrementProgress()
    local playersProgressed = false;
    local localPlayerProgressed = false;
    for i, player in pairs(SessionInstance.PlayerGroup) do
        local playerName = player:GetName();
        local playerRace = player:GetRace();
        local playerIsLocal = table.equal(playerName, SessionInstance.LocalPlayer:GetName());
        --Checking if player has not completed the deed and stays in range for the progress to be achieved.
        if not table.indexOf(self.PlayersCompleted, playerName) and (Settings.Main.AnyDist or playerRace ~= 0)  then
            local multiplier = ((playerIsLocal and Settings.Main.SimulateAcceleration) or UI.MainWindow.GroupContainer.Players[i].EffectDisplay:GetEffect()) and 2 or 1;
            local progress = self.PlayerProgress[playerName];
            --Checking if player's progress found in list.
            if progress then
                local index = #progress;
                --Checking if current progress is less than deed's objective.
                if progress[index] <= self.Objective * index then
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
                                table.insert(self.PlayerProgress[playerName], 0);
                            end
                        else
                            --Set deed as completed. 
                            table.insert(self.PlayersCompleted, player:GetName());
                        end
                    end
                    self.PlayerProgress[playerName][index] = value;
                    playersProgressed = true;
                    if playerIsLocal then localPlayerProgressed = true end;
                end
            else
                --Checking if player's level is enough to start progressing the deed.
                if player:GetLevel() >= self.Level[1] then
                    --Init a progress for the player.
                    self.PlayerProgress[playerName] = {multiplier};
                    playersProgressed = true;
                    if playerIsLocal then localPlayerProgressed = true end;
                end
            end
        end
    end
    return playersProgressed, localPlayerProgressed;
end