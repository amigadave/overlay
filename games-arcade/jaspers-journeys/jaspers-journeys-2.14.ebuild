# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Save Jasper's cat from the evil witch in this retro platform game"
HOMEPAGE="http://www.lexaloffle.com/jasper.php"
SRC_URI="${PN}_${PV}-1_i386.tar.gz"

LICENSE="Jaspers-journeys-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? ( >=media-libs/libsdl-1.2 )"

S="${WORKDIR}/jasper"

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

	doexe jasper
	doins jasper.dat
	doins -r xm
	dodoc jasper.txt

	games_make_wrapper "${PN}" "./jasper" "${dir}"
	make_desktop_entry "${PN}" "Jasper's Journeys"

	prepgamesdirs
}
