# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base virtualx

DESCRIPTION="Output visualizer for valgrind's Massif tool"
HOMEPAGE="http://gitorious.org/massifg"
SRC_URI="http://www.jonnor.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="x11-libs/goffice:0.8
	>=x11-libs/gtk+-2.20:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.14 )"

DOCS=( "README" )

src_configure() {
	econf $(use_enable doc gtk-doc)
}

src_test() {
	emake check || die "tests failed"
	Xemake app-test || die "applications tests failed"
}
