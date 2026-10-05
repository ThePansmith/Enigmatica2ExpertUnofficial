import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
#modloaded thermalexpansion
#modloaded enderio

# Planks/Slabs -> Sticks
for plank in <ore:plankWood>.items {
	mods.thermalexpansion.Sawmill.addRecipe(<minecraft:stick> * 6, plank, 500, <thermalfoundation:material:800>, 30);
}

for slab in <ore:slabWood>.items {
	mods.thermalexpansion.Sawmill.addRecipe(<minecraft:stick> * 3, slab, 250, <thermalfoundation:material:800>, 15);
}

  # Compression Dynamo Fuels
  var fuels as float[ILiquidStack] = {    # base rf per bucket
    # canola chain
    <liquid:canolaoil>                  :  500000,
    <liquid:refinedcanolaoil>           : 1000000,
    <liquid:crystaloil>                 : 3000000,
    <liquid:empoweredoil>               : 7500000,

    # base thermal oils
    <liquid:refined_biofuel>            : 15000000,  # grassoline - I find this is much harder to produce in mass than most things (requires huge farm or phytos).. so it's higher total power (longer burn time)
    <liquid:coal>                       :  2000000,  # liquificated coal
    <liquid:refined_oil>                :  4000000,  # naptha
    <liquid:refined_fuel>               :  8000000,  # refined fuel

    # other
    <liquid:bio.ethanol>                :  6000000,  # forestry ethanol
    <liquid:crude_oil>                  :  5000000,  # crude oil
    <liquid:oil>                        :  5000000,  # crude oil
    <liquid:ic2biogas>                  :   500000,  # ic2 biogas (easy to make in mass, must burn faster)
    <liquid:diesel>                     :  8000000,  # immersive petrol diesel
    <liquid:gasoline>                   :  1000000,  # immersive petrol gasoline
    <liquid:hootch>                     :  4000000,  # eio hootch
    <liquid:fire_water>                 :  6000000,  # eio fire water  (hootch + blaze powder + redstone)
    <liquid:rocket_fuel>                :  6000000,  # eio rocket fuel (hootch + gunpowder    + redstone)
    <liquid:biofuel>                    :  3000000,  # industrial foregoing biofuel
    <liquid:if.protein>                 :  4000000,  # industrial foregoing protein (very similar to biofuel but meats)
    <liquid:seed.oil>                   :   500000,  # forestry seed oil (remove thermal seed_oil)
    <liquid:creosote>                   :  1500000,  # creosote
    <liquid:tree_oil>                   : 13000000,  # tree oil (from resin, quite slow)
    <liquid:biodiesel>                  :  1500000   # bio diesel - worse version than IE multiblock for tradeoff of space - can be rectified via augments or using combustion generator
  };
  for fuel, energy in fuels {
    mods.thermalexpansion.CompressionDynamo.removeFuel(fuel);
    mods.thermalexpansion.CompressionDynamo.addFuel(fuel, energy);

    # Combustion generator uses same fuels but at a constant burn rate and more efficient, increasing power output per space
    var combustion_eff    = 1.2;                                            # base level capacitor has equal fuel eff to dynamo, each level beyond is mult by cap level, 1/2/3/4/5 etc
    var burn_time         = 1000.0;                                         # 1000 is the min time, and I don't recommend increasing it after playing around with it.. too bad
    var base_cap_quality  = 16.0;                                           # I have no idea where this is defined.. but I need it for accurate burn duration and total energy for level 1 cap
    var total_energy      = energy * combustion_eff / base_cap_quality;
    mods.enderio.CombustionGen.removeFuel(fuel);
    mods.enderio.CombustionGen.addFuel(fuel, total_energy / burn_time, burn_time * base_cap_quality);
  }
  mods.thermalexpansion.CompressionDynamo.removeFuel(<liquid:seed_oil>); # remove thermal seed_oil in favor of forestry

