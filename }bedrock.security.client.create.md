## Description
   
 This process will create clients, assign a password and max ports.  
     
**Use Case:**    Intended for production.  
1. Create clients for multiple new hires simultaneously.  
     
**Note:**     
 Naturally, a client (`pClient`) is mandatory otherwise the process will abort.  
 - Multiple clients can be specified separated by a delimiter.  
 - If client already exists then the process will not attempt to re-create it but will reset password and max ports.  
 - Each client will have to be assigned to a group afterwards.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pClient`|String||REQUIRED: Single user name or list of users separated by delimiter|
  |`pAlias`|String||OPTIONAL: single or delimited list of }TM1_DefaultDisplayValue alias to assign to user (if list of users then size of list of aliases must be the same!)|
  |`pPassword`|String||OPTIONAL: Initial Password|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter (Blank = &)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
