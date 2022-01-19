## Description
   
 This process will copy a subset from a Hierarchy in source Dimension to a Hierarchy in target  Dimension.  
     
**Note:**     
 Valid source dimension name (`pSrcDim`), source (`pSrcSub`) and target subset (`pTgtSub`) are  mandatory otherwise the process will abort.  
     
**:warning:Caution:**  
 - Target hierarchy cannot be `Leaves`.  
 - If the target dimension Hierarchy exists then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||REQUIRED: Dimension where the subset exists|
  |`pSrcHier`|String||OPTIONAL: Source Hierarchy (blank = same as source)|
  |`pSrcSub`|String||REQUIRED: Source Subset|
  |`pTgtDim`|String||OPTIONAL: Target dimension (blank = same as source)|
  |`pTgtHier`|String||OPTIONAL: Target Hierarchy (blank = same as Target Dimension)|
  |`pTgtSub`|String||REQUIRED: Target Subset|
  |`pTemp`|Numeric|`1`|OPTIONAL: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
