_G.Texts = {};

Texts.ShellCommands = {
    Help = "<rgb=#00FFFF><rgb=#FFBF00>" .. Plugin:GetName() .. "</rgb> команды:" ..
    "\n<rgb=#FFBF00>/lpe <rgb=#bfff00>reload</rgb></rgb>\nПерезагрузить плагин (может пригодиться, если возникли неполадки)." ..
    "\n<rgb=#FFBF00>/lpe <rgb=#bfff00>restore</rgb></rgb>\nВосстановить настройки по умолчанию и перезагрузить плагин.</rgb>",
}

Texts.UI = {};

Texts.UI.DevMessage = "Lotro Points Essentials " .. Plugin:GetVersion() .. " by " .. Plugin:GetAuthor() ..
"\n\n" ..
"Данный плагин остлеживает прогресс деяний на убийство для каждого члена группы." ..
"\n\n" ..
"Работает в землях Бри, Шире, Эред Луине, инстансе \"Гнев воды\"(Форност)." ..
"\n" ..
"Также поддерживает расовые деяния беорнингов." ..
"\n" ..
"Не рекомендуется использовать в рейде, а также менять состав группы после старта сессии." ..
"\n\n" ..
"Нажмите Ctrl + \\ чтобы переместить элементы интерфейса." ..
"\n\n" ..
"/lpe help - список команд." ..
"\n\n" ..
"\n                . \" \" .        . \" \" ." ..
"\n                I      I      /      /        Нашли баг?"..
"\n                I      I    /      /"..
"\n                I      I  /      /                   Есть идеи по доработке плагина?"..
"\n                I      I/     ---. _"..
"\n                I       __/     /     ;                  Пишите в Дискорде: никнейм -> ziegmaster"..
"\n                I     /     )    /     /"..
"\n                I   /      /_ /\\__/\\                 Если хотите отблагодарить"..
"\n                I /      /              I"..
"\n                (        \\             I             Отправляйте плюшки Lovelive на сервере Brandywine"..
"\n                 \\                   /"..
"\n                  I                  I        Удачного фарма!"..
"\n                  I__________I";

Texts.UI.MainWindowHeader = {
    Main = "Главная",
    Settings = "Настройки",
    Close = "Закрыть",
};

Texts.UI.Start = "СТАРТ";
Texts.UI.Stop = "ЗАВЕРШИТЬ";
Texts.UI.TFA = "Игрок слишком далеко";

Texts.UI.Settings = {
    LocaleLabel = "Язык",
    AlertsLabel = "Оповещения",
    SimulateAcceleration = "Симулировать ускорение деяний\n (Для вашего персонажа)",
    AnyDist = "Работать на любом расстоянии",
    AlertsEnabled = "Показывать оповещения о прогрессе",
    AlertsWindowWidth = "Ширина",
    AlertsWindowHeight = "Высота",
    AlertExample1 = "Пример 1",
    AlertExample2 = "Пример 2",
    AlertExample3 = "Пример 3",
    AlertExample1Text = "Lorem ipsum dolor sit amet",
    AlertExample2Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    AlertExample3Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    AlertsBackgroundOpacity = "Видимость фона",
    AlertsFontLabel = "Шрифт",
    Red = "Красный",
    Green = "Зеленый",
    Blue = "Синий",
    Alpha = "Альфа канал",
}

Texts.UI.EffectTracker = {
    SlayerDeedAcceleration = "Враг за двух",
}

Texts.Parser = {
    LocalPlayerAlias = "Вы",
    DefeatSearchPattern = "^(.+) наносит?[е]- сокрушительный удар. (.+) падает замертво%.",
    LPSearchPattern = "Получено (.+) марок",
};

