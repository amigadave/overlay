# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_PV="${PV//\./_}"
HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="A neo-colonial shoot 'em up"
HOMEPAGE="http://www.finalformgames.com/jamestown/"
SRC_URI="jtownlinux_${MY_PV}_1324610248.zip"

LICENSE="Jamestown-EULA"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND=">=media-libs/libsdl-1.2
		media-libs/openal
		>=sys-devel/gcc-4.6"

S="${WORKDIR}/data"
ZIP_OFFSET=195364

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
}

src_unpack() {
	default_src_unpack
	tail --bytes=+$(( ${ZIP_OFFSET} + 1 )) JamestownInstaller_${MY_PV}-bin \
		> "${P}.zip"
	rm -f JamestownInstaller_${MY_PV}-bin
	unpack "./${P}.zip"
	rm -f "./${P}.zip"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	if use amd64 ; then
		newexe Jamestown-amd64 ${PN}
	else
		newexe Jamestown-x86 ${PN}
	fi

	doicon jamestown.png
	doins -r Archives
	dodoc README-linux.txt

	games_make_wrapper "${PN}" "./${PN}" "${dir}"
	make_desktop_entry "${PN}" "Jamestown"

	prepgamesdirs
}
