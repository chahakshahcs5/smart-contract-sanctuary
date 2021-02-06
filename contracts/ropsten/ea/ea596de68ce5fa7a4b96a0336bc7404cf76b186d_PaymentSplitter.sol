/**
 *Submitted for verification at Etherscan.io on 2021-02-06
*/

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract PaymentSplitter {
    
    function payEth (address payable _beneficiary, address payable _admin, uint256 _originalAmount) public payable {
        _beneficiary.transfer(_originalAmount);
        _admin.transfer(msg.value - _originalAmount);
    }
    
    IERC20 public token;
    
    function payToken (address payable _beneficiary, address payable _admin, address payable _token, uint256 _originalAmount) public payable {
        token = IERC20(_token);
        token.transferFrom(msg.sender, _beneficiary, _originalAmount);
        uint fees = msg.value - _originalAmount;
        token.transferFrom(msg.sender, _admin, fees);
    }
}