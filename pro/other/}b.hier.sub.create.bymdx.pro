﻿601,100
602,"}b.hier.sub.create.bymdx"
562,"NULL"
586,
585,
564,
565,"rhrGKUmXor?74rOq^Ia]MXzXBcw^WJ6\DeT\OxP?[1]w0X78Q0Fys@V:g54>Bw=Y>fR`@sMSqmHy[53;OOs3MKAeV752Mn?4]0G:WvRNWw03^\we_M=tL]I;Nx:VOgd0wBVsj`6lwfAYWap5rwuz@9uzPW;mAQEI8KLK4YP_=ZBFyXJ5=\U:F?HJ_BF_KhM1kbNr@aLE"
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
570,
571,
569,0
592,0
599,1000
560,9
pLogOutput
pStrictErrorHandling
pDim
pHier
pSub
pMDXExpr
pConvertToStatic
pTemp
pAlias
561,9
1
1
2
2
2
2
1
1
2
590,9
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pSub,""
pMDXExpr,""
pConvertToStatic,1
pTemp,1
pAlias,""
637,9
pLogOutput,"Optional: write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"Required: Dimension name"
pHier,"Optional: Hierarchy name (default if blank = same named hierarchy)"
pSub,"Required: Subset name"
pMDXExpr,"Required: Valid MDX Expression for Specified Dimension"
pConvertToStatic,"Optional: Bolean: 1 = True (convert to static subset)"
pTemp,"Optional: Use temporary objects? (Boolean 1=True)"
pAlias,"Optional: Set Alias for Subset"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,162
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}b.hier.sub.create.bymdx', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pSub', '',
    	'pMDXExpr', '',
    	'pConvertToStatic', 1, 'pTemp', 1
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

#Region @DOC
# Description:
# This process will Create a dynamic subset from an MDX expression that evaluates to a non-empty set in the specified dimension.

# Use case: Intended for Production & Development
#1/ Create a dynamic subset for use in a view

# Note:
# Naturally, valid dimension name (pDim) are mandatory otherwise the process will abort.
# If the MDX does not compile or produces an empty set, the process will error.
# If convert to static (pConvertToStatic) is set to 1 then the MDX subset will be replaced by a static subset.
#EndRegion @DOC

### Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName   = GetProcessName();
cTimeStamp      = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt      = NumberToString( INT( RAND( ) * 1000 ));
cTempSub        = cThisProcName | '_' | cTimeStamp | '_' | cRandomInt;
cTempFile       = GetProcessErrorFileDirectory | cTempSub | '.csv';
cUserName       = TM1User();
cMsgErrorLevel  = 'ERROR';
cMsgErrorContent= 'User:%cUserName% Process:%cThisProcName% ErrorMsg:%sMessage%';
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pSub:%pSub%, pMDXExpr:%pMDXExpr%, pConvertToStatic:%pConvertToStatic%, pTemp:%pTemp%, pAlias:%pAlias%.' ;
sMDXExpr        = pMDXExpr;

## LogOutput parameters
IF( pLogoutput  = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###

nErrors         = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension
If( Trim( pDim )  @= '' );
    nErrors     = 1;
    sMessage    = 'No dimension specified';
    DataSourceType= 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

If( DimensionExists( pDim ) = 0 );
    nErrors     = 1;
    sMessage    = 'Invalid dimension: ' | pDim;
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate hierarchy
If( Trim( pHier ) @= '' );
    sHier = pDim;
Else;
    sHier = pHier;
EndIf;

IF(HierarchyExists(pDim, pHier ) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension Hierarchy: ' | pDim |':'|pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate subset
If( Trim( pSub ) @= '' );
    nErrors = 1;
    sMessage = 'No subset specified';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate MDX
If( Trim( sMDXExpr ) @= '' );
    nErrors = 1;
    sMessage = 'No MDX expression specified.';
    DataSourceType = 'NULL';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

## Validate pTemp
IF( pTemp <> 0 & pTemp <> 1 );
    nErrors = 1;
    sMessage = 'Wrong parameter pTemp value (only 0 or 1 accepted).';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Alias exists
If ( pAlias @<> '' & 
    DimIx ( Expand ( '}ElementAttributes_%pDim%' ), pAlias ) = 0
);
  nErrors = 1;
  sMessage = 'Alias does not exist in dimension %pDim%.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;  

# Validate alias attribute name is actually an alias
If ( pAlias @<> '' & 
    Dtype ( Expand ( '}ElementAttributes_%pDim%' ), pAlias ) @<> 'AA'  
);
  nErrors = 1;
  sMessage = 'Attribute %pAlias% is not an alias in dimension %pDim%.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;


### Create Subset ###
If( nErrors = 0 );
  If( ElementCount( pDim, sHier ) = 0 & pConvertToStatic <> 0);
    HierarchySubsetCreate( pDim, sHier, pSub );
  Else;
    If( HierarchySubsetExists( pDim,sHier, pSub ) = 1 );
        HierarchySubsetMDXSet( pDim, sHier, pSub, sMDXExpr );
    Else;
        SubsetCreateByMDX( pSub, sMDXExpr, pDim|':'|sHier, pTemp );
    EndIf;
    If( pConvertToStatic = 1 );
        HierarchySubsetElementInsert( pDim, sHier, pSub, ElementName( pDim, sHier, 1 ), 1 );
        HierarchySubsetElementDelete( pDim, sHier, pSub, 1 );
    EndIf;
  EndIf;
  
  # Set Alias
  If ( pAlias @<> '' );
      If ( pDim @= sHier );
          SubsetAliasSet( pDim, pSub, pAlias);
      Else;
          SubsetAliasSet( pDim | ':' | sHier, pSub, pAlias);
      EndIf;
  EndIf;
EndIf;


### End Prolog ###
573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,33

#****Begin: Generated Statements***
#****End: Generated Statements****

### Destroy Temporary Subset ###

If( pConvertToStatic = 1 & pTemp = 0 );

  If( HierarchySubsetExists( pDim , pHier, cTempSub) = 1 );
    HierarchySubsetDestroy( pDim, pHier, cTempSub );
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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully created subset %pSub% from dimension %pDim%.' );
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
917,0
918,1
919,0
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
