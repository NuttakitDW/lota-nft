// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Lota} from "../src/lota.sol";

contract LotaTest is Test {
    Lota public lota;

    function setUp() public {
        lota = new Lota(makeAddr("item"));
    }
}
