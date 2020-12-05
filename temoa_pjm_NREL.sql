BEGIN TRANSACTION;
CREATE TABLE "time_season" (
	"t_season"	text,
	PRIMARY KEY("t_season")
);
INSERT INTO `time_season` VALUES ('inter');
INSERT INTO `time_season` VALUES ('summer');
INSERT INTO `time_season` VALUES ('winter');

CREATE TABLE "time_periods" (
	"t_periods"	integer,
	"flag"	text,
	FOREIGN KEY("flag") REFERENCES "time_period_labels"("t_period_labels"),
	PRIMARY KEY("t_periods")
);
INSERT INTO `time_periods` VALUES (1950,'e');
INSERT INTO `time_periods` VALUES (1960,'e');
INSERT INTO `time_periods` VALUES (1980,'e');
INSERT INTO `time_periods` VALUES (2000,'e');
INSERT INTO `time_periods` VALUES (2010,'e');
INSERT INTO `time_periods` VALUES (2020,'f');
INSERT INTO `time_periods` VALUES (2025,'f');
INSERT INTO `time_periods` VALUES (2030,'f');
INSERT INTO `time_periods` VALUES (2035,'f');
INSERT INTO `time_periods` VALUES (2040,'f');
INSERT INTO `time_periods` VALUES (2045,'f');
INSERT INTO `time_periods` VALUES (2050,'f');
INSERT INTO `time_periods` VALUES (2055,'f');

CREATE TABLE "time_period_labels" (
	"t_period_labels"	text,
	"t_period_labels_desc"	text,
	PRIMARY KEY("t_period_labels")
);
INSERT INTO `time_period_labels` VALUES ('e','existing vintages');
INSERT INTO `time_period_labels` VALUES ('f','future');

CREATE TABLE "time_of_day" (
	"t_day"	text,
	PRIMARY KEY("t_day")
);
INSERT INTO `time_of_day` VALUES ('day');
INSERT INTO `time_of_day` VALUES ('night');

CREATE TABLE "technology_labels" (
	"tech_labels"	text,
	"tech_labels_desc"	text,
	PRIMARY KEY("tech_labels")
);
INSERT INTO `technology_labels` VALUES ('r','resource technology');
INSERT INTO `technology_labels` VALUES ('p','production technology');
INSERT INTO `technology_labels` VALUES ('pb','baseload production technology');
INSERT INTO `technology_labels` VALUES ('ps','storage production technology');

CREATE TABLE "technologies" (
	"tech"	text,
	"flag"	text,
	"sector"	text,
	"tech_desc"	text,
	"tech_category"	text,
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("flag") REFERENCES "technology_labels"("tech_labels"),
	PRIMARY KEY("tech")
);
INSERT INTO `technologies` VALUES ('NatGas','r','supply','natural gas','natural gas');
INSERT INTO `technologies` VALUES ('Coal','r','supply','coal','coal');
INSERT INTO `technologies` VALUES ('Uranium','r','supply','uranium','nuclear');
INSERT INTO `technologies` VALUES ('Sun','r','supply','dummy tech to have input to solar','renewables');
INSERT INTO `technologies` VALUES ('Wind','r','supply','dummy tech to have input to wind','renewables');
-- placeholder
INSERT INTO `technologies` VALUES ('WindTurbine','p','electric','wind','renewables');
INSERT INTO `technologies` VALUES ('SolarPV','p','electric','solar photovoltaics','renewables');
INSERT INTO `technologies` VALUES ('SolarThermal','p','electric','solar thermal','renewables');
INSERT INTO `technologies` VALUES ('NatGasSteam','p','electric','natural gas/oil steam power plant','natural gas');
INSERT INTO `technologies` VALUES ('CoalSteam','p','electric','coal steam power plant','coal');
INSERT INTO `technologies` VALUES ('NatGasCC','p','electric','natural gas/oil combined cycle power plant','natural gas');
INSERT INTO `technologies` VALUES ('NatGasCT','p','electric','natural gas/oil combustion turbine power plant','natural gas');
INSERT INTO `technologies` VALUES ('Battery','ps','electric','battery storage','battery');
INSERT INTO `technologies` VALUES ('HydroPower','p','electric','hydropower','renewables');
INSERT INTO `technologies` VALUES ('PumpedHydro','ps','electric','pumped hydro storage','storage');
INSERT INTO `technologies` VALUES ('Nuclear','p','electric','nuclear power','nuclear');
-- another placeholder
INSERT INTO `technologies` VALUES ('PhysicalToDemand','p','electric','dummy tech to help with storage','dummy');

