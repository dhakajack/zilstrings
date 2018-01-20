"EMPTY GAME main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"Stringish|
An interactive fiction by Jack">

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

<SYNTAX MID = V-MID>	
<SYNTAX MID OBJECT = V-MID>
<SYNTAX MIDPRES OBJECT = V-PRESMID>
	
<SYNTAX REV = V-REV>	
<SYNTAX REV OBJECT = V-REV>
<SYNTAX REVPRES OBJECT = V-PRESREV>	
	

<ROUTINE V-LONG ()
	<TELL "The description length is " N <LEN ,PRSO> CR>	
>

<ROUTINE V-PRESLONG ()
	<TELL "The length of the presidential name, if any, associated with " D ,PRSO " is: " N <LEN ,PRSO ,P?PRESIDENT> CR> 
>

<ROUTINE V-MID ()
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO>
			<CRLF>
		>
	>
	<TELL "." CR>
>

<ROUTINE V-PRESMID ()
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID .O .I ,PRSO ,P?PRESIDENT>
			<CRLF>
		>
	>
	<TELL "." CR>
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
				<DIROUT 3 ,TEMPTABLE>
				<COND 	(<F? .PRPTY> ;"was the optional argument, a property, supplied?"
							<PRINTD .OBJ>
						)
						(<GETP .OBJ .PRPTY> ;"only try to print it if it's not null, i.e., is defined."
							<TELL <GETP .OBJ .PRPTY>>
						)
				>	
				<DIROUT -3>
			)
	>
	<SET .MAX <GET ,TEMPTABLE 0>> ;"as side effect, reads argument into the temptable buffer"
	<RETURN .MAX>
>

; "print the string starting at element START for NUM characters (or up to end, if shorter)"
<ROUTINE MID (START NUM "OPT" OBJ PRPTY "AUX" MAX C)
	<COND 	(<=? .NUM 0> ; "zero length yields nothing, blow this clam bake."
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
				<RFALSE> ;"as would be the case if, for example, a property were supplied, but the
						   object's property is either <> or the object doesn't have that property"
			)
			(<L? <+ .START .NUM -1> .MAX>
				<SET .MAX <+ .START .NUM -1>>
			)
	>
	<INC .MAX>
	<INC .START>
	<DO (I .START .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<PRINTC .C>
	>		
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

