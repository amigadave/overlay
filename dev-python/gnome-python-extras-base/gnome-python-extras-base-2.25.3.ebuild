# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator eutils autotools gnome2

# This ebuild does nothing -- we just want to get the pkgconfig file installed
MY_PN="gnome-python-extras"
DESCRIPTION="Provides python the base files for the Gnome Python Desktop bindings"
HOMEPAGE="http://pygtk.org/"
PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP}/${MY_PN}-${PV}.tar.bz2"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
RESTRICT="test"

# From the gnome-python-extras eclass
RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.6
	>=dev-python/pygtk-2.4
	!<=dev-python/gnome-python-extras-2.19.1-r2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-allbindings"
}
