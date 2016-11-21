#!/bin/bash
INPFILE=sayhello.txt
DATAFILE=sayhello.data
DELAY=2
printf "starting at: " ; date
printf "running on: "; $(hostname -f)
printf "whoami: "; whoami
printf "home: "; echo $HOME
printf "listing home:\n"
ls -l $HOME
printf "working directory: "; pwd
printf "listing working directory:\n"
ls -l $PWD
if [ "${@}" = "" ]; then
  SAYS="nothing"
else
  SAYS="$@"
fi
echo "User "$(whoami)" says: $SAYS" | tee -i $DATAFILE 
if [ -f "$INPFILE" ]; then
  echo "Receiving sayhello.txt file"
  cat $INPFILE 
else
  echo "Did not find $INPFILE"
fi
printf "waiting for a while ($DELAY minutes) ... "
sleep $((60*DELAY)) # Wait few minutes
echo "done"
printf "ending at: "; date
