#!/usr/bin/env bash
###########################################################################
## ID: block_hate.sh
## DESC: creates DNSBL for use with Pi-hole, BIND, and BlueCat
## AUTHOR: Clair High <github.com@fwd.tch3.com>
## DATE: 2017-10-13, 2019-08-10
###########################################################################
scratch=$(mktemp -d -t tmp.XXXXXXXXXX) # $scratch will be auto-deleted on
finish () { rm -rf $scratch ; }        # exit no matter the exit status
trap finish EXIT INT
###########################################################################
# SHELL SETTINGS
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o posix
#set -o verbose
#set -o xtrace
###########################################################################
# USER CONFIGURABLE VARIABLES
prefix="hategrp"
input="import.csv" 
address="127.0.0.1"
###########################################################################
# PLEASE DO NOT CHANGE THE FOLLOWING
rpz_zone="${prefix}.rpz"
import_file="${rpz_zone}_BAM-import.txt" 
bind_db="${rpz_zone}.db"
pihole_txt="blocklist.txt"
input_tmp="${scratch}/${input}.$$" 
pihole_wildcard="04-pihole-wildcard.conf"
########################################################################### 

if [[ ! -f ${input} ]]
then
    printf "error: missing input file\n"
    exit 1
fi

domains=$(grep -v ^# ${input} | awk -F'|' '{print $2}' | sort)

function help() {
printf "Usage: $(basename $0) -abchin\n"
printf "Options:
    -a, --all     create RPZ import file for Address Manager and BIND database
    -b, --bind    create BIND database
    -c, --clean   clean all files
    -h, --help    prints this help message
    -i, --import  creates RPZ import file for Address Manager
    -n, --named   prints requisite named.conf info
    -p, --pihole  creates file that can be imported into Pi-hole\n"
}

function create_import_file() {
    if [[ -f $import_file ]]
        then rm ${import_file}
    fi
    for domain in ${domains[@]}
    do
        printf "**.${domain}\n" >> ${import_file}
    done
}

function create_pihole_list() {
    for file in ${pihole_txt} ${pihole_wildcard}
    do
        if [[ -e ${file} ]]
            then rm ${file}
        fi
    done
    
cat <<EOF >> ${pihole_txt}
# Hate group DNS Blocklist
# Based off Southern Poverty Law Center's list of hate groups. 
#   Source: https://www.splcenter.org/fighting-hate
#           https://www.splcenter.org/hate-map
#   URL: https://tch3.net/hg-dnsbl/blocklist.txt
#   URL: https://raw.githubusercontent.com/chigh/hategroup-dnsbl/master/blocklist.txt
# Date: $(date +%Y-%m-%d)
#
EOF

cat <<EOF >> ${pihole_wildcard}
# Hate group DNS Blocklist
# Based off Southern Poverty Law Center's list of hate groups. 
#   Source: https://www.splcenter.org/fighting-hate
#           https://www.splcenter.org/hate-map
#   URL: https://tch3.net/hg-dnsbl/blocklist.txt
#   URL: https://raw.githubusercontent.com/chigh/hategroup-dnsbl/master/blocklist.txt
#
# Copy this file to /etc/dnsmasq.d on your Pi-hole appliance and restart Pi-hole:
#
#   pihole restartdns
#
# Date: $(date +%Y-%m-%d)
#
EOF

    for domain in ${domains[@]}
      do 
        printf "${domain}\n" >> ${pihole_txt}
        printf "address=/${domain}/${address}\n" >> ${pihole_wildcard}
    done
}

function create_named_conf()  { 
    printf "Include the following in your named.conf in the DNS view\n\n"
    #printf  "   response-policy { zone \"${rpz_zone}\" policy CNAME localhost; };
    printf  "   response-policy { zone \"${rpz_zone}\" policy NODATA; };

    // zone: ${rpz_zone}
    zone \"${rpz_zone}\"
    {
        type master;
        file \"${bind_db}\";
        allow-transfer { 127.0.0.1; };
    };\n"
}

function create_bind_db() {
#sort -k2 -n ${input} > ${input_tmp}
cat > ${bind_db} <<EOL
\$TTL 5
@ IN SOA LOCALHOST. postmaster.no.email.please. ( 1 3600 600 2592000 3600 )
@ IN NS LOCALHOST.
LOCALHOST. IN A 127.0.0.1
EOL

    for domain in ${domains[@]}
    do
        printf "*.${domain} CNAME .\n" >> ${bind_db}
        printf "${domain} CNAME .\n" >> ${bind_db}
    done
}

function clean_up() {
    if [[ -f ${input_tmp} ]]
      then rm -f ${input_tmp}
    fi
}

function clean_all() {
    for file in ${input_tmp} ${bind_db} ${import_file}
    do
        if [[ -f ${file} ]]
          then rm -f ${file}
        fi
    done
}

case "${1-}" in
    -a|--all) create_named_conf && create_import_file && create_bind_db && create_pihole_list;;
    -b|--bind) create_bind_db      ;;
    -c|--clean) clean_all && exit 0 ;;
    -h|--help) help && exit 0      ;;
    -i|--import) create_import_file  ;;
    -n|--named) create_named_conf   ;;
    -p|--pihole) create_pihole_list ;;
     *) clean_up; printf "error: invalid option\n\n" && help ; exit 1 ;;
esac

clean_up
