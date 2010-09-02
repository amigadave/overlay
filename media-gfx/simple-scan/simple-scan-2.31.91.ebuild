# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/gnome-doc-utils
	>=x11-libs/gtk+-2.18.0:2
	dev-libs/glib:2
	gnome-base/gconf:2
	>=media-gfx/sane-backends-1.0.20
	sys-fs/udev[extras]
	>=sys-libs/zlib-1.2.5
	x11-libs/cairo
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0"

DOCS="AUTHORS ChangeLog NEWS README"
