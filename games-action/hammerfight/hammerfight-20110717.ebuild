# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Physics-based combat with flying machines"
HOMEPAGE="http://www.koshutin.com/"
SRC_URI="hf-linux-07172011-bin"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="x86? (
		>=media-libs/libsdl-1.2
		media-libs/openal
		virtual/opengl
	)
	amd64? (
		app-emulation/emul-linux-x86-medialibs
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

	doexe Hammerfight
	newicon hammerfight.png "${PN}.png"
	doins Config.ini media.script strings.txt
	doins -r Data Demo Media Objects Saves
	dodoc README-linux.txt readme.txt

	games_make_wrapper "${PN}" "./Hammerfight" "${dir}"
	make_desktop_entry "${PN}" "Hammerfight"

	prepgamesdirs
}