#other nuclear fuels? 
#justification: I chose these technologies because they were the some of the largest portion of generation, 
#or because I thought there was large potential for growth. Excluded petroleum because I thought it would
# be hard to trace the supply chain for that and it's very small. 
#this is where i am up to, 10:15 PM, 11/13. -Sean
CREATE TABLE "tech_reserve" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);
#leaving this blank for now, may have to look more into. 
#Seems like it refers to the buffer capacity that the grid is required to have to make sure it can always meet demand
#techs that can count toward this requirement would be counted here. U.S. project has lots of techs here, 
#"reserve margin requirement power" google search could help provide info

CREATE TABLE "tech_exchange" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);
#leaving this blank for now, may have to look more into. Idk what this means

CREATE TABLE "tech_curtailment" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);
INSERT INTO `tech_curtailment` VALUES ('WindTurbine','');
INSERT INTO `tech_curtailment` VALUES ('SolarPV','');

CREATE TABLE "tech_annual" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);
#technologies that produce constant annual output, not sure what these would be, leaving empty for now

CREATE TABLE "sector_labels" (
	"sector"	text,
	PRIMARY KEY("sector")
);
INSERT INTO `sector_labels` VALUES ('supply');
INSERT INTO `sector_labels` VALUES ('electric');
INSERT INTO `sector_labels` VALUES ('demand');
#INSERT INTO `sector_labels` VALUES ('transport');
#INSERT INTO `sector_labels` VALUES ('commercial');
#INSERT INTO `sector_labels` VALUES ('residential');
#INSERT INTO `sector_labels` VALUES ('industrial');

#took this stuff out, can put back into if we need

CREATE TABLE "regions" (
	"regions"	TEXT,
	"region_note"	TEXT,
	PRIMARY KEY("regions")
);
INSERT INTO `regions` VALUES ('pjm',NULL);
#Could split this up by state or more granular, not sure if we will need to

CREATE TABLE "groups" (
	"group_name"	text,
	"notes"	text,
	PRIMARY KEY("group_name")
);

CREATE TABLE "commodity_labels" (
	"comm_labels"	text,
	"comm_labels_desc"	text,
	PRIMARY KEY("comm_labels")
);
INSERT INTO `commodity_labels` VALUES ('p','physical commodity');
INSERT INTO `commodity_labels` VALUES ('e','emissions commodity');
INSERT INTO `commodity_labels` VALUES ('d','demand commodity');

CREATE TABLE "commodities" (
	"comm_name"	text,
	"flag"	text,
	"comm_desc"	text,
	FOREIGN KEY("flag") REFERENCES "commodity_labels"("comm_labels"),
	PRIMARY KEY("comm_name")
);
INSERT INTO `commodities` VALUES ('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO `commodities` VALUES ('SOL','p','# sunlight');
INSERT INTO `commodities` VALUES ('WND','p','# wind');
INSERT INTO `commodities` VALUES ('CL','p','# coal');
INSERT INTO `commodities` VALUES ('NG','p','# natural gas');
INSERT INTO `commodities` VALUES ('URN','p','# uranium');
INSERT INTO `commodities` VALUES ('co2','e','#CO2 emissions');
INSERT INTO `commodities` VALUES ('OED','p','# overall electricity demand intermediate for storage');
INSERT INTO `commodities` VALUES ('OEDD','d','# overall electricity demand demand commodity');
# commented out stuff I didn't think was relevant, added OED for us. 

CREATE TABLE "TechOutputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"tech"	TEXT,
	"output_comm"	text,
	"to_split"	real,
	"to_split_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech","output_comm")
);

CREATE TABLE "TechInputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"input_comm"	text,
	"tech"	text,
	"ti_split"	real,
	"ti_split_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","input_comm","tech")
);


