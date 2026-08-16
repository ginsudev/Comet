# For arm64e backward compatible support.
export THEOS_PLATFORM_SDK_ROOT = /Applications/Xcode-15.4.0.app/Contents/Developer
export PREFIX = $(THEOS_PLATFORM_SDK_ROOT)/Toolchains/XcodeDefault.xctoolchain/usr/bin/

ROOTLESS ?= 0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = Preferences
TARGET = iphone:clang:16.5:14.5
PACKAGE_VERSION = 2.0.1

# Rootless / Rootful settings
ifeq ($(ROOTLESS),1)
	THEOS_PACKAGE_SCHEME = rootless
endif

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = Comet
Comet_FRAMEWORKS = MobileCoreServices
Comet_FILES = $(shell find Sources/Comet -name '*.swift') $(shell find Sources/CometC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
Comet_SWIFTFLAGS = -ISources/CometC/include
Comet_SWIFTFLAGS += -enable-library-evolution
Comet_CFLAGS = -fobjc-arc -ISources/CometC/include
Comet_INSTALL_PATH = /Library/Frameworks

include $(THEOS_MAKE_PATH)/framework.mk

# Assemble the multi-arch .swiftmodule directory bundle into the framework
# before it's rsynced to $(THEOS)/lib (for dev consumption) and staged into
# the .deb. Theos emits one arch-specific flat module per arch; consumers
# resolve `import Comet` by looking inside Modules/Comet.swiftmodule/ for
# the target-triple-named file matching their build arch.
before-Comet-stage::
	@mkdir -p $(THEOS_OBJ_DIR)/Comet.framework/Modules/Comet.swiftmodule
	@cp $(THEOS_OBJ_DIR)/arm64/Comet.swiftmodule  $(THEOS_OBJ_DIR)/Comet.framework/Modules/Comet.swiftmodule/arm64-apple-ios.swiftmodule
	@cp $(THEOS_OBJ_DIR)/arm64e/Comet.swiftmodule $(THEOS_OBJ_DIR)/Comet.framework/Modules/Comet.swiftmodule/arm64e-apple-ios.swiftmodule
