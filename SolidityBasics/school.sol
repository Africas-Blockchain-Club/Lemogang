// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
        uint Gradelevel;
    }

    mapping(uint => Student) public students;

    constructor(string memory _schoolName) school(_schoolName) {
        
    }

    function addStudent(uint _id, string calldata _name, uint _Gradelevel) public {
        students[_id] = Student(_name, _Gradelevel );
    }

    function getStudent(uint _id) public view returns (string memory, uint ) {
        Student memory s = students[_id];
        return (s.name, s.Gradelevel );
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




