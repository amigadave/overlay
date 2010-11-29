# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base cvs

DESCRIPTION="Fetches your Hotmail (MSN) Live mail"
HOMEPAGE="http://sourceforge.net/projects/getlive/"
ECVS_SERVER="getlive.cvs.sourceforge.net:/cvsroot/getlive"
ECVS_MODULE="GetLive"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/perl
	dev-perl/net-server
	|| ( net-misc/curl[gnutls] net-misc/curl[nss] net-misc/curl[ssl] )"

DOCS=( "ChangeLog" "Manual" "SmtpAuthForward.pl" "SmtpForward.pl" )

S=${WORKDIR}/${ECVS_MODULE}

src_install() {
	base_src_install_docs
	dobin GetLive.pl || die "dobin failed"
}
