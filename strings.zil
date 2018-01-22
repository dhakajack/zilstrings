"EMPTY GAME main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"Stringish|
An interactive fiction by Jack">

<CONSTANT OTHERTABLE <ITABLE 50>> ;"Holds intermediate results before copying back to TEMPTABLE"

<ROUTINE GO ()
    <CRLF> <CRLF>
    <TELL "Some fun with text." CR CR>
    <V-VERSION> <CRLF>
    <SETG HERE ,LAB>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>>

<INSERT-FILE "parser">

"Objects"

<OBJECT LAB
    (IN ROOMS)
    (DESC "The Lab")
    (FLAGS LIGHTBIT)>

<OBJECT TESSERACT
	(DESC "tesseract")
	(SYNONYM PYLON TESSERACT ITEM OBJECT)
	(ADJECTIVE METAL TIMEY-WIMEY)
	(IN LAB)
	(LDESC "A shiny timey-wimey hyperdimensional object.")
	(PRESIDENT "Cleveland")
>

<OBJECT TMARBLE
	(DESC "marble")
	(SYNONYM MARBLE SPHERE)
	(ADJECTIVE GLASS)
	(IN LAB)
	(LDESC "A sphere of coloured glass.")
>

<SYNTAX LEN = V-LONG> 
<SYNTAX LEN OBJECT = V-LONG>
<SYNTAX LENPRES OBJECT = V-PRESLONG>

<SYNTAX MID = V-MIDBUF>	
<SYNTAX MID OBJECT = V-MID>
<SYNTAX MIDPRES OBJECT = V-PRESMID>
	
<SYNTAX MIDBUF = V-MIDBUF>
	
<SYNTAX REV = V-REV>	
<SYNTAX REV OBJECT = V-REV>
<SYNTAX REVPRES OBJECT = V-PRESREV>	
	
<SYNTAX REVMID = V-REVMID>
<SYNTAX REVMID OBJECT = V-REVMID>
	
<SYNTAX SHOW = V-SHOW>
<SYNTAX SHOWOTHER = V-SHOWOTHER>
	

<ROUTINE V-LONG ()
	<TELL "The description length is " N <LEN ,PRSO> CR>	
>

<ROUTINE V-PRESLONG ()
	<TELL "The length of the presidential name, if any, associated with " D ,PRSO " is: " N <LEN ,PRSO ,P?PRESIDENT> CR> 
>

<ROUTINE V-MIDBUF () ;"demo midstring on the buffer itself"
	<DO (I 7 1 -1)
		<TELL "Outer 2 and inner " N .I ": " >
		<MID 2 .I>
		<SHOWSTRING>
		<CRLF>
	>
>

<ROUTINE V-MID () ;"demo midstring function on an object's name"
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO>
			<SHOWSTRING>
			<CRLF>
		>
	>
>

<ROUTINE V-REVMID () ;"demo midstring function on an object's name, but with negative len argument"
	<DO (O 0 7)
		<DO (I -7 0 1)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO>
			<SHOWSTRING>
			<CRLF>
		>
	>
>

<ROUTINE V-SHOW () ;"show what's in the scratch buffer"
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-SHOWOTHER () ;"just of diagnostic interest"
	<SHOWSTRING ,OTHERTABLE>
	<CRLF>
>

<ROUTINE V-PRESMID ()
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO ,P?PRESIDENT>
			<SHOWSTRING>
			<CRLF>
		>
	>
>

<ROUTINE V-REV ()
	<REVERSE ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESREV ()
	<TELL "The reverse of the president (if any) of " D ,PRSO " is: ">
	<REVERSE ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>

;"==========================================
Functions perform pseudostring manipulation
============================================"

;"LEN [object] [property]
Purpose: Finds length of a string.
Returns: a FIX, the length in characters of its argument.
Comment: Used by a lot of other functions to get text into
the buffer for further manipulation.
"

<ROUTINE LEN ("OPT" OBJ PRPTY "AUX" MAX ) ;"if object supplied, operates on whatever remains in temptable buffer"
	<COND 	(<T? .OBJ>
				<DIROUT 3 ,TEMPTABLE> ;"As side effect, reads argument into the temptable buffer
										if no argument at all is supplied, it operates directly on
										whatever is already in the buffer."
				<COND 	(<F? .PRPTY> ;"Was the optional argument, a property, supplied?"
							<PRINTD .OBJ>
						)
						(<GETP .OBJ .PRPTY> ;"only try to print it if it's not null, i.e., is defined."
							<TELL <GETP .OBJ .PRPTY>>
						)
				>	
				<DIROUT -3>
			)
	>
	<SET .MAX <GET ,TEMPTABLE 0>> 
	<RETURN .MAX>
