# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games unpacker

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Side-scrolling mediaeval real-time strategy"
HOMEPAGE="http://www.swordsandsoldiers.com/"
SRC_URI="SwordsAndSoldiers-HIB-2012-03-25-2.sh"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND=">=media-libs/libsdl-1.2
		media-libs/openal"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
}

src_unpack() {
	unpack_makeself

	mv subarch subarch.tar.xz
	unpack ./subarch.tar.xz

	mv instarchive_all all.tar.xz
	unpack ./all.tar.xz

	if use amd64 ; then
		mv instarchive_linux_x86_64 bin.tar.xz
	else
		mv instarchive_linux_x86 bin.tar.xz
	fi

	unpack ./bin.tar.xz
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	if use amd64 ; then
		doexe SwordsAndSoldiers.bin.x86_64 || die
		doexe Setup.bin.x86_64 || die
		games_make_wrapper "${PN}" "./SwordsAndSoldiers.bin.x86_64" "${dir}"
	else
		doexe SwordsAndSoldiers.bin.x86 || die
		doexe Setup.bin.x86 || die
		games_make_wrapper "${PN}" "./SwordsAndSoldiers.bin.x86" "${dir}"
	fi

	newicon SwordsAndSoldiers.png ${PN}.png
	doins -r Data || die
	dodoc README.linux || die

	make_desktop_entry "${PN}" "Swords and Soldiers"

	prepgamesdirs
}
