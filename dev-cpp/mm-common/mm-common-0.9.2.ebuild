# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base gnome.org

DESCRIPTION="Common files for development of Gnome C++ (*mm) bindings"
HOMEPAGE="http://www.gtkmm.org/"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-util/pkgconfig"
DEPEND=""

DOCS=( "ChangeLog" "NEWS" "README" )

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	base_src_install
}
