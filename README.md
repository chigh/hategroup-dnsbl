# Hate Group DNSBL

This is a list of designated hate groups' domains as designated by the [Southern Poverty Law Center](http://splcenter.org).

**Note:** This project and I am are in *no* way associated with SPLC. I created this with data from their public website plus a handful of other domains I have come across. (see the Custom section in *import.csv*)

* Not all groups have domains; Some have facebook or pages on other shared resources. This will be noted in the *import.csv* if further information is available. This information will be periodically back-filled as it becomes available.
* Some ideologies have overlap. Pi-hole will account for that. 

Included in this bundle are files and configuration code to be used with [Pi-hole](https://pi-hole.net), [ISC BIND](https://isc.org) Response Policies, or [BlueCat](https://bluecatnetworks.com) Response Policies.

## Files

* *04-pihole-wildcard.conf*
	* Wildcard domain list for Pi-hole. When using the GUI, *03-pihole-wildcard.conf* is created and used. Used as a separate file, *dnsmasq* will read in the contents for both without having to worry about overwriting anything added within the GUI. Less work.
	* Copy this file into */etc/dnsmasq.d* onto your Pi-hole appliance and restart Pi-hole: 
		* `pihole restartdns`
* *block_hate.sh*
	* Script to generate the list objects
* *blocklist.txt*
	* A text file list of only the domains.
	* This can be added to Pi-hole configuration on a local web server or add the following URL to Pi-hole's Block Lists ([instructions](https://github.com/pi-hole/pi-hole/wiki/Customising-sources-for-ad-lists)):
		* https://tch3.net/hg-dnsbl/blocklist.txt
		* https://raw.githubusercontent.com/chigh/hategroup-dnsbl/master/blocklist.txt
* *hategrp.rpz.db*
	* BIND zone database file to be used with the contents of named.conf for BIND's Response Policies
* *hategrp.rpz_BAM-import.txt*
	* A file to be imported into BlueCat Address Manager to create a hate group based Response Policy
* *import.csv*
	* A comma separated variable file of domains and the names of the organization.
	* For reference and to generate all of the lists.
* *named.conf*
	* A section of named.conf to be included in your BIND implementation to use the included database

### Pi-Hole
With Pi-hole, use either the wildcard list or the singular blacklist.txt, but not both. 

### BIND
TBD

### BlueCat
Importing the generated file will over-write all entries in the Response Policy in which this list is imported.

## To do

* Complete all ideologies.

## Ideologies checked/completed: 

**Note:** This is a work in progress and I haven't gotten to all sections, yet.

| [Ideology] & [Sources]            | Date     |
| :--                               | :--:     |
| [Alt-Right]                       |[N/A][na]|
| [Anti-Immigrant]                  |2017-09-25|
| [Anti-LGBT]                       |2017-10-13|
| [Anti-Muslim]                     |2017-10-13|
| [Antigovernment Movement]         |[NEXT]|
| [Black Separatist]  		        |TBD|
| [Christian Identity] 		        |TBD|
| [General Hate]                    |TBD|
| [Hate Music]                      |TBD|
| [Holocaust Denial]                |2017-09-25|
| [KKK]                             |2017-09-25|
| [Neo-Confederate]                 |2017-09-25|
| [Neo-Nazi]                        |TBD|
| [Phineas Priesthood]              |TBD|
| [Racist Skinheads]                |2017-09-25|
| [Radical Traditional Catholicism] |TBD|
| [Sovereign Citizens Movement]     |TBD|
| [White Nationalist]               |2017-09-25|

[na]:   # "No specific groups are listed or found for this ideology."
[next]: # "This is next on the list to be done."
[sources]: https://www.splcenter.org/fighting-hate
[ideology]: https://www.splcenter.org/fighting-hate/extremist-files/ideology
[alt-right]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/alt-right
[anti-immigrant]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/anti-immigrant
[anti-lgbt]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/anti-lgbt
[anti-muslim]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/anti-muslim
[antigovernment movement]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/antigovernment
[black separatist]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/black-separatist
[christian identity]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/christian-identity
[general hate]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/general-hate
[hate music]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/hate-music
[holocaust denial]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/holocaust-denial
[kkk]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/ku-klux-klan
[neo-confederate]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/neo-confederate
[neo-nazi]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/neo-nazi
[phineas priesthood]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/phineas-priesthood
[racist skinheads]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/racist-skinhead
[radical traditional catholicism]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/radical-traditional-catholicism
[sovereign citizens movement]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/sovereign-citizens-movement
[white nationalist]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/white-nationalist
