# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome2 virtualx

DESCRIPTION="An easy to use database designer and user interface"
HOMEPAGE="http://www.glom.org/"
LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"

IUSE="-client-only doc sqlite"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=gnome-extra/libgda-4.1.2:4
	>=dev-cpp/libgdamm-3.99.18:3.99
	>=dev-cpp/goocanvasmm-0.14.0
	>=dev-cpp/gconfmm-2.6.0
	>=dev-cpp/gtkmm-2.19.7
	>=dev-cpp/libxmlpp-2.24.0
	!client-only? ( app-text/iso-codes dev-cpp/gtksourceviewmm )
	dev-libs/boost[python]
	>=dev-libs/libxslt-1.1.10
	>=dev-python/pygobject-2.6.0
	>=dev-python/libgda-python-2.25.3
	>=net-libs/libepc-0.3.1
	dev-db/postgresql-server"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	doc? ( app-doc/doxygen dev-python/sphinx )
	dev-libs/glib"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.14.3-fix-test-load-python-module-linking.patch"
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

# Tests require an X server.
src_test() {
	Xemake check || die "tests failed"
}
