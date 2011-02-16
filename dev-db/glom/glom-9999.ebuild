# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="*"

inherit gnome2-live virtualx

DESCRIPTION="An easy to use database designer and user interface"
HOMEPAGE="http://www.glom.org/"

LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-client-only doc sqlite"

RDEPEND=">=gnome-extra/libgda-4.1.2:4[postgres]
	>=dev-cpp/libgdamm-3.99.21:3.99
	>=dev-cpp/goocanvasmm-2.91.5:2.0
	>=dev-cpp/gtkmm-2.99.1:3.0
	>=dev-cpp/libxmlpp-2.24.0
	!client-only? ( app-text/iso-codes dev-cpp/gtksourceviewmm:3.0 )
	dev-libs/boost[python]
	>=dev-libs/libxslt-1.1.10
	>=dev-python/pygobject-2.6.0
	>=dev-python/libgda-python-2.25.3
	>=net-libs/libepc-0.3.1
	dev-db/postgresql-server"
DEPEND="${RDEPEND}
	>=dev-cpp/mm-common-0.8
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	doc? ( app-doc/doxygen dev-python/sphinx )
	dev-libs/glib"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	cd "${S}"
	NOCONFIGURE=1 ./autogen.sh
	gnome2_omf_fix
	elibtoolize
}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--enable-postgresql
		$(use_enable client-only)
		$(use_enable doc documentation)
		$(use_enable sqlite)"
}

src_test() {
	Xemake check || die "tests failed"
}
