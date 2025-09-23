FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://issue"

do_install:append() {
    # Copia el archivo issue modificado
    install -m 0644 ${WORKDIR}/issue ${D}${sysconfdir}/issue
}
