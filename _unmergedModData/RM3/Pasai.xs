// Pasai
// Original by RF_Gandalf - KOREA -
// Inverse version by HrdsHrdrck for Pepp
// Finishing by Pepp
// Main entry point for random map script    

include "mercenaries.xs";
include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";

// initialize map type variables
  string nativeCiv1 = "";
  string nativeCiv2 = "";
 
  string baseMix = "texas_grass";
  string baseTerrain = "water";
  string seaType = "new england coast";
  string cliffType = "Texas Grass";

  string forestType = "Jawa Lowland Forest";
  string startTreeType = "STreeMahogany";
  
  string mapType1 = "Sundaland";
  string mapType2 = "yellowRiver";

  string huntable1 = "Tapir";  
  string huntable2 = "ypWildElephant";
  string fish1 = "ypFishTuna";
  string fish2 = "ypSquid";
  string whale1 = "HumpbackWhale";
  string sheepType = "ypGoat";
  
  string patchTerrain = "Texas\ground1_tex";
  string patchType1 = "Texas\ground2_tex";
  string patchType2 = "Texas\groundforest_tex";
  
  string lightingType = "Himalayas";
  
// Initialize terms
  int classSmallIsland = 0;
  int avoidAll = 0;
  int avoidAllForests = 0;
  int avoidWater4 = 0;
  int avoidRandomBerries = 0;
  int avoidNugget = 0;
  int nuggetVsCoin = 0;
  int islandConstraint = 0; 
  int avoidSmallIslands = 0;
  int nuggetAvoidsBerries = 0;
  int forestVsNugget = 0;
  int forestVsCoin = 0;
  int islandEdgeConstraint = 0;
  int forestConstraintShort = 0;
  int avoidImpassableLand = 0;
  int avoidImpassableLandLong = 0;
  int shortAvoidTradeRoute = 0;
  int avoidTradeRouteSocketsShort = 0;
  int avoidTradeRouteSocketsNear = 0;
  int avoidNuggetShort = 0;
  int avoidCoinShort = 0;
  int numTries = 0;
  int goldCounter = 0;
  int berryCounter = 0;
  int nuggetCounter = 0;
  int forestCounter = 0;
  int huntCounter = 0;
  float randomIslandStuff = 0.0;

   int classHuntable=0;
   int huntableConstraint=0;
   int classImportantItem=0;

   float xLoc = 0.0;
   float yLoc = 0.0;

//places mines in the north
void sfIslandGold (int islandID = 0, string mineType = "mine", int mineCount = 1)
{
  int islandGoldID = rmCreateObjectDef("random gold"+goldCounter);
  rmAddObjectDefItem(islandGoldID, mineType, 1, 0);
  rmSetObjectDefMinDistance(islandGoldID, 0.0);
  rmSetObjectDefMaxDistance(islandGoldID, 6.0);    
  rmAddObjectDefConstraint(islandGoldID, avoidImpassableLandLong);    
  rmAddObjectDefConstraint(islandGoldID, avoidTradeRouteSocketsShort);   
  rmAddObjectDefConstraint(islandGoldID, shortAvoidTradeRoute);   
  rmAddObjectDefConstraint(islandGoldID, avoidAll);    
  rmAddObjectDefConstraint(islandGoldID, avoidCoinShort);    
  rmAddObjectDefConstraint(islandGoldID, avoidNuggetShort);    
  rmPlaceObjectDefInArea(islandGoldID, 0, islandID, mineCount);
  goldCounter = goldCounter + 1;
}

//places berries in the north
void sfIslandBerries (int islandID = 0, int berryLow = 0, int berryHigh = 0)
{
  int islandBerriesID=rmCreateObjectDef("random berries"+berryCounter);
  rmAddObjectDefItem(islandBerriesID, "berrybush", rmRandInt(berryLow,berryHigh), 6.0); 
  rmSetObjectDefMinDistance(islandBerriesID, 0.0);
  rmSetObjectDefMaxDistance(islandBerriesID, rmXFractionToMeters(0.5));
  rmAddObjectDefConstraint(islandBerriesID, avoidRandomBerries);
  rmAddObjectDefConstraint(islandBerriesID, avoidImpassableLand);  
  rmAddObjectDefConstraint(islandBerriesID, avoidTradeRouteSocketsShort);   
  rmAddObjectDefConstraint(islandBerriesID, shortAvoidTradeRoute);   
  rmAddObjectDefConstraint(islandBerriesID, avoidAll);    
  rmPlaceObjectDefInArea(islandBerriesID, 0, islandID, 1); 
  berryCounter = berryCounter + 1;
}

//places treasures in the north
void sfIslandNuggets (int islandID = 0, int nuggetLow = 0, int nuggetHigh = 0)
{
  int nuggetID= rmCreateObjectDef("nugget"+nuggetCounter); 
  rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
  rmSetObjectDefMinDistance(nuggetID, 0.0);
  rmSetNuggetDifficulty(nuggetLow, nuggetHigh);
  rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
  rmAddObjectDefConstraint(nuggetID, nuggetAvoidsBerries);
  rmAddObjectDefConstraint(nuggetID, avoidAll);
  rmAddObjectDefConstraint(nuggetID, avoidImpassableLandLong);
  rmAddObjectDefConstraint(nuggetID, forestVsNugget);
  rmAddObjectDefConstraint(nuggetID, forestConstraintShort);
  rmAddObjectDefConstraint(nuggetID, avoidWater4);
  rmAddObjectDefConstraint(nuggetID, avoidTradeRouteSocketsShort);   
  rmAddObjectDefConstraint(nuggetID, shortAvoidTradeRoute);   
  rmAddObjectDefConstraint(nuggetID, islandEdgeConstraint);
  rmPlaceObjectDefInArea(nuggetID, 0, islandID, 1);
  nuggetCounter = nuggetCounter + 1;
}

