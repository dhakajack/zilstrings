"EMPTY GAME main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"Stringish|
An interactive fiction by Jack">

<CONSTANT OTHERTABLE <ITABLE 50>> ;"Holds intermediate results before copying back to TEMPTABLE"
<CONSTANT MAXTBLSIZE 50>

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
	(PRESIDENT "James K. Polk, Napoleon of the Stump.")
>

<OBJECT TMARBLE
	(DESC "marble")
	(SYNONYM MARBLE SPHERE)
	(ADJECTIVE GLASS)
	(IN LAB)
	(LDESC "A sphere of coloured glass.")
>

"Verbs"

<SYNTAX LEN = V-LONG> 
<SYNTAX LEN OBJECT = V-LONG>
<SYNTAX LENPRES OBJECT = V-PRESLONG>

<SYNTAX MID = V-MID>
<SYNTAX MID OBJECT = V-MID>
<SYNTAX MIDPRES OBJECT = V-PRESMID>
	
<SYNTAX REV = V-REV>	
<SYNTAX REV OBJECT = V-REV>
<SYNTAX REVPRES OBJECT = V-PRESREV>	
	
<SYNTAX SHOW = V-SHOW>
<SYNTAX SHOWOTHER = V-SHOWOTHER>
	
<SYNTAX LEFT = V-LEFT>
<SYNTAX LEFT OBJECT = V-LEFT>
<SYNTAX LEFTPRES OBJECT = V-PRESLEFT>
	
<SYNTAX RIGHT = V-RIGHT>
<SYNTAX RIGHT OBJECT = V-RIGHT>
<SYNTAX RIGHTPRES OBJECT = V-PRESRIGHT>
	
<SYNTAX ROTATE = V-ROTATE>
<SYNTAX ROTATE OBJECT = V-ROTATE>
<SYNTAX ROTATEPRES OBJECT = V-PRESROTATE>
	
<SYNTAX TOUPPER = V-TOUPPER>
<SYNTAX TOUPPER OBJECT = V-TOUPPER>
<SYNTAX TOUPPERPRES OBJECT = V-PRESTOUPPER>
	
<SYNTAX TOLOWER = V-TOLOWER>
<SYNTAX TOLOWER OBJECT = V-TOLOWER>
<SYNTAX TOLOWERPRES OBJECT = V-PRESTOLOWER>
	
<SYNTAX PREPEND = V-PREPEND>
<SYNTAX APPEND = V-APPEND>

<ROUTINE V-PREPEND ()
	<TELL "Starting contents of TEMPTABLE: ">
	<SHOWSTRING>
	<TELL "|Starting content of OTHERTABLE: " >
	<SHOWSTRING ,OTHERTABLE>
	<TELL "|And now combined..." CR>
	<PREPEND ,OTHERTABLE>
	<SHOWSTRING>
	<CRLF>	
>

<ROUTINE V-APPEND ()
	<TELL "Starting contents of TEMPTABLE: ">
	<SHOWSTRING>
	<TELL "|Starting content of OTHERTABLE: " >
	<SHOWSTRING ,OTHERTABLE>
	<TELL "|And now combined..." CR>
	<APPEND ,OTHERTABLE>
	<SHOWSTRING>
	<CRLF>	
>

<ROUTINE V-TOUPPER ()
	<TOUPPER ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESTOUPPER ()
	<TOUPPER ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>
	
<ROUTINE V-TOLOWER ()
	<TOLOWER ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESTOLOWER ()
	<TOLOWER ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-LONG ()
	<TELL "The description length is " N <LEN ,PRSO> CR>	
>

<ROUTINE V-PRESLONG ()
	<TELL "The length of the presidential name, if any, associated with " D ,PRSO " is: " N <LEN ,PRSO ,P?PRESIDENT> CR> 
>

<ROUTINE V-MID ("AUX" BEGIN SSLEN) ;"demo midstring function on an object's name"
	<LEN ,PRSO> ;"just to load it in; could also test if LEN > 0 to proceed"
	<MIDCOMMON>
>

<ROUTINE V-PRESMID ()
	<LEN ,PRSO ,P?PRESIDENT>
	<MIDCOMMON>
>

<ROUTINE MIDCOMMON ("AUX" BEGIN SSLEN)
	<TELL "Starting at what position?" CR>
	<SET .BEGIN <GETNUM>>
	<TELL "What is the substring length (negative for other end)?" CR>
	<SET .SSLEN <GETNUM>>
	<MID .BEGIN .SSLEN>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-LEFT ("OPT" OBJ PRPTY "AUX" NUM)
	<TELL "How many characters?" CR>
	<SET .NUM <GETNUM>>
	<LEFT .NUM ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESLEFT ("OPT" OBJ PRPTY "AUX" NUM)
	<TELL "How many characters?" CR>
	<SET .NUM <GETNUM>>
	<LEFT .NUM ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-RIGHT ("OPT" OBJ PRPTY "AUX" NUM)
	<TELL "How many characters?" CR>
	<SET .NUM <GETNUM>>
	<RIGHT .NUM ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESRIGHT ("OPT" OBJ PRPTY "AUX" NUM)
	<TELL "How many characters?" CR>
	<SET .NUM <GETNUM>>
	<RIGHT .NUM ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-SHOW () ;"show what's in the scratch buffer"
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-SHOWOTHER () ;"just of diagnostic interest"
	<SHOWSTRING ,OTHERTABLE>
	<CRLF>
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

