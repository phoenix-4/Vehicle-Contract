pragma solidity ^0.4.17;

contract VehicleFactory {
    
	address[] public deployedVehicles;
	mapping(string => bool) private registrationLog;

	function createVehicle(string regNumber) public {
	    require(!registrationLog[regNumber]);
		address newVehicle = new Vehicle(regNumber, msg.sender);
		registrationLog[regNumber] = true;
		deployedVehicles.push(newVehicle);
	}
	
	function getDeployedVehicles() public view returns(address[]) {
		return deployedVehicles;
	}
}

contract Vehicle {
    
    struct Ownership {
		string Owner;
		string Address;
		string NIC;
		string Email;
		string Telephone;
		string Date;
	}
	
	struct ChassisN {
	    string chassis;
	    string date;
	}
	
	struct Engine {
	    string engine;
	    string date;
	}
	
	struct Colours {
	    string colour;
	    string date;
	}
	
    Ownership[] public ownerships;
    ChassisN[] public chassisNumbers;
    Engine[] public engineNumbers;
    Colours[] public colours;
    
    string public owner;
    string public nic;
    string public Raddress;
    string public engine;
    string public chassis;
    string public colour;
    string public provincialCouncil;
    address public manager;
    string public registrationNumber;
    
    

    modifier restricted() {
		require(msg.sender == manager);
		_;
	}

    function Vehicle(string regNumber, address vehicleCreator) public {
		manager = vehicleCreator;
		registrationNumber = regNumber;
		
	}
	
	function createOwner(string Owner, string Address, string NIC, string Email, string Telephone, string Date) public restricted {
		owner = Owner;
		nic = NIC;
		Raddress = Address;
		Ownership memory newOwner = Ownership({
			Owner: Owner,
			Address: Address,
			NIC: NIC,
			Email: Email,
			Telephone: Telephone,
			Date: Date
		});
		ownerships.push(newOwner);
	}
	
    function setProvincialCouncil(string province) public restricted {
        provincialCouncil = province;
    }
    
    function setchassisNumber(string chassisN, string date) public restricted {
        chassis = chassisN;
        ChassisN memory newChassis = ChassisN({
            chassis: chassisN,
            date: date
        });
        chassisNumbers.push(newChassis);
    }
    
    function setengineNumber(string engineN, string date) public restricted {
        engine = engineN;
        Engine memory newEngine = Engine({
            engine: engineN,
            date: date
        });
        engineNumbers.push(newEngine);
    }
    
    function setColour(string colourN, string date) public restricted {
        colour = colourN;
        Colours memory newColour = Colours({
            colour: colourN,
            date: date
        });
        colours.push(newColour);
    }
	
}