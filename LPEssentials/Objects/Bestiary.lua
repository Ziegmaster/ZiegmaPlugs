--This class is for linking all text data together and store it in objects
_G.Bestiary = class();

function Bestiary:Constructor()
    self:InitDeeds();
    self:LinkCreatures();
end

--Creates pseudo deeds
function Bestiary:InitDeeds()
    self.SlayerDeeds = {};
    self.SlayerDeeds.Bree = {
        Spider = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Spider, Texts.Bestiary.Locations.Bree, {5, 5}, 30),
        Neekerbreeker = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Neekerbreeker, Texts.Bestiary.Locations.Bree, {5, 5}, 30),
        Brigand = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Brigand, Texts.Bestiary.Locations.Bree, {5, 5}, 30),
        SickleFly = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.SickleFly, Texts.Bestiary.Locations.Bree, {6, 6}, 20),
        Wight = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Wight, Texts.Bestiary.Locations.Bree, {12, 12}, 30),
        Barghest = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Barghest, Texts.Bestiary.Locations.Bree, {12, 12}, 30),
        Woodsman = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Woodsman, Texts.Bestiary.Locations.Bree, {12, 12}, 20),
        GraveDigger = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.GraveDigger, Texts.Bestiary.Locations.Bree, {15, 15}, 50),
        NemesisOfTheFallen = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.NemesisOfTheFallen, Texts.Bestiary.Locations.Bree, {15, 15}, 50),
        BroodHunter = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.BroodHunter, Texts.Bestiary.Locations.Bree, {15, 15}, 30),
        Orc = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Bree.Orc, Texts.Bestiary.Locations.Bree, {10, 10}, 30),
    };
    self.SlayerDeeds.Shire = {
        Wolf = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.Wolf, Texts.Bestiary.Locations.Shire, {5, 5}, 30),
        Slug = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.Slug, Texts.Bestiary.Locations.Shire, {5, 5}, 20),
        Brigand = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.Brigand, Texts.Bestiary.Locations.Shire, {5, 5}, 30),
        HarvestFly = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.HarvestFly, Texts.Bestiary.Locations.Shire, {5, 5}, 20),
        Spider = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.Spider, Texts.Bestiary.Locations.Shire, {5, 5}, 20),
        Goblin = DeedSlayer(Texts.Bestiary.Deeds.Slayer.Shire.Goblin, Texts.Bestiary.Locations.Shire, {5, 5}, 30),
    }
    self.SlayerDeeds.EredLuin = {
        Wolf = DeedSlayer(Texts.Bestiary.Deeds.Slayer.EredLuin.Wolf, Texts.Bestiary.Locations.EredLuin, {5, 5}, 30),
        Goblin = DeedSlayer(Texts.Bestiary.Deeds.Slayer.EredLuin.Goblin, Texts.Bestiary.Locations.EredLuin, {5, 5}, 30),
        Spider = DeedSlayer(Texts.Bestiary.Deeds.Slayer.EredLuin.Spider, Texts.Bestiary.Locations.EredLuin, {5, 5}, 30),
        Hendroval = DeedSlayer(Texts.Bestiary.Deeds.Slayer.EredLuin.Hendroval, Texts.Bestiary.Locations.EredLuin, {5, 5}, 20),
        Brigand = DeedSlayer(Texts.Bestiary.Deeds.Slayer.EredLuin.Brigand, Texts.Bestiary.Locations.EredLuin, {5, 5}, 30),
    }
    self.SlayerDeeds.NorthDowns = {
        Orc = DeedSlayer(Texts.Bestiary.Deeds.Slayer.NorthDowns.Orc, Texts.Bestiary.Locations.NorthDowns, {20, 20}, 60),
        Goblin = DeedSlayer(Texts.Bestiary.Deeds.Slayer.NorthDowns.Goblin, Texts.Bestiary.Locations.NorthDowns, {20, 20}, 60),
        Warg = DeedSlayer(Texts.Bestiary.Deeds.Slayer.NorthDowns.Warg, Texts.Bestiary.Locations.NorthDowns, {20, 20}, 60),
    }
    self.SlayerDeeds.Beornings = {
        EnmityOfTheGoblins = DeedSlayerRacial(Texts.Bestiary.Deeds.Slayer.Beornings.EnmityOfTheGoblins, Texts.Bestiary.Locations.Beornings, {13, 19}, 50),
        EnmityOfTheSpiders = DeedSlayerRacial(Texts.Bestiary.Deeds.Slayer.Beornings.EnmityOfTheSpiders, Texts.Bestiary.Locations.Beornings, {15}, 50),
    }
end

--Links creature names with existing deeds (hardcode)
function Bestiary:LinkCreatures()
    self.CreatureDeeds = {};
    for index, creature in pairs(Texts.Bestiary.Creatures.EredLuin.Goblin) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.EredLuin.Goblin, self.SlayerDeeds.Beornings.EnmityOfTheGoblins};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.EredLuin.Wolf) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.EredLuin.Wolf};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.EredLuin.Spider) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.EredLuin.Spider, self.SlayerDeeds.Beornings.EnmityOfTheSpiders};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.EredLuin.Hendroval) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.EredLuin.Hendroval};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.EredLuin.Brigand) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.EredLuin.Brigand};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.Wolf) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.Wolf};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.Slug) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.Slug};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.Brigand) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.Brigand};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.HarvestFly) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.HarvestFly};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.Spider) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.Spider, self.SlayerDeeds.Beornings.EnmityOfTheSpiders};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Shire.Goblin) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Shire.Goblin, self.SlayerDeeds.Beornings.EnmityOfTheGoblins};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Spider) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Spider, self.SlayerDeeds.Beornings.EnmityOfTheSpiders};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Tomb.Spider) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Spider, self.SlayerDeeds.Bree.BroodHunter, self.SlayerDeeds.Beornings.EnmityOfTheSpiders};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Neekerbreeker) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Neekerbreeker};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Brigand) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Brigand};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.SickleFly) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.SickleFly};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Wight) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Wight};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Tomb.Wight) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Wight, self.SlayerDeeds.Bree.GraveDigger};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Barghest) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Barghest};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Huorn) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Woodsman};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Tomb.Spirit) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.NemesisOfTheFallen};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Orc) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Bree.Orc};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.Bree.Goblin) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.Beornings.EnmityOfTheGoblins};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.NorthDowns.Fornost.Orc) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.NorthDowns.Orc};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.NorthDowns.Fornost.Goblin) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.NorthDowns.Goblin, self.SlayerDeeds.Beornings.EnmityOfTheGoblins};
    end
    for index, creature in pairs(Texts.Bestiary.Creatures.NorthDowns.Fornost.Warg) do
        self.CreatureDeeds[creature] = {self.SlayerDeeds.NorthDowns.Warg};
    end
end