## Description
   
 This process will remove all children from a specific target consolidation (`pConsol`) in a Hierarchy  in target Dimension. If recursive (`pRecursive`=1), it will also unwind all consolidations that are  descendants of the target regardless of depth. If not recursive (`pRecursive`=0) then only immediate children  of the target consolidation will be removed.  
  
     
**Use Case:**    Intended for both production and development/prototyping scenarios.  
 1. **Production** call prior to main dimension build process in case mapping relationships have changed to ensure no double-counting steming from leaf elements     rolling into multiple parents within the same rollup or hierarhcy  
 2. **Production** combine with }bedrock.hier.emptyconsols.delete to remove orphaned rollups  
 3. **Development** manual cleanup of dimensions during prototyping or prior to going to production  
  
     
**Note:**  
    
 * A valid source dimension name (`pDim`) is mandatory otherwise the process will abort.  
 * A blank `pHier` parameter will process _only the same named hierarchy_ for each of the dimensions processed.  
 * A \* `pConsol` parameter will process ALL C level items in the given hierarchy (`pHier`).  
 * A delimited list or wildcard for `pDim` or `pHier` or a delimited list of consolidations for `pConsol` will result in recursive calls of the process.  
  
     
**:warning:Caution:**  If consolidations are also used in unrelated consolidations and recursive is selected this  will result in orphan consolidations in the other rollups.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Target Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||OPTIONAL: Target Hierarchy (will use default is left blank), accepts wildcards (if = *, then all hierarchies)|
  |`pConsol`|String|`*`|OPTIONAL: Target Consolidation, accepts wildcards ( * will unwind ALL)|
  |`pRecursive`|Numeric|`0`|REQUIRED: Boolean: 1 = True (break from node down not just direct children)|
  |`pDelim`|String|`&`|OPTIONAL: delimiter character for element list (default value if blank = '&')|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