# Numismatic Dynamo Gems
  var gems as float[IItemStack] = {    # base rf per item
    # Diamond/Emerald related
    <minecraft:emerald>                                           :   1000000,
    <minecraft:diamond>                                           :   3000000,
    <redstonearsenal:material:160>                                :   4000000,
    <extrautils2:suncrystal>                                      :   9000000,

    <darkutils:shulker_pearl>                                     :     25000,

    # Astral
    <astralsorcery:itemcraftingcomponent:0>                       :    800000,   # aquamarine
    <astralsorcery:itemcraftingcomponent:4>                       :   5000000,   # resonating gem
    # wanted to also do rock/celestial crystals but they don't work properly.. for some reason all crystals are equal even though they have different ids

    #AE2
    <appliedenergistics2:material:0>                              :    100000,   # certus
    <appliedenergistics2:material:1>                              :    200000,   # charged certus
    <appliedenergistics2:material:10>                             :     50000,   # pure certus - easily duped
    <appliedenergistics2:material:7>                              :    400000,   # fluix
    <appliedenergistics2:material:12>                             :     60000,   # pure fluix - easily duped

    <actuallyadditions:item_misc:5>                               :    200000,   # black quartz
    <nuclearcraft:gem:1>                                          :  20000000    # cubic boron nitride gem
  };
  for gem, energy in gems {
    mods.thermalexpansion.NumisticDynamo.removeGemFuel(gem);
    mods.thermalexpansion.NumisticDynamo.addGemFuel(gem, energy);
  }

# Numismatic Dynamo Coin overrides
  var coins as float[IItemStack] = {    # base rf per item
    # Top alloys
    <thermalfoundation:coin:103>             :   1000000,   # enderium
    <thermalfoundation:coin:102>             :    500000,   # lumium
    <thermalfoundation:coin:101>             :    500000,   # signalum
    <thermalfoundation:coin:72>              :    500000,   # mana infused (you can make infinite of this easily by placing silver ore or blocks against liquid primal mana - expert strat for someone to discover)

    # Basic alloys
    <thermalfoundation:coin:100>             :    100000,   # constantan
    <thermalfoundation:coin:99>              :     75000,   # bronze
    <thermalfoundation:coin:98>              :    100000,   # invar
    <thermalfoundation:coin:97>              :    100000,   # electrum
    <thermalfoundation:coin:96>              :    100000,   # steel
    <harvestcraft:garliccoinitem>            :     10000,   # garlic coin (meme, gold nug + garlic)

    # Expensive metals
    <thermalfoundation:coin:71>              :    200000,   # iridium
    <thermalfoundation:coin:70>              :    200000,   # platinum
    <jaopca:item_cointitanium>               :    300000,   # titanium
    <jaopca:item_coindraconium>              :    200000,   # draconium
    <jaopca:item_coinastralstarmetal>        :    300000,   # star metal
  };
  for coin, energy in coins {
    mods.thermalexpansion.NumisticDynamo.removeFuel(coin);
    mods.thermalexpansion.NumisticDynamo.addFuel(coin, energy);
  }

# Reactant Dynamo elemental overrides
  var elementalBaseEnergy = 1200000;
  mods.thermalexpansion.ReactantDynamo.removeReaction(        <thermalfoundation:material:1024>,      <liquid:cryotheum>);
  mods.thermalexpansion.ReactantDynamo.addReactionElemental(  <thermalfoundation:material:1024>,      <liquid:cryotheum>,     elementalBaseEnergy ); # pyro  / cryo

  mods.thermalexpansion.ReactantDynamo.removeReaction(        <thermalfoundation:material:1025>,      <liquid:pyrotheum>);
  mods.thermalexpansion.ReactantDynamo.addReactionElemental(  <thermalfoundation:material:1025>,      <liquid:pyrotheum>,     elementalBaseEnergy ); # cryo  / pyro

  mods.thermalexpansion.ReactantDynamo.removeReaction(        <thermalfoundation:material:1026>,      <liquid:petrotheum>);
  mods.thermalexpansion.ReactantDynamo.addReactionElemental(  <thermalfoundation:material:1026>,      <liquid:petrotheum>,    elementalBaseEnergy ); # aero  / petro

  mods.thermalexpansion.ReactantDynamo.removeReaction(         <thermalfoundation:material:1027>,      <liquid:aerotheum>);
  mods.thermalexpansion.ReactantDynamo.addReactionElemental(   <thermalfoundation:material:1027>,      <liquid:aerotheum>,     elementalBaseEnergy ); # petro / aero

