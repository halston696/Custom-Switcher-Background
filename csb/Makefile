include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CSB
CSB_FILES = csbRootListController.m
CSB_INSTALL_PATH = /Library/PreferenceBundles
CSB_FRAMEWORKS = UIKit CoreGraphics Social
CSB_PRIVATE_FRAMEWORKS = Preferences
CSB_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CSB.plist$(ECHO_END)
