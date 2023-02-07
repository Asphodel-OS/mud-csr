// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { console } from "forge-std/console.sol";
import { IStore } from "../IStore.sol";
import { StoreSwitch } from "../StoreSwitch.sol";
import { StoreCore } from "../StoreCore.sol";
import { SchemaType } from "../Types.sol";
import { Bytes } from "../Bytes.sol";
import { Schema, SchemaLib } from "../Schema.sol";
import { PackedCounter, PackedCounterLib } from "../PackedCounter.sol";

// -- User defined schema and tableId --
struct AddressArray {
  address[] addresses;
}

// -- Autogenerated library to interact with tables with this schema --
// TODO: autogenerate

library AddressArray_ {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema schema) {
    schema = SchemaLib.encode(SchemaType.AddressArray);
  }

  /** Register the table's schema */
  function registerSchema(bytes32 tableId) internal {
    StoreSwitch.registerSchema(tableId, getSchema());
  }

  function registerSchema(bytes32 tableId, IStore store) internal {
    store.registerSchema(tableId, getSchema());
  }

  /** Set the table's data */
  function set(
    bytes32 tableId,
    bytes32 key,
    address[] memory addresses
  ) internal {
    bytes memory data = Bytes.from(addresses);
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = key;
    StoreSwitch.setField(tableId, keyTuple, 0, data);
  }

  /**
   * Push an element to the addresses array
   * TODO: this is super inefficient right now, need to add support for pushing to arrays to the store core library to avoid reading/writing the entire array
   */
  function push(
    bytes32 tableId,
    bytes32 key,
    address addr
  ) internal {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = key;
    bytes memory addresses = abi.encodePacked(StoreSwitch.getField(tableId, keyTuple, 0), addr);
    StoreSwitch.setField(tableId, keyTuple, 0, addresses);
  }

  /** Get the table's data */
  function get(bytes32 tableId, bytes32 key) internal view returns (address[] memory addresses) {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = key;
    bytes memory blob = StoreSwitch.getRecord(tableId, keyTuple);
    return decode(blob);
  }

  function get(
    bytes32 tableId,
    IStore store,
    bytes32 key
  ) internal view returns (address[] memory addresses) {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = key;
    bytes memory blob = store.getRecord(tableId, keyTuple);
    return decode(blob);
  }

  function decode(bytes memory blob) internal pure returns (address[] memory addresses) {
    if (blob.length == 0) return new address[](0);
    return Bytes.toAddressArray(Bytes.slice(blob, 32, blob.length - 32));
  }
}
