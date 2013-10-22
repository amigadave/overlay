# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 autotools gnome.org gnome2

EGIT_REPO_URI="git://git.gnome.org/easytag"

DESCRIPTION="GTK+ utility for editing MP2, MP3, MP4, FLAC, Ogg and other media tags"
HOMEPAGE="http://projects.gnome.org/easytag/"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 mp4 nls speex vorbis wavpack"

RDEPEND=">=x11-libs/gtk+-2.24:2
	mp3? (
		>=media-libs/id3lib-3.8.3-r7
		media-libs/libid3tag
		)
	flac? (
		media-libs/flac
		media-libs/libvorbis
		)
	mp4? ( media-libs/taglib[mp4] )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	speex? (
		media-libs/speex
		media-libs/libvorbis
		)"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.4
	app-text/yelp-tools
	>=dev-util/intltool-0.50.0
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.11
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh || die
}

src_configure() {
	gnome2_src_configure \
		$(use_enable nls) \
		$(use_enable mp3) \
		$(use_enable mp3 id3v23) \
		$(use_enable vorbis ogg) \
		$(use_enable speex) \
		$(use_enable flac) \
		$(use_enable mp4) \
		$(use_enable wavpack)
}

src_install() {
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
