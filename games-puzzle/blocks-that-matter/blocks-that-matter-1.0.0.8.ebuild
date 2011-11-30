# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

MY_P="blocks-matter_${PV}"
HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Platform puzzler with the player taking the role of the Tetrobot"
HOMEPAGE="http://www.swingswingsubmarine.com/games/blocks-that-matter/"
SRC_URI="amd64? ( ${MY_P}_x64.tar.gz )
	x86? ( ${MY_P}_x86.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

RDEPEND="media-libs/openal
	virtual/jre
	virtual/opengl"

if use amd64 ; then
	S="${WORKDIR}/${MY_P}_x64"
else
	S="${WORKDIR}/${MY_P}_x86"
fi

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "and then move it to:"
	einfo "  ${DISTDIR}"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doexe BTM || die
	doins BTM.bftm BTM.jar || die
	newicon BTM.png ${PN}.png || die
	doins -r BTM_lib config || die
	dodoc README/USER_DATAS_FILES.txt README/ChangeLog.txt README/README.txt \
		|| die
	dodir "${dir}/java_libs" || die
	insinto "${dir}/java_libs"
	if use amd64 ; then
		doins libjinput-linux64.so liblwjgl64.so || die
	else
		# Only other architecture is x86.
		doins libjinput-linux.so liblwjgl.so || die
	fi

	games_make_wrapper "${PN}" "java -Xmx1024M -Xms512M \
		-Djava.library.path=java_libs -jar BTM.jar" "${dir}" || die
	make_desktop_entry "${PN}" "Blocks That Matter" || die

	prepgamesdirs
}
