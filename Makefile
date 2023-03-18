ARCHS = arm64 arm64e
TARGET = iphone:15.2:14.5
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = Preferences
PACKAGE_VERSION = 1.0.1
COMET_INSTALL_PATH = /Library/Frameworks

include $(THEOS)/makefiles/common.mk

clean:
	xcodebuild clean

framework: stage
		@$(PRINT_FORMAT_MAKING) "Building Comet v$(PACKAGE_VERSION)"
		xcodebuild clean build -project Comet.xcodeproj \
				-scheme Comet \
				-configuration Release \
				-sdk iphoneos \
				CONFIGURATION_BUILD_DIR=$(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)/ \
				ARCHS="$(ARCHS)" \
				CODE_SIGN_IDENTITY="" \
				CODE_SIGNING_REQUIRED=NO
		@$(PRINT_FORMAT_MAKING) "Signing"
				ldid -Sentitlements.xml $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)/Comet.framework/Comet

before-package:: framework