CREATE TABLE "StorageDuration" (
	"regions"	text,
	"tech"	text,
	"duration"	real,
	"duration_notes"	text,
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "SegFrac" (
	"season_name"	text,
	"time_of_day_name"	text,
	"segfrac"	real CHECK("segfrac" >= 0 AND "segfrac" <= 1),
	"segfrac_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("season_name","time_of_day_name")
);
INSERT INTO `SegFrac` VALUES ('inter','day',0.1667,'# I-D');
INSERT INTO `SegFrac` VALUES ('inter','night',0.0833,'# I-N');
INSERT INTO `SegFrac` VALUES ('summer','day',0.1667,'# S-D');
INSERT INTO `SegFrac` VALUES ('summer','night',0.0833,'# S-N');
INSERT INTO `SegFrac` VALUES ('winter','day',0.3333,'# W-D');
INSERT INTO `SegFrac` VALUES ('winter','night',0.1667,'# W-N');
--leaving the same for now

CREATE TABLE "PlanningReserveMargin" (
	`regions`	text,
	`reserve_margin`	REAL,
	PRIMARY KEY(regions),
	FOREIGN KEY(`regions`) REFERENCES regions
);
CREATE TABLE "Output_V_Capacity" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"tech"	text,
	"vintage"	integer,
	"capacity"	real,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","tech","vintage")
);

CREATE TABLE "Output_VFlow_Out" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_out"	real,
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);

CREATE TABLE "Output_VFlow_In" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_in"	real,
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);

CREATE TABLE "Output_Objective" (
	"scenario"	text,
	"objective_name"	text,
	"total_system_cost"	real
);

CREATE TABLE "Output_Emissions" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"emissions_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"emissions"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("emissions_comm") REFERENCES "EmissionActivity"("emis_comm"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","emissions_comm","tech","vintage")
);
CREATE TABLE "Output_Curtailment" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"curtailment"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_Costs" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"output_name"	text,
	"tech"	text,
	"vintage"	integer,
	"output_cost"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","output_name","tech","vintage")
);
CREATE TABLE "Output_CapacityByPeriodAndTech" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"tech"	text,
	"capacity"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","tech")
);
CREATE TABLE "MyopicBaseyear" (
	"year"	real
	"notes"	text	
);
CREATE TABLE "MinGenGroupWeight" (
	"regions"	text,
	"tech"	text,
	"group_name"	text,
	"act_fraction"	REAL,
	"tech_desc"	text,
	PRIMARY KEY("tech","group_name","regions")
);
CREATE TABLE "MinGenGroupTarget" (
	"regions"	text,
	"periods"	integer,
	"group_name"	text,
	"min_act_g"	real,
	"notes"	text,
	PRIMARY KEY("periods","group_name","regions")
);
CREATE TABLE "MinCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"mincap"	real,
	"mincap_units"	text,
	"mincap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);

CREATE TABLE "MinActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"minact"	real,
	"minact_units"	text,
	"minact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
CREATE TABLE "MaxCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxcap"	real,
	"maxcap_units"	text,
	"maxcap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
-- INSERT INTO "MaxCapacity" VALUES('pjm',2020, 'NatGasSteam',8.41,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2025, 'NatGasSteam',0.1,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2030, 'NatGasSteam',0.1,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2035, 'NatGasSteam',0,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2040, 'NatGasSteam',0,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2045, 'NatGasSteam',0,'GW', '');
-- INSERT INTO "MaxCapacity" VALUES('pjm',2050, 'NatGasSteam',0,'GW', '');

CREATE TABLE "MaxActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxact"	real,
	"maxact_units"	text,
	"maxact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
