/*================================================================================================================*/
// *********************************** THESE ARE THE INFORMATIONS OF THE MAP: *********************************** //
/*================================================================================================================*/

// Serang
// Modified by Pepp from Bayan Kara Ula by Dany
// March 2016

// THE BAYAN KARA ULA:
// CREATED BY DANY:
// FEBRUARY 2008:

/*================================================================================================================*/
// ********************************** MAIN ENTRY POINT FOR RANDOM MAP SCRIPT: *********************************** //   
/*================================================================================================================*/

include "mercenaries.xs";
include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";

void main(void)
{

/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.01);
/*================================================================================================================*/
  
        // THE WHICH VERSION VARIABLE: 
		int whichVersion = rmRandInt(1,2);
		// - if(whichVersion == 1) - 

/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.02);
/*================================================================================================================*/
// ********************************* CHOOSES WHICH NATIVES APPEAR ON THE MAP: *********************************** //
/*================================================================================================================*/
  
        int subCiv0=-1;
        int subCiv1=-1;
        int subCiv2=-1;
		int subCiv3=-1;
		int subCiv4=-1;
	    int subCiv5=-1;
		
/*----------------------------------------------------------------------------------------------------------------*/		

        if (rmAllocateSubCivs(2) == true)
  {
  
		float randomizerl = rmRandFloat(0,1);
  
			if(randomizerl > 0.75) 
			{
				string civalpha = "Kejawen";
				string civdelta = "Pesantren";
			}
			else if (randomizerl > 0.50)
			{
				civalpha = "Pesantren";
				civdelta = "Madura";
			}
			else if (randomizerl > 0.25)
			{
				civalpha = "Matraman";
				civdelta = "Kejawen";
			}
			else
			{
				civalpha = "Madura";
				civdelta = "Matraman";
			}
						
		subCiv0=rmGetCivID(civdelta);
        if (subCiv0 >= 0)
        rmSetSubCiv(0, civdelta);

		subCiv1=rmGetCivID(civalpha);
        if (subCiv1 >= 0)
        rmSetSubCiv(1, civalpha);
		
		subCiv2=rmGetCivID(civalpha);
        if (subCiv2 >= 0)
        rmSetSubCiv(2, civalpha);

		subCiv3=rmGetCivID(civdelta);
        if (subCiv3 >= 0)
        rmSetSubCiv(3, civdelta);
		
		subCiv4=rmGetCivID(civdelta);
        if (subCiv4 >= 0)
        rmSetSubCiv(4, civdelta);
		
		subCiv5=rmGetCivID(civdelta);
        if (subCiv5 >= 0)
        rmSetSubCiv(5, civdelta);
  }
  
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.05);
/*================================================================================================================*/
// ******************************************** PICKS THE MAP SIZE: ********************************************* //
/*================================================================================================================*/
    
	    // THE BASIC MAP STUFF:
	    int playerTiles = 20000;
	    
		if (cNumberNonGaiaPlayers <=2)
		playerTiles = 20000;
	    if (cNumberNonGaiaPlayers >2)
		playerTiles = 22000;

	    int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
	    rmEchoInfo("Map size="+size+"m x "+size+"m");
	    rmSetMapSize(size, size);
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.15);
/*================================================================================================================*/
// ***************************************** DEFINE THE MAP PARAMETERS: ***************************************** //
/*================================================================================================================*/
	    
		// SET MAP ELEVATION PARAMETERS:
		rmSetMapElevationParameters(cElevTurbulence, 0.4, 6, 0.7, 5.0);
	    
		// SET MAP ELEVATION HEIGHT BLEND:
		rmSetMapElevationHeightBlend(1);
	
	    // PICKS A DEFAULT WATER HEIGHT:
	    rmSetSeaLevel(1.0);
	
	    // SET LIGHTING:
		// rmSetLightingSet(lightingType);
		   rmSetLightingSet("great plains");

        // - PICKS DEFAULT TERRAIN AND WATER - :
	    
		// SET SEA TYPE:
		// rmSetSeaType(riverType);
		   rmSetSeaType("Yellow River");
	    
		// SET BASE TERRAIN MIX:
		// rmSetBaseTerrainMix(baseMix);
		   rmSetBaseTerrainMix("texas_grass");
	    
		// TERRAIN INITIALIZATION:
		// rmTerrainInitialize(baseTerrain, 5.0);
		   rmTerrainInitialize("texas\ground4_tex", 5.0);
	    
		// ENABLE LOCAL WATER:
		rmEnableLocalWater(false);
	    
		// SET MAP TYPE:
		// rmSetMapType(mapType1);
		   rmSetMapType("pesisir");
	    // rmSetMapType(mapType2);
		   rmSetMapType("Grass");
	    // rmSetMapType(mapType3);
		   rmSetMapType("water"); // added by me...test... 
	    
		// SET WORLD CIRCLE CONSTRAINT:
		rmSetWorldCircleConstraint(true);
	    
		// SET WIND MAGNITUDE:
		// rmSetWindMagnitude(windSpeed);
		   rmSetWindMagnitude(4.0); // added by me...test... 
        
		// SET GLOBAL RAIN:
		// rmSetGlobalRain(rainChance);
		   rmSetGlobalRain(0.8); // added by me...test... 

	    // CHOOSE MERCS:
		chooseMercs();
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.20);
/*================================================================================================================*/
// ************************* DEFINE SOME CLASSES: THESE ARE USED LATER FOR CONSTRAINTS: ************************* //
/*================================================================================================================*/

        // THE CLASSES:
	    int classPlayer=rmDefineClass("player");
			
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.25);
/*================================================================================================================*/
// ******************************************* DEFINE THE CONSTRAINTS: ****************************************** //
// ************************* THESE ARE USED TO HAVE OBJECTS AND AREAS AVOID EACH OTHER: ************************* //
/*================================================================================================================*/
    
	// MAP EDGE CONSTRAINTS:
	int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, 0, rmGetMapXSize()-18, 0, 0, 0);
	
	// PLAYER CONSTRAINTS:
	int playerConstraint=rmCreateClassDistanceConstraint("stay away from players", rmClassID("player"), 8.0);
	
	// CARDINAL DIRECTIONS:
    int Northward=rmCreatePieConstraint("northMapConstraint", 0.50, 0.50, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(315), rmDegreesToRadians(135));
    int Southward=rmCreatePieConstraint("southMapConstraint", 0.50, 0.50, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(135), rmDegreesToRadians(315));
    int Eastward=rmCreatePieConstraint("eastMapConstraint", 0.50, 0.50, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(45), rmDegreesToRadians(225));
    int Westward=rmCreatePieConstraint("westMapConstraint", 0.50, 0.50, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(225), rmDegreesToRadians(45));
			
	// DECORATION AVOIDANCE:
    int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.30);
