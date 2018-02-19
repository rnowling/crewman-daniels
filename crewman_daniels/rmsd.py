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
from collections import Counter
import os
import sys

import matplotlib
matplotlib.use("PDF")
import matplotlib.pyplot as plt
import mdtraj as md
import numpy as np

def plot_rmsd(args):
    if not args.figure_fl and not args.output_tsv:
        raise Exception("No output specified.")

    print "reading trajectory"
    traj = md.load(args.input_traj,
                   top=args.pdb_file)

    print "aligning frames"
    if args.align_atom_select in ["all", "alpha", "minimal", "heavy", "water"]:
        align_atoms = traj.topology.select_atom_indices(args.align_atom_select)
    else:
        align_atoms = traj.topology.select(args.align_atom_select)
        
    traj.superpose(traj, atom_indices=align_atoms)

    print "computing RMSD"
    if args.rmsd_atom_select in ["all", "alpha", "minimal", "heavy", "water"]:
        rmsd_atoms = traj.topology.select_atom_indices(args.rmsd_atom_select)
    else:
        rmsd_atoms = traj.topology.select(args.rmsd_atom_select)

    rmsds = md.rmsd(traj,
                    traj,
                    atom_indices=rmsd_atoms,
                    ref_atom_indices=rmsd_atoms)

    frame_time = np.arange(1, traj.n_frames + 1) * args.timestep
    if args.figure_fl:
        plt.clf()
        plt.plot(frame_time, rmsds)
        plt.xlabel("Time (ns)", fontsize=16)
        plt.ylabel("RMSD (nm)", fontsize=16)
        plt.xlim([0, traj.n_frames + 2])
        plt.grid()
        plt.savefig(args.figure_fl,
                    DPI=300)

    if args.output_tsv:
        with open(args.output_tsv, "w") as fl:
            fl.write("Time (ns)\tRMSD (nm)\n")
            for t, r in zip(frame_time, rmsds):
                fl.write("%s\t%s\n" % (t, r))
    
def parseargs():
    parser = argparse.ArgumentParser()

    parser.add_argument("--figure-fl",
                        type=str,
                        help="Plot RMSD and save to this file")

    parser.add_argument("--output-tsv",
                        type=str,
                        help="Save RMSD data to TSV file")

    parser.add_argument("--timestep",
                        type=float,
                        required=True,
                        help="Elapsed time between frames in ns")

    parser.add_argument("--pdb-file",
                        type=str,
                        required=True,
                        help="Input PDB file")

    parser.add_argument("--input-traj",
                        type=str,
                        required=True,
                        help="Input trajectory file")

    parser.add_argument("--align-atom-select",
                        type=str,
                        default="minimal",
                        help="String for selecting atoms for aligning frames")

    parser.add_argument("--rmsd-atom-select",
                        type=str,
                        default="minimal",
                        help="String for selecting atoms to calculate RMSD on")

    return parser.parse_args()

if __name__ == "__main__":
    args = parseargs()

    plot_rmsd(args)
