## Description
   
 This process will create a static subset in a Hierarchy of target Dimension that consists of  all leaf descendants of a specified consolidated element.  
     
**Note:**  
    
 - `pExclusions`: If `pExclusions` is specified then the elements (separated by a delimiter) will be    excluded from the subset. Wildcards characters `*` and `?` are accepted.  
 - `pAddToSubset` : If the specified subset already exists then this parameter will control whether    elements will be added to the existing subset (value 1) or a new subset will be created    (value 0).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension name|
  |`pHier`|String||OPTIONAL: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||REQUIRED: Subset Name|
  |`pConsol`|String||OPTIONAL: Consolidated Element  (Blank Equals All)|
  |`pAddToSubset`|Numeric|`0`|OPTIONAL: Add to Subset if it Already Exists (0=No 1=Yes)|
  |`pExclusions`|String||OPTIONAL: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter character|
  |`pAlias`|String||OPTIONAL: Set Alias for Subset|
  |`pTemp`|Numeric|`1`|OPTIONAL: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.sub.create`](}bedrock.hier.sub.create)|Y|N|
  |[`}bedrock.hier.sub.exclude`](}bedrock.hier.sub.exclude)|Y|N|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  