/*================================================================================================================*/
// ******************************************* DEFINE SOME OBJECTS: ********************************************* //
// ************************ THESE OBJECTS ARE ALL DEFINED SO THEY CAN BE PLACED LATER: ************************** //	
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.35);
/*================================================================================================================*/
// ************************************ DEFINE AND PLACE THE TRADE ROUTE: *************************************** //  
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/
        
		// TRADE ROUTE AVOIDANCE:
	    int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 6.0);
	    
	    // SOCKETS AVOIDANCE:
	    int avoidSocket=rmCreateTypeDistanceConstraint("stuff vs socket", "SocketTradeRoute", 12.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
		// TRADE ROUTE VARIATIONS:
		int whichTradeRoute=rmRandInt(1,5);
		
		// THE NORTH TRADE ROUTE:
        int tradeRouteID = rmCreateTradeRoute();
        int socketID=rmCreateObjectDef("north trade route");
        rmSetObjectDefTradeRouteID(socketID, tradeRouteID);

        rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
	    rmSetObjectDefAllowOverlap(socketID, true);
        rmSetObjectDefMinDistance(socketID, 0.0);
        rmSetObjectDefMaxDistance(socketID, 8.0);
		
		if ( whichTradeRoute == 1 )
    {
        rmAddTradeRouteWaypoint(tradeRouteID, 0.025, 0.500);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.250, 0.750);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.500);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.750, 0.250);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.980, 0.500);
	}	
        else if ( whichTradeRoute == 2 )
		
	{
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.000, 0.800);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.500);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.800, 0.000);
	}

        else if ( whichTradeRoute == 3 )
		
	{
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.980);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.250, 0.750);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.500);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.750, 0.250);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.025);
	}

        else if ( whichTradeRoute == 4 )
		
	{
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.000, 0.500);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.200, 0.700);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.700);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.600, 0.500);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.500, 0.300);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.800, 0.300);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.980, 0.500);
	}

        else
		
	{
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.300, 0.900);
	    rmAddTradeRouteWaypoint(tradeRouteID, 0.300, 0.500);
		rmAddTradeRouteWaypoint(tradeRouteID, 0.700, 0.500);
        rmAddTradeRouteWaypoint(tradeRouteID, 0.700, 0.020);
	}

     	bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "java");
        if(placedTradeRoute == false)
        rmEchoError("Failed to place trade route"); 
  
        // ADD THE SOCKETS ALONG THE TRADE ROUTE:
		vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.020);
        rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		
		socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.225);
        rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
  
        socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.5);
        rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		
		socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.775);
        rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

        socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, .980);
        rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.40);