//builds the north area
int sfBuildBigIsland (string bigIslandName = "", float x_loc = 0.0, float y_loc = 0.0, float mainlandType = 0.0)
{
  int bigIslandID=rmCreateArea(bigIslandName);
  rmSetAreaSize(bigIslandID, 0.14, 0.14);
  rmAddAreaToClass(bigIslandID, classSmallIsland);  
  rmSetAreaMix(bigIslandID, baseMix);
  rmSetAreaEdgeFilling(bigIslandID, 5);
  rmSetAreaBaseHeight(bigIslandID, 1.0);
  rmSetAreaSmoothDistance(bigIslandID, 10);
  rmSetAreaWarnFailure(bigIslandID, false);
  rmSetAreaCoherence(bigIslandID, 0.55);
  rmSetAreaLocation(bigIslandID, x_loc, y_loc);  
  rmSetAreaObeyWorldCircleConstraint(bigIslandID, false);
  rmSetAreaElevationType(bigIslandID, cElevTurbulence);
  rmSetAreaElevationVariation(bigIslandID, 3.0);
  rmSetAreaElevationMinFrequency(bigIslandID, 0.09);
  rmSetAreaElevationOctaves(bigIslandID, 3);
  rmSetAreaElevationPersistence(bigIslandID, 0.2);
  rmSetAreaElevationNoiseBias(bigIslandID, 1); 
  rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.1, 1.0, 0.1);
  rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.1, 0.0, 0.1);  
  rmBuildArea(bigIslandID);
  
    
    // check for KOTH game mode
    if(rmGetIsKOTH())
    {
      int randLoc = rmRandInt(1,2);
      float walk = 0.1;

      xLoc = 0.5;
      
      ypKingsHillPlacer(xLoc, yLoc, walk, avoidTradeRouteSocketsNear);
      rmEchoInfo("XLOC = "+xLoc);
      rmEchoInfo("XLOC = "+yLoc);
    }
  
  sfIslandBerries(bigIslandID, 7, 9);  
  sfIslandNuggets(bigIslandID, 4, 4);
  sfIslandNuggets(bigIslandID, 3, 3);
  
  if(cNumberNonGaiaPlayers < 4) 
    sfIslandGold(bigIslandID, "minegold", 2);
  else if(cNumberNonGaiaPlayers < 6) 
    sfIslandGold(bigIslandID, "minegold", 3);
  else if (mainlandType == 1.0)
    sfIslandGold(bigIslandID, "minegold", 4);
    
  return(bigIslandID);
}

