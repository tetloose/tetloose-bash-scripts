#!/bin/bash

#SEARCH REPLACE
clear
echo "Starting..."
read -p "Make sure this script is in the parent folder of the itmes you wanna search replace, press [ENTER] to continue or, [ctrl+c] to cancel: "
read -p "File extension: [html, txt, md] " extension
read -rp "Search pattern: [can be a regex, remember to escape characters i.e <\/style>] " pattern
read -rp "Replace with: " replaceWith
read -p "You are about to search all '.$extension' files for '$pattern' and replace with '$replaceWith' type: [Y/N] " gate

if [ "$gate" = "Y" ]; then
  function recursive_for_loop {
    for f in *; do
      if [ -d $f -a ! -h $f ];
      then
        cd -- "$f";
        find ./ -type f -name "*.$extension" | xargs sed -i '' -e 's/'"$pattern"'/'"$replaceWith"'/gi'
        echo "$f done!";
        cd ..;
      fi;
    done;
  };
  recursive_for_loop
else
  echo "Canceling!"
fi;
