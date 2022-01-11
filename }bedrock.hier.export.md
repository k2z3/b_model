## Description
   
 This process will Export all Dimension elements in a Hierarchy to a File. Export file maintains  all data that can be used to completely reconstruct the dimension. Custom record delimiter  (specified by a character or its ASCII code) can be used.  
 __Format of the file:__  
 - 1st line: File metadata contains summary information about the dimension, hierarchy, number of    elements and date/time when file was generated.  
 - 2nd line: Source dimension and hierarchy.  
 - 3rd line: Dimension sort order.  
 - 4th and 5th line: Reserved for future development.  
 - 6th line: Header for elements export.  
 - 7th line and forth: Elements export data.  
     
**Use Case:**  
    
 1. Backup of dimension before changes in productive environment.  
 2. Quick replication of a large dimension.  
     
**Note:**     
 Valid dimension name (`pDim`), inclusion of header (`pTitleRecord`) and legacy export format (`pLegacy`)  
 are mandatory otherwise the process will abort.  
 If needed, custom delimiter might be used by specifying parameter `pDelim` value as either exactly one  character or as a 3-digit (decimal) ASCII code. For example to use TAB as a delimiter, use 009.  
     
**:warning:Caution:** Process was redesigned in Bedrock4 but is able to process dimension extracts from prior  versions of Bedrock in legacy mode (`pLegacy` = 1).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||REQUIRED: Dimension|
  |`pHier`|String||OPTIONAL: Hierarchy (defaults to dimension name if blank)|
  |`pTgtDir`|String||OPTIONAL: Target Directory Path (defaults to Error File Directory)|
  |`pTgtFile`|String||OPTIONAL: Target File Name (defaults to Dimension Hierarchy_Export.csv if blank)|
  |`pTitleRecord`|Numeric|`1`|REQUIRED: Boolean 1 = Yes - Include header row|
  |`pDelim`|String|`,`|OPTIONAL: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`"`|OPTIONAL: AsciiOutput quote character (Accepts empty quote, exactly 3 digits = ASCII code)|
  |`pLegacy`|Numeric|`0`|REQUIRED: Boolean 1 = Legacy format|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
