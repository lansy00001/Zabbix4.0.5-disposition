#/bin/bash
#CONFIG_FILE=/etc/zabbix/zabbix_agentd.d/redis_mem_port.txt
CONFIG_FILE=/etc/zabbix/zabbix_agentd.d/lld_tcplisten_port.txt
Check(){
    #grep -vE '(^ *#|^$)' ${CONFIG_FILE} | grep -vE '^ *[0-9]+' &> /dev/null
    grep -vE "(^ *#|^$)" ${CONFIG_FILE} |grep -vE '^ *[a-z]+' &> /dev/null
    if [ $? -eq 0 ]
    then
        echo Error: ${CONFIG_FILE} Contains Invalid Port.
        exit 1
    else
        #portarray=($(grep -vE '(^ *#|^$)' ${CONFIG_FILE} | grep -E '^ *[0-9]+' | awk -F: '{print $2}'))
        portarray=($(grep -vE '(^ *#|^$)' ${CONFIG_FILE} | awk -F: '{print $2}'))
    fi
}
PortDiscovery(){
    length=${#portarray[@]}
    printf "{\n"
    printf  '\t'"\"data\":["
    for ((i=0;i<$length;i++))
      do
         printf '\n\t\t{'
         printf "\"{#TCP_PORT}\":\"${portarray[$i]}\"}"
         if [ $i -lt $[$length-1] ];then
                    printf ','
         fi
      done
    printf  "\n\t]\n"
    printf "}\n"
}
port(){
    Check
    PortDiscovery
}
port
