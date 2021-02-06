Установим утилиту `FIGlet`, чтобы получить возможность конвертировать текст в ASCII Арт из командной строки в Linux.

Для Ubuntu, Debian, Linux Mint и т.д.

.. code-block:: bash

    sudo apt-get install figlet

Чтобы использовать `FIGlet` с настройками по умолчанию, просто наберите:

.. code-block:: bash

    figlet "Shell Hacks"

.. code-block:: text

     ____  _          _ _   _   _            _
    / ___|| |__   ___| | | | | | | __ _  ___| | _____
    \___ \| '_ \ / _ \ | | | |_| |/ _` |/ __| |/ / __|
     ___) | | | |  __/ | | |  _  | (_| | (__|   <\__ \
    |____/|_| |_|\___|_|_| |_| |_|\__,_|\___|_|\_\___/

Если Вы хотите выровнять текст по центру, используйте `опцию -c`:

Используйте `опцию -f`, чтобы изменить шрифт, например:

.. code-block:: bash

    figlet -f digital "Shell Hacks"

.. code-block:: text

    +-+-+-+-+-+ +-+-+-+-+-+
    |S|h|e|l|l| |H|a|c|k|s|
    +-+-+-+-+-+ +-+-+-+-+-+

Показать список доступных шрифтов в `FIGlet`:

.. code-block:: bash

    showfigfonts

Также Вы можете `скачать дополнительные шрифты для FIGlet <http://www.figlet.org/fontdb.cgi>`_, например:

.. code-block:: bash

    wget http://www.figlet.org/fonts/univers.flf
    figlet -f univers.flf "lol"

.. code-block:: text

    88             88  
    88             88  
    88             88  
    88  ,adPPYba,  88  
    88 a8"     "8a 88  
    88 8b       d8 88  
    88 "8a,   ,a8" 88  
    88  `"YbbdP"'  88 

см. `Примеры шрифтов <http://www.figlet.org/examples.html>`_

Если Вы хотите отобразить вывод команды с помощью `FIGlet`, просто `перенаправьте вывод через пайп` в `FIGlet`: 

.. code-block:: bash

    date +%r | figlet -f bubble

.. code-block:: text

      _   _   _   _   _   _   _   _     _   _
     / \ / \ / \ / \ / \ / \ / \ / \   / \ / \
    ( 0 | 4 |: | 5 | 1 |: | 4 | 9 ) ( P | M )
     \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/

.. code-block:: bash

    echo "WTF?" | figlet -f banner

.. code-block:: text

    #     # ####### #######  #####
    #  #  #    #    #       #     #
    #  #  #    #    #             #
    #  #  #    #    #####      ###
    #  #  #    #    #          #
    #  #  #    #    #
     ## ##     #    #          #

Используйте `опцию -p`, если `FIGlet` получает текст из файла:

.. code-block:: bash

    cat myfile

.. code-block:: console

    Shell Hacks

.. code-block:: bash

    figlet -p < myfile

.. code-block:: text

     ____  _          _ _   _   _            _
    / ___|| |__   ___| | | | | | | __ _  ___| | _____
    \___ \| '_ \ / _ \ | | | |_| |/ _` |/ __| |/ / __|
     ___) | | | |  __/ | | |  _  | (_| | (__|   <\__ \
    |____/|_| |_|\___|_|_| |_| |_|\__,_|\___|_|\_\___/

Более подробную информацию Вы найдете на `официальном сайте FIGlet <http://www.figlet.org/>`_.

