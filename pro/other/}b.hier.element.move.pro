﻿601,100
602,"}b.hier.element.move"
562,"NULL"
586,
585,
564,
565,"i;qyWrvINaXr4q3;rCnTYZMmA?Faj8<BvT:YH^KBMFL=99d8<CdC;pQrCB=7DuX@V:\:o`QBaXmfgZCEoIX:PKor`GlIXH0U?p@p``JV2EAH<Z:Vuxh28yzy2Ax_q_FULHM>D=X=^WeTZ:q@Z:e51D^KAw?QO7grutDz36Ne>@q;UEF\Eh=Fh2[qq2@MFXdjoWg^B7mN"
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
560,8
pLogOutput
pStrictErrorHandling
pDim
pHier
pEle
pTgtConsol
pMode
pWeight
561,8
1
1
2
2
2
2
2
1
590,8
pLogOutput,0
pStrictErrorHandling,0
pDim,""
pHier,""
pEle,""
pTgtConsol,""
pMode,"Add"
pWeight,1
637,8
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pDim,"REQUIRED: Dimension Name"
pHier,"OPTIONAL: Hierarchy Name"
pEle,"REQUIRED: Element Name"
pTgtConsol,"REQUIRED: Target Consolidation"
pMode,"REQUIRED: Add or Remove Element from Hierarchy"
pWeight,"OPTIONAL: Element Weight (for Add only)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,146
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}b.hier.element.move', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
    	'pDim', '', 'pHier', '', 'pEle', '',
    	'pTgtConsol', '', 'pMode', 'Add', 'pWeight', 1
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

#Region @DOC
# Description:
# This process will Add or Remove Element from a Consolidation in a Hierarchy.

# Note:
# Valid dimension name (pDim), consolidated element name (pTgtConsol) and element name (pEle)
# otherwise the process will abort. Mode can be either Add to add or Remove to remove the element
# from a consolidation. 

# Caution: Target hierarchy cannot be `Leaves`.
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
cLogInfo        = 'Process:%cThisProcName% run with parameters pDim:%pDim%, pHier:%pHier%, pEle:%pEle%, pTgtConsol:%pTgtConsol%, pMode:%pMode%, pWeight:%pWeight%.';

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

### Validate Parameters ###
nErrors = 0;

If( Scan( ':', pDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pDim, Scan( ':', pDim ) + 1, Long( pDim ) );
    pDim        = SubSt( pDim, 1, Scan( ':', pDim ) - 1 );
EndIf;

# Validate dimension
If( Trim( pDim ) @= '' );
    nErrors = 1;
    sMessage = 'No dimension specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( DimensionExists( pDim ) = 0 );
    nErrors = 1;
    sMessage = 'Dimension ' | pDim | ' does not exist on server.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Hierarchy
If( Trim( pHier ) @= '' );
    sHier = Trim( pDim );
Else;
    sHier = Trim( pHier );
EndIf;
If( sHier @= 'Leaves' );
    nErrors = 1;
    sMessage = 'Invalid  Hierarchy: ' | pDim |':'|sHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( HierarchyExists( pDim, sHier ) = 0 );
    nErrors = 1;
    sMessage = 'The Hierachy ' | sHier | ' does not exist in dimension ' | pDim;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate Element
If( Trim( pEle ) @= '' );
    nErrors = 1;
    sMessage = 'No element specified.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( ElementIndex ( pDim, sHier, pEle ) = 0 );
    nErrors = 1;
    sMessage = 'Element: ' | pEle | ' does not exist in dimension: ' | pDim|':'| sHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate target consol
If( ElementIndex ( pDim, sHier, pTgtConsol ) = 0  );
    nErrors = 1;
    sMessage = 'Consolidated Element: ' | pTgtConsol | ' does not exist in dimension: ' | pDim|':'| sHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIf( ElementType( pDim, sHier, pTgtConsol ) @<> 'C' );
    nErrors = 1;
    sMessage = 'Target Consolidation: ' | pTgtConsol | ' has incorrect element type.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;
If( ElementIsAncestor( pDim, sHier, pEle, pTgtConsol ) = 1 );
    nErrors = 1;
    sMessage = 'Cannot add element: ' | pEle | ' to consolidation: ' | pTgtConsol | ' due to circular reference.';
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

# Validate action
If( pMode @<> 'Add' & pMode @<> 'Remove' );
    nErrors = 1;
    sMessage = 'Invalid action: ' | pMode | '. Valid actions are Add or Remove';
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


### Insert Element into consolidation ###
If( pMode @= 'Add' );
    HierarchyElementComponentAdd( pDim, sHier, pTgtConsol, pEle, pWeight );
EndIf;


### Remove Element from consolidation ###
If( pMode @= 'Remove' );
    # Check that element is actually a child of target consol
    If( ElementIsComponent ( pDim, sHier, pEle, pTgtConsol ) = 1 );
        HierarchyElementComponentDelete( pDim, sHier, pTgtConsol, pEle );
    Else;
        nErrors = 1;
        sMessage = 'Element: ' | pEle | ' is not a child of consolidation: ' | pTgtConsol;
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    EndIf;
EndIf;


### End Prolog ###
573,4

#****Begin: Generated Statements***
#****End: Generated Statements****

574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,25

#****Begin: Generated Statements***
#****End: Generated Statements****

### If errors occurred terminate process with a major error status ###
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 major error and consequently aborted. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% aborted. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
EndIf;

### Return Code
sProcessAction      = Expand( 'Process:%cThisProcName% successfully %pMode%ed element %pEle% to/from %pTgtConsol% in the %pDim%:%pHier% dimension:hierarchy.' );
sProcessReturnCode  = Expand( '%sProcessReturnCode% %sProcessAction%' );
nProcessReturnCode  = 1;
If( pLogoutput = 1 );
    LogOutput('INFO', Expand( sProcessAction ) );   
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
