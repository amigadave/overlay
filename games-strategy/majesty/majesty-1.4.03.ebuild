# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils versionator games

PV_MAJOR=$(get_version_component_range 1-2)
MY_P_MAJOR=${PN}-${PV_MAJOR}
MY_PATCH_ONE=${MY_P_MAJOR}-${PV_MAJOR}.01.run
MY_PATCH_TWO=${MY_P_MAJOR}.01-${PV_MAJOR}.02-x86.run
MY_PATCH_THREE=${MY_P_MAJOR}.02-${PV_MAJOR}.03-x86.run

DESCRIPTION="The fantasy kingdom sim"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=8&"
SRC_URI="http://updatefiles.linuxgamepublishing.com/${PN}/${MY_PATCH_ONE}
	http://updatefiles.linuxgamepublishing.com/${PN}/${MY_PATCH_TWO}
	http://updatefiles.linuxgamepublishing.com/${PN}/${MY_PATCH_THREE}"

# See README.licenses for details of included packages.
LICENSE="Majesty-EULA BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+music"
RESTRICT="strip"

RDEPEND="sys-libs/glibc
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"
DEPEND=""

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	cdrom_get_cds majesty.xpm

	ln -sfn "${CDROM_ROOT}" cd || die "CD symlink failed"
	einfo "Copying files from game CD"
	cp -rf ./cd/CREDITS ./cd/README* ./cd/majestysite.url . || die "cp READMEs failed"
	cp -rf ./cd/majesty.{bmp,xpm} . || die "cp icons failed"
	cp -rf ./cd/bin/Linux/x86/glibc-2.1/* . || die "cp exes failed"

	# Not installing the game music saves around 22 MB.
	if use music; then
		cp -rf ./cd/music . || die "cp music failed"
	fi

	# Installing only the lo-res movies or no movies at all causes majesty to
	# crash, so the hi-res movies are always installed.
	cp -rf ./cd/movies . || die "cp movies failed"

	einfo "Unpacking game data"
	for datafile in data datamx quests questsmx; do
		unpack "./cd/${datafile}.tar.gz"
	done

	rm -f cd

	einfo "Unpacking patches"
	for patches in "one ${MY_PATCH_ONE}" "two ${MY_PATCH_TWO}" \
		"three ${MY_PATCH_THREE}" ; do

		set -- $patches
		cd "${S}"
		mkdir -p patch/$1 || die "mkdir $1 failed"
		cd patch/$1
		unpack_makeself $2
	done
}

src_prepare() {
	einfo "Patching binaries"
	local patchdirs="patch/one patch/two patch/three"
	if use x86; then
		for patchdir in $patchdirs; do
			cd "${S}"/${patchdir}
			bin/Linux/x86/loki_patch patch.dat "${S}" \
				|| die "loki_patch ${patchdir} failed"
		done
	elif use amd64; then
		for patchdir in $patchdirs; do
			cd "${S}"/${patchdir}
			bin/Linux/x86_64/loki_patch patch.dat "${S}" \
				|| die "loki_patch ${patchdir} failed"
		done
	fi

	cd "${S}"
	# EULA is duplicated in licenses.
	rm -rf patch EULA || die "rm -rf patch EULA failed"
}

src_install() {
	local instdir=${GAMES_PREFIX_OPT}/${PN}
	insinto "${instdir}"
	exeinto "${instdir}"

	dodoc CREDITS README* || die "dodoc failed"
	rm CREDITS README* || die "rm CREDITS README* failed"
	doins -r * || die "doins -r failed"
	# Only install static binaries
	doexe ${PN} majx || die "doexe ${PN} majx failed"
	doicon ${PN}.xpm || die "doicon failed"

	games_make_wrapper majesty ./majesty "${dir}" "${dir}"
	games_make_wrapper majx ./majx "${dir}" "${dir}"

	make_desktop_entry majesty "Majesty" "majesty"
	make_desktop_entry majx "Majesty: The Northern Expansion" "majesty"

	prepgamesdirs
}
