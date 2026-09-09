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

contract WTC {
     struct wtcStudentInfo {
        string name;
        uint level;
    }

    mapping(uint => wtcStudentInfo) public wtcStudents;

    function addStudent(uint _id, string calldata _name, uint _level) public {
        // WTC addStudent
        wtcStudents[_id] = wtcStudentInfo(_name, _level );
    }

    function getWtcStudent(uint _id) public view returns (string memory, uint ) {
        wtcStudentInfo memory s = wtcStudents[_id];
        return (s.name, s.level );
    }
}

contract ABC {
     struct abcStudentInfo {
        string name;
        string standard;
        
    }

    mapping(uint => abcStudentInfo) public abcStudents;

    function addStudent(uint _id, string calldata _name, string calldata _standard) public {
        abcStudents[_id] = abcStudentInfo(_name , _standard);
    }

    function getAbcStudent(uint _id) public view returns (string memory, string memory) {
        abcStudentInfo memory s = abcStudents[_id];
        return (s.name, s.standard);
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

contract fullSystem is school, ABC, WTC, AdminControl {

    constructor(string memory _schoolName)
        school(_schoolName)
        AdminControl(){
    }

    function getFullWTCDetails(uint _id) public view returns(string memory name, uint256 level , string memory, address) {
        WTC.wtcStudentInfo memory s = wtcStudents[_id];
        return (s.name, s.level, getSchoolName(), admin); 
    }

    function getFullABCDetails(uint _id) public view returns(string memory name, string memory standard ,string memory, address) {
        ABC.abcStudentInfo memory s = abcStudents[_id]; 
        return (s.name, s.standard , getSchoolName(), admin);  
    }

}
