xcodebuild -project GSPrefs.xcodeproj -scheme GSPrefs -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR=. clean build
find . -name '.DS_Store' -type f -delete
rm -rf Layout/Library/Frameworks/GSPrefs.framework/
mv GSPrefs.framework/ Layout/Library/Frameworks/
rm -rf GSPrefs.framework.dSYM
dpkg-deb -Z gzip -b Layout/ GSPrefs.deb
