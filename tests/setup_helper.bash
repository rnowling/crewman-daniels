setup() {
    export TEST_TEMP_DIRNAME=`mktemp -u --tmpdir crewman-daniels-tests.XXXX`
    mkdir -p ${TEST_TEMP_DIRNAME}

    export PDB_FILE=${BATS_TEST_DIRNAME}/../ala5-simulation-data/model/ala5_ambergb_folded_fixed.pdb
    export DCD_FILE=${BATS_TEST_DIRNAME}/../ala5-simulation-data/simulation_data/ala5_simulation_01.dcd
}

teardown() {
    rm -rf ${TEST_TEMP_DIRNAME}
}
