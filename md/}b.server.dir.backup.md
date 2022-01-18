## Description
   
 This process will back up the Data Directory.  
     
**Use Case:**    Intended for development and production.  
1. Backup Data directory every day during development.  
2. Backup Data directory every day during planning cycle.  
     
**Note:**     
 Naturally, a valid data directory (`pSrcDir`) and targer directory (`pTgtDir`) is mandatory otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDir`|String|`.`|REQUIRED: Source Directory to Backup|
  |`pTgtDir`|String||REQUIRED: Destination Directory for Backup|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.server.savedataall`](}bedrock.server.savedataall)|Y|N|
  