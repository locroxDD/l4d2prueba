local mapname = Director.GetMapName();

local PatientSmokers = ["models/infected/ceda_smoker_l4d1.mdl","models/infected/patient_smoker.mdl"];
local Fat = ["models/infected/fatasses/beard/boomer.mdl","models/infected/boomer_l4d1.mdl"];
local Witch = ["models/infected/witch.mdl","models/infected/cashier_witch.mdl"];
local C11Chargers = ["models/infected/roadcrew_charger_L4d1.mdl","models/infected/riot_charger_l4d1.mdl"];
local C12Smokers = ["models/infected/rural_smoker_l4d1.mdl","models/infected/soldier_smoker.mdl"];
local C12Chargers = ["models/infected/rural_charger_l4d1.mdl","models/infected/soldier_charger.mdl"];

local othermodels = [
    "models/infected/baggage_hunter.mdl",
    "models/infected/baggage_smoker.mdl",
    "models/infected/ceda_charger_l4d1.mdl",
	"models/infected/ceda_charger.mdl",
    "models/infected/smoker_l4d1_subway.mdl",
    "models/infected/vagrant_smoker.mdl",
    "models/infected/survivor_smoker.mdl",
    "models/infected/smoker_l4d1_mud.mdl",
    "models/infected/religious_smoker.mdl",
    "models/infected/roadcrew_smoker_l4d1.mdl",
    "models/infected/pilot_smoker.mdl",
    "models/infected/fatasses/boomer_l4d1.mdl",
    "models/infected/shirtless_hunter_l4d1.mdl",
    "models/infected/literal_hunter.mdl",
    "models/infected/spitter_nurse.mdl",
    "models/infected/spitter_l4d1.mdl",
    "models/infected/screamer_jockey.mdl",
    "models/infected/jockey_l4d1.mdl",
    "models/infected/charger2_l4d1.mdl",
    "models/infected/military_hulk_l4d1.mdl"
	"models/infected/soldier_hunter.mdl"
];

local PrecacheSets =
[

	Witch,
	PatientSmokers,
	Fat,
	C11Chargers,
	C12Smokers,
	C12Chargers,
	othermodels,

];

function PrecacheModels(sets)
{
    local seen = {};

    foreach(arr in sets)
    {
        foreach(model in arr)
        {
            if (!(model in seen))
            {
                seen[model] <- true;
                PrecacheModel(model);
            }
        }
    }
}

PrecacheModels(PrecacheSets);

