#!/bin/bash

#Packager
ROOT=${PWD}
FILES="$ROOT"/Files
DIST="$ROOT"/Dist
ZIP_README="$ROOT"/ReadMe/Zip/.
FOLDER_README="$ROOT"/ReadMe/Folder/.
COMPARE_README="$ROOT"/ReadMe/Compare/.
DEPARTMENT="";
LANG_CODES=(
  "PLPL"
  "CZCS"
  "HRHR"
  "ESES"
  "CHIT"
  "EEET"
  "BGBG"
  "SISL"
  "ATDE"
  "FRFR"
  "HUHU"
  "WWFR"
  "FIFI"
  "ITIT"
  "WWEN"
  "NLNL"
  "DEDE"
  "ESCA"
  "GREL"
  "SESV"
  "BENL"
  "SKSK"
  "PTPT"
  "NONO"
  "IEEN"
  "GBEN"
  "CHFR"
  "CHDE"
  "ZAEN"
  "BEFR"
  "LVLV"
  "LTLT"
  "RORO"
  "DKDA"
)
LANG=""

clear
echo "Starting..."
echo Run Packager: [0];
echo Run Uploader: [1];
read -p "Which service would you like to run enter [0/1]: " SERVICE


# =====================================
# PACKAGER
# =====================================

if [ "$SERVICE" = "0" ]; then #
  clear
  echo "========================="
  echo "Starting Packager..."
  echo "========================="
  read -p "Make sure you have added the files into the correct places refer to README.md: [ENTER] to continue [CTL+C] to quit "
  read -p "Quarterly period [1-4] " QUARTERLY_PERIOD
  cd "$FILES"

  packager() {
    for f in *; do
      if [ -d $f -a ! -h $f ]; then
        cd -- "$f";
        dirLoop
        cd ..;
      else
        cd ..;
      fi;
    done;
  };

  dirLoop() {
    for f in *; do
      if [ -d $f -a ! -h $f ]; then
        cd -- "$f";
        INDEX_FILE=`ls -1 *.html 2>/dev/null | wc -l`;

        if [ $INDEX_FILE != 0 ]; then
          build
        else
          dirLoop;
        fi

        cd ..;
      else
        cd ..;
      fi;
    done;
  }

  build() {
    GET_URL_PARTS=${PWD};

    for (( i=0; i < ${#LANG_CODES[@]}; i++ ))
    do
      if [[ "$GET_URL_PARTS" == *${LANG_CODES[$i]}* ]]; then
        LANG=${LANG_CODES[$i]}
      fi
    done

    if [[ "$GET_URL_PARTS" == *compare* ]]; then
      DEPARTMENT="Web_HTML_Compare_Module";
    else
      DEPARTMENT="Web_Marketing_Page_HTML";
    fi

    clear
    echo "========================="
    echo ${PWD} | sed 's/^.*Files//';
    echo "========================="

    read -p "Enter product type e.g. [iPad_Air_5G] use above url for reference: " PRODUCT_TYPE;

    FILE_NAME="$LANG"_"$PRODUCT_TYPE"_Q"$QUARTERLY_PERIOD"$(date +"%y")_"$DEPARTMENT"

    if [ $DEPARTMENT = "Web_Marketing_Page_HTML" ]; then
      cp -r "$ZIP_README" .
    else
      cp -r "$COMPARE_README" .
    fi;

    eval zip -r "$FILE_NAME".zip .;
    mkdir "$FILE_NAME"
    mv "$FILE_NAME".zip "$FILE_NAME"
    cd "$FILE_NAME"

    if [ $DEPARTMENT = "Web_Marketing_Page_HTML" ]; then
      mkdir _Shared_Assets
    fi;

    cp -r "$FOLDER_README" .
    cd ..
    mv $FILE_NAME "$DIST"
  }

  packager
fi;


# =====================================
# UPLOADER
# =====================================

if [ "$SERVICE" = "1" ]; then
  clear
  echo "=========================";
  echo "Starting Uploader...";
  echo "=========================";
  echo "1. Mount the directory";
  echo "2. Right Click mounted directory select copy";
  read -p "3. Paste here should look like [/Volumes/5_Silver_Bronze_Exports]: " SERVER_DIRECTORY
  read -p "Enter new directory name: " NEW_DIRECTORY
  eval rsync "$DIST" $SERVER_DIRECTORY --stats --progress -zvrt --update --dry-run
  read -p "Was the test successful? [Y/N] " RUN_CODE

  if [ $RUN_CODE = "Y" ]; then
    eval rsync "$DIST" $SERVER_DIRECTORY --stats --progress -zvrt --update
    mv "$SERVER_DIRECTORY"/dist "$SERVER_DIRECTORY"/"$NEW_DIRECTORY"
  else
    clear
    echo "========================="
    echo "Possible errors..."
    echo "1: Server drive not mounted"
    echo "2: Wrong server drive url"
    echo "3: No files in $DIST"
    echo "4: Just cancled."
    echo "========================="
  fi;
fi;
