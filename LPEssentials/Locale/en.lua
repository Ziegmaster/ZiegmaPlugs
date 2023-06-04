_G.Texts = {};
Texts.UI = {};
Texts.UI.Hint = "Lotro Points Essentials " .. plugin:GetVersion() .. " by " .. plugin:GetAuthor() ..
"\n\n" ..
"This plugin counts defeated enemies for each group member and tracks their deed progression." ..
"\n" ..
"Press start to start your session." ..
"\n\n" ..
"Works at character render distance." ..
"\n" ..
"Supported regions: Ered Luin, Bree, Shire, Wraith of Water(Fornost)." ..
"\n" ..
"Also supports racial slayer deeds for beornings." ..
"\n" ..
"We do not recommend using it in a raid, as well as changing the composition of the group after the start of the session due to Lotro API issues." ..
"\n\n\n" ..
"Found a bug? Have an idea how to improve the plugin? There is my Discord: Ziegmaster#2410" ..
"\n" ..
"Good luck with your LP farm.";
Texts.UI.Options = {
    LocaleLabel = "Change locale\nPlugin will be reloaded",
    SimulateAcceleration = "Simulate deed acceleration\n (For your character)",
    AnyDist = "Work at any distance",
    AlertsEnabled = "Show progress alerts",
    AlertsStyle = "Style",
    AlertsStyleTitle = "Alerts style",
    AlertsWindowWidth = "Width",
    AlertsWindowHeight = "Height",
    AlertExample1 = "Example 1",
    AlertExample2 = "Example 2",
    AlertExample3 = "Example 3",
    AlertExample1Text = "Lorem ipsum dolor sit amet",
    AlertExample2Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    AlertExample3Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    AlertsBackgroundOpacity = "Background opacity",
    AlertsFontLabel = "Font",
    Red = "Red",
    Green = "Green",
    Blue = "Blue",
    Alpha = "Alpha channel",
    PlayerTrackerEnabled = "Show interfering players",
}
Texts.UI.PlayerTracker = {
    InterferingPlayers = "Interfering players",
    InvitePlayer = "Invite",
}
Texts.UI.EffectTracker = {
    SlayerDeedAcceleration = "Slayer Deed Acceleration",
}
Texts.UI.PressStart = "Press start";
Texts.UI.TFA = "TFA";
Texts.UI.Buttons = {
    Start = "Start",
    Reset = "Reset",
    Parser = "Parser",
    Debug = "Debug",
};
Texts.Parser = {
    LocalPlayerAlias = "Your mighty blow",
    DefeatSearchPattern = "^(.+) defeated ?[the]- (.+)%.",
    DeedsFound = "Deeds Found:",
    NoDeeds = "No deeds found for this creature.",
    ProgressAchieved = "Progress achieved.",
    ProgressDenied = "Progress denied.",
};
Texts.Bestiary = {};
Texts.Bestiary.Locations = {
    EredLuin = "Ered Luin",
    Shire = "Shire",
    Bree = "Bree-land",
    NorthDowns = "North Downs",
    Elves = "Elves",
    Men = "Men",
    Dwarves = "Dwarves",
    Hobbits = "Hobbits",
    Beornings = "Beornings",
};
Texts.Bestiary.Deeds = {};
Texts.Bestiary.Deeds.Slayer = {};
Texts.Bestiary.Deeds.Slayer.Bree = {
    Neekerbreeker = "Neekerbreeker-slayer",
    SickleFly = "Sickle-fly Slayer",
    Orc = "Orc-slayer",
    Wight = "Wight-slayer",
    Barghest = "Barghest-slayer",
    GraveDigger = "Grave-digger",
    NemesisOfTheFallen = "Nemesis of the Fallen",
    Woodsman = "Bree-land Woodsman",
    BroodHunter = "Brood-hunter",
    Brigand = "Brigand-slayer",
    Spider = "Spider-slayer",
};
Texts.Bestiary.Deeds.Slayer.Shire = {
    Slug = "Slug-slayer",
    Spider = "Spider-slayer",
    Wolf = "Wolf-slayer",
    Brigand = "Brigand-slayer",
    HarvestFly = "Harvest-fly Slayer",
    Goblin = "Goblin-slayer",
};
Texts.Bestiary.Deeds.Slayer.EredLuin = {
    Hendroval = "Hendroval-slayer",
    Spider = "Spider-slayer",
    Wolf = "Wolf-slayer",
    Brigand = "Brigand-slayer",
    Goblin = "Goblin-slayer",
};
Texts.Bestiary.Deeds.Slayer.NorthDowns = {
    Orc = "Orc-slayer",
    Goblin = "Goblin-slayer",
    Warg = "Warg-slayer",
};
Texts.Bestiary.Deeds.Slayer.Beornings = {
    EnmityOfTheGoblins = "Enmity of the Goblins",
    EnmityOfTheSpiders = "Enmity of the Spiders",
};