CREATE TABLE "LifetimeTech" (
	"regions"	text,
	"tech"	text,
	"life"	real,
	"life_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
INSERT INTO `LifetimeTech` VALUES ('pjm','WindTurbine',21.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','SolarPV',32.5,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','SolarThermal',26.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','HydroPower',105.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','Battery',11.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','PumpedHydro',101.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','NatGas',1000.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','Coal',1000.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','Uranium',1000.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','Sun',1000.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','Wind',1000.0,'');
INSERT INTO `LifetimeTech` VALUES ('pjm','PhysicalToDemand',1000.0,'');

CREATE TABLE "LifetimeProcess" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"life_process"	real,
	"life_process_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',1950,75.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',1960,65.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',1980,45.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2000,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2020,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2025,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2030,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2035,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2040,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2045,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasSteam',2050,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',1950,75.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',1960,65.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',1980,45.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2000,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2020,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2025,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2030,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2035,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2040,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2045,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','CoalSteam',2050,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',1960,65.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',1980,45.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2000,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2020,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2025,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2030,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2035,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2040,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2045,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCC',2050,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',1960,65.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',1980,45.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2000,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2020,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2025,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2030,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2035,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2040,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2045,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','NatGasCT',2050,31.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',1960,65.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',1980,45.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2020,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2025,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2030,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2035,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2040,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2045,41.0,'');
INSERT INTO `LifetimeProcess` VALUES ('pjm','Nuclear',2050,41.0,'');

CREATE TABLE "LifetimeLoanTech" (
	"regions"	text,
	"tech"	text,
	"loan"	real,
	"loan_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
--not sure if we need this

CREATE TABLE "GrowthRateSeed" (
	"regions"	text,
	"tech"	text,
	"growthrate_seed"	real,
	"growthrate_seed_units"	text,
	"growthrate_seed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "GrowthRateMax" (
	"regions"	text,
	"tech"	text,
	"growthrate_max"	real,
	"growthrate_max_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "GlobalDiscountRate" (
	"rate"	real
);
INSERT INTO `GlobalDiscountRate` VALUES (0.05);
#not sure what we want to choose here, leaving it at 5% for now

CREATE TABLE "ExistingCapacity" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"exist_cap"	real,
	"exist_cap_units"	text,
	"exist_cap_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech","vintage")
);
--INSERT INTO `ExistingCapacity` VALUES ('utopia','E01',1960,0.175,'','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','Battery',2010,0.351,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCC',2000,44.1571,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCC',1980,4.9525,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCC',1960,0.532,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCT',2000,19.021,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCT',1980,5.460,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasCT',1960,0.702,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','PumpedHydro',1980,3.003,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','PumpedHydro',1960,2.049,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','HydroPower',2000,0.297,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','HydroPower',1980,0.427,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','HydroPower',1960,0.340,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','HydroPower',1950,1.976,'GW','');;
INSERT INTO `ExistingCapacity` VALUES ('pjm','Nuclear',1980,18.213,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','Nuclear',1960,15.240,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','SolarPV',2000,2.003,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','CoalSteam',2000,3.655,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','CoalSteam',1980,11.419,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','CoalSteam',1960,34.206,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','CoalSteam',1950,3.387,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasSteam',2000,0.082,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasSteam',1980,0.600,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasSteam',1960,6.146,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','NatGasSteam',1950,1.587,'GW','');
INSERT INTO `ExistingCapacity` VALUES ('pjm','WindTurbine',2000,9.812,'GW','');

CREATE TABLE "EmissionLimit" (
	"regions"	text,
	"periods"	integer,
	"emis_comm"	text,
	"emis_limit"	real,
	"emis_limit_units"	text,
	"emis_limit_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","emis_comm")
);
INSERT INTO "EmissionLimit" VALUES('pjm',2020,'co2',307761.08,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2025,'co2',270737.5665,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2030,'co2',233714.0532,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2035,'co2',196690.5399,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2040,'co2',159667.0266,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2045,'co2',122643.5133,'#kt','#80% reduction by 2050');
INSERT INTO "EmissionLimit" VALUES('pjm',2050,'co2',85620,'#kt','#80% reduction by 2050');

CREATE TABLE "EmissionActivity" (
	"regions"	text,
	"emis_comm"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"emis_act"	real,
	"emis_act_units"	text,
	"emis_act_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","emis_comm","input_comm","tech","vintage","output_comm")
);
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',1950,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',1960,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',1980,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2000,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2020,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2025,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2030,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2035,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2040,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2045,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasSteam',2050,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',1960,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',1980,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2000,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2020,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2025,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2030,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2035,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2040,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2045,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCC',2050,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',1960,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',1980,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2000,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2020,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2025,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2030,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2035,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2040,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2045,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','NG','NatGasCT',2050,'OED',110.731563372,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',1950,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',1960,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',1980,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2000,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2020,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2025,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2030,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2035,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2040,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2045,'OED',279.349715634,'kt/PJout','');
INSERT INTO `EmissionActivity` VALUES ('pjm','co2','CL','CoalSteam',2050,'OED',279.349715634,'kt/PJout','');

