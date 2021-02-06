.. note:: For 14.04 and newer:

Make a file in: /etc/apt/apt.conf.d:

.. code-block:: bash

    sudoedit /etc/apt/apt.conf.d/99progressbar

Then add these contents:

Dpkg::Progress-Fancy "1";

And save the file.

Then if your umask was not 0027, (i.e. it might also be 0023), then also set this new file's permissions to 644 (i.e. -rw-r--r--) as follows:

.. code-block:: bash

    chmod 644 99progressbar

(Without this permission correction things like Debian's reportbug will stop working.)

Now enjoy apt progress bars in all their glory:
