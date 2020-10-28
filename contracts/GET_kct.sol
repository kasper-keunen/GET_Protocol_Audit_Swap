pragma solidity ^0.5.0;

import "./MinterRole.sol";
import "./ERC20Detailed.sol";
import "./ERC20.sol";

contract GET_ERC20 is ERC20, ERC20Detailed, MinterRole {
    constructor (string memory name, string memory symbol, uint8 decimals)
        public
        ERC20Detailed(name, symbol, decimals) { }
 
     /**
     * @dev See `ERC20._mint`.
     * Requirements:
     * - the caller must have the `MinterRole`.
     */
    function mint(address account, uint256 amount) public onlyMinter returns (bool) {
        _mint(account, amount);
        return true;
    }

    /**
     * @dev Destoys `amount` tokens from the caller.
     *
     * See `ERC20._burn`.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

 }

contract GET_kct is GET_ERC20 {
    constructor() public
    GET_ERC20("Guaranteed Entrance Token Klaytn","GET kct",18) { }
}