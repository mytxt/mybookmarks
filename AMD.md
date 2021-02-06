The AMD Open Source Driver for Vulkan is designed to support the following features:

    Vulkan 1.1
    More than 30 extensions
    Radeon™ GPUProfiler tracing
    Built-in debug and profiling tools
    Mid-command buffer preemption and SR-IOV virtualization

Known Issues

*    CTS may hang in VK.synchronization.internally_synchronized_objects.pipeline_cache_compute with Linux kernel versions lower than 4.13
*    The driver can only work with firmware of ME feature version >= 25 (you can check the version with command `sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info`). If you are using upstream stack with GPUs of SI or CI family, you may need to upgrade the kernel to 4.19 or later version and firmware (under /lib/firmware/amdgpu/) to the right version from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/amdgpu, and then update ramfs 

.. code-block:: bash

    sudo mkinitramfs -o /boot/initrd.img-`uname -r` `uname -r`

Build Instructions

System Requirements

It is recommended to install 16GB RAM in your build system.
Install Dev and Tools Packages
Ubuntu

.. code-block:: bash

    sudo apt-get install build-essential python3 cmake curl g++-multilib gcc-multilib

.. code-block:: bash

    sudo apt-get install libx11-dev libxcb1-dev x11proto-dri2-dev libxcb-dri3-dev libxcb-dri2-0-dev libxcb-present-dev libxshmfence-dev libxrandr-dev libx11-dev:i386 libxcb1-dev:i386 x11proto-dri2-dev:i386 libxcb-dri3-dev:i386 libxcb-dri2-0-dev:i386 libxcb-present-dev:i386 libxshmfence-dev:i386 libwayland-dev libwayland-dev:i386 libxrandr-dev:i386

Get Repo Tools

.. code-block:: bash

    mkdir ~/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo

Get Source Code

.. code-block:: bash

    mkdir vulkandriver
    cd vulkandriver
    ~/bin/repo init -u https://github.com/GPUOpen-Drivers/AMDVLK.git -b master
    ~/bin/repo sync

.. note:: Source code in dev branch can be gotten by using “-b dev” in the “repo init” command 64-bit Build Ubuntu

.. code-block:: bash

    cd <vulkandriver_path>/drivers/xgl
    cmake -H. -Bbuilds/Release64
    cd builds/Release64
    make -j$(nproc)

32-bit Build
Ubuntu

.. code-block:: bash

    cd <vulkandriver_path>/drivers/xgl
    cmake -H. -Bbuilds/Release -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32
    cd builds/Release
    make -j$(nproc)

.. note:: If the build runs into errors like “collect2: fatal error: ld terminated with signal 9 [Killed]” due to out of memory, you could try with reducing the number of threads in “make” command.

Debug build can be done by using `-DCMAKE_BUILD_TYPE=Debug`. 
To enable Wayland support, you need to build the driver by using `-DBUILD_WAYLAND_SUPPORT=ON` and install the Wayland WSA library.

**Installation Instructions**

Install Vulkan SDK

You can download and install the SDK package here.
Uninstall Previously Installed JSON Files

Please make sure all JSON files for AMD GPUs under below folders are uninstalled:

`/etc/vulkan/icd.d`
`/usr/share/vulkan/icd.d`

Copy Driver and JSON Files
Ubuntu

.. code-block:: bash

    sudo cp <vulkandriver_path>/drivers/xgl/builds/Release64/icd/amdvlk64.so /usr/lib/x86_64-linux-gnu/
    sudo cp <vulkandriver_path>/drivers/xgl/builds/Release/icd/amdvlk32.so /usr/lib/i386-linux-gnu/
    sudo cp <vulkandriver_path>/drivers/AMDVLK/json/Ubuntu/ /etc/vulkan/icd.d/



.. note:: The remaining steps are only required when running the AMDGPU upstream driver stack.

Add following lines in `/usr/share/X11/xorg.conf.d/10-amdgpu.conf`:

.. code-block:: ini

    Section "Device"
        Identifier "AMDgpu"
        Option  "DRI" "3"
    EndSection

And make sure following line is NOT included in the section:

Driver      "modesetting"

**Required Settings**

On the AMDGPU upstream driver stack with libdrm version lower than 2.4.92, the max number of IB per submission MUST be limited to ``4`` (the default setting in AMD Open Source driver for Vulkan is ``16``).
This can be accomplished via the Runtime Settings mechanism by adding the following line to ``amdPalSettings.cfg``:

.. code-block:: cfg

    MaxNumCmdStreamsPerSubmit,4
    CommandBufferCombineDePreambles,1

Install with pre-built driver
-----------------------------

You could download and install pre-built deb package (compatible with Ubuntu 16.04 and 18.04) from https://github.com/GPUOpen-Drivers/AMDVLK/releases for each stable code promotion in master branch:

.. code-block:: bash

    sudo dpkg -r amdvlk
    sudo dpkg -i amdvlk_x.x.x_amd64.deb
    sudo apt-get -f install

You could also install the latest driver build from http://repo.radeon.com:

.. code-block:: bash

    sudo wget -qO - http://repo.radeon.com/amdvlk/apt/debian/amdvlk.gpg.key | sudo apt-key add -
    sudo sh -c 'echo deb [arch=amd64] http://repo.radeon.com/amdvlk/apt/debian/ bionic main > /etc/apt/sources.list.d/amdvlk.list'
    sudo apt-get remove amdvlk
    sudo apt update
    sudo apt-get install amdvlk

**Runtime Settings**

The driver exposes many settings that can customize the driver’s behavior and facilitate debugging. You can add/edit settings in ``amdPalSettings.cfg`` file under one of below paths, formatted with one name,value pair per line: ``/etc/amd`` ``$XDG_CONFIG_HOME $HOME/.config``

Runtime cache is the default mode.

For “cache to disk”, the cache file is generated under

*   ``$AMD_SHADER_DISK_CACHE_PATH/AMD/LlpcCache`` or
*   ``$XDG_CACHE_HOME/AMD/LlpcCache`` or
*   ``$HOME/.cache/AMD/LlpcCache``

All available settings can be determined by examining below source files that define them.

.. code-block:: cfg

    .../xgl/icd/settings/settings.cfg (API layer settings)
    .../pal/src/core/settings_core.json (PAL hardware-independent settings)
    .../pal/src/core/hw/gfxip/gfx6/settings_gfx6.json (PAL GFX6-8 settings)
    .../pal/src/core/hw/gfxip/gfx9/settings_gfx9.json (PAL GFX9+ settings)

Runtime settings are only read at device initialization, and cannot be changed without restarting the application. If running on a system with multiple GPUs, the same settings will apply to all of them. Lines in the settings file that start with ; will be treated as comments.

Enable extensions under development

The extensions under development are not enabled by default in driver. You can enable them through environment variable:

*   ``export AMDVLK_ENABLE_DEVELOPING_EXT="<extension1-name> [<extension2-name>...]"`` or
*   ``export AMDVLK_ENABLE_DEVELOPING_EXT="all"``

The extension name is case-insensitive.

**PAL GpuProfiler Layer**

The GpuProfiler is an optional layer that is designed to intercept the PAL interface to provide basic GPU profiling support. Currently, this layer is controlled exclusively through runtime settings and outputs its results to file.
