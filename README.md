# zilstrings
Some (sort of) string manipulation functions for ZIL.

Digging strings out of DESC is difficult and trying to get to the memory 
location for z-encoded strings that are object properties is nigh impossible.
However, since everything eventually boils down to displaying text to the 
player, I thought it worthwhile to develop some reusable code to make it
easier to manipulate text more along the lines of functions found in other
high-level languages, for example, functions to grab a string, determine
its length, chop it in pieces, flip it around, or otherwise transform it.

At present, I am working with verion 0.8 of the ZILF package:

https://bitbucket.org/jmcgrew/zilf/wiki/Home
