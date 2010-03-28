# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

# Actually 2.3, but that version does not exist in python.eclass.
PYTHON_DEPEND="*:2.4"

inherit bash-completion python

DESCRIPTION="The Debian Package Upload Tool"
HOMEPAGE="http://git.debian.org/?p=collab-maint/dput.git"
SRC_URI="mirror://debian/pool/main/d/dput/dput_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-crypt/gnupg
	>=dev-lang/python-2.3"

src_install() {
	dodoc debian/changelog FAQ README THANKS TODO
	doman dcut.1 dput.1
	# Work around doman change in Gentoo bug #222439.
	insinto ${EPREFIX}/usr/share/man/man5
	doins dput.cf.5
	dobashcompletion bash_completion dput
	dobin dput dcut
	insinto ${EPREFIX}/etc
	doins dput.cf
	insinto ${EPREFIX}/usr/share/${PN}
	doins ftp.py http.py https.py scp.py local.py rsync.py
	insinto ${EPREFIX}/usr/share/${PN}/helper
	doins dputhelper.py security-warning
}
