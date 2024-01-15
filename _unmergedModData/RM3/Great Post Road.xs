/*================================================================================================================================================*/
// ************************************************* THESE ARE THE INFORMATIONS OF THE MAP: ***************************************************** //
/*================================================================================================================================================*/

// THE MONGOLIAN WAR::
// CREATED BY DANY:
// MAY 2008:
// Modified by Mahidevran/Pepp as Great Post Road 19/04/2019

/*================================================================================================================================================*/
// ************************************************** MAIN ENTRY POINT FOR RANDOM MAP SCRIPT: *************************************************** //
/*================================================================================================================================================*/

include "mercenaries.xs";
include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";

void main(void)
{
   
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.01);
/*================================================================================================================================================*/
/*  
        // DESERT/PLAINS - MONGOLIA:

        nativeCiv1 = "sufi";
        nativeCiv2 = "shaolin";
        nativeString1 = "native sufi mosque mongol ";
        nativeString2 = "native shaolin temple mongol 0";
        
		baseMix1 = "mongolia_grass";
		baseMix2 = "mongolia_grass_b";
		baseMix3 = "mongolia_forest";
		baseMix4 = "mongolia_desert";
		
		baseTerrain0 = "Mongolia\ground_forest_mongol";
		
        baseTerrain1 = "Mongolia\ground_grass1_mongol";
		baseTerrain2 = "Mongolia\ground_grass2_mongol";
		baseTerrain3 = "Mongolia\ground_grass3_mongol";
		baseTerrain4 = "Mongolia\ground_grass4_mongol";
		baseTerrain5 = "Mongolia\ground_grass5_mongol";
		baseTerrain6 = "Mongolia\ground_grass6_mongol";
		
		baseTerrain6 = "Mongolia\ground_sand1_mongol";
		baseTerrain6 = "Mongolia\ground_sand2_mongol";
		baseTerrain6 = "Mongolia\ground_sand3_mongol";
        
		forestType1 = "Mongolian Forest";
		forestType2 = "Mongolian Fir Forest";
        
		startTreeType = "ypTreeSaxaul";
		startTreeType2 = "ypTreeMongolia";
		startTreeType3 = "ypTreeMongolianFir";
        
		patchTerrain = "Mongolia\ground_grass4_mongol";
        patchType1 = "Mongolia\ground_grass5_mongol";
        patchType2 = "Mongolia\ground_grass2_mongol";
        
		mapType1 = "silkRoad2";
		mapType2 = "grass";
        
		herdableType = "ypYak";
        
		huntable1 = "ypSaiga";
        huntable2 = "ypMuskDeer";    
        
		lightingType = "mongolia";
        
		tradeRouteType = "water";
        guardianType = "ypWokou";
*/
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.05);
/*================================================================================================================================================*/
// *********************************************** DEFINE WHICH NATIVES WILL APPEAR ON THE MAP: ************************************************* //
/*================================================================================================================================================*/

        int subCiv0=-1;								
        int subCiv1=-1;								
        int subCiv2=-1;
        int subCiv3=-1;
        int subCiv4=-1;
        int subCiv5=-1;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        if (rmAllocateSubCivs(6) == true)
		
    {
	
			//this is a mixed range and melee map
			if(rmRandFloat(0,1) > 0.50) 
			{ //Pesisiran or Cirebon
				string rangedCiv = "Pesisiran"; //tupi
				string meleeCiv = "Pesantren"; //zapotec
			}
			else
			{
				rangedCiv = "Cirebon"; //caribs
				meleeCiv = "Sunda"; //Maya
			}
		//	if(rmRandFloat(0,1) > 0.50)
		//	{ //Pesantren or Sunda 
		//		string meleeCiv = "Pesantren"; //zapotec
		//	}
		//	else
		//	{
		//		meleeCiv = "Sunda"; //Maya
		//	}
	
        subCiv0=rmGetCivID(rangedCiv);					
        rmEchoInfo("subCiv0 is "+subCiv0);
        if (subCiv0 >= 0)
        rmSetSubCiv(0, rangedCiv);

        subCiv1=rmGetCivID(meleeCiv);
        rmEchoInfo("subCiv1 is "+subCiv1);
        if (subCiv1 >= 0)
        rmSetSubCiv(1, meleeCiv);
	 
        subCiv2=rmGetCivID(rangedCiv);
        rmEchoInfo("subCiv2 is "+subCiv2);
        if (subCiv2 >= 0)
        rmSetSubCiv(2, rangedCiv);

        subCiv3=rmGetCivID(meleeCiv);					
        rmEchoInfo("subCiv3 is "+subCiv3);
        if (subCiv3 >= 0)
        rmSetSubCiv(3, meleeCiv);

        subCiv4=rmGetCivID(rangedCiv);
        rmEchoInfo("subCiv4 is "+subCiv4);
        if (subCiv4 >= 0)
        rmSetSubCiv(4, rangedCiv);

        subCiv5=rmGetCivID(meleeCiv);
        rmEchoInfo("subCiv5 is "+subCiv5);
        if (subCiv5 >= 0)
        rmSetSubCiv(5, meleeCiv);
    }
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.10);
/*================================================================================================================================================*/
// ********************************************************* PICKS THE MAP SIZE: **************************************************************** //
/*================================================================================================================================================*/  

	    int playerTiles = 30000;

	    int size=1.5*sqrt(cNumberNonGaiaPlayers*playerTiles);
	    rmEchoInfo("Map size="+size+"m x "+size+"m");
	    rmSetMapSize(size, size); // THE NUMBER 800 IS REPLACING THE WORD: - "size" -
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.15);
/*================================================================================================================================================*/
// ******************************************************* DEFINE THE MAP PARAMETERS: *********************************************************** //	
/*================================================================================================================================================*/

        // SET MAP ELEVATION PARAMETERS:
		rmSetMapElevationParameters(cElevTurbulence, 0.05, 10, 0.4, 7.0);
		//rmSetMapElevationParameters(cElevTurbulence, 0.06, 1, 0.4, 3.0);
	    
		// SET MAP ELEVATION HEIGHT BLEND:
		rmSetMapElevationHeightBlend(1);
	
	    // SET SEA LEVEL:
		rmSetSeaLevel(3.0);
		
		// SET SEA TYPE:
		rmSetSeaType("atlantic coast");
		
		// ENABLE LOCAL WATER:
		rmEnableLocalWater(false);
	    
	    // SET BASE TERRAIN MIX:
		rmSetBaseTerrainMix("texas_grass");
	    
		// TERRAIN INITIALIZE:
		rmTerrainInitialize("texas\ground4_tex", 2.0);
		
		// SET LIGHTING:
		rmSetLightingSet("mongolia");
	    
		// SET MAP TYPE:
		rmSetMapType("greatpostroad");
	    rmSetMapType("water");
	    rmSetMapType("grass");
	    
		// SET WORLD CIRCLE CONSTRAINT:
		rmSetWorldCircleConstraint(true);
	    
		// SET WIND MAGNITUDE:
		rmSetWindMagnitude(2.0);

	    // CHOOSE MERCS:
		chooseMercs();
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.20);
/*================================================================================================================================================*/
// *************************************** DEFINE SOME CLASSES: THESE ARE USED LATER FOR CONSTRAINTS: ******************************************* //
/*================================================================================================================================================*/

	    int classPlayer=rmDefineClass("player");
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.25);
/*================================================================================================================================================*/
// ********************************************************* DEFINE SOME CONSTRAINTS: *********************************************************** //
// ***************************************** THESE ARE USED TO HAVE OBJECTS AND AREAS AVOID EACH OTHERS: **************************************** //
/*================================================================================================================================================*/
    
	// MAP EDGE CONSTRAINTS:
	int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.485), rmDegreesToRadians(0), rmDegreesToRadians(360));
  	//int playerEdgeConstraint=rmCreateBoxConstraint("player edge of map", rmXTilesToFraction(12), rmZTilesToFraction(12), 1.0-rmXTilesToFraction(12), 1.0-rmZTilesToFraction(12), 0.01);

	// PLAYER CONSTRAINTS:
	int playerConstraint=rmCreateClassDistanceConstraint("stay away from players", classPlayer, 25.0);
	
	// CARDINAL DIRECTIONS:
	int Northward=rmCreatePieConstraint("northMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(315), rmDegreesToRadians(135));
	int Southward=rmCreatePieConstraint("southMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(135), rmDegreesToRadians(315));
	int Eastward=rmCreatePieConstraint("eastMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(45), rmDegreesToRadians(225));
	int Westward=rmCreatePieConstraint("westMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(225), rmDegreesToRadians(45));
	
	// CREATE SOME WATER CONSTRAINTS:
	int avoidWater3 = rmCreateTerrainDistanceConstraint("stuff vs.water 3", "Land", false, 3.0);
	int avoidWater5 = rmCreateTerrainDistanceConstraint("stuff vs.water 5", "Land", false, 5.0);
	int avoidWater6 = rmCreateTerrainDistanceConstraint("stuff vs.water 6", "Land", false, 6.0);
	int avoidWater8 = rmCreateTerrainDistanceConstraint("stuff vs.water 8", "Land", false, 8.0);
	int avoidWater10 = rmCreateTerrainDistanceConstraint("stuff vs. water 10", "Land", false, 10.0);
	int avoidWater12 = rmCreateTerrainDistanceConstraint("stuff vs. water 12", "Land", false, 12.0);
	int avoidWater15 = rmCreateTerrainDistanceConstraint("stuff vs. water 15", "Land", false, 15.0);
    int avoidWater20 = rmCreateTerrainDistanceConstraint("stuff vs. water 20", "Land", false, 20.0);
	int avoidWater25 = rmCreateTerrainDistanceConstraint("stuff vs. water 25", "Land", false, 25.0);
	int avoidWater30 = rmCreateTerrainDistanceConstraint("stuff vs. water 30", "Land", false, 30.0);
	int avoidWater35 = rmCreateTerrainDistanceConstraint("stuff vs. water 35", "Land", false, 35.0);
	
	// AVOID IMPASSABLE LAND:
	int avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 10.0);
	int avoidCloseImpassableLand=rmCreateTerrainDistanceConstraint("close avoid impassable land", "Land", false, 5.0);
	int avoidMediumImpassableLand=rmCreateTerrainDistanceConstraint("medium avoid impassable land", "Land", false, 15.0);
	int avoidFarImpassableLand=rmCreateTerrainDistanceConstraint("far avoid impassable land", "Land", false, 25.0);
    
	// CIRCLE CONSTRAINT:
	int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.47), rmDegreesToRadians(0), rmDegreesToRadians(360));
	int circleConstraintTwo=rmCreatePieConstraint("circle Constraint 2", 0.5, 0.5, 0, rmZFractionToMeters(0.48), rmDegreesToRadians(0), rmDegreesToRadians(360));
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.30);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE 2 SMALL BAYS: ******************************************************** //
/*================================================================================================================================================*/

        // CREATE THE CLASS BAY:
        int classBay=rmDefineClass("bay");
		
		// CREATE THE CLASS BAY CONSTRAINT:
		int avoidBay=rmCreateClassDistanceConstraint("stuff avoid bay", rmClassID("bay"), 15.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int BayID=rmCreateArea("The Bay 1");
		
		rmSetAreaSize(BayID, 0.0335, 0.0335);
        rmSetAreaLocation(BayID, 0.775, 0.775);
	    
		rmAddAreaInfluenceSegment(BayID, 0.600, 1.000, 0.800, 1.000);
		rmAddAreaInfluenceSegment(BayID, 0.800, 1.000, 1.000, 0.800);
		rmAddAreaInfluenceSegment(BayID, 1.000, 0.800, 1.000, 0.600);
		rmAddAreaInfluenceSegment(BayID, 1.000, 0.600, 0.850, 0.600);
		rmAddAreaInfluenceSegment(BayID, 0.850, 0.600, 0.750, 0.650);
		rmAddAreaInfluenceSegment(BayID, 0.750, 0.650, 0.650, 0.750);
		rmAddAreaInfluenceSegment(BayID, 0.650, 0.750, 0.600, 0.850);
		rmAddAreaInfluenceSegment(BayID, 0.600, 0.850, 0.600, 1.000);
		
        rmSetAreaWaterType(BayID, "atlantic coast");
		rmSetAreaBaseHeight(BayID, 1.0); 
        
		rmSetAreaMinBlobs(BayID, 1);
        rmSetAreaMaxBlobs(BayID, 1);
        rmSetAreaMinBlobDistance(BayID, 1);
        rmSetAreaMaxBlobDistance(BayID, 1);
        
		rmSetAreaSmoothDistance(BayID, 5);
        rmSetAreaCoherence(BayID, 1.0);
        
		rmAddAreaToClass(BayID, rmClassID("bay"));
		//rmAddAreaConstraint(BayID, avoidBay); 
	    
        rmSetAreaObeyWorldCircleConstraint(BayID, false);
   
        rmBuildArea(BayID);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

       // int Bay2ID=rmCreateArea("The Bay 2");
		
		//rmSetAreaSize(Bay2ID, 0.0275, 0.0275);
      //  rmSetAreaLocation(Bay2ID, 0.225, 0.225);
	    
		//rmAddAreaInfluenceSegment(Bay2ID, 0.400, 0.000, 0.200, 0.000);
	//	rmAddAreaInfluenceSegment(Bay2ID, 0.200, 0.000, 0.000, 0.200);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.000, 0.200, 0.000, 0.400);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.000, 0.400, 0.150, 0.400);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.150, 0.400, 0.250, 0.350);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.250, 0.350, 0.350, 0.250);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.350, 0.250, 0.400, 0.150);
		//rmAddAreaInfluenceSegment(Bay2ID, 0.400, 0.150, 0.400, 0.000);
		
        //rmSetAreaWaterType(Bay2ID, "Yellow River Flooded");
		//rmSetAreaBaseHeight(Bay2ID, 1.0); 
        
		//rmSetAreaMinBlobs(Bay2ID, 1);
       // rmSetAreaMaxBlobs(Bay2ID, 1);
       // rmSetAreaMinBlobDistance(Bay2ID, 1);
       // rmSetAreaMaxBlobDistance(Bay2ID, 1);
        
		//rmSetAreaSmoothDistance(Bay2ID, 5);
       // rmSetAreaCoherence(Bay2ID, 1.0);
        
		//rmAddAreaToClass(Bay2ID, rmClassID("bay"));
		//rmAddAreaConstraint(Bay2ID, avoidBay); 
	    
       // rmSetAreaObeyWorldCircleConstraint(Bay2ID, false);
   
       // rmBuildArea(Bay2ID);
		
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.35);
/*================================================================================================================================================*/
// ************************************************** DEFINE AND PLACE THE TRADE ROUTE: ********************************************************* //		
/*================================================================================================================================================*/
    
		// CREATE THE CLASS SOCKET:
		int classSocket = rmDefineClass("SocketClass");
		
	    // CREATE THE CLASS SOCKET CONSTRAINTS:
	    int avoidSocket=rmCreateClassDistanceConstraint("socket avoidance", rmClassID("SocketClass"), 8.0);
		
		// CREATE THE TRADE ROUTE CONSTRAINTS:
        int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 6.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		//int whichTradeRoute=rmRandInt(1,2);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE AND PLACE THE TRADE ROUTE NUMBER 1:
	    int tradeRouteID = rmCreateTradeRoute();
        int socketID=rmCreateObjectDef("sockets to dock Trade Posts North");
        rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
		
		//rmAddObjectDefItem(socketID, "ypTradingPostCapture", 1, 6.0);
        //rmAddObjectDefItem(socketID, "Nugget", 1, 6.0);
        //rmSetNuggetDifficulty(99, 99);

        rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
        rmSetObjectDefAllowOverlap(socketID, true);
        rmAddObjectDefToClass(socketID, rmClassID("SocketClass"));
        rmSetObjectDefMinDistance(socketID, 0.0);
        rmSetObjectDefMaxDistance(socketID, 8.0);
		
		rmAddTradeRouteWaypoint(tradeRouteID, 0.300, 0.900);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.400, 0.800);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.700);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.600, 0.700);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.700, 0.600);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.700, 0.500);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.800, 0.400);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.900, 0.300);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "java");
        if(placedTradeRoute == false)
        rmEchoError("Failed to place trade route");
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/  
	  
	    rmPlaceObjectDefAtLoc(socketID, 0, 0.300, 0.900); 
		rmPlaceObjectDefAtLoc(socketID, 0, 0.500, 0.700);
        rmPlaceObjectDefAtLoc(socketID, 0, 0.650, 0.650); 		
		rmPlaceObjectDefAtLoc(socketID, 0, 0.700, 0.500); 
		rmPlaceObjectDefAtLoc(socketID, 0, 0.900, 0.300);  	

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      
	    // DEFINE AND PLACE THE TRADE ROUTE NUMBER 2:
	    int tradeRoute2ID = rmCreateTradeRoute();
        socketID=rmCreateObjectDef("sockets to dock Trade Posts South");
        rmSetObjectDefTradeRouteID(socketID, tradeRoute2ID);

        //rmAddObjectDefItem(socketID, "ypTradingPostCapture", 1, 6.0);
        //rmAddObjectDefItem(socketID, "Nugget", 1, 6.0);
        //rmSetNuggetDifficulty(99, 99);
		
		rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
        rmSetObjectDefAllowOverlap(socketID, true);
        rmAddObjectDefToClass(socketID, rmClassID("SocketClass"));
        rmSetObjectDefMinDistance(socketID, 0.0);
        rmSetObjectDefMaxDistance(socketID, 8.0);
	
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.100, 0.700);
	    rmAddTradeRouteWaypoint(tradeRoute2ID, 0.200, 0.600);
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.300, 0.500);
	    rmAddTradeRouteWaypoint(tradeRoute2ID, 0.300, 0.400);
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.400, 0.300);
	    rmAddTradeRouteWaypoint(tradeRoute2ID, 0.500, 0.300);
		rmAddTradeRouteWaypoint(tradeRoute2ID, 0.600, 0.200);
	    rmAddTradeRouteWaypoint(tradeRoute2ID, 0.700, 0.100);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        placedTradeRoute = rmBuildTradeRoute(tradeRoute2ID, "java");
        if(placedTradeRoute == false)
        rmEchoError("Failed to place trade route"); 
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/  

        rmPlaceObjectDefAtLoc(socketID, 0, 0.100, 0.700); 
		rmPlaceObjectDefAtLoc(socketID, 0, 0.300, 0.500); 
		rmPlaceObjectDefAtLoc(socketID, 0, 0.350, 0.350); 
		rmPlaceObjectDefAtLoc(socketID, 0, 0.500, 0.300);  	
		rmPlaceObjectDefAtLoc(socketID, 0, 0.700, 0.100); 

