pragma solidity ^0.5.0;

import "./Roles.sol";

/** Note from GET Protocol team. 
 * Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/access/roles/MinterRole.sol
 * No changes made to the code. This is orginal / stock OZ code. 
 * For questions contact: Kasper Keuenen (kasper at get-protocol.io)
 */

contract MinterRole {
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

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}
