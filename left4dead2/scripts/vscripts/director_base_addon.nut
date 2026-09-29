DirectorBaseAddon <-
{
    settings =
    {
        smoker_chance = 50,
        boomer_chance = 50,
        hunter_chance = 50,
        spitter_chance = 50,
        jockey_chance = 50,
        charger_chance = 50,
        tank_chance = 50,
        witch_chance = 50,
		
        l4d1_smoker_chance = 50,
        l4d1_boomer_chance = 50,
        l4d1_hunter_chance = 50,
        l4d1_spitter_chance = 50,
        l4d1_jockey_chance = 50,
        l4d1_charger_chance = 50,
        l4d1_tank_chance = 50,
        l4d1_witch_chance = 50

    },

    S = null,

    function Init()
    {
        S = settings;
        getroottable().TosdaConfig <- S;
    },

    function SerializeSettings()
    {
        local fileName = "map_specific_si/settings.cfg";
        local data = "{";

        foreach (key, val in settings)
            data += "\n\t" + key + " = " + val + ",";

        data += "\n}";
        StringToFile(fileName, data);
    },

    function ParseSettings()
    {
        local fileName = "map_specific_si/settings.cfg";
        local file = FileToString(fileName);

        if (file == null)
        {
            this.SerializeSettings();
            this.Init();
            return;
        }

        try
        {
            local data = compilestring("return " + file)();

            foreach (key, val in settings)
            {
                if (key in data)
                    settings[key] = data[key];
            }
        }
        catch (e)
        {
            Msg("tosda config error, restoring defaults.\n");
            this.SerializeSettings();
        }

        this.Init();
    }
};

DirectorBaseAddon.ParseSettings();

local Root = getroottable();
local Config = Root.TosdaConfig;
local mapname = Director.GetMapName();

local L4D1_PatientSmokers =
[
    "models/infected/ceda_smoker_l4d1.mdl",
    "models/infected/patient_smoker.mdl"
];
local L4D1_C11Chargers =
[
    "models/infected/roadcrew_charger_L4d1.mdl",
    "models/infected/riot_charger_l4d1.mdl"
];
local L4D1_C11Smokers =
[
    "models/infected/baggage_smoker.mdl",
    "models/infected/pilot_smoker.mdl"
];
local L4D1_C12Smokers =
[
    "models/infected/rural_smoker_l4d1.mdl",
    "models/infected/soldier_smoker.mdl"
];
local L4D1_C12Chargers =
[
    "models/infected/rural_charger_l4d1.mdl",
    "models/infected/soldier_charger_l4d1.mdl"
];
local L4D2_DTCharger =
[
    "models/infected/urban_charger.mdl",
    "models/infected/Ceda_Charger.mdl",
    "models/infected/fhs_charger.mdl"
];
local L4D2_DTHunter =
[
    "models/infected/ceda_hunter.mdl",
    "models/infected/loose_hooded_hunter.mdl"
];
local L4D2_HRSmoker =
[
    "models/infected/roadcrew_smoker.mdl",
    "models/infected/mud_smoker.mdl"
];
local L4D2_SFSmoker =
[
    "models/infected/militia_smoker.mdl",
    "models/infected/mud_smoker.mdl"
];
local L4D2_SFSpitter =
[
    "models/infected/ratman.mdl",
    "models/infected/fisherman_spitter.mdl"
];
local L4D2_PRTanks =
[
    "models/infected/riot_tank.mdl",
    "models/infected/military_hulk.mdl"
];
local L4D2_PRChargers =
[
    "models/infected/riot_charger.mdl",
    "models/infected/soldier_charger.mdl"
];
local TosdaPrecacheSets =
[
    L4D1_PatientSmokers,
    L4D1_C11Chargers,
    L4D1_C11Smokers,
    L4D1_C12Smokers,
    L4D1_C12Chargers,
    L4D2_DTCharger,
    L4D2_DTHunter,
    L4D2_HRSmoker,
    L4D2_SFSmoker,
    L4D2_SFSpitter,
    L4D2_PRTanks,
    L4D2_PRChargers,
    [
        "models/infected/baggage_hunter.mdl",
        "models/infected/ceda_charger_l4d1.mdl",
        "models/infected/ceda_charger.mdl",
        "models/infected/smoker_l4d1_subway.mdl",
        "models/infected/vagrant_smoker.mdl",
        "models/infected/survivor_smoker.mdl",
        "models/infected/smoker_l4d1_mud.mdl",
        "models/infected/religious_smoker.mdl",
        "models/infected/roadcrew_smoker_l4d1.mdl",
        "models/infected/ceda_smoker.mdl",
        "models/infected/soldier_smoker.mdl",
        "models/infected/roadcrew_smoker.mdl",
        "models/infected/fatasses/beard/boomer.mdl",
        "models/infected/fatasses/2/boomer.mdl",
        "models/infected/fatasses/1/boomer_l4d1.mdl",
        "models/infected/fatasses/roadcrew/boomer.mdl",
		"models/infected/fatasses/roadcrew/boomer_l4d1.mdl",
        "models/infected/fatasses/1/boomer.mdl",
        "models/infected/fatasses/boomer_l4d1.mdl",
        "models/infected/shirtless_hunter_l4d1.mdl",
        "models/infected/literal_hunter.mdl",
        "models/infected/soldier_hunter.mdl",
        "models/infected/survivor_hunter.mdl",
        "models/infected/spitter_nurse.mdl",
        "models/infected/spitter_l4d1.mdl",
        "models/infected/screamer_jockey.mdl",
        "models/infected/jockey_l4d1.mdl",
        "models/infected/clown_jockey.mdl",
        "models/infected/swamp_jockey.mdl",
        "models/infected/charger_l4d1.mdl",
        "models/infected/roadcrew_charger.mdl",
        "models/infected/soldier_charger.mdl",
        "models/infected/military_hulk_l4d1.mdl",
        "models/infected/clown_hulk.mdl",
        "models/infected/rayford_tank.mdl",
        "models/infected/roadcrew_hulk.mdl",
		"models/infected/cashier_witch.mdl"
		"models/infected/police_hunter.mdl"
		"models/infected/oaks_witch.mdl"
		"models/infected/mutated_smoker.mdl"
    ]
];

