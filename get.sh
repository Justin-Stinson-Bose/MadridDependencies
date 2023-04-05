#!/bin/sh

# exit when any command fails
set -e

sourceUrl=https://github.com/urbanairship/ios-library/releases/download/16.11.3/Airship.zip
frameworks="AirshipAutomation.xcframework
AirshipBasement.xcframework
AirshipCore.xcframework
AirshipMessageCenter.xcframework
"

echo "Downloading $sourceUrl"
curl $sourceUrl -O -L

echo "\nUnzipping Airship.zip"
rm -r Airship
unzip Airship.zip -d Airship >/dev/null

for framework in $frameworks
do
    echo "\nProcessing $framework..."
    zip -r "$framework.zip" "Airship/$framework" >/dev/null

    echo "Computing checksum $framework..."
    swift package compute-checksum $framework.zip
done

rm -r Airship
