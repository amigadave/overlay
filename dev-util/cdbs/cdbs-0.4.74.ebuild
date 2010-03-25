# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base

DESCRIPTION="The Common Debian Build System"
HOMEPAGE="http://git.debian.org/?p=collab-maint/cdbs.git;a=summary"
SRC_URI="mirror://debian/pool/main/c/cdbs/cdbs_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/dblatex
	dev-libs/libxml2
	dev-libs/libxslt
	media-gfx/graphviz
	www-client/elinks"
RDEPEND=""

DOCS=( "doc/cdbs-doc.pdf" "debian/changelog" )
HTML_DOCS=( "doc/cdbs-doc.html" "doc/buildcore.png" "doc/depgraph.png"
	"doc/cdbs-doc.css" )
PATCHES=( "${FILESDIR}/${PN}-0.4.74-docbook2latex.patch" )

src_prepare() {
	base_src_prepare
}

src_install() {
	base_src_install
}
