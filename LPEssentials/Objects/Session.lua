--This class is for storing all progress data
_G.Session = class();

function Session:Constructor()
    self.LocalPlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
    self.Bestiary = Bestiary();
    self.DeedQueue = {};
    self.StartTime = nil;
    self:SetGroup();
end

--Starts session
function Session:Start()
    self.StartTime = Turbine.Engine.GetGameTime();
end

--Gets current info about player's group from game client
function Session:SetGroup()
    self.PlayerGroup = {self.LocalPlayer};
    local group = self.LocalPlayer:GetParty();
    if group then
        local memberCount = group:GetMemberCount();
        memberCount = memberCount > 6 and 6 or memberCount;
        for i=1, memberCount do
            local member = group:GetMember(i);
            if not table.equal(member, self.LocalPlayer) and #self.PlayerGroup < 6  then
                table.insert(self.PlayerGroup, member);
            end
        end
    end
end

--Management of deed queue (stack cycle)
function Session:UpdateDeedQueue(deed)
    local index = table.indexOf(self.DeedQueue, deed);
    if index then
        table.remove(self.DeedQueue, index);
    end
    table.insert(self.DeedQueue, 1, deed);
end