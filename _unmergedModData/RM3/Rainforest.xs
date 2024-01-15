// Magelang
// Modified from dhplante's Africa map
// Original: Nov 08
// Modified: 12 March 2016


include "mercenaries.xs";
include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";

// Main entry point for random map script
void main(void)
{

  // Text
  // These status text lines are used to manually animate the map generation progress bar
  rmSetStatusText("",0.01);

  // determines map orientation - 1 is E/W, 2 is N/S
  int whichVersion = rmRandInt(1,2);
  
  // version switcher for testing
  // whichVersion = 2;
  
   int subCiv0=-1;
   int subCiv1=-1;
   int subCiv2=-1;
   int subCiv3=-1;

   
	// All tupi all the time
   if (rmAllocateSubCivs(4) == true)
   {
		if(rmRandFloat(1,1) > 0.50) 
		{ //this is a mixed range and melee map
			if(rmRandFloat(0,1) > 0.50) 
			{ //Tupi or Caribs
				string rangedCiv = "Kejawen"; //tupi
			}
			else
			{
				rangedCiv = "Matraman"; //caribs
			}
			if(rmRandFloat(0,1) > 0.50)
			{ //Zapotec or Maya
				string meleeCiv = "Pesantren"; //zapotec
			}
			else
			{
				meleeCiv = "Matraman"; //Maya
			}
			
			if(rmRandFloat(0,1) > 0.50) 
			{ //Ranged Top Left and Bottom Right
				subCiv0=rmGetCivID(rangedCiv);
				if (subCiv0 >= 0)
					rmSetSubCiv(0, rangedCiv);
				subCiv1=rmGetCivID(meleeCiv);
				if (subCiv1 >= 0)
					rmSetSubCiv(1, meleeCiv);

				subCiv2=rmGetCivID(meleeCiv);
				if (subCiv2 >= 0)
					rmSetSubCiv(2, meleeCiv);

				subCiv3=rmGetCivID(rangedCiv);
				if (subCiv3 >= 0)
					rmSetSubCiv(3, rangedCiv);
			}
			else
			{ //Melee Top Left and Bottom Right
				subCiv0=rmGetCivID(meleeCiv);
				if (subCiv0 >= 0)
					rmSetSubCiv(0, meleeCiv);
				subCiv1=rmGetCivID(rangedCiv);
				if (subCiv1 >= 0)
					rmSetSubCiv(1, rangedCiv);

				subCiv2=rmGetCivID(rangedCiv);
				if (subCiv2 >= 0)
					rmSetSubCiv(2, rangedCiv);

				subCiv3=rmGetCivID(meleeCiv);
				if (subCiv3 >= 0)
					rmSetSubCiv(3, meleeCiv);
			}

		}
		else
		{ //this is a all ranged or all melee map
			if(rmRandFloat(0,1) > 0.50) 
			{ //Ranged only (Tupi & Caribs)
				if(rmRandFloat(0,1) > 0.50) 
				{ //Tupi Top Left and Bottom Right
					subCiv0=rmGetCivID("Kejawen");
					if (subCiv0 >= 0)
						rmSetSubCiv(0, "Kejawen");
					subCiv1=rmGetCivID("Matraman");
					if (subCiv1 >= 0)
						rmSetSubCiv(1, "Matraman");

					subCiv2=rmGetCivID("Matraman");
					if (subCiv2 >= 0)
						rmSetSubCiv(2, "Matraman");

					subCiv3=rmGetCivID("Pesantren");
					if (subCiv3 >= 0)
						rmSetSubCiv(3, "Pesantren");
				}
				else
				{ //Tupi Bottom Left and Top Right
					subCiv0=rmGetCivID("Matraman");
					if (subCiv0 >= 0)
						rmSetSubCiv(0, "Matraman");
					subCiv1=rmGetCivID("Pesantren");
					if (subCiv1 >= 0)
						rmSetSubCiv(1, "Pesantren");

					subCiv2=rmGetCivID("Kejawen");
					if (subCiv2 >= 0)
						rmSetSubCiv(2, "Kejawen");

					subCiv3=rmGetCivID("Matraman");
					if (subCiv3 >= 0)
						rmSetSubCiv(3, "Matraman");
				}
			}
			else
			{ //Melee only (Zapotec & Maya)
				if(rmRandFloat(0,1) > 0.50) 
				{ //Zapotec Top Left and Bottom Right
					subCiv0=rmGetCivID("Matraman");
					if (subCiv0 >= 0)
						rmSetSubCiv(0, "Matraman");
					subCiv1=rmGetCivID("Kejawen");
					if (subCiv1 >= 0)
						rmSetSubCiv(1, "Kejawen");

					subCiv2=rmGetCivID("Pesantren");
					if (subCiv2 >= 0)
						rmSetSubCiv(2, "Pesantren");

					subCiv3=rmGetCivID("Matraman");
					if (subCiv3 >= 0)
						rmSetSubCiv(3, "Matraman");
				}
				else
				{ //Zapotec Bottom Left and Top Right
					subCiv0=rmGetCivID("Pesantren");
					if (subCiv0 >= 0)
						rmSetSubCiv(0, "Pesantren");
					subCiv1=rmGetCivID("Matraman");
					if (subCiv1 >= 0)
						rmSetSubCiv(1, "Matraman");

					subCiv2=rmGetCivID("Matraman");
					if (subCiv2 >= 0)
						rmSetSubCiv(2, "Matraman");

					subCiv3=rmGetCivID("Kejawen");
					if (subCiv3 >= 0)
						rmSetSubCiv(3, "Kejawen");
				}

			}

		}

	}

   
   
   // Picks the map size
	int playerTiles = 10000;
	if (cNumberNonGaiaPlayers >4)
		playerTiles = 9000;
	if (cNumberNonGaiaPlayers >6)
		playerTiles = 8000;			

  int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
  rmEchoInfo("Map size="+size+"m x "+size+"m");
  rmSetMapSize(size, size);

	rmSetWindMagnitude(2);

  // Picks a default water height
  rmSetSeaLevel(-3.0);

   // Picks default terrain and water
	//	rmSetMapElevationParameters(long type, float minFrequency, long numberOctaves, float persistence, float heightVariation)
	rmSetMapElevationParameters(cElevTurbulence, 0.06, 1, 0.4, 3.0);
  rmSetMapElevationHeightBlend(0.6);
	rmSetMapType("jawa");
	rmSetMapType("grass");
	rmSetMapType("land");
	rmSetWorldCircleConstraint(true);
  rmSetLightingSet("Berlin Dusk");

  // Init map.
  rmSetBaseTerrainMix("amazon grass");
  rmTerrainInitialize("amazon\ground1_ama", 2.0);

	chooseMercs();


  // Define some classes. These are used later for constraints.
  int classPlayer=rmDefineClass("player");
  rmDefineClass("classForest");
  rmDefineClass("importantItem");
  rmDefineClass("socketClass");
   rmDefineClass("natives");
  int foodClass = rmDefineClass("FoodClass");

  // -------------Define constraints
  // These are used to have objects and areas avoid each other
   
  // Map edge constraints
  int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.45), rmDegreesToRadians(0), rmDegreesToRadians(360));
  int resourceEdgeConstraint=rmCreatePieConstraint("resource edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.48), rmDegreesToRadians(0), rmDegreesToRadians(360));
  int forestMidConstraint=rmCreatePieConstraint("dense middle forests", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.16), rmDegreesToRadians(0), rmDegreesToRadians(360));
  int edgeForestConstraint=rmCreatePieConstraint("Ring for sparse forests near edge of map", 0.5, 0.5, rmXFractionToMeters(0.24), rmXFractionToMeters(0.48), rmDegreesToRadians(0), rmDegreesToRadians(360));

  // Player constraints
  int playerConstraint=rmCreateClassDistanceConstraint("avoid players", classPlayer, 10.0);
  int playerConstraintMid=rmCreateClassDistanceConstraint("resources avoid players", classPlayer, 15.0);
  int playerConstraintFar=rmCreateClassDistanceConstraint("resources avoid players far", classPlayer, 35.0);
  
   int avoidNatives=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 10.0);
   int avoidNativesMed=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 20.0);
   int avoidNativesFar=rmCreateClassDistanceConstraint("stuff avoids natives far", rmClassID("natives"), 45.0);
  int playerConstraintNugget=rmCreateClassDistanceConstraint("nuggets avoid players far", classPlayer, 65.0);
  int avoidTC = rmCreateTypeDistanceConstraint("avoid TCs", "TownCenter", 20.0);
 
  // Nature avoidance
  int forestObjConstraint=rmCreateTypeDistanceConstraint("forest obj", "all", 15.0);
  int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 35.0);
  int forestConstraintSmall=rmCreateClassDistanceConstraint("forest vs. forest less", rmClassID("classForest"), 25.0);
  int avoidResource=rmCreateTypeDistanceConstraint("resource avoid resource", "resource", 10.0);
  int avoidCoin=rmCreateTypeDistanceConstraint("avoid coin", "mine", 70.0);
  int avoidGold=rmCreateTypeDistanceConstraint("avoid gold", "minegold", 60.0);
  int avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "AbstractNugget", 50.0);
  int avoidFood = rmCreateClassDistanceConstraint("avoid foods", foodClass, 12.0);
  int avoidFoodMid = rmCreateClassDistanceConstraint("avoid foods mid", foodClass, 25.0);
  int avoidFoodFar = rmCreateClassDistanceConstraint("avoid foods far", foodClass, 45.0);
  int avoidElephants = rmCreateTypeDistanceConstraint("avoid elephants far", "Pronghorn", 60.0);
  int avoidHerdables=rmCreateTypeDistanceConstraint("avoids cattle", "ypWaterBuffalo", 65.0); 
  int avoidImportantItem=rmCreateClassDistanceConstraint("important stuff avoids each other", rmClassID("importantItem"), 5.0);
  int avoidImportantItemFar=rmCreateClassDistanceConstraint("important stuff avoids each other far", rmClassID("importantItem"), 15.0);
  int avoidBerries = rmCreateTypeDistanceConstraint("avoid berries", "berrybush", 65.0);
  
  // Avoid impassable land
  int avoidImpassableLandShort=rmCreateTerrainDistanceConstraint("avoid impassable land short", "Land", false, 4.0);
  int avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 8.0);
  int avoidImpassableLandFar=rmCreateTerrainDistanceConstraint("avoid impassable land far", "Land", false, 12.5);
  
  // Constraint to avoid water.
  int avoidWater4 = rmCreateTerrainDistanceConstraint("avoid water", "Land", false, 4.0);
  int avoidWater10 = rmCreateTerrainDistanceConstraint("avoid water medium", "Land", false, 10.0);
  
  // Constraint for grassy area to seek water
  int riverGrass = rmCreateTerrainMaxDistanceConstraint("stay near the water", "land", false, 5.0);

  // Unit avoidance
  int avoidTownCenter=rmCreateTypeDistanceConstraint("avoid Town Center", "townCenter", 10.0);

  // general avoidance
  int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 4.0);


  // Player placing  
  
  int teamZeroCount = rmGetNumberPlayersOnTeam(0);
	int teamOneCount = rmGetNumberPlayersOnTeam(1);
  
  // determine where the river is going to be now so we can push the player on the dry side out a bit
  int randomRiver = rmRandInt(1,2);
  //~ whichVersion = 2;
  //~ randomRiver = 1;
  
  if (cNumberTeams == 2)	{
    
    if(whichVersion == 1) {
      rmSetPlacementTeam(0);
      
      if(randomRiver == 1)
        rmSetPlacementSection(0.78, 0.95);
      
      else 
        rmSetPlacementSection(0.81, 0.98);
      
      if(teamZeroCount == 1)
        rmSetPlacementSection(.87, .88);
      rmPlacePlayersCircular(.36, .36, 0);

      rmSetPlacementTeam(1);
      
      if(randomRiver == 1)
        rmSetPlacementSection(.30, .47);
      
      else 
        rmSetPlacementSection(.27, .44);  
      
      if(teamOneCount == 1)
        rmSetPlacementSection(.37, .38);
      rmPlacePlayersCircular(.36, .36, 0);
    }
    
    else {
      rmSetPlacementTeam(0);
      
      if(randomRiver == 1)
        rmSetPlacementSection(0.06, 0.23);
      
      else 
        rmSetPlacementSection(0.03, 0.2);

      if(teamZeroCount == 1)
        rmSetPlacementSection(.15, .16);
      rmPlacePlayersCircular(.36, .36, 0);

      rmSetPlacementTeam(1);
      
      if(randomRiver == 1)
        rmSetPlacementSection(.53, .70);
      
      else 
        rmSetPlacementSection(.56, .73);

      if(teamOneCount == 1)
        rmSetPlacementSection(.64, .65);
      rmPlacePlayersCircular(.36, .36, 0);
    }
	}

  // FFA
  else {
    rmPlacePlayersCircular(0.35, 0.35, 0.0);
  }

  // Text
  rmSetStatusText("",0.10);

  float playerFraction=rmAreaTilesToFraction(100);
  for(i=1; <cNumberPlayers) {
    // Create the area.
    int id=rmCreateArea("Player"+i);
    // Assign to the player.
    rmSetPlayerArea(i, id);
    // Set the size.
    rmSetAreaSize(id, playerFraction, playerFraction);
    rmAddAreaToClass(id, classPlayer); 
    rmAddAreaConstraint(id, playerConstraint); 
    rmAddAreaConstraint(id, playerEdgeConstraint); 
    rmAddAreaConstraint(id, avoidImpassableLand);
    rmAddAreaConstraint(id, avoidWater10);
    rmSetAreaCoherence(id, 1.0);
    //rmSetAreaLocPlayer(id, i);
    rmSetAreaWarnFailure(id, false);
  }
  
  rmBuildAllAreas();
  
  // Text
  rmSetStatusText("",0.25);

  // Placement order
  // Rivers & Cliffs -> Trade route -> Resources -> Nuggets

  // Rivers and cliffs
  // Half the time there will be a river to the north, half to the south (same with v2 of the map)
  
  int northRiver = rmRiverCreate(-1, "Deccan Plateau River", 5, 5, 5, 5);
  int southRiver = rmRiverCreate(-1, "Deccan Plateau River", 5, 5, 5, 5);
  float riverXLoc = 0;
  float riverYLoc = 0;
  
  // north/west river
  if (randomRiver == 1) {
    if(whichVersion == 1) {
      rmRiverAddWaypoint(northRiver, 0.40, 1.0);
      rmRiverAddWaypoint(northRiver, .73, .73);
      riverXLoc = .73;
      riverYLoc = .73;
      rmRiverAddWaypoint(northRiver, 1.0, 0.40);
    }
    
    else {
      rmRiverAddWaypoint(northRiver, 0.64, 1.0);
      rmRiverAddWaypoint(northRiver, .3, .7);
      riverXLoc = .3;
      riverYLoc = .7;
      rmRiverAddWaypoint(northRiver, 0.0, 0.375);
    }
    
    rmRiverSetShallowRadius(northRiver, 5);
    rmRiverAddShallow(northRiver, rmRandFloat(0.15, 0.25));
    rmRiverAddShallow(northRiver, rmRandFloat(0.75, 0.85));
    rmRiverSetBankNoiseParams(northRiver, 0.07, 2, 15.0, 15.0, 0.667, 1.8);
//    rmRiverBuild(northRiver);
  }
  
  // south/east river  
  else {
    if(whichVersion == 1) {
      rmRiverAddWaypoint(southRiver, 0.0, 0.65);
      rmRiverAddWaypoint(southRiver, .29, .29);
      riverXLoc = .29;
      riverYLoc = .29;
      rmRiverAddWaypoint(southRiver, 0.65, 0.0);
    }
    
    else {
      rmRiverAddWaypoint(southRiver, 1.0, 0.64);
      rmRiverAddWaypoint(southRiver, .7, .3);
      riverXLoc = .7;
      riverYLoc = .3;
      rmRiverAddWaypoint(southRiver, 0.375, 0.0);
    } 
    
    rmRiverSetShallowRadius(southRiver, 5);
    rmRiverAddShallow(southRiver, rmRandFloat(0.15, 0.25));
    rmRiverAddShallow(southRiver, rmRandFloat(0.75, 0.85));
    rmRiverSetBankNoiseParams(southRiver, 0.07, 2, 5.0, 5.0, 0.667, 1.8);
    rmRiverBuild(southRiver);
  }

  // Paint some grass near the river
 int grassPatch=rmCreateArea("grassy area near river");
  rmSetAreaSize(grassPatch, .5, .5);
  rmSetAreaLocation(grassPatch, riverXLoc, riverYLoc);
  rmSetAreaWarnFailure(grassPatch, false);
  rmSetAreaSmoothDistance(grassPatch, 10);
  rmSetAreaCoherence(grassPatch, .6);
  rmSetAreaMix(grassPatch, "texas_grass");
  rmAddAreaConstraint(grassPatch, riverGrass);
  rmBuildArea(grassPatch);

  
 // Cliff only present in non-FFA games
  int startingCliff1=rmCreateArea("Plateau");
  rmSetAreaSize(startingCliff1, .125, .125);
  rmSetAreaLocation(startingCliff1, .5, .5);
  rmSetAreaWarnFailure(startingCliff1, false);
  rmSetAreaSmoothDistance(startingCliff1, 10);
  rmSetAreaCoherence(startingCliff1, .6);
  rmSetAreaTerrainType(startingCliff1, "borneo\ground_grass4_borneo");
  rmSetAreaMix(startingCliff1, "texas_grass");
  //rmSetAreaCliffPainting(startingCliff1, true, true, true, 0, true);
  rmAddAreaConstraint(startingCliff1, avoidWater10);
  rmBuildArea(startingCliff1);
  
 
  
   // Text
   rmSetStatusText("",0.35);

   
	//Bottom Village
	int topleftVillageID = -1;
	if (subCiv0 == rmGetCivID("Pesantren"))
	{  
		topleftVillageID = rmCreateGrouping("Tupi village Top Left", "Pesantren_"+rmRandInt(1,5));
	}
	else if (subCiv0 == rmGetCivID("Kejawen"))
	{  
		topleftVillageID = rmCreateGrouping("Carib village Top Left", "Kejawen_"+rmRandInt(1,5));
	}
	else if (subCiv0 == rmGetCivID("Matraman"))
	{  
		topleftVillageID = rmCreateGrouping("Zapotec village Top Left", "Matraman_"+rmRandInt(1,4));
	}
	else
	{  
		topleftVillageID = rmCreateGrouping("Maya village Top Left", "Matraman_"+rmRandInt(1,4));
	}
	rmSetGroupingMinDistance(topleftVillageID, 0.0);
	rmSetGroupingMaxDistance(topleftVillageID, 0.20);
	rmAddGroupingToClass(topleftVillageID, rmClassID("natives"));
	rmAddGroupingToClass(topleftVillageID, rmClassID("importantItem"));
	rmPlaceGroupingAtLoc(topleftVillageID, 0, 0.40, 0.40);

	//Right Village
	int bottomleftVillageID = -1;
	if (subCiv1 == rmGetCivID("Pesantren"))
	{  
		bottomleftVillageID = rmCreateGrouping("Tupi village Bottom Left", "Pesantren_"+rmRandInt(1,5));
	}
	else if (subCiv1 == rmGetCivID("Kejawen"))
	{  
		bottomleftVillageID = rmCreateGrouping("Carib village Bottom Left", "Kejawen_"+rmRandInt(1,5));
	}
	else if (subCiv1 == rmGetCivID("Matraman"))
	{  
		bottomleftVillageID = rmCreateGrouping("Zapotec village Bottom Left", "Matraman_"+rmRandInt(1,4));
	}
	else
	{  
		bottomleftVillageID = rmCreateGrouping("Maya village Bottom Left", "Matraman_"+rmRandInt(1,4));
	}
	rmSetGroupingMinDistance(bottomleftVillageID, 0.0);
	rmSetGroupingMaxDistance(bottomleftVillageID, 0.20);
	rmAddGroupingToClass(bottomleftVillageID, rmClassID("natives"));
	rmAddGroupingToClass(bottomleftVillageID, rmClassID("importantItem"));
	rmPlaceGroupingAtLoc(bottomleftVillageID, 0, 0.6, 0.4);

	//Left Village
	int topRightVillageID = -1;
	if (subCiv2 == rmGetCivID("Pesantren"))
	{  
		topRightVillageID = rmCreateGrouping("Tupi village Top Right", "Pesantren_"+rmRandInt(1,5));
	}
	else if (subCiv2 == rmGetCivID("Kejawen"))
	{  
		topRightVillageID = rmCreateGrouping("Carib village Top Right", "Kejawen_"+rmRandInt(1,5));
	}
	else if (subCiv2 == rmGetCivID("Matraman"))
	{  
		topRightVillageID = rmCreateGrouping("Zapotec village Top Right", "Matraman_"+rmRandInt(1,4));
	}
	else
	{  
		topRightVillageID = rmCreateGrouping("Maya village Top Right", "Matraman_"+rmRandInt(1,4));
	}
	rmSetGroupingMinDistance(topRightVillageID, 0.0);
	rmSetGroupingMaxDistance(topRightVillageID, 0.20);
	rmAddGroupingToClass(topRightVillageID, rmClassID("natives"));
	rmAddGroupingToClass(topRightVillageID, rmClassID("importantItem"));
	rmPlaceGroupingAtLoc(topRightVillageID, 0, 0.4, 0.6);


	//Top Village
	int bottomRightVillageID = -1;
	if (subCiv3 == rmGetCivID("Pesantren"))
	{  
		bottomRightVillageID = rmCreateGrouping("Tupi village Bottom Right", "Pesantren_"+rmRandInt(1,5));
	}
	else if (subCiv3 == rmGetCivID("Kejawen"))
	{  
		bottomRightVillageID = rmCreateGrouping("Carib village Bottom Right", "Kejawen_"+rmRandInt(1,5));
	}
	else if (subCiv3 == rmGetCivID("Matraman"))
	{  
		bottomRightVillageID = rmCreateGrouping("Zapotec village Bottom Right", "Matraman_"+rmRandInt(1,4));
	}
	else
	{  
		bottomRightVillageID = rmCreateGrouping("Maya village Bottom Right", "Matraman_"+rmRandInt(1,4));
	}
	rmSetGroupingMinDistance(bottomRightVillageID, 0.0);
	rmSetGroupingMaxDistance(bottomRightVillageID, 0.20);
	rmAddGroupingToClass(bottomRightVillageID, rmClassID("natives"));
	rmAddGroupingToClass(bottomRightVillageID, rmClassID("importantItem"));
	rmPlaceGroupingAtLoc(bottomRightVillageID, 0, 0.6, 0.6);


   
   
   rmSetStatusText("",0.45);
   
   
	// PLAYER STARTING RESOURCES

   rmClearClosestPointConstraints();

	// Player placement
	int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
  
	int TCID = rmCreateObjectDef("player TC");
	if (rmGetNomadStart()) {
			rmAddObjectDefItem(TCID, "CoveredWagon", 1, 0.0);
  }
	else {
		rmAddObjectDefItem(TCID, "TownCenter", 1, 0.0);
  }

  rmSetObjectDefMinDistance(TCID, 0.0);
	rmSetObjectDefMaxDistance(TCID, 5.0);

	rmAddObjectDefConstraint(TCID, avoidTownCenter);
	rmAddObjectDefConstraint(TCID, avoidNatives);
	rmAddObjectDefConstraint(TCID, playerEdgeConstraint);
	rmAddObjectDefConstraint(TCID, avoidImpassableLand);

	int playerSilverID = rmCreateObjectDef("player mine");
	rmAddObjectDefItem(playerSilverID, "minegold", 1, 0);
	rmAddObjectDefConstraint(playerSilverID, avoidTownCenter);
	rmAddObjectDefConstraint(playerSilverID, avoidNatives);
	rmSetObjectDefMinDistance(playerSilverID, 12.0);
	rmSetObjectDefMaxDistance(playerSilverID, 16.0);
  rmAddObjectDefConstraint(playerSilverID, avoidImpassableLand);

	int playerFoodID=rmCreateObjectDef("player nilgai");
  rmAddObjectDefItem(playerFoodID, "Pronghorn", 8, 6.0);
  rmAddObjectDefToClass(playerFoodID, foodClass);
  rmSetObjectDefMinDistance(playerFoodID, 8);
  rmSetObjectDefMaxDistance(playerFoodID, 14);
	rmAddObjectDefConstraint(playerFoodID, avoidAll);
  rmAddObjectDefConstraint(playerFoodID, avoidFood);
  rmAddObjectDefConstraint(playerFoodID, avoidImpassableLand);
  rmAddObjectDefConstraint(playerFoodID, avoidNatives);
  rmSetObjectDefCreateHerd(playerFoodID, false);

	int playerTreeID=rmCreateObjectDef("player trees");
  rmAddObjectDefItem(playerTreeID, "STreeTeak", 7, 13);
  rmSetObjectDefMinDistance(playerTreeID, 8);
  rmSetObjectDefMaxDistance(playerTreeID, 12);
	rmAddObjectDefConstraint(playerTreeID, avoidAll);
  rmAddObjectDefConstraint(playerTreeID, avoidImpassableLand);
  rmAddObjectDefConstraint(playerTreeID, avoidNatives);
  
  int playerNuggetID=rmCreateObjectDef("player nugget");
  rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
  rmSetObjectDefMinDistance(playerNuggetID, 15.0);
  rmSetObjectDefMaxDistance(playerNuggetID, 20.0);
  rmAddObjectDefConstraint(playerNuggetID, avoidAll);
  rmAddObjectDefConstraint(playerNuggetID, avoidImpassableLand);
  rmAddObjectDefConstraint(playerNuggetID, avoidNatives);
  
  int playerCrateID=rmCreateObjectDef("bonus starting crates");
  rmAddObjectDefItem(playerCrateID, "STelikSandi", 1, 7.0);
  rmSetObjectDefMinDistance(playerCrateID, 10);
  rmSetObjectDefMaxDistance(playerCrateID, 12);
	rmAddObjectDefConstraint(playerCrateID, avoidAll);
  rmAddObjectDefConstraint(playerCrateID, avoidImpassableLand);
  rmAddObjectDefConstraint(playerCrateID, avoidNatives);
  
  int playerBerryID=rmCreateObjectDef("player berries");
  rmAddObjectDefItem(playerBerryID, "berryBush", 4, 4.0);
  rmSetObjectDefMinDistance(playerBerryID, 10);
  rmSetObjectDefMaxDistance(playerBerryID, 15);
	rmAddObjectDefConstraint(playerBerryID, avoidAll);
  rmAddObjectDefConstraint(playerBerryID, avoidImpassableLand);
  rmAddObjectDefConstraint(playerBerryID, avoidNatives);

	for(i=1; <cNumberPlayers) {
	  rmPlaceObjectDefAtLoc(TCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	  vector TCLoc = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, i));

	  rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
	  rmPlaceObjectDefAtLoc(playerSilverID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
	  rmPlaceObjectDefAtLoc(playerFoodID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
    rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
    rmPlaceObjectDefAtLoc(playerCrateID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
    rmPlaceObjectDefAtLoc(playerBerryID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

    rmSetNuggetDifficulty(1, 1);
    rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
    
    // Japanese
    if(ypIsAsian(i) && rmGetNomadStart() == false)
      rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i), i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
  }
  
  rmClearClosestPointConstraints();
  
  // Text
  rmSetStatusText("",0.55);
  
	int silverID = -1;
	int silverCount = 3;
  
  if (cNumberNonGaiaPlayers < 5)
    silverCount = 4;
  
	rmEchoInfo("silver count = "+silverCount);

  int rightSilverID = rmCreateObjectDef("silver "+i);
  rmAddObjectDefItem(rightSilverID, "minegold", 1, 0.0);
  rmSetObjectDefMinDistance(rightSilverID, rmXFractionToMeters(0.2));
  rmSetObjectDefMaxDistance(rightSilverID, rmXFractionToMeters(0.48));
  rmAddObjectDefConstraint(rightSilverID, avoidAll);
  rmAddObjectDefConstraint(rightSilverID, avoidCoin);    
  rmAddObjectDefConstraint(rightSilverID, avoidGold);
  rmAddObjectDefConstraint(rightSilverID, avoidImpassableLand);
  rmAddObjectDefConstraint(rightSilverID, avoidImportantItem);
  rmAddObjectDefConstraint(rightSilverID, avoidWater10);
  rmAddObjectDefConstraint(rightSilverID, playerConstraintFar);
  rmAddObjectDefConstraint(rightSilverID, avoidNatives);
  rmPlaceObjectDefPerPlayer(rightSilverID, false, silverCount);
  
  int numTries=4*cNumberNonGaiaPlayers;
  int failCount=0;
  
  // Text
  rmSetStatusText("",0.60);

  // heavier forests in central area
  for (i=0; <numTries) {   
    int forest=rmCreateArea("foresta"+i, startingCliff1);
    rmSetAreaWarnFailure(forest, false);
    rmSetAreaSize(forest, rmAreaTilesToFraction(400), rmAreaTilesToFraction(450));
    rmSetAreaForestType(forest, "Jawa Lowland Forest");
    rmSetAreaForestDensity(forest, 1);
    rmSetAreaForestClumpiness(forest, 0.9);
    rmSetAreaForestUnderbrush(forest, 0.7);
    rmSetAreaCoherence(forest, 0.7);
    rmAddAreaToClass(forest, rmClassID("classForest"));
    rmAddAreaConstraint(forest, forestConstraintSmall);
    rmAddAreaConstraint(forest, forestObjConstraint);
    rmAddAreaConstraint(forest, forestMidConstraint);
    rmAddAreaConstraint(forest, avoidImportantItem);
    rmAddAreaConstraint(forest, playerConstraintMid);
    rmAddAreaConstraint(forest, avoidNatives);
    rmAddAreaConstraint(forest, avoidWater4); 


     if(rmBuildArea(forest)==false)
     {
        // Stop trying once we fail 3 times in a row.
        failCount++;
        if(failCount==3)
           break;
     }
     else
        failCount=0; 
  } 
 
  // sparser forests around the outside where the gold is

	for(i=0; < 40*cNumberNonGaiaPlayers)  
	{
		int randomTreeID=rmCreateObjectDef("random tree "+i);
		rmAddObjectDefItem(randomTreeID, "STreeTeak", rmRandInt(5,8), 3.0);
        	rmAddObjectDefItem(randomTreeID, "UnderbrushBorneo", rmRandInt(4,6), 4.0);
		rmSetObjectDefMinDistance(randomTreeID, 1);
		rmSetObjectDefMaxDistance(randomTreeID, rmXFractionToMeters(0.3));
		rmAddObjectDefConstraint(randomTreeID, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID, forestObjConstraint);
		rmAddObjectDefConstraint(randomTreeID, avoidImportantItem);
		rmAddObjectDefConstraint(randomTreeID, avoidWater4); 
		rmAddObjectDefConstraint(randomTreeID, playerConstraintMid);
		rmAddObjectDefConstraint(randomTreeID, avoidNatives);
		rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5);
   }

	for(i=0; < 5*cNumberNonGaiaPlayers)  
	{
		int randomTreeID2=rmCreateObjectDef("random tree south"+i);
		rmAddObjectDefItem(randomTreeID2, "STreeTeak", rmRandInt(2,5), 3.0);
		rmSetObjectDefMinDistance(randomTreeID2, 0.1);
		rmSetObjectDefMaxDistance(randomTreeID2, rmXFractionToMeters(0.3));
		rmAddObjectDefConstraint(randomTreeID2, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID2, forestObjConstraint);
		rmAddObjectDefConstraint(randomTreeID2, avoidImportantItem);
		rmAddObjectDefConstraint(randomTreeID2, avoidWater4); 
		rmAddObjectDefConstraint(randomTreeID2, playerConstraintMid);
		rmAddObjectDefConstraint(randomTreeID2, avoidNatives);
		rmPlaceObjectDefAtLoc(randomTreeID2, 0, 0, 0);
   }
    
	for(i=0; < 5*cNumberNonGaiaPlayers)  
	{
		int randomTreeID3=rmCreateObjectDef("random tree north"+i);
		rmAddObjectDefItem(randomTreeID3, "STreeTeak", rmRandInt(2,5), 3.0);
		rmSetObjectDefMinDistance(randomTreeID3, 0.1);
		rmSetObjectDefMaxDistance(randomTreeID3, rmXFractionToMeters(0.3));
		rmAddObjectDefConstraint(randomTreeID3, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID3, forestObjConstraint);
		rmAddObjectDefConstraint(randomTreeID3, avoidImportantItem);
		rmAddObjectDefConstraint(randomTreeID3, avoidWater4); 
		rmAddObjectDefConstraint(randomTreeID3, playerConstraintMid);
		rmAddObjectDefConstraint(randomTreeID3, avoidNatives);
		rmPlaceObjectDefAtLoc(randomTreeID3, 0, 1, 1);
   }
	for(i=0; < 5*cNumberNonGaiaPlayers)  
	{
		int randomTreeID4=rmCreateObjectDef("random tree east"+i);
		rmAddObjectDefItem(randomTreeID4, "STreeTeak", rmRandInt(2,5), 3.0);
		rmSetObjectDefMinDistance(randomTreeID4, 0.1);
		rmSetObjectDefMaxDistance(randomTreeID4, rmXFractionToMeters(0.3));
		rmAddObjectDefConstraint(randomTreeID4, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID4, forestObjConstraint);
		rmAddObjectDefConstraint(randomTreeID4, avoidImportantItem);
		rmAddObjectDefConstraint(randomTreeID4, avoidWater4); 
		rmAddObjectDefConstraint(randomTreeID4, playerConstraintMid);
		rmAddObjectDefConstraint(randomTreeID4, avoidNatives);
		rmPlaceObjectDefAtLoc(randomTreeID4, 0, 0, 1);
   }
	for(i=0; < 5*cNumberNonGaiaPlayers)  
	{
		int randomTreeID5=rmCreateObjectDef("random tree west"+i);
		rmAddObjectDefItem(randomTreeID5, "STreeTeak", rmRandInt(2,5), 3.0);
		rmSetObjectDefMinDistance(randomTreeID5, 0.1);
		rmSetObjectDefMaxDistance(randomTreeID5, rmXFractionToMeters(0.3));
		rmAddObjectDefConstraint(randomTreeID5, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID5, forestObjConstraint);
		rmAddObjectDefConstraint(randomTreeID5, avoidImportantItem);
		rmAddObjectDefConstraint(randomTreeID5, avoidWater4); 
		rmAddObjectDefConstraint(randomTreeID5, playerConstraintMid);
		rmAddObjectDefConstraint(randomTreeID5, avoidNatives);
		rmPlaceObjectDefAtLoc(randomTreeID5, 0, 1, 0);
   }
  // Text
  rmSetStatusText("",0.75);

  int foodCount = rmRandInt(6,8);

  int foodID=rmCreateObjectDef("nilgai");
  rmAddObjectDefItem(foodID, "Pronghorn", foodCount, 6.0);
  rmAddObjectDefToClass(foodID, foodClass);
  rmSetObjectDefMinDistance(foodID, 0.0);
  rmSetObjectDefMaxDistance(foodID, rmXFractionToMeters(0.15));
  rmAddObjectDefConstraint(foodID, avoidImpassableLand);
  rmAddObjectDefConstraint(foodID, playerConstraintMid);
  rmAddObjectDefConstraint(foodID, avoidFoodMid);
  rmAddObjectDefConstraint(foodID, avoidNatives);
  rmAddObjectDefConstraint(foodID, avoidImportantItem); 
  rmSetObjectDefCreateHerd(foodID, true);
  rmPlaceObjectDefAtLoc(foodID, 0, 0.5, 0.5, 3*cNumberNonGaiaPlayers);
  
  // smaller herds around the map edges
  foodCount = rmRandInt(4,5);
  
  int food2ID=rmCreateObjectDef("more nilgai");
  rmAddObjectDefItem(food2ID, "Pronghorn", foodCount, 4.0);
  rmAddObjectDefToClass(food2ID, foodClass);
  rmSetObjectDefMinDistance(food2ID, 0.0);
  rmSetObjectDefMaxDistance(food2ID, rmXFractionToMeters(0.5));
  rmAddObjectDefConstraint(food2ID, avoidImpassableLand);
  rmAddObjectDefConstraint(food2ID, avoidFoodFar);
  rmAddObjectDefConstraint(food2ID, playerConstraintMid);
  rmAddObjectDefConstraint(food2ID, avoidWater4);
  rmAddObjectDefConstraint(food2ID, avoidImportantItem); 
  rmAddObjectDefConstraint(food2ID, avoidNatives); 
  rmAddObjectDefConstraint(food2ID, edgeForestConstraint);
  rmSetObjectDefCreateHerd(food2ID, true);
  rmPlaceObjectDefAtLoc(food2ID, 0, 0.5, 0.5, 5*cNumberNonGaiaPlayers);
  
  foodCount = rmRandInt(2,2);
  
  int food3ID=rmCreateObjectDef("ephelants!");
  rmAddObjectDefItem(food3ID, "Pronghorn", foodCount, 3.0);
  rmAddObjectDefToClass(food3ID, foodClass);
  rmSetObjectDefMinDistance(food3ID, rmXFractionToMeters(0.25));
  rmSetObjectDefMaxDistance(food3ID, rmXFractionToMeters(0.5));
  rmAddObjectDefConstraint(food3ID, avoidImpassableLand);
  rmAddObjectDefConstraint(food3ID, playerConstraintFar);
  rmAddObjectDefConstraint(food3ID, avoidNatives);
  rmAddObjectDefConstraint(food3ID, avoidFoodMid);
  rmAddObjectDefConstraint(food3ID, avoidElephants);
  rmSetObjectDefCreateHerd(food3ID, true);
  rmPlaceObjectDefAtLoc(food3ID, 0, 0.5, 0.5, 2*cNumberNonGaiaPlayers);
  
  int herdID=rmCreateObjectDef("water buffalo");
  rmAddObjectDefItem(herdID, "YPPetTiger", 1, 2.5);
  rmSetObjectDefMinDistance(herdID, 0.0);
  rmSetObjectDefMaxDistance(herdID, rmXFractionToMeters(0.225));
  rmAddObjectDefConstraint(herdID, avoidHerdables);
  rmAddObjectDefConstraint(herdID, avoidAll);
  rmAddObjectDefConstraint(herdID, avoidImpassableLandShort);
  rmAddObjectDefConstraint(herdID, avoidNatives);
  rmAddObjectDefConstraint(herdID, avoidTC);
  rmPlaceObjectDefAtLoc(herdID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4); 
  
  // Berries
  int berriesID=rmCreateObjectDef("berries");
	rmAddObjectDefItem(berriesID, "berrybush", 4, 3.0);
	rmSetObjectDefMinDistance(berriesID, 0);
	rmSetObjectDefMaxDistance(berriesID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(berriesID, avoidImpassableLand);
	rmAddObjectDefConstraint(berriesID, playerConstraintFar); 
  rmAddObjectDefConstraint(berriesID, avoidBerries);
  rmAddObjectDefConstraint(berriesID, avoidImportantItem);
  rmAddObjectDefConstraint(berriesID, avoidNatives);
  rmAddObjectDefConstraint(berriesID, avoidResource);
  rmPlaceObjectDefAtLoc(berriesID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);  

  // Text
  rmSetStatusText("",0.90);
  
  // check for KOTH game mode
  if(rmGetIsKOTH()) {
    
    int randLoc = rmRandInt(1,2);
    float xLoc = 0.5;
    float yLoc = 0.5;
    float walk = 0.075;
    
    ypKingsHillPlacer(xLoc, yLoc, walk, 0);
    rmEchoInfo("XLOC = "+xLoc);
    rmEchoInfo("XLOC = "+yLoc);
  }
  


  // some crazy nuggets

	int crazyNugget= rmCreateObjectDef("nugget crazy"); 
	rmAddObjectDefItem(crazyNugget, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(4, 4);
	rmSetObjectDefMinDistance(crazyNugget, 0.0);
	rmSetObjectDefMaxDistance(crazyNugget, rmXFractionToMeters(0.25));
	rmAddObjectDefConstraint(crazyNugget, avoidImpassableLand);
  rmAddObjectDefConstraint(crazyNugget, avoidNugget);
  rmAddObjectDefConstraint(crazyNugget, avoidWater4);
  rmAddObjectDefConstraint(crazyNugget, avoidAll);
  rmAddObjectDefConstraint(crazyNugget, playerConstraintNugget);
  rmAddObjectDefConstraint(crazyNugget, resourceEdgeConstraint);
  rmAddObjectDefConstraint(crazyNugget, avoidNatives);
  rmAddObjectDefConstraint(crazyNugget, avoidImportantItem);
  rmPlaceObjectDefAtLoc(crazyNugget, 0, 0.5, 0.5, 2*cNumberNonGaiaPlayers);

  
  // some hard nuggets
	int hardNugget= rmCreateObjectDef("nugget hard"); 
	rmAddObjectDefItem(hardNugget, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(3, 3);
	rmSetObjectDefMinDistance(hardNugget, 0.0);
	rmSetObjectDefMaxDistance(hardNugget, rmXFractionToMeters(0.25));
	rmAddObjectDefConstraint(hardNugget, avoidImpassableLand);
  rmAddObjectDefConstraint(hardNugget, avoidNugget);
  rmAddObjectDefConstraint(hardNugget, avoidWater4);
  rmAddObjectDefConstraint(hardNugget, avoidAll);
  rmAddObjectDefConstraint(hardNugget, playerConstraintNugget);
  rmAddObjectDefConstraint(hardNugget, resourceEdgeConstraint);
  rmAddObjectDefConstraint(hardNugget, avoidImportantItem);
  rmPlaceObjectDefAtLoc(hardNugget, 0, 0.5, 0.5, 2*cNumberNonGaiaPlayers);
  
  // medium nuggets
  int mediumNugget= rmCreateObjectDef("nugget medium"); 
	rmAddObjectDefItem(mediumNugget, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(2, 2);
  rmSetObjectDefMinDistance(mediumNugget, rmXFractionToMeters(0.15));
	rmSetObjectDefMaxDistance(mediumNugget, rmXFractionToMeters(0.45));
	rmAddObjectDefConstraint(mediumNugget, avoidImpassableLand);
  rmAddObjectDefConstraint(mediumNugget, avoidNugget);
	rmAddObjectDefConstraint(mediumNugget, avoidWater4);
  rmAddObjectDefConstraint(mediumNugget, avoidAll);
  rmAddObjectDefConstraint(mediumNugget, playerConstraintNugget);
	rmAddObjectDefConstraint(mediumNugget, resourceEdgeConstraint);
	rmAddObjectDefConstraint(mediumNugget, avoidNatives);
  rmAddObjectDefConstraint(mediumNugget, avoidImportantItem);
  rmPlaceObjectDefAtLoc(mediumNugget, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);

  // easy nuggets 
  int easyNugget= rmCreateObjectDef("easy nuggets"); 
	rmAddObjectDefItem(easyNugget, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(1, 1);
  rmSetObjectDefMinDistance(easyNugget, rmXFractionToMeters(0.25));
	rmSetObjectDefMaxDistance(easyNugget, rmXFractionToMeters(0.45));
	rmAddObjectDefConstraint(easyNugget, avoidImpassableLand);
  rmAddObjectDefConstraint(easyNugget, avoidNugget);
	rmAddObjectDefConstraint(easyNugget, avoidWater4);
  rmAddObjectDefConstraint(easyNugget, avoidAll);
  rmAddObjectDefConstraint(easyNugget, playerConstraintFar);
  rmAddObjectDefConstraint(easyNugget, avoidNatives);
	rmAddObjectDefConstraint(easyNugget, resourceEdgeConstraint);
  rmAddObjectDefConstraint(easyNugget, avoidImportantItem); 
  rmPlaceObjectDefAtLoc(easyNugget, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);
  
  // Team nuggets
  if(cNumberTeams == 2 && cNumberNonGaiaPlayers > 2){
    rmSetNuggetDifficulty(12, 12);
	  rmPlaceObjectDefAtLoc(easyNugget, 0, 0.5, 0.5, 2*cNumberNonGaiaPlayers);
  }

	int Underbrush= rmCreateObjectDef("random underbrush"); 
	rmAddObjectDefItem(Underbrush, "UnderbrushBorneo", 1, 0.0);
	rmSetObjectDefMinDistance(Underbrush, 0.0);
	rmSetObjectDefMaxDistance(Underbrush, rmXFractionToMeters(0.25));
	rmAddObjectDefConstraint(Underbrush, avoidImpassableLand);
  rmAddObjectDefConstraint(Underbrush, avoidNugget);
  rmAddObjectDefConstraint(Underbrush, avoidWater4);
  rmAddObjectDefConstraint(Underbrush, avoidAll);
  rmAddObjectDefConstraint(Underbrush, avoidNatives);
  rmAddObjectDefConstraint(Underbrush, playerConstraintNugget);
  rmAddObjectDefConstraint(Underbrush, resourceEdgeConstraint);
  rmAddObjectDefConstraint(Underbrush, avoidImportantItem);
  rmPlaceObjectDefAtLoc(Underbrush, 0, 0.5, 0.5, 5*cNumberNonGaiaPlayers);
  
  // Text
  rmSetStatusText("",1.0);
      
}  
