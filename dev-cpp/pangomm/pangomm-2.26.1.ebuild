# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ interface for pango"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND=">=x11-libs/pango-1.23.0
	>=dev-cpp/glibmm-2.14.1
	>=dev-cpp/cairomm-1.2.2
	dev-libs/libsigc++:2
	!<dev-cpp/gtkmm-2.13:2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (
		media-gfx/graphviz
		dev-libs/libxslt
		app-doc/doxygen )"

DOCS="AUTHORS ChangeLog NEWS README*"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-maintainer-mode
		$(use_enable doc documentation)"
}
