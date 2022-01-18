## Description
   
 This process exports a dimension hierarchies as _TurboIntegrator script_. This is rather than creating a CSV which can be read by a generic  TurboIntegrator process this process creates a _**hardcoded**_ TurboIntegrator process to create a dimension/hierarchy complete with rollup  structure, attribute values, subsets and metadata information such as sort order, MDX hierarchy names and levels and captions.  
  
     
**Use Case:**     
 The specific use case where this process will be useful is to automate the creation of TurboIntegrator script for promotion/migration purposes  as 100% stand-alone without need for data source o any parameters for the process. This can be useful in situations where DevOps has no file system access  to an environment and for manually defined dimensions such as measures.  
  
     
**Note:**     
 Several parameters control the scope of what is exported.  
 * `pDim` accepts wildcard and lists of dimensions and/or hierarchies to filter the **}Dimensions** dimension. There is no separate **pHier** parameter for this process  
 * `pEle` accepts wildcard and lists of _elements_. This can be used to limit the scope of the export of dimension structure and attribute values to a subset of elements  
 * `pDim`Info 1/0 numeric Boolean whether to include metadata relevant to the dimensions/hierarchies defined in `pDim` from }DimensionProperties, }HierarchyProperties and }DimensionAttributes  
 * `pAttr` 1/0 numeric Boolean whether to include attribute creation  
 * `pAttr`Val 1/0 numeric Boolean whether to include attribute values (for the elements defined in `pEle` )  
 * `pSub` 1/0 numeric Boolean whether to include subset definitions for dynamic and static subsets  
 * There is no Boolean for exporting dimension structure, this is determined by `pEle`. To export all elements use `pEle`="*". To suppress export of rollup structure (and attribute values) use `pEle`=""  
 * 2 scripts are produced. One to copy/paste into prolog and one for epilog as Direct functions are not used for creation of elements and parent-child relationships  
  
     
**:warning:Caution:**  This process is designed for _**smaller (typically manually defined) dimensions**_. No check is implemented for upper limit of the set of elements defined by `pEle` if run on a large  dimension then the export script will be correspondingly large.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Target Dimension or Hierarchy (as dim:hier), accepts wildcards (if = *, then all the dimensions)|
  |`pEle`|String||OPTIONAL: Target Element(s), accepts wildcards ( * will include ALL)|
  |`pDelim`|String|`&`|OPTIONAL: Delimiter character if list used for pDim, pHier or pEle|
  |`pTgtDir`|String||OPTIONAL: Target Directory Path (defaults to Error File Directory if blank)|
  |`pTgtFile`|String||OPTIONAL: Root file name without file extension. If blank "bedrock_dimension_script" will be used|
  |`pTitleRecord`|Numeric|`1`|REQUIRED: Boolean 1 = Yes - Include header row|
  |`pDimInfo`|Numeric|`1`|OPTIONAL: Include dimension info section (SortOrder, HierarchyProperties, etc.)|
  |`pAttr`|Numeric|`1`|OPTIONAL: Include creation of attributes|
  |`pSub`|Numeric|`0`|OPTIONAL: Include subset definitions|
  |`pAttrVal`|Numeric|`1`|OPTIONAL: Include attribute values (for selected elements in pEle)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
