# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Epic fantasy role-playing adventure in an enormous and unique world"
HOMEPAGE="http://www.spidweb.com/avadon/"
SRC_URI="avadon-linux-1331768904-bin"

LICENSE="as-is"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libogg
	media-libs/libsdl[X]
	media-libs/libvorbis
	>=media-libs/openal-1.5"

S="${WORKDIR}/data"
ZIP_OFFSET="202888"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
	einfo
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
		newexe Avadon-amd64 ${PN} || die
	else
		newexe Avadon-x86 ${PN} || die
	fi

	newicon Avadon.png "${PN}.png" || die
	doins -r "avadon files" || die
	dodoc README-linux.txt || die

	games_make_wrapper "${PN}" "./${PN}" "${dir}" || die
	make_desktop_entry "${PN}" "Avadon: The Black Fortress" || die

	prepgamesdirs
}