/*================================================================================================================*/
// ****************************************** CHECK FOR KOTH GAME MODE: ***************************************** //  
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/

        int avoidKOTH=rmCreateTypeDistanceConstraint("avoid KOTH", "ypKingsHill", 12.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
		if(rmGetIsKOTH()) 
    {
    
        int randLoc = rmRandInt(1,2);
        float xLoc = 0.5;
        float yLoc = 0.5;
        float walk = 0.075;
    
        if(randLoc == 1 || cNumberTeams > 2)
        yLoc = .5;
    
        else
        yLoc = .5;
    
        ypKingsHillPlacer(xLoc, xLoc, walk, avoidSocket);
      	//ypKingsHillPlacer(xLoc, yLoc, walk, 0);
        rmEchoInfo("XLOC = "+xLoc);
        rmEchoInfo("XLOC = "+yLoc);
    }
	
/*================================================================================================================*/
// ********************************** CREATE A CENTER AREA FOR THE TOWNCENTER: ********************************** //
/*================================================================================================================*/

        int classCenter=rmDefineClass("center");
		int centerConstraint=rmCreateClassDistanceConstraint("stuff vs center", rmClassID("center"), 5.0);
	
/*----------------------------------------------------------------------------------------------------------------*/
/*        
		// THE TOWNCENTER CENTER AREA:
        int center2ID=rmCreateArea("center 500");
        rmAddAreaToClass(center2ID, rmClassID("center"));
        rmSetAreaMix(center2ID, "texas_dirt");
		rmSetAreaCoherence(center2ID, 1.0);
		
		rmSetAreaSize(center2ID, rmAreaTilesToFraction(500), rmAreaTilesToFraction(500));
        rmSetAreaLocation(center2ID, 0.625, 0.825);
 		rmBuildArea(center2ID);
*/		
/*----------------------------------------------------------------------------------------------------------------*/
/*		
		// THE TOWNCENTER CENTER AREA:
        int centerID=rmCreateArea("center 250");
        rmAddAreaToClass(centerID, rmClassID("center"));
        rmSetAreaMix(centerID, "rockies_grass");
		rmSetAreaCoherence(centerID, 1.0);
		
		rmSetAreaSize(centerID, rmAreaTilesToFraction(500), rmAreaTilesToFraction(500));
        rmSetAreaLocation(centerID, 0.625, 0.825);
 		rmBuildArea(centerID);
*/	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.45);
/*================================================================================================================*/
// **************************************** SET UP THE PLAYER LOCATIONS: **************************************** //
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/
        
		if(rmRandFloat(0,1) > 0.50)
	{
		rmSetPlacementTeam(0);
		rmPlacePlayersLine(0.625, 0.825, 0.825, 0.625, 0, 0.0);

		rmSetPlacementTeam(1);
		rmPlacePlayersLine(0.375, 0.175, 0.175, 0.375, 0, 0.0);
	}
	    else
	{
		rmSetPlacementTeam(0);
		rmPlacePlayersLine(0.375, 0.175, 0.175, 0.375, 0, 0.0);
	
		rmSetPlacementTeam(1);
		rmPlacePlayersLine(0.625, 0.825, 0.825, 0.625, 0, 0.0);
	}
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.50);
/*================================================================================================================*/
// ******************************************* SET UP THE PLAYER AREAS: ***************************************** //   
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/
		
		float playerFraction=rmAreaTilesToFraction(3250);
		        
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
		//rmSetAreaMinBlobs(id, 1);
        //rmSetAreaMaxBlobs(id, 1);
        
		// SET AREA LOC PLAYER:
		rmSetAreaLocPlayer(id, i);
		
		// ADD AREA CONSTRAINT:
		//rmAddAreaConstraint(id, playerConstraint); 
		
		// SET AREA COHERENCE:
		rmSetAreaCoherence(id, 1.0);
		
		// SET AREA TERRAIN TYPE:
		//rmSetAreaTerrainType(id, "carolina\marshflats");
		
		// SET AREA TERRAIN TYPE:
		//rmSetAreaTerrainType(id, "texas\ground2");

		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_snow");
		
		// SET AREA MIX:
		//rmSetAreaMix(id, "texas_dirt");
		
		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_grass");
	    
		// SET AREA BASE HEIGHT:
		//rmSetAreaBaseHeight(id, 18.0);
      
	    // SET AREA WARN FAILURE:
		rmSetAreaWarnFailure(id, false);
   }
   
        // BUILD THE AREAS:
        rmBuildAllAreas(); 
		
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.55);
/*================================================================================================================*/
// *************************************** DEFINE AND PLACE THE NATIVES: **************************************** //
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/

        // NATIVE TRIBES VARIATIONS:
		int whichNatives=rmRandInt(1,2);
		
		int nativesClass=rmDefineClass("natives");
		int nativesConstraint=rmCreateClassDistanceConstraint("stuff vs natives", rmClassID("natives"), 5.0);
		int importantItemClass=rmDefineClass("importantItem");
		int importantItemConstraint=rmCreateClassDistanceConstraint("stuff vs importantItem", rmClassID("importantItem"), 15.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
	
		int zenVillageAID = -1;
		if (subCiv1 == rmGetCivID("Pesantren"))
		{  
			zenVillageAID = rmCreateGrouping("Tupi village Top Communist", "Pesantren_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Kejawen"))
		{  
			zenVillageAID = rmCreateGrouping("Carib village Top Communist", "Kejawen_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Matraman"))
		{  
			zenVillageAID = rmCreateGrouping("Zapotec village Top Communist", "Matraman_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Madura"))
		{  
			zenVillageAID = rmCreateGrouping("Maya village Top Communist", "Madura_"+rmRandInt(1,5));
		}
		rmSetGroupingMinDistance(zenVillageAID, 0.0);
		rmSetGroupingMaxDistance(zenVillageAID, 0.0);
		rmAddGroupingToClass(zenVillageAID, rmClassID("natives"));
		rmAddGroupingToClass(zenVillageAID, rmClassID("importantItem"));
		//rmAddGroupingConstraint(zenVillageAID, avoidNatives);
		
		if ( whichNatives == 1 )
		rmPlaceGroupingAtLoc(zenVillageAID, 0, 0.4, 0.8);
		else
		rmPlaceGroupingAtLoc(zenVillageAID, 0, 0.8, 0.4);



		int ShaolinvillageBID = -1;
		if (subCiv1 == rmGetCivID("Pesantren"))
		{  
			ShaolinvillageBID = rmCreateGrouping("Tupi village Top Left", "Pesantren_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Kejawen"))
		{  
			ShaolinvillageBID = rmCreateGrouping("Carib village Top Left", "Kejawen_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Matraman"))
		{  
			ShaolinvillageBID = rmCreateGrouping("Zapotec village Top Left", "Matraman_"+rmRandInt(1,5));
		}
		else if (subCiv1 == rmGetCivID("Madura"))
		{  
			ShaolinvillageBID = rmCreateGrouping("Maya village Top Left", "Madura_"+rmRandInt(1,5));
		}
		rmSetGroupingMinDistance(ShaolinvillageBID, 0.0);
		rmSetGroupingMaxDistance(ShaolinvillageBID, 0.0);
		rmAddGroupingToClass(ShaolinvillageBID, rmClassID("natives"));
		rmAddGroupingToClass(ShaolinvillageBID, rmClassID("importantItem"));
		//rmAddGroupingConstraint(ShaolinvillageBID, avoidNatives);
		
		if ( whichNatives == 1 )
		rmPlaceGroupingAtLoc(ShaolinvillageBID, 0, 0.6, 0.2);
		else
		rmPlaceGroupingAtLoc(ShaolinvillageBID, 0, 0.2, 0.6);

	
/*----------------------------------------------------------------------------------------------------------------*/

        if (cNumberNonGaiaPlayers <=2)
{		
	    
		int zenvillageEID = -1;
		if (subCiv0 == rmGetCivID("Pesantren"))
		{  
			zenvillageEID = rmCreateGrouping("Tupi village Top Lady", "Pesantren_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Kejawen"))
		{  
			zenvillageEID = rmCreateGrouping("Carib village Top Lady", "Kejawen_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Matraman"))
		{  
			zenvillageEID = rmCreateGrouping("Zapotec village Top Lady", "Matraman_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Madura"))
		{  
			zenvillageEID = rmCreateGrouping("Maya village Top Lady", "Madura_"+rmRandInt(1,5));
		}
		rmSetGroupingMinDistance(zenvillageEID, 0.0);
		rmSetGroupingMaxDistance(zenvillageEID, 20.0);
		rmAddGroupingToClass(zenvillageEID, rmClassID("natives"));
		rmAddGroupingToClass(zenvillageEID, rmClassID("importantItem"));
		//rmAddGroupingConstraint(zenvillageEID, avoidNatives);
		rmPlaceGroupingAtLoc(zenvillageEID, 0, 0.825, 0.625);

	

		int ShaolinvillageFID = -1;
		if (subCiv0 == rmGetCivID("Pesantren"))
		{  
			ShaolinvillageFID = rmCreateGrouping("Tupi village Top Lord", "Pesantren_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Kejawen"))
		{  
			ShaolinvillageFID = rmCreateGrouping("Carib village Top Lord", "Kejawen_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Matraman"))
		{  
			ShaolinvillageFID = rmCreateGrouping("Zapotec village Top Lord", "Matraman_"+rmRandInt(1,5));
		}
		else if (subCiv0 == rmGetCivID("Madura"))
		{  
			ShaolinvillageFID = rmCreateGrouping("Maya village Top Lord", "Madura_"+rmRandInt(1,5));
		}
		rmSetGroupingMinDistance(ShaolinvillageFID, 0.0);
		rmSetGroupingMaxDistance(ShaolinvillageFID, 20.0);
		rmAddGroupingToClass(ShaolinvillageFID, rmClassID("natives"));
		rmAddGroupingToClass(ShaolinvillageFID, rmClassID("importantItem"));
		//rmAddGroupingConstraint(ShaolinvillageFID, avoidNatives);
		rmPlaceGroupingAtLoc(ShaolinvillageFID, 0, 0.175, 0.375);
		
}
		
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.60);
/*================================================================================================================*/
// ************************************** DEFINE AND PLACE SOME CLIFFS: ***************************************** //
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/

   		// CLIFF AVOIDANCE:
		int classCliff=rmDefineClass("cliff");
		int cliffConstraint=rmCreateClassDistanceConstraint("stuff vs. cliff", rmClassID("cliff"), 5.0);
		int cliffMediumConstraint=rmCreateClassDistanceConstraint("medium vs. cliff", rmClassID("cliff"), 15.0);
		int cliffFarConstraint=rmCreateClassDistanceConstraint("far vs. cliff", rmClassID("cliff"), 40.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
		int numTries=-1;
		   
		if (cNumberNonGaiaPlayers <=2)
		numTries=3.0*cNumberNonGaiaPlayers;
	    else
		numTries=1.5*cNumberNonGaiaPlayers;
		
/*----------------------------------------------------------------------------------------------------------------*/		
   
        for(i=0; <numTries)
   {
        int cliffID=rmCreateArea("cliff"+i);
        rmSetAreaSize(cliffID, rmAreaTilesToFraction(750), rmAreaTilesToFraction(750));
        rmSetAreaWarnFailure(cliffID, false);
	     rmSetAreaCliffType(cliffID, "Texas Grass");
		   //rmSetAreaCliffType(cliffID, "Patagonia");
	    rmSetAreaCliffEdge(cliffID, 1, 0.6, 0.8, 1.0, 0);
        //rmSetAreaCliffEdge(cliffID, 1, 0.6, 0.1, 1.0, 0);
	    //rmSetAreaCliffEdge(cliffID, 1, 1);
        rmSetAreaCliffPainting(cliffID, false, true, true, 1.5, true);
        rmSetAreaCliffHeight(cliffID, 5, 2.0, 0.5);
        rmSetAreaHeightBlend(cliffID, 1);
        rmAddAreaToClass(cliffID, rmClassID("cliff")); 
        
		rmAddAreaConstraint(cliffID, playerEdgeConstraint);
        rmAddAreaConstraint(cliffID, cliffFarConstraint);
	    rmAddAreaConstraint(cliffID, playerConstraint);
        rmAddAreaConstraint(cliffID, avoidKOTH);
        rmAddAreaConstraint(cliffID, avoidTradeRoute);
		rmAddAreaConstraint(cliffID, avoidSocket);
	    rmAddAreaConstraint(cliffID, Northward);
	    rmAddAreaConstraint(cliffID, nativesConstraint);
        
		rmSetAreaMinBlobs(cliffID, 4);
        rmSetAreaMaxBlobs(cliffID, 6);
        rmSetAreaMinBlobDistance(cliffID, 16.0);
        rmSetAreaMaxBlobDistance(cliffID, 30.0);
        rmSetAreaSmoothDistance(cliffID, 10);
        rmSetAreaCoherence(cliffID, 0.75);
        rmBuildArea(cliffID);
   } 
   
/*----------------------------------------------------------------------------------------------------------------*/

        for(i=0; <numTries)
   {
        int cliff2ID=rmCreateArea("cliff 2"+i);
        rmSetAreaSize(cliff2ID, rmAreaTilesToFraction(750), rmAreaTilesToFraction(750));
        rmSetAreaWarnFailure(cliff2ID, false);
	     rmSetAreaCliffType(cliff2ID, "Texas Grass");
		   //rmSetAreaCliffType(cliff2ID, "Patagonia");
	    rmSetAreaCliffEdge(cliff2ID, 1, 0.6, 0.8, 1.0, 0);
        //rmSetAreaCliffEdge(cliff2ID, 1, 0.6, 0.1, 1.0, 0);
	    //rmSetAreaCliffEdge(cliff2ID, 1, 1);
        rmSetAreaCliffPainting(cliff2ID, false, true, true, 1.5, true);
        rmSetAreaCliffHeight(cliff2ID, 5, 2.0, 0.5);
        rmSetAreaHeightBlend(cliff2ID, 1);
        rmAddAreaToClass(cliff2ID, rmClassID("cliff")); 
        
		rmAddAreaConstraint(cliff2ID, playerEdgeConstraint);
        rmAddAreaConstraint(cliff2ID, cliffFarConstraint);
	    rmAddAreaConstraint(cliff2ID, playerConstraint);
        rmAddAreaConstraint(cliff2ID, avoidKOTH);
        rmAddAreaConstraint(cliff2ID, avoidTradeRoute);
		rmAddAreaConstraint(cliff2ID, avoidSocket);
	    rmAddAreaConstraint(cliff2ID, Southward);
	    rmAddAreaConstraint(cliff2ID, nativesConstraint);
        
		rmSetAreaMinBlobs(cliff2ID, 4);
        rmSetAreaMaxBlobs(cliff2ID, 6);
        rmSetAreaMinBlobDistance(cliff2ID, 16.0);
        rmSetAreaMaxBlobDistance(cliff2ID, 30.0);
        rmSetAreaSmoothDistance(cliff2ID, 10);
        rmSetAreaCoherence(cliff2ID, 0.75);
        rmBuildArea(cliff2ID);
   }    
   
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.65);
/*================================================================================================================*/
// ************************* DEFINE THE STARTING TCID AND STARTING UNITS AND RESOURCES: ************************* //  
/*================================================================================================================*/
  
    // THE CLASS RESOURCE:
	int classResource=rmDefineClass("resource");
		
	// RESOURCE CONSTRAINTS:
	int resourceConstraint=rmCreateClassDistanceConstraint("stuff vs resource", rmClassID("resource"), 8.0);
	
	// THE CLASS TREE:
	int classTree=rmDefineClass("tree");
	
	// TREE CONSTRAINTS:
	int treeConstraint=rmCreateClassDistanceConstraint("stuff vs tree", rmClassID("tree"), 8.0);
	int treeMediumConstraint=rmCreateClassDistanceConstraint("medium vs tree", rmClassID("tree"), 17.5);
	
	// NUGGET CONSTRAINTS:
	int nuggetConstraint=rmCreateTypeDistanceConstraint("stuff vs nugget", "AbstractNugget", 1.0);
	int nuggetMediumConstraint=rmCreateTypeDistanceConstraint("medium vs nugget", "AbstractNugget", 15.0);
	int nuggetFarConstraint=rmCreateTypeDistanceConstraint("far vs nugget", "AbstractNugget", 20.0);
	
	// FRUITS AVOIDANCE:
	int fruitsConstraint=rmCreateTypeDistanceConstraint("stuff vs fruits", "Deer", 5.0);
	int fruitsMediumConstraint=rmCreateTypeDistanceConstraint("medium vs fruits", "Deer", 15.0);
	int fruitsFarConstraint=rmCreateTypeDistanceConstraint("far vs fruits", "Deer", 20.0);
	
	// COIN AVOIDANCE:
	int coinConstraint=rmCreateTypeDistanceConstraint("stuff vs coin", "Gold", 5.0);
	int coinMediumConstraint=rmCreateTypeDistanceConstraint("medium vs coin", "Gold", 15.0);
	int coinFarConstraint=rmCreateTypeDistanceConstraint("far vs coin", "Gold", 20.0);
		
