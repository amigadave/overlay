# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_PN="CaveStory+"
HIBPAGE="http://www.humblebundle.com"
DESCRIPTION="A platform-adventure game by Studio Pixel"
HOMEPAGE="http://www.nicalis.com/"
SRC_URI="${PN//\+/plus}-linux-${PV}.tar.gz"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="media-libs/libsdl
	 virtual/glu
	 virtual/opengl"

S="${WORKDIR}/${MY_PN}"

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

	newexe "${MY_PN}$(usex "amd64" "_64" "")" "${PN}"

	# TODO: Convert BMP to PNG.
	newicon "data/icon.bmp" "${PN}.bmp"
	doins -r data

	games_make_wrapper "${PN}" "./${PN}" "${dir}"
	make_desktop_entry "${PN}" "${MY_PN}"

	prepgamesdirs
}