CREATE TABLE "Efficiency" (
	"regions"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"efficiency"	real CHECK("efficiency" > 0),
	"eff_notes"	text,
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","input_comm","tech","vintage","output_comm")
);
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',1950,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',1960,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',1980,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2000,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2020,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2025,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2030,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2035,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2040,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2045,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PhysicalToDemand',2050,'OEDD',1.000,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',1950,'OED',0.328772,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',1960,'OED',0.328772,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',1980,'OED',0.328772,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2000,'OED',0.328772,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2020,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2025,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2030,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2035,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2040,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2045,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','CL','CoalSteam',2050,'OED',0.323382,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',1960,'OED',0.327165,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',1980,'OED',0.327165,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2020,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2025,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2030,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2035,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2040,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2045,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','URN','Nuclear',2050,'OED',0.326757,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',1950,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',1960,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',1980,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2000,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2020,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2025,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2030,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2035,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2040,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2045,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','HydroPower',2050,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',1960,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',1980,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2000,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2020,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2025,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2030,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2035,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2040,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2045,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCC',2050,'OED',0.5388,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',1960,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',1980,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2000,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2020,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2025,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2030,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2035,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2040,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2045,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasCT',2050,'OED',0.3626,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',1950,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',1960,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',1980,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2000,'OED',0.339469,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2020,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2025,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2030,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2035,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2040,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2045,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','NG','NatGasSteam',2050,'OED',0.441283,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',1950,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',1960,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',1980,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2000,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2020,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2025,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2030,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2035,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2040,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2045,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','WND','WindTurbine',2050,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',1950,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',1960,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',1980,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2000,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2020,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2025,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2030,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2035,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2040,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2045,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarThermal',2050,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',1950,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',1960,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',1980,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2000,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2020,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2025,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2030,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2035,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2040,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2045,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','SOL','SolarPV',2050,'OED',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',1950,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',1960,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',1980,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2000,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2020,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2025,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2030,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2035,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2040,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2045,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','NatGas',2050,'NG',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',1950,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',1960,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',1980,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2000,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2020,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2025,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2030,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2035,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2040,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2045,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Coal',2050,'CL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',1950,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',1960,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',1980,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2000,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2020,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2025,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2030,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2035,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2040,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2045,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Uranium',2050,'URN',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',1950,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',1960,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',1980,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2000,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2020,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2025,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2030,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2035,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2040,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2045,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Wind',2050,'WND',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',1950,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',1960,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',1980,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2000,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2020,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2025,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2030,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2035,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2040,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2045,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','ethos','Sun',2050,'SOL',1,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2000,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2010,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2020,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2025,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2030,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2035,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2040,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2045,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','Battery',2050,'OED',0.9,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',1960,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',1980,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2020,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2025,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2030,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2035,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2040,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2045,'OED',0.8,'');
INSERT INTO `Efficiency` VALUES ('pjm','OED','PumpedHydro',2050,'OED',0.8,'');

CREATE TABLE "DiscountRate" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"tech_rate"	real,
	"tech_rate_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);
CREATE TABLE "DemandSpecificDistribution" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"demand_name"	text,
	"dds"	real CHECK("dds" >= 0 AND "dds" <= 1),
	"dds_notes"	text,
	FOREIGN KEY("demand_name") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	PRIMARY KEY("regions","season_name","time_of_day_name","demand_name")
);
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','inter','day','OEDD',0.243,'');
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','inter','night','OEDD',0.22,'');
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','summer','day','OEDD',0.147,'');
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','summer','night','OEDD',0.129,'');
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','winter','day','OEDD',0.134,'');
INSERT INTO `DemandSpecificDistribution` VALUES ('pjm','winter','night','OEDD',0.127,'');

CREATE TABLE "Demand" (
	"regions"	text,
	"periods"	integer,
	"demand_comm"	text,
	"demand"	real,
	"demand_units"	text,
	"demand_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("demand_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","demand_comm")
);
INSERT INTO `Demand` VALUES ('pjm',2020,'OEDD',2896.5516984,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2025,'OEDD',3007.6055676,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2030,'OEDD',3121.8491556,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2035,'OEDD',3181.8886956,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2040,'OEDD',3321.1202472,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2045,'OEDD',3448.8264744,'PJ','');
INSERT INTO `Demand` VALUES ('pjm',2050,'OEDD',3585.0414564,'PJ','');

CREATE TABLE "CostVariable" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_variable"	real,
	"cost_variable_units"	text,
	"cost_variable_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);
