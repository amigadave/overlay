# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

MY_PN="cortex_command"
MY_V="b24-12162010"

DESCRIPTION="Action game similar to Worms"
HOMEPAGE="http://www.cortexcommand.com/"
SRC_URI="amd64? ( ${MY_PN}-amd64-installer-${MY_V}.bin )
	x86? ( ${MY_PN}-i386-installer-${MY_V}.bin )"

LICENSE="cortex-command-EULA LGPL-2 LGPL-2.1 LGPL-3 MIT BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/CortexCommand.bin"

DEPEND="app-arch/unzip"
RDEPEND=">=media-libs/allegro-4.4:0[vorbis]
	media-libs/openal
	net-misc/curl"

S="${WORKDIR}"
AMD64_ZIP_OFFSET=253992
X86_ZIP_OFFSET=197428
HIBPAGE="http://www.humblebundle.com/"

pkg_nofetch() {
	einfo "Buy and download ${SRC_URI} from ${HIBPAGE} and place it in"
	einfo "${DISTDIR}"
}

src_unpack() {
	if use amd64 ; then
		tail --bytes=+$(( ${AMD64_ZIP_OFFSET} + 1 )) "${DISTDIR}/${A}" > \
			"${P}.zip" || die "tail \"${DISTDIR}/${A}\" failed"
	else
		tail --bytes=+$(( ${X86_ZIP_OFFSET} + 1 )) "${DISTDIR}/${A}" > \
			"${P}.zip" || die "tail \"${DISTDIR}/${A}\" failed"
	fi
	unpack "./${P}.zip" || die "unpack failed"
	rm -f "./${P}.zip" || die "rm zip failed"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"
	local ccdir="data/cortex_command_linux"
	local cclibdir="${ccdir}/libs"

	exeinto "${dir}"
	doexe ${ccdir}/CortexCommand.bin || die "doexe failed"
	insinto "${dir}"
	# TODO: No ebuilds currently exist for cAudio and luabind.
	rm ${cclibdir}/{liballeg.so.4.4,libcurl.so.4,libopenal.so.1,libogg.so.0,libvorbis.so.0,libvorbisfile.so.3} \
		|| die "rm bundled libraries failed"
	doins -r ${ccdir}/{libs,*.rte,Credits.txt} || die "doins failed"
	dodoc ${ccdir}/readme.txt

	games_make_wrapper ${PN} ./CortexCommand.bin "${dir}" \
		|| die "make wrapper failed"
	newicon ${ccdir}/CortexCommand.png ${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} "Cortex Command" || die "make desktop entry failed"

	prepgamesdirs
}
