
.. code-block:: bash

	sudo acpidump > acpidata.dat
	acpixtract -sSSDT acpidata.dat
	acpixtract -sDSDT acpidata.dat

	iasl -d DSDT.dat SSDT*.dat

`ACPI Tricks and Tips <https://wiki.ubuntu.com/Kernel/Reference/ACPITricksAndTips>`_
