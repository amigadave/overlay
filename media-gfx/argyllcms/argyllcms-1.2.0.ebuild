# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Argyll is an open source, ICC compatible color management system."
HOMEPAGE="http://www.argyllcms.com"
MY_P="Argyll_V${PV}"
SRC_URI="http://www.argyllcms.com/${MY_P}_src.zip"
LICENSE="AGPL-3 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/tiff-3.7.3
	>=media-libs/jpeg-6b-r5
	>=sys-libs/zlib-1.2.3"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-util/ftjam-2.4
	x11-libs/libXinerama
	x11-libs/libXScrnSaver"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake install || die

	rm bin/License.txt || die
	dobin bin/* || die
	dohtml doc/* || die

	newdoc log.txt ChangeLog ||die
	newdoc Readme.txt README || die
	newdoc ttbd.txt TODO || die
	newdoc notes.txt NOTES || die

	insinto /usr/share/${PN}/ref
	doins ref/* || die
}

pkg_postinst() {
	einfo "If you have a Spyder2 you need to extract the firmware"
	einfo "from the spyder2_setup.exe (ColorVision CD)"
	einfo "and store it as /usr/bin/spyd2PLD.bin."
	einfo
	einfo "For further info on setting up instrument access read"
	einfo "http://www.argyllcms.com/doc/Installing_Linux.html"
}
