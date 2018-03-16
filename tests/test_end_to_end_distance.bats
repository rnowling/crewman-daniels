#!/usr/bin/env bats

load setup_helper

@test "end-to-end-distance (no arguments)" {
    run ${BATS_TEST_DIRNAME}/../bin/end-to-end-distance
    [ "$status" -eq 2 ]
}

@test "end-to-end-distance (--help option)" {
    run ${BATS_TEST_DIRNAME}/../bin/end-to-end-distance --help
    [ "$status" -eq 0 ]
}

@test "end-to-end-distance (defaults)" {
    run ${BATS_TEST_DIRNAME}/../bin/end-to-end-distance \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
	    --figure-fl ${TEST_TEMP_DIRNAME}/end-to-end-distance.png

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/end-to-end-distance.png" ]
}
