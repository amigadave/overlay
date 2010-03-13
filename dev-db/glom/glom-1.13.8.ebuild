# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2

DESCRIPTION="An easy to use database designer and user interface"
HOMEPAGE="http://www.glom.org/"
LICENSE="|| ( GPL-2 GPL-3 LGPL-2.1 )"

IUSE="-client-only doc +postgres sqlite"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=gnome-extra/libgda-4.1.2:4
	>=dev-cpp/libgdamm-3.99.18:3.99
	>=dev-cpp/goocanvasmm-0.14.0
	>=dev-cpp/gconfmm-2.6.0
	>=dev-cpp/gtkmm-2.19.2
	>=dev-cpp/libxmlpp-2.24.0
	!client-only? ( app-text/iso-codes dev-cpp/gtksourceviewmm )
	dev-libs/boost[python]
	>=dev-libs/libxslt-1.1.10
	>=dev-python/pygobject-2.6.0
	>=dev-python/libgda-python-2.25.3
	net-dns/avahi[gtk]
	>=net-libs/libepc-0.3.1
	postgres? ( gnome-extra/libgda:4[postgres] virtual/postgresql-server )
	!sqlite? ( gnome-extra/libgda:4[postgres] virtual/postgresql-server )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	dev-libs/glib
	postgres? ( virtual/postgresql-base )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable client-only)"

	if ! use postgres && ! use sqlite ; then
		G2CONF="${G2CONF}
			--enable-postgresql
			--disable-sqlite"
	else
		G2CONF="${G2CONF}
			$(use_enable postgres postgresql)
			$(use_enable sqlite)"
	fi
}
