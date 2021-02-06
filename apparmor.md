Использование AppArmor
----------------------

Пакет apparmor-utils содержит утилиты командной строки, которые можно использовать для изменения режима выполнения AppArmor, поиска статуса профиля, создания новых профилей и т.п.

1. **apparmor_status** используется для просмотра текущего статуса профиля AppArmor.

.. code-block:: bash

    sudo apparmor_status

2. **aa-complain** переводит профиль в режим обучения (complain).

.. code-block:: bash

    sudo aa-complain /path/to/bin

3. **aa-enforce** переводит профиль в режим ограничений (enforce).

.. code-block:: bash

    sudo aa-enforce /path/to/bin

4. Профили AppArmor расположены в каталоге /etc/apparmor.d. Его можно использовать для управления режимом всех профилей. Введите следующую команду для перевода всех профилей в режим обучения:

.. code-block:: bash

    sudo aa-complain /etc/apparmor.d/*

Перевод всех профилей в режим ограничений:

 .. code-block:: bash

    sudo aa-enforce /etc/apparmor.d/*

5. Команда **apparmor_parser** используется для загрузки профиля в ядро. Она также может использоваться для повторной загрузки загруженного профиля при использовании опции '-r'. Для загрузки введите

.. code-block:: bash

    cat /etc/apparmor.d/profile.name | sudo apparmor_parser -a

Для перезагрузки:

.. code-block:: bash

    cat /etc/apparmor.d/profile.name | sudo apparmor_parser -r

6. /etc/init.d/apparmor служит для перезагрузки всех профилей:

.. code-block:: bash

    sudo /etc/init.d/apparmor reload

7. Директория /etc/apparmor.d/disable может использоваться совместно с опцией **apparmor_parser -R** для отключения профиля.

.. code-block:: bash

    sudo ln -s /etc/apparmor.d/profile.name /etc/apparmor.d/disable/
    sudo apparmor_parser -R /etc/apparmor.d/profile.name

Для активации отключенного профиля удалите символическую ссылку на профиль в /etc/apparmor.d/disable/. Затем загрузите профиль используя опцию '-a'.

.. code-block:: bash

    sudo rm /etc/apparmor.d/disable/profile.name
    cat /etc/apparmor.d/profile.name | sudo apparmor_parser -a

8. AppArmor можно отключить, а модуль ядра выгрузить следующей командой:

.. code-block:: bash

    sudo /etc/init.d/apparmor stop
    sudo update-rc.d -f apparmor remove

9. Для повторной активации AppArmor введите:

.. code-block:: bash

    sudo /etc/init.d/apparmor start
    sudo update-rc.d apparmor defaults

`Отсюда взято <https://help.ubuntu.ru/wiki/%D1%80%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D1%81%D1%82%D0%B2%D0%BE_%D0%BF%D0%BE_ubuntu_server/%D0%B1%D0%B5%D0%B7%D0%BE%D0%BF%D0%B0%D1%81%D0%BD%D0%BE%D1%81%D1%82%D1%8C/apparmor>`_


