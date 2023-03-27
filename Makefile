ROOTLESS ?= 0
ARCHS = arm64 arm64e
TARGET = iphone:15.2:14.5
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = Preferences
PACKAGE_VERSION = 1.0.1

ifeq ($(ROOTLESS),1)
		THEOS_LAYOUT_DIR_NAME = layout-rootless
		THEOS_PACKAGE_SCHEME = rootless
		COMET_INSTALL_PATH = /var/jb/Library/Frameworks
else
		THEOS_LAYOUT_DIR_NAME = layout
		COMET_INSTALL_PATH = /Library/Frameworks
endif

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/xcodeproj.mk

setup: stage
		@$(PRINT_FORMAT_MAKING) "Setting up build dir"
		mkdir -p $(THEOS_STAGING_DIR)/DEBIAN/

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
				DYLIB_INSTALL_NAME_BASE=$(COMET_INSTALL_PATH)
				
sign: stage
		@$(PRINT_FORMAT_MAKING) "Signing"
		ldid -Sentitlements.xml $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)/Comet.framework/Comet

before-package:: setup framework sign