# Update Augment Recipes
 # auxiliary transmission coil (all dynamos - power output)
  recipes.remove(<thermalexpansion:augment:512>);
  recipes.addShaped("Auxiliary Transmission Coil",
  <thermalexpansion:augment:512>,
  [[<mekanism:speedupgrade>, <teslacorelib:speed_tier2>, <mekanism:speedupgrade>],
  [<ore:coilElectrum>, <thermalfoundation:material:515>, <ore:coilElectrum>],
  [<mekanism:speedupgrade>, <teslacorelib:speed_tier2>, <mekanism:speedupgrade>]]);

 # Fuel Catalyzer (all dynamos - fuel efficiency)
  recipes.remove(<thermalexpansion:augment:513>);
  recipes.addShaped("Fuel Catalyzer",
  <thermalexpansion:augment:513>,
  [[<mekanism:energyupgrade>, <teslacorelib:energy_tier2>, <mekanism:energyupgrade>],
  [<ore:solenoidMagnesiumDiboride>, <thermalfoundation:material:514>, <ore:solenoidMagnesiumDiboride>],
  [<mekanism:energyupgrade>, <teslacorelib:energy_tier2>, <mekanism:energyupgrade>]]);

 # Closed Loop Cooling (compression dynamo - coolant not consumed)
  recipes.remove(<thermalexpansion:augment:672>);
  recipes.addShaped("Closed Loop Cooling",
  <thermalexpansion:augment:672>,
  [[null, <ore:gearInvar>, null],
  [<ic2:te:134>, <thermalfoundation:material:515>, <ic2:te:134>],
  [null, <ore:dustCryotheum>, null]]);

 # Ignition Plugs (compression dynamo - refined fuel specialty)
  recipes.remove(<thermalexpansion:augment:673>);
  recipes.addShaped("Ignition Plugs",
  <thermalexpansion:augment:673>,
  [[null, <ore:gearSignalum>, null],
  [<thermalexpansion:augment:512>, <thermalfoundation:material:515>, <thermalexpansion:augment:513>],
  [null, <ore:dustPyrotheum>, null]]);

 # Agitative Manifold (compression dynamo - grassoline specialty)
  recipes.remove(<thermalexpansion:augment:674>);
  recipes.addShaped("Agitative Manifold",
  <thermalexpansion:augment:674>,
  [[null, <ore:gearBronze>, null],
  [<thermalexpansion:augment:512>, <thermalfoundation:material:515>, <thermalexpansion:augment:513>],
  [null, <ore:dustAerotheum>, null]]);

 # Isentropic Reservoir (magmatic dynamo - coolant specialty)
   recipes.remove(<thermalexpansion:augment:656>);
   recipes.addShaped("Isentropic Reservoir",
   <thermalexpansion:augment:656>,
   [[null, <ore:gearSignalum>, null],
   [<thermalexpansion:augment:512>, <thermalfoundation:material:515>, <thermalexpansion:augment:513>],
   [null, <ore:dustCryotheum>, null]]);

 # Lapidary Calibration (Numismatic dynamo - gem specialty)
   recipes.remove(<thermalexpansion:augment:720>);
   recipes.addShaped("Lapidary Calibration",
   <thermalexpansion:augment:720>,
   [[null, <ore:gearSignalum>, null],
   [<thermalexpansion:augment:512>, <thermalfoundation:material:515>, <thermalexpansion:augment:513>],
   [null, <tconstruct:materials:16>, null]]);

 # Elemental Catalyzer (Reactant dynamo - elemental specialty)
   recipes.remove(<thermalexpansion:augment:688>);
   recipes.addShaped("Elemental Catalyzer",
   <thermalexpansion:augment:688>,
   [[null, <ore:gearEnderium>, null],
   [<thermalexpansion:augment:512>, <thermalfoundation:material:515>, <thermalexpansion:augment:513>],
   [null, <ore:dustAerotheum>, null]]);

