## Description
   
 This TI deletes a dimension from a cube that has already been built with the ability to preserve data.  
     
**Use Case:**    Intended for development/prototyping.  
1. Rebuild existing cube with the removal of one dimension without losing all the data.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 Also, a valid dimension name (`pDim`) is mandatory otherwise the process will abort.  
 If data needs to be kept (using `pIncludeData`), data from `pDim` will be summed.  
 Rule can be kept as backup file only or reloaded back.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|REQUIRED: Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Cube|
  |`pDim`|String||REQUIRED: Dimension to be deleted|
  |`pIncludeData`|Numeric|`1`|REQUIRED: If 1 then data is kept (copied through clone cube)|
  |`pIncludeRules`|Numeric|`2`|REQUIRED: Unload and reload the rule (0 = do not keep the rule, 1 = unload the rule, 2 = unload the rule and reload on new cube)|
  |`pCtrlObj`|Numeric|`0`|REQUIRED: Allow overwrite control cubes|
  |`pTemp`|Numeric|`1`|REQUIRED: Delete the clone cube (1 = delete, 0 = not delete)|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.cube.rule.manage`](}bedrock.cube.rule.manage)|Y|N|
  |[`}bedrock.cube.clone`](}bedrock.cube.clone)|Y|N|
  |[`}bedrock.cube.create`](}bedrock.cube.create)|Y|N|
  |[`}bedrock.cube.data.copy.intercube`](}bedrock.cube.data.copy.intercube)|Y|N|
  |[`}bedrock.cube.delete`](}bedrock.cube.delete)|Y|N|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  |[`}bedrock.cube.view.create`](}bedrock.cube.view.create)|Y|N|
  |[`}bedrock.cube.data.clear`](}bedrock.cube.data.clear)|Y|N|
  |[`}bedrock.cube.data.export`](}bedrock.cube.data.export)|Y|N|
  |[`}bedrock.hier.sub.create`](}bedrock.hier.sub.create)|Y|N|
  |[`}bedrock.hier.sub.exclude`](}bedrock.hier.sub.exclude)|Y|N|
  