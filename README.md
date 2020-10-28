# GET Protocol Klaytn Swap Contracts
This repository contain the contracts that will facilitate the partial tokenswapping of the Guaranteed Entrance Token (issued by the GET Protocol) between the Ethereum Blockchain and the Klaytn Blockchain.

###  Klaytn x GET - Blockchain Integration
The GET Protocol is an internationally operating ticketing protocol. It's native token, the Guaranteed Entrance Token, is the fuel required for ticketing operations to be included in the global smart ticketing ledger. The protocol is blockchain agnostic. Meaning that it can perform its value adding features for its clients on a wide array of blockchains. The client (generally ticketing companies) decide what blockchain is used to register and settle their business. 

Purpose of contracts: The GET Protocol foundation is an integration partner with Klaytn. In light of this coorperation and request of integrators of the GET Protocol in Korea, there is demand there to be a representation of the GET token on the Klaytn blockchain. As the Etheruem blockchain and Klaytn blockchain have different ledgers, a mechanism is needed to 'move' GET_eth (GET on the Ethereum blocckhain) to GET_kct (GET on the Klaytn blockchain). The contracts in this repostitory serve this purpose.  

**Assets** 

*GET_eth* -> ERC20 token of GET on the Ethereum blokchain. [GET_eth Contract Etherscan](https://etherscan.io/token/0x8a854288a5976036a725879164ca3e91d30c6a1b)   
*GET_kct* -> KCT token of GET on the Klaytn blockchain [WILL BE ADDED](https://scope.klaytn.com/)   

### Completed Audits
 [Audit report of crowdsale contract by Matthew Di Ferrante.](https://github.com/mattdf/audits/tree/master/guts)   
[Audit report of finalized ERC20 GET contract by Slowmist](https://github.com/kasper-keunen/GET_Protocol_Audit_Swap/blob/main/audit_reports/Smart%20Contract%20Security%20Audit%20-%20GET.pdf)  


---

## Swap contracts live on Klaytn Blockchain
[Testnet Swap Contract:](https://baobab.scope.klaytn.com/account/0xed2b243e561f4d9f2b708d2b2b83cf2ae0eb0fbd)
[Mainnet Swap Contract:](https://scope.klaytn.com/account/0xed2b243e561f4d9f2b708d2b2b83cf2ae0eb0fbd?tabId=internalTx)

*Contract verification pending*

Deployer: 0x1ec51aab59bab529f4ae2b78cebd9808a6ecdfaa
Owner: 0x1ec51aab59bab529f4ae2b78cebd9808a6ecdfaa 
Minter: 0x1ec51aab59bab529f4ae2b78cebd9808a6ecdfaa

---

## Klaytn GET partial/continous swap details

#### About GET_eth 
GET_eth was minted in 2017 after a public crowdsale. GET is a regular ERC20 contract with a capped supply. The audit of the crowdsale contract can be found here (conducted by Ethereum Foundation Security developer Matthew Di Ferrante). The minting contract of GET_eth was finalized after the crowdsale. Due to this it is not possible to mint additional GET_eth.


#### About GET_kct
*GET_kct* is  the representation of GET on the Klaytn blockchain (essentially 'wrapped GET' - in a custodial manner). The process of receiving GET_eth custodially and then minting an equal amount of GET_kct is done 'manually' by an address that has been granted 'minter rights' -> a minterrole. 

#### About the Klaytn Blockchain
Klaytn is an EVM compatible blockchain. For more information about Klaytn refer to the following documentation: https://docs.klaytn.com/klaytn. As noted the Klaytn blokchain has the same EVM as Ethereum. Thefefore the contracts in this repository can be interpreted as one would interpret a contract on ethereum (same EVM). 

##### Compiler & Deployment
The Klaytn EVM compiler doesn't support the newest compiler versions of Solidity. Therefore contarcts in this repo will be used the tried and tested 0.5.0 version of Soliidty.  

---

## Overview contracts 
The majority of the contracts used are sourced from the [V.3.0 version of the Open Zeppeling contracts.](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/). The only contracts that have some edited code contain some minor changes is MinterRole.sol. 

#### Ownable.sol
Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/ownership/Ownable.sol. No changes made to the code. Contract module which provides a basic access control mechanism, where there is an account (an owner) that can be granted exclusive access to specific functions.

#### MinterRole.sol
Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/access/roles/MinterRole.sol. Minor changes where made (only allowing the owner to add minters using Ownable.sol). 

#### GET_kct.sol
Standard contract inheriting a set of contracts and constructing/deploying it to the blockchain. This contract is used to deploy the GET_kct token. 

#### Roles.sol
Standard Open Zeppeling contract. Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/access/Roles.sol. No changes have been made to this code. The roles contract is used to manage the storage of the onlyMinter modifier. Allowing the owner to manage what addresses/contracts are allowed to mint kyc_GET tokens on the Klaytn blockchain. 

#### SafeMath.sol
Standard Open Zeppeling contract. Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/math/SafeMath.sol. No changes have been made to this code. The SafeMath contract is used to handle calculation in a manner that prevents overflow errors and other unwanted behviour. It is well known and extremly tried and tested. 

#### ERC20Detailed.sol
Standard Open Zeppeling contract. Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC20/ERC20Detailed.sol. No changes have been made to this code. The ERC20Detailed contract allows for the addition of metadata to the ERC20 standard. 

#### ERC20.sol 
Standard Open Zeppeling contract. Sourced from Open ZeppelinV2.3.0: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC20/ERC20.solNo changes have been made to this code. The ERC20 standard provides a standarization for tokenization. This contract describes all the standard features of the ERC20 standard as is well known in the space.

----

## Roles 
The system has two roles. An owner address (there can only be 1 owner/admin address at any time) and one or more 'minter(s)'. 

#### 1. Owner
The owner address has admin rights over adding and removing minters. As well as managing its own owner status. Only the owner address is able to add minters.

#### 2. Minter
If a address is granted minter rights it is able to mint GET_kct tokens. The amount of tokens a minter can mint is unlimited. There is no limit to the amount of registered minters.  If an address is a minter they are able to remove/revoke their minter-rights. A normal address isn't able to receive minter rights.

## Security Audit Inquiry
To ensure the safety of the partial and continous token swap between GET_eth and GET_kct we would like to have a security audit performed. This audit mainly needs to focus on the "Minterrole.sol" contract. Beyond the management of the minters, there is to audit in these contracts beyond the obvious. 



