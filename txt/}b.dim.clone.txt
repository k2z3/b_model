## Description
   
 This process can clone a source dimension and all the Hierarchies.  
     
**Use Case:**    Intended for development/prototyping.  
1. Replicate a dimension with it's hierarchies for testing.  
     
**Note:**     
 If the target dimension:hierarchy already exists then it will be overwritten.  
 Naturally, a valid source dimension name (`pSrcDim`) is mandatory otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||REQUIRED: Source Dimension|
  |`pTgtDim`|String||OPTIONAL: Target Dimension (will default to pSrcDim_clone If blank (or) is same as pSrcDim)|
  |`pHier`|String|`*`|REQUIRED: Hierarchies to be included (will use default is left blank), accepts wildcards (if = *, then all hierarchies)|
  |`pAttr`|Numeric|`0`|REQUIRED: Include Attributes? (Boolean 1=True)|
  |`pUnwind`|Numeric|`0`|REQUIRED: 0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements|
  |`pDelim`|String|`&`|OPTIONAL: delimiter character for element list (required if pEle parameter is used) (default value if blank = '&')|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.hier.unwind`](}bedrock.hier.unwind)|Y|N|
  |[`}bedrock.hier.clone`](}bedrock.hier.clone)|Y|N|
  