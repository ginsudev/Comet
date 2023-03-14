ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.5

include @@THEOS@@/makefiles/common.mk

BUNDLE_NAME = @@PROJECTNAME@@

@@PROJECTNAME@@_EXTRA_FRAMEWORKS = GSPrefs
@@PROJECTNAME@@_FRAMEWORKS = SwiftUI
@@PROJECTNAME@@_FILES = $(shell find Sources/@@PROJECTNAME@@ -name '*.swift') $(shell find Sources/@@PROJECTNAME@@C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
@@PROJECTNAME@@_SWIFTFLAGS = -ISources/@@PROJECTNAME@@C/include
@@PROJECTNAME@@_INSTALL_PATH = /Library/PreferenceBundles
@@PROJECTNAME@@_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