Tosda_L4D1Spawn <-
{
	OnGameEvent_player_spawn = function(event)
	{
		local SI = GetPlayerFromUserID(event.userid)
		if(SI.IsValid() && !SI.IsSurvivor() && !SI.IsDead())
		{
			if (RandomInt(0,1) == 1)
			{
				if(SI.GetZombieType() == 1)
				{
					if(mapname.find("c8m4") != null)
					{
						SI.SetModel(PatientSmokers[RandomInt(0,1)]);
						local modelnimi = NetProps.GetPropString(SI, "m_ModelName");
						if (modelnimi == "models/infected/patient_smoker.mdl")
						{
							SI.SetBodygroup(0, RandomInt(0,1))
							SI.SetBodygroup(2, RandomInt(0,1))
						}
					}
					if(mapname.find("c8m2") != null)
						SI.SetModel("models/infected/smoker_l4d1_subway.mdl");
					if(mapname.find("c8m3") != null || mapname.find("c9m1") != null)
						SI.SetModel("models/infected/vagrant_smoker.mdl");
					if(mapname.find("c8m5") != null)
						SI.SetModel("models/infected/ceda_smoker_l4d1.mdl");
					if(mapname.find("c9m2") != null || mapname.find("c11m1") != null)
						SI.SetModel("models/infected/survivor_smoker.mdl");
					if(mapname.find("c10m2") != null)
						SI.SetModel("models/infected/smoker_l4d1_mud.mdl");
					if(mapname.find("c10m3") != null)
						SI.SetModel("models/infected/religious_smoker.mdl");
					if(mapname.find("c11m3") != null)
						SI.SetModel("models/infected/roadcrew_smoker_l4d1.mdl");
					if(mapname.find("c11m4") != null || mapname.find("c11m5") != null)
					{
						local roll = RandomInt(1, 100);
						if (roll <= 30)
						{
							SI.SetModel("models/infected/baggage_smoker.mdl");
						}
						else if (roll <= 80)
						{
							SI.SetModel("models/infected/pilot_smoker.mdl");
						}
					}
					if(mapname.find("c12m") != null)
						SI.SetModel(C12Smokers[RandomInt(0,1)]);
				}
				if(SI.GetZombieType() == 2)
				{
					if(mapname.find("c8m4") != null)
						SI.SetModel("models/infected/fatasses/boomer_l4d1.mdl");
					if(mapname.find("c9m") != null)
					{
						SI.SetModel(Fat[RandomInt(0,1)]);
						{
							SI.SetBodygroup(1, RandomInt(0,1))
							SI.SetBodygroup(2, RandomInt(0,1))
						}
					}
				}		
				if(SI.GetZombieType() == 3)
				{
					local roll = RandomInt(1, 100);
					if (roll <= 15)
					{
						SI.SetModel("models/infected/shirtless_hunter_l4d1.mdl");
					}
					else if (roll <= 65)
					{
						if(mapname.find("c10m1") != null || mapname.find("c12m1") != null)
							SI.SetModel("models/infected/literal_hunter.mdl");
						if(mapname.find("c12m2") != null || mapname.find("c12m3") != null || mapname.find("c12m4") != null || mapname.find("c12m5") != null)
						SI.SetModel("models/infected/soldier_hunter.mdl");
						if(mapname.find("c11m4") != null || mapname.find("c11m5") != null)
							SI.SetModel("models/infected/baggage_hunter.mdl");
					}
				}
				if(SI.GetZombieType() == 8)
				{
					if(mapname.find("c10m4") != null || mapname.find("c12m") != null)
						SI.SetModel("models/infected/military_hulk_l4d1.mdl");
				}
			}
			// spitter, jockey, and charger is different because their default is braindead's infected
			if(SI.GetZombieType() == 4)
			{
				SI.SetModel("models/infected/spitter_l4d1.mdl");
				if (RandomInt(0,1) == 1)
				{
					if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
						SI.SetModel("models/infected/spitter_nurse.mdl");
				}
			}
			if(SI.GetZombieType() == 5)
			{
				SI.SetModel("models/infected/jockey_l4d1.mdl");
				if (RandomInt(0,1) == 1)
				{
					if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
						SI.SetModel("models/infected/screamer_jockey.mdl");
				}
			}
			if(SI.GetZombieType() == 6)
			{
				local modelnimi = NetProps.GetPropString(SI, "m_ModelName");
				if (modelnimi != "models/infected/l4lcharchar.mdl")
				{
					SI.SetModel("models/infected/charger2_l4d1.mdl");
				}
				if (RandomInt(0,1) == 1)
				{
					if(mapname.find("c8m4") != null || mapname.find("c8m5") != null)
						SI.SetModel("models/infected/ceda_charger_l4d1.mdl");
					if(mapname.find("c7m") != null)
						SI.SetModel("models/infected/ceda_charger.mdl");
					if(mapname.find("c11m3") != null)
						SI.SetModel(C11Chargers[RandomInt(0,1)]);
					if(mapname.find("c11m1") != null || mapname.find("c8m3") != null)
						SI.SetModel("models/infected/riot_charger_l4d1.mdl");
					if(mapname.find("c12m") != null)
						SI.SetModel(C12Chargers[RandomInt(0,1)]);
				}
			}
		}
	}

    OnGameEvent_witch_spawn = function(event)
    {
        local witch = null;

        while ((witch = Entities.FindByClassname(witch, "witch")) != null)
        {
			if(mapname.find("c8m4") != null)
			{
				witch.SetModel(Witch[RandomInt(0,1)]);
			}
        }
    }
}

__CollectEventCallbacks(Tosda_L4D1Spawn, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);