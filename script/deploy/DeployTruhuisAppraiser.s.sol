// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.13;

import "forge-std/Script.sol";
import "@core/appraiser/TruhuisAppraiser.sol";

contract DeployTruhuisAppraiser is Script {
    function deploy(address _addressRegistry) external {
        vm.startBroadcast();

        new TruhuisAppraiser(_addressRegistry);

        vm.stopBroadcast();
    }
}
