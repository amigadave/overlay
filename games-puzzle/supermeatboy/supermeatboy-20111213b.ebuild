# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_PV="12132011b"
HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="An insanely hard and delightfully meaty platformer"
HOMEPAGE="http://www.supermeatboy.com/"
SRC_URI="${PN}-linux-${MY_PV}-bin"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND=">=media-libs/libsdl-1.2
		media-libs/openal"

S="${WORKDIR}/data"
ZIP_OFFSET=195364

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

	if use amd64 ; then
		newexe amd64/SuperMeatBoy-amd64 ${PN}
	else
		newexe x86/SuperMeatBoy-x86 ${PN}
	fi

	doicon ${PN}.png
	doins -r resources
	doins gameaudio.dat gamedata.dat locdb.txt
	dodoc README-linux.txt

	games_make_wrapper "${PN}" "./${PN}" "${dir}"
	make_desktop_entry "${PN}" "Super Meat Boy"

	prepgamesdirs
}
