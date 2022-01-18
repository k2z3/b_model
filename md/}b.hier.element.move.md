## Description
   
 This process will Add or Remove Element from a Consolidation in a Hierarchy.  
     
**Note:**     
 Valid dimension name (`pDim`), consolidated element name (`pTgtConsol`) and element name (`pEle`)  
 otherwise the process will abort. Mode can be either Add to add or Remove to remove the element  from a consolidation.  
     
**:warning:Caution:** Target hierarchy cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension Name|
  |`pHier`|String||OPTIONAL: Hierarchy Name|
  |`pEle`|String||REQUIRED: Element Name|
  |`pTgtConsol`|String||REQUIRED: Target Consolidation|
  |`pMode`|String|`Add`|REQUIRED: Add or Remove Element from Hierarchy|
  |`pWeight`|Numeric|`1`|OPTIONAL: Element Weight (for Add only)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
