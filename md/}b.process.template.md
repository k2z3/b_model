## Description
   
 A description of what this process does here.  
     
**Use Case:**     
 A description of the use cast for this process does here.  
     
**Note:**  
    
 * List any notes for users to be aware of here.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Write status messages to tm1server.log file?|
  |`pTemp`|Numeric|`1`|Use temporary objects for views & subsets?|
  ## Full Process Dependencies
  
|Process|ExecuteProcess|RunProcess|
  |---|:-:|:-:|
  |[`}bedrock.cube.data.clear`](}bedrock.cube.data.clear)|Y|N|
  |[`}bedrock.cube.view.create`](}bedrock.cube.view.create)|Y|N|
  |[`}bedrock.hier.sub.create`](}bedrock.hier.sub.create)|Y|N|
  |[`}bedrock.hier.sub.exclude`](}bedrock.hier.sub.exclude)|Y|N|
  |[`}bedrock.hier.sub.create.bymdx`](}bedrock.hier.sub.create.bymdx)|Y|N|
  