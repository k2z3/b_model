## Description
   
 This process will load a csv text file to the target cube.  
     
**Use Case:**    Intended for development/prototyping or in Production environment.  
1. Import data from another TM1 model.  
2. To eliminate possibility of locking it is sometimes better to export and import when needing to copy data from one cube to another.  
     
**Note:**     
 Naturally, a valid target cube name (`pCube`) is mandatory otherwise the process will abort.  
 Element mapping for new dimensions (`pMappingToNewDims` ) is also required when the target cube has more dimensions than the source, otherwise the process will abort.  
 The default input path is the same as the error file path if not specified.  
 If the file name is left blank, the process will look for a file called `pCube`_Export.csv.  
 Format:  
 The assumed file format is as per standard CMA export:  
 - v1 specIfies cube name, subsequent fields specify cube address ( individual element names ).  
 - vN specIfies cell data value to load. With provision for files with header rows.  
 Format of filter row for Zero out:  
 - v1 specifies source cube name  
 - v2 must be equal to "Filter".  
 - v3 specifies the filter to be used to zero out. Please note if target cube has additional dimensions this is the final filter used if `pMappingToNewDims` is not speficied. All the elements in additional dimensions will be cleaned  
 - v4 specifies the dimension delimiter used in filter  
 - v5 specifies the element start delimiter used in filter  
 - v6 specifies the element delimiter used in filter  Note about the Zero out:  
 if `pMappingToNewDims` parameter is specified, it will be concatenated to the filter in the file to restict the cube slice to be zeroed out. Similarly, if `pDim` is specified the source element is substituted with the targed one, sould it be in the filter string  in both cases the delimiters in the source file must match the delimiters passed in parameters of this process.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Target Cube|
  |`pSrcDir`|String||OPTIONAL: Source Directory (will default to error log path)|
  |`pSrcFile`|String||OPTIONAL: Source File (will default to pCube_Export.csv )|
  |`pDim`|String||OPTIONAL: Dimension|
  |`pSrcEle`|String||OPTIONAL: Source Element ( Only required if a Dimension is used.)|
  |`pTgtEle`|String||OPTIONAL: Target Element (Only required if Dimension is used.)|
  |`pTitleRows`|Numeric|`1`|REQUIRED: Number of Title Rows to Skip|
  |`pDelim`|String|`,`|REQUIRED: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`"`|REQUIRED: Quote (Accepts empty quote, exactly 3 digits = ASCII code)|
  |`pCumulate`|Numeric|`0`|REQUIRED: Accumulate Amounts (0 = Overwrite values, 1 = Accumulate values)|
  |`pCubeLogging`|Numeric|`0`|Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions, 2 = Ignore Cube Logging - No Action Taken)|
  |`pSandbox`|String||OPTIONAL: To use sandbox not base data enter the sandbox name (invalid name will result in process error)|
  |`pZeroFilter`|Numeric|`0`|OPTIONAL: Source file includes Zero out filter (0=No filter line in source file, 1=Ignore filter line, 2=Perform ZeroOut using filter line)|
  |`pMappingToNewDims`|String||REQUIRED IF TARGET HAS DIMS NOT IN SOURCE: DimX¦InputElementForDimX & DimY¦InputElementForDimY (specify an N level element for each new dim)|
  |`pDimDelim`|String|`&`|OPTIONAL. Delimiter for start of Dimension/Element set|
  |`pEleStartDelim`|String|`¦`|OPTIONAL: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|OPTIONAL: Delimiter between elements|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.cube.data.clear`](}bedrock.cube.data.clear)|Y|N|
  |[`}bedrock.cube.view.create`](}bedrock.cube.view.create)|Y|N|
  |[`}bedrock.hier.sub.create`](}bedrock.hier.sub.create)|Y|N|
  |[`}bedrock.hier.sub.exclude`](}bedrock.hier.sub.exclude)|Y|N|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  