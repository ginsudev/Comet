ROOTLESS ?= 0

# Build config
ARCHS = arm64 arm64e
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = Preferences
PACKAGE_VERSION = 1.0.5

# Rootless / Rootful settings
ifeq ($(ROOTLESS),1)
	Comet_XCODEFLAGS = SWIFT_ACTIVE_COMPILATION_CONDITIONS="ROOTLESS"
	THEOS_PACKAGE_SCHEME = rootless
	COMET_INSTALL_PATH = /var/jb/Library/Frameworks
	MOVE_TO_THEOS_PATH = $(THEOS)/lib/iphone/rootless/
	# Control
	PKG_NAME_SUFFIX = (Rootless)
else
	Comet_XCODEFLAGS = SWIFT_ACTIVE_COMPILATION_CONDITIONS=""
	COMET_INSTALL_PATH = /Library/Frameworks
	MOVE_TO_THEOS_PATH = $(THEOS)/lib/
endif

include $(THEOS)/makefiles/common.mk

XCODEPROJ_NAME = Comet
Comet_XCODEFLAGS += LD_DYLIB_INSTALL_NAME=$(COMET_INSTALL_PATH)/Comet.framework/Comet
Comet_XCODEFLAGS += DYLIB_INSTALL_NAME_BASE=$(COMET_INSTALL_PATH)/Comet.framework/Comet
Comet_XCODEFLAGS += DWARF_DSYM_FOLDER_PATH=$(THEOS_OBJ_DIR)/dSYMs
Comet_XCODEFLAGS += CONFIGURATION_BUILD_DIR=$(THEOS_OBJ_DIR)/

include $(THEOS)/makefiles/xcodeproj.mk

override THEOS_PACKAGE_NAME := com.ginsu.comet-$(PKG_ARCHITECTURE)

before-package::
	# Append values to control file
	$(ECHO_NOTHING)sed -i '' \
		-e 's/\$${PKG_NAME_SUFFIX}/$(PKG_NAME_SUFFIX)/g' \
		$(THEOS_STAGING_DIR)/DEBIAN/control$(ECHO_END)
	
ifeq ($(ROOTLESS),1)
	# Move to staging dir
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)$(ECHO_END)
	$(ECHO_NOTHING)mv $(THEOS_OBJ_DIR)/Comet.framework/ $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)$(ECHO_END)
endif

	# Copy to theos/lib
	$(ECHO_NOTHING)rm -rf $(MOVE_TO_THEOS_PATH)Comet.framework/$(ECHO_END)
	$(ECHO_NOTHING)cp -r $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)/Comet.framework $(MOVE_TO_THEOS_PATH)$(ECHO_END)

before-all::
	$(ECHO_NOTHING)rm -rf $(THEOS_STAGING_DIR)$(COMET_INSTALL_PATH)$(ECHO_END)
	$(ECHO_NOTHING)rm -rf $(THEOS_OBJ_DIR)$(ECHO_END)
