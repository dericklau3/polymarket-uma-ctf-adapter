// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {BaseDeployScript} from "./BaseDeployScript.sol";

import {UmaCtfAdapter} from "../src/UmaCtfAdapter.sol";

contract ContractCollection is BaseDeployScript {

    function deployUmaCtfAdapter(
        address ctf,
        address finder,
        address oo
    ) public returns (UmaCtfAdapter adapter) {
        adapter = new UmaCtfAdapter(ctf, finder, oo);
        saveContract("umaCtfAdapter", address(adapter));
    }
}
