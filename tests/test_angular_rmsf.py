#!/usr/bin/env bats

load setup_helper

@test "Run angular-rmsf with no arguments" {
    run ${BATS_TEST_DIRNAME}/../bin/angular-rmsf
    [ "$status" -eq 2 ]
}

@test "Run angular-rmsf with --help option" {
    run ${BATS_TEST_DIRNAME}/../bin/angular-rmsf --help
    [ "$status" -eq 0 ]
}

@test "Calculate angular-rmsf (plot)" {
    run ${BATS_TEST_DIRNAME}/../bin/angular-rmsf \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
	    --figure-fl ${TEST_TEMP_DIRNAME}/angular-rmsf.png

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/angular-rmsf.png" ]
}

@test "Calculate angular-rmsf (tsv)" {
    run ${BATS_TEST_DIRNAME}/../bin/angular-rmsf \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
	    --output-tsv ${TEST_TEMP_DIRNAME}/angular-rmsf.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/angular-rmsf.tsv" ]
}
