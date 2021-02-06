.. code-block:: bash

    #Option `"XkbOptions lv3:ralt_switch"` is set by default in xorg.conf.
    #This can be manually commented out or you can run +
    sudo dpkg-reconfigure xserver-xorg
    #and disable the option from in there
    #this works (for X):
    xmodmap -e 'clear mod5'
    xmodmap -e "keycode 108 = Alt_L"
