# Packager

## Make this script executable

`chmod 755 package-uploader.sh`

## Adding package files

Add Products to the folder **Files**, make sure each product has a parent name i.e:

1. iWatch
2. iPhone
3. Mac
4. iPad
5. etc...

Manually remove any folders from files, i.e. folders with **\_** at the start.

## Adding ReadMe's

### Compare

Readme that goes into the compare product zip goes -> **ReadMe/Compare**

### Folder

Readme that goes into the folder of each product -> **ReadMe/Folder**

### Zip

Readme that goes into the Zip of each non compare product -> **ReadMe/Zip**

## Running the script

From the script directory run from Command Line

1. `./PackageUploader.sh`
2. Enter `0`

Follow on screen instructions.

Once everything is done, package files are located in the **Dist** folder.

# Uploader

## Where the files go

You can upload these files to any location with the folder url, for mounted drive.

First mount the directory, once mounted **right click** the drive and select **copy**.

This will copy the path of the mounted directory i.e. `/Volumes/{name-of-mounted-hdd}`.

Other wise you can just paste a full url `/Users/{user}/Sites/Scripts/PackageUploader`

## Naming the new upload folder

Once the files uploaded, it will then rename that folder, enter a new folder name.

A test will run, if the test passes, press **Y** if fail press **N**

## Running the script

From the script directory run from Command Line

1. `./PackageUploader.sh`
2. Enter `1`

Follow on screen instructions.
