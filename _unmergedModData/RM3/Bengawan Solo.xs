/*================================================================================================================================================*/
// ************************************************ THESE ARE THE INFORMATIONS OF THE MAP: ****************************************************** //
/*================================================================================================================================================*/

// THE VIRGIN ISLANDS:
// CREATED BY DANY:
// JUIN 2010:
// Edited for SoI by Mahidevran, 22 May 2017

/*================================================================================================================================================*/
// *************************************************** MAIN ENTRY POINT FOR RANDOM MAP SCRIPT: ************************************************** //
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
// NONE FOR NOW:
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

	    int subCiv0=-1;
        int subCiv1=-1;
	    int subCiv2=-1;
        int subCiv3=-1;
	    int subCiv4=-1;
        int subCiv5=-1;

/*------------------------------------------------------------------------------------------------------------------------------------------------*/        

        if (rmAllocateSubCivs(6) == true)
   {
		subCiv0=rmGetCivID("Matraman");
        rmEchoInfo("subCiv0 is Matraman "+subCiv0);
        if (subCiv0 >= 0)
        rmSetSubCiv(0, "Matraman");

        subCiv1=rmGetCivID("Matraman");
        rmEchoInfo("subCiv1 is Matraman "+subCiv1);
        if (subCiv1 >= 0)
		rmSetSubCiv(1, "Matraman");

        subCiv2=rmGetCivID("Kejawen");
        rmEchoInfo("subCiv2 is Kejawen "+subCiv2);
        if (subCiv2 >= 0)
		rmSetSubCiv(2, "Kejawen");

        subCiv3=rmGetCivID("Kejawen");
        rmEchoInfo("subCiv3 is Kejawen "+subCiv3);
        if (subCiv3 >= 0)
		rmSetSubCiv(3, "Kejawen");

        subCiv4=rmGetCivID("Pesantren");
        rmEchoInfo("subCiv4 is Pesantren "+subCiv4);
        if (subCiv4 >= 0)
		rmSetSubCiv(4, "Pesantren");

        subCiv5=rmGetCivID("Pesantren");
        rmEchoInfo("subCiv5 is Pesantren "+subCiv5);
        if (subCiv5 >= 0)
		rmSetSubCiv(5, "Pesantren");
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

        // SET SEA LEVEL:
        rmSetSeaLevel(2.0);
        
		// SET SEA TYPE:
		rmSetSeaType("Yellow River");
 	    
		// SET BASE TERRAIN MIX:
		rmSetBaseTerrainMix("texas_grass");
	    
		// SET MAP TYPE:
		rmSetMapType("jawa");
	    rmSetMapType("grass");
	    rmSetMapType("water");
        
		// SET THE LIGHTING:
		rmSetLightingSet("seville_morning");

        // MAP INITIALIZATION:
        rmTerrainInitialize("water");
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.15);
/*================================================================================================================================================*/
// **************************************** DEFINE SOME CLASSES: THESE ARE USED LATER FOR CONSTRAINTS: ****************************************** //
/*================================================================================================================================================*/
        
		// DEFINE THE CLASS PLAYER:
		int classPlayer=rmDefineClass("player");
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.20);
/*================================================================================================================================================*/
// ****************************************************** DEFINE THE CONSTRAINTS: *************************************************************** //
// ************************************** THESE ARE USED TO HAVE OBJECTS AND AREAS AVOID EACH OTHER: ******************************************** //
/*================================================================================================================================================*/
    
	// DEFINE THE CREATE A EDGE OF MAP CONSTRAINT:
    int playerEdgeConstraint=rmCreatePieConstraint("player edge of map", 0.5, 0.5, rmXFractionToMeters(0.0), rmXFractionToMeters(0.485), rmDegreesToRadians(0), rmDegreesToRadians(360));
	
    // DEFINE THE PLAYER AREA CONSTRAINT:
    int playerConstraint=rmCreateClassDistanceConstraint("stuff vs players", classPlayer, 25.0);
	int playerCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs players", classPlayer, 15.0);
	int playerMediumConstraint=rmCreateClassDistanceConstraint("medium stuff vs players", classPlayer, 35.0);
	
	// DEFINE THE IMPASSABLE LAND CONSTRAINT:
    int avoidImpassableLand=rmCreateTerrainDistanceConstraint("stuff vs impassable land", "Land", false, 10.0);
    int avoidVeryCloseImpassableLand=rmCreateTerrainDistanceConstraint("very close stuff vs impassable land", "Land", false, 2.0);
   
    // DECORATION AVOIDANCE:
	int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
	
	// CONSTRAINT TO AVOID WATER:
    int avoidWater5 = rmCreateTerrainDistanceConstraint("stuff vs water 5", "Land", false, 5.0);
	int avoidWater8 = rmCreateTerrainDistanceConstraint("stuff vs water 8", "Land", false, 8.0);
	int avoidWater10 = rmCreateTerrainDistanceConstraint("stuff vs water 10", "Land", false, 10.0);
	int avoidWater12 = rmCreateTerrainDistanceConstraint("stuff vs water 12", "Land", false, 12.0);
	int avoidWater20 = rmCreateTerrainDistanceConstraint("stuff vs water 20", "Land", false, 20.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.25);
