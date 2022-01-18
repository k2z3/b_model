## Description
   
 This process will delete specified or all elements from a dimension Hierarchy. Elements might be  specified as a delimited list of elements. Each member in the list might be specified exactly or  by a wildcard pattern. Wildcards "\*" and "?" are accepted.  
  
     
**:warning:Caution:** When `pEle` is set to \*, __all__ elements in `pHier` will be deleted!  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: dimension name, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||OPTIONAL: hierarchy name (if blank then same named hierarchy as dimension is assumed), accepts wildcards (if = *, then all hierarchies)|
  |`pEle`|String||OPTIONAL: filter on elements (delimiter separated list of elements, accepts wildcards (if = *, then all the elements in hierarchy get deleted))|
  |`pDelim`|String|`&`|OPTIONAL: delimiter character for element list (default value if blank = '&')|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
