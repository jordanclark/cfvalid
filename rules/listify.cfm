<cfparam name="arguments.delimiters" type="string" default=", ;#chr(9)##chr(10)##chr(13)#">

<cfset LOCAL.value = listChangeDelims( trim( LOCAL.value ), left( arguments.delimiters, 1 ), arguments.delimiters )>
