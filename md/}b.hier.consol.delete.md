## Description
   
 This process will delete a specified C-Level item **or** ALL consolidations in the dimension hierarchy.  
     
**Use Case:**    Could be used during development or in production.  
1. Delete a specific or all C-Level items in a hierarchy.  
     
**Note:**     
 Valid dimension name (`pDim`) is mandatory otherwise the process will abort. Control dimensions are excluded.  
 The hierarchy (`pHier`) will default to `pDim` if not specified, otherwise it must be valid else the process will abort.  
 **ALL** consoldidated items in hierarchy will be deleted if consolidated item (`pEle`) is specified as \*, otherwise it needs to contain valid c-level item(s).  
     
**:warning:Caution:** Target hierarchy (`pHier`) cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension name|
  |`pHier`|String||OPTIONAL: Hierarchy name (if blank then same named hierarchy as dimension is assumed)|
  |`pEle`|String||OPTIONAL: Filter on elements (element list separated by delimiter, accepts wildcards (if * then all the consolidation elements get deleted))|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter character for element list (default to '&' if blank)|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  