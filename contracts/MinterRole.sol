pragma solidity ^0.5.0;

import "./Roles.sol";
import "./Ownable.sol";

/** Note from GET Protocol team. 
 * Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/access/roles/MinterRole.sol
 * No changes made to the code. This is orginal / stock OZ code. 
 * For questions contact: Kasper Keuenen (kasper at get-protocol.io)
 */

contract MinterRole is Ownable {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(isMinter(msg.sender), "MinterRole: caller does not have the Minter role");
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    // Change from OZ original: onlyMinter() changed to onlyOwner()
    // Purpose: The should be one admin address that can add and remove minters. 
    function addMinter(address account) public onlyOwner() {
        _addMinter(account);
    }

    // Change. Added the ability for a minter to renounce their minterrole.
    function renounceMinter() public onlyMinter {
        _minters.remove(msg.sender);
        emit MinterRemoved(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    // Change from OZ original: Function is public. onlyOwner() modifier added. 
    // Purpose: GET Protocol admin-address can always remove minter-rights.
    function removeMinter(address account) public onlyOwner() {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}
