# meta-rpi-krlos/recipes-bsp/bootfiles/rpi-bootfiles.bbappend

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://cmdline-fragment.txt \
    file://config-fragment.txt \
"

python do_add_uart() {
    import os

    bb.note("Agregando soporte UART a cmdline.txt y config.txt")

    cmdline = os.path.join(d.getVar('D'), 'cmdline.txt')
    config = os.path.join(d.getVar('D'), 'config.txt')
    cmdline_fragment = os.path.join(d.getVar('WORKDIR'), 'cmdline-fragment.txt')
    config_fragment = os.path.join(d.getVar('WORKDIR'), 'config-fragment.txt')

    # cmdline.txt
    with open(cmdline_fragment, 'r') as f:
        fragment = f.read()
    with open(cmdline, 'r+') as f:
        content = f.read()
        if fragment not in content:
            f.write(" " + fragment)

    # config.txt
    with open(config_fragment, 'r') as f:
        fragment = f.read()
    with open(config, 'r+') as f:
        content = f.read()
        if fragment not in content:
            f.write("\n" + fragment)
}

do_add_uart[dirs] = "${WORKDIR}"
do_add_uart[cleandirs] = "${WORKDIR}"

addtask do_add_uart after do_install before do_image
