// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.13;

import "./ATruhuisInspector.sol";

/**
 * @title TruhuisInspector
 * @author vsevdrob
 * @notice _
 */
contract TruhuisInspector is ATruhuisInspector {
    constructor(address _addressRegistry) ATruhuisInspector(_addressRegistry) {}

    /// @inheritdoc ITruhuisInspector
    function carryOutStructuralInspection(uint256 _purchaseAgreementId)
        external
        onlyOwner
    {
        _carryOutStructuralInspection(_purchaseAgreementId);
    }
}