/*----------------------------------------------------------------------------------------------------------------*/	    
		
		// DEFINE THE STARTING TCID:
        
        int TCID= rmCreateObjectDef("startingTC");
  
	    if (rmGetNomadStart())
	{
        rmAddObjectDefItem(TCID, "CoveredWagon", 1, 5.0);
    }
        else	
	{
        rmAddObjectDefItem(TCID, "townCenter", 1, 5.0);
    }
    	    
		rmSetObjectDefMinDistance(TCID, 0.0);
	    rmSetObjectDefMaxDistance(TCID, 0.0);
		rmAddObjectDefToClass(TCID, rmClassID("player"));
		rmAddObjectDefToClass(TCID, rmClassID("resource"));
	    //rmAddObjectDefConstraint(TCID, resourceConstraint);


/*----------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE THE STARTING UNITS:
		int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
		rmAddObjectDefToClass(startingUnits, rmClassID("resource"));
	    rmSetObjectDefMinDistance(startingUnits, 5.0);
        rmSetObjectDefMaxDistance(startingUnits, 15.0);
	    //rmAddObjectDefConstraint(startingUnits, avoidAll);
	    rmAddObjectDefConstraint(startingUnits, resourceConstraint);
	    //rmAddObjectDefConstraint(startingUnits, avoidImpassableLand);
	    //rmAddObjectDefConstraint(startingUnits, avoidWater);
		
/*----------------------------------------------------------------------------------------------------------------*/

        int playerCrateID=rmCreateObjectDef("bonus starting crates");
        rmAddObjectDefItem(playerCrateID, "crateOfFood", 0, 0.0);
        rmAddObjectDefItem(playerCrateID, "crateOfWood", 0, 0.0);
        rmAddObjectDefItem(playerCrateID, "crateOfCoin", 0, 0.0);
		rmAddObjectDefToClass(playerCrateID, rmClassID("resource"));
        rmSetObjectDefMinDistance(playerCrateID, 5);
        rmSetObjectDefMaxDistance(playerCrateID, 15);
	    //rmAddObjectDefConstraint(playerCrateID, avoidAll);
        rmAddObjectDefConstraint(playerCrateID, resourceConstraint);			
		
