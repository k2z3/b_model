601,100
602,"}b.security.cube.cellsecurity.destroy"
562,"NULL"
586,
585,
564,
565,"s9`lhW?<9KcEfc]KbDNz:^agtAezRFbprjY763Y3BlO4iZeUVH0p2L_itWi^bl9U^0QVpxBppVApUQECP_H2ks`41mCx052_3fsQOBjvfBiT]yuYS56UCgV<oCD\gDBK80MCjmF08qI;Sn5gU[ZViqe]:3hpDIR3\Gda4YAQD2VfHUB\ajNqH>T_4wrC[FH9SV5P[[Ls9`lhW?<9KcEfc]KbDNt:^agtAezRFb0xjY763Y3BlO4iZhUVH0p2L_it'_TbliR^0Q_QpxBppfMp5TECP_H2ks`41}Bx052_3fsWOBjvfBiT]I4US56UCgV<oCD\J@BKh6mMjmF08qi6Sn5jU[j_iqe]:3hpDIR3\wea49MQD2V&KUB\ajNqX0T_4wrC[JH3SV5P[[L"
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
560,4
pLogOutput
pStrictErrorHandling
pCube
pDelim
561,4
1
1
2
2
590,4
pLogOutput,0
pStrictErrorHandling,0
pCube,""
pDelim,"&"
637,4
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pCube,"REQUIRED: List of Cubes (Separated by Delimiter, Accepts Wild card)"
pDelim,"OPTIONAL: Delimiter (Defaults to & if left blank.)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,141
#Region CallThisProcess
# A snippet of code provided as an example how to call this process should the developer be working on a system without access to an editor with auto-complete.
If( 1 = 0 );
    ExecuteProcess( '}b.security.cube.cellsecurity.destroy', 'pLogOutput', pLogOutput,
      'pStrictErrorHandling', pStrictErrorHandling,
	    'pCube', '', 'pDelim', '&'
	);
EndIf;
#EndRegion CallThisProcess

#****Begin: Generated Statements***
#****End: Generated Statements****

#Region @DOC
# Description:
# This process will destroy the cell security cube(s) for the specified cube(s).

# Use case: Intended for development.
# 1/ Remove cell level security for one or more cubes.

# Note:
# Naturally, a valid cube (pCube) is mandatory otherwise the process will abort.
# If the cube does not have cell security set up, it will skip that cube but log an error.
# Multiple cubes can be specified separated by the pDelim or by using wildcards (*).
#EndRegion @DOC

##Global Variables
StringGlobalVariable('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode= 0;

### Constants ###
cThisProcName = GetProcessName();
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt = NumberToString( INT( RAND( ) * 1000 ));
DatasourceASCIIQuoteCharacter = '';
cUserName         = TM1User();
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo          = 'Process:%cThisProcName% run with parameters pCube:%pCube%, pDelim:%pDelim%.' ;  

## LogOutput parameters
IF( pLogoutput = 1 );
    LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;

## check operating system
If( SubSt( GetProcessErrorFileDirectory, 2, 1 ) @= ':' );
  sOS = 'Windows';
  sOSDelim = '\';
ElseIf( Scan( '/', GetProcessErrorFileDirectory ) > 0 );
  sOS = 'Linux';
  sOSDelim = '/';
Else;
  sOS = 'Windows';
  sOSDelim = '\';
EndIf;

### Validate Parameters ###
nErrors = 0;

# If blank delimiter specified then convert to default
If( pDelim @= '' );
    pDelim = '&';
EndIf;

# If no cubes have been specified then terminate process
If( Trim( pCube ) @= '' );
    nErrors = 1;
    sMessage = 'No cube(s) specified.';
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

### Split pCubes into individual Cubes  ###
sCubes                  = pCube;
nDelimiterIndex         = 1;
While( nDelimiterIndex <> 0 );
    nDelimiterIndex     = Scan( pDelim, sCubes );
    If( nDelimiterIndex = 0 );
        sCube           = sCubes;
    Else;
        sCube           = Trim( SubSt( sCubes, 1, nDelimiterIndex - 1 ) );
        sCubes          = Trim( Subst( sCubes, nDelimiterIndex + Long(pDelim), Long( sCubes ) ) );
    EndIf;
  
    # Check if a wildcard has been used to specify the Cube name.
    # If it hasn't then just delete the Cube if it exists
    # If it has then search the relevant Cube folder to find the matches
    If( Scan( '*', sCube ) = 0 );
        If( CubeExists( sCube ) = 1 ); 
            If(CubeExists( '}CellSecurity_' | sCube ) = 1);
                nRet = CellSecurityCubeDestroy( sCube );
                If( nRet = 1 );
                    sMessage = '}CellSecurity_' | sCube | ' successfully destroyed.';
                    LogOutput( 'INFO', Expand( cMsgErrorContent ) );
                Else;
                    nErrors = 1;
                    sMessage = 'Error. Could not destroy }CellSecurity_' | sCube;
                    LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
                EndIf;
            Endif;
        Endif;
    Else;
        # Wildcard search string
        sSearch                     = Expand('.%sOSDelim%%sCube%.cub');

        # Find all Cubes that match search string
        sFilename                   = WildcardFileSearch( sSearch, '' );
        While( sFilename @<> '' );
            # Trim .cub off the filename
            sCube                   = SubSt( sFilename, 1, Long( sFilename ) - 4 );
            # Destroy Cube
            If( CubeExists( sCube ) = 1 ); 
                If(CubeExists( '}CellSecurity_' | sCube ) = 1);
                    nRet            = CellSecurityCubeDestroy( sCube );
                    If( nRet = 1 );
                        sMessage    = '}CellSecurity_' | sCube | ' successfully destroyed.';
                        LogOutput( 'INFO', Expand( cMsgErrorContent ) );
                    Else;
                        nErrors     = 1;
                        sMessage    = 'Error. Could not destroy }CellSecurity_' | sCube;
                        LogOutput( 'ERROR', Expand( cMsgErrorContent ) );
                    EndIf;
                Endif;
            Endif;
            sFilename               = WildcardFileSearch( sSearch, sFilename );
        End;
    EndIf;

End;

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
    sProcessAction = Expand( 'Process:%cThisProcName% successfully detsroyed cell security for cube  %pCube%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

sProcessReturnCode = pCube;

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