# AA Oil Generator -> Compression Dynamo
	recipes.addShapeless(<thermalexpansion:dynamo:2>, [<actuallyadditions:block_oil_generator>]);

# Essence of Knowledge XP Compatibility (credit RedGoblin88)
	mods.thermalexpansion.Crucible.addRecipe(<liquid:experience> * 200, <mysticalagriculture:xp_droplet>, 4000);
	mods.thermalexpansion.Crucible.addRecipe(<liquid:experience> * 200, <mysticalagriculture:experience_essence>, 4000);

# Nullifier
	recipes.remove(<thermalexpansion:device:1>);
	recipes.addShaped("Nullifier",
	<thermalexpansion:device:1>,
	[[<ore:ingotTin>, <ore:ingotTin>, <ore:ingotTin>],
	[<ore:ingotTin>, <extrautils2:trashcan>, <ore:ingotTin>],
	[<ore:ingotTin>, <ore:ingotTin>, <ore:ingotTin>]]);

# Igneous Extruder
	recipes.remove(<thermalexpansion:machine:15>);
	recipes.addShaped("Igneous Extruder",
	<thermalexpansion:machine:15>,
	[[null, <ore:blockGlass>, null],
	[<ore:ingotInvar>, <thermalexpansion:frame:64>, <ore:ingotInvar>],
	[<ore:gearCopper>, <immersiveengineering:metal_decoration0>, <ore:gearCopper>]]);

# Reinforced Cell Frame (Empty)
	recipes.addShapedMirrored("Reinforced Cell Frame",
	<thermalexpansion:frame:130>,
	[[<ore:gearSilver>, <thermalfoundation:material:515>, <ore:gearSilver>],
	[<ore:plateElectrumFlux>, <thermalexpansion:frame:129>, <ore:plateElectrumFlux>],
	[<ore:gemCrystalFlux>, <tconstruct:large_plate>.withTag({Material: "electrum"}), <ore:gemCrystalFlux>]]);

# Reinforced Cell Frame (Full)
	mods.thermalexpansion.Transposer.addFillRecipe(<thermalexpansion:frame:146>, <thermalexpansion:frame:130>, <liquid:lumium> * 576, 250000);

# Signalum Cell Frame (Empty)
	recipes.addShapedMirrored("Signalum Cell Frame Empty",
	<thermalexpansion:frame:131>,
	[[<ore:plateSignalum>, <ore:crystalCinnabar>, <ore:plateSignalum>],
	[<thermalfoundation:material:832>, <thermalexpansion:frame:146>, <thermalfoundation:material:832>],
	[<ore:plateSignalum>, <ore:crystalSlagRich>, <ore:plateSignalum>]]);

# Signalum Cell Frame (Full)
	mods.thermalexpansion.InductionSmelter.addRecipe(<thermalexpansion:frame:147>, <thermalexpansion:frame:131>, <minecraft:redstone_block> * 40, 100000);

# Resonant Cell Frame (Empty)
	mods.forestry.ThermionicFabricator.addCast(<thermalexpansion:frame:132>,
	[[<thermalfoundation:material:166>, <actuallyadditions:block_misc:8>, <thermalfoundation:material:166>],
	[<thermalfoundation:glass_alloy:7>, <thermalexpansion:frame:147>, <thermalfoundation:glass_alloy:7>],
	[<thermalfoundation:material:1028>, <thermalfoundation:material:1028>, <thermalfoundation:material:1028>]], <liquid:glass> * 4000);

# Resonant Cell Frame (Full)
	mods.extendedcrafting.CombinationCrafting.addRecipe(<thermalexpansion:frame:148>,
	100000000, 1000000,
	<thermalexpansion:frame:132>,
	[<gendustry:genetics_processor>, <extrautils2:ingredients:5>, <ic2:plate:16>,
	<ic2:lapotron_crystal:*>, <forestry:thermionic_tubes:12>, <forestry:crafting_material:1>,
	<mekanismgenerators:reactor:1>, <environmentaltech:structure_frame_1>, <rftools:infused_diamond>,
	<mekanism:controlcircuit:3>, <thermalfoundation:material:295>, <environmentaltech:litherite_crystal>,
	<nuclearcraft:part:6>, <nuclearcraft:gem:1>]);

