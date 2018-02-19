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


# @test "Calculate likelihood_ratio_test (categories, class probabilities intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept none \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (categories, no intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept none \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (categories, free-parameter intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept free-parameter \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (categories, class probabilities intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept class-probabilities \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (categories, no intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept none \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (categories, free-parameter intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${WORKDIR_PATH} \
#         --intercept free-parameter \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, default arguments)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH}

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, class probabilities intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept none \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, no intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept none \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, free-parameter intercept, adjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept free-parameter \
#         --training-set adjusted-for-unknown

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, class probabilities intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept class-probabilities \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, no intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept none \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }

# @test "Calculate likelihood_ratio_test (counts, free-parameter intercept, unadjusted)" {
#     run ${BATS_TEST_DIRNAME}/../bin/likelihood_ratio_test \
# 	    --workdir ${COUNTS_WORKDIR_PATH} \
#         --intercept free-parameter \
#         --training-set unadjusted

#     [ "$status" -eq 0 ]
#     [ -e "${COUNTS_WORKDIR_PATH}/statistics/snp_likelihood_ratio_tests.tsv" ]
# }
