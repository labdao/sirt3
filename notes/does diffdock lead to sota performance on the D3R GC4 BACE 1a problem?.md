#sirt3 #experiment 

## question
Does [[diffdock]] lead to [[SOTA]] performance in the [[D3R challenge]] [[D3R GC4]] BACE 1a problem in a [[zero shot learning]] context?

## data / material
* all available [[BACE1]] entries on [[PDB]]
* ligand [[SMILES]] provided in the phase 1a of the problem

## intervention
* run [[diffdock]] against every [[pdb file]] and every [[SMILES]]
* calculate a set of aggregate metrics for each interaction:
	* top 1 [[confidence score]]
	* top 5 [[confidence score]] median
	* top 5 [[confidence score]] mean
	* top 10 [[confidence score]] median
	* top 10 [[confidence score]] mean

## outcome
[[spearman correlation]] of [[pIC50]]

## potential extensions
* calculate vina score 
* calculate [[kendall tau]] score