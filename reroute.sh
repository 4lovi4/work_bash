#!/bin/sh

TEL_GW='192.168.42.129'
W_GW='10.58.2.1'

function f_usage ()
{
        echo "usage:
        $0 <-p> - through 3G
        $0 <-s> - through working network"
        exit 1
}

if [ $# -eq 0 ];then
        f_usage

else

        case $1 in 
                "-s"|"s"|"S"|"-S" )
                        echo "working network wan!"
                        /sbin/route del default dev usb0
                        if [ `echo $?` -eq 0 ];then 
                                echo "phone deleted!"
                        fi
                        /sbin/route add default gw "$W_GW" dev eth0
                        if [ `echo $?` -eq 0 ];then 
                                echo "working network added!"
                        fi
                        ;;
                "-p"|"p"|"P"|"-P" )
                        /sbin/dhclient usb0
                        echo "3G wan!"
                        /sbin/route del default dev eth0
                        /sbin/ip route add default via "$TEL_GW" dev usb0
                        if [ `echo $?` -eq 0 ];then 
                                echo "working network deleted and phone added!"
                        fi
                        ;;
                * )
                        f_usage
                        ;;
        esac
fi
exit 0