Texts.Bestiary = {};
Texts.Bestiary.Locations = {
    EredLuin = "Эред Луин",
    Shire = "Шир",
    Bree = "Земли Бри",
    NorthDowns = "Северное нагорье",
    Elves = "Эльфы",
    Men = "Люди",
    Dwarves = "Гномы",
    Hobbits = "Хоббиты",
    Beornings = "Беорнинги",
};
Texts.Bestiary.Deeds = {};
Texts.Bestiary.Deeds.Slayer = {};
Texts.Bestiary.Deeds.Slayer.Bree = {
    Neekerbreeker = "Победитель кровопросцев",
    SickleFly = "Бич серпиц",
    Orc = "Бич орков",
    Wight = "Гроза умертвий",
    Barghest = "Бич баргестов",
    GraveDigger = "Могильщик",
    NemesisOfTheFallen = "Заклятый враг падших",
    Woodsman = "Лесоруб из Бри",
    BroodHunter = "Охота на проклятое племя",
    Brigand = "Гроза разбойников",
    Spider = "Гроза пауков",
};
Texts.Bestiary.Deeds.Slayer.Shire = {
    Slug = "Гроза слизней",
    Spider = "Гроза пауков",
    Wolf = "Убийца волков",
    Brigand = "Гроза разбойников",
    HarvestFly = "Гроза певчих цикад",
    Goblin = "Истребитель гоблинов",
};
Texts.Bestiary.Deeds.Slayer.EredLuin = {
    Hendroval = "Гроза эндровалов",
    Spider = "Гроза пауков",
    Wolf = "Убийца волков",
    Brigand = "Гроза злодеев-Крепкохватов",
    Goblin = "Истребитель гоблинов",
};
Texts.Bestiary.Deeds.Slayer.NorthDowns = {
    Orc = "Истребитель орков",
    Goblin = "Истребитель гоблинов",
    Warg = "Истребитель варгов",
};
Texts.Bestiary.Deeds.Slayer.Beornings = {
    EnmityOfTheGoblins = "Укрощение гоблинов",
    EnmityOfTheSpiders = "Укрощение пауков",
};

Texts.Bestiary.Creatures = {};

Texts.Bestiary.Creatures.EredLuin = {};
Texts.Bestiary.Creatures.EredLuin.Goblin = {
    "Синеутесник-страж",--"Blue-crag Sentinel",
    "Синеутесник-осквернитель",--"Blue-crag Defiler",
    "Синеутесник-мошенник",--"Blue-crag Gouger",
    "Синеутесник-застрельщик",--"Blue-crag Skirmisher",
    "Синеутесник-расхититель",--"Blue-crag Despoiler",
    "Синеутесник",--"Blue-crag Goblin",
    "Синеутесник-стрелок",--"Blue-crag Stinger",
    "Синеутесник-задира",--"Blue-crag Scrapper",
    "Синеутесник-рубака",--"Blue-crag Slicer",
    "Синеутесник-огненосец",--"Blue-crag Sapper",
    "Синеутесник-метатель",--"Blue-crag Hurler",
    "Синеутесник-щитоносец",--"Blue-crag Shielder",
    "Синеутесник-разрушитель",--"Blue-crag Demolisher",
    "Пампруш",--"Pampraush",
    "Дурглуп",--"Durglup",
    "Газрип",--"Gazrîp",
};
Texts.Bestiary.Creatures.EredLuin.Wolf = {
    "Воющий серый волк",--"Howling Grey Wolf",
    "Дикий серый волк",--"Wild Grey Wolf",
    "Серый волк-одиночка",--"Lone Grey Wolf",
}
Texts.Bestiary.Creatures.EredLuin.Spider = {
    "Крадущийся снежный ткач",--"Snow-spinner Lurker",
    "Кусачий снежный ткач",--"Biting Snow-spinner",
    "Снежный ткач-силочник",--"Snow-spinner Trapper",
    "Снежный ткач-охотник",--"Snow-spinner Hunter",
    "Шустрый снежный ткач",--"Skittering Snow-spinner",
    "Снежный ткач-ловчий",--"Snow-spinner Ambusher",
    "Королева снежных ткачей",--"Snow-spinner Mother",
    "Наэгарх",--"Naegarch",
}
Texts.Bestiary.Creatures.EredLuin.Hendroval = {
    "Утесный эндровал",--"Cliff Hendroval",
    "Молниеносный эндровал",--"Hendroval Canopy-darter",
}
Texts.Bestiary.Creatures.EredLuin.Brigand = {
    "Крепкохват-воин",--"Dourhand Warrior",
    "Крепкохват-силач",--"Sturdy Dourhand",
    "Вожак Крепкохватов",--"Dourhand Chief",
    "Крепкохват-воитель",--"Dourhand Armsman", "Stout Dourhand",
    "Крепкохват-дозорный",--"Dourhand Night-watch",
    "Крепкохват-предводитель",--"Dourhand Commander",
    "Скити Черная Рука",--"Skíthi Blackhand",
    "Старкат",--"Starkath",
}