/*----------------------------------------------------------------------------------------------------------------*/  
        
        // DEFINE THE START BERRIES:
  	    int StartBerriesID=rmCreateObjectDef("starting berries");
	    rmAddObjectDefItem(StartBerriesID, "SCricket", 4, 5.0);
		rmAddObjectDefToClass(StartBerriesID, rmClassID("resource"));
	    rmSetObjectDefMinDistance(StartBerriesID, 15);
	    rmSetObjectDefMaxDistance(StartBerriesID, 25);
	    rmAddObjectDefConstraint(StartBerriesID, resourceConstraint);
	    rmAddObjectDefConstraint(StartBerriesID, fruitsMediumConstraint);
	    //rmAddObjectDefConstraint(StartBerriesID, avoidNatives);
	    //rmAddObjectDefConstraint(StartBerriesID, avoidTradeRoute);
		
/*----------------------------------------------------------------------------------------------------------------*/

        // DEFINE THE START SILVER:
		int startSilverID = rmCreateObjectDef("player silver");
	    rmAddObjectDefItem(startSilverID, "SKapuk", 3, 3.0);
		rmAddObjectDefToClass(startSilverID, rmClassID("resource"));
	    rmSetObjectDefMinDistance(startSilverID, 15.0);
	    rmSetObjectDefMaxDistance(startSilverID, 25.0);
	    //rmAddObjectDefConstraint(startSilverID, avoidAll);
	    rmAddObjectDefConstraint(startSilverID, resourceConstraint);
        rmAddObjectDefConstraint(startSilverID, coinMediumConstraint);
		
/*----------------------------------------------------------------------------------------------------------------*/		
        
		// THE STARTING DEER HERDS:
		int startYpIbexID=rmCreateObjectDef("The Starting YpIbex Herds");
	    rmAddObjectDefItem(startYpIbexID, "Pronghorn", 7, 5.0);
		rmAddObjectDefToClass(startYpIbexID, rmClassID("resource"));
	    rmSetObjectDefMinDistance(startYpIbexID, 15.0);
	    rmSetObjectDefMaxDistance(startYpIbexID, 25.0);
	    rmSetObjectDefCreateHerd(startYpIbexID, false);
		rmAddObjectDefConstraint(startYpIbexID, resourceConstraint);

/*----------------------------------------------------------------------------------------------------------------*/		
        
		int playerNuggetID=rmCreateObjectDef("player nugget");
        rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
		rmAddObjectDefToClass(playerNuggetID, rmClassID("resource"));
        rmSetObjectDefMinDistance(playerNuggetID, 20.0);
        rmSetObjectDefMaxDistance(playerNuggetID, 30.0);
        //rmAddObjectDefConstraint(playerNuggetID, avoidAll);
        rmAddObjectDefConstraint(playerNuggetID, resourceConstraint);
		rmAddObjectDefConstraint(playerNuggetID, nuggetMediumConstraint);

/*----------------------------------------------------------------------------------------------------------------*/

        int StartAreaTreeID=rmCreateObjectDef("starting trees");
	    // rmAddObjectDefItem(StartAreaTreeID, startTreeType, 12, 8.0);
		   rmAddObjectDefItem(StartAreaTreeID, "STreePakisHaji", 12, 6.0);
		rmAddObjectDefToClass(StartAreaTreeID, rmClassID("resource"));
		rmAddObjectDefToClass(StartAreaTreeID, rmClassID("tree"));
	    rmSetObjectDefMinDistance(StartAreaTreeID, 32);
	    rmSetObjectDefMaxDistance(StartAreaTreeID, 40);
	    rmAddObjectDefConstraint(StartAreaTreeID, resourceConstraint);
	    rmAddObjectDefConstraint(StartAreaTreeID, treeMediumConstraint);
	    //rmAddObjectDefConstraint(StartAreaTreeID, avoidTradeRoute);
	    //rmAddObjectDefConstraint(StartAreaTreeID, avoidNatives);

/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.70);
/*================================================================================================================*/    
// ************************* PLACE THE STARTING TCID AND STARTING UNITS AND RESOURCES: ************************** //
/*================================================================================================================*/  
 
	    for(i=1; < cNumberPlayers) 
	{
		// PLACE THE STARTING TCID:
		
		rmPlaceObjectDefAtLoc(TCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
        // PLACE THE STARTING UNITS:
		//rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

        //rmPlaceObjectDefAtLoc(TCID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
		vector TCLoc = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, i));				
		rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
				
		
