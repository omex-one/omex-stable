// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NativeOFT} from "src/NativeOFT.sol";
import {OFT} from "src/OFT.sol";
import {ProxyOFT} from "src/ProxyOFT.sol";

contract deployContract is Script {
    NativeOFT public nativeOFT;
    OFT public oft;
    ProxyOFT public proxyOFT;

    address lzEndpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
    address initOwner = msg.sender;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        oft = new OFT("OMEX-stable", "OMEX", lzEndpoint, initOwner);
        proxyOFT = new ProxyOFT(lzEndpoint, address(oft), initOwner);
        nativeOFT = new NativeOFT("OMEX-stable", "OMEX", lzEndpoint, msg.sender);

        console.log("OFT address: ", address(oft));
        console.log("ProxyOFT address: ", address(proxyOFT));
        console.log("NativeOFT address: ", address(nativeOFT));

        vm.stopBroadcast();
    }
}
