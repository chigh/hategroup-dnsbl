# Hate Group DNS Blacklist

* [Overview](#overview)
* [Files & Notes](#files--notes)
	* [Pi-hole](#pi-hole)
	* [ISC BIND](#isc-bind)
	* [BlueCat Address Manager/Response Policies](#bluecat-address-managerresponse-policies)
* [To do](#to-do)
* [Sources](#sources)
* [License](#license)

## Overview
This is a list of designated hate groups' domains as designated by the [Southern Poverty Law Center](http://splcenter.org).
Please report errors [here](https://github.com/chigh/hategroup-dnsbl/issues).

**Note:** This project and I am are in *no* way associated with SPLC. I created this with data from their public website plus a handful of other domains I have come across. (see the Custom section in *import.csv*)

* Not all groups have domains; Some have facebook or pages on other shared resources. This will be noted in the *import.csv* if further information is available. This information will be periodically back-filled as it becomes available.
* Some ideologies have overlap. Pi-hole will account for that. 

Included in this bundle are files and configuration code to be used with [Pi-hole](https://pi-hole.net), [ISC BIND](https://isc.org) Response Policies, or [BlueCat](https://bluecatnetworks.com) Response Policies.

## Files & Notes 
* *block_hate.sh*
	* Script to generate the list objects
* *import.csv*
	* A comma separated variable file of domains and the names of the organizations. This is for reference and to generate all of the lists.
    * Lines beginning with ? are groups/domains that are not in the 2018 list ([Source](https://www.splcenter.org/hate-map)).
    * Lines beginning with + are newly added groups in the 2018 list.

### Pi-hole
With Pi-hole, use either the wildcard list or the blacklist, but not both. 

* *blocklist.txt*
	* A text file list of only the domains.
	* This can be added to Pi-hole configuration on a local web server or add the following URL to Pi-hole's Block Lists ([instructions](https://github.com/pi-hole/pi-hole/wiki/Customising-sources-for-ad-lists)):
		* https://tch3.net/hg-dnsbl/blocklist.txt
		* https://raw.githubusercontent.com/chigh/hategroup-dnsbl/master/blocklist.txt
* *04-pihole-wildcard.conf*
	* Wildcard domain list for Pi-hole. When using the GUI, *03-pihole-wildcard.conf* is created and used. Used as a separate file, *dnsmasq* will read in the contents for both without having to worry about overwriting anything added within the GUI. Less work.
    * Modify this file to contain the IP address of your Pi-Hole appliance.
	* Copy this file into */etc/dnsmasq.d* onto your Pi-hole appliance and restart Pi-hole: 
		* `pihole restartdns`

### ISC BIND
* *hategrp.rpz.db*
	* BIND zone database file to be used with the contents of named.conf for BIND's Response Policies
* *hategrp.rpz_BAM-import.txt*
	* A file to be imported into BlueCat Address Manager to create a hate group based Response Policy
* *named.conf*
	* A section of named.conf to be included in your BIND implementation to use the included database. This goes in the *view* section.

### BlueCat Address Manager/Response Policies
Importing the generated file will over-write all entries in the Response Policy in which this list is imported.

* *hategrp.rpz_BAM-import.txt*

## Sources 

**Note:** This is a work in progress and I haven't gotten to all sections, yet.

| [Ideology] & [Sources]            | Date     |
| :--                               | :--:     |
| [Alt-Right]                       |2018-07-06|
| [Anti-Immigrant]                  |2019-08-08|
| [Anti-LGBT]                       |2017-10-13|
| [Anti-Muslim]                     |2017-10-13|
| [Antigovernment Movement]         |TBD|
| [Black Separatist]  		        |2019-08-10|
| [Christian Identity] 		        |2019-08-10|
| [General Hate]                    |2019-08-10|
| [Hate Music]                      |[N/A]|
| [Holocaust Denial]                |2017-09-25|
| [KKK]                             |2017-09-25|
| [Male Supremacy]                  |2019-08-06|
| [Neo-Confederate]                 |2017-09-25|
| [Neo-Nazi]                        |2017-10-17|
| [Phineas Priesthood]              |[N/A]|
| [Racist Skinheads]                |2017-09-25|
| [Radical Traditional Catholicism] |2017-10-25|
| [Sovereign Citizens Movement]     |[N/A]|
| [White Nationalist]               |2017-09-25|

* There is no SPLC for Canada, so based upon a groups related to the ones already in the list.
	* [A guide to Canada's anti-Islamic groups -- NowToronto](https://nowtoronto.com/news/canada-islamophobic-groups/)


## To do

* Fill in with 2018 data from SPLC's hate map. [in progress]
* Complete the Antigovernment Movement.
	* There are 475 groups listed. Some may be grouped under a single domain, but until I can research, they are all considered to be individual groups with potentially individual domains.

## License
Copyright &copy; 2019 Clair High &mdash; Licensed under [MIT](https://raw.githubusercontent.com/chigh/hategroup-dnsbl/master/LICENSE.md).

[N/A]:  # "No specific groups are listed or found for this ideology."
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
[male supremacy]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/male-supremacy
[neo-confederate]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/neo-confederate
[neo-nazi]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/neo-nazi
[phineas priesthood]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/phineas-priesthood
[racist skinheads]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/racist-skinhead
[radical traditional catholicism]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/radical-traditional-catholicism
[sovereign citizens movement]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/sovereign-citizens-movement
[white nationalist]: https://www.splcenter.org/fighting-hate/extremist-files/ideology/white-nationalist

