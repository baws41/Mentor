#!/bin/bash
################################################################################
#         Linux Support          Script to test debuging skills                #
#                                                                              #
#  Script :  mentor-really.sh                                                  #
#  Args   :  see usage function                                                #
#  Purpose:  Check system stats                                                #
#                                                                              #
#   Vers  When      Who      What                                              #
#   ----  --------- ---      ----                                              #
#   0.1   01Jul2021 bstewart Initial Version                                   #
#   0.2   22Apr2022 bstewart Reapeat creatin of many inodes and hide output    #
#                            also remove set +x                                #
#   0.3   25Apr2022 bstewart Add incorrect values in sudoers file. Added ver   #
#   0.4   27Apr2022 bstewart changed the compile options for shc.              #
#                                                                              # #                                                                              #
################################################################################
# RCS - Revision Control
#
# $Id$
# $Source$
# $Revision$
# $Date$
#
################################################################################

#Script to test DBA's to trouble shoot.
ver=0.4
case "$1" in
        1)
        #Change fstab
                sed -i 's/mega_data/mega-data/g;s/var/Var/g' /etc/fstab
                ;;
        2)
        #Fill up file system with lots of small files and use up inodes.
            mkdir -p /mega_data/.' ' 2> /dev/null

        touch /mega/.' '/file_{0..9999}_{a..z} > /dev/null 2>&1
        touch /mega_data/.' '/file_{0..9999}_{a..z} > /dev/null 2>&1
        touch /mega_data/.' '/{a..d}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{e..h}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{j..l}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{m..o}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{p..s}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{t..w}_{0..9999}_file.tx > /dev/null 2>&1
        touch /mega_data/.' '/{x..z}_{0..9999}_file.txt > /dev/null 2>&1
        touch /mega_data/.' '/{z..x}_{0..9999}_file.txt > /dev/null 2>&1
        touch /mega_data/.' '/{w..t}_{0..9999}_file.txt > /dev/null 2>&1
        touch /mega_data/.' '/{a..d}_{9999..0}_file_d.txt > /dev/null 2>&1
        touch /mega_data/.' '/{e..h}_{9999..0}_file_c.txt > /dev/null 2>&1
        touch /mega_data/.' '/{j..l}_{9999..0}_file_b.txt > /dev/null 2>&1
        touch /mega_data/.' '/{m..o}_{9999..0}_file_a.txt > /dev/null 2>&1
                ;;
        3)
        #Change root password to force root password reset from single user mode.
                echo -e "Ahc5SoeC\nAhc5SoeC" | passwd  root
        #Changed from moving sudoers to creating a mistake in a sudoers file more likely to happen in real life.
        #mv /etc/sudoers /etc/sudoers.old
        echo -e "#Commands you will allow\n%apache_admin\tALL=(ALL:ALL) /usr/bin/view /var/log/messages\n%admins\tALL=(ALL:ALL) view /var/log/syslog" > /etc/sudoers.d/admin-users

                ;;
        rootpass)
                echo -e "Root password is\nAhc5SoeC"
                ;;
        v)
        echo -e "\n\n\t**** Version $ver. ****\n\n"
                ;;
        *)
        echo -e "\nUsage of this command is:\nsudo mentor x (where x 1-3,v)\n\n\t**** Do Not run this on a live/production server. ****"
                ;;
esac

#To compile
#shc -rU -f mentor-really.sh -o mentor
