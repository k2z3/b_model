## Description
   
 This process will create a cell security cube for the specified cube for the specified list of dimensions  using the TI function _CellSecurityCubeCreate_. The benefit of this process is not needing to write a custom  process each time in order to create a cell security cube.  
     
**Use Case:**    Intended for development.  
1. Set up cell security cubes  
     
**Note:**  
    
 * Naturally, a valid cube (`pCube`) is mandatory otherwise the process will abort.  
 * If cell security has already been set up the TI will abort.  
 * The `pDim` parameter must map _ALL_ the dimensions in order in the cube with a 0 or 1.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Cube to create cell security for|
  |`pDim`|String||REQUIRED: Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. "1:0:0:1:0"|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
