xcodebuild -project Comet.xcodeproj -scheme Comet -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR=. clean build
find . -name '.DS_Store' -type f -delete
rm -rf Layout/Library/Frameworks/Comet.framework/
mv Comet.framework/ Layout/Library/Frameworks/
rm -rf Comet.framework.dSYM
dpkg-deb -Z gzip -b Layout/ Comet.deb
