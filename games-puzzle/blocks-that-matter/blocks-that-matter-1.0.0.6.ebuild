# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

HIBPAGE="http://www.humblebundle.com/"
DESCRIPTION="Platform puzzler with the player taking the role of the Tetrobot"
HOMEPAGE="http://www.swingswingsubmarine.com/games/blocks-that-matter/"
SRC_URI="blocks-matter_${PV}_all.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="media-gfx/icoutils"
RDEPEND="media-libs/openal
	virtual/jre
	virtual/opengl"

S="${WORKDIR}/BlocksThatMatter.Full.Linux.${PV}"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HIBPAGE}"
	einfo "and then move it to:"
	einfo "  ${DISTDIR}"
}

src_prepare() {
	icotool --extract BTM.ico || die "icon conversion failed"
	mv BTM_1_64x64x24.png ${PN}.png
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doexe BTM
	doins BTM.bftm BTM.jar
	doicon ${PN}.png
	doins -r BTM_lib config
	dodoc README/USER_DATAS_FILES.txt README/ChangeLog.txt README/README.txt
	dodir "${dir}/java_libs"
	insinto "${dir}/java_libs"
	if use amd64 ; then
		doins libjinput-linux64.so liblwjgl64.so
	else
		# Only other architecture is x86.
		doins libjinput-linux.so liblwjgl.so
	fi

	games_make_wrapper "${PN}" "java -Xmx1024M -Xms512M \
		-Djava.library.path=java_libs -jar BTM.jar" "${dir}"
	make_desktop_entry "${PN}" "Blocks That Matter"

	prepgamesdirs
}
