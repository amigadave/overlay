# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games versionator

MY_PN="braid-linux"
MY_PV="-build$(get_version_component_range 3)"
MY_P="${MY_PN}${MY_PV}"

DESCRIPTION="A puzzle-platformer game, drawn in a painterly style, where the player manipulates the flow of time in strange and unusual ways"
HOMEPAGE="http://braid-game.com"

HIBPAGE="http://www.humblebundle.com"
SRC_URI="${MY_P}.run.bin"
ZIP_OFFSET="191620"

RESTRICT="fetch"
LICENSE="Arphic CCPL-Attribution-ShareAlike-NonCommercial-1.0 MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="media-gfx/nvidia-cg-toolkit
	 media-libs/libsdl
	 x11-libs/libX11
	 x11-libs/libXau
	 x11-libs/libxcb
	 x11-libs/libXdmcp
	 x11-libs/libXext
	 virtual/opengl"

S="${WORKDIR}/data"

GAMEDIR="${GAMES_PREFIX_OPT}/${PN}"

pkg_nofetch() {
	einfo ""
	einfo "Please buy and download \"${SRC_URI}\" from:"
	einfo "  ${HIBPAGE}"
	einfo "and move it to \"${DISTDIR}\""
	einfo ""
}

src_unpack() {
	tail --bytes=+$(( ${ZIP_OFFSET} + 1 )) "${DISTDIR}/${A}" > "${MY_P}.zip" || die "tail \"${DISTDIR}/${A}\" failed"
	unpack "./${MY_P}.zip" || die "unpack \"${MY_P}\" failed"
	rm -f "${MY_P}.zip" || die "remove \"${MY_P}\" failed"
}

src_prepare() {
	cp "${FILESDIR}/${PN}" "${PN}" || die "copy \"${FILESDIR}/${PN}\" failed"
	sed -e "s:\#GAMEDIR\#:${GAMEDIR}:g" \
	    -e "s:\#PN\#:${PN}:g" \
	    -i "${PN}"
}

src_install() {
	cd "gamedata" || die "cd \"gamedata\" failed"

	insinto "${GAMEDIR}" || die "insinto \"${GAMEDIR}\" failed"
	doins -r "data" || die "doins \"data\" failed"

	exeinto "${GAMEDIR}" || die "exeinto \${GAMEDIR}\" failed"
	if use amd64
	then
		doexe "../amd64/${PN}" || die "doexe \"amd64/${PN}\" failed"
	fi
	if use x86
	then
		doexe "../x86/${PN}" || die "doexe \"x86/${PN}\" failed"
	fi

	# Make game wrapper
	newgamesbin "../${PN}" "${PN}" || die "newgamesbin \"${FILESDIR}/${PN}\" failed"

	# Install icon and desktop file
	doicon "${PN}.png" || die "newicon \"${PN}.png\" failed"
	make_desktop_entry "${PN}" "Braid" "/usr/share/pixmaps/${PN}.png" || die "make_desktop_entry failed"

	# Install documentation
	dodoc *.txt || die "dodoc failed"

	# Setting permissions
	prepgamesdirs
}

pkg_postinst() {
	echo ""
	games_pkg_postinst

	einfo "Braid doesn't provide a \"Settings\" menu."
	einfo ""
	einfo "For them you need to run "${PN}" once,"
	einfo "then you can edit \"\${HOME}\.Braid\settings.cfg\"."
	echo ""
}
