# User Types

  * one type of user, can use all features

# Stories

# Browsing

## user browses all songs in a category

user types 'list hip-hop'
returns all hip-hop songs

## user browses all soul songs between a low and high bpm

user types 'list soul 88 102'
returns all soul songs between 88 and 102 bpm

## user browses all songs in a key between a low and high bpm

user types 'list jazz 88 102 CM'
returns all CM jazz songs between 88 and 102

# Adding

## user adds a song

user types "add 'O.C.' 'Time's Up' 88 dm [89]"
adds a record to the database
returns "added record\nartist: O.C song: Time's Up bpm: 88 key: dm b-side bpm: 89"

## user updates a song
user types "list 'Snoop Dogg' 'Drop It Like It\'s Hot'"
returns "Artist Album Song BPM Key Key2"


Acceptance Criteria:

* Student pulls records from the database by passing in genre, low bpm, high bpm, and key arguments
* returns a list of records containing artist album song bpm key key2
