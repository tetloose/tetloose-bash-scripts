#!/bin/bash

#zip-and-send
clear
echo "Starting..."
read -p "Make sure this script is in the parent folder of the items you wanna zip and upload, press [ENTER] to continue or, [ctrl+c] to cancel: "
read -rp "Make sure server directory is mounted then, right click mounted directory and select copy then paste here should look like [/Volumes/5_Silver_Bronze_Exports]: " SERVER_DIRECTORY
read -rp "Create a new directory in '$SERVER_DIRECTORY' i.e. [uploads | backups | any_thing_you_want]: " NEW_DIRECTORY
read -p "You are about to zip all folders then upload them to '$SERVER_DIRECTORY' into the directory '$NEW_DIRECTORY' type: [Y/N] " GATE

if [ "$GATE" = "Y" ]; then
  eval "mkdir ../$NEW_DIRECTORY"
  function recursive_for_loop {
    for f in *; do
      if [ -d $f -a ! -h $f ];
      then
        cd -- "$f";
        eval "zip -r $f.zip .";
        eval mv "$f".zip ../../"$NEW_DIRECTORY"/"$f"-$(date +"%d-%m-%Y").zip
        echo "$f"-$(date +"%d-%m-%Y") zipped and moved;
        cd ..;
      fi;
    done;
  };
  recursive_for_loop
  read -p "All folders zipped and ready to be uploaded, a test will run. type: [Y/N] " RUN_TEST
  if [ "$RUN_TEST" = "Y" ]; then
    eval rsync "../$NEW_DIRECTORY" $SERVER_DIRECTORY --stats --progress -zvrt --update --dry-run
    read -p "Did the upload test pass or fail? press [ENTER] to continue or, [ctrl+c] to cancel: "
    eval rsync "../$NEW_DIRECTORY" $SERVER_DIRECTORY --stats --progress -zvrt --update
    read -p "Remove local "$NEW_DIRECTORY" directory. type: [Y/N] " CLEAN_UP
    if [ "$CLEAN_UP" = "Y" ]; then
      eval rm -rf "../$NEW_DIRECTORY"
      echo Done!
    else
      echo Remove "$NEW_DIRECTORY manually"
    fi;
  else
    echo Copy "$NEW_DIRECTORY" manually to "$SERVER_DIRECTORY"
  fi;
else
  echo "Canceling!"
fi;