Texts.Bestiary.Creatures.Shire = {};
Texts.Bestiary.Creatures.Shire.Wolf = {
    "Рычащий волк",--"Snarling Wolf",
    "Вожак волков",--"Wolf Leader",
    "Волк",--"Wolf",
    "Дерзкий волк",--"Bold Wolf",
    "Охотящийся волк",--"Wolf Hunter",
}
Texts.Bestiary.Creatures.Shire.Slug = {
    "Гнилостный болотный слизень",--"Putrid Bog-slug",
    "Вонючий болотный слизень",--"Reeking Bog-slug",
}
Texts.Bestiary.Creatures.Shire.Brigand = {
    "Разбойник-прощелыга",--"Brigand Knave",
    "Таящаяся разбойница",--"Brigand Waylayer",
    "Разбойница",--"Brigand Poacher",
    "Разбойник-ворюга",--"Brigand Robber",
    "Главарь разбойников",--"Brigand Boss",
    "Верзила Том",--"Big Tom",
}
Texts.Bestiary.Creatures.Shire.HarvestFly = {
    "Малая певчая цикада",--"Small Harvest-fly",
    "Певчая цикада",--"Harvest-fly",
}
Texts.Bestiary.Creatures.Shire.Spider = {
    "Кусачий паук из Зеленых полей",--"Greenfields Biter",
    "Древесная ткачиха из Зеленых полей",--"Greenfields Tree-weaver",
    "Королева пауков из Зеленых полей",--"Greenfields Queen",
    "Дровяной паук-ткач",--"Bindbole Weaver",
    "Дровяной паук-прядильщик",--"Bindbole Spinner",
}
Texts.Bestiary.Creatures.Shire.Goblin = {
    "Гоблин-копьеметатель",--"Gramsfoot Hurler",
    "Страж из горы Грэм",--"Gramsfoot Guard",
    "Берсерк из горы Грэм",--"Wild Gramsfoot",
    "Осквернитель из горы Грэм",--"Gramsfoot Defiler",
    "Боец из горы Грэм",--"Gramsfoot Battler",
    "Стрелок из горы Грэм",--"Gramsfoot Piercer",
    "Воитель из горы Грэм",--"Gramsfoot Advancer",
    "Заншик",--"Zanshík",
}

