# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime gnome2-utils eutils autotools

DESCRIPTION="RAW Image format viewer and GIMP plugin"
HOMEPAGE="http://ufraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64  ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="bzip2 contrast exif fits gimp gnome gtk jpeg lensfun openmp png tiff timezone zlib"

RDEPEND="dev-libs/glib:2
	media-libs/lcms:0
	bzip2? ( app-arch/bzip2 )
	exif? ( >=media-gfx/exiv2-0.20 )
	fits? ( sci-libs/cfitsio )
	gnome? ( >=gnome-base/gconf-2
		>=x11-misc/shared-mime-info-0.21 )
	gtk? ( >=x11-libs/gtk+-2.6:2
		>=media-gfx/gtkimageview-1.6.0 )
	gimp? ( >=x11-libs/gtk+-2.6:2
		>=media-gfx/gtkimageview-1.6.0
		>=media-gfx/gimp-2.0 )
	jpeg? ( virtual/jpeg )
	lensfun? ( >=media-libs/lensfun-0.2.5 )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-automagics.patch
	eautoreconf
}

src_configure() {
	econf \
		--without-cinepaint \
		$(use_with bzip2) \
		$(use_enable contrast) \
		$(use_with exif exiv2) \
		$(use_with fits cfitsio) \
		$(use_with gimp) \
		$(use_with gtk) \
		$(use_with jpeg) \
		$(use_with lensfun) \
		$(use_enable gnome mime) \
		$(use_enable openmp) \
		$(use_with png libpng) \
		$(use_with tiff) \
		$(use_enable timezone dst-correction) \
		$(use_with zlib) \
		$(usex gimp --with-gtk "")
}

src_install() {
	emake DESTDIR="${D}" schemasdir="${EPREFIX}"/etc/gconf/schemas install
	dodoc MANIFEST README TODO 
	if use gnome; then
		gnome2_gconf_savelist
	fi
}

pkg_postinst() {
	if use gnome; then
		fdo-mime_mime_database_update
		fdo-mime_desktop_database_update
		gnome2_gconf_install
	fi
}

pkg_postrm() {
	if use gnome; then
		gnome2_gconf_uninstall
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
	fi
}
