# What's new in in bedrock v4?

With the release of **IBM Planning Analytics** and the introduction of _alternate hierarchies_ for dimensions the game has changed. Supporting hierarchies required a re-write of a large section of the library and so a decision was made to undertake a bottom up re-write of the _entire_ library and implement a number of enhancements as opposed to just supporting hierarchies. This artice is a summary of the major differences from bedrock 3.

## Departures from v3
There are a number of significant departures from the previous v2 and v3 releases:
* No more _pDebug_. When bedrock was first released some 10 years ago the built in logging modes (0 no logging, 1 log actions, 2 log actions which _would have been performed_ but don't do them) was one of the great features of the library. There was no alternative in TurboIntegrator other than to write text files for debugging purposes. But **times have changed**, with support in TM1's Rest API for debugging and TM1 IDEs like [Arc for TM1](https://code.cubewise.com/arc-overview) supporting step-through debugging there is simply no need for this anymore in the library, hence _pDebug_ is no more.
* Goodbye _pDebug_, hello _pLogOutput_. When things go wrong with a library process it's almost always becasue wrong parameters were passed. The _LogOutput_ function was introduced in TM1 10.2.2 and the bedrock v4 library makes full use of this capability. If pLogOutput=1 then bedrock will write the user and parameter values the process was called with to the server message log. Likewise should a bedrock proces encounter any errors this will also be written to the server message log. So rather than piecing together 100s of .debug files the tm1server.log file is _**the**_ place to look.
* **Temporary objects** were introduced in 11.0 but didn't become useable for libraries such as bedrock until 11.3 when the scope of temporary objects was widened from the immediate creating processes to all ancestor processes within the same ExecuteProcess transaction thread. Temporary objects have significant locking and performance benefits _and don't need to be destroyed_ as they get destroyed automatically when the process transaction ends. _By default bedrock uses temporary objects for all processing._ No more left over views and subsets from TI processes! So remember, if you want to create a _**permanent**_ view or subset with bedrock the _pTemp_ parameter **must be set to 0** not the default value of 1.
* New error handling avoiding _ProcessError_ and rollbacks. Whereever possibe if an error can be handled bedrock will write to the tm1server.log to indicate the issue _but will not raise a ProcessError_, rather the process will still conclude with a "normal" or "success" status. This avoids potential locking and recycling issues caused by rollbacks.
* \* wildcard for "ALL". In bedrock 3 it was a bit variable from process to process whether a blank parameter would be interpreted as "ALL" or "no filter" versus "do nothing" or whether some other special keyword might be required. In bedrock 4 the asterix ( \* ) is universally implemented and required to indicate "ALL".
* Change in default _dimension¦1st element_ separator in filter strings. With the introduction of hierarchies the colon ( : ) is used as the internal delimiter for dimension:hierarchy. It should therefore be avoided as a delimiter in filter strings. It has been replaced by the vertical broken bar ( ¦ ) as the default delimiter between dimension name and first element.
* _**No change log**_. As v4 is a bottom-up re-write a change log would have been somewhat pointless.
* Bedrock processes are now control objects and start with }. When we solicited feedback there was a strong preference to hide the library from view like built-in control objects. **You got your wish** and all processes are now }bedrock... and hidden from view by default.
* **Lower case**. With more and more TM1 / Planning Analytics systems running on Linux these days case is starting to make a difference in the TM1 world. Hence we have opted for all lowercase for bedrock 4 processes.

## Enhancements in v4
Of course many things stayed the same but just got better.
* It's a small thing but one that makes the library easier to learn and use. Parameter names are now _consistent accross all processes_. :-)
* _**Filters got more powerful**_. Almost all bedrock 4 processes universally support delimited lists and wildcards (and combination of delimited list which includes wildcards). This means a single bedrock process can perform actions on a large number of objects. Try it!
* _**New documentation concept**_. Bedrock 4 documentation is built-in. The header of each process contains _DocString_ tags from where the documentation which appears in the [Wiki](https://github.com/cubewise-code/bedrock/wiki) is automatically parsed. In a future release we will also include the [TM1Py](https://github.com/cubewise-code/tm1py) script which we use to do this so you can include this technique in your own projects.
* Full support for **hierarchies**. Hierarchies are now the container for _elements_ and _subsets_. Dimensions are a more abstract concept being a _container for hierarchies_. Bedrock 4 fully supports hierarchies including some useful processes to _convert rollups to hierarchies_.
* Copy data within a slice of a cube and _between_ cubes without writing a line of code! The [_}bedrock.cube.data.copy_](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.cube.data.copy) process got a whole lot more powerful, not only accepting a filter to define the source area but also allowing for multiple source to target mappings and an optional scaling factor. And the process now has a twin [_}bedrock.cube.data.copy.intercube_](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.cube.data.copy.intercube) which does the same thing but between different cubes, which don't even have to have the same dimensions.
* Automatically invoke processing on **multiple threads**. The 2 processes mentioned above [_}bedrock.cube.data.copy_](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.cube.data.copy) & [_}bedrock.cube.data.copy.intercube_](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.cube.data.copy.intercube) make use of the new _RunProcess_ function (available from 11.4, officially suppported from 11.5) to optionally split processing over multiple CPU cores. This can significaltly reduce end to end processing time for larger data volumes. This is controled by the parameters _pFilterParallel_ and _pParallelThreads_. Try it and see how easy it is!

## Open for contribution from the community
There have already been many people contributing to bedrock 4 behind the scenes. Now it's your turn. All TM1 and Planning Analytics enthusiasts are invited to contribute to the bedrock project and enhance TM1 for everyone!