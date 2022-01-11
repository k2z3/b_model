## Description
   
 This process will create new element in a dimension Hierarchy. More elements than one will be  created if `pEle` is supplied with a delimited list of elements.  
     
**Note:**     
 Valid dimension name (`pDim`) and element list are mandatory, otherwise the process will abort.  
     
**:warning:Caution:** When target hierarchy is `Leaves`, no consolidated elements will be created.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: dimension name, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||OPTIONAL: hierarchy (default value same named hierarchy as dimension), accepts wildcards (if = *, then all hierarchies)|
  |`pEle`|String||REQUIRED: element name, accepts delimited list|
  |`pEleType`|String||OPTIONAL: element type N S C (default value N)|
  |`pInsertionPoint`|String||OPTIONAL: insertion point (default value blank)|
  |`pDelim`|String|`&`|OPTIONAL: delimiter character for element list. (default value if blank = '&')|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
