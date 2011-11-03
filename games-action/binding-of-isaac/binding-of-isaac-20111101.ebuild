# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Twisted Zelda-like action adventure through Isaac's basement"
HOMEPAGE="http://www.bindingofisaac.com/"
SRC_URI="${PN}_${PV}_i386.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs )
	x86? ( dev-db/sqlite:3
		net-dns/libidn
		x11-libs/gtk+:2 )"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "Then move it to:"
	einfo "  ${DISTDIR}"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	exeinto "${dir}"

	doexe isaac

	games_make_wrapper "${PN}" "./isaac" "${dir}"
	make_desktop_entry "${PN}" "The Binding of Isaac"

	prepgamesdirs
}