# Mana Dust
	recipes.addShapedMirrored("Mana Dust",
	<thermalfoundation:material:1028> * 2,
	[[<ore:manaDiamond>, <ore:dustCryotheum>, <ore:manaDiamond>],
	[<ore:dustPyrotheum>, <ore:powderMana>, <ore:dustAerotheum>],
	[<ore:manaDiamond>, <ore:dustPetrotheum>, <ore:manaDiamond>]]);

# Centrifugal Seperator
	recipes.remove(<thermalexpansion:machine:10>);
	recipes.addShaped("Centrifugal Seperator",
	<thermalexpansion:machine:10>,
	[[null, <forestry:centrifuge>, null],
	[<ore:ingotConstantan>, <thermalexpansion:frame>, <ore:ingotConstantan>],
	[<ore:gearCopper>, <thermalfoundation:material:513>, <ore:gearCopper>]]);

# Fluid Transposer
	recipes.remove(<thermalexpansion:machine:8>);
	recipes.addShaped("Fluid Transposer",
	<thermalexpansion:machine:8>,
	[[<thermalexpansion:tank>, <forestry:carpenter>, <thermalexpansion:tank>],
	[<ore:blockGlass>, <thermalexpansion:frame>, <ore:blockGlass>],
	[<ore:gearInvar>, <thermalfoundation:material:513>, <ore:gearInvar>]]);

# Sawmill
	recipes.remove(<thermalexpansion:machine:2>);
	recipes.addShaped("Sawmill",
	<thermalexpansion:machine:2>,
	[[null, <mekanism:machineblock2:5>, null],
	[<ore:logWood>, <thermalexpansion:frame>, <ore:logWood>],
	[<ore:gearCopper>, <thermalfoundation:material:513>, <ore:gearCopper>]]);

# Pulverizer
	recipes.remove(<thermalexpansion:machine:1>);
	recipes.addShaped("Pulverizer",
	<thermalexpansion:machine:1>,
	[[<ore:craftingPiston>, <actuallyadditions:block_grinder>, <ore:craftingPiston>],
	[<tconstruct:large_plate>.withTag({Material: "flint"}), <thermalexpansion:frame>, <tconstruct:large_plate>.withTag({Material: "flint"})],
	[<ore:gearCopper>, <thermalfoundation:material:513>, <ore:gearCopper>]]);

	recipes.addShaped("Pulverizer2",
	<thermalexpansion:machine:1>,
	[[<ore:craftingPiston>, <actuallyadditions:block_grinder_double>, <ore:craftingPiston>],
	[<tconstruct:large_plate>.withTag({Material: "flint"}), <thermalexpansion:frame>, <tconstruct:large_plate>.withTag({Material: "flint"})],
	[<ore:gearCopper>, <thermalfoundation:material:513>, <ore:gearCopper>]]);

# Primal Mana
	mods.tconstruct.Alloy.addRecipe(<liquid:mana> * 125, [<liquid:mirion> * 18, <liquid:osgloglas> * 18, <liquid:ic2coolant> * 125]);

# Mana Infused Ingot&Block
	mods.mekanism.infuser.addRecipe("DIAMOND", 20, <botania:manaresource>, <thermalfoundation:material:136>);
	mods.mekanism.infuser.addRecipe("DIAMOND", 160, <botania:storage>, <thermalfoundation:storage:8>);

# Energy Cell Frame
	recipes.remove(<thermalexpansion:frame:128>);
	mods.mekanism.infuser.addRecipe("REDSTONE", 400, <thermalexpansion:frame>, <thermalexpansion:frame:128>);