INSERT INTO `CostVariable` VALUES ('pjm',2020,'CoalSteam',1950,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'CoalSteam',1960,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'CoalSteam',1980,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'CoalSteam',2000,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasSteam',1950,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasSteam',1960,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasSteam',1980,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasSteam',2000,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCC',1960,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCC',1980,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCC',2000,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCT',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCT',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCT',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'SolarPV',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'WindTurbine',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'WindTurbine',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'Battery',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'Nuclear',1960,0.64,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'Nuclear',1980,0.64,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2020,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'CoalSteam',2000,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasSteam',2000,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCC',2000,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCT',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'SolarPV',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'WindTurbine',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'WindTurbine',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'Battery',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'Battery',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2025,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'CoalSteam',2000,0.51,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'CoalSteam',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasSteam',2000,0.29,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasSteam',2030,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCC',2000,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCC',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCT',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'NatGasCT',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'HydroPower',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'PumpedHydro',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarPV',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarPV',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'SolarThermal',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'WindTurbine',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'WindTurbine',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'WindTurbine',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Battery',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Battery',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Battery',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2030,'Nuclear',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'CoalSteam',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'CoalSteam',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasSteam',2030,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasSteam',2035,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCC',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCC',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCT',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'NatGasCT',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'HydroPower',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'PumpedHydro',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarPV',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarPV',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarThermal',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'SolarThermal',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'WindTurbine',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'WindTurbine',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'WindTurbine',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'WindTurbine',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Battery',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Battery',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Battery',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Nuclear',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2035,'Nuclear',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'CoalSteam',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'CoalSteam',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'CoalSteam',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasSteam',2030,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasSteam',2035,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasSteam',2040,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCC',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCC',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCC',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCT',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCT',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'NatGasCT',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'HydroPower',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'PumpedHydro',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarPV',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarPV',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarPV',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarThermal',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarThermal',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'SolarThermal',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'WindTurbine',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'WindTurbine',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'WindTurbine',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'WindTurbine',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'WindTurbine',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Battery',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Battery',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Battery',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Nuclear',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Nuclear',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2040,'Nuclear',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'CoalSteam',2045,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2030,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2035,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2040,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasSteam',2045,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCC',2045,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'NatGasCT',2045,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'HydroPower',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'PumpedHydro',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarPV',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'SolarThermal',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'WindTurbine',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'WindTurbine',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'WindTurbine',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'WindTurbine',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'WindTurbine',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Battery',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Battery',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Battery',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2045,'Nuclear',2045,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2045,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'CoalSteam',2050,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2020,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2025,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2030,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2035,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2040,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2045,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasSteam',2050,0.28,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2045,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCC',2050,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2020,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2025,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2030,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2035,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2040,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2045,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'NatGasCT',2050,1.11,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',1950,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2000,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'HydroPower',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',1960,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',1980,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'PumpedHydro',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2020,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarPV',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2025,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'SolarThermal',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'WindTurbine',2030,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'WindTurbine',2035,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'WindTurbine',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'WindTurbine',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'WindTurbine',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Battery',2040,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Battery',2045,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Battery',2050,0,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2020,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2025,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2030,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2035,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2040,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2045,0.56,'M$/PJ','');
INSERT INTO `CostVariable` VALUES ('pjm',2050,'Nuclear',2050,0.56,'M$/PJ','');

CREATE TABLE "CostInvest" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"cost_invest"	real,
	"cost_invest_units"	text,
	"cost_invest_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2020,4138,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2025,4099,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2030,4049,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2035,3986,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2040,3913,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2045,3854,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','CoalSteam',2050,3754,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2020,1066,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2025,1008,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2030,983,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2035,964,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2040,948,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2045,936,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCC',2050,913,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2020,974,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2025,925,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2030,898,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2035,879,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2040,865,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2045,854,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasCT',2050,834,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2020,7112,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2025,6929,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2030,6728,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2035,6505,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2040,6266,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2045,6048,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Nuclear',2050,5768,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2020,1519,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2025,1381,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2030,1227,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2035,1165,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2040,1102,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2045,1038,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','WindTurbine',2050,973,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2020,1354,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2025,1095,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2030,836,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2035,799,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2040,762,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2045,725,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarPV',2050,688,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2020,1455,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2025,1004,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2030,817,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2035,766,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2040,715,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2045,664,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','Battery',2050,613,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2020,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2025,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2030,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2035,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2040,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2045,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','SolarThermal',2050,1331,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2020,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2025,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2030,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2035,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2040,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2045,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','HydroPower',2050,4213,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2020,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2025,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2030,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2035,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2040,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2045,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','NatGasSteam',2050,100000,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2020,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2025,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2030,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2035,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2040,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2045,2638,'M$/GW','');
