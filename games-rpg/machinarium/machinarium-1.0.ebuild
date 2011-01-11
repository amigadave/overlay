# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

MY_PN="Machinarium"
MY_P="${MY_PN}_full_en"

DESCRIPTION="Puzzle point-and-click adventure game"
HOMEPAGE="http://machinarium.net/"
SRC_URI="${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND=""
RDEPEND="amd64? ( app-emulation/emul-linux-x86-gtklibs )
	x86? ( x11-libs/gtk+:2 )"

S=${WORKDIR}/${MY_PN}

pkg_nofetch() {
	elog "Download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	exeinto "${dir}"
	doexe ${MY_PN} || die "doexe failed"
	insinto "${dir}"
	doins -r 00/ 01/ 10/ 11/ || die "doins failed"

	games_make_wrapper ${PN} ./${MY_PN} "${dir}"
	make_desktop_entry ${PN} "Machinarium"

	prepgamesdirs
}
