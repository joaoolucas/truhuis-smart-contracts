// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.13;

import "forge-std/Test.sol";
import "@core/address/TruhuisAddressRegistry.sol";
import "@core/appraiser/TruhuisAppraiser.sol";
import "@core/bank/TruhuisBank.sol";
import "@core/cadastre/TruhuisCadastre.sol";
import "@core/currency/TruhuisCurrencyRegistry.sol";
import "@core/inspector/TruhuisInspector.sol";
import "@core/notary/TruhuisNotary.sol";
import "@core/state/Municipality.sol";
import "@core/state/PersonalRecordsDatabase.sol";
import "@core/state/TaxAdministration.sol";
import "@core/trade/TruhuisTrade.sol";
import "@mocks/MockERC20EURT.sol";
import "@interfaces/IPersonalRecordsDatabase.sol";
import "@interfaces/IPurchaseAgreement.sol";

/**
 * @title Conftest
 * @author vsevdrob
 * @notice Configurations for tests.
 */
contract Conftest is Test {
    // Truhuis account.
    address public truhuis;
    // Sellers accounts.
    address public alice = address(0x1);
    address public bob = address(0x2);
    address public charlie = address(0x3);
    // Buyers accounts.
    address public dave = address(0x4);
    address public eve = address(0x5);
    address public ferdie = address(0x6);

    // Truhuis contracts as well as state and currency contracts.
    TruhuisAddressRegistry public addressRegistry;
    TruhuisAppraiser public appraiser;
    TruhuisBank public bank;
    TruhuisCadastre public cadastre;
    TruhuisCurrencyRegistry public currencyRegistry;
    TruhuisInspector public inspector;
    TruhuisNotary public notary;
    MockERC20EURT public mockERC20EURT;
    Municipality public municipalityA;
    Municipality public municipalityR;
    Municipality public municipalityH;
    PersonalRecordsDatabase public personalRecordsDatabase;
    TaxAdministration public taxAdministration;
    TruhuisTrade public trade;

    bytes4 public constant AMSTERDAM = bytes4("0363");
    bytes4 public constant ROTTERDAM = bytes4("0599");
    bytes4 public constant THE_HAGUE = bytes4("0518");

    /// @dev Identifier for Truhuis Address Registry smart contract.
    bytes32 public constant ADDRESS_REGISTRY = "ADDRESS_REGISTRY";
    /// @dev Identifier for Truhuis Appraiser smart contract.
    bytes32 public constant APPRAISER = "APPRAISER";
    /// @dev Identifier for Truhuis Bank smart contract.
    bytes32 public constant BANK = "BANK";
    /// @dev Identifier for Truhuis Cadastre smart contract.
    bytes32 public constant CADASTRE = "CADASTRE";
    /// @dev Identifier for Truhuis Currency Registry smart contract.
    bytes32 public constant CURRENCY_REGISTRY = "CURRENCY_REGISTRY";
    /// @dev Identifier for Truhuis Inspector smart contract.
    bytes32 public constant INSPECTOR = "INSPECTOR";
    /// @dev Identifier for Truhuis Notary smart contract.
    bytes32 public constant NOTARY = "NOTARY";
    /// @dev Identifier for Personal Records Database smart contract.
    bytes32 public constant PERSONAL_RECORDS_DATABASE =
        "PERSONAL_RECORDS_DATABASE";
    /// @dev Identifier for Chainlink Price Feed smart contract.
    bytes32 public constant PRICE_ORACLE = "PRICE_ORACLE";
    /// @dev Identifier for Tax Administration smart contract.
    bytes32 public constant TAX_ADMINISTRATION = "TAX_ADMINISTRATION";
    /// @dev Identifier for Truhuis Trade smart contract.
    bytes32 public constant TRADE = "TRADE";

    constructor() {
        truhuis = msg.sender;
    }

    function _deploy() internal {
        addressRegistry = new TruhuisAddressRegistry();
        appraiser = new TruhuisAppraiser(address(addressRegistry));
        bank = new TruhuisBank(address(addressRegistry));
        cadastre = new TruhuisCadastre(
            address(addressRegistry),
            "Truhuis Cadastre"
        );
        currencyRegistry = new TruhuisCurrencyRegistry();
        inspector = new TruhuisInspector(address(addressRegistry));
        notary = new TruhuisNotary(address(addressRegistry));
        mockERC20EURT = new MockERC20EURT(truhuis, 1 * 1000000 * 1000000);
        municipalityA = new Municipality(AMSTERDAM);
        municipalityR = new Municipality(ROTTERDAM);
        municipalityH = new Municipality(THE_HAGUE);
        personalRecordsDatabase = new PersonalRecordsDatabase(
            address(addressRegistry)
        );
        taxAdministration = new TaxAdministration();
        trade = new TruhuisTrade(address(addressRegistry), 50);

        _refuelAccountsERC20();
    }

    function _refuelAccountsERC20() private {
        // Send EURT to the accounts.
        vm.startPrank(truhuis);
        mockERC20EURT.transfer(alice, 10000000);
        mockERC20EURT.transfer(bob, 10000000);
        mockERC20EURT.transfer(charlie, 10000000);
        mockERC20EURT.transfer(dave, 10000000);
        mockERC20EURT.transfer(eve, 10000000);
        mockERC20EURT.transfer(ferdie, 10000000);
        vm.stopPrank();
    }
}
