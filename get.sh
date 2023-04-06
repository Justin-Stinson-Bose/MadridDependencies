#!/bin/sh

# exit when any command fails
set -e

sourceUrl=https://github.com/urbanairship/ios-library/releases/download/16.11.3/Airship.zip
frameworks="AirshipAutomation.xcframework
AirshipBasement.xcframework
AirshipCore.xcframework
AirshipMessageCenter.xcframework
AirshipNotificationServiceExtension.xcframework
"

rm -rf Airship*

echo "Downloading $sourceUrl"
curl $sourceUrl -O -L

echo "\nUnzipping Airship.zip"
unzip Airship.zip -d Airship >/dev/null

pushd Airship
for framework in $frameworks
do
    echo "\nProcessing $framework.zip..."
    zip -r "$framework.zip" "$framework" >/dev/null

    echo "Computing checksum $framework..."
    swift package compute-checksum $framework.zip

    mv "$framework.zip" ../
done
popd

rm -r Airship
rm Airship.zip
