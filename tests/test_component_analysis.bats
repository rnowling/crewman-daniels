#!/usr/bin/env bats

load setup_helper

@test "Run component-analysis with no arguments" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis
    [ "$status" -eq 2 ]
}

@test "Run component-analysis with --help option" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis --help
    [ "$status" -eq 0 ]
}

@test "component-analysis: Train PCA model, dihedrals" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model PCA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]

    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train PCA model, dihedrals, residues 2-4" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 4 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model PCA \
        --lag-time 1 \
        --select-residues 2-4 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]

    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train PCA model, dihedrals + chi" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals-chi \
        --model PCA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/pca_dihedrals_chi.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals_chi.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train PCA model, residue-residue distances" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 2 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type residue-residue-distances \
        --model PCA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_res-res-dist.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/pca_res-res-dist.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/pca_res-res-dist.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_res-res-dist.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 \
        --model-file ${TEST_TEMP_DIRNAME}/pca_res-res-dist.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1.png" ]
}

@test "component-analysis: Train SVD model, dihedrals" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model SVD \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/svd_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals.pkl
    
    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train SVD model, dihedrals + chi" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals-chi \
        --model SVD \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/svd_dihedrals_chi.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        explained-variance-analysis \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals_chi.pkl \
        --figures-dir ${TEST_TEMP_DIRNAME}

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/explained_variance_ratios.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/svd_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train ICA model, dihedrals" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model ICA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/ica_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train ICA model, dihedrals + chi" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals-chi \
        --model ICA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/ica_dihedrals_chi.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/ica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train tICA model, dihedrals" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 10 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model tICA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        timescale-analysis \
        --timestep 0.01 \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/timescales.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train tICA model, dihedrals, residues 2-4" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 4 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type transformed-dihedrals \
        --model tICA \
        --lag-time 1 \
        --select-residues 2-4 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        timescale-analysis \
        --timestep 0.01 \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/timescales.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train tICA model, dihedrals + chi" {
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
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        timescale-analysis \
        --timestep 0.01 \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/timescales.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_2_3.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 2 3 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_dihedrals_chi.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1_2_3.png" ]
}

@test "component-analysis: Train tICA model, residue-residue-distances" {
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        train-model \
        --n-components 2 \
        --pdb-file ${PDB_FILE} \
        --input-traj ${DCD_FILE} \
        --feature-type residue-residue-distances \
        --model tICA \
        --lag-time 1 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_res-res-dist.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/tica_res-res-dist.pkl" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        timescale-analysis \
        --timestep 0.01 \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --model-file ${TEST_TEMP_DIRNAME}/tica_res-res-dist.pkl

    [ "$status" -eq 0 ]
    [ -e "${TEST_TEMP_DIRNAME}/timescales.png" ]
    
    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projections \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --pairs 0 1 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_res-res-dist.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/component_projection_0_1.png" ]

    run ${BATS_TEST_DIRNAME}/../bin/component-analysis \
        plot-projected-timeseries \
        --figures-dir ${TEST_TEMP_DIRNAME} \
        --dimensions 0 1 \
        --model-file ${TEST_TEMP_DIRNAME}/tica_res-res-dist.pkl

    [ "$status" -eq 0 ]    
    [ -e "${TEST_TEMP_DIRNAME}/projected_timeseries_0_1.png" ]
}
