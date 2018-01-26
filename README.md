# zilstrings
Some (sort of) string manipulation functions for ZIL.

Digging strings out of DESC is difficult and trying to get to the memory 
location for z-encoded strings that are object properties is nigh impossible.
Further, there is no string data type. However, it is possible to stick 
characters into tables, which serve as buffers. The content of these buffers
can then be manipulated, reordered, copied, etc., and then dumped out as 
text. 

The following functions have been implemented, and use the TEMPTABLE, which
is already defined in the parser, so it doesn't cost anything more in terms
of storage. An auxiliary buffer, "OTHERTABLE" is also used for some functions.
By default, these buffers are only 50 characters long, so if longer bits of 
text are to be manipulated all at once, you would need to allocate storage 
by defining bigger tables.

Most of the functions are written such that if no argument is applied, the
funtion runs on the existing contents of the TEMPTABLE and the result is the
state of that table after the function runs. In that way, a series of 
functions can be run, one after the other. Most functions can also take an 
object reference, and the function would then be applied to the short name 
(DESC) of the object. Finally, if you provide both an object and a property
of that object (presumably, literal text), the function will be applied
to that property.

Here's what's implemented. Arguments in square brackets are optional.

* LEN [object] [property] - returns length of text, leaves the argument in buffer
* MID start substring-length [object] [property] - returns substring; if substrlen
  is negative, counts from the right end of the text
* LEFT substrlen [object] [property] - returns leftmost substring of length substrlen
* RIGHT substrlen [object] [property] - returns the rightmost substring of length substrlen
* ROTATE num [object] [property]- permutes text up or down num; e.g., to generate rot13.
* TOUPPER [object][property] - lowercase text converted to upper case.
* TOLOWER [object] [property] - uppercase text converted to lower case.
* PREPEND sourcetable - insert content of sourcetable before contents in TEMPTABLE
* APPEND sourcetable - append content of sourcetable after contents of TEMPTABLE

The first part of the file sets up a bare bones testing game to play around with
these various functions. In actual use, you would probably want to just copy or 
include the second half of the file, below "functions perform pseudostring 
manipulation".

At present, I am working with verion 0.8 of the ZILF package:

https://bitbucket.org/jmcgrew/zilf/wiki/Home