//main function
void main(void)
{
// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.01);

// Define Natives
   int subCiv0=-1;
   int subCiv1=-1;
   int subCiv2=-1;

   if (rmAllocateSubCivs(3) == true)
   {
	subCiv0=rmGetCivID("Gayo");
	rmEchoInfo("subCiv0 is Gayo "+subCiv0);
	if (subCiv0 >= 0)
	rmSetSubCiv(0, "Gayo");

	subCiv1=rmGetCivID("Gayo");
	rmEchoInfo("subCiv1 is Gayo "+subCiv1);
	if (subCiv1 >= 0)
	rmSetSubCiv(1, "Gayo");

	subCiv2=rmGetCivID("Trumon");
	rmEchoInfo("subCiv2 is Trumon "+subCiv2);
	if (subCiv2 >= 0)
	rmSetSubCiv(2, "Trumon");
   }

// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.10);
		
// Set size of map
	int playerTiles=27000;
	if (cNumberNonGaiaPlayers == 3)   // If 3 players...
		playerTiles = 25000;		// ...give this many tiles per player.
	if (cNumberNonGaiaPlayers == 4)   // If 4 players...
		playerTiles = 22000;		// ...give this many tiles per player.
	if (cNumberNonGaiaPlayers >4)   // If 5 or 6 players...
		playerTiles = 19000;		// ...give this many tiles per player.
	if (cNumberNonGaiaPlayers >6)	// If more than 6 players...
		playerTiles = 15000;		// ...give this many tiles per player.	
	int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
	int longSide=1.35*size;
	rmEchoInfo("Map size="+size+"m x "+size+"m");
	rmSetMapSize(size, longSide);

// Set up map types
      int mapTypePicker = rmRandInt(1,2);
	rmSetSeaLevel(1.0);          
	rmSetSeaType(seaType);
      rmEnableLocalWater(false);
	rmSetBaseTerrainMix(baseMix);
      if (mapTypePicker == 1)
	   rmSetMapType(mapType1);
      else
	   rmSetMapType(mapType2);
	rmSetMapType("grass");
	rmSetMapType("water");
	rmSetLightingSet(lightingType);

// Initialize map.
	rmTerrainInitialize(baseTerrain);
	chooseMercs();

// Define some classes.
	int classPlayer=rmDefineClass("player");
	int classIsland=rmDefineClass("island");
      classSmallIsland=rmDefineClass("smallIsland");
	rmDefineClass("classForest");
	
	rmDefineClass("natives");
	rmDefineClass("classSocket");
      rmDefineClass("classPatch");

      classHuntable=rmDefineClass("huntableFood");   
      int classHerdable=rmDefineClass("herdableFood"); 
      classImportantItem=rmDefineClass("importantItem");
      rmDefineClass("classCliff");

// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.20);

// -------------Define constraints----------------------------------------
   avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 4.0);    
   avoidAllForests=rmCreateTypeDistanceConstraint("avoid all forests", "all", 6.0);    
   avoidRandomBerries=rmCreateTypeDistanceConstraint("avoid random berries", "berrybush", 55.0);
   nuggetAvoidsBerries=rmCreateTypeDistanceConstraint("nuggets avoid berries", "berrybush", 5.0);
   int avoidBerries = rmCreateTypeDistanceConstraint("avoid berries", "berrybush", 8.0);

   int avoidSheep=rmCreateClassDistanceConstraint("sheep avoids sheep etc", rmClassID("herdableFood"), 45.0);
   huntableConstraint=rmCreateClassDistanceConstraint("huntable constraint", rmClassID("huntableFood"), 45.0);
   int nuggetPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players a lot", classPlayer, 60.0);
  
   // Create an edge of map constraint.
   int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.46), rmDegreesToRadians(0), rmDegreesToRadians(360));

   // Player area constraint.
   int playerConstraint=rmCreateClassDistanceConstraint("stay away from players", classPlayer, 25.0);
   int playerConstraintFar=rmCreateClassDistanceConstraint("stay away from player Far", classPlayer, 75.0);
   int playerConstraintNative=rmCreateClassDistanceConstraint("natives stay away from player Far", classPlayer, 65.0);
  
   // Island Halves
   int westHalf = rmCreateBoxConstraint("stay in west half", .35, .7, .65, .6);
   int eastHalf = rmCreateBoxConstraint("stay in east half", .35, .4, .65, .3);
   int middle = rmCreateBoxConstraint("stay in middle", .285, .285, .715, .715);
   int avoidSouth = rmCreateBoxConstraint("avoid the south", 0.0, 0.05, 1.0, 1.0);

   // Bonus area constraint.  
   islandConstraint=rmCreateClassDistanceConstraint("stay away from main island", classIsland, 12.0);
   avoidSmallIslands = rmCreateClassDistanceConstraint("stay away from other bonus islands", classSmallIsland, 10.0);
   islandEdgeConstraint = rmCreatePieConstraint("Islands away from edge of map", 0.5, 0.5, 0, rmGetMapXSize()-12, 0, 0, 0);

   // Fish Constraints
   int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", fish1, 25.0);		
   int fishVsFishTarponID=rmCreateTypeDistanceConstraint("fish v fish2", fish2, 20.0);
   int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 8.0);			
   int whaleVsWhaleID=rmCreateTypeDistanceConstraint("whale v whale", whale1, 35.0);	
   int fishVsWhaleID=rmCreateTypeDistanceConstraint("fish v whale", whale1, 20.0); 
   int whaleLand = rmCreateTerrainDistanceConstraint("whale land", "land", true, 20.0);
   int whaleEdgeConstraint = rmCreatePieConstraint("whale away from edge of map", 0.5, 0.5, 0, rmGetMapXSize()-18, 0, 0, 0);
   int avoidLand = rmCreateTerrainDistanceConstraint("ship avoid land", "land", true, 15.0);

   // resource constraints
   int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 35.0);
   forestConstraintShort=rmCreateClassDistanceConstraint("vs. forest short", rmClassID("classForest"), 5.0);
   int avoidCoin=rmCreateTypeDistanceConstraint("avoid coin", "mine", 50.0);	
   avoidCoinShort=rmCreateTypeDistanceConstraint("avoid coin short", "minegold", 30.0);	
   int avoidGold=rmCreateTypeDistanceConstraint("avoid gold", "minegold", 55.0);	
   forestVsCoin=rmCreateTypeDistanceConstraint("forest vs. coin", "mine", 10.0);
   nuggetVsCoin=rmCreateTypeDistanceConstraint("nugget vs. coin", "mine", 8.0);
   int avoidRandomTurkeys=rmCreateTypeDistanceConstraint("avoid random turkeys", huntable1, 35.0);	
   avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "abstractNugget", 35.0); 
   int avoidNuggetFar=rmCreateTypeDistanceConstraint("nugget avoid nugget far", "abstractNugget", 70.0); 
   forestVsNugget=rmCreateTypeDistanceConstraint("forest vs. nugget", "abstractNugget", 10.0);
   avoidNuggetShort=rmCreateTypeDistanceConstraint("vs. nugget short", "abstractNugget", 8.0);
   int patchConstraint=rmCreateClassDistanceConstraint("patch vs. patch", rmClassID("classPatch"), 5.0);

   // Avoid impassable land
   avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 6.0);
   avoidImpassableLandLong=rmCreateTerrainDistanceConstraint("avoid impassable land long", "Land", false, 15.0);
   int shortAvoidImpassableLand=rmCreateTerrainDistanceConstraint("short avoid impassable land", "Land", false, 2.0);

   int cliffsAvoidCliffs=rmCreateClassDistanceConstraint("cliffs vs. cliffs", rmClassID("classCliff"), 30.0);

   // Constraint to avoid water.
   avoidWater4 = rmCreateTerrainDistanceConstraint("avoid water short", "Land", false, 5.0);
   int avoidWater20 = rmCreateTerrainDistanceConstraint("avoid water long", "Land", false, 20.0);
   int avoidWater8 = rmCreateTerrainDistanceConstraint("avoid water 8", "Land", false, 10.0);

   int avoidImportantItem = rmCreateClassDistanceConstraint("secrets etc avoid each other", rmClassID("importantItem"), 10.0);
   int avoidImportantItemFar = rmCreateClassDistanceConstraint("secrets etc avoid each other Far", rmClassID("importantItem"), 50.0);
  
   shortAvoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route short", 5.0);
   int medAvoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route med", 12.0);
   avoidTradeRouteSocketsShort=rmCreateTypeDistanceConstraint("avoid trade route sockets short", "sockettraderoute", 10.0);
   avoidTradeRouteSocketsNear=rmCreateTypeDistanceConstraint("avoid trade route sockets near", "sockettraderoute", 6.0);

   // Flag constraints for HC spawn point
   int flagEdgeConstraint = rmCreatePieConstraint("flags away from edge of map", 0.5, 0.5, 0, rmGetMapXSize()-15, 0, 0, 0);
   int flagLand = rmCreateTerrainDistanceConstraint("flag vs land", "land", true, 18.0);
   int flagVsFlag = rmCreateTypeDistanceConstraint("flag avoid same", "HomeCityWaterSpawnFlag", 22); 
	
// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.30);

