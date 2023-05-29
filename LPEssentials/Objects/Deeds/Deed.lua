--Pseudo deed superclass.
_G.Deed = class();

function Deed:Constructor(Name, Location, Level)

    --Deed's ingame name.
    self.Name = Name;
    --Name of location or race name.
    self.Location = Location;
    --Object of min levels for deed to be started or advanced.
    self.Level = Level;
    --List of players progressing the deed.
    self.PlayersProgress = {};
    --List of players completed the deed.
    self.PlayersCompleted = {};

end