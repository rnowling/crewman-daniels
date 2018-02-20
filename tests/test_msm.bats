#!/usr/bin/env bats

load setup_helper

@test "Run msm with no arguments" {
    run ${BATS_TEST_DIRNAME}/../bin/msm
    [ "$status" -eq 2 ]
}

@test "Run msm with --help option" {
    run ${BATS_TEST_DIRNAME}/../bin/msm --help
    [ "$status" -eq 0 ]
}

@test "msm: tICA, dihedrals + chi" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals-chi \
        --model tICA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/msm \
        sweep-clusters \
        --dimensions 0 1 2 3 \
        --n-clusters 2 4 6 8 \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/cluster_inertia_0_1_2_3.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/msm \
        sweep-lag-times \
        --figure-fl ${TEST_TEMP_DIRNAME}/msm_lag_times.png \
        --dimensions 0 1 2 3 \
        --n-states 4 \
        --timestep 0.01 \
        --strides 1 5 10 25 50 100 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/msm_lag_times.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/msm \
        train-model \
        --dimensions 0 1 2 3 \
        --n-states 4 \
        --timestep 0.01 \
        --stride 10 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl \
        --msm-model-file ${TEST_TEMP_DIRNAME}/msm.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/msm.pkl" ]

    
    run ${BATS_TEST_DIRNAME}/../bin/msm \
        draw-network \
        --figure-fl ${TEST_TEMP_DIRNAME}/msm_network.png \
        --scale-size equilibrium-populations \
        --msm-model-file ${TEST_TEMP_DIRNAME}/msm.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/msm_network.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/msm \
        draw-fluxes \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --msm-model-file ${TEST_TEMP_DIRNAME}/msm.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/flux_1.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/msm \
        draw-timeseries \
        --figure-fl ${TEST_TEMP_DIRNAME}/msm_timeseries.png \
        --msm-model-file ${TEST_TEMP_DIRNAME}/msm.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/msm_timeseries.png" ]

    # run ${BATS_TEST_DIRNAME}/../bin/msm \
    #     test-state-dihedrals \
    #     --output-dir ${TEST_TEMP_DIRNAME} \
    #     --msm-model-file ${TEST_TEMP_DIRNAME}/msm.pkl \
    #     --pdb-file $PDB_FILE \
    #     --input-traj $DCD_FILE \
    #     --angle-type phi-psi

    # [ "$status" -eq 0 ]  
    # [ -e "${TEST_TEMP_DIRNAME}/state_dihedral_tests_phi-psi_0_1.png" ]
}
