* Adding a directory to the `PATH` in Unix/Linux is a very common task. However, what if the directory is already in the path? My goal is to write a shell function (preferably portable) that will add a directory to the front or back of the `PATH` variable, but only if it's not already there.

syntax is in `zsh / bash`

Взято отсюда https://codereview.stackexchange.com/questions/88236/unix-shell-function-for-adding-directories-to-path

.. code-block:: bash

    #-------
    # DESC: Adds a directory to the PATH if it's not already in the PATH
    # ARGS:
    #  1 - The directory to add
    #  2 - Which end of PATH to add to.  Use "front" to prepend.
    #-------
    add2path() {
      if ! echo $PATH | egrep "(^|:)$1(:|\$)" > /dev/null ; then
        if [[ $2 = "front" ]]; then
          PATH="$1:$PATH"
        else
          PATH="$PATH:$1"
        fi
        export PATH
      fi
    }


