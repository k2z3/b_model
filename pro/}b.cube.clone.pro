﻿601,100
602,"}b.cube.clone"
562,"NULL"
586,"z_gen_cube"
585,"z_gen_cube"
564,
565,"ce2yTPTD?Z3C:dSX2=eM7TRQ__e[OHf:FqX<wxPYMxk8zm9h`x]wipOF^]uWTTqFspJpJ6N<u?Njb_ImS7xFjaBZ@KBBPYpMw2a<MvQGOvFjq>mlH0ctZXL8D^2FY2LK^yEA21O;xreV`7:f7[?9MPEV4i?VYN<?kX`m4iujq4VwdtRsu?V@tArt9AUHc@F_0S:pP1iZ"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,","
568,""""
570,{sys
571,
569,0
592,0
599,1000
560,13
pLogOutput
pStrictErrorHandling
pSrcCube
pTgtCube
pIncludeRules
pIncludeData
pFilter
pDimDelim
pEleStartDelim
pEleDelim
pSuppressRules
pTemp
pCubeLogging
561,13
1
1
2
2
1
1
2
2
2
2
1
1
1
590,13
pLogOutput,0
pStrictErrorHandling,0
pSrcCube,""
pTgtCube,""
pIncludeRules,1
pIncludeData,0
pFilter,""
pDimDelim,"&"
pEleStartDelim,"|"
pEleDelim,"+"
pSuppressRules,1
pTemp,1
pCubeLogging,0
637,13
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcCube,"REQUIRED: Source Cube"
pTgtCube,"OPTIONAL: Target Cube to create/re-create (Source cube_clone if left blank)"
pIncludeRules,"REQUIRED: Include cube rules? (Boolean Yes = 1)"
pIncludeData,"REQUIRED: Include cube data? (Boolean Yes = 1)"
pFilter,"OPTIONAL: Filter on source cube in format Year| 2006 + 2007 & Scenario| Actual + Budget. Blank for whole cube"
pDimDelim,"OPTIONAL: Delimiter for start of Dimension/Element set  (default value if blank = '&')"
pEleStartDelim,"OPTIONAL: Delimiter for start of element list  (default value if blank = '|')"
pEleDelim,"OPTIONAL: Delimiter between elements (default value if blank = '+')"
pSuppressRules,"REQUIRED: Skip rule values? (1=skip)"
pTemp,"REQUIRED: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )"
pCubeLogging,"Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,179
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}b.cube.clone', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pSrcCube' ,'', 'pTgtCube', '',
    	'pIncludeRules', 1, 'pIncludeData', 0,
    	'pFilter', '',
    	'pDimDelim', '&', 'pEleStartDelim', '|', 'pEleDelim', '+',
    	'pSuppressRules', 1, 'pTemp', 1, 'pCubeLogging', 0
    );
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

#Region @DOC
# Description:
# This process replicates an existing cube. It can include data & rules too.

# Use case: Intended for development/prototyping.
# 1. Take a snapshot of cube data copying all rules to values.
# 2. Take an exact copy of a cube in a "one click action" as a starting point for prototyping rule changes or developing new features.

# Note:
# * There are parameter options to include data (pIncludeData) and rules (pIncludeRules) with the creation of the cube.
# * If the source cube (pSrcCube) is left blank or doesn't exist in the model, process will terminate withoud doing anything.
# * If the target cube (pTgtCube) already exists in the model, process will terminate withoud doing anything.
# * If the target cube is left blank or is the same as the source cube the cloned cube will inherit the source cube name with "_Clone" appended.
# * If the source cube data only needs to be partially copied, then the pFilter parameter should be entered otherwise all other parameters can be left as is.
# * In productive systems this process may be called internally by other processes (}b.cube.data.copy, }b.cube.data.copy.intercube) if copying data via intermediate cloned cube.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cUserName       = TM1User();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pSrcCube:%pSrcCube%, pTgtCube:%pTgtCube%, pIncludeRules:%pIncludeRules%, pIncludeData:%pIncludeData%, pFilter:%pFilter%, pDimDelim:%pDimDelim%, pEleStartDelim:%pEleStartDelim%, pEleDelim:%pEleDelim%, pSuppressRules:%pSuppressRules%, pTemp:%pTemp%, pCubeLogging:%pCubeLogging%.' ;   
cDimCountMax    = 30 ;

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Initialise ###
nErrors         = 0;
nDataCheck      = 0;
sDimCountMax    = NumberToString( cDimCountMax );
sDimsString     = '';
sDelim          = '+';

### Validate Parameters ###

## Default filter delimiters
If( pDimDelim     @= '' );
    pDimDelim     = '&';
EndIf;
If( pEleStartDelim@= '' );
    pEleStartDelim= '|';
EndIf;
If( pEleDelim     @= '' );
    pEleDelim     = '+';
EndIf;

# Validate source cube
If( Trim( pSrcCube ) @= '' );
    nErrors = 1;
    sMessage = 'No cube specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( CubeExists( pSrcCube ) = 0 );    
    sMessage = Expand( 'Invalid source cube specified: %pSrcCube%.' );
    nErrors = 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate target cube
If( pTgtCube @= '' % pTgtCube @= pSrcCube );
    pTgtCube = pSrcCube | '{repl';
EndIf;
If( CubeExists( pTgtCube ) = 1 );    
    sMessage = Expand( 'Invalid target cube : %pTgtCube%.' );
    nErrors = 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Create the clone cube ###
nDimCount = 1;
While( TabDim( pSrcCube, nDimCount ) @<> '' );
  sDimName = TabDim (pSrcCube, nDimCount);
  sDimsString = sDimsString | sDimName | sDelim;
  nDimCount = nDimCount + 1;
End;
nDimCount = nDimCount - 1;
sDimsString = Subst(sDimsString,1,long(sDimsString)-long(sDelim));

If( nDimCount > cDimCountMax );
  nErrors = 1;
  sMessage = Expand( 'Cube has too many dimensions: %pSrcCube% max %sDimCountMax% dims catered for, TI must be altered to accomodate.' );
  DataSourceType = 'NULL';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

sProc = '}b.cube.create';
nRet = ExecuteProcess( sProc,
  'pLogOutput', pLogOutput,
  'pStrictErrorHandling', pStrictErrorHandling,
  'pCube', pTgtCube,
  'pDims', sDimsString,
  'pRecreate', 1,
  'pDelim', sDelim
  );

IF(nRet <> 0);
  sMessage = 'Error creating the target cube.';
  nErrors = 1;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
ENDIF;


### copy data ####
If( pIncludeData = 1 );
nRet = ExecuteProcess('}b.cube.data.copy.intercube',
    'pLogOutput', pLogOutput,
    'pStrictErrorHandling', pStrictErrorHandling,
  	'pSrcCube',pSrcCube,
  	'pFilter',pFilter,
  	'pTgtCube',pTgtCube,
  	'pMappingToNewDims','',
  	'pSuppressConsol',1,
  	'pSuppressRules',pSuppressRules,
  	'pZeroTarget',0,
  	'pZeroSource',0,
  	'pFactor',1,
    'pDimDelim', pDimDelim,
    'pEleStartDelim', pEleStartDelim,
    'pEleDelim', pEleDelim,
    'pTemp', pTemp,
    'pCubeLogging', pCubeLogging);

  IF(nRet <> 0);
    sMessage = 'Error copying data.';
    nErrors = nErrors + 1;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    Else;
        ProcessBreak;
    EndIf;
  ENDIF;

EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,7

#****Begin: Generated Statements***
#****End: Generated Statements****




575,33

#****Begin: Generated Statements***
#****End: Generated Statements****

### Attach rules to cloned cube ###
If( nErrors = 0 & pIncludeRules = 1 );
  sRuleFile = pSrcCube | '.rux';
  If( FileExists( sRuleFile ) = 1 );
    If( nErrors = 0 );
      RuleLoadFromFile( pTgtCube, sRuleFile );
    EndIf;
  EndIf;
EndIf;
    
### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% successfully cloned the %pSrcCube% cube to %pTgtCube%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

### End Epilog ###
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,1
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,1
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
