# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools db-use eutils flag-o-matic gnome2 java-pkg-opt-2

DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
LICENSE="GPL-2 LGPL-2"

# MDB support currently works with CVS only, so disable it in the meantime
# experimental IUSE: introspection
IUSE="berkdb bindist canvas doc firebird freetds gtk graphviz ldap mysql oci8 odbc postgres sourceview xbase"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

# FIXME: sqlite is automagic, but maybe it is a hard-dep
# FIXME: autoconf is a hell of inconsistencies
RDEPEND="
	app-text/iso-codes
	>=dev-libs/glib-2.16
	>=dev-libs/libxml2-2
	dev-libs/libxslt
	dev-libs/libunique
	sys-libs/readline
	sys-libs/ncurses
	>=net-libs/libsoup-2.24:2.4
	berkdb?   ( sys-libs/db )
	freetds?  ( >=dev-db/freetds-0.62 )
	!bindist? ( firebird? ( dev-db/firebird ) )
	gtk? (
		>=x11-libs/gtk+-2.12
		canvas? ( x11-libs/goocanvas )
		sourceview? ( x11-libs/gtksourceview:2.0 )
		graphviz? ( media-gfx/graphviz )
	)
	ldap?     ( >=net-nds/openldap-2.0.25 )
	mysql?    ( virtual/mysql )
	odbc?     ( >=dev-db/unixODBC-2.0.6 )
	postgres? ( >=virtual/postgresql-base-7.2.1 )
	xbase?    ( dev-db/xbase )
	>=dev-db/sqlite-3.6.22:3"
#   json?     ( dev-libs/json-glib )
#	mdb?      ( >app-office/mdbtools-0.5 )

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.35.5
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

# Tests are not really good
RESTRICT="test"

src_prepare() {
	# Fix from GNOME bug #607357 for Gentoo bug #308793.
	epatch "${FILESDIR}/libgda-4.1.4-install-libgda-h.patch"
	eautoreconf
}

pkg_setup() {
	if use canvas || use graphviz || use sourceview; then
		if ! use gtk; then
			ewarn "You must enable USE=gtk to make use of canvas, graphviz or sourceview USE flag."
			ewarn "Disabling for now."
			G2CONF="${G2CONF} --without-goocanvas --without-graphivz --without-gtksourceview"
		else
			G2CONF="${G2CONF}
				$(use_with canvas goocanvas)
				$(use_with graphviz)
				$(use_with sourceview gtksourceview)"
		fi
	fi

	G2CONF="${G2CONF}
		--with-unique
		--with-libsoup
		--disable-introspection
		--disable-static
		--enable-system-sqlite
		$(use_with gtk ui)
		$(use_with berkdb bdb /usr)
		$(use_with odbc odbc /usr)
		$(use_with mysql mysql /usr)
		$(use_with postgres postgres /usr)
		$(use_with freetds tds /usr)
		$(use_with xbase xbase /usr)
		$(use_with ldap ldap /usr)
		$(use_with java java $JAVA_HOME)
		--without-mdb"
#		$(use_with mdb mdb /usr)

	if use bindist; then
		# firebird license is not GPL compatible
		G2CONF="${G2CONF} --without-firebird"
	else
		G2CONF="${G2CONF} $(use_with firebird firebird /usr)"
	fi

	use berkdb && append-cppflags "-I$(db_includedir)"
	use oci8 || G2CONF="${G2CONF} --without-oracle"

	# Not in portage
	G2CONF="${G2CONF}
		--without-msql
		--without-sybase
		--without-ibmdb2
		--disable-default-binary"
}

src_test() {
	emake check HOME=$(unset HOME; echo "~") || die "tests failed"
}