>

"MID start substring-length [object] [property]
Purpose: Extract a substring.
Returns: NULL.
Comment: The result is left in the TEMPTABLE.
A start less than 1 will be set equal to one.
A negative substring-length will work from the right side of the word.
The functions LEFT and RIGHT are special cases of MID.
"
; "Print the string starting at element START for NUM characters (or up to end, if shorter)"
<ROUTINE MID (START NUM "OPT" OBJ PRPTY "AUX" MAX J C BKWRDS)
	<COND 	(<=? .NUM 0> ; "zero length yields nothing, blow this clam bake."
				<PUT ,TEMPTABLE 0 0>
				<RFALSE>
			)
			(<F? .OBJ>
				<SET .MAX <GET ,TEMPTABLE 0>>
			)
			(T
				<COND	(<F? .PRPTY> ;"was the optional argument, a property, supplied?"
								<SET .MAX <LEN .OBJ>>
						)
						(T
							<SET .MAX <LEN .OBJ .PRPTY>>
						)
				>
			)			
	>;"incidentally, getting the length loads the TEMPTABLE with the string of interest"
	<COND	(<L? .START 1>
				<SET .START 1>
			)
	>
	<COND  	(<L? .NUM 0>
				<SET .NUM <* .NUM -1>>
				<SET .BKWRDS T>
				<REVERSE>
			)
	>
	<COND 	(<=? .MAX 0>
				<SET .MAX <GET ,TEMPTABLE 0>>
				<RFALSE> ;"as would be the case if, for example, a property were supplied, but the
						   object's property is either <> or the object doesn't have that property"
			)
			(<L? <+ .START .NUM -1> .MAX>
				<SET .MAX <+ .START .NUM -1>>
			)
	>
	<INC .MAX>
	<INC .START> 
	;"Put the final result back into TEMPTABLE so it can be further manipulated."
	<PUT ,OTHERTABLE 0 <- .MAX .START -1>>
	<SET .J 2>
	<DO (I .START .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE .J > ;"takes into consideration that
												the first word is length,so
												actual text starts at position 3
												in the table."	
	<COND 	(<T? .BKWRDS>
				<REVERSE>
			)
	>
>

"REVERSE [object] [property]
Purpose: Reverse the order of a string
Returns: NULL.
Comment: The result is left in the TEMPTABLE.
"

<ROUTINE REVERSE ("OPT" OBJ PRTY "AUX" MAX C J)
	<COND 	(<T? .OBJ>
				<COND	(<F? .PRTY>
							<SET .MAX <LEN .OBJ>>
						)	
						(T
							<SET .MAX <LEN .OBJ .PRTY>>
						) 
				>
			)
			(T
				<SET .MAX <LEN>>
			)
	>
	<COND 	(<0? .MAX>
				<RFALSE>
			)
	>
	<INC MAX>
	<PUT ,OTHERTABLE 0 <GET ,TEMPTABLE 0>>
	<SET .J 2>
	<DO (I .MAX 2 -1)
		<SET .C <GETB ,TEMPTABLE .I>>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE .J>
>

<ROUTINE SHOWSTRING ("OPT" TBL "AUX" MAX C)
	<COND 	(<F? .TBL>
				<SET .TBL ,TEMPTABLE>
			)
	>
	<SET .MAX <GET .TBL 0>>
	<COND 	(<0? .MAX> ;"empty table returns nothing"
				<RETURN>
			)
	>
	<INC MAX>
	<DO (I  2 .MAX )
		<SET .C <GETB .TBL .I>>
		<PRINTC .C>
	>
>

"LEFT substring-length [object] [property]
Purpose: Extract the left-most substring-length characters in a string
Returns: NULL.
Comment: The result is left in the TEMPTABLE.
"

<ROUTINE LEFT (NUM "OPT" OBJ PRPTY)
	<MID 1 .NUM .OBJ .PRPTY>
>

"RIGHT substring-length [object] [property]
Purpose: Extract the right-most substring-length characters in a string
Returns: NULL.
Comment: The result is left in the TEMPTABLE.
"

<ROUTINE RIGHT (NUM "OPT" OBJ PRPTY)
	<MID 1 <* .NUM -1> .OBJ .PRPTY>
>