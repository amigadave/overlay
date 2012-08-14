# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Voxel-based adventure, in a game world of tiny destructable cubes"
HOMEPAGE="http://www.lexaloffle.com/voxatron.php"
SRC_URI="${PN}_${PV}_i386.tar.gz"

LICENSE="Voxatron-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? ( >=media-libs/libsdl-1.2 )"

S="${WORKDIR}/${PN}"

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

	doexe vox
	doins vox.dat
	dodoc voxatron.txt

	newicon lexaloffle-vox.png ${PN}.png

	games_make_wrapper "${PN}" "./vox" "${dir}"
	make_desktop_entry "${PN}" "Voxatron"

	prepgamesdirs
}
