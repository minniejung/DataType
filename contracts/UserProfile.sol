// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

// Solidity 스타일가이드 권장
// contract YourContract {
// 1. events
// 2. errors
// 3. enums
// 4. structs
// 5. state variables
// 6. constructor
// 7. modifiers
// 8. functions
// }

contract UserProfile {
    event UserRegistered(address user, string name, uint age);

    struct User {
        string name;
        uint256 age;
        bool isRegistered;
    }

    mapping(address => User) public users;

    address[] public registeredUsers;

    function registerUser(string memory _name, uint _age) public {
        require(users[msg.sender].isRegistered == false, "Already registered!");
        users[msg.sender] = User(_name, _age, true);
        registeredUsers.push(msg.sender);

        emit UserRegistered(msg.sender, _name, _age);
    }

    function getUserProfile(address _user) public view returns (User memory) {
        return users[_user];
    }

    function isUserRegistered(address _user) public view returns (bool) {
        return users[_user].isRegistered;
    }

    function getAllUserAddresses() public view returns (address[] memory) {
        return registeredUsers;
    }

    function getAllUsers() public view returns (User[] memory) {
        // Solidity에서 new 키워드로 동적 배열을 만들 땐 배열 타입 뒤에 괄호 안에 길이 명시
        // new Type[](length)
        User[] memory allUsers = new User[](registeredUsers.length);
        for (uint i = 0; i < registeredUsers.length; i++) {
            allUsers[i] = users[registeredUsers[i]];
        }
        return allUsers;
    }

    // string, bytes, array, struct → 참조 타입 (reference type) → memory나 calldata 명시 필수
    // uint, int, bool, address → 값 타입 (value type) → 기본적으로 stack에 저장되므로 안 붙여도 됨
    // memory 수정가능? 변수재할당 가능, struct내부 필드 수정 가능, 배열 요소수정 가능, 변수자체가 calldata 에서 왔을 땐 수정불가
    function updateUser(string memory _name, uint _age) public {
        require(users[msg.sender].isRegistered == true, "Not registered!");
        users[msg.sender] = User(_name, _age, true);
    }
}