# Machine Frame
	recipes.remove(<thermalexpansion:frame>);
	mods.forestry.ThermionicFabricator.addCast(<thermalexpansion:frame> * 2,
	[[<actuallyadditions:item_crystal:5>, <rftools:machine_frame>, <actuallyadditions:item_crystal:5>],
	[<immersiveengineering:metal_decoration0:5>, <thermalexpansion:frame:64>, <actuallyadditions:block_misc:9>],
	[<actuallyadditions:item_crystal:5>, <teslacorelib:machine_case>, <actuallyadditions:item_crystal:5>]],
	<liquid:glass> * 6000);

# Removing craftable Bronze
	recipes.removeShapeless(<thermalfoundation:material:163> * 4,
	[<ore:ingotTin>, <ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>]);

# Redstone Reception Coil
	recipes.remove(<thermalfoundation:material:513>);
	mods.actuallyadditions.AtomicReconstructor.addRecipe(<thermalfoundation:material:513> * 1, <immersiveengineering:metal_decoration0>, 25000);
	mods.mekanism.infuser.addRecipe("REDSTONE", 160, <minecraft:gold_ingot>, <thermalfoundation:material:513>);

# Redstone Transmission Coil
	recipes.remove(<thermalfoundation:material:514>);
	mods.actuallyadditions.AtomicReconstructor.addRecipe(<thermalfoundation:material:514>, <immersiveengineering:wirecoil:2>, 5000);
	mods.mekanism.infuser.addRecipe("REDSTONE", 160, <thermalfoundation:material:130>, <thermalfoundation:material:514>);

# Redstone Conductance Coil
	recipes.remove(<thermalfoundation:material:515>);
	mods.actuallyadditions.AtomicReconstructor.addRecipe(<thermalfoundation:material:515> * 1, <immersiveengineering:metal_decoration0:1>, 25000);
	mods.mekanism.infuser.addRecipe("REDSTONE", 160, <thermalfoundation:material:161>, <thermalfoundation:material:515>);

# Removing Netherrack -> Gravel Pulverizer recipes
	mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:netherrack>);

# Making TE alloys meltable
	mods.thermalexpansion.Crucible.addRecipe(<liquid:signalum> * 144, <thermalfoundation:material:165>, 5000);
	mods.thermalexpansion.Crucible.addRecipe(<liquid:lumium> * 144, <thermalfoundation:material:166>, 5000);
	mods.thermalexpansion.Crucible.addRecipe(<liquid:enderium> * 144, <thermalfoundation:material:167>, 5000);

# Signalum Ingots
	mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:material:165>, <nuclearcraft:alloy:7>, <liquid:redstone> * 250, 5000);
	mods.thermalexpansion.InductionSmelter.addRecipe(<nuclearcraft:alloy:7> * 4, <thermalfoundation:material:130>, <thermalfoundation:material:128> * 3, 15000);

# Lumium Ingots
	mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:material:166>, <nuclearcraft:alloy:8>, <liquid:glowstone> * 250, 5000);
	mods.thermalexpansion.InductionSmelter.addRecipe(<nuclearcraft:alloy:8> * 4, <thermalfoundation:material:130>, <thermalfoundation:material:129> * 3, 20000);

# Enderium Ingots
	mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:material:167>, <nuclearcraft:alloy:9>, <liquid:ender> * 250, 10000);
	mods.thermalexpansion.InductionSmelter.addRecipe(<nuclearcraft:alloy:9> * 4, <thermalfoundation:material:134>, <thermalfoundation:material:131> * 3, 25000);

# Hardened Cell Frame
	mods.actuallyadditions.Empowerer.addRecipe(<thermalexpansion:frame:129>, <thermalexpansion:frame:128>, <immersiveengineering:material:2>, <thermalfoundation:material:354>, <thermalfoundation:material:290>, <mekanism:basicblock:8>, 2500000, 200, [0.25, 0.25, 0.29]);

