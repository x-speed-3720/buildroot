################################################################################
#
# hddtemp
#
################################################################################

HDDTEMP_VERSION = 0.3-beta15
HDDTEMP_SOURCE = hddtemp-$(HDDTEMP_VERSION).tar.bz2
HDDTEMP_SITE = http://download.savannah.gnu.org/releases/hddtemp
HDDTEMP_LICENSE = GPLv2
HDDTEMP_LICENSE_FILES = GPL-2

define HDDTEMP_REMOVE_MAN
	rm -rf $(TARGET_DIR)/usr/man
endef

HDDTEMP_POST_INSTALL_TARGET_HOOKS += HDDTEMP_REMOVE_MAN

$(eval $(autotools-package))