// Make one big island.  
   int bigIslandID=rmCreateArea("big peninsula");
   rmSetAreaSize(bigIslandID, 0.44, 0.44);
   rmSetAreaCoherence(bigIslandID, 0.66);
   rmSetAreaBaseHeight(bigIslandID, 1.5);
   rmSetAreaSmoothDistance(bigIslandID, 12);
   rmSetAreaMix(bigIslandID, baseMix);
   rmAddAreaToClass(bigIslandID, classIsland);
   rmSetAreaObeyWorldCircleConstraint(bigIslandID, false);
   rmSetAreaElevationType(bigIslandID, cElevTurbulence);
   rmSetAreaElevationVariation(bigIslandID, 3.0);
   rmSetAreaElevationMinFrequency(bigIslandID, 0.12);
   rmSetAreaElevationOctaves(bigIslandID, 3);
   rmSetAreaElevationPersistence(bigIslandID, 0.15);
   rmSetAreaElevationNoiseBias(bigIslandID, 1);
   rmSetAreaEdgeFilling(bigIslandID, 5);
   rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.82, 0.5, 0.80); 
   rmAddAreaInfluenceSegment(bigIslandID, 0.0, 0.06, 1.0, 0.06);
   rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.80, 0.5, 0.81); 

   rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.25, 0.0, 0.1);
   rmAddAreaInfluenceSegment(bigIslandID, 0.5, 0.25, 1.0, 0.1);

   rmAddAreaInfluenceSegment(bigIslandID, 0.26, 0.0, 0.34, 0.71); 
   rmAddAreaInfluenceSegment(bigIslandID, 0.74, 0.0, 0.66, 0.71); 

   rmSetAreaLocation(bigIslandID, 0.5, 0.4);
   rmSetAreaWarnFailure(bigIslandID, false);
   rmBuildArea(bigIslandID);
   
   //Make trading route into the land
   
    int tradeRouteID = rmCreateTradeRoute();
    int socketID=rmCreateObjectDef("sockets to dock Trade Posts");
    rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
    rmAddObjectDefToClass(socketID, classImportantItem); 
    rmSetObjectDefAllowOverlap(socketID, true);
    rmSetObjectDefMinDistance(socketID, 0.0);
    rmSetObjectDefMaxDistance(socketID, 8.0);

    rmAddTradeRouteWaypoint(tradeRouteID, .915, .05);
    rmAddTradeRouteWaypoint(tradeRouteID, .9, .1);
    rmAddTradeRouteWaypoint(tradeRouteID, .85, .2);
    rmAddTradeRouteWaypoint(tradeRouteID, .7, .2);
    rmAddTradeRouteWaypoint(tradeRouteID, .62, .3);
    rmAddTradeRouteWaypoint(tradeRouteID, .6, .35);
    rmAddTradeRouteWaypoint(tradeRouteID, .57, .50);
    rmAddTradeRouteWaypoint(tradeRouteID, .55, .53);
    rmAddTradeRouteWaypoint(tradeRouteID, .5, .7);
    rmAddTradeRouteWaypoint(tradeRouteID, .45, .53);
    rmAddTradeRouteWaypoint(tradeRouteID, .43, .50);
    rmAddTradeRouteWaypoint(tradeRouteID, .4, .35);
    rmAddTradeRouteWaypoint(tradeRouteID, .38, .3);
    rmAddTradeRouteWaypoint(tradeRouteID, .3, .2);
    rmAddTradeRouteWaypoint(tradeRouteID, .15, .2);
    rmAddTradeRouteWaypoint(tradeRouteID, .1, .1);
    rmAddTradeRouteWaypoint(tradeRouteID, .085, .05);
    rmEchoInfo("Up top");
   
    bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "java");
    if(placedTradeRoute == false)
      rmEchoError("Failed to place trade route"); 
    
    // add the sockets along the trade route.
    rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
    
    vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.2);
    rmPlaceObjectDefAtPoint(socketID, 0, socketLoc); 
	
    socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.4);
    rmPlaceObjectDefAtPoint(socketID, 0, socketLoc); 
	
    socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.6);
    rmPlaceObjectDefAtPoint(socketID, 0, socketLoc); 

    socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.8);
    rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);   
   

// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.40);
	
// Set up player areas and starting locs
	
  float teamStartLoc = rmRandFloat(0.0, 1.0);  

  if (cNumberTeams == 2)
  {
    if (cNumberNonGaiaPlayers == 2)
    {
      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(0);
      else    
        rmSetPlacementTeam(1);

      rmPlacePlayersLine(0.67, 0.5, 0.67, 0.49, 0.1, 0);                

      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(1);
      else    
        rmSetPlacementTeam(0);

      rmPlacePlayersLine(0.33, 0.5, 0.33, 0.49, 0.1, 0); 
    }
    else if (cNumberNonGaiaPlayers < 5)
    {
      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(0);
      else    
        rmSetPlacementTeam(1);

      rmPlacePlayersLine(0.69, 0.6, 0.69, 0.4, 0.1, 0);                

      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(1);
      else    
        rmSetPlacementTeam(0);

      rmPlacePlayersLine(0.31, 0.4, 0.31, 0.6, 0.1, 0); 
    }  
    else
    {
      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(0);
      else    
        rmSetPlacementTeam(1);

      rmPlacePlayersLine(0.7, 0.65, 0.7, 0.35, 0.1, 0);                

      if (teamStartLoc > 0.5)
        rmSetPlacementTeam(1);
      else    
        rmSetPlacementTeam(0);

      rmPlacePlayersLine(0.3, 0.35, 0.3, 0.65, 0.1, 0); 
    } 
  }
  else  // otherwise FFA
  {
	if (cNumberNonGaiaPlayers < 5)
 	   rmSetPlayerPlacementArea(0.31, 0.35, 0.69, 0.65);
	else if (cNumberNonGaiaPlayers < 7)
 	   rmSetPlayerPlacementArea(0.31, 0.33, 0.69, 0.67);
	else
 	   rmSetPlayerPlacementArea(0.3, 0.31, 0.7, 0.68);
	rmPlacePlayersSquare(0.5, 0.0, 0.0);
  }

 // Create the Player's area.
   float playerFraction=rmAreaTilesToFraction(100);
   for(i=1; <cNumberPlayers)
   {
    int id=rmCreateArea("Player"+i, bigIslandID);
    rmSetPlayerArea(i, id);
    rmSetAreaSize(id, playerFraction, playerFraction);
    rmAddAreaConstraint(id, avoidWater8);
    rmAddAreaToClass(id, classPlayer);
    rmSetAreaLocPlayer(id, i);
    rmSetAreaWarnFailure(id, true);
   }

   // Build the areas. 
   rmBuildAllAreas();

// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.50);

   int castleSetup = rmRandInt(1,2);
   if (cNumberTeams > 2)
	castleSetup = 3;

   if (castleSetup == 1)
      yLoc = 0.07;
   else if (castleSetup == 2)
      yLoc = 0.28;
   else
	yLoc = 0.5;

   int bonusIslandID6 = sfBuildBigIsland("bonus island 6", 0.5, 0.08, 1.0);

// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.60);
 
// Natives  
   int nativeType = rmRandInt(1,3);
   int villageType = rmRandInt(1,5);
   int nativeSetup = rmRandInt(1,2);

    int villageAID = -1;  // SOUTHERN VILLAGE
    if (nativeType == 1)
       villageAID = rmCreateGrouping("village A", "Gayo_"+villageType);
    else 
       villageAID = rmCreateGrouping("village A", "Gayo_"+villageType);
    rmAddGroupingToClass(villageAID, rmClassID("importantItem"));
    rmSetGroupingMinDistance(villageAID, 0.0);
    rmSetGroupingMaxDistance(villageAID, 15.0);
    rmAddGroupingConstraint(villageAID, avoidImpassableLand);
    rmAddGroupingConstraint(villageAID, avoidWater8);
    rmAddGroupingConstraint(villageAID, avoidImportantItemFar);
    rmAddGroupingConstraint(villageAID, playerConstraintNative);
    rmAddGroupingConstraint(villageAID, avoidAll);
    rmAddGroupingConstraint(villageAID, medAvoidTradeRoute);
    rmAddGroupingConstraint(villageAID, avoidTradeRouteSocketsShort);

    int villageBID = -1;   // NORTHERN VILLAGE
    nativeType = rmRandInt(1,3);
    villageType = rmRandInt(1,5);
    if (nativeType == 1)
       villageBID = rmCreateGrouping("village B", "Gayo_"+villageType);
    else 
       villageBID = rmCreateGrouping("village B", "Trumon_"+villageType);
    rmAddGroupingToClass(villageBID, rmClassID("importantItem"));
    rmSetGroupingMinDistance(villageBID, 0.0);
    rmSetGroupingMaxDistance(villageBID, 20.0);
    rmAddGroupingConstraint(villageBID, avoidImpassableLand);
    rmAddGroupingConstraint(villageBID, avoidWater8);
    rmAddGroupingConstraint(villageBID, avoidImportantItemFar);
    rmAddGroupingConstraint(villageBID, playerConstraintNative);
    rmAddGroupingConstraint(villageBID, avoidAll);
    rmAddGroupingConstraint(villageBID, medAvoidTradeRoute);
    rmAddGroupingConstraint(villageBID, avoidTradeRouteSocketsShort);
    
   if (nativeSetup == 1) 
   {
      if (cNumberNonGaiaPlayers == 2)
      {
         rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.77);
   	   if (castleSetup == 1)
            rmPlaceGroupingAtLoc(villageBID, 0, 0.5, 0.28); 
   	   else
            rmPlaceGroupingAtLoc(villageBID, 0, 0.5, 0.07); 
      }
	else
      {
         rmPlaceGroupingAtLoc(villageBID, 0, 0.22, 0.1); 
         rmPlaceGroupingAtLoc(villageAID, 0, 0.78, 0.1);
	   if (cNumberNonGaiaPlayers > 5)
            rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.785);
	   else 
            rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.77);
      }
   }
   else if (nativeSetup == 2) 
   {
	if (cNumberNonGaiaPlayers > 5)
         rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.785);
	else 
         rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.77);
      if(rmGetIsKOTH())
      {
	}
	else
	{
	  if (cNumberTeams == 2)
	  {
           if (rmRandInt(1,2) == 1)
	         rmPlaceGroupingAtLoc(villageBID, 0, 0.5, 0.51);
	     else
 	         rmPlaceGroupingAtLoc(villageAID, 0, 0.5, 0.51);
	  }
	}
      if (castleSetup == 1)
         rmPlaceGroupingAtLoc(villageBID, 0, 0.5, 0.28); 
   	else
         rmPlaceGroupingAtLoc(villageBID, 0, 0.5, 0.07); 
   }
  
// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.70);

// Player stuff 
//Prepare to place TCs
	int TCID = rmCreateObjectDef("player TC");
	if ( rmGetNomadStart())
		rmAddObjectDefItem(TCID, "coveredWagon", 1, 0);
	else
		rmAddObjectDefItem(TCID, "townCenter", 1, 0);
	rmSetObjectDefMinDistance(TCID, 0.0);
	rmSetObjectDefMaxDistance(TCID, 10.0); 
	rmAddObjectDefConstraint(TCID, avoidImpassableLand);
	rmAddObjectDefConstraint(TCID, avoidWater8);
    	
//Prepare to place Explorers, Explorer's dog, Explorer's Taun Taun, etc.
	int startingUnits = rmCreateStartingUnitsObjectDef(4.0);
	rmSetObjectDefMinDistance(startingUnits, 5.0);
	rmSetObjectDefMaxDistance(startingUnits, 8.0);
	rmAddObjectDefConstraint(startingUnits, avoidAll);
	rmAddObjectDefConstraint(startingUnits, avoidImpassableLand);

//Prepare to place player starting Mine
	int playerGoldID = rmCreateObjectDef("player silver");
	rmAddObjectDefItem(playerGoldID, "mine", 1, 0);
	rmSetObjectDefMinDistance(playerGoldID, 14.0);
	rmSetObjectDefMaxDistance(playerGoldID, 20.0);
	rmAddObjectDefConstraint(playerGoldID, avoidAll);
      rmAddObjectDefConstraint(playerGoldID, avoidImpassableLand);
      rmAddObjectDefConstraint(playerGoldID, avoidBerries);

//Dock Wagon
	int playerCrateID=rmCreateObjectDef("starting wagon");
	rmAddObjectDefItem(playerCrateID, "ypDockWagon", 1, 0.0);
	rmSetObjectDefMinDistance(playerCrateID, 9.0);
	rmSetObjectDefMaxDistance(playerCrateID, 12.0);
	rmAddObjectDefConstraint(playerCrateID, avoidAll);
	rmAddObjectDefConstraint(playerCrateID, shortAvoidImpassableLand);

//Prepare to place player starting Berries
	int playerBerriesID=rmCreateObjectDef("player berries");
	rmAddObjectDefItem(playerBerriesID, "berrybush", 5, 3.0);	
      rmSetObjectDefMinDistance(playerBerriesID, 13);
      rmSetObjectDefMaxDistance(playerBerriesID, 16);	
	rmAddObjectDefConstraint(playerBerriesID, avoidAll);
      rmAddObjectDefConstraint(playerBerriesID, shortAvoidImpassableLand);
  
//Prepare to place player starting pop block
	int playerPopBlock=rmCreateObjectDef("player pop block");
	rmAddObjectDefItem(playerPopBlock, "ypPopBlock", 1, 0.0);	
      rmSetObjectDefMinDistance(playerPopBlock, 7);
      rmSetObjectDefMaxDistance(playerPopBlock, 10);
	rmAddObjectDefConstraint(playerPopBlock, avoidAll);
      rmAddObjectDefConstraint(playerPopBlock, avoidImpassableLand);

//Prepare to place player starting huntables
	int playerTurkeyID=rmCreateObjectDef("player deer");
      rmAddObjectDefItem(playerTurkeyID, huntable1, 7, 6.0);	
      rmSetObjectDefMinDistance(playerTurkeyID, 15);
	rmSetObjectDefMaxDistance(playerTurkeyID, 20);	
	rmAddObjectDefConstraint(playerTurkeyID, avoidAll);
      rmAddObjectDefConstraint(playerTurkeyID, avoidImpassableLand);
      rmSetObjectDefCreateHerd(playerTurkeyID, false);

//Prepare to place player starting trees
	int StartAreaTreeID=rmCreateObjectDef("starting trees");
	rmAddObjectDefItem(StartAreaTreeID, startTreeType, 7, 5.0);
	rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
      rmAddObjectDefConstraint(StartAreaTreeID, avoidImpassableLand);
      rmAddObjectDefConstraint(StartAreaTreeID, avoidBerries);
	rmSetObjectDefMinDistance(StartAreaTreeID, 22.0);	
	rmSetObjectDefMaxDistance(StartAreaTreeID, 25.0);	

	int waterSpawnPointID = 0;
   
// Clear out constraints for good measure.
   rmClearClosestPointConstraints(); 
   
   for(i=1; <cNumberPlayers)
   {
      // Place TC and starting units
	rmPlaceObjectDefAtLoc(TCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	vector TCLoc = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, i));				
	rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
	rmPlaceObjectDefAtLoc(playerBerriesID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));  
      rmPlaceObjectDefAtLoc(playerGoldID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));   
	rmPlaceObjectDefAtLoc(playerTurkeyID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));  										
  //  rmPlaceObjectDefAtLoc(playerCrateID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
      rmPlaceObjectDefAtLoc(playerPopBlock, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
        
      // Place player starting trees
	rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
         
      if(ypIsAsian(i) && rmGetNomadStart() == false)
         rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i), i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
     
      // Place water spawn points for the players
	waterSpawnPointID=rmCreateObjectDef("colony ship "+i);
	rmAddObjectDefItem(waterSpawnPointID, "HomeCityWaterSpawnFlag", 1, 10.0);
	rmAddClosestPointConstraint(flagVsFlag);
	rmAddClosestPointConstraint(flagLand); 
      rmAddClosestPointConstraint(flagEdgeConstraint); 
	vector closestPoint = rmFindClosestPointVector(TCLoc, rmXFractionToMeters(1.0));
	rmPlaceObjectDefAtLoc(waterSpawnPointID, i, rmXMetersToFraction(xsVectorGetX(closestPoint)), rmZMetersToFraction(xsVectorGetZ(closestPoint)));
    
    // place some starter fishing boats at the spawn flag. We're that nice.
    int fishingBoatID1=rmCreateObjectDef("FishingBoat1"+i);
    int fishingBoatID2=rmCreateObjectDef("FishingBoat2"+i);
    
    if (rmGetPlayerCiv(i) ==  rmGetCivID("Japanese") || rmGetPlayerCiv(i) ==  rmGetCivID("Indians") || rmGetPlayerCiv(i) ==  rmGetCivID("Chinese")) 
    {
      rmAddObjectDefItem(fishingBoatID1, "ypFishingBoatAsian", 1, 10.0);
      rmAddObjectDefItem(fishingBoatID2, "ypFishingBoatAsian", 1, 10.0);
    }    
    else
    {
      rmAddObjectDefItem(fishingBoatID1, "FishingBoat", 1, 10.0);
      rmAddObjectDefItem(fishingBoatID2, "FishingBoat", 1, 10.0);
    }
    
    rmPlaceObjectDefAtLoc(fishingBoatID1, i, rmXMetersToFraction(xsVectorGetX(closestPoint)), rmZMetersToFraction(xsVectorGetZ(closestPoint)));
    rmPlaceObjectDefAtLoc(fishingBoatID2, i, rmXMetersToFraction(xsVectorGetX(closestPoint)), rmZMetersToFraction(xsVectorGetZ(closestPoint)));        
	
	
    // place unique buildings
    int sekulID=rmCreateObjectDef("SoldatSekul1"+i);
	
	
    if (rmGetPlayerCiv(i) ==  rmGetCivID("Germans")) 
    {
      rmAddObjectDefItem(sekulID, "SoldatSekul", 1, 10.0);
    }  
    else
    {
      rmAddObjectDefItem(sekulID, "STreeTeak", 1, 10.0);
    }
	
	rmPlaceObjectDefAtLoc(sekulID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
    
	
	
    // clear closest point for next iteration
    rmClearClosestPointConstraints();

   }
	
// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.80); 

// Cliffs
   int cliffHt = -1;
   int numCliffs=(cNumberNonGaiaPlayers + 4);
   int cliffVariety = rmRandInt(1,3);

   for (i=0; <numCliffs)
   {
      cliffVariety = rmRandInt(1,3);
	cliffHt = rmRandInt(5,7);    
	int bigCliffID=rmCreateArea("big cliff" +i);
	rmSetAreaWarnFailure(bigCliffID, false);
	rmSetAreaCliffType(bigCliffID, cliffType);
	rmAddAreaToClass(bigCliffID, rmClassID("classCliff"));
      rmSetAreaSize(bigCliffID, rmAreaTilesToFraction(400), rmAreaTilesToFraction(800));
	rmSetAreaCliffEdge(bigCliffID, 1, 0.65, 0.1, 1.0, 0);
	rmSetAreaCliffPainting(bigCliffID, false, true, true, 1.5, true);
	rmSetAreaCliffHeight(bigCliffID, cliffHt, 2.0, 1.0);
	rmSetAreaCoherence(bigCliffID, rmRandFloat(0.4, 0.9));
	rmSetAreaSmoothDistance(bigCliffID, 15);
	rmSetAreaHeightBlend(bigCliffID, 1.0);
	rmSetAreaMinBlobs(bigCliffID, 3);
	rmSetAreaMaxBlobs(bigCliffID, 7);
	rmSetAreaMinBlobDistance(bigCliffID, 5.0);
	rmSetAreaMaxBlobDistance(bigCliffID, 20.0);
	rmAddAreaConstraint(bigCliffID, avoidImportantItem);
      rmAddAreaConstraint(bigCliffID, playerConstraintFar);
      rmAddAreaConstraint(bigCliffID, avoidWater20);
	rmAddAreaConstraint(bigCliffID, medAvoidTradeRoute);
      rmAddAreaConstraint(bigCliffID, cliffsAvoidCliffs);
      rmAddAreaConstraint(bigCliffID, avoidTradeRouteSocketsShort);
	rmBuildArea(bigCliffID);
   } 

// Gold
   int goldID = rmCreateObjectDef("random silver");
   rmAddObjectDefItem(goldID, "mine", 1, 0);
   rmSetObjectDefMinDistance(goldID, 0.0);
   rmSetObjectDefMaxDistance(goldID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(goldID, playerConstraintFar);
   rmAddObjectDefConstraint(goldID, avoidAll);
   rmAddObjectDefConstraint(goldID, avoidCoin);
   rmAddObjectDefConstraint(goldID, avoidGold);
   rmAddObjectDefConstraint(goldID, avoidImpassableLand);
   rmAddObjectDefConstraint(goldID, avoidImportantItem);    
   rmPlaceObjectDefInArea(goldID, 0, bigIslandID, cNumberNonGaiaPlayers*2.5);

// Berries
   int berriesID=rmCreateObjectDef("random berries");
   rmAddObjectDefItem(berriesID, "berrybush", rmRandInt(4,6), 6.0);  
   rmSetObjectDefMinDistance(berriesID, 0.0);
   rmSetObjectDefMaxDistance(berriesID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(berriesID, playerConstraint);
   rmAddObjectDefConstraint(berriesID, avoidAll);
   rmAddObjectDefConstraint(berriesID, avoidRandomBerries);
   rmAddObjectDefConstraint(berriesID, avoidImpassableLand);
   rmAddObjectDefConstraint(berriesID, avoidImportantItem);    
   rmPlaceObjectDefInArea(berriesID, 0, bigIslandID, cNumberNonGaiaPlayers*2); 
  
// Forests
   numTries=12*cNumberNonGaiaPlayers;
   int failCount=0;
   int forestSize = rmRandInt(200,320);
   int patchSize = 0;

   for (i=0; <numTries)
   {   
    int forest=rmCreateArea("forest "+i);
    rmSetAreaWarnFailure(forest, false);
    rmSetAreaSize(forest, rmAreaTilesToFraction(forestSize), rmAreaTilesToFraction(forestSize));
    rmSetAreaForestType(forest, forestType);
    rmSetAreaForestDensity(forest, 0.9);
    rmSetAreaForestClumpiness(forest, 0.6);
    rmSetAreaForestUnderbrush(forest, 0.6);
    rmSetAreaCoherence(forest, 0.4);
    rmAddAreaToClass(forest, rmClassID("classForest")); 
    rmAddAreaConstraint(forest, forestConstraint);
    rmAddAreaConstraint(forest, avoidImportantItem); 
    rmAddAreaConstraint(forest, avoidWater4);
    rmAddAreaConstraint(forest, playerConstraint);
    rmAddAreaConstraint(forest, forestVsCoin);
    rmAddAreaConstraint(forest, avoidAll);
    
    if(rmBuildArea(forest)==false)
     {
        // Stop trying once we fail 5 times in a row.
        failCount++;
        if(failCount==5)
           break;
     }
     else
        failCount=0; 

	patchSize = forestSize+70;
      int coverForestPatchID = rmCreateArea(("forest cover"+i), rmAreaID("forest "+i));   
      rmSetAreaWarnFailure(coverForestPatchID, false);
      rmSetAreaSize(coverForestPatchID, rmAreaTilesToFraction(patchSize), rmAreaTilesToFraction(patchSize));
      rmSetAreaCoherence(coverForestPatchID, 0.99);
      rmSetAreaMix(coverForestPatchID, baseMix);
      rmBuildArea(coverForestPatchID);

	forestSize = rmRandInt(200,350);
   } 

// Huntables - near and far
   int turkeyID=rmCreateObjectDef("random deer");
   rmAddObjectDefItem(turkeyID, huntable1, rmRandInt(3,5), 5.0);
   rmAddObjectDefToClass(turkeyID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(turkeyID, 40.0);
   rmSetObjectDefMaxDistance(turkeyID, rmXFractionToMeters(0.3));
   rmAddObjectDefConstraint(turkeyID, playerConstraint);
   rmAddObjectDefConstraint(turkeyID, avoidRandomTurkeys);
   rmAddObjectDefConstraint(turkeyID, avoidImpassableLand);
   rmAddObjectDefConstraint(turkeyID, avoidImportantItem); 
   rmSetObjectDefCreateHerd(turkeyID, true);
   rmPlaceObjectDefPerPlayer(turkeyID, false, 1);

   int farPronghornID=rmCreateObjectDef("far pronghorn");
   rmAddObjectDefItem(farPronghornID, huntable2, rmRandInt(2,3), 4.0);
   rmAddObjectDefToClass(farPronghornID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farPronghornID, 42.0);
   rmSetObjectDefMaxDistance(farPronghornID, 65.0);
   rmAddObjectDefConstraint(farPronghornID, nuggetPlayerConstraint);
   rmAddObjectDefConstraint(farPronghornID, avoidImpassableLand);
   rmAddObjectDefConstraint(farPronghornID, avoidImportantItem);
   rmAddObjectDefConstraint(farPronghornID, huntableConstraint);
   rmAddObjectDefConstraint(farPronghornID, avoidAll);
   rmSetObjectDefCreateHerd(farPronghornID, true);
   rmPlaceObjectDefPerPlayer(farPronghornID, false, 1);

   rmSetObjectDefMinDistance(farPronghornID, 75.0);
   rmSetObjectDefMaxDistance(farPronghornID, 105.0);
   rmAddObjectDefConstraint(farPronghornID, playerConstraintFar);
   rmPlaceObjectDefPerPlayer(farPronghornID, false, 1);

 // --------------- Make load bar move. ----------------------------------------------------------------------------
	rmSetStatusText("",0.90);
  
// Nuggets
   if (mapTypePicker == 2)
	rmSetMapType(mapType1);
   else
	rmSetMapType(mapType2);
   int nugget1= rmCreateObjectDef("nugget easy"); 
   rmAddObjectDefItem(nugget1, "Nugget", 1, 0.0);
   rmSetObjectDefMinDistance(nugget1, 0.0);
   rmSetNuggetDifficulty(1, 2);
   rmSetObjectDefMaxDistance(nugget1, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(nugget1, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget1, avoidNugget);
   rmAddObjectDefConstraint(nugget1, playerConstraint);
   rmAddObjectDefConstraint(nugget1, avoidAll);
   rmAddObjectDefConstraint(nugget1, avoidImportantItem); 
   rmAddObjectDefConstraint(nugget1, avoidWater4);
   rmPlaceObjectDefInArea(nugget1, 0, bigIslandID, cNumberNonGaiaPlayers*2);

   rmSetNuggetDifficulty(3, 3);
   rmPlaceObjectDefInArea(nugget1, 0, bigIslandID, cNumberNonGaiaPlayers);
    
// sheep etc
      int sheepID=rmCreateObjectDef("herdable animal");
      rmAddObjectDefItem(sheepID, sheepType, 2, 4.0);
      rmSetObjectDefMinDistance(sheepID, 35.0);
      rmAddObjectDefToClass(sheepID, rmClassID("herdableFood"));
      rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.5));
      rmAddObjectDefConstraint(sheepID, avoidSheep);
      rmAddObjectDefConstraint(sheepID, avoidAll);
      rmAddObjectDefConstraint(sheepID, playerConstraint);
      rmAddObjectDefConstraint(sheepID, avoidImpassableLand);
      if (rmRandInt(1,2) == 1)
         rmPlaceObjectDefAtLoc(sheepID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);
      else 
         rmPlaceObjectDefAtLoc(sheepID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4); 

// Water nuggets
  rmSetMapType(mapType1);
  int nugget2= rmCreateObjectDef("nugget water"); 
  rmAddObjectDefItem(nugget2, "ypNuggetBoat", 1, 0.0);
  rmSetNuggetDifficulty(5, 5);
  rmSetObjectDefMinDistance(nugget2, rmXFractionToMeters(0.0));
  rmSetObjectDefMaxDistance(nugget2, rmXFractionToMeters(0.5));
  rmAddObjectDefConstraint(nugget2, avoidLand);
  rmAddObjectDefConstraint(nugget2, avoidNuggetFar);
  if (cNumberNonGaiaPlayers <4)
     rmPlaceObjectDefAtLoc(nugget2, 0, 0.5, 0.65, cNumberNonGaiaPlayers*4);
  else if (cNumberNonGaiaPlayers <7)
     rmPlaceObjectDefAtLoc(nugget2, 0, 0.5, 0.65, cNumberNonGaiaPlayers*3);
  else
     rmPlaceObjectDefAtLoc(nugget2, 0, 0.5, 0.65, cNumberNonGaiaPlayers*2);

// Random whales
	int whaleID=rmCreateObjectDef("whale");
	rmAddObjectDefItem(whaleID, whale1, 1, 0.0);
	rmAddObjectDefConstraint(whaleID, whaleVsWhaleID);
	rmAddObjectDefConstraint(whaleID, whaleLand);
      rmAddObjectDefConstraint(whaleID, whaleEdgeConstraint);
	rmSetObjectDefMinDistance(whaleID, 0.0);
	rmSetObjectDefMaxDistance(whaleID, rmXFractionToMeters(0.35)); 
	rmPlaceObjectDefAtLoc(whaleID, 0, 0.1, 0.53, cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(whaleID, 0, 0.9, 0.53, cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(whaleID, 0, 0.5, 0.95, cNumberNonGaiaPlayers*3);

// Place Random Fish everywhere, but restrained to avoid whales 

	int fishID=rmCreateObjectDef("fish 1");
	rmAddObjectDefItem(fishID, fish1, 1, 0.0);
	rmSetObjectDefMinDistance(fishID, 0.0);
	rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.35));
	rmAddObjectDefConstraint(fishID, fishVsFishID);
	rmAddObjectDefConstraint(fishID, fishVsWhaleID);
	rmAddObjectDefConstraint(fishID, fishLand);
	rmPlaceObjectDefAtLoc(fishID, 0, 0.1, 0.5, 4*cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(fishID, 0, 0.9, 0.5, 4*cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.95, 4*cNumberNonGaiaPlayers);

	int fish2ID=rmCreateObjectDef("fish 2");
	rmAddObjectDefItem(fish2ID, fish2, 1, 0.0);
	rmSetObjectDefMinDistance(fish2ID, 0.0);
	rmSetObjectDefMaxDistance(fish2ID, rmXFractionToMeters(0.45));
	rmAddObjectDefConstraint(fish2ID, fishVsFishTarponID);
	rmAddObjectDefConstraint(fish2ID, fishVsWhaleID);
	rmAddObjectDefConstraint(fish2ID, fishLand);
	rmPlaceObjectDefAtLoc(fish2ID, 0, 0.1, 0.5, 3*cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(fish2ID, 0, 0.9, 0.5, 3*cNumberNonGaiaPlayers);
	rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.9, 3*cNumberNonGaiaPlayers);

	if (cNumberNonGaiaPlayers <5)		// If less than 5 players, place extra fish.
	{
	      rmSetObjectDefMaxDistance(fish2ID, rmXFractionToMeters(0.65));
		rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.6, 3*cNumberNonGaiaPlayers);	
	}

  // Vary some terrain
  for (i=0; < 20) {
    int patch=rmCreateArea("first patch "+i);
    rmSetAreaWarnFailure(patch, false);
    rmSetAreaSize(patch, rmAreaTilesToFraction(100), rmAreaTilesToFraction(200));
    rmSetAreaMix(patch, baseMix);
    rmSetAreaTerrainType(patch, patchTerrain);
    rmAddAreaTerrainLayer(patch, patchType1, 0, 1);
    rmAddAreaToClass(patch, rmClassID("classPatch"));
    rmSetAreaCoherence(patch, 0.4);
    rmAddAreaConstraint(patch, shortAvoidImpassableLand);
    rmBuildArea(patch); 
  }
      
  for (i=0; <10) {
    int dirtPatch=rmCreateArea("paint patch "+i);
    rmSetAreaWarnFailure(dirtPatch, false);
    rmSetAreaSize(dirtPatch, rmAreaTilesToFraction(200), rmAreaTilesToFraction(300));
    rmSetAreaMix(dirtPatch, baseMix);
    rmSetAreaTerrainType(dirtPatch, patchTerrain);
    rmAddAreaTerrainLayer(dirtPatch, patchType2, 0, 1);
    rmAddAreaToClass(dirtPatch, rmClassID("classPatch"));
    rmSetAreaCoherence(dirtPatch, 0.4);
    rmAddAreaConstraint(dirtPatch, shortAvoidImpassableLand);
    rmAddAreaConstraint(dirtPatch, patchConstraint);
    rmBuildArea(dirtPatch); 
  }
  
// --------------- Make load bar move. ----------------------------------------------------------------------------
   rmSetStatusText("",0.99);  
}