# Remove creative kit crafts (no actual creative conversion kit)
recipes.removeByRecipeName("thermalexpansion:cell_17");
recipes.removeByRecipeName("thermalexpansion:cell_16");
recipes.removeByRecipeName("thermalexpansion:cell_15");
recipes.removeByRecipeName("thermalexpansion:cell_14");
recipes.removeByRecipeName("thermalexpansion:cell_18");
recipes.removeByRecipeName("thermalexpansion:tank_18");
recipes.removeByRecipeName("thermalexpansion:tank_16");
recipes.removeByRecipeName("thermalexpansion:tank_17");
recipes.removeByRecipeName("thermalexpansion:tank_14");
recipes.removeByRecipeName("thermalexpansion:tank_15");

# Remove old non-working reservior clearings
recipes.removeByRecipeName("thermalexpansion:reservoir_10");
recipes.removeByRecipeName("thermalexpansion:reservoir_11");
recipes.removeByRecipeName("thermalexpansion:reservoir_12");
recipes.removeByRecipeName("thermalexpansion:reservoir_13");
recipes.removeByRecipeName("thermalexpansion:reservoir_14");

# Clear content of reservior and tank
for i in 0 to 5 {
	val reservior as IItemStack = <thermalexpansion:reservoir>.definition.makeStack(i) as IItemStack;
	clearFluid(reservior);
	# mods.jei.JEI.addItem(reservior); # Tanks cant be added to JEI
}
clearFluid(<thermalexpansion:tank>.withTag({}));

# Add to Jei
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 1 as byte}));
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 2 as byte}));
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 3 as byte}));
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 4 as byte}));
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 4 as byte}));
mods.jei.JEI.addItem(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Creative: 1 as byte, Level: 4 as byte}));

# TE coolants
var coolants as int[][ILiquidStack] = {   #rfValue, efficiencyPct
  <liquid:water>                      : [   250000, 20],
  <liquid:ic2distilled_water>         : [   300000, 30],
  <liquid:ice>                        : [  1500000, 45],
  <liquid:ic2coolant>                 : [ 20000000, 50],
  <liquid:cryotheum>                  : [ 30000000, 60],
  <liquid:ender_distillation>         : [ 40000000, 70],
  <liquid:vapor_of_levity>            : [ 45000000, 75],
  <liquid:liquid_nitrogen>            : [ 45000000, 75],
  <liquid:liquidhelium>               : [ 50000000, 80],
  <liquid:blockfluidantimatter>       : [ 50000000, 80]
};
for coolant, values in coolants {
  mods.thermalexpansion.Coolant.addCoolant(coolant, values[0], values[1]);

  # eio combustion generator uses same coolants
  mods.enderio.CombustionGen.removeCoolant(coolant);

  if( coolant.name == <liquid:water>.name || coolant.name == <liquid:ic2distilled_water>.name ){
    continue;
  }
  mods.enderio.CombustionGen.addCoolant(coolant, values[1] / 20.0);
}
# mods.enderio.CombustionGen.removeCoolant(<liquid:water>);
# mods.enderio.CombustionGen.removeCoolant(<liquid:ic2distilled_water>);


# Duct filling compat
scripts.process.fill(<thermaldynamics:duct_0:6>,  <liquid:redstone>*200,  <thermaldynamics:duct_0:2>,  null);
scripts.process.fill(<thermaldynamics:duct_0:7>,  <liquid:redstone>*200,  <thermaldynamics:duct_0:3>,  null);
scripts.process.fill(<thermaldynamics:duct_0:8>,  <liquid:redstone>*200,  <thermaldynamics:duct_0:4>,  null);
scripts.process.fill(<thermaldynamics:duct_0:9>,  <liquid:cryotheum>*500, <thermaldynamics:duct_0:5>,  null);
scripts.process.fill(<thermaldynamics:duct_32:1>, <liquid:glowstone>*200, <thermaldynamics:duct_32:3>, null);
scripts.process.fill(<thermaldynamics:duct_32:4>, <liquid:glowstone>*200, <thermaldynamics:duct_32:6>, null);
scripts.process.fill(<thermaldynamics:duct_32:5>, <liquid:glowstone>*200, <thermaldynamics:duct_32:7>, null);
scripts.process.fill(<thermaldynamics:duct_32>,   <liquid:glowstone>*200, <thermaldynamics:duct_32:2>, null);
scripts.process.fill(<thermaldynamics:duct_64:3>, <liquid:aerotheum>*500, <thermaldynamics:duct_64>,   null);
scripts.process.fill(<thermaldynamics:duct_64>,   <liquid:ender>*1000,    <thermaldynamics:duct_64:2>, null);


