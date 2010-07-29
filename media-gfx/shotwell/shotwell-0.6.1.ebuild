# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2 versionator eutils

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Open source photo manager for GNOME"
HOMEPAGE="http://www.yorba.org/shotwell/"
SRC_URI="http://www.yorba.org/download/${PN}/${MY_PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-db/sqlite-3.5.9:3
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/libgee-0.5.0
	>=dev-libs/libunique-1.0.0
	>=dev-libs/libxml2-2.6.32
	>=gnome-base/gconf-2.22.0
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.6
	>=net-libs/libsoup-2.26.0
	>=net-libs/webkit-gtk-1.1.5
	>=sys-fs/udev-145[extras]
	>=x11-libs/gtk+-2.14.4:2
	>=media-libs/libraw-0.9.0
	>=media-libs/gexiv2-0.1.0"
DEPEND="${RDEPEND}
	=dev-lang/vala-0.8*"

DOCS="AUTHORS MAINTAINERS NEWS README THANKS"

src_prepare() {
	epatch "${FILESDIR}/${P}-libraw.patch" || die "libraw patch failed."
	mv vapi/libraw{,_r}.vapi || die "renaming libraw.vapi failed"
}

pkg_setup() {
	G2CONF="--disable-schemas-install
		--disable-desktop-update
		--disable-icon-update"
}

src_install() {
	# This is needed so that gnome2_gconf_savelist() works correctly.
	insinto "${EPREFIX}"/etc/gconf/schemas
	doins misc/shotwell.schemas || die "install gconf schema failed"
	gnome2_src_install
}
