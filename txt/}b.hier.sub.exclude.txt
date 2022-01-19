## Description
   
 This process will remove specified elements from a subset in a Hierarchy of target Dimension.  
 Wildcard characters `*`and `?` are accepted in list of elements to be excluded.  
     
**Note:**  
    
 - If a leaf level element is specified, it will be removed on its own.  
 - If a consolidated element is specified it will be removed as well as its descendants.  
     
**:warning:Caution:** Target hierarchy cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension name|
  |`pHier`|String||OPTIONAL: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||REQUIRED: Subset name|
  |`pExclusions`|String||OPTIONAL: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter character|
  |`pTemp`|Numeric|`1`|OPTIONAL: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  