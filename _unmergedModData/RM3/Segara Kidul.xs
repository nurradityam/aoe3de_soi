/*================================================================================================================================================*/
// *********************************************** THESE ARE THE INFORMATIONS OF THE MAP: ******************************************************* //
/*================================================================================================================================================*/

// RIO NEGRO:
// BY DANY:
// JUNE 2010:
// Edited for SoI by Pepp, 22 May 2017

/*================================================================================================================================================*/
// ************************************************ MAIN ENTRY POINT FOR RANDOM MAP SCRIPT: ***************************************************** //
/*================================================================================================================================================*/

include "mercenaries.xs";
void main(void)
{

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.01);
/*================================================================================================================================================*/   
// ************************************************** CHOOSES WHICH NATIVES APPEAR ON THE MAP: ************************************************** //
/*================================================================================================================================================*/

        int subCiv0=-1;
        int subCiv1=-1;
        int subCiv2=-1;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	
	int whichNative=rmRandInt(1,3);
	
	if ( whichNative == 1)
	{
		subCiv0=rmGetCivID("Matraman");
		rmEchoInfo("subCiv0 is Matraman "+subCiv0);
		if (subCiv0 >= 0)
		rmSetSubCiv(0, "Matraman");

		subCiv1=rmGetCivID("Pesantren");
		rmEchoInfo("subCiv1 is Pesantren "+subCiv1);
		if (subCiv1 >= 0)
		rmSetSubCiv(1, "Pesantren");
			
		subCiv2=rmGetCivID("Pesantren");
		rmEchoInfo("subCiv2 is Pesantren "+subCiv2);
		if (subCiv2 >= 0)
		rmSetSubCiv(2, "Pesantren");	
	}
	else if ( whichNative == 2)
	{
		subCiv0=rmGetCivID("Kejawen");
		rmEchoInfo("subCiv0 is Kejawen "+subCiv0);
		if (subCiv0 >= 0)
		rmSetSubCiv(0, "Kejawen");

		subCiv1=rmGetCivID("Matraman");
		rmEchoInfo("subCiv1 is Matraman "+subCiv1);
		if (subCiv1 >= 0)
		rmSetSubCiv(1, "Matraman");
			
		subCiv2=rmGetCivID("Matraman");
		rmEchoInfo("subCiv2 is Matraman "+subCiv2);
		if (subCiv2 >= 0)
		rmSetSubCiv(2, "Matraman");	
	}
	else	
	{
		subCiv0=rmGetCivID("Pesantren");
		rmEchoInfo("subCiv0 is Pesantren "+subCiv0);
		if (subCiv0 >= 0)
		rmSetSubCiv(0, "Pesantren");

		subCiv1=rmGetCivID("Kejawen");
		rmEchoInfo("subCiv1 is Kejawen "+subCiv1);
		if (subCiv1 >= 0)
		rmSetSubCiv(1, "Kejawen");
			
		subCiv2=rmGetCivID("Matraman");
		rmEchoInfo("subCiv2 is Matraman "+subCiv2);
		if (subCiv2 >= 0)
		rmSetSubCiv(2, "Matraman");	
	}
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.05);
/*================================================================================================================================================*/   
// ******************************************************* PICKS THE MAP SIZE: ****************************************************************** //
/*================================================================================================================================================*/
	
	    int playerTiles=25000;

	    int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
	    rmEchoInfo("Map size="+size+"m x "+size+"m");
	    rmSetMapSize(632, 632); // THE NUMBER 632 IS REPLACING THE WORD - "size" -:
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.10);
/*================================================================================================================================================*/
// ***************************************************** DEFINE THE MAP PARAMETERS: ************************************************************* //
/*================================================================================================================================================*/

        // PICKS A DEFAULT WATER HEIGHT:
        rmSetSeaLevel(1.0);

        // PICKS DEFAULT TERRAIN AND WATER:
	    
		// SET MAP ELEVATION PARAMETERS:
		// rmSetMapElevationParameters(long type, float minFrequency, long numberOctaves, float persistence, float heightVariation)
	    rmSetMapElevationParameters(cElevTurbulence, 0.1, 4, 0.2, 3.0);
	    
		// SET SEA TYPE:
		rmSetSeaType("new england coast");
   
        // ENABLE LOCAL WATER:
		rmEnableLocalWater(false);
	    
		// SET BASE TERRAIN MIX:
		rmSetBaseTerrainMix("texas_grass");
        
		// TERRAIN INITIALIZATION:
		rmTerrainInitialize("texas\ground4_tex", 4.0);
	    
		// SET MAP TYPE:
		rmSetMapType("jawa");
	    rmSetMapType("water");
	    rmSetMapType("grass");
        
		// SET LIGHTING:
		rmSetLightingSet("patagonia");
	
	    // SET WORLD CIRCLE CONSTRAINT:
		rmSetWorldCircleConstraint(true);

	    // CHOOSE THE MERCS:
	    chooseMercs();
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.15);
/*================================================================================================================================================*/
// ************************************** DEFINE SOME CLASSES: THESE ARE USED LATER FOR CONSTRAINTS: ******************************************** //
/*================================================================================================================================================*/

    int classPlayer=rmDefineClass("player");
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.20);
/*================================================================================================================================================*/   
// ******************************************************* DEFINE THE CONSTRAINTS: ************************************************************** //
// **************************************** THESE ARE USED TO HAVE OBJECTS AND AREAS AVOID EACH OTHER: ****************************************** //
/*================================================================================================================================================*/
   
    // DEFINE THE MAP EDGE CONSTRAINTS:
    int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.485), rmDegreesToRadians(0), rmDegreesToRadians(360));
 
    // DEFINE THE PLAYER CONSTRAINTS:
    int playerConstraint=rmCreateClassDistanceConstraint("stuff vs players", classPlayer, 15.0);
	int playerCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs players", classPlayer, 10.0);
	int playerVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff vs players", classPlayer, 5.0);
	
	// DEFINE THE CARDINAL DIRECTIONS CONSTRAINTS (HANDY!)
    int Northward=rmCreatePieConstraint("northMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(315), rmDegreesToRadians(135));
    int Southward=rmCreatePieConstraint("southMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(135), rmDegreesToRadians(315));
    int Eastward=rmCreatePieConstraint("eastMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(45), rmDegreesToRadians(225));
    int Westward=rmCreatePieConstraint("westMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(225), rmDegreesToRadians(45));

	// DEFINE THE DECORATION AVOIDANCE:
    int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
	
	// DEFINE THE CONSTRAINTS TO AVOID WATER:
	int avoidWater2 = rmCreateTerrainDistanceConstraint("stuff vs water 2", "Land", false, 2.0);   //I added this one so I could experiment with it.
	int avoidWater5 = rmCreateTerrainDistanceConstraint("stuff vs water 5", "Land", false, 5.0);
	int avoidWater8 = rmCreateTerrainDistanceConstraint("stuff vs water 8", "Land", false, 8.0);
	int avoidWater10 = rmCreateTerrainDistanceConstraint("stuff vs water 10", "Land", false, 10.0);
	int avoidWater12 = rmCreateTerrainDistanceConstraint("stuff vs water 12", "Land", false, 12.0);
	int avoidWater15 = rmCreateTerrainDistanceConstraint("stuff vs water 15", "Land", false, 15.0);
	int avoidWater20 = rmCreateTerrainDistanceConstraint("stuff vs water 20", "Land", false, 20.0);
	
	// CIRCLE CONSTRAINT:
	int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.485), rmDegreesToRadians(0), rmDegreesToRadians(360));
	
 
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.25);
/*================================================================================================================================================*/   
// ********************************************************** CREATE THE TWO BAY AREAS: ********************************************************* //
/*================================================================================================================================================*/

    // DEFINE THE CLASS BAY:
	int ClassBay=rmDefineClass("bay");
	
	// DEFINE THE CLASS BAY CONSTRAINTS:
	int bayConstraint=rmCreateClassDistanceConstraint("stuff vs bay", rmClassID("bay"), 5.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	// THE BAY 1:
	int bay1ID=rmCreateArea("Bay 1");
    //rmSetAreaSize(bay1ID, 0.05, 0.05);
	rmSetAreaSize(bay1ID, 0.06, 0.06);
	//rmSetAreaLocation(bay1ID, 1.0, 0.45);
	rmSetAreaLocation(bay1ID, 0.0, 0.45);
	rmSetAreaWaterType(bay1ID, "hudson bay");
    rmSetAreaBaseHeight(bay1ID, 1.0); // Was 10
    rmSetAreaMinBlobs(bay1ID, 4);
    rmSetAreaMaxBlobs(bay1ID, 6);
    rmSetAreaMinBlobDistance(bay1ID, 5);
    rmSetAreaMaxBlobDistance(bay1ID, 30);
    rmSetAreaSmoothDistance(bay1ID, 50);
    rmSetAreaCoherence(bay1ID, 0.55);
    rmAddAreaToClass(bay1ID, rmClassID("bay"));
	rmSetAreaEdgeFilling(bay1ID, 5);
    rmSetAreaObeyWorldCircleConstraint(bay1ID, false);
	rmBuildArea(bay1ID);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

    // THE BAY 2:
	int bay2ID=rmCreateArea("Bay 2");
    //rmSetAreaSize(bay2ID, 0.05, 0.05);
	rmSetAreaSize(bay2ID, 0.06, 0.06);
	rmSetAreaLocation(bay2ID, 0.525, 0.0);
	rmSetAreaWaterType(bay2ID, "hudson bay");
    rmSetAreaBaseHeight(bay2ID, 1.0); // Was 10
    rmSetAreaMinBlobs(bay2ID, 4);
    rmSetAreaMaxBlobs(bay2ID, 6);
    rmSetAreaMinBlobDistance(bay2ID, 5);
    rmSetAreaMaxBlobDistance(bay2ID, 30);
    rmSetAreaSmoothDistance(bay2ID, 50);
    rmSetAreaCoherence(bay2ID, 0.355);
    rmAddAreaToClass(bay2ID, rmClassID("bay"));
	rmSetAreaEdgeFilling(bay2ID, 5);
    rmSetAreaObeyWorldCircleConstraint(bay2ID, false);
    rmBuildArea(bay2ID);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

    // THE BAY 3:
	int bay3ID=rmCreateArea("Bay 3");
    //rmSetAreaSize(bay3ID, 0.14, 0.14);
	rmSetAreaSize(bay3ID, 0.16, 0.16);
    //rmSetAreaLocation(bay3ID, 1.0, 0.0);
	rmSetAreaLocation(bay3ID, 0.0, 0.0);
	rmSetAreaWaterType(bay3ID, "hudson bay");
    rmSetAreaBaseHeight(bay3ID, 1.0); // Was 10
    rmSetAreaMinBlobs(bay3ID, 4);
    rmSetAreaMaxBlobs(bay3ID, 6);
    rmSetAreaMinBlobDistance(bay3ID, 5);
    rmSetAreaMaxBlobDistance(bay3ID, 30);
    rmSetAreaSmoothDistance(bay3ID, 50);
    rmSetAreaCoherence(bay3ID, 0.55);
    rmAddAreaToClass(bay3ID, rmClassID("bay"));
	rmSetAreaEdgeFilling(bay3ID, 5);
    rmSetAreaObeyWorldCircleConstraint(bay3ID, false);
    rmBuildArea(bay3ID);	
  
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.30);
/*================================================================================================================================================*/   
// **************************************************** DEFINE AND PLACE THE TRADE ROUTE: ******************************************************* //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
    
		// CREATE THE CLASS SOCKET:
		int classSocket = rmDefineClass("SocketClass");
		
	    // CREATE THE CLASS SOCKET CONSTRAINTS:
	    int avoidSocket=rmCreateClassDistanceConstraint("socket avoidance", rmClassID("SocketClass"), 8.0);
		
		// CREATE THE TRADE ROUTE CONSTRAINTS:
        int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 6.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE AND PLACE THE TRADE ROUTE NUMBER 1:
	    int tradeRouteID = rmCreateTradeRoute();
        int socketID=rmCreateObjectDef("sockets to dock Trade Posts North");
        rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
		
		rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
        rmSetObjectDefAllowOverlap(socketID, true);
        rmAddObjectDefToClass(socketID, rmClassID("SocketClass"));
        rmSetObjectDefMinDistance(socketID, 0.0);
        rmSetObjectDefMaxDistance(socketID, 8.0);
		
		rmAddTradeRouteWaypoint(tradeRouteID, 0.125, 0.785);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.250, 0.900);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.425, 0.950);
	    //rmAddTradeRouteWaypoint(tradeRouteID, 0.625, 0.950);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "java");
        if(placedTradeRoute == false)
        rmEchoError("Failed to place trade route");
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/  
	  
	    rmPlaceObjectDefAtLoc(socketID, 0, 0.125, 0.785);
        rmPlaceObjectDefAtLoc(socketID, 0, 0.250, 0.900);
        rmPlaceObjectDefAtLoc(socketID, 0, 0.425, 0.950);  		
		//rmPlaceObjectDefAtLoc(socketID, 0, 0.625, 0.950);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      
	    // DEFINE AND PLACE THE TRADE ROUTE NUMBER 2:
	    int tradeRoute2ID = rmCreateTradeRoute();
        socketID=rmCreateObjectDef("sockets to dock Trade Posts South");
        rmSetObjectDefTradeRouteID(socketID, tradeRoute2ID);
		
		rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
        rmSetObjectDefAllowOverlap(socketID, true);
        rmAddObjectDefToClass(socketID, rmClassID("SocketClass"));
        rmSetObjectDefMinDistance(socketID, 0.0);
        rmSetObjectDefMaxDistance(socketID, 8.0);
	
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.825, 0.175);
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.925, 0.300);
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.965, 0.500);
	    //rmAddTradeRouteWaypoint(tradeRoute2ID, 0.950, 0.65);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        placedTradeRoute = rmBuildTradeRoute(tradeRoute2ID, "java");
        if(placedTradeRoute == false)
        rmEchoError("Failed to place trade route"); 
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/  

        rmPlaceObjectDefAtLoc(socketID, 0, 0.825, 0.175);
		rmPlaceObjectDefAtLoc(socketID, 0, 0.925, 0.300);
		rmPlaceObjectDefAtLoc(socketID, 0, 0.965, 0.500);
		//rmPlaceObjectDefAtLoc(socketID, 0, 0.950, 0.65); 
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    // CLEAR OUT CONSTRAINTS FOR GOOD MEASURE:
        rmClearClosestPointConstraints();   //This was in the Caribbean script I started with.  Not sure what it does so afraid to axe it.			
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.35);
/*================================================================================================================================================*/   
// ************************************************* SET UP THE PLAYER STARTING LOCATIONS: ****************************************************** //
/*================================================================================================================================================*/
            
			float teamStartLoc = rmRandFloat(0.0, 1.0); 
			