<ROUTINE V-ROTATE ("AUX" NUM)
	<TELL "Rotate how many charcters, positive or negative?">
	<SET .NUM <GETNUM>>
	<ROTATE .NUM ,PRSO>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE V-PRESROTATE ("AUX" NUM)
	<TELL "Rotate how many charcters, positive or negative?">
	<SET .NUM <GETNUM>>
	<ROTATE .NUM ,PRSO ,P?PRESIDENT>
	<SHOWSTRING>
	<CRLF>
>

<ROUTINE GETNUM ()
	<REPEAT ()
		<TELL "#>">
		<READLINE>
		<COND 	(<PARSE-NUMBER? 1>
					<RETURN>
				)
				(T
					<TELL "Please enter an integer." CR >
				)
		>
	>
	<RETURN ,P-NUMBER>
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

"ROTATE how-many-units [object] [property]
Purpose: Permute text by a constant number of characters right or, if negative, left
Returns: NULL.
Comment: The result is left in TEMPTABLE.
"
<ROUTINE ROTATE (ROT "OPT" OBJ PRTY "AUX" MAX C J)
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
	<SET .ROT <MOD .ROT 26>>
	<COND 	(<L? .ROT 0>
				<SET .ROT <+ .ROT 26>>
			)
	>
	<INC MAX>
	<PUT ,OTHERTABLE 0 <GET ,TEMPTABLE 0>>
	<SET .J 2>
	<DO (I 2 .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<COND 	(<AND <G=? .C !\a> <L=? .C !\z>>
					<SET .C <+ .C .ROT>>
					<COND 	(<G? .C !\z>
								<SET .C <- .C 26>>
							)
					>
				)
				(<AND <G=? .C !\A> <L=? .C !\Z>>
						<SET .C <+ .C .ROT>>
						<COND 	(<G? .C !\Z>
								<SET .C <- .C 26>>
							)
					>
				)
		>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE .J>
>


"TOUPPER [object] [property]
Purpose: PUT TEXT IN ALL CAPS
Returns: NULL.
Comment: The result is left in TEMPTABLE.
"
<ROUTINE TOUPPER ("OPT" OBJ PRTY "AUX" MAX C J)
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
	<DO (I 2 .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<COND 	(<AND <G=? .C !\a> <L=? .C !\z>>
					<SET .C <- .C <- !\a  !\A>>>
				)
		>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE .J>
>

"TOLOWER [object] [property]
Purpose: PUT TEXT IN ALL CAPS
Returns: NULL.
Comment: The result is left in TEMPTABLE.
"
<ROUTINE TOLOWER ("OPT" OBJ PRTY "AUX" MAX C J)
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
	<DO (I 2 .MAX)
		<SET .C <GETB ,TEMPTABLE .I>>
		<COND 	(<AND <G=? .C !\A> <L=? .C !\Z>>
					<SET .C <+ .C <- !\a  !\A>>>
				)
		>
		<PUTB ,OTHERTABLE .J .C>
		<INC .J>
	>
	<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE .J>
>

<ROUTINE PREPEND (SRCTBL "AUX" LENSRC C POS)
	<SET .LENSRC <GET .SRCTBL 0>>
	<COND 	(<0? .LENSRC>
				<RETURN>
			)
			(<G=? .LENSRC MAXTBLSIZE>
				<COPY-TABLE-B ,OTHERTABLE ,TEMPTABLE MAXTBLSIZE>
				<RETURN>
			)
	>
	<SET .POS <+ .LENSRC <GET ,TEMPTABLE 0> 1>>
	<COND 	(<G? .POS <+ 1 MAXTBLSIZE>>
				<SET .POS <+ 1 MAXTBLSIZE>>
			)
	>
	<DO (I .POS <=? .I <- .POS <GET ,TEMPTABLE 0>>> -1)
		<SET .C <GETB ,TEMPTABLE <- .I .LENSRC>>>
		<PUTB ,TEMPTABLE .I .C>
	>
	<PUT ,TEMPTABLE 0 <- .POS 1>>
	<DO (I 2 <G? .I <+ .LENSRC 1>>)
		<SET .C <GETB .SRCTBL .I>>
		<PUTB ,TEMPTABLE .I .C>
	>
>

<ROUTINE APPEND (SRCTBL "AUX" LENSRC C POS)
	<SET .LENSRC <GET .SRCTBL 0>>
	<TELL "Length to be appended: " N .LENSRC CR>
	<COND 	(<0? .LENSRC>
				<TELL "DEBUG: RETURNING: Nothing to add." CR>
				<RETURN>
			)
			(<G=? <GET ,TEMPTABLE 0> MAXTBLSIZE>
				<TELL "DEBUG: No room to add anything, temptable already maxed" CR>
				<RETURN>
			)
	>
	<SET .POS <+ <GET ,TEMPTABLE 0> 2>>
	<TELL "Starting at position: " N .POS CR>
	<DO (I 1 <OR <G? .I .LENSRC> <G? .POS <+ MAXTBLSIZE 1>>>)
		<SET .C <GETB ,OTHERTABLE <+ .I 1>>>
		<TELL "Adding: " C .C CR>
		<PUTB ,TEMPTABLE .POS .C>
		<INC .POS>
	>
	<PUT ,TEMPTABLE 0 <- .POS 2>>
	<TELL "DONE." CR>
>