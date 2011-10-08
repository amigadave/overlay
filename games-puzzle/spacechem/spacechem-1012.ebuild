# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_PN=SpaceChem

DESCRIPTION="A chemistry-based pipeline puzzle game"
HOMEPAGE="http://spacechemthegame.com/"
SRC_URI="${MY_PN}-${PV}-hib.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="dev-lang/mono
	x11-misc/xclip
	amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? (
		media-libs/libsdl
		media-libs/sdl-image
		media-libs/sdl-mixer )"
DEPEND="${DEPEND}"

S=${WORKDIR}
HIBPAGE="http://www.humblebundle.com/"

pkg_nofetch() {
	einfo "Buy and download ${SRC_URI} from ${HIBPAGE} and place it in"
	einfo "${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	unpack "./${MY_PN}-i386.deb"
	unpack ./data.tar.gz
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"
	cd "${S}/opt/zachtronicsindustries/spacechem"

	rm ${PN}-launcher.sh ${PN}.ico zachtronicsindustries-${PN}.desktop
	dodoc readme/PRIVACY.txt readme/SOUND-CREDITS.txt

	exeinto "${dir}"
	doexe rgb2theora
	insinto "${dir}"
	doins -r fonts images lang music sounds text
	doins Ionic.Zip.dll Mono.Security.dll Newtonsoft.Json.dll registration.key \
		${MY_PN}.exe ${MY_PN}.exe.config System.Data.SQLite.dll Tao.OpenGl.dll \
		Tao.OpenGl.dll.config Tao.Sdl.dll Tao.Sdl.dll.config template.locals \
		template.user VerisignRootForGoogleAuth.cer
	newicon icon.png ${PN}.png
	games_make_wrapper ${PN} "mono SpaceChem.exe" "${dir}"
	make_desktop_entry ${PN} ${MY_PN}

	prepgamesdirs
}
