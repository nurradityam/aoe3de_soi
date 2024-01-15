/*================================================================================================================================================*/
// ************************************************* THESE ARE THE INFORMATIONS OF THE MAP: ***************************************************** //
/*================================================================================================================================================*/

// THE AMAZONIAN JUNGLE:
// CREATED BY DANY:
// JUIN 2010:
// Edited for SoI by Pepp, 23 May 2017

/*================================================================================================================================================*/
// *********************************************** MAIN ENTRY POINT FOR RANDOM MAP SCRIPT: ****************************************************** //
/*================================================================================================================================================*/

include "mercenaries.xs";

void main(void)
{

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.01);
/*================================================================================================================================================*/
// ********************************************** CHOOSES WHICH NATIVES APPEAR ON THE MAP: ****************************************************** //
/*================================================================================================================================================*/

	// CHOOSE WHICH VARIATION TO USE:  
	int whichMap=rmRandInt(1,2);
	// int whichMap=2;
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	    int subCiv0=-1;
        int subCiv1=-1;
        int subCiv2=-1;
        int subCiv3=-1;
        int subCiv4=-1;
        int subCiv5=-1;
	
        
		if (rmAllocateSubCivs(6) == true)
   {
		subCiv0=rmGetCivID("Sunda");
		rmEchoInfo("subCiv0 is Sunda "+subCiv0);
		if (subCiv0 >= 0)
			rmSetSubCiv(0, "Sunda");

		subCiv1=rmGetCivID("Kejawen");
		rmEchoInfo("subCiv1 is Kejawen "+subCiv1);
		if (subCiv1 >= 0)
			rmSetSubCiv(1, "Kejawen");

		subCiv2=rmGetCivID("Kejawen");
		rmEchoInfo("subCiv2 is Kejawen "+subCiv2);
		if (subCiv2 >= 0)
			rmSetSubCiv(2, "Kejawen");
		
		subCiv3=rmGetCivID("Sunda");
		rmEchoInfo("subCiv3 is Sunda "+subCiv3);
		if (subCiv3 >= 0)
			rmSetSubCiv(3, "Sunda");
		
		subCiv4=rmGetCivID("Sunda");
		rmEchoInfo("subCiv4 is Sunda "+subCiv4);
		if (subCiv4 >= 0)
			rmSetSubCiv(4, "Sunda");
		
		subCiv5=rmGetCivID("Kejawen");
		rmEchoInfo("subCiv5 is Kejawen "+subCiv5);
		if (subCiv5 >= 0)
			rmSetSubCiv(5, "Kejawen");
   }

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.05);
/*================================================================================================================================================*/   
// ************************************************************* PICKS THE MAP SIZE: ************************************************************ //
/*================================================================================================================================================*/

	int playerTiles=25000;

	int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
	rmEchoInfo("Map size="+size+"m x "+size+"m");
	rmSetMapSize(632, 632); // THE NUMBER 632 IS REPLACING THE WORD - "size" - : 
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.10);
/*================================================================================================================================================*/   
// ******************************************************* DEFINE THE MAP PARAMETERS: ********************************************************** //		
/*================================================================================================================================================*/

    // PICKS A DEFAULT WATER HEIGHT:
	rmSetSeaLevel(8.0);

    // PICKS DEFAULT TERRAIN AND WATER:
	
	// SET MAP ELEVATION PARAMETERS:
	// rmSetMapElevationParameters(long type, float minFrequency, long numberOctaves, float persistence, float heightVariation)
	rmSetMapElevationParameters(cElevTurbulence, 0.02, 7, 0.5, 8.0);
	
	// SET MAP ELEVATION HEIGHT BLEND:
	rmSetMapElevationHeightBlend(0.75);
	
	// SET BASE TERRAIN MIX:
 	rmSetBaseTerrainMix("borneo_grass_a");
	
	// TERRAIN INITIALIZE:
	rmTerrainInitialize("borneo\ground_grass2_borneo", 5.0);
		
	// SET MAP TYPE:
	rmSetMapType("sundaland");
	rmSetMapType("tropical");
	rmSetMapType("land");
	
	// SET LIGHTING:
	rmSetLightingSet("parahyangan");
	
	// SET WORLD CIRCLE CONSTRAINT:
	rmSetWorldCircleConstraint(true);
	
	// CHOOSE MERCS:
	chooseMercs();	

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.15);
/*================================================================================================================================================*/
// ************************************** DEFINE SOME CLASSES. THESE ARE USED LATER FOR CONSTRAINTS: ******************************************** //
/*================================================================================================================================================*/

	    int classPlayer=rmDefineClass("player");
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.20);
/*================================================================================================================================================*/
// ********************************************************* DEFINE THE CONSTRAINTS: ************************************************************ //
// **************************************** THESE ARE USED TO HAVE OBJECTS AND AREAS AVOID EACH OTHER: ****************************************** //
/*================================================================================================================================================*/
	
	// MAP EDGE CONSTRAINTS:
    int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.485), rmDegreesToRadians(0), rmDegreesToRadians(360));

    // PLAYER CONSTRAINTS:
    int playerConstraint=rmCreateClassDistanceConstraint("stuff stay away from player", classPlayer, 20.0);
	
	// CARDINAL DIRECTIONS:
	int Northward=rmCreatePieConstraint("northMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(315), rmDegreesToRadians(135));
	int Southward=rmCreatePieConstraint("southMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(135), rmDegreesToRadians(315));
	int Eastward=rmCreatePieConstraint("eastMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(45), rmDegreesToRadians(225));
	int Westward=rmCreatePieConstraint("westMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(225), rmDegreesToRadians(45));
	
	// DEFINE THE CIRCLE CONSTRAINTS:
	int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.47), rmDegreesToRadians(0), rmDegreesToRadians(360));

	// DECORATION AVOIDANCE CONSTRAINTS:
    int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.30);
/*================================================================================================================================================*/
// ********************************************************** DEFINE THE AREAS: ***************************************************************** //
/*================================================================================================================================================*/

    // AT THIS STAGE YOU MUST DEFINE ALL THE AREAS:
	
/*================================================================================================================================================*/	
// *************************************************** SET UP PLAYER STARTING LOCATIONS: ******************************************************** //
/*================================================================================================================================================*/
 
        if ( whichMap == 1 )
   {
	    rmSetPlacementSection(0.7, 0.3); // 0.5
   }
        else
   {
	    rmSetPlacementSection(0.2, 0.8); // 0.5	   	
   }
        rmSetTeamSpacingModifier(0.7);
        rmPlacePlayersCircular(0.38, 0.38, 0);
	
/*================================================================================================================================================*/
//********************************************************  SET UP THE PLAYER AREAS: ************************************************************ //
/*================================================================================================================================================*/

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
		//rmAddAreaConstraint(id, playerConstraint); 
        //rmAddAreaConstraint(id, playerEdgeConstraint); 
	    //rmAddAreaConstraint(id, avoidTradeRoute);
	    
		// SET AREA COHERENCE:
		rmSetAreaCoherence(id, 0.7);
	rmSetAreaSmoothDistance(id, 0.7);
        
		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_snow");	  
		rmSetAreaMix(id, "city_jawa");	  
        
		// SET AREA LOC PLAYER:
		rmSetAreaLocPlayer(id, i);
        
		// SET AREA WARN FAILURE:
		rmSetAreaWarnFailure(id, false);
   }
   
        // BUILD THE AREAS:
	    rmBuildAllAreas();
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.35);
/*================================================================================================================================================*/
// ******************************************************* DEFINE THE VARIABLES: **************************************************************** //
/*================================================================================================================================================*/

	int numTries = -1;
	int failCount = -1;

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.375);
/*================================================================================================================================================//
// ************************************************ DEFINE AND PLACE SOME RANDOM SMALL CLIFFS: ************************************************** //
/*================================================================================================================================================*/

        // CREATE THE CLASS CLIFF:
        int classCliff=rmDefineClass("cliff");
		
		// CREATE THE CLIFF CONSTRAINT:
		int avoidCliff=rmCreateClassDistanceConstraint("stuff vs. cliff", rmClassID("cliff"), 15.0);
		int avoidCloseCliff=rmCreateClassDistanceConstraint("close vs. cliff", rmClassID("cliff"), 10.0);
		int avoidMediumCliff=rmCreateClassDistanceConstraint("medium vs. cliff", rmClassID("cliff"), 45.0);
		int avoidFarCliff=rmCreateClassDistanceConstraint("far vs. cliff", rmClassID("cliff"), 60.0);
		
		
		// CREATE THE RIVER CONSTRAINT:
		int avoidRiver = rmCreateTerrainDistanceConstraint("avoid river", "Land", false, 5.0);
		int avoidRiverFar = rmCreateTerrainDistanceConstraint("avoid river far", "Land", false, 35.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/






	// Middle River
	int riverID = rmRiverCreate(-1, "Amazon River", 5, 12, 6, 7);
	//rmRiverAddWaypoint(riverID, 0.0, 0.0);
	//rmRiverAddWaypoint(riverID, 0.5, 0.5);	-- this is how it used to be --
	//rmRiverAddWaypoint(riverID, 1.0, 1.0);
	
	

	rmRiverAddWaypoint(riverID, 0.5, 0.0);
	rmRiverAddWaypoint(riverID, 0.5, 0.3);
	rmRiverAddWaypoint(riverID, 0.45, 0.5);
	rmRiverAddWaypoint(riverID, 0.55, 0.75);
	rmRiverAddWaypoint(riverID, 0.5, 1.0);
	rmRiverSetShallowRadius(riverID, 4+cNumberNonGaiaPlayers);

	
		// crossing on top - players on bottom
		
		
		rmRiverAddShallow(riverID, rmRandFloat(0.2, 0.3));
		rmRiverAddShallow(riverID, rmRandFloat(0.4, 0.5));
		rmRiverAddShallow(riverID, rmRandFloat(0.6, 0.7));
		rmRiverAddShallow(riverID, rmRandFloat(0.8, 0.9));
		//if(cNumberTeams > 2)
			//rmRiverAddShallow(riverID, rmRandFloat(0.45, 0.55));
	
	
	
	
	
	
	//rmRiverSetBankNoiseParams(riverID, 0.07, 2, 1.5, 10.0, 0.667, 3.0);
	rmRiverSetBankNoiseParams(riverID, 0.07, 2, 1.5, 10.0, 0.667, 3.0);
	rmRiverBuild(riverID);




/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		
		if (cNumberNonGaiaPlayers <=2)
		numTries=cNumberNonGaiaPlayers*10;
		else
		numTries=cNumberNonGaiaPlayers*5;
	    
		failCount=0;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
	    for(i=0; <numTries)
	{
		int cliffID=rmCreateArea("The Cliff"+i);
	    rmSetAreaSize(cliffID, rmAreaTilesToFraction(450), rmAreaTilesToFraction(650));  
		rmSetAreaWarnFailure(cliffID, false);
		rmSetAreaCliffType(cliffID, "Coastal Japan");
		
		rmAddAreaToClass(cliffID, rmClassID("cliff"));	
		// rmSetAreaCliffEdge(cliffID, 2, 0.4, 0.1, 1.0, 0);
		   rmSetAreaCliffEdge(cliffID, rmRandInt(1,3), 0.4, 0.1, 1.0, 2);  //1, 1.0, 0.1, 1.0, 0);
		rmSetAreaCliffPainting(cliffID, true, true, true, 1.5, true);
		rmSetAreaCliffHeight(cliffID, rmRandInt(7,10), 1.0, 0.5);
		rmSetAreaHeightBlend(cliffID, 1);
		
		//rmAddAreaTerrainLayer(cliffID, "texas\ground2_tex", 0, 2);
		rmSetAreaObeyWorldCircleConstraint(cliffID, false);
		
		rmAddAreaConstraint(cliffID, avoidFarCliff);		
		rmAddAreaConstraint(cliffID, avoidRiver);				
		rmAddAreaConstraint(cliffID, playerConstraint);
        rmAddAreaConstraint(cliffID, playerEdgeConstraint);
	
		rmSetAreaMinBlobs(cliffID, 1);
		rmSetAreaMaxBlobs(cliffID, 2);
		rmSetAreaMinBlobDistance(cliffID, 1.0);
		rmSetAreaMaxBlobDistance(cliffID, 2.0);
		
		rmSetAreaCoherence(cliffID, 0.85);
		rmSetAreaSmoothDistance(cliffID, 30);						
		rmSetAreaCoherence(cliffID, 0.85);

		if(rmBuildArea(cliffID)==false)
	  {
		// Stop trying once we fail 3 times in a row
		failCount++;
		if(failCount==3)
		break;
	  }
		else
		failCount=0;
    }

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.40);
/*================================================================================================================================================*/
// ********************************************* PLACEMENT ORDER OF NON-TRADE ROUTE STUFF: ****************************************************** //
// **************************************** NATIVES -> SECRETS -> NUGGETS -> SMALL PONDS (WHEE) ************************************************* //
/*================================================================================================================================================*/
// ************************************************** STARTING UNITS AND RESOURCES DEFS: ******************************************************** //
/*================================================================================================================================================*/
 
        // DEFINE THE CLASS STARTING UNITS:
	    int classStartingUnit=rmDefineClass("startingUnit");
		
		// DEFINE THE STARTING UNITS CONSTRAINTS:
        int avoidStartingUnits=rmCreateClassDistanceConstraint("objects avoid starting units", rmClassID("startingUnit"), 30.0);
        int avoidStartingUnitsSmall=rmCreateClassDistanceConstraint("objects avoid starting units small", rmClassID("startingUnit"), 5.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
 
	    // DEFINE THE STARTING UNITS:
		int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
	    rmSetObjectDefMinDistance(startingUnits, 7.0);
	    rmSetObjectDefMaxDistance(startingUnits, 12.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    // DEFINE THE STARTING TCID:
		int startingTCID = rmCreateObjectDef("startingTC");
	    if ( rmGetNomadStart())
	{
		rmAddObjectDefItem(startingTCID, "CoveredWagon", 1, 0.0);
	}
	    else
	{
		rmAddObjectDefItem(startingTCID, "TownCenter", 1, 0.0);
	}
	    rmAddObjectDefToClass(startingTCID, rmClassID("startingUnit"));
	    rmSetObjectDefMinDistance(startingTCID, 0.0);
	    rmSetObjectDefMaxDistance(startingTCID, 0.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE THE STARTING COIN CONSTRAINTS:
	    int avoidStartingCoin=rmCreateTypeDistanceConstraint("starting coin avoids coin", "gold", 22.0);		
		
		// DEFINE THE PLAYER GOLD ID:
		int silverType = -1;
	    int playerGoldID = -1;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	    
		// DEFINE THE STARTING AREA TREES:
		int StartAreaTreeID=rmCreateObjectDef("starting trees");
	    rmAddObjectDefItem(StartAreaTreeID, "STreeTeak", 1, 0.0);
	    rmSetObjectDefMinDistance(StartAreaTreeID, 12.0);
	    rmSetObjectDefMaxDistance(StartAreaTreeID, 18.0);
	    rmAddObjectDefConstraint(StartAreaTreeID, avoidStartingUnitsSmall);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    // DEFINE THE START BERRIES:
		int StartBerriesID=rmCreateObjectDef("Starting Berries");
	    rmAddObjectDefItem(StartBerriesID, "SSalak", 4, 4.0);
	    rmSetObjectDefMinDistance(StartBerriesID, 10.0);
	    rmSetObjectDefMaxDistance(StartBerriesID, 12.0);
	    rmSetObjectDefCreateHerd(StartBerriesID, true);
	    rmAddObjectDefConstraint(StartBerriesID, avoidStartingUnitsSmall);
		
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
		
		// DEFINE Unique Buildings:	
		int SoldatSekulID=rmCreateObjectDef("soldat sekul building");
		
			rmAddObjectDefItem(SoldatSekulID, "SoldatSekul", 1, 0.0);
		rmSetObjectDefMinDistance(SoldatSekulID, 4.0);
		rmSetObjectDefMaxDistance(SoldatSekulID, 10.0);
		rmAddObjectDefConstraint(SoldatSekulID, avoidAll);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    // DEFINE THE CLASS PLAYER NUGGET:
	    int classPlayerNugget=rmDefineClass("playerNuggets");
		
		// DEFINE THE CLASS PLAYER NUGGET CONSTRAINTS:
		int playerNuggetConstraint=rmCreateClassDistanceConstraint("playerNuggets avoid playerNuggets", rmClassID("playerNuggets"), 40.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// DEFINE THE PLAYER NUGGET:
		int playerNuggetID=rmCreateObjectDef("playerNuggets");
	    rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
	    rmAddObjectDefToClass(playerNuggetID, rmClassID("playerNuggets"));
	    rmAddObjectDefToClass(playerNuggetID, rmClassID("startingUnit"));
        rmSetObjectDefMinDistance(playerNuggetID, 28.0);
        rmSetObjectDefMaxDistance(playerNuggetID, 35.0);
	    rmAddObjectDefConstraint(playerNuggetID, playerNuggetConstraint);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.45);
/*================================================================================================================================================*/
// *********************** PLACING THE STARTING TCID...STARTING UNITS...STARTING RESOURCES: ********************* //
/*================================================================================================================*/
	
 	for(i=1; <cNumberPlayers)
	{
		
		// PLACE THE STARTING TCID:
		rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		if (rmGetPlayerCiv(i) ==  rmGetCivID("Germans")) {
			rmPlaceObjectDefAtLoc(SoldatSekulID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
        }
		
		// PLACE THE STARTING UNITS:
		rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		
		
		// DEFINE THE PLAYER GOLD:
		// EVERYONE GETS TWO ORE OBJECTSDEFS, ONE PRETTY CLOSE, THE OTHER A LITTLE FURTHER AWAY:
		silverType = rmRandInt(1,10);
		playerGoldID = rmCreateObjectDef("player silver closer "+i);
		rmAddObjectDefItem(playerGoldID, "SKapuk", 3, 3.0);
		rmAddObjectDefConstraint(playerGoldID, avoidStartingCoin);
		rmAddObjectDefConstraint(playerGoldID, avoidStartingUnitsSmall);
		rmSetObjectDefMinDistance(playerGoldID, 15.0);
		rmSetObjectDefMaxDistance(playerGoldID, 20.0);
		
		// PLACE THE TWO GOLD MINES:
		rmPlaceObjectDefAtLoc(playerGoldID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(playerGoldID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// PLACE THE STARTING TREES:
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// PLACE THE START BERRIES:
		rmPlaceObjectDefAtLoc(StartBerriesID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// PLACE THE PLAYER NUGGET:
		rmSetNuggetDifficulty(1, 1);
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
	}

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.50);
/*================================================================================================================================================*/
// **************************************************** DEFINE AND PLACE THE NATIVE AMERICANS: ************************************************** //
/*================================================================================================================================================*/
        
	// DEFINE THE CLASS NATIVES:
	int classNatives=rmDefineClass("natives");

    // CREATE THE NATIVES CONSTRAINTS:
	int nativesConstraint=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 20.0);
	int nativesCloseConstraint=rmCreateClassDistanceConstraint("close stuff avoids natives", rmClassID("natives"), 15.0);
	int nativesVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff avoids natives", rmClassID("natives"), 10.0);
    int nativesMediumConstraint=rmCreateClassDistanceConstraint("medium vs natives", rmClassID("natives"), 35.0);
	int nativesFarConstraint=rmCreateClassDistanceConstraint("far vs natives", rmClassID("natives"), 65.0);
		
	// DEFINE THE CLASS IMPORTANT ITEM:
	int classImportantItem=rmDefineClass("importantItem");
	
	// CREATE THE IMPORTANT ITEM CONSTRAINTS:
	int importantItemConstraint=rmCreateClassDistanceConstraint("stuff vs importantItem", rmClassID("importantItem"), 20.0);
	int importantItemCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs importantItem", rmClassID("importantItem"), 15.0);
	int importantItemVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff vs importantItem", rmClassID("importantItem"), 10.0);
    int importantItemMediumConstraint=rmCreateClassDistanceConstraint("medium vs importantItem", rmClassID("importantItem"), 35.0);
	int importantItemFarConstraint=rmCreateClassDistanceConstraint("far vs importantItem", rmClassID("importantItem"), 65.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        if (subCiv0 == rmGetCivID("Sunda"))
    {  
        int nativeVillage1ID = -1;
        int nativeVillageType = rmRandInt(1,5);
        nativeVillage1ID = rmCreateGrouping("native village 1", "Sunda_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage1ID, 0.0);
        rmSetGroupingMaxDistance(nativeVillage1ID, rmXFractionToMeters(0.1));
		rmAddGroupingToClass(nativeVillage1ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage1ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage1ID, avoidCliff);
        rmAddGroupingConstraint(nativeVillage1ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage1ID, playerEdgeConstraint);
		
		if ( whichMap == 1 )
	  {
		rmPlaceGroupingAtLoc(nativeVillage1ID, 0, 0.35, 0.15);
	  }
		else
	  {
		rmPlaceGroupingAtLoc(nativeVillage1ID, 0, 0.35, 0.15);
		//rmPlaceGroupingAtLoc(nativeVillage1ID, 0, 0.375, 0.175);
	  }
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

        if (subCiv1 == rmGetCivID("Kejawen"))
    {   
        int nativeVillage2ID = -1;
        nativeVillageType = rmRandInt(1,5);
        nativeVillage2ID = rmCreateGrouping("native village 2", "Kejawen_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage2ID, 0.0);
        rmSetGroupingMaxDistance(nativeVillage2ID, rmXFractionToMeters(0.1));
        rmAddGroupingToClass(nativeVillage2ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage2ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage2ID, avoidCliff);
        rmAddGroupingConstraint(nativeVillage2ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage2ID, playerEdgeConstraint);
		
		if ( whichMap == 1 )
	  {
		rmPlaceGroupingAtLoc(nativeVillage2ID, 0, 0.65, 0.15); 
	  }
		else
	  {
		rmPlaceGroupingAtLoc(nativeVillage2ID, 0, 0.65, 0.15); 
		//rmPlaceGroupingAtLoc(nativeVillage2ID, 0, 0.675, 0.175); 
	  }
    }
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

	    if(subCiv2 == rmGetCivID("Kejawen"))
    {   
        int nativeVillage3ID = -1;
        nativeVillageType = rmRandInt(1,5);
        nativeVillage3ID = rmCreateGrouping("native village 3", "Kejawen_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage3ID, 0.0);
        rmSetGroupingMaxDistance(nativeVillage3ID, rmXFractionToMeters(0.1));
        rmAddGroupingToClass(nativeVillage3ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage3ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage3ID, avoidCliff);
		rmAddGroupingConstraint(nativeVillage3ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage3ID, playerEdgeConstraint);
		
		if ( whichMap == 1 )
	  {
		rmPlaceGroupingAtLoc(nativeVillage3ID, 0, 0.15, 0.85);
	  }
		else
	  {
		rmPlaceGroupingAtLoc(nativeVillage3ID, 0, 0.15, 0.85);
		//rmPlaceGroupingAtLoc(nativeVillage3ID, 0, 0.175, 0.875);
	  }
	}
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/   

	    if(subCiv3 == rmGetCivID("Sunda"))
    {   
        int nativeVillage4ID = -1;
        nativeVillageType = rmRandInt(1,5);
        nativeVillage4ID = rmCreateGrouping("native village 4", "Sunda_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage4ID, 0.0);
        rmSetGroupingMaxDistance(nativeVillage4ID, rmXFractionToMeters(0.1));
        rmAddGroupingToClass(nativeVillage4ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage4ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage4ID, avoidCliff);
	    rmAddGroupingConstraint(nativeVillage4ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage4ID, playerEdgeConstraint);
		
		if ( whichMap == 1 )
	  {
		rmPlaceGroupingAtLoc(nativeVillage4ID, 0, 0.35, 0.45);
	  }
		else
	  {
		rmPlaceGroupingAtLoc(nativeVillage4ID, 0, 0.35, 0.45);
		//rmPlaceGroupingAtLoc(nativeVillage4ID, 0, 0.375, 0.475);
	  }
    }

/*------------------------------------------------------------------------------------------------------------------------------------------------*/   
   
	    if(subCiv4 == rmGetCivID("Sunda"))
    {
        int nativeVillage5ID = -1;
        nativeVillageType = rmRandInt(1,5);
        nativeVillage5ID = rmCreateGrouping("native village 5", "Sunda_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage5ID, 0.0);
	    rmSetGroupingMaxDistance(nativeVillage5ID, rmXFractionToMeters(0.1));
        rmAddGroupingToClass(nativeVillage5ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage5ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage5ID, avoidCliff);
        rmAddGroupingConstraint(nativeVillage5ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage5ID, playerEdgeConstraint);
	   
	    if ( whichMap == 1 )
	  {
		rmPlaceGroupingAtLoc(nativeVillage4ID, 0, 0.85, 0.85);
	  }
		else
	  {
		rmPlaceGroupingAtLoc(nativeVillage4ID, 0, 0.85, 0.85);
		//rmPlaceGroupingAtLoc(nativeVillage5ID, 0, 0.875, 0.875);
	  }
	}
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	

        if (subCiv5 == rmGetCivID("Kejawen"))
   {   
        int nativeVillage6ID = -1;
        nativeVillageType = rmRandInt(1,5);
        nativeVillage6ID = rmCreateGrouping("native village 6", "Kejawen_"+nativeVillageType);
        rmSetGroupingMinDistance(nativeVillage6ID, 0.0);
        rmSetGroupingMaxDistance(nativeVillage6ID, rmXFractionToMeters(0.1));
        rmAddGroupingToClass(nativeVillage6ID, rmClassID("importantItem"));
        rmAddGroupingToClass(nativeVillage6ID, rmClassID("natives"));
        rmAddGroupingConstraint(nativeVillage6ID, avoidCliff);
        rmAddGroupingConstraint(nativeVillage6ID, playerConstraint);
		rmAddGroupingConstraint(nativeVillage6ID, playerEdgeConstraint);

		if ( whichMap == 1 )
		{
			rmPlaceGroupingAtLoc(nativeVillage6ID, 0, 0.65, 0.45);
		}
		else
		{
			rmPlaceGroupingAtLoc(nativeVillage6ID, 0, 0.65, 0.45);
			//rmPlaceGroupingAtLoc(nativeVillage6ID, 0, 0.675, 0.475);
			
		}
   }

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.55);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE NUGGETS: ********************************************************* //
/*================================================================================================================================================*/

	// DEFINE THE NUGGET CONSTRAINTS:
	int nuggetFarConstraint=rmCreateTypeDistanceConstraint("far nugget vs nugget", "AbstractNugget", 75.0);
    int nuggetCloseConstraint=rmCreateTypeDistanceConstraint("close nugget vs stuff", "AbstractNugget", 10.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	int nuggetID= rmCreateObjectDef("nugget"); 
	rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
	rmSetObjectDefMinDistance(nuggetID, 0.0);
	rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
	
	rmAddObjectDefConstraint(nuggetID, nuggetFarConstraint);
	rmAddObjectDefConstraint(nuggetID, avoidCliff);
	rmAddObjectDefConstraint(nuggetID, playerConstraint);
  	rmAddObjectDefConstraint(nuggetID, nativesConstraint);
	rmAddObjectDefConstraint(nuggetID, avoidAll);
	rmAddObjectDefConstraint(nuggetID, playerEdgeConstraint);
	
	rmSetNuggetDifficulty(1, 3);
	
	if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*8.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	}
	

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.60);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE FOREST AREAS: **************************************************** //
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // CREATE THE FOREST CLASS:
		int forestClass=rmDefineClass("classForest");
		
		// CREATE THE FOREST CONSTRAINT:
		int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 15.0);
		int forestEnoughConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 30.0);
	    int forestMediumConstraint=rmCreateClassDistanceConstraint("medium vs. forest", rmClassID("classForest"), 45.0);
        int forestCloseConstraint=rmCreateClassDistanceConstraint("close vs. forest", rmClassID("classForest"), 10.0);
        int forestFarConstraint=rmCreateClassDistanceConstraint("far vs. forest", rmClassID("classForest"), 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		
        int whichVariation=-1;
	    whichVariation = rmRandInt(1,2);
		
		int forestTreeID = 0;

	    if (cNumberNonGaiaPlayers <=2)
		numTries = 8.50 * cNumberNonGaiaPlayers;
	    else
		numTries = 4.25 * cNumberNonGaiaPlayers;
	    
		failCount=0;
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	    
		// THE NORTHERN FORESTS:
		for (i=0; <numTries)
{   
		int forestID=rmCreateArea("forestID"+i);
		rmSetAreaWarnFailure(forestID, false);
		rmSetAreaSize(forestID, rmAreaTilesToFraction(475), rmAreaTilesToFraction(475));
		
		
		if ( whichVariation == 1 )
		{
		rmSetAreaForestType(forestID, "Jawa Lowland Forest");
		}
		else
		{
		rmSetAreaForestType(forestID, "Jawa Highland Forest");
		}
		//rmSetAreaForestType(forestID, "Jawa Lowland Forest");
		
		rmSetAreaForestDensity(forestID, 1.0);
		rmSetAreaForestClumpiness(forestID, 0.5);		
		rmSetAreaForestUnderbrush(forestID, 0.8);
		
		rmSetAreaMinBlobs(forestID, 1);
		rmSetAreaMaxBlobs(forestID, 6);						
		rmSetAreaMinBlobDistance(forestID, 1.0);
		rmSetAreaMaxBlobDistance(forestID, 5.0);
		
		rmSetAreaCoherence(forestID, 1.0);
		rmSetAreaSmoothDistance(forestID, 5);
		rmAddAreaToClass(forestID, rmClassID("classForest"));
		
		rmAddAreaConstraint(forestID, forestConstraint);
		//rmAddAreaConstraint(forestID, avoidCliff);
		rmAddAreaConstraint(forestID, nativesConstraint);
		rmAddAreaConstraint(forestID, playerConstraint);
		rmAddAreaConstraint(forestID, playerEdgeConstraint);
		rmAddAreaConstraint(forestID, nuggetCloseConstraint);
		rmAddAreaConstraint(forestID, Northward);
		
		if(rmBuildArea(forestID)==false)
	{
		// Stop trying once we fail 10 times in a row.
		failCount++;
		if(failCount==10)
		break;
	}
		else
		failCount=0; 
}

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE SOUTHERN FORESTS:
		for (i=0; <numTries)
{   
		int forest2ID=rmCreateArea("forestID 2"+i);
		rmSetAreaWarnFailure(forest2ID, false);
		rmSetAreaSize(forest2ID, rmAreaTilesToFraction(475), rmAreaTilesToFraction(475));
		
		if ( whichVariation == 1 )
		{
		rmSetAreaForestType(forest2ID, "Jawa Highland Forest");
		}
		else
		{
		rmSetAreaForestType(forest2ID, "Jawa Lowland Forest");
		}
		//rmSetAreaForestType(forest2ID, "Jawa Lowland Forest");
		
		rmSetAreaForestDensity(forest2ID, 1.0);
		rmSetAreaForestClumpiness(forest2ID, 0.5);		
		rmSetAreaForestUnderbrush(forest2ID, 0.8);
		
		rmSetAreaMinBlobs(forest2ID, 1);
		rmSetAreaMaxBlobs(forest2ID, 6);						
		rmSetAreaMinBlobDistance(forest2ID, 1.0);
		rmSetAreaMaxBlobDistance(forest2ID, 5.0);
		
		rmSetAreaCoherence(forest2ID, 1.0);
		rmSetAreaSmoothDistance(forest2ID, 5);
		rmAddAreaToClass(forest2ID, rmClassID("classForest"));
		
		rmAddAreaConstraint(forest2ID, forestConstraint);
		rmAddAreaConstraint(forest2ID, playerConstraint);
		rmAddAreaConstraint(forest2ID, playerEdgeConstraint);
		//rmAddAreaConstraint(forest2ID, avoidCliff);
		rmAddAreaConstraint(forest2ID, nativesConstraint);
		rmAddAreaConstraint(forest2ID, nuggetCloseConstraint);
		rmAddAreaConstraint(forest2ID, Southward);
		
		if(rmBuildArea(forest2ID)==false)
	{
		// Stop trying once we fail 10 times in a row.
		failCount++;
		if(failCount==10)
		break;
	}
		else
		failCount=0; 
}

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.65);
/*================================================================================================================================================*/
// **************************************************** DEFINE AND PLACE THE RESOURCES: ********************************************************* //
/*================================================================================================================================================*/
// *********************************** FAST COIN - THREE EXTRA PER PLAYER BEYOND STARTING RESOURCES: ******************************************** //
/*================================================================================================================================================*/
    
	// DEFINE THE COIN CONSTRAINTS:
	int coinFarConstraint=rmCreateTypeDistanceConstraint("coin vs coin", "gold", 90.0);
	int coinCloseConstraint=rmCreateTypeDistanceConstraint("stuff close vs coin ", "gold", 15.0);
	
/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	    int silverID = -1;
		if (cNumberNonGaiaPlayers <=2)
	{	
	    int silverCount = (cNumberNonGaiaPlayers*8);
	}
        else
	{	
    	silverCount = (cNumberNonGaiaPlayers*4.0);
	}	
	    rmEchoInfo("silver count = "+silverCount);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

	    for(i=0; < silverCount)
	{
		silverType = rmRandInt(1,10);
		silverID = rmCreateObjectDef("silver "+i);
		rmAddObjectDefItem(silverID, "mine", 1, 0.0);
		rmSetObjectDefMinDistance(silverID, 0.0);
		rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(silverID, coinFarConstraint);
		rmAddObjectDefConstraint(silverID, avoidCliff);
		rmAddObjectDefConstraint(silverID, playerEdgeConstraint);
		rmAddObjectDefConstraint(silverID, forestConstraint);
		rmAddObjectDefConstraint(silverID, playerConstraint);
		rmAddObjectDefConstraint(silverID, nativesConstraint);
		rmAddObjectDefConstraint(silverID, nuggetCloseConstraint);
		int result = rmPlaceObjectDefAtLoc(silverID, 0, 0.5, 0.5);
		if(result == 0)
		break;
    }

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.70);
/*================================================================================================================================================*/
// ************************************************ DEFINE AND PLACE THE TAPIR HERDS: *********************************************************** //
/*================================================================================================================================================*/

        // DEFINE THE TAPIR CONSTRAINTS:
	    int tapirFarConstraint=rmCreateTypeDistanceConstraint("tapir avoids tapir", "Pronghorn", 60.0);
		int tapirCloseConstraint=rmCreateTypeDistanceConstraint("stuff close vs tapir", "Pronghorn", 15.0);
	    int tapirMediumConstraint=rmCreateTypeDistanceConstraint("stuff medium vs tapir", "Pronghorn", 25.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int tapirID=rmCreateObjectDef("tapir herd");
        rmAddObjectDefItem(tapirID, "Pronghorn", rmRandInt(12,16), 12.0);
        rmSetObjectDefMinDistance(tapirID, 0.0);
        rmSetObjectDefMaxDistance(tapirID, rmXFractionToMeters(0.5));
        
		rmAddObjectDefConstraint(tapirID, tapirFarConstraint);
		rmAddObjectDefConstraint(tapirID, avoidCliff);
	    rmAddObjectDefConstraint(tapirID, playerConstraint);
		rmAddObjectDefConstraint(tapirID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(tapirID, nuggetCloseConstraint);
		rmAddObjectDefConstraint(tapirID, forestConstraint);
		rmAddObjectDefConstraint(tapirID, nativesConstraint);
		rmAddObjectDefConstraint(tapirID, coinCloseConstraint);
        
		rmSetObjectDefCreateHerd(tapirID, true);
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(tapirID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(tapirID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2.0);
	}
	    

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.75);
/*================================================================================================================================================*/
// ************************************************ DEFINE AND PLACE THE BERRYBUSH HERDS: ******************************************************* //
/*================================================================================================================================================*/
        
		// DEFINE THE BERRYBUSH CONSTRAINTS:
	    int fruitFarConstraint=rmCreateTypeDistanceConstraint("fruits avoid fruits", "AbstractFruit", 75.0);
	    int fruitCloseConstraint=rmCreateTypeDistanceConstraint("other avoid close fruits", "AbstractFruit", 25.0);
        int fruitVeryCloseConstraint=rmCreateTypeDistanceConstraint("other avoid very close fruits", "AbstractFruit", 15.0);
		
		
        //int whichVariation=-1;
	    whichVariation = rmRandInt(1,4);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        int fruitID=rmCreateObjectDef("The Fruit Herds");
		
		if ( whichVariation == 1 )
		{	
	    rmAddObjectDefItem(fruitID, "SSalak", rmRandInt(5,9), 10.0);
		}
		else if ( whichVariation == 2 )
		{
	    rmAddObjectDefItem(fruitID, "SBuni", rmRandInt(3,5), 10.0);
		}
		else if ( whichVariation == 3 )
		{
	    rmAddObjectDefItem(fruitID, "SMundu", rmRandInt(3,5), 10.0);
		}
		else
		{
	    rmAddObjectDefItem(fruitID, "SMundu", rmRandInt(3,5), 10.0);
		}
        //rmAddObjectDefItem(fruitID, "SSalak", rmRandInt(6,9), 10.0);
        rmSetObjectDefMinDistance(fruitID, 0.0);
        rmSetObjectDefMaxDistance(fruitID, rmXFractionToMeters(0.5));
        
		rmAddObjectDefConstraint(fruitID, fruitFarConstraint);
		rmAddObjectDefConstraint(fruitID, avoidCliff);
		rmAddObjectDefConstraint(fruitID, avoidRiver);
		rmAddObjectDefConstraint(fruitID, tapirCloseConstraint);
	    rmAddObjectDefConstraint(fruitID, playerConstraint);
		rmAddObjectDefConstraint(fruitID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(fruitID, nuggetCloseConstraint);
		rmAddObjectDefConstraint(fruitID, forestConstraint);
		rmAddObjectDefConstraint(fruitID, nativesConstraint);
		rmAddObjectDefConstraint(fruitID, coinCloseConstraint);
        
		rmSetObjectDefCreateHerd(fruitID, true);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(fruitID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(fruitID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.80);
/*================================================================================================================================================*/
// ************************************************ DEFINE AND PLACE THE BERRYBUSH HERDS: ******************************************************* //
/*================================================================================================================================================*/

        // DEFINE THE CAPYBARA CONSTRAINTS:
	    int capybaraFarConstraint=rmCreateTypeDistanceConstraint("capybara far vs capybara", "Deer", 60.0);
		int capybaraCloseConstraint=rmCreateTypeDistanceConstraint("stuff close vs capybara", "Deer", 15.0);
	    int capybaraMediumConstraint=rmCreateTypeDistanceConstraint("stuff medium vs capybara", "Deer", 25.0);
		
	    int tigerMediumConstraint=rmCreateTypeDistanceConstraint("stuff medium vs capybara", "ypPetTiger", 25.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int capybaraID=rmCreateObjectDef("capybara herd");
        rmAddObjectDefItem(capybaraID, "Deer", rmRandInt(6,9), 10.0);
        rmSetObjectDefMinDistance(capybaraID, 0.0);
        rmSetObjectDefMaxDistance(capybaraID, rmXFractionToMeters(0.5));
        
		rmAddObjectDefConstraint(capybaraID, capybaraFarConstraint);
		rmAddObjectDefConstraint(capybaraID, fruitCloseConstraint);
		rmAddObjectDefConstraint(capybaraID, tapirFarConstraint);
	    rmAddObjectDefConstraint(capybaraID, playerConstraint);
		rmAddObjectDefConstraint(capybaraID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(capybaraID, nuggetCloseConstraint);
		rmAddObjectDefConstraint(capybaraID, forestConstraint);
		rmAddObjectDefConstraint(capybaraID, nativesConstraint);
		rmAddObjectDefConstraint(capybaraID, avoidCliff);
		rmAddObjectDefConstraint(capybaraID, avoidRiver);
		rmAddObjectDefConstraint(capybaraID, coinCloseConstraint);
        
		rmSetObjectDefCreateHerd(capybaraID, true);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(capybaraID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*6.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(capybaraID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3.0);
	}
	
	
			   
		  int herdID=rmCreateObjectDef("water buffalo");
		  rmAddObjectDefItem(herdID, "YPPetTiger", 1, 2.5);
		  rmSetObjectDefMinDistance(herdID, 0.0);
		  rmSetObjectDefMaxDistance(herdID, rmXFractionToMeters(0.225));
		  
		//rmAddObjectDefConstraint(herdID, capybaraFarConstraint);
		rmAddObjectDefConstraint(herdID, fruitCloseConstraint);
		rmAddObjectDefConstraint(herdID, tigerMediumConstraint);
		//rmAddObjectDefConstraint(herdID, tapirFarConstraint);
	    rmAddObjectDefConstraint(herdID, playerConstraint);
		rmAddObjectDefConstraint(herdID, playerEdgeConstraint);
	    //rmAddObjectDefConstraint(herdID, nuggetCloseConstraint);
		//rmAddObjectDefConstraint(herdID, forestConstraint);
		rmAddObjectDefConstraint(herdID, nativesConstraint);
		//rmAddObjectDefConstraint(herdID, avoidCliff);
		rmAddObjectDefConstraint(herdID, avoidRiver);
		rmAddObjectDefConstraint(herdID, coinCloseConstraint);
		  rmPlaceObjectDefAtLoc(herdID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4); 
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.85);
/*================================================================================================================================================*/
// **************************************************** DEFINE AND PLACE SOME RANDOM TREES: ***************************************************** //
/*================================================================================================================================================*/

        int avoidTree=rmCreateTypeDistanceConstraint("stuff avoid tree", "tree", 15.0);
		int avoidCloseTree=rmCreateTypeDistanceConstraint("close avoid tree", "tree", 10.0);
		int avoidVeryCloseTree=rmCreateTypeDistanceConstraint("very close avoid tree", "tree", 5.0);
		int avoidMediumTree=rmCreateTypeDistanceConstraint("medium avoid tree", "tree", 30.0);
	    int avoidFarTree=rmCreateTypeDistanceConstraint("far avoid tree", "tree", 65.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        // THE RANDOM TREES:
		int randomTreeID=rmCreateObjectDef("The Random Trees");
	    rmAddObjectDefItem(randomTreeID, "STreeAngsana", 3, 6.0);
	    rmSetObjectDefMinDistance(randomTreeID, 0.0);
	    rmSetObjectDefMaxDistance(randomTreeID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(randomTreeID, avoidCloseTree);
		rmAddObjectDefConstraint(randomTreeID, avoidCliff);
		rmAddObjectDefConstraint(randomTreeID, capybaraCloseConstraint);
		rmAddObjectDefConstraint(randomTreeID, fruitVeryCloseConstraint);
		rmAddObjectDefConstraint(randomTreeID, tapirCloseConstraint);
	    rmAddObjectDefConstraint(randomTreeID, playerConstraint);
		rmAddObjectDefConstraint(randomTreeID, playerEdgeConstraint);
	    rmAddObjectDefConstraint(randomTreeID, nuggetCloseConstraint);
		rmAddObjectDefConstraint(randomTreeID, forestConstraint);
		rmAddObjectDefConstraint(randomTreeID, nativesConstraint);
		rmAddObjectDefConstraint(randomTreeID, coinCloseConstraint);
		
		if (cNumberNonGaiaPlayers <=2)
	{	
		rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*50.0);
	}
        else
	{
        rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*25.0);
	}					
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.90);
/*================================================================================================================================================*/
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*===============================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",1.00);
/*===============================================================================================================================================*/
}
/*===============================================================================================================================================*/
// **************************************************** THIS IS THE END OF THE MAP: ************************************************************ //
/*===============================================================================================================================================*/
