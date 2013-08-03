# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games unpacker

DESCRIPTION="Maps for Quake 3: Team Arena"
HOMEPAGE="ftp://ftp.idsoftware.com/idstuff/teamarena/map_paks"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/teamarena/map_paks/TA_mappak1b.zip ftp://ftp.idsoftware.com/idstuff/teamarena/map_paks/TA_mappak2.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
	games-fps/quake3
	games-fps/quake3-bin )
	games-fps/quake3-teamarena"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/quake3/missionpack
	doins missionpack/*.pk3

	dohtml -r "missionpack/TA Map Pack 1 Readme"/*
	dohtml -r "missionpack/TA Map Pack 2 Readme"/*

	find "${D}" -exec touch '{}' \;
	prepgamesdirs
}
