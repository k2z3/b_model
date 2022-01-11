## Description
   
 This process deletes a dimension or hierarchy (or a list thereof).  
     
**Use Case:**    Intended for development/prototyping.  
1. Clean up unused dimension/hierarchies after Go Live.  
     
**Note:**     
 Naturally, a valid dimension name (`pDim`) is mandatory otherwise the process will abort.  
 If no hierarchy (`pHier`) is specified the dimension will be deleted if not in use by a **regular** cube.  
 If a hierarchy is specified, it must be valid otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||OPTIONAL: Hierarchy, accepts wildcards (all hierarchies except default and Leaves deleted if = *)|
  |`pDelim`|String|`&`|OPTIONAL: delimiter character for element list. (default value if blank = '&')|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
