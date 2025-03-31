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

    function setDynamicData(bytes calldata _data) public {
        dynamicData = _data;
    }

    function getDynamicDataLength() public view returns (uint) {
        return dynamicData.length;
    }

    function getDynamicDataAsString() public view returns (string memory) {
        return string(dynamicData);
    }

    function setState(uint _state) public {
        require(_state <= 2, "Invalid state");
        currentState = State(_state);
    }

    function getDetails()
        public
        view
        returns (
            uint _positiveNumber,
            int _negativeNumber,
            bool _isActive,
            address _wallet,
            address _recipient,
            bytes32 _fixedData,
            bytes memory _dynamicData,
            uint _currentState
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
            uint(currentState)
        );
    }
}