/*------------------------------------------------------------------------------------------------------------------------------------------------*/			
			
			//TEAM 0 STARTS ON TOP:
			if (teamStartLoc > 0.5)
		{
			rmSetPlacementTeam(0);
			rmPlacePlayersLine(0.265, 0.715, 0.600, 0.865, 0.0, 0.0);  
			
			rmSetPlacementTeam(1);
			rmPlacePlayersLine(0.740, 0.300, 0.85, 0.65, 0.0, 0.0); 
		}
			else
			// TEAM 1 STARTS ON TOP:
		{
			rmSetPlacementTeam(0);
			rmPlacePlayersLine(0.740, 0.300, 0.85, 0.65, 0.0, 0.0); 
						
			rmSetPlacementTeam(1);
			rmPlacePlayersLine(0.265, 0.715, 0.600, 0.865, 0.0, 0.0); 
		}
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.40);
/*================================================================================================================================================*/   
// ******************************************************** SET UP THE PLAYER AREAS: ************************************************************ //
/*================================================================================================================================================*/

        float playerFraction=rmAreaTilesToFraction(2750);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
        for(i=1; <cNumberPlayers)
		
   {
        // CREATE THE AREA:.
        int id=rmCreateArea("Player"+i);
        
		// ASSIGN TO THE PLAYER:
        rmSetPlayerArea(i, id);
	    
		// ADD AREA CONSTRAINT:
		//rmAddAreaConstraint(i, avoidSocketPlayer);
		// rmAddAreaConstraint(id, playerConstraint); 
        // rmAddAreaConstraint(id, playerEdgeConstraint); 
        
		// SET THE SIZE:
        rmSetAreaSize(id, playerFraction, playerFraction);
        
		// ADD AREA TO CLASS:
		rmAddAreaToClass(id, classPlayer);
        
		// SET AREA MIN AND MAX BLOBS:
		rmSetAreaMinBlobs(id, 1);
        rmSetAreaMaxBlobs(id, 1);
        
        // SET AREA LOC PLAYER: 		
        rmSetAreaLocPlayer(id, i);
		
		// SET AREA COHERENCE:
		rmSetAreaCoherence(id, 0.7);
	rmSetAreaSmoothDistance(id, 0.7);
        
		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_grass");
		//rmSetAreaMix(id, "rockies_snow");
		rmSetAreaMix(id, "city_jawa");	
        
		// SET AREA WARN FAILURE:
		rmSetAreaWarnFailure(id, false);
   }

        // BUILD THE AREAS:
        rmBuildAllAreas();
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.425);
/*================================================================================================================================================*/

	    // CLEAR OUT CONSTRAINTS FOR GOOD MEASURE:
        rmClearClosestPointConstraints();   //This was in the Caribbean script I started with.  Not sure what it does so afraid to axe it.	
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.45);
/*================================================================================================================================================*/
// ********************************** DEFINE THE STARTING UNITS AND THE STARTING TCID AND STARTING RESOURCES: *********************************** //
/*================================================================================================================================================*/
	
	    // DEFINE THE CLASS STARTING UNITS:
        int classStartingUnit=rmDefineClass("startingUnit");
		
		// DEFINE THE CLASS STARTING UNITS CONSTRAINTS:
		int avoidStartingUnits=rmCreateClassDistanceConstraint("objects avoid starting units", rmClassID("startingUnit"), 30.0);
        int avoidStartingUnitsSmall=rmCreateClassDistanceConstraint("objects avoid starting units small", rmClassID("startingUnit"), 5.0);
        int avoidStartingUnitsLarge=rmCreateClassDistanceConstraint("objects avoid starting units large", rmClassID("startingUnit"), 50.0);
		
		// DEFINE THE START RESOURCE CONSTRAINT:
		int avoidStartResource=rmCreateTypeDistanceConstraint("start resource no overlap", "resource", 6.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		// DEFINE THE STARTING UNITS:
		int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
        rmSetObjectDefMinDistance(startingUnits, 5.0);
        rmSetObjectDefMaxDistance(startingUnits, 10.0);
	    rmAddObjectDefConstraint(startingUnits, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    // DEFINE THE STARTING TCID:
		int startingTCID= rmCreateObjectDef("startingTC");
		//rmAddObjectDefToClass(startingTCID, rmClassID("startingUnit"));
		
	    if ( rmGetNomadStart())
	{
		rmAddObjectDefItem(startingTCID, "CoveredWagon", 1, 0.0);
	}
	    else
	{
		rmAddObjectDefItem(startingTCID, "TownCenter", 1, 0.0);
		
		// GIVE IT A LITTLE WIGGLE ROOM FOR MAPS WITH GREATER THAN FOUR PLAYERS:
		if ( cNumberNonGaiaPlayers > 4 )
	  {
		rmSetObjectDefMinDistance(startingTCID, 0.0);
		rmSetObjectDefMaxDistance(startingTCID, 6.0);
	  }
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

	    // DEFINE THE START BERRYBUSH:
		int StartBerryBushID=rmCreateObjectDef("starting berry bush");
	    rmAddObjectDefItem(StartBerryBushID, "SPepaya", 5, 4.0);
	    rmSetObjectDefMinDistance(StartBerryBushID, 12.0);
	    rmSetObjectDefMaxDistance(StartBerryBushID, 16.0);
	    rmAddObjectDefConstraint(StartBerryBushID, avoidStartingUnitsSmall);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	
        // DEFINE THE PLAYER DEER HERDS:
		int avoidPlayerDeer=rmCreateTypeDistanceConstraint("deer herds vs deer herds", "deer", 25.0);
		
		// DEFINE THE PLAYER DEER HERDS:
		int playerDeerID=rmCreateObjectDef("player deer herds");
        rmAddObjectDefItem(playerDeerID, "deer", rmRandInt(2,4), 6.0);
        rmSetObjectDefMinDistance(playerDeerID, 29.0);
        rmSetObjectDefMaxDistance(playerDeerID, 32.0);
	    rmAddObjectDefConstraint(playerDeerID, avoidAll);
		rmAddObjectDefConstraint(playerDeerID, avoidPlayerDeer);
	    rmSetObjectDefCreateHerd(playerDeerID, true);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// DEFINE THE CLASS PLAYERNUGGETS:
		int classPlayerNuggets=rmDefineClass("playerNuggets");
		
		// DEFINE THE CLASS PLAYERNUGGETS CONSTRAINTS:
		int nuggetPlayerConstraint=rmCreateClassDistanceConstraint("stuff avoids playerNuggets", rmClassID("playerNuggets"), 35.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    // DEFINE THE PLAYER NUGGET: 
	    int playerNuggetID=rmCreateObjectDef("player nugget");
	    rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
	    rmAddObjectDefToClass(playerNuggetID, rmClassID("playerNuggets"));
        rmSetObjectDefMinDistance(playerNuggetID, 30.0);
        rmSetObjectDefMaxDistance(playerNuggetID, 35.0);
	    rmAddObjectDefConstraint(playerNuggetID, avoidAll);
	    rmAddObjectDefConstraint(playerNuggetID, nuggetPlayerConstraint);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE THE START AREA TREES:
		int avoidStartTrees=rmCreateTypeDistanceConstraint("start area trees vs trees", "STreeTeak", 20.0);
		
		// DEFINE THE START AREA TREES:
	    int StartAreaTreeID=rmCreateObjectDef("starting trees");
	    rmAddObjectDefItem(StartAreaTreeID, "STreeTeak", rmRandInt(7,9), 6.0);
	    rmSetObjectDefMinDistance(StartAreaTreeID, 20);
	    rmSetObjectDefMaxDistance(StartAreaTreeID, 25);
	    rmAddObjectDefConstraint(StartAreaTreeID, avoidStartResource);
	    rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
		rmAddObjectDefConstraint(StartAreaTreeID, avoidStartTrees);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		int StartMooseID=rmCreateObjectDef("starting moose");
	    rmAddObjectDefItem(StartMooseID, "moose", 4, 4.0);
	    rmSetObjectDefMinDistance(StartMooseID, 12);
	    rmSetObjectDefMaxDistance(StartMooseID, 15);
	    rmAddObjectDefConstraint(StartMooseID, avoidStartResource);
	    rmAddObjectDefConstraint(StartMooseID, avoidAll);
	    rmSetObjectDefCreateHerd(StartMooseID, true);		
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

        // DEFINE THE PLAYER GOLD CONSTRAINT:
	    int playerGoldConstraint=rmCreateTypeDistanceConstraint("playerGold vs playerGold", "minegold", 30.0);
	
	    // DEFINE THE PLAYER GOLD:
	    int playerGoldID=rmCreateObjectDef("player silver ore");
	    int silverType = rmRandInt(1,10);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // FLAG CONSTRAINTS FOR HC SPAWN POINT:
        int flagEdgeConstraint = rmCreatePieConstraint("flags away from edge of map", 0.5, 0.5, 0, rmGetMapXSize()-10, 0, 0, 0);
		//int flagEdgeConstraint = rmCreatePieConstraint("flags stay near edge of map", 0.5, 0.5, rmGetMapXSize()-20, rmGetMapXSize()-10, 0, 0, 0);
        //int flagEdgeConstraint = rmCreatePieConstraint("flags away from edge of map", 0.5, 0.5, rmGetMapXSize()-200, rmGetMapXSize()-100, 0, 0, 0);
        //int flagEdgeConstraint=rmCreatePieConstraint("flag edge of map", 0.5, 0.5, 0, rmZFractionToMeters(0.20), rmDegreesToRadians(0), rmDegreesToRadians(360));
  
		
	    int flagLand = rmCreateTerrainDistanceConstraint("flag vs land", "land", true, 15.0);
	    int flagVsFlag = rmCreateTypeDistanceConstraint("flag avoid same", "HomeCityWaterSpawnFlag", 15); 
 	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	    // DEFINE THE VARIABLE FOR THE WATER SPAWN POINT:
		int waterSpawnPointID = 0;

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.50);
/*================================================================================================================================================*/
// ********************************** PLACE THE STARTING UNITS AND THE STARTING TCID AND STARTING RESOURCES: ************************************ //
/*================================================================================================================================================*/
	    
		// CLEAR OUT CONSTRAINTS FOR GOOD MEASURE:
        rmClearClosestPointConstraints(); 

/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		for(i=1; <cNumberPlayers)
	{
	
		// PLACE THE STARTING TCID:
		//rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		vector TCLoc = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(startingTCID, i));			
		
		// PLACE THE STARTING UNITS:
		rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	
		// PLACE THE START BERRYBUSH:
		rmPlaceObjectDefAtLoc(StartBerryBushID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		// PLACE THE START AREA TREE:
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		// PLACE START RESOURCES:
		//rmPlaceObjectDefAtLoc(StartMooseID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// EVERYONE GETS TWO ORE GROUPINGS, ONE PRETTY CLOSE, THE OTHER A LITTLE FURTHER AWAY:
		
		// PLACE THE CLOSE PLAYER GOLD:
		silverType = rmRandInt(1,10);
		playerGoldID = rmCreateObjectDef("player silver closer "+i);
		rmAddObjectDefItem(playerGoldID, "SKapuk", 3, 0.0);
		//rmAddObjectDefConstraint(playerGoldID, avoidTradeRoute);
		rmAddObjectDefConstraint(playerGoldID, playerGoldConstraint);
		//rmAddObjectDefConstraint(playerGoldID, avoidCliffs);
		rmAddObjectDefConstraint(playerGoldID, avoidAll);
		rmSetObjectDefMinDistance(playerGoldID, 25.0);
		rmSetObjectDefMaxDistance(playerGoldID, 30.0);
		rmPlaceObjectDefAtLoc(playerGoldID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// PLACE THE FURTHER PLAYER GOLD:
		silverType = rmRandInt(1,10);
		playerGoldID = rmCreateObjectDef("player silver further "+i);
		rmAddObjectDefItem(playerGoldID, "SKapuk", 3, 0.0);
		//rmAddObjectDefConstraint(playerGoldID, avoidTradeRoute);
		rmAddObjectDefConstraint(playerGoldID, playerGoldConstraint);
		//rmAddObjectDefConstraint(playerGoldID, avoidCliffs);
		rmAddObjectDefConstraint(playerGoldID, avoidAll);
		rmSetObjectDefMinDistance(playerGoldID, 30.0);
		rmSetObjectDefMaxDistance(playerGoldID, 35.0);
		rmPlaceObjectDefAtLoc(playerGoldID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// EVERYONE GETS TWO DEER HERDS:
		rmPlaceObjectDefAtLoc(playerDeerID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(playerDeerID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// PLACE THE PLAYER NUGGETS:
		rmSetNuggetDifficulty(1, 1);
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// DEFINE THE VECTOR CLOSEST POINT:
		//vector closestPoint=rmGetUnitPosition(rmGetUnitPlacedOfPlayer(startingUnits, i));
		
		// PLACE THE WATER SPAWN POINTS FOR THE PLAYERS:
		waterSpawnPointID=rmCreateObjectDef("colony ship "+i);
		rmAddObjectDefItem(waterSpawnPointID, "HomeCityWaterSpawnFlag", 1, 0.0);
		
		rmAddClosestPointConstraint(flagVsFlag);
		rmAddClosestPointConstraint(flagLand); 
        rmAddClosestPointConstraint(flagEdgeConstraint); 
		
		
		vector closestPoint = rmFindClosestPointVector(TCLoc, rmXFractionToMeters(1.0));
		rmPlaceObjectDefAtLoc(waterSpawnPointID, i, rmXMetersToFraction(xsVectorGetX(closestPoint)), rmZMetersToFraction(xsVectorGetZ(closestPoint)));
        
   		// CLEAR CLOSEST POINT FOR NEXT ITERATION:
        rmClearClosestPointConstraints();

	}
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.55);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE NATIVES: ********************************************************* //
/*================================================================================================================================================*/
        
		// DEFINE THE CLASS NATIVES:
        int classNatives=rmDefineClass("natives");

        // DEFINE THE CLASS NATIVES CONSTRAINTS:
        int nativesConstraint=rmCreateClassDistanceConstraint("stuff vs natives", rmClassID("natives"), 25.0);			
	    int nativesCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs natives", rmClassID("natives"), 15.0);
        int nativesVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff vs natives", rmClassID("natives"), 8.0);			

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

		// THE NATIVES VILLAGE NUMBER 1:
		int nativesVillage1ID = -1;
		int	nativesVillageType = rmRandInt(1,4);
		
		if ( whichNative == 1 )
	{	
        nativesVillage1ID = rmCreateGrouping("natives city 1", "Matraman_"+nativesVillageType);
	}
        else if ( whichNative == 2 )
    {
        nativesVillage1ID = rmCreateGrouping("natives city 1", "Kejawen_"+nativesVillageType);	
	}	
	    else
    {
        nativesVillage1ID = rmCreateGrouping("natives city 1", "Pesantren_"+nativesVillageType);		
    }
	
        rmSetGroupingMinDistance(nativesVillage1ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage1ID, 0.0);
		rmAddGroupingToClass(nativesVillage1ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage1ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage1ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage1ID, 0, 0.775, 0.815);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
       
		// THE NATIVES VILLAGE NUMBER 2:
		int nativesVillage2ID = -1;
		nativesVillageType = rmRandInt(1,4);
		
		if ( whichNative == 1 )
	{	
        nativesVillage2ID = rmCreateGrouping("natives city 2", "Pesantren_"+nativesVillageType);
	}
        else if ( whichNative == 2 )
    {
        nativesVillage2ID = rmCreateGrouping("natives city 2", "Matraman_"+nativesVillageType);	
	}
        else
    {		
        nativesVillage2ID = rmCreateGrouping("natives city 2", "Kejawen_"+nativesVillageType);
	}	
        
		rmSetGroupingMinDistance(nativesVillage2ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage2ID, 0.0);
		rmAddGroupingToClass(nativesVillage2ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage2ID, 0, 0.325, 0.525);
       
/*------------------------------------------------------------------------------------------------------------------------------------------------*/    
    
		// THE NATIVES VILLAGE NUMBER 3:
		int nativesVillage3ID = -1;
		nativesVillageType = rmRandInt(1,5);
		
		if ( whichNative == 1 )
	{	
        nativesVillage3ID = rmCreateGrouping("natives city 3", "Pesantren_"+nativesVillageType);
	}
        else if ( whichNative == 2 )
    {
        nativesVillage3ID = rmCreateGrouping("natives city 3", "Matraman_"+nativesVillageType);	
	}	
        else
	{
	    nativesVillage3ID = rmCreateGrouping("natives city 3", "Matraman_"+nativesVillageType);
    }
	
        rmSetGroupingMinDistance(nativesVillage3ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage3ID, 0.0);
		rmAddGroupingToClass(nativesVillage3ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage3ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage3ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage3ID, 0, 0.525, 0.325);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.60);
/*================================================================================================================================================*/
// **************************************************** DEFINE AND PLACE THE CENTER CLIFF: ****************************************************** //
/*================================================================================================================================================*/
	
        // DEFINE THE CLASS CLIFF:
		int classCliff=rmDefineClass("classCliff");

        // DEFINE THE CLASS CLIFF CONSTRAINTS:
		int avoidCliffs=rmCreateClassDistanceConstraint("cliff vs. cliff", rmClassID("classCliff"), 30.0);
		int avoidCloseCliffs=rmCreateClassDistanceConstraint("close stuff vs. cliff", rmClassID("classCliff"), 15.0);
		int avoidVeryCloseCliffs=rmCreateClassDistanceConstraint("very close stuff vs. cliff", rmClassID("classCliff"), 8.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        int whichVariation=-1;
	    whichVariation = rmRandInt(1,2);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int cliffID=rmCreateArea("cliff"+i);
        
		//rmSetAreaSize(cliffID, rmAreaTilesToFraction(400), rmAreaTilesToFraction(400));
		
		if ( whichVariation == 1 )
	{	
		rmSetAreaSize(cliffID, 0.03, 0.03);
	}
        else
    {		
        rmSetAreaSize(cliffID, 0.01, 0.01);
	}	
		rmSetAreaWarnFailure(cliffID, false);
        rmSetAreaCliffType(cliffID, "Texas Grass");
        
		if ( whichVariation == 1 )
	{	
		rmSetAreaCliffEdge(cliffID, 2, 0.3, 0.1, 1.0, 0);
	}
        else
	{	
		rmSetAreaCliffEdge(cliffID, 1, 1.0, 0.1, 1.0, 0);
	}	
        rmSetAreaCliffPainting(cliffID, false, true, true, 1.5, true);
        //rmSetAreaCliffHeight(cliffID, 7, 2.0, 0.5);
		rmSetAreaCliffHeight(cliffID, rmRandInt(6, 8), 1.0, 1.0);  
        rmSetAreaHeightBlend(cliffID, 1);
        rmSetAreaObeyWorldCircleConstraint(cliffID, false);
        
		rmAddAreaToClass(cliffID, rmClassID("classCliff")); 
	    rmSetAreaMix(cliffID, "texas_dirt");
        rmAddAreaConstraint(cliffID, avoidCliffs);
        
		rmSetAreaMinBlobs(cliffID, 2);
        rmSetAreaMaxBlobs(cliffID, 3);
        rmSetAreaMinBlobDistance(cliffID, 5.0);
        rmSetAreaMaxBlobDistance(cliffID, 20.0);
        
		rmSetAreaSmoothDistance(cliffID, 5);
        rmSetAreaCoherence(cliffID, 0.775);		// higher = tries to make round
		
		rmSetAreaLocation(cliffID, 0.55, 0.60); 
        rmBuildArea(cliffID);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.65);
/*================================================================================================================================================*/
// *************************************************** DEFINE AND PLACE THE SCATTERED MINES: **************************************************** //
/*================================================================================================================================================*/

	    // DEFINE THE COIN CONSTRAINTS:
		int avoidFarCoin=rmCreateTypeDistanceConstraint("coin vs coin", "Gold", 65.0);
        int avoidCoin=rmCreateTypeDistanceConstraint("stuff vs coin", "Gold", 25.0);	
        int avoidCloseCoin=rmCreateTypeDistanceConstraint("close stuff vs coin", "Gold", 15.0);
        int avoidVeryCloseCoin=rmCreateTypeDistanceConstraint("very close stuff vs coin", "Gold", 8.0);	 		
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
		
		// THE RANDOM GOLD 1:
		int goldID = rmCreateObjectDef("random gold 1");
	    
		if ( whichVariation == 1 )
	{		
		rmAddObjectDefItem(goldID, "minegold", 1, 0);
	}
        else
    {	
        rmAddObjectDefItem(goldID, "mine", 1, 0);
    }
	
	    rmSetObjectDefMinDistance(goldID, 0.0);
	    rmSetObjectDefMaxDistance(goldID, rmXFractionToMeters(0.5));

		rmAddObjectDefConstraint(goldID, avoidWater5);
	    rmAddObjectDefConstraint(goldID, playerConstraint);
		rmAddObjectDefConstraint(goldID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(goldID, avoidFarCoin);
        rmAddObjectDefConstraint(goldID, nativesCloseConstraint);
		rmAddObjectDefConstraint(goldID, avoidCloseCliffs);
		rmAddObjectDefConstraint(goldID, avoidWater8);
		rmAddObjectDefConstraint(goldID, avoidTradeRoute);
		rmAddObjectDefConstraint(goldID, avoidSocket);
		rmAddObjectDefConstraint(goldID, Eastward);
	    
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(goldID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
		else
		rmPlaceObjectDefAtLoc(goldID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
		
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // THE RANDOM GOLD 2:
		int gold2ID = rmCreateObjectDef("random gold 2");
		
		if ( whichVariation == 1 )
	{		
		rmAddObjectDefItem(gold2ID, "minegold", 1, 0);
	}
        else
    {	
        rmAddObjectDefItem(gold2ID, "mine", 1, 0);
    }
	    
	    rmSetObjectDefMinDistance(gold2ID, 0.0);
	    rmSetObjectDefMaxDistance(gold2ID, rmXFractionToMeters(0.5));

		rmAddObjectDefConstraint(gold2ID, avoidWater5);
	    rmAddObjectDefConstraint(gold2ID, playerConstraint);
		rmAddObjectDefConstraint(gold2ID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(gold2ID, avoidFarCoin);
        rmAddObjectDefConstraint(gold2ID, nativesCloseConstraint);
		rmAddObjectDefConstraint(gold2ID, avoidCloseCliffs);
		rmAddObjectDefConstraint(gold2ID, avoidWater8);
		rmAddObjectDefConstraint(gold2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(gold2ID, avoidSocket);
		rmAddObjectDefConstraint(gold2ID, Westward);

        if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(gold2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
		else
		rmPlaceObjectDefAtLoc(gold2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);	
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.70);
/*================================================================================================================================================*/
// ************************************************* DEFINE AND PLACE THE SCATTERED FORESTS: **************************************************** //
/*================================================================================================================================================*/
	
        // DEFINE THE CLASS FOREST:
		int classForest=rmDefineClass("classForest");
		
		// DEFINE THE CLASS FOREST CONSTRAINTS:
		int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 35);
		int forestCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs. forest", rmClassID("classForest"), 15);
		int forestVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff vs. forest", rmClassID("classForest"), 8);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		int forestTreeID = 0;
        
		if (cNumberNonGaiaPlayers <=2)
		int numTries=6*cNumberNonGaiaPlayers; 
	    else
	    numTries=3*cNumberNonGaiaPlayers; 
		
        int failCount=0;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
        for (i=0; <numTries)
    {   
        int forestID=rmCreateArea("forest "+i);
        rmSetAreaWarnFailure(forestID, false);
		
		if ( whichVariation == 1 )
	{	
        rmSetAreaSize(forestID, rmAreaTilesToFraction(250), rmAreaTilesToFraction(250));
	}
        else
    {		
        rmSetAreaSize(forestID, rmAreaTilesToFraction(375), rmAreaTilesToFraction(375));
	}
	
		rmSetAreaForestType(forestID, "Jawa Lowland Forest");
        rmSetAreaForestDensity(forestID, 1.0);
        rmSetAreaForestClumpiness(forestID, 0.3);
        rmSetAreaForestUnderbrush(forestID, 0.5);
        rmSetAreaMinBlobs(forestID, 1);
        rmSetAreaMaxBlobs(forestID, 3);
        rmSetAreaMinBlobDistance(forestID, 1.0);
        rmSetAreaMaxBlobDistance(forestID, 3.0);
        rmSetAreaCoherence(forestID, 0.75);
        rmSetAreaSmoothDistance(forestID, 10);
        rmAddAreaToClass(forestID, rmClassID("classForest"));
       
		rmAddAreaConstraint(forestID, forestConstraint);
        rmAddAreaConstraint(forestID, avoidWater8);
		rmAddAreaConstraint(forestID, avoidCloseCoin);
		rmAddAreaConstraint(forestID, nativesCloseConstraint);
        rmAddAreaConstraint(forestID, avoidCloseCliffs); 
        rmAddAreaConstraint(forestID, avoidTradeRoute); 
        rmAddAreaConstraint(forestID, avoidSocket); 		
		rmAddAreaConstraint(forestID, playerCloseConstraint);
        rmAddAreaConstraint(forestID, playerEdgeConstraint); 		
		rmAddAreaConstraint(forestID, Eastward);
        
		if(rmBuildArea(forestID)==false)
      {
        // Stop trying once we fail 3 times in a row.
        failCount++;
        if(failCount==5)
        break;
      }
        else
        failCount=0; 
    } 
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
        for (i=0; <numTries)
    {   
        int forest2ID=rmCreateArea("forest 2"+i);
        rmSetAreaWarnFailure(forest2ID, false);
		
		if ( whichVariation == 1 )
	{	
        rmSetAreaSize(forest2ID, rmAreaTilesToFraction(250), rmAreaTilesToFraction(250));
	}
        else
	{
        rmSetAreaSize(forest2ID, rmAreaTilesToFraction(375), rmAreaTilesToFraction(375));
	}	
		
        rmSetAreaForestType(forest2ID, "Jawa Lowland Forest");
        rmSetAreaForestDensity(forest2ID, 1.0);
        rmSetAreaForestClumpiness(forest2ID, 0.0);
        rmSetAreaForestUnderbrush(forest2ID, 0.0);
        rmSetAreaMinBlobs(forest2ID, 1);
        rmSetAreaMaxBlobs(forest2ID, 3);
        rmSetAreaMinBlobDistance(forest2ID, 1.0);
        rmSetAreaMaxBlobDistance(forest2ID, 3.0);
        rmSetAreaCoherence(forest2ID, 0.75);
        rmSetAreaSmoothDistance(forest2ID, 10);
        rmAddAreaToClass(forest2ID, rmClassID("classForest")); 
        
		rmAddAreaConstraint(forest2ID, forestConstraint);
        rmAddAreaConstraint(forest2ID, avoidWater8);
		rmAddAreaConstraint(forest2ID, avoidCloseCoin);
		rmAddAreaConstraint(forest2ID, nativesCloseConstraint);
        rmAddAreaConstraint(forest2ID, avoidCloseCliffs); 
        rmAddAreaConstraint(forest2ID, avoidTradeRoute); 
        rmAddAreaConstraint(forest2ID, avoidSocket); 		
		rmAddAreaConstraint(forest2ID, playerCloseConstraint);
        rmAddAreaConstraint(forest2ID, playerEdgeConstraint); 		
		rmAddAreaConstraint(forest2ID, Westward);
        
		if(rmBuildArea(forest2ID)==false)
      {
        // Stop trying once we fail 3 times in a row.
        failCount++;
        if(failCount==5)
        break;
      }
        else
        failCount=0; 
    } 
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.75);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE NUGGETS: ********************************************************* //
/*================================================================================================================================================*/
    
	    // DEFINE THE NUGGET CONSTRAINTS:
	    int avoidFarNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "abstractNugget", 65.0);  
	    int avoidNugget=rmCreateTypeDistanceConstraint("stuff vs nugget", "abstractNugget", 25.0);  
	    int avoidCloseNugget=rmCreateTypeDistanceConstraint("close stuff vs nugget", "abstractNugget", 15.0);  
	    int avoidVeryCloseNugget=rmCreateTypeDistanceConstraint("very close stuff vs nugget", "abstractNugget", 8.0);  
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
		
		// THE EASTWARD NUGGETS:
		int nuggetID= rmCreateObjectDef("nugget 1"); 
	    rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
	    rmSetObjectDefMinDistance(nuggetID, 0.0);
	    rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(nuggetID, avoidFarNugget);
		rmAddObjectDefConstraint(nuggetID, avoidCloseCoin);
		rmAddObjectDefConstraint(nuggetID, forestCloseConstraint);
  	    rmAddObjectDefConstraint(nuggetID, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(nuggetID, playerCloseConstraint);
		rmAddObjectDefConstraint(nuggetID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(nuggetID, avoidTradeRoute);
	    rmAddObjectDefConstraint(nuggetID, avoidCloseCliffs);
	    rmAddObjectDefConstraint(nuggetID, avoidSocket);
	    rmAddObjectDefConstraint(nuggetID, avoidWater8);
	    rmAddObjectDefConstraint(nuggetID, Eastward);
	    
		int whichNugget=rmRandInt(0,1);
	
	    if ( whichNugget == 1)
	{	
		rmSetNuggetDifficulty(1, 3);
	}	
		else
	{	
		rmSetNuggetDifficulty(1, 4);
	}	
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
		else
		rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // THE WESTWARD NUGGETS:
		int nugget2ID= rmCreateObjectDef("nugget 2"); 
	    rmAddObjectDefItem(nugget2ID, "Nugget", 1, 0.0);
	    rmSetObjectDefMinDistance(nugget2ID, 0.0);
	    rmSetObjectDefMaxDistance(nugget2ID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(nugget2ID, avoidFarNugget);
		rmAddObjectDefConstraint(nugget2ID, avoidCloseCoin);
		rmAddObjectDefConstraint(nugget2ID, forestCloseConstraint);
  	    rmAddObjectDefConstraint(nugget2ID, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(nugget2ID, playerCloseConstraint);
		rmAddObjectDefConstraint(nugget2ID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(nugget2ID, avoidTradeRoute);
	    rmAddObjectDefConstraint(nugget2ID, avoidCloseCliffs);
	    rmAddObjectDefConstraint(nugget2ID, avoidSocket);
	    rmAddObjectDefConstraint(nugget2ID, avoidWater8);
	    rmAddObjectDefConstraint(nugget2ID, Westward);
	    
		if ( whichNugget == 1)
	{	
		rmSetNuggetDifficulty(1, 3);
	}	
		else
	{	
		rmSetNuggetDifficulty(1, 4);
	}	
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(nugget2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
		else
		rmPlaceObjectDefAtLoc(nugget2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.80);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE DEER HERDS: ****************************************************** //
/*================================================================================================================================================*/

    // DEFINE THE DEER HERDS CONSTRAINTS:
	int avoidFarDeer=rmCreateTypeDistanceConstraint("deer avoid deer", "deer", 65.0);  
	int avoidDeer=rmCreateTypeDistanceConstraint("stuff vs deer", "deer", 25.0);  
	int avoidCloseDeer=rmCreateTypeDistanceConstraint("close stuff vs deer", "deer", 15.0);  
	int avoidVeryCloseDeer=rmCreateTypeDistanceConstraint("very close stuff vs deer", "deer", 8.0);  
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	// THE EASWARD DEER HERDS:
	int huntableID=rmCreateObjectDef("The deer herds 1");
	rmAddObjectDefItem(huntableID, "deer", rmRandInt(3,5), 5.0);
    rmSetObjectDefMinDistance(huntableID, 0.0);
    rmSetObjectDefMaxDistance(huntableID, rmXFractionToMeters(0.5));
   
	rmAddObjectDefConstraint(huntableID, avoidFarDeer);
    rmAddObjectDefConstraint(huntableID, avoidCloseNugget);
	rmAddObjectDefConstraint(huntableID, avoidCloseCoin);
    rmAddObjectDefConstraint(huntableID, forestCloseConstraint);
	rmAddObjectDefConstraint(huntableID, Eastward);
	rmAddObjectDefConstraint(huntableID, avoidWater8);
	rmAddObjectDefConstraint(huntableID, avoidSocket);
	rmAddObjectDefConstraint(huntableID, avoidTradeRoute);
	rmAddObjectDefConstraint(huntableID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(huntableID, playerCloseConstraint);
	rmAddObjectDefConstraint(huntableID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(huntableID, avoidCloseCliffs);
    
	rmSetObjectDefCreateHerd(huntableID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(huntableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	else
	rmPlaceObjectDefAtLoc(huntableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
	// THE WESTWARD DEER HERDS:
	int huntable2ID=rmCreateObjectDef("The deer herds 2");
	rmAddObjectDefItem(huntable2ID, "deer", rmRandInt(3,5), 5.0);
    rmSetObjectDefMinDistance(huntable2ID, 0.0);
    rmSetObjectDefMaxDistance(huntable2ID, rmXFractionToMeters(0.5));
   
	rmAddObjectDefConstraint(huntable2ID, avoidFarDeer);
    rmAddObjectDefConstraint(huntable2ID, avoidCloseNugget);
	rmAddObjectDefConstraint(huntable2ID, avoidCloseCoin);
    rmAddObjectDefConstraint(huntable2ID, forestCloseConstraint);
	rmAddObjectDefConstraint(huntable2ID, Westward);
	rmAddObjectDefConstraint(huntable2ID, avoidWater8);
	rmAddObjectDefConstraint(huntable2ID, avoidSocket);
	rmAddObjectDefConstraint(huntable2ID, avoidTradeRoute);
	rmAddObjectDefConstraint(huntable2ID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(huntable2ID, playerCloseConstraint);
	rmAddObjectDefConstraint(huntable2ID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(huntable2ID, avoidCloseCliffs);
    
	rmSetObjectDefCreateHerd(huntableID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(huntable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	else
	rmPlaceObjectDefAtLoc(huntable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.825);
/*================================================================================================================================================*/   
// ***************************************************** DEFINE AND PLACE THE RHEA HERDS: ******************************************************* //
/*================================================================================================================================================*/

	// DEFINE THE RHEA HERDS CONSTRAINTS:
	int avoidFarRhea=rmCreateTypeDistanceConstraint("rhea avoid rhea", "Pronghorn", 65.0);  
	int avoidRhea=rmCreateTypeDistanceConstraint("stuff vs rhea", "Pronghorn", 25.0);  
	int avoidCloseRhea=rmCreateTypeDistanceConstraint("close stuff vs rhea", "Pronghorn", 15.0);  
	int avoidVeryCloseRhea=rmCreateTypeDistanceConstraint("very close stuff vs rhea", "Pronghorn", 8.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

    int avoidFarBerries=rmCreateTypeDistanceConstraint("berries avoid berries", "AbstractFruit", 65.0);  
	int avoidBerries=rmCreateTypeDistanceConstraint("stuff vs berries", "AbstractFruit", 25.0);  
	int avoidCloseBerries=rmCreateTypeDistanceConstraint("close stuff vs berries", "AbstractFruit", 15.0);  
	int avoidVeryCloseBerries=rmCreateTypeDistanceConstraint("very close stuff vs berries", "AbstractFruit", 8.0); 	
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
	// THE EASTWARD RHEA HERDS:
	int huntable3ID=rmCreateObjectDef("rhea flock 1");
	
	if ( whichVariation == 1 )
{	
    rmAddObjectDefItem(huntable3ID, "Pronghorn", rmRandInt(3,5), 7.0);
} 
    else
{	
    rmAddObjectDefItem(huntable3ID, "SKepel", rmRandInt(2,3), 7.0);
}	
	
	rmSetObjectDefMinDistance(huntable3ID, 0.0);
    rmSetObjectDefMaxDistance(huntable3ID, rmXFractionToMeters(0.5));
	
	rmAddObjectDefConstraint(huntable3ID, avoidFarRhea);
	rmAddObjectDefConstraint(huntable3ID, avoidFarBerries);
	rmAddObjectDefConstraint(huntable3ID, avoidDeer);
    rmAddObjectDefConstraint(huntable3ID, avoidCloseNugget);
    rmAddObjectDefConstraint(huntable3ID, forestCloseConstraint);
	rmAddObjectDefConstraint(huntable3ID, avoidTradeRoute);
	rmAddObjectDefConstraint(huntable3ID, avoidSocket);
	rmAddObjectDefConstraint(huntable3ID, Eastward);
	rmAddObjectDefConstraint(huntable3ID, avoidCloseCoin);
	rmAddObjectDefConstraint(huntable3ID, avoidWater8);
	rmAddObjectDefConstraint(huntable3ID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(huntable3ID, playerCloseConstraint);
	rmAddObjectDefConstraint(huntable3ID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(huntable3ID, avoidCloseCliffs);
    
	rmSetObjectDefCreateHerd(huntable3ID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(huntable3ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	else
	rmPlaceObjectDefAtLoc(huntable3ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

    // THE WESTWARD RHEA HERDS:
	int huntable4ID=rmCreateObjectDef("rhea flock 2");
	
	if ( whichVariation == 1 )
{	
    rmAddObjectDefItem(huntable4ID, "Pronghorn", rmRandInt(3,5), 7.0);
} 
    else
{	
    rmAddObjectDefItem(huntable4ID, "SKepel", rmRandInt(2,3), 7.0);
}	
    rmSetObjectDefMinDistance(huntable4ID, 0.0);
    rmSetObjectDefMaxDistance(huntable4ID, rmXFractionToMeters(0.5));
	
	rmAddObjectDefConstraint(huntable4ID, avoidFarRhea);
	rmAddObjectDefConstraint(huntable4ID, avoidFarBerries);
	rmAddObjectDefConstraint(huntable4ID, avoidDeer);
    rmAddObjectDefConstraint(huntable4ID, avoidCloseNugget);
    rmAddObjectDefConstraint(huntable4ID, forestCloseConstraint);
	rmAddObjectDefConstraint(huntable4ID, avoidTradeRoute);
	rmAddObjectDefConstraint(huntable4ID, avoidSocket);
	rmAddObjectDefConstraint(huntable4ID, Westward);
	rmAddObjectDefConstraint(huntable4ID, avoidCloseCoin);
	rmAddObjectDefConstraint(huntable4ID, avoidWater8);
	rmAddObjectDefConstraint(huntable4ID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(huntable4ID, playerCloseConstraint);
	rmAddObjectDefConstraint(huntable4ID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(huntable4ID, avoidCloseCliffs);
    
	rmSetObjectDefCreateHerd(huntable4ID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(huntable4ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	else
	rmPlaceObjectDefAtLoc(huntable4ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.85);
/*================================================================================================================================================*/   
// *************************************************** DEFINE AND PLACE THE SHEEP HERDS: ******************************************************** //
/*================================================================================================================================================*/

	// DEFINE THE RHEA HERDS CONSTRAINTS:
	int avoidFarSheep=rmCreateTypeDistanceConstraint("sheep avoid sheep", "ypGoat", 80.0);  
	int avoidSheep=rmCreateTypeDistanceConstraint("stuff vs sheep", "ypGoat", 40.0);  
	int avoidCloseSheep=rmCreateTypeDistanceConstraint("close stuff vs sheep", "ypGoat", 25.0);  
	int avoidVeryCloseSheep=rmCreateTypeDistanceConstraint("very close stuff vs sheep", "ypGoat", 10.0); 
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	// THE EASTWARD SHEEP HERDS:
	int herdableID=rmCreateObjectDef("sheep herds 1");
	rmAddObjectDefItem(herdableID, "ypGoat", 2, 2.0);
	rmSetObjectDefMinDistance(herdableID, 0.0);
	rmSetObjectDefMaxDistance(herdableID, rmXFractionToMeters(0.5));
	
	rmAddObjectDefConstraint(herdableID, avoidFarSheep);
	rmAddObjectDefConstraint(herdableID, avoidRhea);
    rmAddObjectDefConstraint(herdableID, avoidDeer);
    rmAddObjectDefConstraint(herdableID, forestCloseConstraint);
	rmAddObjectDefConstraint(herdableID, Eastward);
	rmAddObjectDefConstraint(herdableID, avoidCloseNugget);
    rmAddObjectDefConstraint(herdableID, avoidTradeRoute);
	rmAddObjectDefConstraint(herdableID, avoidSocket);
	rmAddObjectDefConstraint(herdableID, avoidCloseCoin);
	rmAddObjectDefConstraint(herdableID, avoidWater8);
	rmAddObjectDefConstraint(herdableID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(herdableID, playerCloseConstraint);
	rmAddObjectDefConstraint(herdableID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(herdableID, avoidCloseCliffs);
	
	rmSetObjectDefCreateHerd(herdableID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(herdableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	else
	rmPlaceObjectDefAtLoc(herdableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	    
	// THE WESTWARD SHEEP HERDS:
	int herdable2ID=rmCreateObjectDef("sheep herds 2");
	rmAddObjectDefItem(herdable2ID, "ypGoat", 2, 2.0);
	rmSetObjectDefMinDistance(herdable2ID, 0.0);
	rmSetObjectDefMaxDistance(herdable2ID, rmXFractionToMeters(0.5));
	
	rmAddObjectDefConstraint(herdable2ID, avoidFarSheep);
	rmAddObjectDefConstraint(herdable2ID, avoidRhea);
    rmAddObjectDefConstraint(herdable2ID, avoidDeer);
    rmAddObjectDefConstraint(herdable2ID, forestCloseConstraint);
	rmAddObjectDefConstraint(herdable2ID, Westward);
	rmAddObjectDefConstraint(herdable2ID, avoidCloseNugget);
    rmAddObjectDefConstraint(herdable2ID, avoidTradeRoute);
	rmAddObjectDefConstraint(herdable2ID, avoidSocket);
	rmAddObjectDefConstraint(herdable2ID, avoidCloseCoin);
	rmAddObjectDefConstraint(herdable2ID, avoidWater8);
	rmAddObjectDefConstraint(herdable2ID, nativesCloseConstraint);
  	rmAddObjectDefConstraint(herdable2ID, playerCloseConstraint);
	rmAddObjectDefConstraint(herdable2ID, playerEdgeConstraint);
  	rmAddObjectDefConstraint(herdable2ID, avoidCloseCliffs);
	
	rmSetObjectDefCreateHerd(herdable2ID, true);
	if (cNumberNonGaiaPlayers <=2)
	rmPlaceObjectDefAtLoc(herdable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	else
	rmPlaceObjectDefAtLoc(herdable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.90);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE RANDOM TREES: **************************************************** //
/*================================================================================================================================================*/
        
        // DEFINE THE DEER HERDS CONSTRAINTS:
		int avoidRandomTree=rmCreateTypeDistanceConstraint("trees vs trees", "STreeAngsana", 6.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE RANDOM TREE 1:
		int randomTreeID=rmCreateObjectDef("random tree 1");
        rmAddObjectDefItem(randomTreeID, "STreeAngsana", 1, 0.0);
        rmSetObjectDefMinDistance(randomTreeID, 0.0);
        rmSetObjectDefMaxDistance(randomTreeID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseSheep);
	    rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseRhea);
        rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseDeer);
        rmAddObjectDefConstraint(randomTreeID, avoidTradeRoute);
	    rmAddObjectDefConstraint(randomTreeID, avoidSocket);
	    rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseCliffs);
		rmAddObjectDefConstraint(randomTreeID, playerVeryCloseConstraint);
		rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseNugget);
  	    rmAddObjectDefConstraint(randomTreeID, nativesVeryCloseConstraint);
  	    rmAddObjectDefConstraint(randomTreeID, avoidVeryCloseCoin);
  	    rmAddObjectDefConstraint(randomTreeID, avoidWater5);
	    rmAddObjectDefConstraint(randomTreeID, forestVeryCloseConstraint);
	    rmAddObjectDefConstraint(randomTreeID, playerEdgeConstraint);
		rmAddObjectDefConstraint(randomTreeID, avoidRandomTree); 
        
	    if ( whichVariation == 1 )
	{	
		if (cNumberNonGaiaPlayers <=2)
	    rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*15.0);
	    else	
	    rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*7.0);
	}
        else
    {
        if (cNumberNonGaiaPlayers <=2)
	    rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*20.0);
	    else	
	    rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*10.0);
    }	
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.95);
/*================================================================================================================================================*/
// ******************************************************* DEFINE AND PLACE THE FISHES: ********************************************************* //
/*================================================================================================================================================*/

        // DEFINE THE SEA FOOD-FISH CONSTRAINTS:
		int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", "ypFishCatfish", 15.0);
        int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 8.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

		// DEFINE AND PLACE THE FISH SALMON:
		int fishID=rmCreateObjectDef("fish Mahi");
        rmAddObjectDefItem(fishID, "ypFishCatfish", 3, 9.0);
        rmSetObjectDefMinDistance(fishID, 0.0);
        rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(fishID, fishVsFishID);
        rmAddObjectDefConstraint(fishID, fishLand);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 30*cNumberNonGaiaPlayers);
        else
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 15*cNumberNonGaiaPlayers);
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.975);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE WHALE: *********************************************************** //
/*================================================================================================================================================*/

        // DEFINE THE SEA MONEY-WHALES CONSTRAINTS:
		int whaleVsWhaleID=rmCreateTypeDistanceConstraint("whale v whale", "AbstractWhale", 50.0);
        int whaleLand = rmCreateTerrainDistanceConstraint("whale land", "land", true, 25.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int whaleID=rmCreateObjectDef("whale");
        rmAddObjectDefItem(whaleID, "HumpbackWhale", 1, 0.0);
        rmSetObjectDefMinDistance(whaleID, 0.0);
        rmSetObjectDefMaxDistance(whaleID, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(whaleID, whaleVsWhaleID);
        rmAddObjectDefConstraint(whaleID, whaleLand);
		rmAddObjectDefConstraint(whaleID, Southward);
		
		if (cNumberNonGaiaPlayers <=2)
        rmPlaceObjectDefAtLoc(whaleID, 0, 0.5, 0.5, 6*cNumberNonGaiaPlayers);
		else
		rmPlaceObjectDefAtLoc(whaleID, 0, 0.5, 0.5, 3*cNumberNonGaiaPlayers);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",1.00);
/*================================================================================================================================================*/
}
/*================================================================================================================================================*/
// ******************************************************** THIS IS THE END OF THE MAP: ********************************************************* //
/*================================================================================================================================================*/
