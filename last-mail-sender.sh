#! /bin/sh
# |perl -ne 'print "$2 " if /^(?:From:|\tfor <dex\@localhost>;) (.*?)(?: \+0200 \(CEST\))?$/'

cat $HOME/Maildir/cur/`grep 'Notified comsat:' ~/.procmail/log|cut -d '/' -f 6|sed 's/"/*/'`\
    |perl -ne 'print "$1  " if /^(?:From:|\tfor <dex\@localhost>;) (.*?)(?: \+0200 \(CEST\))?$/'

