# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games unpacker

DESCRIPTION="Threewave CTF maps for Quake 3: Arena"
HOMEPAGE="http://lvlworld.com/review/Threewave%20CTF"
SRC_URI="http://lvlworld.com/dl/lvl/3 -> q3wctf.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
	games-fps/quake3
	games-fps/quake3-bin )"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/quake3/baseq3
	doins maps-q3wctf.pk3

	dodoc maps-q3wctf.txt maps-q3wctf-kythkin.txt

	find "${D}" -exec touch '{}' \;
	prepgamesdirs
}
