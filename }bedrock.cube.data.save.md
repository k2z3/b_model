## Description
   
 This process save data to disk for the cubes provided in parameter.  
     
**Use Case:**    Intended for Development or production.  
1. This process would be used any time data for a specific cube need to be saved (i.e.: After a data loading to save a specific cube or or for manual entry cubes).  
     
**Note:**     
 Naturally, a valid  cube name (`pCube`) is mandatory otherwise the process will abort. Wildcards and lists are acceptable.  
 This process will save data for a cube.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Save data for this cube (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