/*----------------------------------------------------------------------------------------------------------------*/

        // NOMAD:
		if(ypIsAsian(i) && rmGetNomadStart() == false)
        rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i, 1), i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		// PLACE THE PLAYER CRATES:
		rmPlaceObjectDefAtLoc(playerCrateID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
		
		// PLACE THE START BERRIES:
		rmPlaceObjectDefAtLoc(StartBerriesID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
		rmPlaceObjectDefAtLoc(StartBerriesID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

        // PLACE THE START SILVER:
		rmPlaceObjectDefAtLoc(startSilverID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
	    rmPlaceObjectDefAtLoc(startSilverID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
			
		
		// PLACE THE START DEER:
		rmPlaceObjectDefAtLoc(startYpIbexID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
		
		// PLACE THE PLAYER NUGGET:
		rmSetNuggetDifficulty(1, 1);
        rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmSetNuggetDifficulty(2, 2);
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
      
	    // PLACE THE START TREES:
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
        rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i)); 
	}
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.75);
/*================================================================================================================*/   	
// **************************************** DEFINE AND PLACE THE FORESTS: *************************************** //
/*================================================================================================================*/
// NONE FOR NOW:
/*----------------------------------------------------------------------------------------------------------------*/

	    int forestClass=rmDefineClass("classForest");
		int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 15.0);
	    int forestMediumConstraint=rmCreateClassDistanceConstraint("medium vs. forest", rmClassID("classForest"), 20.0);
	
	    //int numTries = -1;
	    int failCount = -1; 
/*----------------------------------------------------------------------------------------------------------------*/
		
		int forestTreeID = 0;

	    if (cNumberNonGaiaPlayers <=2)
		numTries=8*cNumberNonGaiaPlayers;
	    else
		numTries=4*cNumberNonGaiaPlayers;
	    
		failCount=0;
		
/*----------------------------------------------------------------------------------------------------------------*/		
	    
		// THE NORTHERN FORESTS:
		for (i=0; <numTries)
{   
		int forestID=rmCreateArea("forestID"+i);
		rmSetAreaWarnFailure(forestID, false);
		
		if(rmRandFloat(0,1) > 0.50)
	{	
		rmSetAreaSize(forestID, rmAreaTilesToFraction(225), rmAreaTilesToFraction(350));
	}	
		else
	{	
		rmSetAreaSize(forestID, rmAreaTilesToFraction(325), rmAreaTilesToFraction(450));
	}	
		// rmSetAreaForestType(forestID, forestType1);
		   rmSetAreaForestType(forestID, "Jawa Bamboo Forest");
		
		rmSetAreaForestDensity(forestID, 0.9);
		rmSetAreaForestClumpiness(forestID, 0.7);		
		rmSetAreaForestUnderbrush(forestID, 0.6);
		
		rmSetAreaMinBlobs(forestID, 1);
		rmSetAreaMaxBlobs(forestID, 4);						
		rmSetAreaMinBlobDistance(forestID, 5.0);
		rmSetAreaMaxBlobDistance(forestID, 20.0);
		
		rmSetAreaCoherence(forestID, 0.4);
		rmSetAreaSmoothDistance(forestID, 10);
		rmAddAreaToClass(forestID, rmClassID("classForest"));
			
		rmAddAreaConstraint(forestID, forestConstraint);  
		rmAddAreaConstraint(forestID, nativesConstraint);
		rmAddAreaConstraint(forestID, playerConstraint);
		rmAddAreaConstraint(forestID, playerEdgeConstraint);
		rmAddAreaConstraint(forestID, avoidAll);
		rmAddAreaConstraint(forestID, avoidKOTH);
		rmAddAreaConstraint(forestID, Northward);
		rmAddAreaConstraint(forestID, avoidTradeRoute);
		rmAddAreaConstraint(forestID, avoidSocket);
		rmAddAreaConstraint(forestID, cliffConstraint);
					
		if(rmBuildArea(forestID)==false)
	{
		// Stop trying once we fail 5 times in a row.
		failCount++;
		if(failCount==10)
		break;
	}
		else
		failCount=0; 
}

/*----------------------------------------------------------------------------------------------------------------*/

        // THE SOUTHERN FORESTS:
		for (i=0; <numTries)
{   
		int forest2ID=rmCreateArea("forestID 2"+i);
		rmSetAreaWarnFailure(forest2ID, false);
		
		if(rmRandFloat(0,1) > 0.50)
	{	
		rmSetAreaSize(forest2ID, rmAreaTilesToFraction(375), rmAreaTilesToFraction(475));
	}	
		else
	{	
		rmSetAreaSize(forest2ID, rmAreaTilesToFraction(325), rmAreaTilesToFraction(425));
	}	
				
		// rmSetAreaForestType(forestID2, forestType2);
		   rmSetAreaForestType(forest2ID, "Jawa Lowland Forest");
		
		rmSetAreaForestDensity(forest2ID, 0.9);
		rmSetAreaForestClumpiness(forest2ID, 0.7);		
		rmSetAreaForestUnderbrush(forest2ID, 0.6);
		
		rmSetAreaMinBlobs(forest2ID, 1);
		rmSetAreaMaxBlobs(forest2ID, 4);						
		rmSetAreaMinBlobDistance(forest2ID, 5.0);
		rmSetAreaMaxBlobDistance(forest2ID, 20.0);
		
		rmSetAreaCoherence(forest2ID, 0.4);
		rmSetAreaSmoothDistance(forest2ID, 10);
		rmAddAreaToClass(forest2ID, rmClassID("classForest"));
			
		rmAddAreaConstraint(forest2ID, forestConstraint);  
		rmAddAreaConstraint(forest2ID, nativesConstraint);
		rmAddAreaConstraint(forest2ID, playerConstraint);
		rmAddAreaConstraint(forest2ID, playerEdgeConstraint);
		rmAddAreaConstraint(forest2ID, avoidAll);
		rmAddAreaConstraint(forest2ID, avoidKOTH);
		rmAddAreaConstraint(forest2ID, Southward);
		rmAddAreaConstraint(forest2ID, avoidTradeRoute);
		rmAddAreaConstraint(forest2ID, avoidSocket);
		rmAddAreaConstraint(forest2ID, cliffConstraint);
			
		if(rmBuildArea(forest2ID)==false)
	{
		// Stop trying once we fail 5 times in a row.
		failCount++;
		if(failCount==10)
		break;
	}
		else
		failCount=0; 
}
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.80);
/*================================================================================================================*/
// ************************************* DEFINE AND PLACE SOME RANDOM GOLD: ************************************* //
/*================================================================================================================*/
	
		// GOLD MINES CONSTRAINTS:
	    int goldConstraint=rmCreateTypeDistanceConstraint("the stuff vs gold", "Gold", 5.0);
		int goldMediumConstraint=rmCreateTypeDistanceConstraint("The medium vs gold", "Gold", 10.0);
	    int goldFarConstraint=rmCreateTypeDistanceConstraint("the far vs gold", "Gold", 20.0);
		
