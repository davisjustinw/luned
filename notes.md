## TODO
  * build controller method
  * stub CLI methods
  * stub classes
  * stitch it up
---
## Sites
  * Seattle 911 newer API https://dev.socrata.com/foundry/data.seattle.gov/grwu-wqtk
  * Darksky https://api.darksky.net/forecast/
---
## Description
  * Greet User
  * gets <mon yyyy> ex: jan 2004
  * display calendar color coded red == high call volume, green == low call volume
  * gets day
  * displays weather, lunar phase, call stats on hour (color coded?)
  * flex gets hour
  * display address, unit
---
## Domain
  cli - controller (maybe pull out view?)
    view
    prompt
    api - pulls data from sites and initializes object
    day - incidents, observations
      incident - id, unit, type, address
      observation - temp, barometer, lunar phase, precip?
---
## Feature Ideas
  * up command. Example when day is displayed <up 2> would print another day.
  * bread crumb command
## Blog Ideas
  * ambiguous testing?
  * zen and the art of code re-use.  the story of round_to and readability
  * splat breadcrumbs and readability
  * reluctant to build objects but lead to greater readability
  * store objects in other objects or call functions with relations
  * too much in place leads to snaggle code
  * Date DatTime Time a journey with UTC, Daylight savings etc
  * Using Time except for Valid_Date.  Can't use -1 trick for day in Time
  * Revisit Setting month to maximum days.
  * Using TIme on all objects and not storing objects
  * How I learned to write the code I wish I had and returned from despair

## Notes

JSON.pretty_generate(response)
