// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// A contract setup to manage student information between two different schools by one central admin.

contract school {
    string public schoolName;

    constructor(string memory _name) {
        schoolName = _name;
    }

    function getSchoolName() public view returns (string memory) {
        return schoolName;
    }
}

contract WTC is school {
     struct Student {
        string name;
        uint standard;
    }

    mapping(uint => Student) public students;

    constructor(string memory _schoolName) school(_schoolName) {
        
    }

    function addStudent(uint _id, string calldata _name, uint _standard) public {
        students[_id] = Student(_name, _standard );
    }

    function getStudent(uint _id) public view returns (string memory, uint ) {
        Student memory s = students[_id];
        return (s.name, s.standard );
    }
}

contract ABC is school {
     struct Student {
        string name;
        string level;
        
    }

    mapping(uint => Student) public students;

    constructor(string memory _schoolName) school(_schoolName) {
        
    }

    function addStudent(uint _id, string calldata _name, string calldata _level) public {
        students[_id] = Student(_name , _level);
    }

    function getStudent(uint _id) public view returns (string memory, string memory) {
        Student memory s = students[_id];
        return (s.name, s.level);
    }
}

contract AdminControl {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        admin = _newAdmin;
    }
}

// link both schools together where the admin can add students to either school

contract is ABC,WTC,AdminControl{

    constructor(string _schoolName)
        ABC(_schoolName)
        WTC(_schoolName)
        AdminControl(){
    }


    function getFullABCDetails(uint _id) public view returns(string memory name, string memory standard, string memory school, address admin) {
        return getABCDetails(_id);
    }

    function getFullWTCDetails(uint _id) public view returns(string memory name, uint256 level, string memory school, address admin) {
        return getWTCDetails(_id);
    }

}