#####################################

# Clathrates rework. More output
function reworkClathrate(ore as IItemStack, crystal as IItemStack, dust as IItemStack, liquid as ILiquidStack) {
	# Remove default outputs
	mods.thermalexpansion.Crucible.removeRecipe(ore);
	mods.thermalexpansion.Crucible.removeRecipe(crystal);
	mods.thermalexpansion.Transposer.removeFillRecipe(crystal, <liquid:cryotheum> * 200);
	recipes.removeShapeless(<*>, [crystal, <thermalfoundation:material:1025>]);

	# Buff melting into raw liquids
	scripts.process.melt(ore, liquid * min(10000, liquid.amount * 4), "no exceptions");
	scripts.process.melt(crystal, liquid, "no exceptions");

	# Filling with cryotheum to make advanced liquids
	scripts.process.fill(crystal, <liquid:cryotheum> * 250, dust, "only: NCInfuser Transposer");
}

reworkClathrate(<thermalfoundation:ore_fluid:2>, <thermalfoundation:material:893>, <thermalfoundation:material:101>, <liquid:redstone> * 1000);
reworkClathrate(<thermalfoundation:ore_fluid:3>, <thermalfoundation:material:894>, <thermalfoundation:material:102>, <liquid:glowstone> * 2500);
reworkClathrate(<thermalfoundation:ore_fluid:4>, <thermalfoundation:material:895>, <thermalfoundation:material:103>, <liquid:ender> * 2500);

#####################################

# Stone Gear [Compactor] recipe
mods.thermalexpansion.Compactor.addGearRecipe(<thermalfoundation:material:23>, <ore:cobblestone>.firstItem * 4, 16000);

# Remove AE2 Seeds from Phytogenic Insolator
mods.thermalexpansion.Insolator.removeRecipe(<appliedenergistics2:crystal_seed:0>, <minecraft:glowstone_dust>);
mods.thermalexpansion.Insolator.removeRecipe(<appliedenergistics2:crystal_seed:600>, <minecraft:glowstone_dust>);
mods.thermalexpansion.Insolator.removeRecipe(<appliedenergistics2:crystal_seed:1200>, <minecraft:glowstone_dust>);

# Add Harvestcraft Sesame Seeds to Phytogenic Insolator
mods.thermalexpansion.Insolator.addRecipe(<harvestcraft:sesameseedsitem>, <thermalfoundation:fertilizer>, <harvestcraft:sesameseedsseeditem>, 4800, <harvestcraft:sesameseedsseeditem>, 110, 1200);
mods.thermalexpansion.Insolator.addRecipe(<harvestcraft:sesameseedsitem> * 2, <thermalfoundation:fertilizer:1>, <harvestcraft:sesameseedsseeditem>, 7200, <harvestcraft:sesameseedsseeditem>, 125, 1800);
mods.thermalexpansion.Insolator.addRecipe(<harvestcraft:sesameseedsitem> * 3, <thermalfoundation:fertilizer:2>, <harvestcraft:sesameseedsseeditem>, 9600, <harvestcraft:sesameseedsseeditem>, 150, 2400);

# Add Mending Moss to Arcane Ensorcellator
mods.thermalexpansion.Enchanter.addRecipe(<tconstruct:materials:19>, <tconstruct:materials:18>, <minecraft:enchanted_book>.withTag({StoredEnchantments: [{id: 70 as short, lvl: 1 as short}]}), 250000, 5000, false);

# Add Magical Wood Large Plate to Compactor
mods.thermalexpansion.Compactor.addPressRecipe(<tconstruct:large_plate>.withTag({Material: "xu_magical_wood"}), <extrautils2:decorativesolidwood:1> * 8, 100000);