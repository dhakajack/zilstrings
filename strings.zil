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
	
<SYNTAX REV = V-REV>	
<SYNTAX REV OBJECT = V-REV>
<SYNTAX REVPRES OBJECT = V-PRESREV>	
	
<SYNTAX SHOW = V-SHOW>
<SYNTAX SHOWOTHER = V-SHOWOTHER>
	

<ROUTINE V-LONG ()
	<TELL "The description length is " N <LEN ,PRSO> CR>	
>

<ROUTINE V-PRESLONG ()
	<TELL "The length of the presidential name, if any, associated with " D ,PRSO " is: " N <LEN ,PRSO ,P?PRESIDENT> CR> 
>

<ROUTINE V-MIDBUF ()
	<DO (I 7 2 -1)
		<TELL "Outer 2 and inner " N .I ": " >
		<MID 2 .I>
		<SHOWSTRING>
		<CRLF>
	>
>

<ROUTINE V-MID ()
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO>
			<SHOWSTRING>
			<CRLF>
		>
	>
>

<ROUTINE V-SHOW ()
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-SHOWOTHER ()
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
	<TELL "Reverse is: ">
	<REVERSE ,PRSO>
	<TELL "." CR>
>

<ROUTINE V-PRESREV ()
	<TELL "The reverse of the president (if any) of " D ,PRSO " is: ">
	<REVERSE ,PRSO ,P?PRESIDENT>
>

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

; "Print the string starting at element START for NUM characters (or up to end, if shorter)"
<ROUTINE MID (START NUM "OPT" OBJ PRPTY "AUX" MAX J C)
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
	<INC .START> ;"Put the final result back into TEMPTABLE so it can be further manipulated."
	<PUT ,OTHERTABLE 0 <- .MAX .START -1>>
	<SET .J 2>
	<DO (I .START .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE <- .MAX .START -3>> ;"takes into consideration that
																the first word is length, so
																max - start +1 copied."
>

<ROUTINE REVERSE ("OPT" OBJ PRTY "AUX" MAX C)
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
				<SET .MAX LEN>
			)
	>
	<COND 	(<0? .MAX>
				<RFALSE>
			)
	>
	<INC MAX>
	<DO (I .MAX 2 -1)
		<SET .C <GETB ,TEMPTABLE .I>>
		<PRINTC .C>
	>
>

<ROUTINE SHOWSTRING ("OPT" TBL "AUX" MAX C)
	<COND 	(<F? .TBL>
				<SET .TBL ,TEMPTABLE>
			)
	>
	<SET .MAX <GET .TBL 0>>
	<COND 	(<0? .MAX>
				<RETURN>
			)
	>
	<INC MAX>
	<DO (I  2 .MAX )
		<SET .C <GETB .TBL .I>>
		<PRINTC .C>
	>
>