function TosdaPrecacheModels(sets)
{
    local seen = {};

    foreach (arr in sets)
    {
        foreach (model in arr)
        {
            if (!(model in seen))
            {
                seen[model] <- true;
                PrecacheModel(model);
            }
        }
    }
}

TosdaPrecacheModels(TosdaPrecacheSets);

TosdaSpawn <-
{
    RandomModel = function(models)
    {
        if (models == null || models.len() <= 0)
            return null;

        return models[RandomInt(0, models.len() - 1)];
    },

    RollChance = function(chance)
    {
        if (chance <= 0)
            return false;

        if (chance >= 100)
            return true;

        return RandomInt(1, 100) <= chance;
    },
	
	// to the guy that had this mod incompatible because of 8 player mod, im sorry i still used GetSurvivorSet. ifffff GetSurvivorSet made it incompatible
	
	HandleSmoker = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();
		local chance = (survivorSet == 1)
			? Config.l4d1_smoker_chance
			: Config.smoker_chance;

		if(!this.RollChance(chance))
			return;
		
		if(mapname.find("c7m") != null)
			SI.SetModel("models/infected/mutated_smoker.mdl");
		else if(mapname.find("c8m4") != null)
		{
			SI.SetModel(this.RandomModel(L4D1_PatientSmokers));

			local modelName = NetProps.GetPropString(SI, "m_ModelName");

			if(modelName == "models/infected/patient_smoker.mdl")
			{
				SI.SetBodygroup(0, RandomInt(0, 1));
				SI.SetBodygroup(2, RandomInt(0, 1));
			}
		}
		else if(mapname.find("c8m2") != null)
			SI.SetModel("models/infected/smoker_l4d1_subway.mdl");
		else if(mapname.find("c8m3") != null || mapname.find("c9m1") != null)
			SI.SetModel("models/infected/vagrant_smoker.mdl");
		else if(mapname.find("c8m5") != null)
			SI.SetModel("models/infected/ceda_smoker_l4d1.mdl");
		else if(mapname.find("c9m2") != null || mapname.find("c11m1") != null)
		{
			SI.SetModel("models/infected/survivor_smoker.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 2));
		}
		else if(mapname.find("c10m2") != null)
			SI.SetModel("models/infected/smoker_l4d1_mud.mdl");
		else if(mapname.find("c10m3") != null)
			SI.SetModel("models/infected/religious_smoker.mdl");
		else if(mapname.find("c11m3") != null)
			SI.SetModel("models/infected/roadcrew_smoker_l4d1.mdl");
		else if(mapname.find("c11m4") != null || mapname.find("c11m5") != null)
			SI.SetModel(this.RandomModel(L4D1_C11Smokers));
		else if(mapname.find("c12m") != null)
			SI.SetModel(this.RandomModel(L4D1_C12Smokers));
		else if(mapname.find("c1m") != null)
			SI.SetModel("models/infected/ceda_smoker.mdl");
		else if(mapname.find("c5m") != null)
		{
			SI.SetModel("models/infected/soldier_smoker.mdl");
			SI.SetBodygroup(1, RandomInt(0, 2));
			SI.SetBodygroup(2, RandomInt(0, 2));
		}
		else if(mapname.find("c6m") != null)
		{
			SI.SetModel("models/infected/survivor_smoker.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 2));
		}
		else if(mapname.find("c3m") != null)
			SI.SetModel(this.RandomModel(L4D2_SFSmoker));
		else if(mapname.find("c4m4") != null || mapname.find("c4m5") != null)
			SI.SetModel(this.RandomModel(L4D2_HRSmoker));
		else if(mapname.find("c4m") != null)
		{
			SI.SetModel("models/infected/roadcrew_smoker.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
		}

		// to prevent gibs from kinda leaking out??
		SI.SetBodygroup(3, 0);
		SI.SetBodygroup(4, 0);
		SI.SetBodygroup(5, 0);
		SI.SetBodygroup(6, 0);
		SI.SetBodygroup(7, 0);
	},

	HandleBoomer = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();
		local chance = (survivorSet == 1)
			? Config.l4d1_boomer_chance
			: Config.boomer_chance;

		if(!this.RollChance(chance))
			return;

		if(mapname.find("c8m4") != null)
			SI.SetModel("models/infected/fatasses/boomer_l4d1.mdl");
		else if(mapname.find("c11m3") != null)
			SI.SetModel("models/infected/fatasses/roadcrew/boomer_l4d1.mdl");
		else if(mapname.find("c9m") != null || mapname.find("c2m5") != null || mapname.find("c6m") != null)
		{
			SI.SetModel("models/infected/fatasses/beard/boomer.mdl");
			SI.SetBodygroup(1, RandomInt(0, 1));
			SI.SetBodygroup(2, RandomInt(0, 1));
		}
		else if(mapname.find("c2m1") != null || mapname.find("c2m2") != null || mapname.find("c2m3") != null || mapname.find("c2m4") != null)
			SI.SetModel("models/infected/fatasses/2/boomer.mdl");
		else if(mapname.find("c3m") != null)
			SI.SetModel("models/infected/fatasses/1/boomer_l4d1.mdl");
		else if(mapname.find("c4m") != null)
			SI.SetModel("models/infected/fatasses/roadcrew/boomer.mdl");
		else if(mapname.find("c5m1") != null || mapname.find("c5m4") != null)
			SI.SetModel("models/infected/fatasses/1/boomer.mdl");
	},

	HandleHunter = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();

		if(survivorSet == 1)
		{
			if(this.RollChance(15))
			{
				SI.SetModel("models/infected/shirtless_hunter_l4d1.mdl");
				return;
			}

			if(!this.RollChance(Config.l4d1_hunter_chance))
				return;

			if(mapname.find("c10m1") != null || mapname.find("c12m1") != null)
				SI.SetModel("models/infected/literal_hunter.mdl");
			else if(mapname.find("c12m2") != null || mapname.find("c12m3") != null || mapname.find("c12m4") != null || mapname.find("c12m5") != null)
			{
				SI.SetModel("models/infected/soldier_hunter.mdl");
				SI.SetBodygroup(0, RandomInt(0, 3));
				SI.SetBodygroup(1, RandomInt(0, 2));
			}
			else if(mapname.find("c11m4") != null || mapname.find("c11m5") != null)
				SI.SetModel("models/infected/baggage_hunter.mdl");
		}
		else
		{
			if(!this.RollChance(Config.hunter_chance))
				return;

			if(mapname.find("c1m") != null)
				SI.SetModel(this.RandomModel(L4D2_DTHunter));
			else if(mapname.find("c4m4") != null || mapname.find("c4m5") != null)
				SI.SetModel("models/infected/police_hunter.mdl");
			else if(mapname.find("c5m") != null)
			{
				SI.SetModel("models/infected/soldier_hunter.mdl");
				SI.SetBodygroup(0, RandomInt(0, 3));
				SI.SetBodygroup(1, RandomInt(0, 2));
			}
			else if(mapname.find("c6m") != null)
			{
				SI.SetModel("models/infected/survivor_hunter.mdl");
				NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 2));
			}
		}
	},

	HandleSpitter = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();

		if(survivorSet == 1)
		{
			SI.SetModel("models/infected/spitter_l4d1.mdl");

			if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
			{
				if(this.RollChance(Config.l4d1_spitter_chance))
					SI.SetModel("models/infected/spitter_nurse.mdl");
			}

			return;
		}

		if(mapname.find("c1m3") != null)
			SI.SetModel("models/infected/spitter_nurse.mdl");
		else if(mapname.find("c3m") != null)
			SI.SetModel(this.RandomModel(L4D2_SFSpitter));
	},

	HandleJockey = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();

		if(survivorSet == 1)
		{
			SI.SetModel("models/infected/jockey_l4d1.mdl");

			if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
			{
				if(this.RollChance(Config.l4d1_jockey_chance))
					SI.SetModel("models/infected/screamer_jockey.mdl");
			}

			return;
		}

		if(mapname.find("c2m") != null)
		{
			SI.SetModel("models/infected/clown_jockey.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 6));
		}
		else if(mapname.find("c3m") != null)
			SI.SetModel("models/infected/swamp_jockey.mdl");
	},

	HandleCharger = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();

		if(survivorSet == 1)
		{
			SI.SetModel("models/infected/charger_l4d1.mdl");

			if(!this.RollChance(Config.l4d1_charger_chance))
				return;

			if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
				SI.SetModel("models/infected/ceda_charger_l4d1.mdl");
			else if(mapname.find("c7m") != null)
				SI.SetModel("models/infected/ceda_charger.mdl");
			else if(mapname.find("c11m3") != null)
				SI.SetModel(this.RandomModel(L4D1_C11Chargers));
			else if(mapname.find("c11m1") != null || mapname.find("c8m3") != null)
				SI.SetModel("models/infected/riot_charger_l4d1.mdl");
			else if(mapname.find("c12m") != null)
				SI.SetModel(this.RandomModel(L4D1_C12Chargers));

			return;
		}

		if(mapname.find("c1m") != null)
		{
			if(!this.RollChance(Config.charger_chance))
				return;

			if(mapname.find("c1m2") != null)
				SI.SetModel(this.RandomModel(L4D2_DTCharger));
			else
				SI.SetModel(L4D2_DTCharger[RandomInt(0, 1)]);
		}
		else if(mapname.find("c4m") != null)
		{
			if(!this.RollChance(Config.charger_chance))
				return;

			SI.SetModel("models/infected/roadcrew_charger.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
		}
		else if(mapname.find("c5m") != null)
		{
			if(!this.RollChance(Config.charger_chance))
				return;

			if(!("RiotChargerModExists" in Root))
				SI.SetModel(this.RandomModel(L4D2_PRChargers));
			else
				SI.SetModel("models/infected/soldier_charger.mdl");
		}
	},

	HandleTank = function(SI)
	{
		local survivorSet = Director.GetSurvivorSet();
		local chance = (survivorSet == 1)
			? Config.l4d1_tank_chance
			: Config.tank_chance;

		if(!this.RollChance(chance))
			return;

		if(mapname.find("c10m4") != null || mapname.find("c12m") != null)
		{
			SI.SetModel("models/infected/military_hulk_l4d1.mdl");
			return;
		}

		if(mapname.find("c2m") != null)
		{
			SI.SetModel("models/infected/clown_hulk.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 6));
		}
		else if(mapname.find("c6m") != null)
			SI.SetModel("models/infected/rayford_tank.mdl");
		else if(mapname.find("c4m") != null)
		{
			SI.SetModel("models/infected/roadcrew_hulk.mdl");
			NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
		}
		else if(mapname.find("c5m") != null)
			SI.SetModel(this.RandomModel(L4D2_PRTanks));
	},
	HandleWitch = function(witch)
	{
		local survivorSet = Director.GetSurvivorSet();
		local chance = (survivorSet == 1)
			? Config.l4d1_witch_chance
			: Config.witch_chance;

		if (!this.RollChance(chance))
			return;

		if (mapname.find("c1m3") != null || mapname.find("c8m4") != null)
			witch.SetModel("models/infected/cashier_witch.mdl");
		else if (mapname.find("c2m2") != null || mapname.find("c2m3") != null)
			witch.SetModel("models/infected/oaks_witch.mdl");
	},
    OnGameEvent_player_spawn = function(event)
    {
        local SI = GetPlayerFromUserID(event.userid);

        if (SI == null || !SI.IsValid() || SI.IsSurvivor())
            return;

        switch (SI.GetZombieType())
        {
            case 1:
                this.HandleSmoker(SI);
                break;
            case 2:
                this.HandleBoomer(SI);
                break;
            case 3:
                this.HandleHunter(SI);
                break;
            case 4:
                this.HandleSpitter(SI);
                break;
            case 5:
                this.HandleJockey(SI);
                break;
            case 6:
                this.HandleCharger(SI);
                break;
            case 8:
                this.HandleTank(SI);
                break;
        }
    },
	OnGameEvent_witch_spawn = function(event)
	{
		local witch = EntIndexToHScript(event.witchid);
		this.HandleWitch(witch);
	}
};

__CollectEventCallbacks(
    TosdaSpawn,
    "OnGameEvent_",
    "GameEventCallbacks",
    RegisterScriptGameEventListener
);
