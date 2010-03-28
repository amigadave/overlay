# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Argyll is an open source, ICC compatible color management system."
HOMEPAGE="http://www.argyllcms.com"
MY_P="Argyll_V${PV}"
SRC_URI="http://www.argyllcms.com/${MY_P}_src.zip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

RDEPEND=">=media-libs/tiff-3.7.3
	>=media-libs/jpeg-6b-r5
	>=sys-libs/zlib-1.2.3"
DEPEND="${RDEPEND}
	|| ( >=dev-util/jam-2.4 >=dev-util/ftjam-2.4 )"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake install

	# Install binaries to /usr/bin
	exeinto /usr/bin
	exeopts -m0755
	doexe bin/*

	# Delete license file from BINDIR
	rm "${D}/usr/bin/License.txt"

	# Install HTML documentation
	dohtml doc/*

	# Install text documentation
	newdoc log.txt     CHANGELOG
	newdoc Readme.txt  README
	newdoc License.txt LICENSE
	newdoc ttbd.txt    TODO
	newdoc notes.txt   NOTES

	# Install reference files
	insinto /usr/share/${PF}/ref
	insopts -m0644
	doins   ref/*
}

pkg_postinst() {
	ewarn
	ewarn "\tExecutables have been renamed!"
	ewarn "\tRead /usr/share/doc/${P}/CHANGELOG.bz2!."
	ewarn
	einfo
	einfo "If you have a Spyder2 you need to extract the firmware"
	einfo "from the spyder2_setup.exe (ColorVision CD)"
	einfo "and store it as /usr/bin/spyd2PLD.bin."
	einfo
	einfo "For further info on setting up instrument access read"
	einfo "http://www.argyllcms.com/doc/Installing_Linux.html"
	einfo
}
