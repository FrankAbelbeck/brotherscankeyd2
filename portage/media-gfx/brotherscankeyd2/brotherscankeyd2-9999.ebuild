EAPI=7

inherit git-r3

DESCRIPTION="Brother Scan Key Daemon allows to manage the scan-to-x menus of Brother printers."
HOMEPAGE="https://github.com/FrankAbelbeck/brotherscankeyd2"
LICENSE="GPL-3"
KEYWORDS="amd64"
DEPEND=""
RDEPEND="dev-python/linuxfd"
EGIT_REPO_URI="https://github.com/FrankAbelbeck/brotherscankeyd2.git"
SLOT="0"

src_install() {
	# install program and the init script
	dobin  ${S}/bin/brotherscankeyd2
	dobin  ${S}/bin/bskd2_scan2image
	dobin  ${S}/bin/bskd2_scan2pdf
	doinitd ${S}/openrc/brotherscankeyd2
	# extract example configuration file and place it in /etc
	# set permission so that config is readable by all
	insinto /etc
	${S}/bin/brotherscankeyd2 cfgMain | newins - brotherscankeyd2.ini
	fperms 644 /etc/brotherscankeyd2.ini
}

pkg_postinst() {
	elog "Please edit /etc/brotherscankeyd2.ini."
	elog "You need to define some menu entries, otherwise this daemon does nothing."
	elog "And please check if the default daemon user exists on your system."
	elog "If not either create it or change it to an existing suitable user."
}
