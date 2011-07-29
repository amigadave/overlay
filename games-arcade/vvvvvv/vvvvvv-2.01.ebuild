# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="A 2D platform puzzle game in the style of Jet Set Willy"
HOMEPAGE="http://thelettervsixtim.es/"
SRC_URI="VVVVVV_${PV}_Linux.tar.gz"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="media-libs/libogg
	>=media-libs/libsdl-1.2
	>=media-libs/libvorbis-1.3.2
	media-libs/sdl-image
	media-libs/sdl-mixer"

S="${WORKDIR}/VVVVVV"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doexe VVVVVV VVVVVV_32 VVVVVV_64
	doins -r data

	games_make_wrapper "${PN}" "./VVVVVV" "${dir}"
	make_desktop_entry "${PN}" "VVVVVV"

	prepgamesdirs
}
