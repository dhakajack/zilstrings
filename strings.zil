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
 
<SYNTAX LONG OBJECT = V-LONG>
<SYNTAX LONG = V-LONG>
<SYNTAX PRES OBJECT = V-PRES>
<SYNTAX MID OBJECT = V-MID>

<ROUTINE V-LONG ()
	<TELL "The length for the " D ,PRSO  " description is " N <LEN ,PRSO> CR>	
>

<ROUTINE V-PRES ()
	<TELL "The length of the presidential name associated with " D ,PRSO " is: " N <LEN ,PRSO ,P?PRESIDENT> CR> 
>

<ROUTINE V-MID ()
	<DO (O 0 7)
		<DO (I 0 7)
			<TELL "Outer " N .O " and inner " N .I ": " >
			<MID ,PRSO .O .I ,P?PRESIDENT>
			<CRLF>
		>
	>
	<TELL "." CR>
>

<ROUTINE LEN ("OPT" OBJ  PRPTY "AUX" MAX ) ;"if object supplied, operates on whatever remains in temptable buffer"
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
	<SET .MAX <GET ,TEMPTABLE 0>>
	<RETURN .MAX>
>

; "print the string starting at element START for NUM characters (or up to end, if shorter)"
<ROUTINE MID (ITEM START NUM "OPT" PRPTY "AUX" MAX C)
	<COND 	(<=? .NUM 0> ; "zero length yields nothing, blow this clam bake."
				<RFALSE>
			)			
			(<F? .PRPTY> ;"was the optional argument, a property, supplied?"
				<SET .MAX <LEN .ITEM>>
			)
			(T
				<SET .MAX <LEN .ITEM .PRPTY>>
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
		<SET C <GETB ,TEMPTABLE .I>>
		<PRINTC .C>
	>		
>


