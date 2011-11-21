# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Tactical turn-based strategy combat in a future dystopia"
HOMEPAGE="http://www.frozensynapse.com/"
SRC_URI="frozensynapse-${PV}-linux-bin"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? (
		>=media-libs/libsdl-1.2
		media-libs/openal
		virtual/opengl
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

	doexe FrozenSynapse

	newicon frozensynapse.png "${PN}.png"
	doins cacert.pem fontchars.txt fontlist.txt main.cs
	doins -r common psychoff TGB tools
	dodoc README-linux.txt readme.txt steam_appid.txt

	games_make_wrapper "${PN}" "./FrozenSynapse" "${dir}"
	make_desktop_entry "${PN}" "Frozen Synapse"

	prepgamesdirs
}