/*================================================================================================================================================*/
// ************************************************ DEFINE AND PLACE THE 2 BIG CONTINENTS: ****************************************************** //
/*================================================================================================================================================*/

        // DEFINE THE CLASS BIG CONTINENT:
		int classBigContinent=rmDefineClass("big continent"); 
		
		// DEFINE THE CLASS BIG CONTINENT CONSTRAINTS:
		int avoidBigContinent=rmCreateClassDistanceConstraint("avoid bonus island", classBigContinent, 25.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
		// THE BIG CONTINENT NUMBER 1:
        int bigContinentID=rmCreateArea("big continent");
        rmSetAreaSize(bigContinentID, 0.3, 0.3);		// 0.65, 0.65
        rmSetAreaWarnFailure(bigContinentID, false);
        //rmAddAreaConstraint(bigContinentID, avoidBigContinent);
        rmAddAreaToClass(bigContinentID, classBigContinent);
        rmSetAreaSmoothDistance(bigContinentID, 5);  //35
	    rmSetAreaMix(bigContinentID, "texas_grass");
        rmSetAreaElevationType(bigContinentID, cElevTurbulence);
        rmSetAreaElevationVariation(bigContinentID, 3.0);
        rmSetAreaBaseHeight(bigContinentID, 6.0);
        rmSetAreaElevationMinFrequency(bigContinentID, 0.09);
        rmSetAreaElevationOctaves(bigContinentID, 3);
        rmSetAreaElevationPersistence(bigContinentID, 0.2);      
	    rmSetAreaCoherence(bigContinentID, 0.75);  //0.90
	    rmSetAreaLocation(bigContinentID, 0.00, 0.00);
        rmSetAreaEdgeFilling(bigContinentID, 5);
	    rmSetAreaObeyWorldCircleConstraint(bigContinentID, false);
	    rmBuildArea(bigContinentID);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		// THE BIG CONTINENT NUMBER 2:
        int bigContinent2ID=rmCreateArea("big continent 2");
        rmSetAreaSize(bigContinent2ID, 0.3, 0.3);		// 0.65, 0.65
        rmSetAreaWarnFailure(bigContinent2ID, false);
        //rmAddAreaConstraint(bigContinent2ID, longPlayerConstraint);
        rmAddAreaToClass(bigContinent2ID, classBigContinent);
        rmSetAreaSmoothDistance(bigContinent2ID, 5);
	    rmSetAreaMix(bigContinent2ID, "texas_grass");
        rmSetAreaElevationType(bigContinent2ID, cElevTurbulence);
        rmSetAreaElevationVariation(bigContinent2ID, 3.0);
        rmSetAreaBaseHeight(bigContinent2ID, 6.0);
        rmSetAreaElevationMinFrequency(bigContinent2ID, 0.09);
        rmSetAreaElevationOctaves(bigContinent2ID, 3);
        rmSetAreaElevationPersistence(bigContinent2ID, 0.2);      
	    rmSetAreaCoherence(bigContinent2ID, 0.50);
	    rmSetAreaLocation(bigContinent2ID, 1.00, 1.00);
        rmSetAreaEdgeFilling(bigContinent2ID, 5);
	    rmSetAreaObeyWorldCircleConstraint(bigContinent2ID, false);
	    rmBuildArea(bigContinent2ID);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/   
		
	// ADD THE 2 BIG CONTINENT CONSTRAINTS:
    int bigContinentConstraint=rmCreateAreaConstraint("big continent", bigContinentID); // force objects to remain in bigContinentID area:
    int bigContinent2Constraint=rmCreateAreaConstraint("big continent 2", bigContinent2ID); // force objects to remain in bigContinent2ID area:
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.30);
/*================================================================================================================================================*/
// ********************************** BUILD UP SMALL CONTINENT SPURS CALLED "SMALL CONTINENT SPUR 1 TO 4": ************************************** //
/*================================================================================================================================================*/
		
		// DEFINE AND PLACE THE SMALL CONTINENT SPUR 1:
		int smallContinent1ID=rmCreateArea("small continent spur 1");
        rmSetAreaSize(smallContinent1ID, 0.035, 0.035);
        rmSetAreaWarnFailure(smallContinent1ID, false);
        rmAddAreaToClass(smallContinent1ID, classBigContinent);
		//rmAddAreaConstraint(smallContinent1ID, avoidImpassableLand);
		//rmAddAreaConstraint(smallContinent1ID, longPlayerConstraint);
        rmSetAreaSmoothDistance(smallContinent1ID, 5);
	    rmSetAreaMix(smallContinent1ID, "texas_grass");
        rmSetAreaElevationType(smallContinent1ID, cElevTurbulence);
        rmSetAreaElevationVariation(smallContinent1ID, 2.0);
        rmSetAreaBaseHeight(smallContinent1ID, 6.0);
        rmSetAreaElevationMinFrequency(smallContinent1ID, 0.09);
		rmSetAreaElevationOctaves(smallContinent1ID, 3);
        rmSetAreaElevationPersistence(smallContinent1ID, 0.2);      
	    rmSetAreaCoherence(smallContinent1ID, 0.75);
	    rmSetAreaLocation(smallContinent1ID, 0.05, 0.65);
        rmSetAreaEdgeFilling(smallContinent1ID, 0);
        rmSetAreaObeyWorldCircleConstraint(smallContinent1ID, false);

	    rmBuildArea(smallContinent1ID);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE AND PLACE THE SMALL CONTINENT SPUR 2:
		int smallContinent2ID=rmCreateArea("small continent spur 2");
        rmSetAreaSize(smallContinent2ID, 0.035, 0.035);
        rmSetAreaWarnFailure(smallContinent2ID, false);
        rmAddAreaToClass(smallContinent2ID, classBigContinent);
		//rmAddAreaConstraint(smallContinent2ID, avoidImpassableLand);
        rmSetAreaSmoothDistance(smallContinent2ID, 5); //0
	    rmSetAreaMix(smallContinent2ID, "texas_grass");
        rmSetAreaElevationType(smallContinent2ID, cElevTurbulence);
        rmSetAreaElevationVariation(smallContinent2ID, 2.0);
        rmSetAreaBaseHeight(smallContinent2ID, 6.0);
        rmSetAreaElevationMinFrequency(smallContinent2ID, 0.09);
        rmSetAreaElevationOctaves(smallContinent2ID, 3);
        rmSetAreaElevationPersistence(smallContinent2ID, 0.2);      
	    rmSetAreaCoherence(smallContinent2ID, 0.5); //1.0
	    rmSetAreaLocation(smallContinent2ID, 0.65, 0.05);
        rmSetAreaEdgeFilling(smallContinent2ID, 0);
        rmSetAreaObeyWorldCircleConstraint(smallContinent2ID, false);

	    rmBuildArea(smallContinent2ID);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE AND PLACE THE SMALL CONTINENT SPUR 3:
		int smallContinent3ID=rmCreateArea("small continent spur 3");
        rmSetAreaSize(smallContinent3ID, 0.035, 0.035);
        rmSetAreaWarnFailure(smallContinent3ID, false);
        rmAddAreaToClass(smallContinent3ID, classBigContinent);
		//rmAddAreaConstraint(smallContinent3ID, longPlayerConstraint);
        rmSetAreaSmoothDistance(smallContinent3ID, 5);
	    rmSetAreaMix(smallContinent3ID, "texas_grass");
        rmSetAreaElevationType(smallContinent3ID, cElevTurbulence);
        rmSetAreaElevationVariation(smallContinent3ID, 2.0);
        rmSetAreaBaseHeight(smallContinent3ID, 6.0);
        rmSetAreaElevationMinFrequency(smallContinent3ID, 0.09);
        rmSetAreaElevationOctaves(smallContinent3ID, 3);
        rmSetAreaElevationPersistence(smallContinent3ID, 0.2);      
	    rmSetAreaCoherence(smallContinent3ID, 0.5);
	    rmSetAreaLocation(smallContinent3ID, 0.35, 0.95);
        rmSetAreaEdgeFilling(smallContinent3ID, 0);
        rmSetAreaObeyWorldCircleConstraint(smallContinent3ID, false);

	    rmBuildArea(smallContinent3ID);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // DEFINE AND PLACE THE SMALL CONTINENT SPUR 4:
		int smallContinent4ID=rmCreateArea("small continent spur 4");
        rmSetAreaSize(smallContinent4ID, 0.035, 0.035);
        rmSetAreaWarnFailure(smallContinent4ID, false);
        rmAddAreaToClass(smallContinent4ID, classBigContinent);
		//rmAddAreaConstraint(smallContinent4ID, longPlayerConstraint);
        rmSetAreaSmoothDistance(smallContinent4ID, 5);
	    rmSetAreaMix(smallContinent4ID, "texas_grass");
        rmSetAreaElevationType(smallContinent4ID, cElevTurbulence);
        rmSetAreaElevationVariation(smallContinent4ID, 2.0);
        rmSetAreaBaseHeight(smallContinent4ID, 6.0);
        rmSetAreaElevationMinFrequency(smallContinent4ID, 0.09);
        rmSetAreaElevationOctaves(smallContinent4ID, 3);
        rmSetAreaElevationPersistence(smallContinent4ID, 0.2);      
	    rmSetAreaCoherence(smallContinent4ID, 0.5);
	    rmSetAreaLocation(smallContinent4ID, 0.95, 0.35);
        rmSetAreaEdgeFilling(smallContinent4ID, 0);
        rmSetAreaObeyWorldCircleConstraint(smallContinent4ID, false);

	    rmBuildArea(smallContinent4ID);				
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.35);
/*================================================================================================================================================*/
// *********************************************** DEFINE AND PLACE THE PLAYER STARTING LOCATIONS: ********************************************** //
/*================================================================================================================================================*/
		
	    if ( cNumberTeams == 2 )
	{
		rmSetPlacementTeam(0);
		rmPlacePlayersLine(0.4, 0.125, 0.125, 0.4, 0.0, 0.0);

		rmSetPlacementTeam(1);
		rmPlacePlayersLine(0.6, 0.875, 0.875, 0.6, 0.0, 0.0);
	}	

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.40);
/*================================================================================================================================================*/
// ************************************************** DEFINE AND PLACE THE SET UP PLAYER AREAS: ************************************************* //
/*================================================================================================================================================*/

        float playerFraction=rmAreaTilesToFraction(2750);
		
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
		// rmAddAreaConstraint(id, playerConstraint); 
        // rmAddAreaConstraint(id, playerEdgeConstraint);
		
	    // SET AREA COHERENCE:
		rmSetAreaCoherence(id, 0.7);
	rmSetAreaSmoothDistance(id, 0.7);
        
		// SET AREA MIX:
		//rmSetAreaMix(id, "rockies_grass");
		//rmSetAreaMix(id, "rockies_snow");
		rmSetAreaMix(id, "city_jawa");	  
      
	    // SET AREA LOC PLAYER:
		rmSetAreaLocPlayer(id, i);
      
	    // SET AREA WARN FAILURE:
		rmSetAreaWarnFailure(id, false);
   }

        // BUILD THE AREAS:
        rmBuildAllAreas();
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
// ********************************************** CLEAR OUT CONSTRAINTS FOR GOOD MEASURES: ****************************************************** //
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        // CLEAR CLOSEST POINT CONSTRAINTS:
		rmClearClosestPointConstraints(); 
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.50);
/*================================================================================================================================================*/
// ************************************************** DEFINE AND PLACE THE LONELY CARIBS: ******************************************************* //
/*================================================================================================================================================*/
        
		// DEFINE THE CLASS NATIVES:
        int classNatives=rmDefineClass("natives");

        // DEFINE THE CLASS NATIVES CONSTRAINTS:
        int nativesConstraint=rmCreateClassDistanceConstraint("stuff vs natives", rmClassID("natives"), 30.0);			
	    int nativesCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs natives", rmClassID("natives"), 15.0);
        int nativesVeryCloseConstraint=rmCreateClassDistanceConstraint("very close stuff vs natives", rmClassID("natives"), 6.0);			

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	
		// THE NATIVES VILLAGE NUMBER 1:
		if (subCiv0 == rmGetCivID("Matraman"))
   {  
		int nativesVillage1ID = -1;
		int	nativesVillageType = rmRandInt(1,4);
        nativesVillage1ID = rmCreateGrouping("natives city 1", "Matraman_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage1ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage1ID, 0.0);
		rmAddGroupingToClass(nativesVillage1ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage1ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage1ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage1ID, 0, 0.65, 0.65);
   }   
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE NATIVES VILLAGE NUMBER 2:
		if (subCiv1 == rmGetCivID("Matraman"))
   {  
		int nativesVillage2ID = -1;
		nativesVillageType = rmRandInt(1,4);
        nativesVillage2ID = rmCreateGrouping("natives city 2", "Matraman_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage2ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage2ID, 0.0);
		rmAddGroupingToClass(nativesVillage2ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage2ID, 0, 0.35, 0.35);
   }   
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE NATIVES VILLAGE NUMBER 3:
		if (subCiv2 == rmGetCivID("Kejawen"))
   {  
		int nativesVillage3ID = -1;
		nativesVillageType = rmRandInt(1,4);
        nativesVillage3ID = rmCreateGrouping("natives city 3", "Kejawen_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage3ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage3ID, 0.0);
		rmAddGroupingToClass(nativesVillage3ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage3ID, 0, 0.6, 0.1);
   }   
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE NATIVES VILLAGE NUMBER 4:
		if (subCiv3 == rmGetCivID("Kejawen"))
   {  
		int nativesVillage4ID = -1;
		nativesVillageType = rmRandInt(1,4);
        nativesVillage4ID = rmCreateGrouping("natives city 4", "Kejawen_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage4ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage4ID, 0.0);
		rmAddGroupingToClass(nativesVillage4ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage4ID, 0, 0.4, 0.9);
   }   
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE NATIVES VILLAGE NUMBER 5:
		if (subCiv4 == rmGetCivID("Pesantren"))
   {  
		int nativesVillage5ID = -1;
		nativesVillageType = rmRandInt(1,4);
        nativesVillage5ID = rmCreateGrouping("natives city 5", "Pesantren_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage5ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage5ID, 0.0);
		rmAddGroupingToClass(nativesVillage5ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage5ID, 0, 0.1, 0.6);
   }   
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		// THE NATIVES VILLAGE NUMBER 6:
		if (subCiv5 == rmGetCivID("Pesantren"))
   {  
		int nativesVillage6ID = -1;
		nativesVillageType = rmRandInt(1,4);
        nativesVillage6ID = rmCreateGrouping("natives city 6", "Pesantren_"+nativesVillageType);
        rmSetGroupingMinDistance(nativesVillage6ID, 0.0);
        rmSetGroupingMaxDistance(nativesVillage6ID, 0.0);
		rmAddGroupingToClass(nativesVillage6ID, rmClassID("natives"));
		
		//rmAddGroupingConstraint(nativesVillage2ID, avoidTeamIslands);
		//rmAddGroupingConstraint(nativesVillage2ID, avoidImpassableLand);

		rmPlaceGroupingAtLoc(nativesVillage6ID, 0, 0.9, 0.4);
   }   
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.55);
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


        int whichVariation=-1;
	    whichVariation = rmRandInt(1,2);

	    // DEFINE THE START BERRYBUSH:
		int StartBerryBushID=rmCreateObjectDef("starting berry bush");
		
		if ( whichVariation == 1 )
		{	
	    rmAddObjectDefItem(StartBerryBushID, "SKepel", 5, 4.0);
		}
		else
		{
	    rmAddObjectDefItem(StartBerryBushID, "SBuni", 5, 4.0);
		}
	    rmSetObjectDefMinDistance(StartBerryBushID, 12.0);
	    rmSetObjectDefMaxDistance(StartBerryBushID, 16.0);
	    rmAddObjectDefConstraint(StartBerryBushID, avoidStartingUnitsSmall);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
	
        // DEFINE THE PLAYER DEER HERDS:
		int avoidPlayerDeer=rmCreateTypeDistanceConstraint("deer herds vs deer herds", "deer", 25.0);
		
		// DEFINE THE PLAYER DEER HERDS:
		int playerDeerID=rmCreateObjectDef("player deer herds");
        rmAddObjectDefItem(playerDeerID, "deer", rmRandInt(4,5), 6.0);
        rmSetObjectDefMinDistance(playerDeerID, 35.0);
        rmSetObjectDefMaxDistance(playerDeerID, 40.0);
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
		int avoidStartTrees=rmCreateTypeDistanceConstraint("start area trees vs trees", "STreeSonokeling", 20.0);
		
		// DEFINE THE START AREA TREES:
	    int StartAreaTreeID=rmCreateObjectDef("starting trees");
	    rmAddObjectDefItem(StartAreaTreeID, "STreeSonokeling", rmRandInt(3,6), 6.0);
	    rmSetObjectDefMinDistance(StartAreaTreeID, 20);
	    rmSetObjectDefMaxDistance(StartAreaTreeID, 25);
	    rmAddObjectDefConstraint(StartAreaTreeID, avoidStartResource);
	    rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
		rmAddObjectDefConstraint(StartAreaTreeID, avoidStartTrees);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
        
		int StartMooseID=rmCreateObjectDef("starting moose");
	    rmAddObjectDefItem(StartMooseID, "Pronghorn", 4, 4.0);
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
		
		
		int SoldatSekulID=rmCreateObjectDef("soldat sekul building");
		
			rmAddObjectDefItem(SoldatSekulID, "SoldatSekul", 1, 0.0);
		rmSetObjectDefMinDistance(SoldatSekulID, 16.0);
		rmSetObjectDefMaxDistance(SoldatSekulID, 20.0);
		rmAddObjectDefConstraint(SoldatSekulID, avoidAll);
		
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
   rmSetStatusText("",0.60);
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
		
		
		if (rmGetPlayerCiv(i) ==  rmGetCivID("Germans")) {
			  rmPlaceObjectDefAtLoc(SoldatSekulID, i, rmXMetersToFraction(xsVectorGetX(TCLoc)), rmZMetersToFraction(xsVectorGetZ(TCLoc)));
			}
		
		// PLACE THE STARTING UNITS:
		rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	
		// PLACE THE START BERRYBUSH:
		rmPlaceObjectDefAtLoc(StartBerryBushID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		
		// PLACE THE START AREA TREE:
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// EVERYONE GETS TWO ORE GROUPINGS, ONE PRETTY CLOSE, THE OTHER A LITTLE FURTHER AWAY:
		
		// PLACE THE CLOSE PLAYER GOLD:
		silverType = rmRandInt(1,10);
		playerGoldID = rmCreateObjectDef("player silver closer "+i);
		rmAddObjectDefItem(playerGoldID, "minegold", 1, 0.0);
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
		rmAddObjectDefItem(playerGoldID, "minegold", 1, 0.0);
		//rmAddObjectDefConstraint(playerGoldID, avoidTradeRoute);
		rmAddObjectDefConstraint(playerGoldID, playerGoldConstraint);
		//rmAddObjectDefConstraint(playerGoldID, avoidCliffs);
		rmAddObjectDefConstraint(playerGoldID, avoidAll);
		rmSetObjectDefMinDistance(playerGoldID, 40.0);
		rmSetObjectDefMaxDistance(playerGoldID, 45.0);
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
   rmSetStatusText("",0.65);
/*================================================================================================================================================*/   
// ************************************************** DEFINE AND PLACE THE SILVER MINES: ******************************************************** //        
/*================================================================================================================================================*/
		
		int avoidCoin=rmCreateTypeDistanceConstraint("stuff vs coin", "mine", 30.0);
		int avoidCloseCoin=rmCreateTypeDistanceConstraint("stuff close vs coin", "mine", 15.0);
		int avoidFarCoin=rmCreateTypeDistanceConstraint("far coin vs coin", "mine", 100.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		silverType = -1;
	    int silverID = -1;
		
		if (cNumberNonGaiaPlayers <=2)
		int silverCount = (cNumberNonGaiaPlayers*2.5);
	    else
	    silverCount = (cNumberNonGaiaPlayers*1.25);
        
	    //int silverCount = (cNumberNonGaiaPlayers*2.75);
	    rmEchoInfo("silver count = "+silverCount);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		

	    for(i=0; < silverCount)
	{
	    int southSilverID = rmCreateObjectDef("south silver "+i);
	    rmAddObjectDefItem(southSilverID, "mine", 1, 0.0);
        rmSetObjectDefMinDistance(southSilverID, 0.0);
        rmSetObjectDefMaxDistance(southSilverID, rmXFractionToMeters(0.5));
	    rmAddObjectDefConstraint(southSilverID, avoidFarCoin);
        rmAddObjectDefConstraint(southSilverID, nativesConstraint);
        rmAddObjectDefConstraint(southSilverID, playerMediumConstraint);
	    rmAddObjectDefConstraint(southSilverID, playerEdgeConstraint);
        rmAddObjectDefConstraint(southSilverID, avoidWater12);
        rmAddObjectDefConstraint(southSilverID, bigContinentConstraint);

	    rmPlaceObjectDefAtLoc(southSilverID, 0, 0.5, 0.5);
   }
   
/*------------------------------------------------------------------------------------------------------------------------------------------------*/   

	    for(i=0; < silverCount)
	{
	    int northSilverID = rmCreateObjectDef("north silver "+i);
	    rmAddObjectDefItem(northSilverID, "mine", 1, 0.0);
        rmSetObjectDefMinDistance(northSilverID, 0.0);
        rmSetObjectDefMaxDistance(northSilverID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(northSilverID, avoidFarCoin);
        rmAddObjectDefConstraint(northSilverID, nativesConstraint);
        rmAddObjectDefConstraint(northSilverID, playerMediumConstraint);
	    rmAddObjectDefConstraint(northSilverID, playerEdgeConstraint);
        rmAddObjectDefConstraint(northSilverID, avoidWater12);
        rmAddObjectDefConstraint(northSilverID, bigContinent2Constraint);
	    
	    rmPlaceObjectDefAtLoc(northSilverID, 0, 0.5, 0.5);
   } 

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.70);
/*================================================================================================================================================*/   
// ****************************************************** DEFINE AND PLACE THE FORESTS: ********************************************************* //
/*================================================================================================================================================*/

        // DEFINE THE CLASS FOREST:
		int classForest=rmDefineClass("classForest");
		
		// DEFINE THE CLASS FOREST CONSTRAINT:
		int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 45.0);
		int forestCloseConstraint=rmCreateClassDistanceConstraint("close stuff vs. forest", rmClassID("classForest"), 10.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int forestTreeID = 0;
		
		if (cNumberNonGaiaPlayers <=2)
		int numTries=12*cNumberNonGaiaPlayers; 
	    else
	    numTries=6*cNumberNonGaiaPlayers; 
        int failCount=0;
        
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		for (i=0; <numTries)
   {   
        int forest=rmCreateArea("forest "+i);
        rmSetAreaWarnFailure(forest, false);
        rmSetAreaSize(forest, rmAreaTilesToFraction(150), rmAreaTilesToFraction(400));
        rmSetAreaForestType(forest, "Jawa Lowland Forest");
        rmSetAreaForestDensity(forest, 1.0);
        rmSetAreaForestClumpiness(forest, 0.0);
        rmSetAreaForestUnderbrush(forest, 0.0);
        rmSetAreaMinBlobs(forest, 1);
        rmSetAreaMaxBlobs(forest, 5);
        rmSetAreaMinBlobDistance(forest, 16.0);
        rmSetAreaMaxBlobDistance(forest, 40.0);
        rmSetAreaCoherence(forest, 0.65);
        rmSetAreaSmoothDistance(forest, 10);
        rmAddAreaToClass(forest, rmClassID("classForest"));
        
		rmAddAreaConstraint(forest, forestConstraint);
		rmAddAreaConstraint(forest, nativesCloseConstraint);
        rmAddAreaConstraint(forest, playerCloseConstraint);
		rmAddAreaConstraint(forest, playerEdgeConstraint);
        rmAddAreaConstraint(forest, avoidWater10); 
        rmAddAreaConstraint(forest, avoidCloseCoin); 
        
		if(rmBuildArea(forest)==false)
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
// ***************************************************** DEFINE AND PLACE THE NUGGETS: ********************************************************** //
/*================================================================================================================================================*/

        // DEFINE THE NUGGET CONSTRAINTS:
		int avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "abstractNugget", 25.0);
		int avoidCloseNugget=rmCreateTypeDistanceConstraint("close stuff vs nugget", "abstractNugget", 10.0);
		int avoidFarNugget=rmCreateTypeDistanceConstraint("far nugget avoid nugget", "abstractNugget", 75.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int nugget1= rmCreateObjectDef("nugget easy"); 
	    rmAddObjectDefItem(nugget1, "Nugget", 1, 0.0);
	    rmSetObjectDefMinDistance(nugget1, 0.0);
	    rmSetNuggetDifficulty(1, 4);
	    rmSetObjectDefMaxDistance(nugget1, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(nugget1, playerConstraint);
		rmAddObjectDefConstraint(nugget1, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(nugget1, avoidNugget);
  	    rmAddObjectDefConstraint(nugget1, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(nugget1, avoidCloseCoin);
  	    rmAddObjectDefConstraint(nugget1, avoidWater20);
	    rmAddObjectDefConstraint(nugget1, forestCloseConstraint);
	    
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefInArea(nugget1, 0, bigContinentID, cNumberNonGaiaPlayers*6.0);
        else
		rmPlaceObjectDefInArea(nugget1, 0, bigContinentID, cNumberNonGaiaPlayers*3.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	    int nugget2= rmCreateObjectDef("nugget easy 2"); 
	    rmAddObjectDefItem(nugget2, "Nugget", 1, 0.0);
	    rmSetObjectDefMinDistance(nugget2, 0.0);
	    rmSetNuggetDifficulty(1, 4);
	    rmSetObjectDefMaxDistance(nugget2, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(nugget2, playerConstraint);
		rmAddObjectDefConstraint(nugget2, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(nugget2, avoidNugget);
  	    rmAddObjectDefConstraint(nugget2, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(nugget2, avoidCloseCoin);
  	    rmAddObjectDefConstraint(nugget2, avoidWater20);
	    rmAddObjectDefConstraint(nugget2, forestCloseConstraint);

		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefInArea(nugget1, 0, bigContinent2ID, cNumberNonGaiaPlayers*6.0);
        else
		rmPlaceObjectDefInArea(nugget1, 0, bigContinent2ID, cNumberNonGaiaPlayers*3.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.80);
/*================================================================================================================================================*/
// ******************************************************* DEFINE AND PLACE THE DEER: *********************************************************** //
/*================================================================================================================================================*/

	    // DEFINE THE DEER HERDS CONSTRAINTS:
		int avoidDeer=rmCreateTypeDistanceConstraint("stuff vs deer", "deer", 25.0);
		int avoidCloseDeer=rmCreateTypeDistanceConstraint("close stuff vs deer", "deer", 10.0);
		int avoidFarDeer=rmCreateTypeDistanceConstraint("far deer vs deer", "deer", 60.0);

/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int deerID=rmCreateObjectDef("deer herd");
	    
		int bonusChance=rmRandFloat(0, 1);
        
		if(bonusChance<0.5)   
        rmAddObjectDefItem(deerID, "deer", rmRandInt(3,4), 10.0);
        else
        rmAddObjectDefItem(deerID, "deer", rmRandInt(4,5), 10.0);
        
		rmSetObjectDefMinDistance(deerID, 0.0);
        rmSetObjectDefMaxDistance(deerID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(deerID, playerConstraint);
		rmAddObjectDefConstraint(deerID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(deerID, avoidNugget);
  	    rmAddObjectDefConstraint(deerID, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(deerID, avoidCloseCoin);
  	    rmAddObjectDefConstraint(deerID, avoidWater20);
	    rmAddObjectDefConstraint(deerID, forestCloseConstraint);
	    rmAddObjectDefConstraint(deerID, avoidFarDeer);
    
		rmSetObjectDefCreateHerd(deerID, true);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefInArea(deerID, 0, bigContinentID, cNumberNonGaiaPlayers*4.0);
        else
		rmPlaceObjectDefInArea(deerID, 0, bigContinentID, cNumberNonGaiaPlayers*2.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/

        int deer2ID=rmCreateObjectDef("deer herd 2");
	    
		bonusChance=rmRandFloat(0, 1);
        
		if(bonusChance<0.5)   
        rmAddObjectDefItem(deer2ID, "deer", rmRandInt(3,4), 10.0);
        else
        rmAddObjectDefItem(deer2ID, "deer", rmRandInt(4,5), 10.0);
        
		rmSetObjectDefMinDistance(deer2ID, 0.0);
        rmSetObjectDefMaxDistance(deer2ID, rmXFractionToMeters(0.5));
	    
		rmAddObjectDefConstraint(deer2ID, playerConstraint);
		rmAddObjectDefConstraint(deer2ID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(deer2ID, avoidNugget);
  	    rmAddObjectDefConstraint(deer2ID, nativesCloseConstraint);
  	    rmAddObjectDefConstraint(deer2ID, avoidCloseCoin);
  	    rmAddObjectDefConstraint(deer2ID, avoidWater20);
	    rmAddObjectDefConstraint(deer2ID, forestCloseConstraint);
	    rmAddObjectDefConstraint(deer2ID, avoidFarDeer);
        
		rmSetObjectDefCreateHerd(deer2ID, true);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefInArea(deer2ID, 0, bigContinent2ID, cNumberNonGaiaPlayers*4.0);
        else
		rmPlaceObjectDefInArea(deer2ID, 0, bigContinent2ID, cNumberNonGaiaPlayers*2.0);
	
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.85);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE RANDOM TREES: **************************************************** //
/*================================================================================================================================================*/
        
        // DEFINE THE DEER HERDS CONSTRAINTS:
		int avoidRandomTree=rmCreateTypeDistanceConstraint("trees vs trees", "STreeSonokeling", 3.0);
		int avoidRandomTree2=rmCreateTypeDistanceConstraint("trees vs trees", "STreeTeak", 3.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int randomTreeID=rmCreateObjectDef("random tree");
        rmAddObjectDefItem(randomTreeID, "STreeSonokeling", 1, 0.0);
        rmSetObjectDefMinDistance(randomTreeID, 0.0);
        rmSetObjectDefMaxDistance(randomTreeID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(randomTreeID, playerCloseConstraint);
		rmAddObjectDefConstraint(randomTreeID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(randomTreeID, avoidCloseNugget);
  	    rmAddObjectDefConstraint(randomTreeID, nativesVeryCloseConstraint);
  	    rmAddObjectDefConstraint(randomTreeID, avoidCloseCoin);
  	    rmAddObjectDefConstraint(randomTreeID, avoidWater5);
	    rmAddObjectDefConstraint(randomTreeID, forestCloseConstraint);
	    rmAddObjectDefConstraint(randomTreeID, avoidCloseDeer);
		rmAddObjectDefConstraint(randomTreeID, avoidRandomTree); 
		rmAddObjectDefConstraint(randomTreeID, avoidRandomTree2); 

        rmPlaceObjectDefAtLoc(randomTreeID, 0, 0.5, 0.5, 40*cNumberNonGaiaPlayers);
		
		int randomTree2ID=rmCreateObjectDef("random tree 2");
        rmAddObjectDefItem(randomTree2ID, "STreeTeak", 1, 0.0);
        rmSetObjectDefMinDistance(randomTree2ID, 0.0);
        rmSetObjectDefMaxDistance(randomTree2ID, rmXFractionToMeters(0.5));
		
		rmAddObjectDefConstraint(randomTree2ID, playerCloseConstraint);
		rmAddObjectDefConstraint(randomTree2ID, playerEdgeConstraint);
  	    rmAddObjectDefConstraint(randomTree2ID, avoidCloseNugget);
  	    rmAddObjectDefConstraint(randomTree2ID, nativesVeryCloseConstraint);
  	    rmAddObjectDefConstraint(randomTree2ID, avoidCloseCoin);
  	    rmAddObjectDefConstraint(randomTree2ID, avoidWater5);
	    rmAddObjectDefConstraint(randomTree2ID, forestCloseConstraint);
	    rmAddObjectDefConstraint(randomTree2ID, avoidCloseDeer);
		rmAddObjectDefConstraint(randomTree2ID, avoidRandomTree); 
		rmAddObjectDefConstraint(randomTree2ID, avoidRandomTree2); 

        rmPlaceObjectDefAtLoc(randomTree2ID, 0, 0.5, 0.5, 20*cNumberNonGaiaPlayers);
		
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.90);
/*================================================================================================================================================*/
// ******************************************************* DEFINE AND PLACE THE FISHES: ********************************************************* //
/*================================================================================================================================================*/

        // DEFINE THE SEA FOOD-FISH CONSTRAINTS:
		int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", "AbstractFish", 15.0);
        int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 8.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

		// DEFINE AND PLACE THE FISH MAHI:
		int fishID=rmCreateObjectDef("fish Mahi");
        rmAddObjectDefItem(fishID, "ypFishCarp", 1, 0.0);
        rmSetObjectDefMinDistance(fishID, 0.0);
        rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(fishID, fishVsFishID);
        rmAddObjectDefConstraint(fishID, fishLand);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 30*cNumberNonGaiaPlayers);
        else
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 15*cNumberNonGaiaPlayers);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		

        // DEFINE AND PLACE THE FISH TARPON:
		int fish2ID=rmCreateObjectDef("fish Tarpon");
        rmAddObjectDefItem(fish2ID, "ypFishCatfish", 1, 0.0);
        rmSetObjectDefMinDistance(fish2ID, 0.0);
        rmSetObjectDefMaxDistance(fish2ID, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(fish2ID, fishVsFishID);
        rmAddObjectDefConstraint(fish2ID, fishLand);
		
		if (cNumberNonGaiaPlayers <=2)
		rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.5, 30*cNumberNonGaiaPlayers);
        else
		rmPlaceObjectDefAtLoc(fish2ID, 0, 0.5, 0.5, 15*cNumberNonGaiaPlayers);
        
   
/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",0.95);
/*================================================================================================================================================*/
// ****************************************************** DEFINE AND PLACE THE WHALE: *********************************************************** //
/*================================================================================================================================================*/

        // DEFINE THE SEA MONEY-WHALES CONSTRAINTS:
		int whaleVsWhaleID=rmCreateTypeDistanceConstraint("whale v whale", "HumpbackWhale", 50.0);
        int whaleLand = rmCreateTerrainDistanceConstraint("whale land", "land", true, 25.0);
		
/*------------------------------------------------------------------------------------------------------------------------------------------------*/		
		
		int whaleID=rmCreateObjectDef("whale");
        rmAddObjectDefItem(whaleID, "HumpbackWhale", 1, 0.0); //This must be replaced with fucking pesoot
        rmSetObjectDefMinDistance(whaleID, 0.0);
        rmSetObjectDefMaxDistance(whaleID, rmXFractionToMeters(0.5));
        rmAddObjectDefConstraint(whaleID, whaleVsWhaleID);
        rmAddObjectDefConstraint(whaleID, whaleLand);
        rmPlaceObjectDefAtLoc(whaleID, 0, 0.5, 0.5, 4*cNumberNonGaiaPlayers);

/*================================================================================================================================================*/
   // TEXT:
   // THESE STATUS TEXT LINES ARE USED TO MANUALLY ANIMATE THE MAP GENERATION PROGRESS BAR:
   rmSetStatusText("",1.00);
/*================================================================================================================================================*/
}
/*================================================================================================================================================*/
// ******************************************************** THIS IS THE END OF THE MAP: ********************************************************* //
/*================================================================================================================================================*/