/*----------------------------------------------------------------------------------------------------------------*/
		
		// THE RANDOM NORTHERN GOLD:
		int goldID = rmCreateObjectDef("The Northern Random Gold");
	    rmAddObjectDefItem(goldID, "SKapuk", 3, 3.0);
	    rmSetObjectDefMinDistance(goldID, 5.0);
	    rmSetObjectDefMaxDistance(goldID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(goldID, goldFarConstraint);
		rmAddObjectDefConstraint(goldID, avoidAll);
		rmAddObjectDefConstraint(goldID, avoidKOTH);
		rmAddObjectDefConstraint(goldID, avoidTradeRoute);
		rmAddObjectDefConstraint(goldID, avoidSocket);
		rmAddObjectDefConstraint(goldID, forestConstraint);
		rmAddObjectDefConstraint(goldID, nativesConstraint);
		rmAddObjectDefConstraint(goldID, playerConstraint);
		rmAddObjectDefConstraint(goldID, playerEdgeConstraint);
		rmAddObjectDefConstraint(goldID, cliffConstraint);
		rmAddObjectDefConstraint(goldID, Northward);
	
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(goldID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6.0);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(goldID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
    } 
	
/*----------------------------------------------------------------------------------------------------------------*/
        
		// THE RANDOM SOUTHERN GOLD:
		int gold2ID = rmCreateObjectDef("The Southern Random Gold");
	    rmAddObjectDefItem(gold2ID, "SKapuk", 3, 3.0);
	    rmSetObjectDefMinDistance(gold2ID, 5.0);
	    rmSetObjectDefMaxDistance(gold2ID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(gold2ID, goldFarConstraint);
		rmAddObjectDefConstraint(gold2ID, avoidAll);
		rmAddObjectDefConstraint(gold2ID, avoidKOTH);
		rmAddObjectDefConstraint(gold2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(gold2ID, avoidSocket);
		rmAddObjectDefConstraint(gold2ID, forestConstraint);
		rmAddObjectDefConstraint(gold2ID, nativesConstraint);
		rmAddObjectDefConstraint(gold2ID, playerConstraint);
		rmAddObjectDefConstraint(gold2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(gold2ID, cliffConstraint);
		rmAddObjectDefConstraint(gold2ID, Southward);
	
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(gold2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6.0);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(gold2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
    }

/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.825);
/*================================================================================================================*/
// ************************************ DEFINE AND PLACE THE LAND NUGGETS: ************************************** //
/*================================================================================================================*/

	    // NUGGET CONSTRAINTS:
	    //int nuggetConstraint=rmCreateTypeDistanceConstraint("the stuff vs nugget", "AbstractNugget", 15.0);
		//int nuggetMediumConstraint=rmCreateTypeDistanceConstraint("The medium vs nugget", "AbstractNugget", 25.0);
	    //int nuggetFarConstraint=rmCreateTypeDistanceConstraint("the far vs nugget", "AbstractNugget", 65.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN EASY NUGGETS:
	    int nugget1= rmCreateObjectDef("The Northern Easy Nugget"); 
	    rmAddObjectDefItem(nugget1, "Nugget", 1, 0.0);
	    rmSetNuggetDifficulty(1, 3);
	    rmSetObjectDefMinDistance(nugget1, 0.0);
	    rmSetObjectDefMaxDistance(nugget1, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(nugget1, nuggetFarConstraint);
		rmAddObjectDefConstraint(nugget1, avoidAll);
		rmAddObjectDefConstraint(nugget1, Northward);
		rmAddObjectDefConstraint(nugget1, forestConstraint);
		rmAddObjectDefConstraint(nugget1, goldConstraint);
		rmAddObjectDefConstraint(nugget1, avoidTradeRoute);
	    rmAddObjectDefConstraint(nugget1, cliffConstraint);
	    rmAddObjectDefConstraint(nugget1, nativesConstraint);
        rmAddObjectDefConstraint(nugget1, playerConstraint);
		rmAddObjectDefConstraint(nugget1, playerEdgeConstraint);
		rmAddObjectDefConstraint(nugget1, avoidKOTH);
		rmAddObjectDefConstraint(nugget1, avoidSocket);
				   
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(nugget1, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6);
	}
        else
	{
        rmPlaceObjectDefAtLoc(nugget1, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);
	}

/*----------------------------------------------------------------------------------------------------------------*/

        // THE SOUTHERN EASY NUGGETS:
	    int nugget2= rmCreateObjectDef("The southern Easy Nugget"); 
	    rmAddObjectDefItem(nugget2, "Nugget", 1, 0.0);
	    rmSetNuggetDifficulty(1, 3);
	    rmSetObjectDefMinDistance(nugget2, 0.0);
	    rmSetObjectDefMaxDistance(nugget2, rmXFractionToMeters(0.5));
	    				
		rmAddObjectDefConstraint(nugget2, nuggetFarConstraint);
		rmAddObjectDefConstraint(nugget2, avoidAll);
		rmAddObjectDefConstraint(nugget2, Southward);
		rmAddObjectDefConstraint(nugget2, forestConstraint);
		rmAddObjectDefConstraint(nugget2, goldConstraint);
		rmAddObjectDefConstraint(nugget2, avoidTradeRoute);
	    rmAddObjectDefConstraint(nugget2, cliffConstraint);
	    rmAddObjectDefConstraint(nugget2, nativesConstraint);
        rmAddObjectDefConstraint(nugget2, playerConstraint);
		rmAddObjectDefConstraint(nugget2, playerEdgeConstraint);
		rmAddObjectDefConstraint(nugget2, avoidKOTH);
		rmAddObjectDefConstraint(nugget2, avoidSocket);
		   
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(nugget2, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6);
	}
        else
	{
        rmPlaceObjectDefAtLoc(nugget2, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);
	}
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.85);
/*================================================================================================================*/
// ************************************* DEFINE AND PLACE THE DEER HERDS: *************************************** //
/*================================================================================================================*/

        // YPIBEX CONSTRAINTS:
	    int ypIbexConstraint=rmCreateTypeDistanceConstraint("stuff vs ypIbex", "Pronghorn", 5.0);
		int ypIbexMediumConstraint=rmCreateTypeDistanceConstraint("medium vs ypIbex", "Pronghorn", 15.0);
	    int ypIbexFarConstraint=rmCreateTypeDistanceConstraint("far vs ypIbex", "Pronghorn", 75.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
	    		
		// THE NORTHERN YPIBEX HERDS:
        int ypIbexID=rmCreateObjectDef("The Northern YpIbex Herds");
	    rmAddObjectDefItem(ypIbexID, "Pronghorn", rmRandInt(3,5), 6.0);
	    rmSetObjectDefMinDistance(ypIbexID, 0.0);
	    rmSetObjectDefMaxDistance(ypIbexID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(ypIbexID, ypIbexFarConstraint);
		rmAddObjectDefConstraint(ypIbexID, goldConstraint);
		rmAddObjectDefConstraint(ypIbexID, avoidAll);
		rmAddObjectDefConstraint(ypIbexID, avoidTradeRoute);
		rmAddObjectDefConstraint(ypIbexID, avoidSocket);
	    rmAddObjectDefConstraint(ypIbexID, nativesConstraint);
		rmAddObjectDefConstraint(ypIbexID, nuggetConstraint);
		rmAddObjectDefConstraint(ypIbexID, playerConstraint);
		rmAddObjectDefConstraint(ypIbexID, playerEdgeConstraint);
		rmAddObjectDefConstraint(ypIbexID, cliffConstraint);
		rmAddObjectDefConstraint(ypIbexID, Northward);
		rmAddObjectDefConstraint(ypIbexID, avoidKOTH);
			
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(ypIbexID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(ypIbexID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);
    }	
	
/*----------------------------------------------------------------------------------------------------------------*/

	    // THE SOUTHERN YPIBEX HERDS:
        int ypIbex2ID=rmCreateObjectDef("The Southern YpIbex Herds");
	    rmAddObjectDefItem(ypIbex2ID, "Pronghorn", rmRandInt(3,5), 6.0);
	    rmSetObjectDefMinDistance(ypIbex2ID, 0.0);
	    rmSetObjectDefMaxDistance(ypIbex2ID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(ypIbex2ID, ypIbexFarConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, goldConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, avoidAll);
		rmAddObjectDefConstraint(ypIbex2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(ypIbex2ID, avoidSocket);
	    rmAddObjectDefConstraint(ypIbex2ID, nativesConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, nuggetConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, playerConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, cliffConstraint);
		rmAddObjectDefConstraint(ypIbex2ID, Southward);
		rmAddObjectDefConstraint(ypIbex2ID, avoidKOTH);
			
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(ypIbex2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(ypIbex2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);
    }
	
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.875);
/*================================================================================================================*/
// *************************************** DEFINE AND PLACE THE BERRIES: **************************************** //        
/*================================================================================================================*/

		// FRUITS CONSTRAINTS:
	    //int fruitsConstraint=rmCreateTypeDistanceConstraint("the stuff vs fruits", "AbstractFruit", 15.0);
		//int fruitsMediumConstraint=rmCreateTypeDistanceConstraint("the medium vs fruits", "AbstractFruit", 40.0);
	    //int fruitsFarConstraint=rmCreateTypeDistanceConstraint("the far vs fruits", "AbstractFruit", 65.0);
		
/*----------------------------------------------------------------------------------------------------------------*/		
		
		// THE NORTHERN BERRIES:
		int berriesID=rmCreateObjectDef("The Northern Berries");
	    rmAddObjectDefItem(berriesID, "Deer", rmRandInt(2,4), 5.0); 
	    rmSetObjectDefMinDistance(berriesID, 0.0);
	    rmSetObjectDefMaxDistance(berriesID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(berriesID, fruitsFarConstraint);
	    rmAddObjectDefConstraint(berriesID, ypIbexConstraint);
		rmAddObjectDefConstraint(berriesID, goldConstraint);
		rmAddObjectDefConstraint(berriesID, avoidAll);
		rmAddObjectDefConstraint(berriesID, avoidTradeRoute);
		rmAddObjectDefConstraint(berriesID, avoidSocket);
		rmAddObjectDefConstraint(berriesID, nativesConstraint);
		rmAddObjectDefConstraint(berriesID, nuggetConstraint);
		rmAddObjectDefConstraint(berriesID, playerConstraint);
		rmAddObjectDefConstraint(berriesID, playerEdgeConstraint);
		rmAddObjectDefConstraint(berriesID, cliffConstraint);
		rmAddObjectDefConstraint(berriesID, Northward);
		rmAddObjectDefConstraint(berriesID, avoidKOTH);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(berriesID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(berriesID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);
    }
	
/*----------------------------------------------------------------------------------------------------------------*/

        // THE SOUTHERN BERRIES:
		int berries2ID=rmCreateObjectDef("The Southern Berries");
	    rmAddObjectDefItem(berries2ID, "Deer", rmRandInt(2,4), 5.0); 
	    rmSetObjectDefMinDistance(berries2ID, 0.0);
	    rmSetObjectDefMaxDistance(berries2ID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(berries2ID, fruitsFarConstraint);
	    rmAddObjectDefConstraint(berries2ID, ypIbexConstraint);
		rmAddObjectDefConstraint(berries2ID, goldConstraint);
		rmAddObjectDefConstraint(berries2ID, avoidAll);
		rmAddObjectDefConstraint(berries2ID, avoidTradeRoute);
		rmAddObjectDefConstraint(berries2ID, avoidSocket);
		rmAddObjectDefConstraint(berries2ID, nativesConstraint);
		rmAddObjectDefConstraint(berries2ID, nuggetConstraint);
		rmAddObjectDefConstraint(berries2ID, playerConstraint);
		rmAddObjectDefConstraint(berries2ID, playerEdgeConstraint);
		rmAddObjectDefConstraint(berries2ID, cliffConstraint);
		rmAddObjectDefConstraint(berries2ID, Southward);
		rmAddObjectDefConstraint(berries2ID, avoidKOTH);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
	    rmPlaceObjectDefAtLoc(berries2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);  
    } 
	    else
	{	
	    rmPlaceObjectDefAtLoc(berries2ID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);
    }

/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.90);
/*================================================================================================================*/
// ***************************************** STARTER SHIPMENT TRIGGERS: ***************************************** //
/*================================================================================================================*/

        for(i = 1; < cNumberPlayers) 
  {
        rmCreateTrigger("XP"+i);
        rmSwitchToTrigger(rmTriggerID("XP"+i));
        rmSetTriggerPriority(3); 
        rmSetTriggerActive(true);
        rmSetTriggerRunImmediately(true);
        rmSetTriggerLoop(false);
      
        rmAddTriggerCondition("Always");
    
        rmAddTriggerEffect("Grant Resources");
        rmSetTriggerEffectParamInt("PlayerID", i, false);
        rmSetTriggerEffectParam("ResName", "XP", false);
        rmSetTriggerEffectParam("Amount", "275", false);
  }	
  
/*================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",1.00);
/*===============================================================================================================*/
}
/*===============================================================================================================*/
// ************************************** THIS IS THE END OF THE MAP: ****************************************** //
/*===============================================================================================================*/	






