INSERT INTO `CostInvest` VALUES ('pjm','PumpedHydro',2050,2638,'M$/GW','');

CREATE TABLE "CostFixed" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_fixed"	real,
	"cost_fixed_units"	text,
	"cost_fixed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);
INSERT INTO `CostFixed` VALUES ('pjm',2020,'CoalSteam',1950,63.00672,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'CoalSteam',1960,61.71648,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'CoalSteam',1980,59.136,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'CoalSteam',2000,56.55552,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasSteam',1950,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasSteam',1960,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasSteam',1980,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasSteam',2000,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCC',1960,13.39392,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCC',1980,13.39392,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCC',2000,13.39392,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCT',1960,12.52352,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCT',1980,12.52352,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCT',2000,12.52352,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'SolarPV',2000,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'WindTurbine',2000,76.1344,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'WindTurbine',2020,43.008,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'Battery',2020,36.37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'Nuclear',1960,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'Nuclear',1980,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2020,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'CoalSteam',2000,56.55552,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasSteam',2000,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCC',2000,13.39392,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCT',2000,12.52352,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'SolarPV',2000,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'WindTurbine',2020,43.008,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'WindTurbine',2025,41.984,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'Battery',2020,36.37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'Battery',2025,25.1,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2025,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'CoalSteam',2000,56.55552,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'CoalSteam',2030,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasSteam',2000,25.87885568,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasSteam',2030,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCC',2000,13.39392,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCC',2030,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCT',2000,12.52352,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'NatGasCT',2030,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'HydroPower',2030,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'PumpedHydro',2030,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarPV',2000,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarPV',2030,10,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'SolarThermal',2030,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'WindTurbine',2020,43.008,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'WindTurbine',2025,41.984,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'WindTurbine',2030,39.936,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Battery',2020,36.37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Battery',2025,25.1,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Battery',2030,20.43,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2030,'Nuclear',2030,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'CoalSteam',2030,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'CoalSteam',2035,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasSteam',2030,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasSteam',2035,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCC',2030,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCC',2035,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCT',2030,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'NatGasCT',2035,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',2030,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'HydroPower',2035,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',2030,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'PumpedHydro',2035,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarPV',2030,10,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarPV',2035,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarThermal',2030,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'SolarThermal',2035,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'WindTurbine',2020,43.008,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'WindTurbine',2025,41.984,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'WindTurbine',2030,39.936,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'WindTurbine',2035,37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Battery',2025,25.1,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Battery',2030,20.43,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Battery',2035,19.15,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Nuclear',2030,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2035,'Nuclear',2035,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'CoalSteam',2030,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'CoalSteam',2035,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'CoalSteam',2040,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasSteam',2030,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasSteam',2035,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasSteam',2040,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCC',2030,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCC',2035,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCC',2040,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCT',2030,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCT',2035,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'NatGasCT',2040,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2030,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2035,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'HydroPower',2040,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',2030,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',2035,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'PumpedHydro',2040,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarPV',2030,10,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarPV',2035,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarPV',2040,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarThermal',2030,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarThermal',2035,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'SolarThermal',2040,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'WindTurbine',2020,43.008,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'WindTurbine',2025,41.984,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'WindTurbine',2030,39.936,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'WindTurbine',2035,37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'WindTurbine',2040,36,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Battery',2030,20.43,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Battery',2035,19.15,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Battery',2040,17.88,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Nuclear',2030,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Nuclear',2035,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2040,'Nuclear',2040,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2030,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2035,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2040,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'CoalSteam',2045,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2030,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2035,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2040,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasSteam',2045,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2030,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2035,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2040,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCC',2045,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2030,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2035,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2040,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'NatGasCT',2045,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2030,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2035,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2040,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'HydroPower',2045,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2030,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2035,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2040,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'PumpedHydro',2045,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2030,10,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2035,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2040,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarPV',2045,8,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2020,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2030,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2035,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2040,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'SolarThermal',2045,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'WindTurbine',2025,41.984,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'WindTurbine',2030,39.936,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'WindTurbine',2035,37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'WindTurbine',2040,36,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'WindTurbine',2045,35,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Battery',2035,19.15,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Battery',2040,17.88,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Battery',2045,16.6,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2030,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2035,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2040,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2045,'Nuclear',2045,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2020,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2025,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2030,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2035,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2040,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2045,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'CoalSteam',2050,40,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2020,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2025,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2030,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2035,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2040,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2045,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasSteam',2050,24.68,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2020,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2030,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2035,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2040,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2045,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCC',2050,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2020,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2025,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2030,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2035,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2040,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2045,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'NatGasCT',2050,11,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',1950,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',1960,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',1980,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2000,45.62944,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2020,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2025,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2030,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2035,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2040,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2045,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'HydroPower',2050,44,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',1960,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',1980,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2020,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2025,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2030,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2035,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2040,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2045,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'PumpedHydro',2050,15.9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2020,16,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2025,13,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2030,10,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2035,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2040,9,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2045,8,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarPV',2050,8,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2025,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2030,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2035,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2040,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2045,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'SolarThermal',2050,85.03,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'WindTurbine',2030,39.936,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'WindTurbine',2035,37,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'WindTurbine',2040,36,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'WindTurbine',2045,35,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'WindTurbine',2050,33,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Battery',2040,17.88,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Battery',2045,16.6,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Battery',2050,15.32,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2020,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2025,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2030,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2035,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2040,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2045,119,'M$/GW','');
INSERT INTO `CostFixed` VALUES ('pjm',2050,'Nuclear',2050,119,'M$/GW','');


