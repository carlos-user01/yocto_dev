FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://serial-getty@ttyAMA0.service"

do_install:append() {
    # Instalar el servicio
    install -d ${D}${systemd_system_unitdir}/
    install -m 0644 ${WORKDIR}/serial-getty@ttyAMA0.service ${D}${systemd_system_unitdir}/

    # Habilitarlo
    install -d ${D}${systemd_system_unitdir}/getty.target.wants/
    ln -sf ${systemd_system_unitdir}/serial-getty@ttyAMA0.service \
        ${D}${systemd_system_unitdir}/getty.target.wants/serial-getty@ttyAMA0.service
}

