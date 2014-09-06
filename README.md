# DJW

command line application for personal music database

## Installation Instructions

  1. Clone this repository
  2. ??
  3. Profit

## Usage

Run:

    ./dj

read prompt, type way to search.

## Technologies / Dependencies

  * Ruby 2.0.0

## Contributors

Will Daly, with some stuff from Eliza Marcum

## License

Copyright (c) 2014 Will Daly. All Rights Reserved.  

## To Do
* key searches for ambiguous keys too, like Eb or e
**	ok EbM will find Eb
*	but bbm will find b, not right (wait what?)
*	and that doesn’t transpose
* key searches for secondary key as well
* whereis-id shows bside bpm, just prints string
* add other genres
* figure out how to deal with genre. add genre column to csv? or make a different table? in my mind, they are.
  possibly rename songs table to be just hip hop?
* make it shorter to get to song search types, maybe change how to pass in the argument
* do recently added, add timestamp for added, table print the last 50 added tracks
* change transpose to be +3;387
* reorder playlist: gotta make it bump up everything after it
* add checks to see if records already exist
* possibly different gets methods?
*	do a gets with regular expressions to handle input
* playlist is broken

## DONE:
* change what input gets split on so that i can search for jay-z. use ;
* drop hiphop db, reimport with the right values
