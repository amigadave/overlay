# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base git

DESCRIPTION="Common files for development of Gnome C++ (*mm) bindings"
HOMEPAGE="http://www.gtkmm.org/"
EGIT_REPO_URI="git://git.gnome.org/mm-common"
EGIT_BOOTSTRAP="autogen.sh"
SRC_URI=""

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-util/pkgconfig"
DEPEND="|| ( net-misc/curl net-misc/wget )"

DOCS=( "ChangeLog" "NEWS" "README" )

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	base_src_install
}
