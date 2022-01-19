## Description
   
 This process creates static subsets named "All level <nn>" for the specified consolidation  levels in a Hierarchy of a Dimension.  
     
**Note:**     
 Option to sort subset is available only for sorting per element principal names.  
     
**:warning:Caution:** Target hierarchy cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension name|
  |`pHier`|String||OPTIONAL: Hierarchy name (default if blank = same named hierarchy)|
  |`pSort`|Numeric|`0`|OPTIONAL: Sort the Subset|
  |`pConvertStatic`|Numeric|`1`|OPTIONAL: Convert the Subset to Static|
  |`pAlias`|String||OPTIONAL: Set Alias for Subset|
  |`pTemp`|Numeric|`1`|OPTIONAL: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
