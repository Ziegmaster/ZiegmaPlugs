--Pseudo deed superclass.
Objects.Deed = class();

function Objects.Deed:Constructor(name, location, level)

    --Deed's ingame name.
    self.Name = name;
    --Name of location or race name.
    self.Location = location;
    --Object of min levels for deed to be started or advanced.
    self.Level = level;
    --List of players progressing the deed.
    self.PlayersProgress = {};
    --List of players completed the deed.
    self.PlayersCompleted = {};

end