/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.40);
/*================================================================================================================================================*/
// ****************************************************** SET UP THE PLAYER LOCATIONS: ********************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		float teamStartLoc = rmRandFloat(0.0, 1.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// TEAM 0 STARTS ON TOP:
		
		if (teamStartLoc > 0.5) 

	{
		rmSetPlacementTeam(0);
		rmPlacePlayersLine(0.475, 0.875, 0.150, 0.525, 0.0, 0.0);
		rmSetTeamSpacingModifier(0.20);
		
		rmSetPlacementTeam(1);
		rmPlacePlayersLine(0.525, 0.125, 0.875, 0.475, 0.0, 0.0);
		rmSetTeamSpacingModifier(0.20);
		
	}
		else
	{
		rmSetPlacementTeam(0);
		rmPlacePlayersLine(0.525, 0.125, 0.875, 0.475, 0.0, 0.0);
		rmSetTeamSpacingModifier(0.20);
		
		rmSetPlacementTeam(1);
		rmPlacePlayersLine(0.475, 0.875, 0.150, 0.525, 0.0, 0.0);
		rmSetTeamSpacingModifier(0.20);
	}
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.45);
/*================================================================================================================================================*/
// ********************************************************* SET UP THE PLAYER AREAS: *********************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		float playerFraction=rmAreaTilesToFraction(1250);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
	    for(i=1; <cNumberPlayers)
	{
		// CREATE THE AREA:
		int id=rmCreateArea("Player"+i);
		
		// ASSIGN TO THE PLAYER:
		rmSetPlayerArea(i, id);
		
		// SET THE SIZE:
		rmSetAreaSize(id, playerFraction, playerFraction);
		
		// ADD AREA TO CLASS:
		rmAddAreaToClass(id, classPlayer);
		
		// SET AREA MIN AND MAX BLOBS:
		rmSetAreaMinBlobs(id, 1);
		rmSetAreaMaxBlobs(id, 1);
		
		// ADD AREA CONSTRAINT:
		//rmAddAreaConstraint(id, avoidCliff); 
		//rmAddAreaConstraint(id, avoidWater5); 
		
		// SET AREA COHERENCE:
		rmSetAreaCoherence(id, 0.7);
	rmSetAreaSmoothDistance(id, 0.7);
		
		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_grass");
		//rmSetAreaMix(id, "rockies_snow");
		//rmSetAreaMix(id, "texas_grass");
		//rmSetAreaMix(id, "mongolia_desert");
		rmSetAreaMix(id, "city_jawa");	  

        // SET AREA TERRAIN TYPE:
		//rmSetAreaTerrainType(id, "texas\ground1_tex");		
		
		// SET AREA LOC PLAYER:
		rmSetAreaLocPlayer(id, i);
	
		// SET AREA WARN FAILURE:
		rmSetAreaWarnFailure(id, true);
	}
	    // BUILD THE AREAS:
	    rmBuildAllAreas();