Texts.Bestiary.Creatures.Bree = {};
Texts.Bestiary.Creatures.Bree.Goblin = {
    "Защитник из Комариных топей",--"Midgewater Defender",
    "Огненосец из Комариных топей",--"Midgewater Sapper",
    "Воин из Комариных топей",--"Midgewater Warrior",
    "Лазутчик из Комариных топей",--"Midgewater Scout",
    "Гурцрам",--Gurzrum",
    "Гурцтаз",--"Gurzstâz",
    "Зау-Гуджаб",--"Zau-gûjâb",
};
Texts.Bestiary.Creatures.Bree.Spider = {
    "Brood Lurker",--"Паук-охотник",
    "Четвудский прядильщик",--"Chetwood Spinner",
    "Chetwood Spider",--Chetwood Spider",
    "Болотный паук",--"Marsh Spider",
    "Болотный страж",--"Marsh Brood-watcher",
    "Королева болотных пауков",--"Marsh Queen",
};
Texts.Bestiary.Creatures.Bree.Brigand = {
    "Чернопустынник",--"Blackwold",
    "Грабитель из Черной пустоши",--"Blackwold Poacher",
    "Разведчица из Черной пустоши",--"Blackwold Scout",
    "Дозорный из Черной пустоши",--"Blackwold Lookout",
    "Сержант Ябблокс",--"Sergeant Applewood",
    "Укротительница волков из Черной пустоши",--"Blackwold Wolf-keeper",
    "Зубастый Джек",--"Jagger Jack",
    "Разбойница из Черной пустоши",--"Blackwold Outlaw",
    "Коул Серполист",--"Cole Sickleleaf",
    "Чернопустынник-надзиратель",--"Blackwold Supervisor",
    "Джаспер Поддон",--"Jasper Mudbottom",
    "Южанка-мошенница",--"Southern Knave",
    "Южанин-громила",--"Southern Brawler",
    "Южанка-лучница",--"Southern Archer", "Southern Lookout",
    "Южанка-разбойница",--"Southern Blade-bearer", "Southern Footpad", "Southern Outlaw",
    "Ставленник Шарку",--"Sharkey's Lieutenant",
    "Южанин-лучник",--"Southern Bowman",
    "Южанин-воин",--"Southern Attacker",
    "Дирк Шипарь",--"Dirk Hawthorn",
    "Южанин-грабитель",--"Southern Robber",
    "Ставленник южан",--"Southern Lieutenant",
    "Южанка-разведчица",--"Southern Scout",
    "Южанка-ведьма",--"Southern Harridan",
    "Патрик Билберри",--"Patric Bilberry",
    "Южанка-воительница",--"Southern Warrior",
    "Венс Вейтман",--"Vance Waithman",
    "Вор из Черной пустоши",--"Blackwold Thief",
    "Главарь южан",--"Southern Captain",
    "Южанка-налетчица",--"Southern Raider",
    "Южанин-налетчик",--"Southern Raider",
    "Южанин-застрельщик",--"Southern Skirmisher",
    "Предводитель южан",--"Southern Leader",
    "Эйлерт Косокор",--"Eilert Crampbark",
    "Южанин-разбойник",--"Southern Outlaw",
    "Южанка-браконьерша",--"Southern Poacher",
    "Алдис Овсон",--"Aldis Oatbearer",
    "Южанин - капитан дозорных",--"Southern Watch-captain",
};
Texts.Bestiary.Creatures.Bree.Huorn = {
    "Пожухлый могильный клен",--"Wretched Barrow-maple",
    "Устрашающий могильный клен",--"Dreadful Barrow-maple",
};
Texts.Bestiary.Creatures.Bree.Orc = {
    "Боец из клана Таркрип",--"Tarkrîp Grunt",
    "Убийца из клана Таркрип",--"Tarkrîp Killer",
    "Лазутчик из клана Таркрип",--"Tarkrîp Prowler",
    "Мечник из клана Таркрип",--"Tarkríp Blade",
    "Лучник из клана Таркрип",--"Tarkríp Archer",
    "Громила из клана Таркрип",--"Tarkríp Brute",
    "Рыжий Разбойник",--"Red Reaver",
    "Гурат-Кафак",--"Gurat-kafak",
};
Texts.Bestiary.Creatures.Bree.Barghest = {
    "Больной баргест",--"Foul Barghest",
    "Зубастый баргест",--"Stout-grip Barghest",
    "Лютый баргест",--"Vile Barghest",
    "Цепкий баргест",--"Strong-grip Barghest",
    "Воющая могильная гончая",--"Howling Barrow-hound",
};
Texts.Bestiary.Creatures.Bree.Neekerbreeker = {
    "Кровопросец-копальщик",--"Neekerbreeker Burrower",
    "Серый кровопросец",--"Dun Neekerbreeker",
    "Зеленый кровопросец",--"Green Neekerbreeker",
    "Болотный кровопросец",--"Marsh Neekerbreeker",
    "Кусачий кровопросец",--"Biting Neekerbreeker",
};
Texts.Bestiary.Creatures.Bree.SickleFly = {
    "Большая муха-серпица",--"Greater Sickle-fly",
    "Муха-серпица",--"Sickle-fly",
};
Texts.Bestiary.Creatures.Bree.Wight = {
    "Могильное умертвие",--"Barrow-wight",
    "Тлетворное могильное умертвие",--"Noxious Barrow-wight",
    "Могильное умертвие - стрелок",--"Barrow-wight Marksman",
    "Могильное умертвие - лучник",--"Barrow-wight Archer",
    "Могильное умертвие - воин",--"Barrow-wight Warrior",
    "Гниющее могильное умертвие",--"Rotting Barrow-wight",
    "Коринтур",--"Corintur",
};
Texts.Bestiary.Creatures.Bree.Warg = {
    "Баугарх",--"Baugarch",
}
Texts.Bestiary.Creatures.Bree.Tomb = {};
Texts.Bestiary.Creatures.Bree.Tomb.Spider = {
    "Могильный паук",--"Barrow-spider",
    "Гвигон",--"Gwigon",
};
Texts.Bestiary.Creatures.Bree.Tomb.Wight = {
    "Тлетворный хранитель курганов",--"Noxious Barrow-warden",
    "Хранитель курганов",--"Barrow-warden",
};
Texts.Bestiary.Creatures.Bree.Tomb.Spirit = {
    "Курганный дух",--"Barrow-spirit",
}
Texts.Bestiary.Creatures.NorthDowns = {};
Texts.Bestiary.Creatures.NorthDowns.Fornost = {};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Orc = {
    "Налетчик из клана Блогмал",--"Blogmal Raider",
    "Мародер из клана Блогмал",--"Blogmal Pillager",
    "Военный вожак клана Блогмал",--"Blogmal Warlord",
};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Goblin = {
    "Копьеметатель из клана Блогмал",--"Blogmal Spear-hurler",
    "Страж из клана Блогмал",--"Blogmal Guard",
    "Зурмат",--"Zhurmat",
};
Texts.Bestiary.Creatures.NorthDowns.Fornost.Warg = {
    "Свирепый варг Форноста",--"Warg Ruins-breaker",
    "Яростный варг Форноста",--"Warg Ruins-howler",
}