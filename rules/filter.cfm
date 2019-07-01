<cfif NOT structKeyExists( arguments, "filter" )>
	<cfset arguments.filter =	"ass,asshole,ass-hole,fuck,fucks,fucker,fuckers,fucking,sex,shit,shithead,shit-head," &
								"slut,bitch," &
								"ho,prostitute,pimp," &
								"cum,ejaculate,orgasm,orgasmic," &
								"orgy,oralsex,oral-sex,blowjob,blow-job," &
								"homo,fag,faggot" &
								"penis,boner,cock,wank,wang,erection," &
								"nutsack,nut-sack,ballsack,ball-sack,testicle,gooch," &
								"clit,cunt,vagina,twat," &
								"boob,nipple," &
								"dildo,dong,vibrator," &
								"spag,dago,gippo," &
								"coon,nig,nigga,nigger,nignog,nig-nog," &
								"wetback,spic,spik,spick," &
								"lubra,boong," &
								"jap,slaphead,slap-head,slopehead,slope-head,nip,nipper,gook,gooky,chink,chinkie,ching,changa,chonga," &
								"honky,whitey,wigger">
</cfif>
<cfif structKeyExists( arguments, "filterAdd" )>
	<cfset arguments.filter = listAppend( arguments.filter, arguments.filterAdd )>
</cfif>

<cfset LOCAL.wordList = reReplace( lCase( LOCAL.value ), "[^a-zA-Z0-9\-]+", ",", "all" )>
<cfset LOCAL.badWords = "">

<cfloop index="LOCAL.word" list="#LOCAL.wordList#">
	<cfif listFind( arguments.filter, LOCAL.word )>
		<cfif arguments.mutable>
			<cfset LOCAL.value = replaceNoCase( LOCAL.value, LOCAL.word, repeatString( "*", len( LOCAL.word ) ) )>
		</cfif>
		<cfif NOT listFind( LOCAL.badWords, LOCAL.word )>
			<cfset LOCAL.badWords = listAppend( LOCAL.badWords, LOCAL.word )>
		</cfif>
	</cfif>
</cfloop>

<cfif len( LOCAL.badWords )>
	<cfset LOCAL.badWords = udf.listAndFormat( LOCAL.badWords )>
	<cfset LOCAL.error = "{label} contained the restricted word(s): <u>#LOCAL.badWords#</u>, please retry.">
</cfif>