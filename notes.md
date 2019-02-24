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
  * too much in place leads to snaggle code

## Notes

JSON.pretty_generate(response)
