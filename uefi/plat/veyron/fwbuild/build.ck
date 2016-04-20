/*++

Copyright (c) 2015 Minoca Corp. All Rights Reserved

Module Name:

    Veyron Firmware Image Builder

Abstract:

    This build utility adds the necessary keyblock and preamble for booting
    a firmware image on a Rk3288 Veyron SoC.

Author:

    Chris Stevens 7-Jul-2015

Environment:

    Build

--*/

function build() {
    sources = [
        "fwbuild.c",
    ];

    libs = [
        "//lib/crypto/ssl:build_ssl",
        "//lib/crypto:build_crypto",
        "//lib/rtl/base:build_basertl",
        "//lib/rtl/rtlc:build_rtlc",
    ];

    includes = [
        "$//uefi/include"
    ];

    app = {
        "label": "veyrnfwb",
        "inputs": sources + libs,
        "includes": includes,
        "build": TRUE
    };

    entries = application(app);
    tool = {
        "type": "tool",
        "name": "veyrnfwb",
        "command": "$^//uefi/plat/veyron/fwbuild/veyrnfwb $TEXT_ADDRESS $IN $OUT",
        "description": "Creating Verified Boot Image - $OUT"
    };

    entries += [tool];
    return entries;
}

return build();