Texts.Bestiary.Creatures = {};

Texts.Bestiary.Creatures.EredLuin = {};
Texts.Bestiary.Creatures.EredLuin.Goblin = {
    "Blue-crag Sentinel",
    "Blue-crag Defiler",
    "Blue-crag Gouger",
    "Blue-crag Skirmisher",
    "Blue-crag Despoiler",
    "Blue-crag Goblin",
    "Blue-crag Stinger",
    "Blue-crag Scrapper",
    "Blue-crag Slicer",
    "Blue-crag Sapper",
    "Blue-crag Hurler",
    "Blue-crag Shielder",
    "Blue-crag Demolisher",
    "Pampraush",
    "Durglup",
    "Gazrîp",
};
Texts.Bestiary.Creatures.EredLuin.Wolf = {
    "Howling Grey Wolf",
    "Wild Grey Wolf",
    "Lone Grey Wolf",
}
Texts.Bestiary.Creatures.EredLuin.Spider = {
    "Snow-spinner Lurker",
    "Biting Snow-spinner",
    "Snow-spinner Trapper",
    "Snow-spinner Hunter",
    "Skittering Snow-spinner",
    "Snow-spinner Ambusher",
    "Snow-spinner Mother",
    "Naegarch",
}
Texts.Bestiary.Creatures.EredLuin.Hendroval = {
    "Cliff Hendroval",
    "Hendroval Canopy-darter",
}
Texts.Bestiary.Creatures.EredLuin.Brigand = {
    "Dourhand Warrior",
    "Sturdy Dourhand",
    "Dourhand Chief",
    "Dourhand Armsman",
    "Stout Dourhand",
    "Dourhand Night-watch",
    "Dourhand Commander",
    "Skíthi Blackhand",
    "Starkath",
}

Texts.Bestiary.Creatures.Shire = {};
Texts.Bestiary.Creatures.Shire.Wolf = {
    "Snarling Wolf",
    "Wolf Leader",
    "Wolf",
    "Bold Wolf",
    "Wolf Hunter",
}
Texts.Bestiary.Creatures.Shire.Slug = {
    "Putrid Bog-slug",
    "Reeking Bog-slug",
}
Texts.Bestiary.Creatures.Shire.Brigand = {
    "Brigand Knave",
    "Brigand Waylayer",
    "Brigand Poacher",
    "Brigand Robber",
    "Brigand Boss",
    "Big Tom",
}
Texts.Bestiary.Creatures.Shire.HarvestFly = {
    "Small Harvest-fly",
    "Harvest-fly",
}
Texts.Bestiary.Creatures.Shire.Spider = {
    "Greenfields Biter",
    "Greenfields Tree-weaver",
    "Greenfields Queen",
    "Bindbole Weaver",
    "Bindbole Spinner",
}
Texts.Bestiary.Creatures.Shire.Goblin = {
    "Gramsfoot Hurler",
    "Gramsfoot Guard",
    "Wild Gramsfoot",
    "Gramsfoot Defiler",
    "Gramsfoot Battler",
    "Gramsfoot Piercer",
    "Gramsfoot Advancer",
    "Zanshík",
}