CREATE TABLE "CapacityToActivity" (
	"regions"	text,
	"tech"	text,
	"c2a"	real,
	"c2a_notes"	TEXT,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
INSERT INTO `CapacityToActivity` VALUES ('pjm','Battery',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','PumpedHydro',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','CoalSteam',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','Nuclear',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','HydroPower',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','WindTurbine',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','SolarThermal',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','SolarPV',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','NatGasSteam',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','NatGasCC',31.54,'GW to yearly PJ see documentation');
INSERT INTO `CapacityToActivity` VALUES ('pjm','NatGasCT',31.54,'GW to yearly PJ see documentation');

CREATE TABLE "CapacityFactorTech" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech")
);
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','CoalSteam',0.43180,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','CoalSteam',0.43180,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','CoalSteam',0.50100,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','CoalSteam',0.50100,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','CoalSteam',0.53270,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','CoalSteam',0.53270,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','Nuclear',0.88700,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','Nuclear',0.88700,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','Nuclear',0.98830,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','Nuclear',0.98830,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','Nuclear',0.97470,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','Nuclear',0.97470,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','HydroPower',0.40800,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','HydroPower',0.40800,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','HydroPower',0.40170,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','HydroPower',0.40170,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','HydroPower',0.42900,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','HydroPower',0.42900,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','NatGasSteam',0.128,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','NatGasSteam',0.128,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','NatGasSteam',0.079,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','NatGasSteam',0.079,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','NatGasSteam',0.226,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','NatGasSteam',0.226,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','NatGasCC',0.52820,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','NatGasCC',0.52820,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','NatGasCC',0.55930,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','NatGasCC',0.55930,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','NatGasCC',0.67330,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','NatGasCC',0.67330,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','NatGasCT',0.108,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','NatGasCT',0.108,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','NatGasCT',0.099,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','NatGasCT',0.099,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','NatGasCT',0.137,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','NatGasCT',0.137,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','WindTurbine',0.36470,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','WindTurbine',0.36470,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','WindTurbine',0.34770,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','WindTurbine',0.34770,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','WindTurbine',0.29630,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','WindTurbine',0.29630,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','SolarThermal',0.21600,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','SolarThermal',0.00000,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','SolarThermal',0.08230,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','SolarThermal',0.00000,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','SolarThermal',0.30870,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','SolarThermal',0.00000,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','day','SolarPV',0.24950,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','inter','night','SolarPV',0.00000,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','day','SolarPV',0.15230,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','winter','night','SolarPV',0.00000,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','day','SolarPV',0.32100,'');
INSERT INTO `CapacityFactorTech` VALUES ('pjm','summer','night','SolarPV',0.00000,'');


CREATE TABLE "CapacityFactorProcess" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"vintage"	integer,
	"cf_process"	real CHECK("cf_process" >= 0 AND "cf_process" <= 1),
	"cf_process_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech","vintage")
);


CREATE TABLE "CapacityCredit" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	PRIMARY KEY("regions","periods","tech")
);
COMMIT;
