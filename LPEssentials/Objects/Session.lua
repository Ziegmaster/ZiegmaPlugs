--This class is for storing all progress data
Objects.Session = class();

function Objects.Session:Constructor()
    self.Bestiary = Objects.Bestiary();
    self.DeedQueue = {};
    self.StartTime = Turbine.Engine.GetGameTime();
    self:SetGroup();
end

--Gets current info about player's group from game client
function Objects.Session:SetGroup()
    self.PlayerGroup = {Plugin.LocalPlayer};
    local group = Plugin.LocalPlayer:GetParty();
    if group then
        local memberCount = group:GetMemberCount();
        memberCount = memberCount > 6 and 6 or memberCount;
        for i=1, memberCount do
            local member = group:GetMember(i);
            if not table.equal(member, Plugin.LocalPlayer) and #self.PlayerGroup < 6  then
                table.insert(self.PlayerGroup, member);
            end
        end
    end
end

--Management of deed queue (stack cycle)
function Objects.Session:UpdateDeedQueue(deed)
    local index = table.indexOf(self.DeedQueue, deed);
    if index then
        table.remove(self.DeedQueue, index);
    end
    table.insert(self.DeedQueue, 1, deed);
end