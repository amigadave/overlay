# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Sokoban-like block-pushing puzzle game"
HOMEPAGE="http://www.lexaloffle.com/choc.php"
SRC_URI="${PN}_${PV}-1_i386.tar.gz"

LICENSE="Chocolate-castle-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? ( >=media-libs/libsdl-1.2 )"

S="${WORKDIR}/choc"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "and then move it to:"
	einfo "  ${DISTDIR}"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doexe choc
	doins choc.dat comp.xm lang_de.txt lang_en.txt lang_es.txt lang_fr.txt \
		title.xm
	dodoc choc.txt

	games_make_wrapper "${PN}" "./choc" "${dir}"
	make_desktop_entry "${PN}" "Chocolate Castle"

	prepgamesdirs
}
