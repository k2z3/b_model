## Description
   
 This process will create a new dimension hierarchy from attribute values.  
     
**Note:**     
 Valid dimension name (`pDim`) and attribute name (`pAttr`) are mandatory, otherwise the  process will abort.  
     
**:warning:Caution:** It is assumed each element exists __only once__ within the hierarchy. This should hold true except in exceptional circumstances.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension|
  |`pSrcHier`|String||OPTIONAL: Source Hierarchy, If not specified takes the default Hierarchy|
  |`pTgtHier`|String||OPTIONAL: Target Hierarchy, If not specified, takes the same name as attribute.|
  |`pAttr`|String||REQUIRED: Attribute|
  |`pTopNode`|String|`Total <pAttr>`|OPTIONAL: The name of the Target Hierarchy top element (will default to 'All ' attribute name )|
  |`pPrefix`|String||OPTIONAL: Prefix before the attribute value|
  |`pSuffix`|String||OPTIONAL: Suffix after the attribute value|
  |`pSkipBlank`|Numeric|`0`|OPTIONAL: To manage empty attribute: 0= Skip,  1=Send to unallocated node (by default blank attribute values are skipped)|
  |`pUnallocated`|String|`Undefined <pAttr>`|OPTIONAL: Naming convention for rollup if attribute is empty (eg. Unallocated <pAttr>, No <pAttr>, Undefined <pAttr>)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
