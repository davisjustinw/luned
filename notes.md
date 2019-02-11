## TODO
  * build controller method
  * stub CLI methods
  * stub classes
  * stitch it up
---
## Sites
  * Seattle 911 - https://opendata.socrata.com/resource/4fng-4fdn.json
  * Wunderground - https://www.wunderground.com/history/daily/us/wa/seattle-boeing/KBFI/date/2019-2-1
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
    scraper - pulls data from sites and initializes object
      month - days, name, year
        day - incidents, observations
          incident - id, unit, type, address
          observation - temp, barometer, lunar phase, precip?
---
## Feature Ideas
  * up command. Example when day is displayed <up 2> would print another day.
  * bread crumb command
## Blog Ideas
  * ambiguous testing
