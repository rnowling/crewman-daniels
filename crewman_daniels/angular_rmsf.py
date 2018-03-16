"""
Copyright 2018 Ronald J. Nowling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

import argparse
import os

import matplotlib
matplotlib.use("PDF")
import matplotlib.pyplot as plt
import mdtraj as md
import numpy as np

def plot_rmsf(args):
    print "reading trajectory"
    traj = md.load(args.input_traj,
                   top=args.pdb_file)

    print "computing dihedrals"
    _, phi_angles = md.compute_phi(traj,
                                   periodic=False)
    _, psi_angles = md.compute_psi(traj,
                                   periodic=False)
    
    # first residue has no phi angle
    # last residue has no psi angle
    # so we only have pairs for residues 1 to n - 2
    angles = np.stack([phi_angles[:, :-1],
                       psi_angles[:, 1:]],
                      axis=2)

    
    print "computing RMSF"
    vectors = np.exp(1.j * angles)
    avg_angle = np.angle(np.mean(vectors, axis=0))

    angle_diff = avg_angle - angles
    rounded_diff = np.arctan2(np.sin(angle_diff),
                              np.cos(angle_diff))
    rmsf = np.sqrt(2 * np.mean(rounded_diff**2, axis=(0, 2)))

    # 1-based indexing
    resids = range(2, rmsf.shape[0] + 2)
    
    if args.figure_fl:
        plt.clf()
        plt.plot(resids,
                 rmsf)
    
        plt.xlabel("Residue", fontsize=16)
        plt.ylabel("RMSF (radians)", fontsize=16)
        plt.ylim([0, np.pi])
        plt.xlim([1, traj.n_residues])
        plt.savefig(args.figure_fl,
                    DPI=300)

    if args.output_tsv:
        with open(args.output_tsv, "w") as fl:
            fl.write("residue_id\tangular_rmsf\n")
            for resid_, rmsf_ in zip(resids, rmsf):
                fl.write("%s\t%s\n" % (resid_, rmsf_))

    
def parseargs():
    parser = argparse.ArgumentParser()

    parser.add_argument("--figure-fl",
                        type=str,
                        help="Figure output file")

    parser.add_argument("--pdb-file",
                        type=str,
                        required=True,
                        help="Input PDB file")

    parser.add_argument("--input-traj",
                        type=str,
                        required=True,
                        help="Input trajectory file")

    parser.add_argument("--output-tsv",
                        type=str,
                        help="Output per-residue RMSF")

    return parser.parse_args()

if __name__ == "__main__":
    args = parseargs()

    plot_rmsf(args)
