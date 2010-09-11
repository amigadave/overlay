# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"
HOMEPAGE="http://www.libraw.org/"
SRC_URI="http://www.libraw.org/data/LibRaw-${PV}.tar.gz"

# Libraw also has it's own license, which is a pdf file and
# can be obtained from here:
# http://www.libraw.org/data/LICENSE.LibRaw.pdf
LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lcms openmp examples"

RDEPEND="lcms? ( =media-libs/lcms-1* )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/LibRaw-${PV}"
MY_LIBDIR=$(get_libdir)

src_prepare() {
	# Add pkg-config support
	epatch "${FILESDIR}/${P}-pkg-config.patch" || die "pkg-config patch failed"

	sed -i -e "s:/usr/local/:${D}usr/:g" \
		-e "/^CFLAGS/ s:-O4:${CFLAGS}:" \
		-e "s:usr/lib:usr/${MY_LIBDIR}:g" \
		Makefile || die "Patching the hell out of manual Makefile failed"
	
	sed -i -e "s:LIBDIR:${MY_LIBDIR}:" \
		-e "s:VERSION:${PV}:" \
		*.pc || die "Patching pc files failed"

	if use lcms; then
		sed -i -r '/^#LCMS/ s!^#!!' Makefile || die "Enabling LCMS failed"
		sed -i -r -e '/^Libs/ s!$! -llcms!' \
			-e '/^Requires/ s!$! lcms!' \
			*.pc || die "Adding pkg-config LCMS dependency failed"
	fi

	if use openmp; then
		sed -i -r '/^CFLAGS/ s!^(.*)$!\1 -fopenmp!' \
			Makefile || die "Enabling OpenMP failed"
		sed -i -r -e '/^Cflags/ s!$! -fopenmp!' \
			-e '/^Libs/ s!$! -lgomp!' \
			*.pc || die "Adding pkg-config OpenMP dependency failed"
	fi
}

src_install() {
	# This Makefile does not even make the directories.
	mkdir -p "${D}usr/include" \
		"${D}usr/${MY_LIBDIR}" \
		"${D}usr/${MY_LIBDIR}/pkgconfig" \
		$(use examples && echo "${D}/usr/bin") || die "Directory making failed"

	emake install \
		$(use examples && echo "install-binaries") || die "Install failed"
}
