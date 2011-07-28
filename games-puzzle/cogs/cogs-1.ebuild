# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="A steampunk puzzle game involving cogs, pipes and music"
HOMEPAGE="http://www.cogs-game.com/"
SRC_URI="cogs-linux-bin"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="x86? (
		>=media-libs/libsdl-1.2[opengl]
		media-libs/openal
		virtual/opengl
	)
	amd64? (
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-opengl
	)"

S="${WORKDIR}/data"
ZIP_OFFSET=192708

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
}

src_unpack() {
	tail --bytes=+$(( ${ZIP_OFFSET} + 1 )) "${DISTDIR}/${A}" > "${P}.zip"
	unpack "./${P}.zip"
	rm -f "./${P}.zip"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doexe Cogs
	newicon cogs.png "${PN}.png"
	doins -r data
	dodoc README-linux.txt

	games_make_wrapper "${PN}" "./Cogs" "${dir}"
	make_desktop_entry "${PN}" "Cogs"

	prepgamesdirs
}
