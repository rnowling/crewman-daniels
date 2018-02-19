#!/usr/bin/env bats

load setup_helper

@test "Run rmsd with no arguments" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd
    [ "$status" -eq 2 ]
}

@test "Run rmsd with --help option" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd --help
    [ "$status" -eq 0 ]
}

@test "Calculate rmsd (plot, defaults)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
	    --figure-fl ${TEST_TEMP_DIRNAME}/rmsd.png

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.png" ]
}

@test "Calculate rmsd (tsv, defaults)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

@test "Calculate rmsd (tsv, align backbone)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --align-atom-select "backbone" \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

@test "Calculate rmsd (tsv, rmsd backbone)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --rmsd-atom-select "backbone" \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

@test "Calculate rmsd (tsv, align alpha)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --align-atom-select "alpha" \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

@test "Calculate rmsd (tsv, rmsd alpha)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --rmsd-atom-select "alpha" \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

@test "Calculate rmsd (tsv, rmsd backbone and resid 2)" {
    run ${BATS_TEST_DIRNAME}/../bin/rmsd \
        --timestep 0.01 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --rmsd-atom-select "backbone and (resid 2 to 4)" \
	    --output-tsv ${TEST_TEMP_DIRNAME}/rmsd.tsv

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/rmsd.tsv" ]
}

