## Description
   
 This process creates a view that can be used for exporting, copying or zeroing out numbers.  
     
**Use Case:**    Intended for development/prototyping or production.  
1. Create a view to zero out data.  
2. Create a view to use as a source for exporting or copying.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 The `pFilter` parameter contains the dimenson and elements to be used for filtering:  
 - The format of the `pFilter` parameter is as follows delimiters of :, & and +: Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4.  
 - The dimension parameters do not need to be given in the index order of dimensions in the cube.  
 - The dimension name is specified as the first member of the delimited string of elements.  
 - If consols are skipped the N level children of any consolidated filter elements will be used.  
 - Spaces are ignored so use them to make your filter more readable.  
 - `pTemp`: This parameter will control whether to make the view temporary (value 1) or if the    view will be permanently retained (value 0).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Cube Name|
  |`pView`|String||REQUIRED: Name of the View|
  |`pFilter`|String||OPTIONAL: Filter: Year¦ 2006 + 2007 & Scenario¦ Actual + Budget & Organization¦ North America Operations|
  |`pSuppressZero`|Numeric|`1`|REQUIRED: Suppress Zero Data (Skip = 1)|
  |`pSuppressConsol`|Numeric|`1`|REQUIRED: Suppress Consolidations (Skip = 1)|
  |`pSuppressRules`|Numeric|`1`|REQUIRED: Suppress Rules (Skip = 1)|
  |`pSuppressConsolStrings`|Numeric|`0`|REQUIRED: Suppress Strings on Consolidations (Skip = 1) (Default = 0)|
  |`pDimDelim`|String|`&`|REQUIRED: Delimiter for start of Dimension/Element set|
  |`pEleStartDelim`|String|`¦`|REQUIRED: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|REQUIRED: Delimiter between elements|
  |`pTemp`|Numeric|`1`|OPTIONAL: Make View Temporary (1=Temporary)|
  |`pSubN`|Numeric|`0`|OPTIONAL: Create N level subset for all dims not mentioned in pFilter|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.sub.create`](}bedrock.hier.sub.create)|Y|N|
  |[`}bedrock.hier.sub.exclude`](}bedrock.hier.sub.exclude)|Y|N|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  