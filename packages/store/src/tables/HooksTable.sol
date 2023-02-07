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
import { AddressArray, AddressArray_ } from "../schemas/AddressArray.sol";

// -- User defined schema and tableId --
bytes32 constant tableId = keccak256("mud.store.table.hooks");

// -- Autogenerated library to interact with tables with this schema --
// TODO: autogenerate

library HooksTable {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema schema) {
    return AddressArray_.getSchema();
  }

  /** Register the table's schema */
  function registerSchema() internal {
    AddressArray_.registerSchema(tableId);
  }

  function registerSchema(IStore store) internal {
    AddressArray_.registerSchema(tableId, store);
  }

  /** Set the table's data */
  function set(bytes32 key, address[] memory addresses) internal {
    AddressArray_.set(tableId, key, addresses);
  }

  /**
   * Push an element to the addresses array
   */
  function push(bytes32 key, address callback) internal {
    AddressArray_.push(tableId, key, callback);
  }

  /** Get the table's data */
  function get(bytes32 key) internal view returns (address[] memory addresses) {
    return AddressArray_.get(tableId, key);
  }

  function get(IStore store, bytes32 key) internal view returns (address[] memory addresses) {
    return AddressArray_.get(tableId, store, key);
  }
}