Texts.Bestiary.Creatures.Bree = {};
Texts.Bestiary.Creatures.Bree.Goblin = {
    "Midgewater Defender",
    "Midgewater Sapper",
    "Midgewater Warrior",
    "Midgewater Scout",
    "Gurzrum",
    "Gurzstâz",
    "Zau-gûjâb",
};
Texts.Bestiary.Creatures.Bree.Spider = {
    "Brood Lurker",
    "Chetwood Spinner",
    "Chetwood Spider",
    "Marsh Spider",
    "Marsh Brood-watcher",
    "Marsh Queen",
};
Texts.Bestiary.Creatures.Bree.Brigand = {
    "Blackwold",
    "Blackwold Poacher",
    "Blackwold Scout",
    "Blackwold Lookout",
    "Sergeant Applewood",
    "Blackwold Wolf-keeper",
    "Jagger Jack",
    "Blackwold Outlaw",
    "Cole Sickleleaf",
    "Blackwold Supervisor",
    "Jasper Mudbottom",
    "Southern Knave",
    "Southern Brawler",
    "Southern Archer",
    "Southern Blade-bearer",
    "Sharkey's Lieutenant",
    "Southern Bowman",
    "Southern Footpad",
    "Southern Attacker",
    "Dirk Hawthorn",
    "Southern Robber",
    "Southern Lieutenant",
    "Southern Scout",
    "Southern Harridan",
    "Patric Bilberry",
    "Southern Warrior",
    "Vance Waithman",
    "Blackwold Thief",
    "Southern Captain",
    "Southern Raider",
    "Southern Skirmisher",
    "Southern Leader",
    "Eilert Crampbark",
    "Southern Outlaw",
    "Southern Lookout",
    "Southern Poacher",
    "Aldis Oatbearer",
    "Southern Watch-captain",
};
Texts.Bestiary.Creatures.Bree.Huorn = {
    "Wretched Barrow-maple",
    "Dreadful Barrow-maple",
};
Texts.Bestiary.Creatures.Bree.Orc = {
    "Tarkrîp Grunt",
    "Tarkrîp Killer",
    "Tarkrîp Prowler",
    "Tarkríp Blade",
    "Tarkríp Archer",
    "Tarkríp Brute",
    "Red Reaver",
    "Gurat-kafak",
};
Texts.Bestiary.Creatures.Bree.Barghest = {
    "Foul Barghest",
    "Stout-grip Barghest",
    "Vile Barghest",
    "Strong-grip Barghest",
    "Howling Barrow-hound",
};
Texts.Bestiary.Creatures.Bree.Neekerbreeker = {
    "Neekerbreeker Burrower",
    "Dun Neekerbreeker",
    "Green Neekerbreeker",
    "Marsh Neekerbreeker",
    "Biting Neekerbreeker",
};
Texts.Bestiary.Creatures.Bree.SickleFly = {
    "Greater Sickle-fly",
    "Sickle-fly",
};
Texts.Bestiary.Creatures.Bree.Wight = {
    "Barrow-wight",
    "Noxious Barrow-wight",
    "Barrow-wight Marksman",
    "Barrow-wight Archer",
    "Barrow-wight Warrior",
    "Rotting Barrow-wight",
    "Corintur",
};
Texts.Bestiary.Creatures.Bree.Warg = {
    "Baugarch",
}
Texts.Bestiary.Creatures.Bree.Tomb = {};
Texts.Bestiary.Creatures.Bree.Tomb.Spider = {
    "Barrow-spider",
    "Gwigon",
};
Texts.Bestiary.Creatures.Bree.Tomb.Wight = {
    "Noxious Barrow-warden",
    "Barrow-warden",
};
Texts.Bestiary.Creatures.Bree.Tomb.Spirit = {
    "Barrow-spirit",
}
Texts.Bestiary.Creatures.NorthDowns = {};
Texts.Bestiary.Creatures.NorthDowns.Fornost = {};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Orc = {
    "Blogmal Raider",
    "Blogmal Pillager",
    "Blogmal Warlord",
};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Goblin = {
    "Blogmal Spear-hurler",
    "Blogmal Guard",
    "Zhurmat",
};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Warg = {
    "Warg Ruins-breaker",
    "Warg Ruins-howler",
}
