// SPDX-Licence-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ITruhuisCadastre is IERC721 {
    /// @dev Reverted if caller is not NFT owner.
    error CALLER_NOT_NFT_OWNER();

    /// @dev Reverted if caller is not permitted to call function.
    error CALLER_NOT_PERMITTED(address caller);
    
    /// @dev Reverted if caller is not NFT owner nor approved.
    error CALLER_NOT_NFT_OWNER_NOR_APPROVED();

    /// @dev Reverted if caller tries to transfer NFT through `transferFrom`,
    ///      `safeTransferFrom` or `safeTransferFrom` function.
    ///
    ///      Instead, use `transferNFTOwnership` function.
    error INACTIVE_FUNCTION();

    /// @dev Event emiited when contract URI is updated.
    event ContractURIUpdated(string contractURI);

    /// @dev Event emitted when token URI is set.
    event TokenURISet(string tokenURI, uint256 tokenId);

    /**
     * @dev _
     */
    function allotTokenURI(string memory _tokenURI, uint256 _tokenId) external;

    /**
     * @dev _
     */
    function confirmTransfer(uint256 _tokenId, uint256 _txId) external;

    /**
     * @dev _
     */
    function pause() external;

    /**
     * @dev _
     */
    function produceNFT(address _to, string memory _tokenURI) external;

    /**
     * @dev _
     */
    function submitTransfer(uint256 _purchaseAgreementId, uint256 _tokenId) external;

    /**
     * @dev _
     */
    function revokeTransferConfirmation(uint256 _tokenId, uint256 _txId)
        external;

    /**
     * @dev _
     */
    function transferNFTOwnership(
        address _from,
        address _to,
        bytes memory _data,
        uint256 _tokenId,
        uint256 _txId
    ) external;

    /**
     * @dev _
     */
    function unpause() external;

    /**
     * @dev _
     */
    function updateContractURI(string memory _contractURI) external;

    /**
     * @dev _
     */
    function exists(uint256 _tokenId) external view returns (bool);

    /**
     * @dev _
     */
    function isNFTOwner(address _account, uint256 _tokenId)
        external
        view
        returns (bool);
}
