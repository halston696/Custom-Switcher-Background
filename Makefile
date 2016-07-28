DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomSwitcherBackground
CustomSwitcherBackground_FILES = Tweak.xm
CustomSwitcherBackground_FRAMEWORKS = UIKit Foundation
CustomSwitcherBackground_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += csb
include $(THEOS_MAKE_PATH)/aggregate.mk
