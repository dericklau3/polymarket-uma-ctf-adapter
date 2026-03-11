// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ContractRegistry} from "./ContractRegistry.sol";

/**
 * @title BaseDeployScript
 * @dev Base deployment script providing simple contract saving functionality
 * Only requires one method: saveContract(contractName, contractAddress)
 */
abstract contract BaseDeployScript is Script {
    using ContractRegistry for *;

    /**
     * @dev Reads a contract address from contracts.json. Returns address(0) if missing.
     * @param contractName Contract name key in the registry
     */
    function getContractAddress(
        string memory contractName
    ) internal view returns (address) {
        string memory fileName = "contracts.json";
        string memory content;

        // Bail out if the file does not exist or is empty
        try vm.readFile(fileName) returns (string memory loaded) {
            if (bytes(loaded).length == 0) {
                return address(0);
            }
            content = loaded;
        } catch {
            return address(0);
        }

        string memory path = string.concat(".", contractName, ".address");
        try vm.parseJsonAddress(content, path) returns (address addr) {
            return addr;
        } catch {
            return address(0);
        }
    }

    /**
     * @dev Save contract name and address to contracts.json
     * @param contractName Contract name
     * @param contractAddress Contract address
     */
    function saveContract(
        string memory contractName,
        address contractAddress
    ) internal {
        ContractRegistry.saveContract(vm, contractName, contractAddress);
    }

    struct Config {
        address ctf;
        address finder;
        address oo;
    }

    function _getConfig() internal view returns (Config memory cfg) {
        if (block.chainid == 8453) {
            cfg.ctf = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;
            cfg.finder = 0x4408e1c6745B43350711317C89Db35B479992e5C;
            cfg.oo = 0x4408e1c6745B43350711317C89Db35B479992e5C;
        } else if (block.chainid == 84532) {
            cfg.ctf = 0x5608E0FCE82574071dd083B2a644A24bbE8847e7;
            cfg.finder = 0x3320eD5f870Cd895D27cf7A941D395A81C090F44;
            cfg.oo = 0xAB7355A0fD1127a5d2f11651f9bB3e4837B3680d;
        } else {
            revert("Unsupported chain");
        }
    } 
}
