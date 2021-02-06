- *acpidump* - dump a system's ACPI tables to an ASCII file

.. code-block:: bash

    acpidump -o dump.txt

    acpidump -b # extract binary data

- *acpixtract* - convert ASCII acpidump output to raw binary table

.. code-block:: bash

    acpixtract dump.txt

- *turbostat* - gather performance statistics

.. code-block:: bash

	cd /sys/firmware/acpi/tables
	sudo cp DSDT ~/dir/dsdt.dat
	sudo chown $USER: DSDT
	iasl -d dsdt.dat
