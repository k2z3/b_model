## Description
   
 This process will clone the source dimension Hierarchy.  
     
**Use Case:**    Mostly in Development.  
1. Create a duplicate of an existing hierarchy for testing.  
     
**Note:**     
 Valid source dimension name (`pSrcDim`) and target dimension (`pTgtDim`) names are mandatory otherwise the process will abort.  
 Valid source hierarchy name (`pSrcHier`) is mandatory otherwise the process will abort.  
     
**:warning:Caution:**  
 - Target hierarchy cannot be `Leaves`.  
 - If the target dimension Hierarchy exists then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||REQUIRED: Source Dimension|
  |`pSrcHier`|String||REQUIRED: Source Hierarchy|
  |`pTgtDim`|String||REQUIRED: Target Dimension (can be the same as source)|
  |`pTgtHier`|String||OPTIONAL: Target Hierarchy (will default to SrcHier_Clone if the dimensions are the same)|
  |`pAttr`|Numeric|`0`|OPTIONAL: Include Attributes? (Boolean 1=True)|
  |`pUnwind`|Numeric|`0`|REQUIRED:  Unwind? (0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements (Only relevant if target hierarchy exists) )|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.unwind`](}bedrock.hier.unwind)|Y|N|
  