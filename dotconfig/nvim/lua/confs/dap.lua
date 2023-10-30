vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})

require'dap'.configurations.cpp = {
    {
        type = 'cppdbg';
        request = 'launch';
        name = "TPV Emulator GL";
        program = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/sandbox/bin/dtvplay-emulator";
        cwd = "${workspaceFolder}",
        environment = {
            { name =  "LC_ALL", value = "C" },
            { name =  "LD_LIBRARY_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/sandbox/lib/:${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib:${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/pulseaudio" },
            { name =  "GIO_MODULE_DIR", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/gio/modules" },
            { name =  "GST_PLUGIN_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/gstreamer-1.0" },
            { name =  "LIBGL_DRIVERS_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debug/usr/lib/dri" }
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
    {
        type = 'cppdbg';
        request = 'launch';
        name = "TPV Emulator GL DebugFull";
        program = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/sandbox/bin/dtvplay-emulator";
        cwd = "${workspaceFolder}",
        environment = {
            { name =  "LC_ALL", value = "C" },
            { name =  "LD_LIBRARY_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/sandbox/lib/:${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib:${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/pulseaudio" },
            { name =  "GIO_MODULE_DIR", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/gio/modules" },
            { name =  "GST_PLUGIN_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/gstreamer-1.0" },
            { name =  "LIBGL_DRIVERS_PATH", value = "${workspaceFolder}/output/tpv_mw_emulator_gl/debugfull/usr/lib/dri" }
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
}

