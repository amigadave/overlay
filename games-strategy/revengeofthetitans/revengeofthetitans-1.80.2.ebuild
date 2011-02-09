# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games versionator

MY_PV=$(delete_all_version_separators)
MY_PN="RevengeOfTheTitans-HIB"
DESCRIPTION="Command your forces against the Titan horde"
HOMEPAGE="http://www.puppygames.net/revenge-of-the-titans/"
SRC_URI="amd64? ( ${MY_PN}-${MY_PV}-amd64.tar.gz )
	x86? ( ${MY_PN}-${MY_PV}-i386.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND=""
RDEPEND="virtual/jre"

HIBPAGE="http://www.humblebundle.com/"
S="${WORKDIR}/${PN}"

pkg_nofetch() {
	einfo "Buy and download ${SRC_URI} from ${HIBPAGE} and place it in"
	einfo "${DISTDIR}"
}

src_install() {
	local instdir="${GAMES_PREFIX_OPT}/${PN}"
	insinto "${instdir}"
	exeinto "${instdir}"

	doexe revenge.sh || die "doexe failed"
	newicon revenge.png ${PN}.png || die "newicon failed"
	rm -f revenge.sh revenge.png || die "rm failed"
	doins -r * || die "doins failed"

	games_make_wrapper ${PN} ./revenge.sh "${instdir}"
	make_desktop_entry ${PN} "Revenge of the Titans"

	prepgamesdirs
}
