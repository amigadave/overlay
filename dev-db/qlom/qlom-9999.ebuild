# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

DESCRIPTION="A Qt application to view Glom databases"
HOMEPAGE="http://gitorious.org/qlom"
EGIT_REPO_URI="git://gitorious.org/qlom/qlom.git"
EGIT_BOOTSTRAP="autoreconf --force --install"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres sqlite"

RDEPEND="dev-db/glom
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	postgres? ( dev-db/glom[postgres] x11-libs/qt-sql[postgres] )
	sqlite? ( dev-db/glom[sqlite] x11-libs/qt-sql[sqlite] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ${DOCS}
}
