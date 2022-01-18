## Description
   
 This process will Create a Top Level Hierarchy by N-Level Elements  that is a subset of all "top node" elements ( Consolidated elements that have no parents )  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension name|
  |`pHier`|String||OPTIONAL: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||REQUIRED: Subset name|
  |`pConvertToStatic`|Numeric|`1`|OPTIONAL: Boolean: 1 = Convert to Static Subset|
  |`pAlias`|String||OPTIONAL: Set Alias for Subset|
  |`pTemp`|Numeric|`1`|OPTIONAL: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
