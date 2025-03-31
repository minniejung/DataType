// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract DataType {
    address public wallet = 0x0000000000000000000000000000000000000000;
    address public recipient;

    uint public positiveNumber = 100;
    int public negativeNumber = -50;
    bool public isActive = true;
    bytes32 public fixedData = "0xabcdef123456";
    bytes public dynamicData;

    constructor(address _recipient) {
        recipient = _recipient;
    }

    enum State {
        Created,
        Active,
        Inactive
    }

    State public currentState = State.Active;

    function setPositiveNumber(uint _num) public {
        positiveNumber = _num;
    }

    function setNegativeNumber(int _num) public {
        negativeNumber = _num;
    }

    function toggleActive() public {
        isActive = !isActive;
    }

    function setWallet(address _wallet) public {
        wallet = payable(_wallet);
        recipient = _wallet;
    }

    function setFixedData(bytes32 _data) public {
        require(_data.length <= 32, "Data too long");
        fixedData = _data;
    }

    function setDynamicData(bytes memory _data) public {
        dynamicData = _data;
    }

    function getDynamicDataLength() public view returns (uint) {
        return dynamicData.length;
    }

    function getDynamicDataAsString() public view returns (string memory) {
        return string(dynamicData);
    }

    function setState(State _state) public {
        require(uint(_state) <= 2, "Invalid state");
        currentState = _state;
    }

    function getDetails()
        public
        view
        returns (
            uint,
            int,
            bool,
            address,
            address,
            bytes32,
            bytes memory,
            State
        )
    {
        return (
            positiveNumber,
            negativeNumber,
            isActive,
            wallet,
            recipient,
            fixedData,
            dynamicData,
            currentState
        );
    }
}
