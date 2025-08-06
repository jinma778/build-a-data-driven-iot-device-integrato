Solidity

/**
 * @title Build a Data-Driven IoT Device Integrator
 * @author [Your Name]
 * @notice This contract integrates IoT devices and handles data processing 
 *          and storage on the blockchain
 */

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract IoTDeviceIntegrator {

    // Mapping of IoT devices to their respective data
    mapping (address => IoTDevice) public devices;

    // Structure to hold IoT device data
    struct IoTDevice {
        string deviceID;
        string deviceType;
        uint[] sensorData;
        uint timestamp;
    }

    // Event emitted when a new IoT device is registered
    event NewDeviceRegistered (address indexed _deviceAddress, string _deviceID, string _deviceType);

    // Event emitted when IoT device data is updated
    event DeviceDataUpdated (address indexed _deviceAddress, uint[] _sensorData, uint _timestamp);

    /**
     * @notice Register a new IoT device
     * @param _deviceID Unique ID of the IoT device
     * @param _deviceType Type of the IoT device (e.g. temperature sensor, humidity sensor)
     */
    function registerDevice(string memory _deviceID, string memory _deviceType) public {
        devices[msg.sender] = IoTDevice(_deviceID, _deviceType, new uint[](0), block.timestamp);
        emit NewDeviceRegistered(msg.sender, _deviceID, _deviceType);
    }

    /**
     * @notice Update IoT device data
     * @param _sensorData Array of sensor readings
     */
    function updateDeviceData(uint[] memory _sensorData) public {
        IoTDevice storage device = devices[msg.sender];
        device.sensorData = _sensorData;
        device.timestamp = block.timestamp;
        emit DeviceDataUpdated(msg.sender, _sensorData, block.timestamp);
    }

    /**
     * @notice Get IoT device data
     * @return Array of sensor readings and timestamp
     */
    function getDeviceData() public view returns (uint[] memory, uint) {
        IoTDevice storage device = devices[msg.sender];
        return (device.sensorData, device.timestamp);
    }
}