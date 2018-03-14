a:33:{i:0;a:3:{i:0;s:14:"document_start";i:1;a:0:{}i:2;i:0;}i:1;a:3:{i:0;s:10:"table_open";i:1;a:3:{i:0;i:4;i:1;i:2;i:2;i:1;}i:2;i:0;}i:2;a:3:{i:0;s:13:"tablerow_open";i:1;a:0:{}i:2;i:0;}i:3;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:0;}i:4;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:"id";}i:2;i:2;}i:5;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:4;}i:6;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:4;}i:7;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:"value";}i:2;i:5;}i:8;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:10;}i:9;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:10;}i:10;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:"usage";}i:2;i:11;}i:11;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:16;}i:12;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:16;}i:13;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:11:"utilization";}i:2;i:17;}i:14;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:28;}i:15;a:3:{i:0;s:14:"tablerow_close";i:1;a:0:{}i:2;i:29;}i:16;a:3:{i:0;s:13:"tablerow_open";i:1;a:0:{}i:2;i:29;}i:17;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:29;}i:18;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"a";}i:2;i:31;}i:19;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:32;}i:20;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:32;}i:21;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"none";}i:2;i:33;}i:22;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:37;}i:23;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:37;}i:24;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:"80";}i:2;i:38;}i:25;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:40;}i:26;a:3:{i:0;s:14:"tablecell_open";i:1;a:3:{i:0;i:1;i:1;N;i:2;i:1;}i:2;i:40;}i:27;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"used";}i:2;i:41;}i:28;a:3:{i:0;s:15:"tablecell_close";i:1;a:0:{}i:2;i:45;}i:29;a:3:{i:0;s:14:"tablerow_close";i:1;a:0:{}i:2;i:46;}i:30;a:3:{i:0;s:11:"table_close";i:1;a:1:{i:0;i:46;}i:2;i:46;}i:31;a:3:{i:0;s:4:"code";i:1;a:3:{i:0;s:2326:"

#!/bin/sh
# This is script is used for implementing a ssl tunnel via SSH. Forwarding remote port to local port 11945.
# Wirtten by Libo.Ma @ 2014.2.19 Wed Feb 19 22:59:38 CST 2014
# Draft version 1.0

curdir=$(cd `dirname $0`;pwd)
pidfile=$curdir/sshtunnl.pid
logfile=$curdir/sshtunnl.log

start () {

# Check pid 
#if [ -f $pidfile ] && ps aux |grep ssh |grep -q `cat $pidfile`
if [ -f $pidfile ] && pgrep -q -F $pidfile # updated on 2015.6.17
then
    echo "SSH tunnel is running."
    exit 0
else
    # Startup running proc
    #nohup ssh -N -L 11945:54.215.124.210:11945 ronniema@54.215.124.210 -i $HOME/.ssh/ronniema.pam >$logfile 2>&1 &
    nohup ssh -N -L 31288:127.0.0.1:31288 root@$server -i $HOME/.ssh/id_rsa >$logfile 2>&1 &
    if [ $? -eq 0 ];then
        echo "$!" >$pidfile
        echo "vpn tunnel is up"
    fi
fi

}

stop () {
    
    # Check pid
    
    # Check pidfile
    [ ! -f $pidfile ] && { echo "no running"; return 1; } || pid=`cat $pidfile`
    # Check running process of ssh tunnel
    if pgrep -q -F $pidfile # updated on 2015.6.17
    then
        kill -KILL $pid && { rm $pidfile; return 0; }
    else
        echo "ssh tunnel not running..."
        return 1
    fi

}

reload () {

    # Check pidfile
    [ ! -f $pidfile ] && { echo "no running"; exit 1; } || pid=`cat $pidfile`

    # Reload configuration...
    #if ps aux |grep ssh |grep -q $pid
    if pgrep -q -F $pidfile # updated on 2015.6.17
    then
        kill -HUP $pid && return 0
    else
        echo "ssh tunnel not running..."
        exit 1
    fi

}

status () {

    # Check pidfile
    [ ! -f $pidfile ] && { echo "no running"; exit 1; } || pid=`cat $pidfile`
    
    if pgrep -q -F $pidfile # updated on 2015.6.17
    then
        echo "Tunnel is running with pid $pid"
    else
        echo "Tunnel service NOT running"
        return 1
    fi
}

help() {
        
    echo "Usage :sh `basename $0 ` [start|stop|status|reload|restart]"
    exit 1

}


# Check user input argv

[ -z $1 ] && help

server=$2

case "$1" in
    start)
        start $2
        ;;
    restart)
        stop;
        sleep 1
        start
        ;;
    stop)
        stop && echo "stopped."
        ;;
    status)
        status
        ;;
    reload)
        reload && echo "reload OK."
        ;;
    *)
        help
        ;;
esac
";i:1;s:4:"bash";i:2;N;}i:2;i:53;}i:32;a:3:{i:0;s:12:"document_end";i:1;a:0:{}i:2;i:53;}}