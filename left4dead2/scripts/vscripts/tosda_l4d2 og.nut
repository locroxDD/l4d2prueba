// spaghetti ass script brah

local mapname = Director.GetMapName();

local Chargers = ["models/infected/roadcrew_charger.mdl","models/infected/urban_charger.mdl"];

local DTCharger = ["models/infected/charger.mdl","models/infected/urban_charger.mdl","models/infected/Ceda_Charger.mdl","models/infected/fhs_charger.mdl"];
local DTWitch = ["models/infected/witch.mdl","models/infected/cashier_witch.mdl"];
local DTHunter = ["models/infected/ceda_hunter.mdl","models/infected/loose_hooded_hunter.mdl"];
local HRSmoker = ["models/infected/roadcrew_smoker.mdl","models/infected/mud_smoker.mdl"];

// swamp brah

local SFSmoker = ["models/infected/militia_smoker.mdl","models/infected/mud_smoker.mdl"];
local SFSpitter = ["models/infected/ratman.mdl","models/infected/fisherman_spitter.mdl"];


local Tanks = ["models/infected/clown_hulk.mdl","models/infected/TosdaMST_hulk.mdl","models/infected/roadcrew_hulk.mdl"];
local Smokers = ["models/infected/ceda_smoker.mdl","models/infected/survivor_smoker.mdl","models/infected/soldier_smoker.mdl"];
local Boomers = ["models/infected/fatasses/beard/boomer.mdl","models/infected/fatasses/1/boomer.mdl","models/infected/fatasses/1/boomer_l4d1.mdl","models/infected/fatasses/boomer.mdl","models/infected/fatasses/2/boomer.mdl"];
local Hunters = ["models/infected/survivor_hunter.mdl","models/infected/swamp_hunter.mdl","models/infected/soldier_hunter.mdl"];
local Spitters = ["models/infected/spitter_nurse.mdl"];
local Jockeys = ["models/infected/swamp_jockey.mdl","models/infected/clown_jockey.mdl"];

//Parish brah

local PRTanks = ["models/infected/riot_tank.mdl","models/infected/military_hulk.mdl"];
local PRChargers = ["models/infected/riot_charger.mdl","models/infected/soldier_charger.mdl"];


local PrecacheSets =
[
	Chargers,
    DTCharger,
    DTWitch,
	DTHunter,
    HRSmoker,
	Tanks,
	Smokers,
	Boomers,
	Hunters,
    Spitters,
	Jockeys,
	SFSmoker,
	SFSpitter,
	PRTanks,
	PRChargers,
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

Tosda_L4D2Spawn <-
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
					if(mapname.find("c1m") != null)
						SI.SetModel("models/infected/ceda_smoker.mdl");
					if(mapname.find("c5m") != null)
						SI.SetModel("models/infected/soldier_smoker.mdl");
						SI.SetBodygroup(1, RandomInt(0,2))
						SI.SetBodygroup(2, RandomInt(0,2))	
					if(mapname.find("c6m") != null)
						SI.SetModel("models/infected/survivor_smoker.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 2));
					if(mapname.find("c3m") != null)
						SI.SetModel(SFSmoker[RandomInt(0, 1)]);
					if (mapname.find("c4m") != null)
					{
						SI.SetModel("models/infected/roadcrew_smoker.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
					}
					if(mapname.find("c4m4") != null || mapname.find("c4m5") != null)
					SI.SetModel(HRSmoker[RandomInt(0, 1)]);
				}
				if(SI.GetZombieType() == 2)
				{
					if(mapname.find("c2m5") != null || mapname.find("c6m") != null)
					{
						SI.SetModel("models/infected/fatasses/beard/boomer.mdl");
						SI.SetBodygroup(1, RandomInt(0,1));
						SI.SetBodygroup(2, RandomInt(0,1));
					}
					if(mapname.find("c2m1") != null || mapname.find("c2m2") != null || mapname.find("c2m3") != null || mapname.find("c2m4") != null)
						SI.SetModel("models/infected/fatasses/2/boomer.mdl");
					if(mapname.find("c3m") != null)
						SI.SetModel("models/infected/fatasses/1/boomer_l4d1.mdl");
					if(mapname.find("c4m") != null)
						SI.SetModel("models/infected/fatasses/boomer.mdl");
					if(mapname.find("c5m1") != null || mapname.find("c5m4") != null)
						SI.SetModel("models/infected/fatasses/1/boomer.mdl");
				}
				if(SI.GetZombieType() == 3)
				{	
					if(mapname.find("c1m") != null)
						SI.SetModel(DTHunter[RandomInt(0,1)]);
					if(mapname.find("c5m") != null)
						SI.SetModel("models/infected/soldier_hunter.mdl");
						SI.SetBodygroup(0, RandomInt(0,3))	
						SI.SetBodygroup(1, RandomInt(0,2))	
					if(mapname.find("c6m") != null)
						SI.SetModel("models/infected/survivor_hunter.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 2));
				}
				if(SI.GetZombieType() == 4)
				{
					if(mapname.find("c1m3") != null)
						SI.SetModel("models/infected/spitter_nurse.mdl");
					if(mapname.find("c3m") != null)
						SI.SetModel(SFSpitter[RandomInt(0,1)]);
				}
				if(SI.GetZombieType() == 5)
				{
					if(mapname.find("c2m") != null)
						SI.SetModel("models/infected/clown_jockey.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 6));
					if(mapname.find("c3m") != null)
						SI.SetModel("models/infected/swamp_jockey.mdl");
				}
				if(SI.GetZombieType() == 6)
				{
					if(mapname.find("c1m") != null)
					{
						local maxIndex = 2;

						if(mapname.find("c1m2") != null)
						{
							maxIndex = 3;
						}

						SI.SetModel(DTCharger[RandomInt(0, maxIndex)]);
					}
					if(mapname.find("c4m") != null)
					{
						SI.SetModel("models/infected/roadcrew_charger.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
					}
						
					if (mapname.find("c5m") != null)
					{
						if (!("RiotChargerModExists" in getroottable()))
						{
							SI.SetModel(PRChargers[RandomInt(0, 1)]);
						}
						else
						{
							SI.SetModel("models/infected/soldier_charger.mdl");
						}
					}
				}
				if(SI.GetZombieType() == 8)
				{
					if(mapname.find("c2m") != null)
						SI.SetModel("models/infected/clown_hulk.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 6));
					if(mapname.find("c3m") != null || mapname.find("c6m1") != null)
						SI.SetModel("models/infected/TosdaMST_hulk.mdl");
					if(mapname.find("c4m") != null)
					{
						SI.SetModel("models/infected/roadcrew_hulk.mdl");
						NetProps.SetPropInt(SI, "m_nSkin", RandomInt(0, 1));
					}
					if(mapname.find("c5m") != null)
						SI.SetModel(PRTanks[RandomInt(0, 1)]);
				}
			}
		}
	}
	
    OnGameEvent_witch_spawn = function(event)
    {
        local witch = null;

        while ((witch = Entities.FindByClassname(witch, "witch")) != null)
        {
			if(mapname.find("c1m3") != null)
			{
				witch.SetModel(DTWitch[RandomInt(0,1)]);
			}
        }
    }
}

__CollectEventCallbacks(Tosda_L4D2Spawn, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);