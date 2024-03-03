ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.5

include @@THEOS@@/makefiles/common.mk

BUNDLE_NAME = @@PROJECTNAME@@

@@PROJECTNAME@@_FRAMEWORKS = SwiftUI
@@PROJECTNAME@@_FILES = $(shell find Sources/@@PROJECTNAME@@ -name '*.swift') $(shell find Sources/@@PROJECTNAME@@C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
@@PROJECTNAME@@_SWIFTFLAGS = -ISources/@@PROJECTNAME@@C/include
ifeq ($(ROOTLESS),1)
	THEOS_PACKAGE_SCHEME = rootless
  @@PROJECTNAME@@_INSTALL_PATH = /var/jb/Library/PreferenceBundles
else
  @@PROJECTNAME@@_INSTALL_PATH = /Library/PreferenceBundles
endif

@@PROJECTNAME@@_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
