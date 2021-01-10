# Binary Atom Search Optimization for Feature Selection

[![View Binary Atom Search Optimization for Feature Selection on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78531-binary-atom-search-optimization-for-feature-selection)
[![License](https://img.shields.io/badge/license-BSD_3-green.svg)](https://github.com/JingweiToo/Machine-Learning-Toolbox/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/badge/release-1.3-yellow.svg)](https://github.com/JingweiToo/Machine-Learning-Toolbox)

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/797de05c-9609-4d7a-9746-a459cbcd44aa/58c7f789-a9d7-458b-9ee0-e62af4c9ed18/images/1595483603.JPG)


## Introduction
* This toolbox offers a Binary Atom Search Optimization ( BASO )  
* The `Main` file illustrates the example of how BASO can solve the feature selection problem using benchmark data-set. 


## Input
* *`feat`*     : feature vector ( Instances *x* Features )
* *`label`*    : label vector ( Instances *x* 1 )
* *`N`*        : number of atoms
* *`max_Iter`* : maximum number of iterations
* *`alpha`*    : depth weight
* *`beta`*     : multiplier weight


## Output
* *`sFeat`*    : selected features
* *`Sf`*       : selected feature index
* *`Nf`*       : number of selected features
* *`curve`*    : convergence curve


### Example
```code
% Benchmark data set 
load ionosphere.mat;  

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

% Parameter setting
N        = 10; 
max_Iter = 100; 
alpha    = 50; 
beta     = 0.2; 
% Binary Atom Search Optimization
[sFeat,Sf,Nf,curve] = jBASO(feat,label,N,max_Iter,alpha,beta,HO);

% Plot convergence curve
plot(1:max_Iter,curve); 
xlabel('Number of iterations');
ylabel('Fitness Value'); 
title('BASO'); grid on;
```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox


## Cite As
```code
@article{too2020binary,
  title={Binary atom search optimisation approaches for feature selection},
  author={Too, Jingwei and Rahim Abdullah, Abdul},
  journal={Connection Science},
  pages={1--25},
  year={2020},
  publisher={Taylor \& Francis}
}
```

