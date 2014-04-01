#!/bin/sh

# Desc:shell script for sending mail with mutt through SMTP
# Author:by Jason.z
# Mail:ccnuzxg@gmail.com
# Date:2014-04-01

from="sender@example.com"
# more receiver like a@example.com b@example.com ...
to=("reciever@example.com")
subject="Your email title"
#you can also read content from the file just use $(cat yourfile)
body="This is body content of your email"

declare -a attachments
attachments=( "a.pdf" "b.zip" )

# smtp info
smtpserver="smtp.example.com"
smtpport="25"
user="test"
password="123456"

declare -a attargs
for att in "${attachments[@]}"; do
	[ ! -f "$att" ] && echo "Warning: attachment $att not found, skipping" >&2 && continue
	attargs+=( "-a" "$att" )
done

# send using smtp
$ mutt -e "set from=$from" \
       -e "set smtp_url=\"smtp://${user}@${smtpserver}:${smtpport}\"" \
       -e "set smtp_pass=\"$password\"" -s "$subject" "$attargs" -- "${to[@]}" <<< "$body"
 
# also 'set ssl_starttls=yes|no' to do/not do TLS