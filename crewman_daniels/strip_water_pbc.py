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
import sys

import mdtraj as md

def strip_water_pbc(args):
    print "reading trajectory"
    traj = md.load(args.input_traj,
                   top=args.input_pdb)

    print "Centering protein"
    traj.image_molecules(inplace = True)

    top = traj.topology
    atom_indices = top.select("protein")

    print "Removing waters"
    traj.atom_slice(atom_indices,
                    inplace = True)
    
    print "Saving"
    traj.save_dcd(args.output_traj)
    traj[0].save_pdb(args.output_pdb)

    
def parseargs():
    parser = argparse.ArgumentParser()

    parser.add_argument("--input-pdb",
                        type=str,
                        required=True,
                        help="Input PDB file")

    parser.add_argument("--output-pdb",
                        type=str,
                        required=True,
                        help="Output PDB file")
    
    parser.add_argument("--input-traj",
                        type=str,
                        required=True,
                        help="Input trajectory file")

    parser.add_argument("--output-traj",
                        type=str,
                        required=True,
                        help="Output trajectory file")

    return parser.parse_args()

if __name__ == "__main__":
    args = parseargs()

    strip_water_pbc(args)
