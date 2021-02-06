`Clock screensaver for XScreenSaver <http://pt2k.xii.jp/software/anclock/xscreensaver/index_e.html>`_
-----------------------------------------------------------------------------------------------------

**Download**

Patch for XScreenSaver 5.43 - 5.43:
`anclock-2.0.1-for-xscreensaver-5.43.patch.gz <http://pt2k.xii.jp/software/anclock/xscreensaver/anclock-2.0.1-for-xscreensaver-5.43.patch.gz>`_

**Compile & Install**

This package is distributed as a patch for original `XScreenSaver sources <http://www.jwz.org/xscreensaver/>`_.
Download xscreensaver-5.43.tar.gz .
Open the console terminal and enter as below:

.. code:: bash

    tar zxf xscreensaver-5.43.tar.gz
    cd xscreensaver-5.43
    zcat ../anclock-2.0.1-for-xscreensaver-5.43.patch.gz | patch -p1
    ./configure
    make
    su
    make install

**Requirement**

Install following packages before compilation:

.. code:: bash

    sudo apt install libxt-dev libglade2-dev


.. note:: Just copy *built* `anclock` from `./hacks` to `/lib/xscreensaver` and make `/usr/share/applications/screensavers/anclock.desktop` file for it (use any existing as template)

.. literalinclude:: ./src/anclock.desktop
    :language: ini
    :linenos:
