// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;


import "./ContractCollection.sol";

contract UmaCtfAdapterScript is ContractCollection {

    uint256 privatekey = vm.envUint("PRIVATEKEY");

    function run() public {
        
        vm.startBroadcast(privatekey);

        Config memory cfg = _getConfig();
        
        deployUmaCtfAdapter(cfg.ctf, cfg.finder, cfg.oo);
        
        vm.stopBroadcast();
    }
}
