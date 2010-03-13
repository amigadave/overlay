# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gda"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for interacting with libgda"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# libgda-python from gnome-python-extras-2.19.1 is for libgda-3.
RDEPEND="gnome-extra/libgda:4
	>=dev-python/libbonobo-python-2.22.1
	!<=dev-python/libgda-python-2.25.0"
DEPEND="${RDEPEND}"

src_unpack() {
	gnome-python-common_src_unpack
}