/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.50);
/*================================================================================================================================================*/
// ***************************************** DEFINE THE TCID AND THE STARTING UNITS AND RESOURCES: ********************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    int avoidAll=rmCreateTypeDistanceConstraint("objects avoid all", "all", 7.0);
		
		int avoidGold=rmCreateTypeDistanceConstraint("stuff avoid gold", "AbstractMine", 8.0);
		int nuggetAvoidGold=rmCreateTypeDistanceConstraint("nugget avoid gold", "AbstractMine", 8.0);
		int treeAvoidGold=rmCreateTypeDistanceConstraint("tree avoid gold", "AbstractMine", 10.0);

        int avoidPlayerBerries = rmCreateTypeDistanceConstraint("objects avoid player berries", "AbstractFruit", 8.0);
		int treeAvoidPlayerBerries = rmCreateTypeDistanceConstraint("trees avoid player berries", "AbstractFruit", 10.0);
		
		int avoidPlayerNugget=rmCreateTypeDistanceConstraint("stuff avoid player nugget", "AbstractNugget", 10.0);
		int treeAvoidPlayerNugget=rmCreateTypeDistanceConstraint("tree avoid player nugget", "AbstractNugget", 12.0);
		
		int avoidTrees = rmCreateTypeDistanceConstraint("objects avoid trees", "ypTreeSaxaul", 22.5);
		
		// FLAG CONSTRAINTS FOR HC SPAWN POINT:
        //int flagEdgeConstraint = rmCreatePieConstraint("flags away from edge of map", 0.5, 0.5, 0, rmGetMapXSize()-25, 0, 0, 0);
		//int flagEdgeConstraint = rmCreatePieConstraint("flags stay near edge of map", 0.5, 0.5, rmGetMapXSize()-180, rmGetMapXSize()-40, 0, 0, 0);
	
	    int flagLand = rmCreateTerrainDistanceConstraint("flag vs land", "land", true, 15.0);
	    int flagVsFlag = rmCreateTypeDistanceConstraint("flag avoid same", "HomeCityWaterSpawnFlag", 75); 
 		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE THE TCID:
		int TCID = rmCreateObjectDef("player TC");
	    if ( rmGetNomadStart())
		rmAddObjectDefItem(TCID, "coveredWagon", 1, 0);
	    else
		rmAddObjectDefItem(TCID, "townCenter", 1, 0);

	    rmSetObjectDefMinDistance(TCID, 0.0);
	    rmSetObjectDefMaxDistance(TCID, 0.0); 
	    //rmAddObjectDefConstraint(TCID, avoidWater8);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
    	
	    // DEFINE THE STARTING UNITS:
	    int startingUnits = rmCreateStartingUnitsObjectDef(4.0);
	    rmSetObjectDefMinDistance(startingUnits, 5.0);
	    rmSetObjectDefMaxDistance(startingUnits, 8.0);
	    //rmAddObjectDefConstraint(startingUnits, avoidAll);
	    
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE THE PLAYER GOLD:
	    int playerGoldID = rmCreateObjectDef("The Player Silver");
	    rmAddObjectDefItem(playerGoldID, "minegold", 1, 0);
	    rmSetObjectDefMinDistance(playerGoldID, 14.0);
	    rmSetObjectDefMaxDistance(playerGoldID, 17.0);
	    rmAddObjectDefConstraint(playerGoldID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        //DEFINE THE PLAYER CRATE: - ( DOCK WAGON ) -
	    int playerCrateID=rmCreateObjectDef("The Player Crates");
		rmAddObjectDefItem(playerCrateID, "crateOfFood", rmRandInt(2, 3), 4.0);
        rmAddObjectDefItem(playerCrateID, "crateOfWood", rmRandInt(1, 2), 4.0);
        rmAddObjectDefItem(playerCrateID, "crateOfCoin", 1, 4.0);
	    rmSetObjectDefMinDistance(playerCrateID, 9.0);
	    rmSetObjectDefMaxDistance(playerCrateID, 12.0);
	    rmAddObjectDefConstraint(playerCrateID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
		
        int whichVariation=-1;
	    whichVariation = rmRandInt(1,2);
		
        // DEFINE THE PLAYER BERRIES:
	    int playerBerriesID=rmCreateObjectDef("The Player Berries");
		
		if ( whichVariation == 1 )
		{	
	    rmAddObjectDefItem(playerBerriesID, "SKepel", 5, 4.0);
		}
		else
		{
	    rmAddObjectDefItem(playerBerriesID, "SBuni", 5, 4.0);
		}
	    //rmAddObjectDefItem(playerBerriesID, "berrybush", 7, 4.0);	
        rmSetObjectDefMinDistance(playerBerriesID, 13);
        rmSetObjectDefMaxDistance(playerBerriesID, 15);	
	    rmAddObjectDefConstraint(playerBerriesID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*		
		// DEFINE THE PLAYER POP BLOCK:
	    int playerPopBlock=rmCreateObjectDef("The Player Pop Block");
	    rmAddObjectDefItem(playerPopBlock, "ypPopBlock", 1, 0.0);	
        rmSetObjectDefMinDistance(playerPopBlock, 7);
        rmSetObjectDefMaxDistance(playerPopBlock, 10);
	    rmAddObjectDefConstraint(playerPopBlock, avoidAll);
*/		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE THE PLAYER YPSAIGA:
	    int playerypSaigaID=rmCreateObjectDef("The Player YPSAIGA");
        rmAddObjectDefItem(playerypSaigaID, "Deer", 7, 6.0);
        rmSetObjectDefCreateHerd(playerypSaigaID, false);		
        rmSetObjectDefMinDistance(playerypSaigaID, 15);
	    rmSetObjectDefMaxDistance(playerypSaigaID, 20);	
	    rmAddObjectDefConstraint(playerypSaigaID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE THE PLAYER NUGGET:
		int playerNuggetID= rmCreateObjectDef("player nugget"); 
	    rmAddObjectDefItem(playerNuggetID, "Nugget", 1, 0.0);
		//rmAddObjectDefToClass(playerNuggetID, rmClassID("resource"));
	    rmSetNuggetDifficulty(1, 1);
	    rmSetObjectDefMinDistance(playerNuggetID, 16.0);
	    rmSetObjectDefMaxDistance(playerNuggetID, 18.0);
		rmAddObjectDefConstraint(playerNuggetID, avoidAll);
        rmAddObjectDefConstraint(playerNuggetID, avoidPlayerBerries);
        rmAddObjectDefConstraint(playerNuggetID, nuggetAvoidGold);		
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		// DEFINE THE START AREA TREE:
	    int StartAreaTreeID=rmCreateObjectDef("The Starting Trees");
	    rmAddObjectDefItem(StartAreaTreeID, "STreeMahogany", 11, 8.0);
	    rmSetObjectDefMinDistance(StartAreaTreeID, 22.0);	
	    rmSetObjectDefMaxDistance(StartAreaTreeID, 25.0);
		rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
		rmAddObjectDefConstraint(StartAreaTreeID, avoidTrees);
        rmAddObjectDefConstraint(StartAreaTreeID, treeAvoidPlayerBerries);
		rmAddObjectDefConstraint(StartAreaTreeID, treeAvoidPlayerNugget);
		rmAddObjectDefConstraint(StartAreaTreeID, treeAvoidGold);
		
		// DEFINE Unique Buildings:	
		int SoldatSekulID=rmCreateObjectDef("soldat sekul building");
		
			rmAddObjectDefItem(SoldatSekulID, "SoldatSekul", 1, 0.0);
		rmSetObjectDefMinDistance(SoldatSekulID, 16.0);
		rmSetObjectDefMaxDistance(SoldatSekulID, 20.0);
		rmAddObjectDefConstraint(SoldatSekulID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
        // DEFINE THE VARIABLE FOR THE WATER SPAWN POINT:
		int waterSpawnPointID = 0;	
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.55);
/*================================================================================================================================================*/	
// ***************************************** DEFINE THE TCID AND THE STARTING UNITS AND RESOURCES: ********************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // CLEAR OUT CONSTRAINTS FOR GOOD MEASURE:
        rmClearClosestPointConstraints(); 
   
	    for(i=1; <cNumberPlayers)
		
    {
	    // PLACE THE TCID:
		rmPlaceObjectDefAtLoc(TCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		vector TCLoc = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, i));				
		
	if (rmGetPlayerCiv(i) ==  rmGetCivID("Germans")) {
          rmPlaceObjectDefAtLoc(SoldatSekulID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
        }
		
		// PLACE THE STARTING UNITS:
		rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

        // PLACE THE PLAYER GOLD:
		rmPlaceObjectDefAtLoc(playerGoldID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

        // PLACE THE PLAYER CRATE:
		rmPlaceObjectDefAtLoc(playerCrateID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

        // PLACE THE PLAYER BERRIES:
		rmPlaceObjectDefAtLoc(playerBerriesID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

        // PLACE THE PLAYER POP BLOCK:
		//rmPlaceObjectDefAtLoc(playerPopBlock, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		
		// PLACE THE PLAYER SEROW:
		rmPlaceObjectDefAtLoc(playerypSaigaID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		
		// PLACE THE PLAYER NUGGET:
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
        //rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));

        // PLACE THE START AREA TREE:
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
	    rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		//rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		//rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		//rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		//rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		
		// NOMAD:
		if(ypIsAsian(i) && rmGetNomadStart() == false)
        rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i), i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
	
		// PLACE THE WATER SPAWN POINTS FOR THE PLAYERS:
		waterSpawnPointID=rmCreateObjectDef("colony ship "+i);
		rmAddObjectDefItem(waterSpawnPointID, "HomeCityWaterSpawnFlag", 1, 10.0);
		
		rmAddClosestPointConstraint(flagVsFlag);
		rmAddClosestPointConstraint(flagLand); 
		//rmAddClosestPointConstraint(flagEdgeConstraint); 
		rmAddClosestPointConstraint(playerEdgeConstraint); 
		
		vector closestPoint = rmFindClosestPointVector(TCLoc, rmXFractionToMeters(1.0));
		
		rmPlaceObjectDefAtLoc(waterSpawnPointID, i, rmXMetersToFraction(xsVectorGetX(closestPoint)), rmZMetersToFraction(xsVectorGetZ(closestPoint)));

   		// CLEAR CLOSEST POINT FOR NEXT ITERATION:
        rmClearClosestPointConstraints();
	}
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.60);
/*================================================================================================================================================*/
// ************************************************** DEFINE AND PLACE THE NATIVE AMERICANS: **************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	// CREATE THE NATIVES CLASS:
	int classNatives=rmDefineClass("natives");
    
	// CREATE THE NATIVES CONSTRAINTS:
	int nativesConstraint=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 12.0);
	int nativesCloseConstraint=rmCreateClassDistanceConstraint("close stuff avoids natives", rmClassID("natives"), 8.0);
    int nativesMediumConstraint=rmCreateClassDistanceConstraint("medium vs natives", rmClassID("natives"), 35.0);
	int nativesFarConstraint=rmCreateClassDistanceConstraint("far vs natives", rmClassID("natives"), 65.0);
	
	// CREATE THE IMPORTANT ITEM CLASS:
	int importantItemClass=rmDefineClass("importantItem");
	
	// CREATE THE IMPORTANT ITEM CONSTRAINTS:
	int importantItemConstraint=rmCreateClassDistanceConstraint("stuff vs importantItem", rmClassID("importantItem"), 15.0);
    int importantMediumItemConstraint=rmCreateClassDistanceConstraint("medium vs importantItem", rmClassID("importantItem"), 35.0);
    int importantFarItemConstraint=rmCreateClassDistanceConstraint("far vs importantItem", rmClassID("importantItem"), 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int nativeVillageAID = -1;
	    int nativeVillageType = rmRandInt(1,3);
		if(subCiv0 == rmGetCivID("Pesisiran"))
	{   
		nativeVillageAID = rmCreateGrouping("village 0", "Pesisiran_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageAID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageAID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageAID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageAID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageAID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageAID, importantItemConstraint);

		if (cNumberNonGaiaPlayers <=2)
		rmPlaceGroupingAtLoc(nativeVillageAID, 0, 0.125, 0.525);
		//else
		//rmPlaceGroupingAtLoc(nativeVillageAID, 0, 0.575, 0.575);
	}
	else
	{  
		nativeVillageAID = rmCreateGrouping("village 0", "Cirebon_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageAID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageAID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageAID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageAID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageAID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageAID, importantItemConstraint);

		if (cNumberNonGaiaPlayers <=2)
		rmPlaceGroupingAtLoc(nativeVillageAID, 0, 0.125, 0.525);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

		int nativeVillageBID = -1;
		if (subCiv1 == rmGetCivID("Pesantren"))
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageBID = rmCreateGrouping("village 1", "Pesantren_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageBID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageBID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageBID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageBID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageBID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageBID, importantItemConstraint);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceGroupingAtLoc(nativeVillageBID, 0, 0.875, 0.475);
		//else
		//rmPlaceGroupingAtLoc(nativeVillageBID, 0, 0.425, 0.425);
		
	}
	else
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageBID = rmCreateGrouping("village 1", "Sunda_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageBID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageBID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageBID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageBID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageBID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageBID, importantItemConstraint);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceGroupingAtLoc(nativeVillageBID, 0, 0.875, 0.475);
		//else
		//rmPlaceGroupingAtLoc(nativeVillageBID, 0, 0.425, 0.425);
		
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

		int nativeVillageCID = -1;
		if(subCiv2 == rmGetCivID("Pesisiran"))
	{   
	    nativeVillageType = rmRandInt(1,3);
		nativeVillageCID = rmCreateGrouping("village 2", "Pesisiran_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageCID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageCID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageCID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageCID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageCID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageCID, importantItemConstraint);
		
		rmPlaceGroupingAtLoc(nativeVillageCID, 0, 0.200, 0.800);
	}
	else
	{   
	    nativeVillageType = rmRandInt(1,3);
		nativeVillageCID = rmCreateGrouping("village 2", "Cirebon_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageCID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageCID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageCID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageCID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageCID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageCID, importantItemConstraint);
		
		rmPlaceGroupingAtLoc(nativeVillageCID, 0, 0.200, 0.800);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

		int nativeVillageDID = -1;
		if (subCiv3 == rmGetCivID("Pesantren"))
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageDID = rmCreateGrouping("village 3", "Pesantren_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageDID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageDID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageDID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageDID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageDID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageDID, importantItemConstraint);
	
		rmPlaceGroupingAtLoc(nativeVillageDID, 0, 0.575, 0.575);
	}
	else
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageDID = rmCreateGrouping("village 3", "Sunda_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageDID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageDID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageDID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageDID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageDID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageDID, importantItemConstraint);
	
		rmPlaceGroupingAtLoc(nativeVillageDID, 0, 0.575, 0.575);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
		int nativeVillageEID = -1;
        if(subCiv4 == rmGetCivID("Pesisiran"))
	{   
	    nativeVillageType = rmRandInt(1,3);
		nativeVillageEID = rmCreateGrouping("village 4", "Pesisiran_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageEID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageEID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageEID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageEID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageEID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageEID, importantItemConstraint);
		
		rmPlaceGroupingAtLoc(nativeVillageEID, 0, 0.800, 0.200);
	}
	else
	{   
	    nativeVillageType = rmRandInt(1,3);
		nativeVillageEID = rmCreateGrouping("village 4", "Cirebon_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageEID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageEID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageEID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageEID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageEID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageEID, importantItemConstraint);
		
		rmPlaceGroupingAtLoc(nativeVillageEID, 0, 0.800, 0.200);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

		int nativeVillageFID = -1;
		if (subCiv5 == rmGetCivID("Pesantren"))
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageFID = rmCreateGrouping("village 5", "Pesantren_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageFID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageFID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageFID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageFID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageFID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageFID, importantItemConstraint);
	
		rmPlaceGroupingAtLoc(nativeVillageFID, 0, 0.425, 0.425);
	}
	else
	{
	    nativeVillageType = rmRandInt(1,5);
		nativeVillageFID = rmCreateGrouping("village 5", "Sunda_"+nativeVillageType);
		rmSetGroupingMinDistance(nativeVillageFID, 0.0);
		rmSetGroupingMaxDistance(nativeVillageFID, rmXFractionToMeters(0.0));
		rmAddGroupingToClass(nativeVillageFID, rmClassID("natives"));
		rmAddGroupingToClass(nativeVillageFID, rmClassID("importantItem"));
		rmAddGroupingConstraint(nativeVillageFID, nativesConstraint);
		rmAddGroupingConstraint(nativeVillageFID, importantItemConstraint);
	
		rmPlaceGroupingAtLoc(nativeVillageFID, 0, 0.425, 0.425);
	}    
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.65);
/*================================================================================================================================================*/
// ********************************************************* CHECK FOR KOTH GAME MODE: ********************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
  
        // CREATE THE KOTH CONSTRAINT:
		int avoidKOTH = rmCreateTypeDistanceConstraint("stuff vs. KOTH", "ypKingsHill", 15.0); 

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        if(rmGetIsKOTH()) 
	{
        
		//ypKingsHillLandfill(0.50, 0.50, .0035, 1.0, "texas_grass", avoidAll);
		// ypKingsHillPlacer(0.50, 0.50, 0.01, avoidWater15);
		   ypKingsHillPlacer(0.5, 0.5, 0.01, 0);
		
    }
	
/*================================================================================================================================================*/
    // TEXT:
    // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
    rmSetStatusText("",0.70);
/*================================================================================================================================================*/
// *************************************************** DEFINE AND PLACE THE TEXAS FOREST: ******************************************************* //
/*================================================================================================================================================*/  
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // CREATE THE FOREST CLASS:
		int forestClass=rmDefineClass("classForest");
		
		// CREATE THE FOREST CONSTRAINT:
		int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 10.0);
	    int forestMediumConstraint=rmCreateClassDistanceConstraint("medium vs. forest", rmClassID("classForest"), 45.0);
        int forestCloseConstraint=rmCreateClassDistanceConstraint("close vs. forest", rmClassID("classForest"), 8.0);
        int forestFarConstraint=rmCreateClassDistanceConstraint("far vs. forest", rmClassID("classForest"), 65.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        int forestTreeID = 0;
        
		if (cNumberNonGaiaPlayers <=2)
		int numTries = 10.0 * cNumberNonGaiaPlayers;
		else
		numTries = 5.0 * cNumberNonGaiaPlayers;
		
		int failCount=0;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
        
		for (i=0; <numTries)
{   
        int forest=rmCreateArea("forest 1"+i);
	
		rmSetAreaWarnFailure(forest, false);
		rmSetAreaSize(forest, rmAreaTilesToFraction(225), rmAreaTilesToFraction(350));
		rmSetAreaForestType(forest, "Jawa Lowland Forest");
		
		rmSetAreaForestDensity(forest, 1.0);
        rmSetAreaForestClumpiness(forest, 0.4);
        rmSetAreaForestUnderbrush(forest, 0.5);
         
		rmSetAreaMinBlobs(forest, 1);
        rmSetAreaMaxBlobs(forest, 3);
        rmSetAreaMinBlobDistance(forest, 1.0);
        rmSetAreaMaxBlobDistance(forest, 5.0);
         
		rmSetAreaCoherence(forest, 0.7);
        rmSetAreaSmoothDistance(forest, 5);
    	rmAddAreaToClass(forest, rmClassID("classForest"));
   
		rmAddAreaConstraint(forest, forestFarConstraint);
        rmAddAreaConstraint(forest, nativesConstraint);
		rmAddAreaConstraint(forest, playerConstraint);
		rmAddAreaConstraint(forest, playerEdgeConstraint);
		rmAddAreaConstraint(forest, avoidKOTH);
        rmAddAreaConstraint(forest, avoidTradeRoute); 
        rmAddAreaConstraint(forest, avoidSocket);
		rmAddAreaConstraint(forest, avoidWater8);
		//rmAddAreaConstraint(forest, avoidBay);
		rmAddAreaConstraint(forest, Northward);
 
        if(rmBuildArea(forest)==false)
    {
        // Stop trying once we fail 5 times in a row.
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
        int forest2=rmCreateArea("forest 2"+i);
	
		rmSetAreaWarnFailure(forest2, false);
		rmSetAreaSize(forest2, rmAreaTilesToFraction(225), rmAreaTilesToFraction(350));
		rmSetAreaForestType(forest2, "Jawa Lowland Forest");
		
		rmSetAreaForestDensity(forest2, 1.0);
        rmSetAreaForestClumpiness(forest2, 0.4);
        rmSetAreaForestUnderbrush(forest2, 0.5);
         
		rmSetAreaMinBlobs(forest2, 1);
        rmSetAreaMaxBlobs(forest2, 3);
        rmSetAreaMinBlobDistance(forest2, 1.0);
        rmSetAreaMaxBlobDistance(forest2, 5.0);
         
		rmSetAreaCoherence(forest2, 0.7);
        rmSetAreaSmoothDistance(forest2, 5);
    	rmAddAreaToClass(forest2, rmClassID("classForest"));
		
		rmAddAreaConstraint(forest2, forestFarConstraint);
        rmAddAreaConstraint(forest2, nativesConstraint);
		rmAddAreaConstraint(forest2, playerConstraint);
		rmAddAreaConstraint(forest2, playerEdgeConstraint);
		rmAddAreaConstraint(forest2, avoidKOTH);
        rmAddAreaConstraint(forest2, avoidTradeRoute); 
        rmAddAreaConstraint(forest2, avoidSocket);
		rmAddAreaConstraint(forest2, avoidWater8);
		//rmAddAreaConstraint(forest2, avoidBay);
		rmAddAreaConstraint(forest2, Southward);

        if(rmBuildArea(forest2)==false)
    {
        // Stop trying once we fail 5 times in a row.
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
// ***************************************************** DEFINE AND PLACE THE SILVER MINES: ***************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

    int avoidCoin=rmCreateTypeDistanceConstraint("stuff avoid coin", "gold", 12.0);
	int avoidCloseCoin=rmCreateTypeDistanceConstraint("close avoid coin", "gold", 10.0);
	int avoidMediumCoin=rmCreateTypeDistanceConstraint("medium avoid coin", "gold", 35.0);
	int avoidFarCoin=rmCreateTypeDistanceConstraint("far avoid coin", "gold", 65.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    int silverType = -1;
		if (cNumberNonGaiaPlayers <=2)
	    int silverCount = 10;
		else
		silverCount = 10;
	    rmEchoInfo("silver count = "+silverCount);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    for(i=0; < silverCount)
	{
	    int silverID = rmCreateObjectDef("silver "+i);
	    rmAddObjectDefItem(silverID, "minegold", 1, 0.0);
        rmSetObjectDefMinDistance(silverID, 0.0);
        rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.5));

		rmAddObjectDefConstraint(silverID, avoidFarCoin);
		rmAddObjectDefConstraint(silverID, forestConstraint);
        rmAddObjectDefConstraint(silverID, playerConstraint);
		rmAddObjectDefConstraint(silverID, playerEdgeConstraint);
		rmAddObjectDefConstraint(silverID, avoidKOTH);
		rmAddObjectDefConstraint(silverID, avoidTradeRoute);
		rmAddObjectDefConstraint(silverID, avoidSocket);
		rmAddObjectDefConstraint(silverID, nativesConstraint);
		rmAddObjectDefConstraint(silverID, avoidWater10);
		rmAddObjectDefConstraint(silverID, Northward);
	    
		rmPlaceObjectDefAtLoc(silverID, 0, 0.50, 0.50);
   }

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    for(i=0; < silverCount)
	{
	    int silver2ID = rmCreateObjectDef("silver 2 "+i);
	    rmAddObjectDefItem(silver2ID, "minegold", 1, 0.0);
        rmSetObjectDefMinDistance(silver2ID, 0.0);
        rmSetObjectDefMaxDistance(silver2ID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(silver2ID, avoidFarCoin);
		rmAddObjectDefConstraint(silver2ID, forestConstraint);
        rmAddObjectDefConstraint(silver2ID, playerConstraint);
		rmAddObjectDefConstraint(silver2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(silver2ID, avoidKOTH);
		rmAddObjectDefConstraint(silver2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(silver2ID, avoidSocket);
		rmAddObjectDefConstraint(silver2ID, nativesConstraint);
		rmAddObjectDefConstraint(silver2ID, avoidWater10);
		rmAddObjectDefConstraint(silver2ID, Southward);
	    
		rmPlaceObjectDefAtLoc(silver2ID, 0, 0.50, 0.50);
   }

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.80);
/*================================================================================================================================================*/
// ********************************************** DEFINE AND PLACE THE NUGGETS: -(TREASURES)- *************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
  
	    int avoidNugget=rmCreateTypeDistanceConstraint("stuff avoid nugget", "AbstractNugget", 12.0);
		int avoidCloseNugget=rmCreateTypeDistanceConstraint("close avoid nugget", "AbstractNugget", 10.0);
		int avoidMediumNugget=rmCreateTypeDistanceConstraint("medium avoid nugget", "AbstractNugget", 35.0);
	    int avoidFarNugget=rmCreateTypeDistanceConstraint("far avoid nugget", "AbstractNugget", 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN NUGGETS: ( -TREASURES- ) 
		int nuggetID= rmCreateObjectDef("The Northern Nugget"); 
	    rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
	    rmSetNuggetDifficulty(1, 4);
	    rmSetObjectDefMinDistance(nuggetID, 0.0);
	    rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(nuggetID, avoidFarNugget);
		rmAddObjectDefConstraint(nuggetID, forestConstraint);
		rmAddObjectDefConstraint(nuggetID, avoidCoin);
        rmAddObjectDefConstraint(nuggetID, playerConstraint);
		rmAddObjectDefConstraint(nuggetID, playerEdgeConstraint);
		rmAddObjectDefConstraint(nuggetID, avoidKOTH);
		rmAddObjectDefConstraint(nuggetID, avoidTradeRoute);
		rmAddObjectDefConstraint(nuggetID, avoidSocket);
		rmAddObjectDefConstraint(nuggetID, nativesConstraint);
		rmAddObjectDefConstraint(nuggetID, avoidWater10);
		rmAddObjectDefConstraint(nuggetID, Northward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
        
		// THE SOUTHERN NUGGETS: ( -TREASURES- ) 
		int nugget2ID= rmCreateObjectDef("The Southern Nugget"); 
	    rmAddObjectDefItem(nugget2ID, "Nugget", 1, 0.0);
	    rmSetNuggetDifficulty(1, 4);
	    rmSetObjectDefMinDistance(nugget2ID, 0.0);
	    rmSetObjectDefMaxDistance(nugget2ID, rmXFractionToMeters(0.5));
		
		//rmAddObjectDefConstraint(nugget2ID, avoidFarNugget);
		rmAddObjectDefConstraint(nugget2ID, avoidMediumNugget);
		rmAddObjectDefConstraint(nugget2ID, forestConstraint);
		rmAddObjectDefConstraint(nugget2ID, avoidCoin);
        rmAddObjectDefConstraint(nugget2ID, playerConstraint);
		rmAddObjectDefConstraint(nugget2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(nugget2ID, avoidKOTH);
		rmAddObjectDefConstraint(nugget2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(nugget2ID, avoidSocket);
		rmAddObjectDefConstraint(nugget2ID, nativesConstraint);
		rmAddObjectDefConstraint(nugget2ID, avoidWater10);
		rmAddObjectDefConstraint(nugget2ID, Southward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(nugget2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*10.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(nugget2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*5.0);
	}

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.825);
/*================================================================================================================================================*/
// ******************************************************* DEFINE AND PLACE THE BERRIES: ******************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
  
	    int avoidFruits=rmCreateTypeDistanceConstraint("stuff avoid berries", "AbstractFruit", 12.0);
		int avoidCloseFruits=rmCreateTypeDistanceConstraint("close avoid berries", "AbstractFruit", 10.0);
		int avoidMediumFruits=rmCreateTypeDistanceConstraint("medium avoid berries", "AbstractFruit", 30.0);
	    int avoidFarFruits=rmCreateTypeDistanceConstraint("far avoid berries", "AbstractFruit", 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN BERRYBUSH:
		int fruitsID= rmCreateObjectDef("The Northern Berries"); 
		if ( whichVariation == 1 )
		{	
	    rmAddObjectDefItem(fruitsID, "SKepel", rmRandInt(2,3), 6.0);
		}
		else
		{
	    rmAddObjectDefItem(fruitsID, "SBuni", rmRandInt(2,4), 6.0);
		}
	    //rmAddObjectDefItem(fruitsID, "berrybush", rmRandInt(7,11), 7.0); 
		rmSetObjectDefCreateHerd(fruitsID, false);
	    rmSetObjectDefMinDistance(fruitsID, 0.0);
	    rmSetObjectDefMaxDistance(fruitsID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(fruitsID, avoidWater10);
		rmAddObjectDefConstraint(fruitsID, avoidFarFruits);
		rmAddObjectDefConstraint(fruitsID, avoidNugget);
		rmAddObjectDefConstraint(fruitsID, avoidCoin);
		rmAddObjectDefConstraint(fruitsID, forestConstraint);
		rmAddObjectDefConstraint(fruitsID, nativesConstraint);
		rmAddObjectDefConstraint(fruitsID, playerConstraint);
		rmAddObjectDefConstraint(fruitsID, playerEdgeConstraint);
		rmAddObjectDefConstraint(fruitsID, avoidTradeRoute);
		rmAddObjectDefConstraint(fruitsID, avoidSocket);
		rmAddObjectDefConstraint(fruitsID, avoidKOTH);
		rmAddObjectDefConstraint(fruitsID, Northward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(fruitsID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(fruitsID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		// THE SOUTHERN BERRYBUSH:
		int fruits2ID= rmCreateObjectDef("The Southern Berries"); 
		if ( whichVariation == 1 )
		{	
	    rmAddObjectDefItem(fruits2ID, "SKepel", rmRandInt(2,3), 6.0);
		}
		else
		{
	    rmAddObjectDefItem(fruits2ID, "SBuni", rmRandInt(2,3), 6.0);
		}
	    //rmAddObjectDefItem(fruits2ID, "berrybush", rmRandInt(5,9), 6.0); 
		rmSetObjectDefCreateHerd(fruits2ID, false);
	    rmSetObjectDefMinDistance(fruits2ID, 0.0);
	    rmSetObjectDefMaxDistance(fruits2ID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(fruits2ID, avoidWater10);
		rmAddObjectDefConstraint(fruits2ID, avoidFarFruits);
		rmAddObjectDefConstraint(fruits2ID, avoidNugget);
		rmAddObjectDefConstraint(fruits2ID, avoidCoin);
		rmAddObjectDefConstraint(fruits2ID, forestConstraint);
		rmAddObjectDefConstraint(fruits2ID, nativesConstraint);
		rmAddObjectDefConstraint(fruits2ID, playerConstraint);
		rmAddObjectDefConstraint(fruits2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(fruits2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(fruits2ID, avoidSocket);
		rmAddObjectDefConstraint(fruits2ID, avoidKOTH);
		rmAddObjectDefConstraint(fruits2ID, Southward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(fruits2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(fruits2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	}	

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.85);
/*================================================================================================================================================*/
// **************************************************** DEFINE AND PLACE THE BISONS HERDS: ****************************************************** //
/*================================================================================================================================================*/        
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // CREATE THE FOOD CLASS:
		int foodClass=rmDefineClass("food");
		
		// CREATE THE FOOD CONSTRAINT:
		int foodConstraint=rmCreateClassDistanceConstraint("stuff vs. food", rmClassID("food"), 15.0);
	    int foodMediumConstraint=rmCreateClassDistanceConstraint("medium vs. food", rmClassID("food"), 35.0);
        int foodCloseConstraint=rmCreateClassDistanceConstraint("close vs. food", rmClassID("food"), 10.0);
        int foodFarConstraint=rmCreateClassDistanceConstraint("far vs. food", rmClassID("food"), 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN FOOD:
		int huntableID= rmCreateObjectDef("The Northern ypSaiga or ypMuskDeer Herds");
        
        int whichHuntable=-1;
		whichHuntable=rmRandInt(1, 2);
		
		if ( whichHuntable == 1 )
    {		
		rmAddObjectDefItem(huntableID, "Deer", rmRandInt(3,4), 9.0);
	}	
        else
    {		
	    rmAddObjectDefItem(huntableID, "Pronghorn", rmRandInt(2,4), 9.0); 
	}
	
		rmSetObjectDefCreateHerd(huntableID, false);
	    rmSetObjectDefMinDistance(huntableID, 0.0);
	    rmSetObjectDefMaxDistance(huntableID, rmXFractionToMeters(0.5));
		rmAddObjectDefToClass(huntableID, rmClassID("food"));
		
		rmAddObjectDefConstraint(huntableID, foodFarConstraint);
		rmAddObjectDefConstraint(huntableID, avoidWater10);
		rmAddObjectDefConstraint(huntableID, avoidMediumFruits);
		rmAddObjectDefConstraint(huntableID, avoidNugget);
		rmAddObjectDefConstraint(huntableID, avoidCoin);
		rmAddObjectDefConstraint(huntableID, forestConstraint);
		rmAddObjectDefConstraint(huntableID, nativesConstraint);
		rmAddObjectDefConstraint(huntableID, playerConstraint);
		rmAddObjectDefConstraint(huntableID, playerEdgeConstraint);
		rmAddObjectDefConstraint(huntableID, avoidTradeRoute);
		rmAddObjectDefConstraint(huntableID, avoidSocket);
		rmAddObjectDefConstraint(huntableID, avoidKOTH);
		rmAddObjectDefConstraint(huntableID, Northward);
				
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(huntableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(huntableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	}

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE SOUTHERN FOOD:
		int huntable2ID= rmCreateObjectDef("The Southern ypSaiga or ypMuskDeer Herds");

        if ( whichHuntable == 1 )
    {		
		rmAddObjectDefItem(huntable2ID, "Deer", rmRandInt(2,4), 9.0);
	}	
        else
    {		
	    rmAddObjectDefItem(huntable2ID, "Pronghorn", rmRandInt(3,4), 9.0); 
	} 
		
	    rmSetObjectDefCreateHerd(huntable2ID, false);
	    rmSetObjectDefMinDistance(huntable2ID, 0.0);
	    rmSetObjectDefMaxDistance(huntable2ID, rmXFractionToMeters(0.5));
		rmAddObjectDefToClass(huntable2ID, rmClassID("food"));
		
		rmAddObjectDefConstraint(huntable2ID, foodFarConstraint);
		rmAddObjectDefConstraint(huntable2ID, avoidWater10);
		rmAddObjectDefConstraint(huntable2ID, avoidMediumFruits);
		rmAddObjectDefConstraint(huntable2ID, avoidNugget);
		rmAddObjectDefConstraint(huntable2ID, avoidCoin);
		rmAddObjectDefConstraint(huntable2ID, forestConstraint);
		rmAddObjectDefConstraint(huntable2ID, nativesConstraint);
		rmAddObjectDefConstraint(huntable2ID, playerConstraint);
		rmAddObjectDefConstraint(huntable2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(huntable2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(huntable2ID, avoidSocket);
		rmAddObjectDefConstraint(huntable2ID, avoidKOTH);
		rmAddObjectDefConstraint(huntable2ID, Southward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(huntable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(huntable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	}

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.90);
/*================================================================================================================================================*/
// ***************************************************** DEFINE AND PLACE THE COWS HERDS: ******************************************************* //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		int avoidHerdable=rmCreateTypeDistanceConstraint("stuff avoid herdable", "ypWaterBuffalo", 15.0);
		int avoidCloseHerdable=rmCreateTypeDistanceConstraint("close avoid herdable", "ypWaterBuffalo", 10.0);
		int avoidMediumHerdable=rmCreateTypeDistanceConstraint("medium avoid herdable", "ypWaterBuffalo", 35.0);
	    int avoidFarHerdable=rmCreateTypeDistanceConstraint("far avoid herdable", "ypWaterBuffalo", 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN YPYAK HERDS:
		int herdableID= rmCreateObjectDef("The Northern YpYak Herds"); 
	    rmAddObjectDefItem(herdableID, "ypWaterBuffalo", rmRandInt(1,2), 6.0); 
		rmSetObjectDefCreateHerd(herdableID, false);
	    rmSetObjectDefMinDistance(herdableID, 0.0);
	    rmSetObjectDefMaxDistance(herdableID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(herdableID, avoidFarHerdable);
		rmAddObjectDefConstraint(herdableID, foodMediumConstraint);
		rmAddObjectDefConstraint(herdableID, avoidWater10);
		rmAddObjectDefConstraint(herdableID, avoidMediumFruits);
		rmAddObjectDefConstraint(herdableID, avoidNugget);
		rmAddObjectDefConstraint(herdableID, avoidCoin);
		rmAddObjectDefConstraint(herdableID, forestConstraint);
		rmAddObjectDefConstraint(herdableID, nativesConstraint);
		rmAddObjectDefConstraint(herdableID, playerConstraint);
		rmAddObjectDefConstraint(herdableID, playerEdgeConstraint);
		rmAddObjectDefConstraint(herdableID, avoidTradeRoute);
		rmAddObjectDefConstraint(herdableID, avoidSocket);
		rmAddObjectDefConstraint(herdableID, avoidKOTH);
		rmAddObjectDefConstraint(herdableID, Northward);

		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(herdableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*5.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(herdableID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.5);
	}	

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
		// THE SOUTHERN YPYAK HERDS:
		int herdable2ID= rmCreateObjectDef("The Southern YpYak Herds"); 
	    rmAddObjectDefItem(herdable2ID, "ypWaterBuffalo", rmRandInt(1,2), 7.0); 
		rmSetObjectDefCreateHerd(herdable2ID, false);
	    rmSetObjectDefMinDistance(herdable2ID, 0.0);
	    rmSetObjectDefMaxDistance(herdable2ID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(herdable2ID, avoidFarHerdable);
		rmAddObjectDefConstraint(herdable2ID, foodMediumConstraint);
		rmAddObjectDefConstraint(herdable2ID, avoidWater10);
		rmAddObjectDefConstraint(herdable2ID, avoidMediumFruits);
		rmAddObjectDefConstraint(herdable2ID, avoidNugget);
		rmAddObjectDefConstraint(herdable2ID, avoidCoin);
		rmAddObjectDefConstraint(herdable2ID, forestConstraint);
		rmAddObjectDefConstraint(herdable2ID, nativesConstraint);
		rmAddObjectDefConstraint(herdable2ID, playerConstraint);
		rmAddObjectDefConstraint(herdable2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(herdable2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(herdable2ID, avoidSocket);
		rmAddObjectDefConstraint(herdable2ID, avoidKOTH);
		rmAddObjectDefConstraint(herdable2ID, Southward);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(herdable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*5.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(herdable2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.5);
	}	

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.95);
/*================================================================================================================================================*/
// ************************************** PLACE RANDOM FISH EVERYWHERE, BUT RESTRAINED TO AVOID WHALES: ***************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    // CREATE THE FISH CONSTRAINTS:
	    int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", "AbstractFish", 25.0);
        int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 8.0);			
		int fishVsWhaleID=rmCreateTypeDistanceConstraint("fish v whale", "AbstractWhale", 20.0); 
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN FISH 1:
		int fishID=rmCreateObjectDef("The Northern Fish 1");
	    rmAddObjectDefItem(fishID, "ypFishCarp", 3, 9.0);
	    rmSetObjectDefMinDistance(fishID, 0.0);
	    rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.5));
	    rmAddObjectDefConstraint(fishID, fishVsFishID);
	    rmAddObjectDefConstraint(fishID, fishVsWhaleID);
	    rmAddObjectDefConstraint(fishID, fishLand);
		//rmAddObjectDefConstraint(fishID, Northward);
		
		if (cNumberNonGaiaPlayers<=2) 
	    rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 20*cNumberNonGaiaPlayers);
		else
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 10*cNumberNonGaiaPlayers);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
			
		// THE SOUTHERN FISH 1:
		int fish2ID=rmCreateObjectDef("The Southern Fish 1");
	    rmAddObjectDefItem(fish2ID, "ypFishCatfish", 3, 9.0);
	    rmSetObjectDefMinDistance(fish2ID, 0.0);
	    rmSetObjectDefMaxDistance(fish2ID, rmXFractionToMeters(0.5));
	    rmAddObjectDefConstraint(fish2ID, fishVsFishID);
	    rmAddObjectDefConstraint(fish2ID, fishVsWhaleID);
	    rmAddObjectDefConstraint(fish2ID, fishLand);
		//rmAddObjectDefConstraint(fish2ID, Southward);
		
		if (cNumberNonGaiaPlayers<=2) 
	    rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.5, 20*cNumberNonGaiaPlayers);
		else
		rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.5, 10*cNumberNonGaiaPlayers);
		
/*================================================================================================================================================*/
// ************************************************** DEFINE AND PLACE THE WATER NUGGETS: ******************************************************* //
/*================================================================================================================================================*/
/*
        // CREATE THE WATER NUGGET CONSTRAINTS:
		int avoidFarWaterNugget=rmCreateTypeDistanceConstraint("far avoid water nugget", "abstractNugget", 45.0);
        int avoidLand=rmCreateTerrainDistanceConstraint("water nugget avoid land", "Land", true, 10.0); 		
*/  
/*================================================================================================================================================*/        
/*		
		int nugget3= rmCreateObjectDef("The Northern Water Nugget"); 
        rmAddObjectDefItem(nugget3, "ypNuggetBoat", 1, 0.0);
        rmSetNuggetDifficulty(5, 5);
        //rmSetObjectDefMinDistance(nugget3, rmXFractionToMeters(0.0));
		rmSetObjectDefMinDistance(nugget3, 0.0);
        rmSetObjectDefMaxDistance(nugget3, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(nugget3, avoidLand);
        rmAddObjectDefConstraint(nugget3, avoidFarWaterNugget);
		rmAddObjectDefConstraint(nugget3, playerEdgeConstraint);
		rmAddObjectDefConstraint(nugget3, Northward);
		
		if (cNumberNonGaiaPlayers<=2) 
        rmPlaceObjectDefAtLoc(nugget3, 0, 0.5, 0.5, cNumberNonGaiaPlayers*1.5);
        else
		rmPlaceObjectDefAtLoc(nugget3, 0, 0.5, 0.5, cNumberNonGaiaPlayers*0.75);
*/		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",1.00);
/*================================================================================================================================================*/
}
/*================================================================================================================================================*/
// ******************************************************** THIS IS THE END OF THE MAP: ********************************************************* //
/*================================================================================================================================================*/







