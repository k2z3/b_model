## Description
   
 This process will run the TI ExecuteCommand function.  
     
**Use Case:**    Intended for production.  
1. To run an executeCommand function from any part of the model, including RushTI or third party system without direct access to TI Editor.  
2. To remove the requirement of creating a one off process to use this function  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCommand`|String||The full command line string to execute|
  |`pWait`|String|`0`|Wait for command to finish 0=false 1=true|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
