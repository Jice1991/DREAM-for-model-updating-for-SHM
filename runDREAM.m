% Clear memory and close pool of matlab nodes (cores)   
clear all; clc; warning off
tic
% Which example to run
example = 1; 
global DREAM_dir EXAMPLE_dir CONV_dir
if ispc, slash_dir = '\'; else slash_dir = '/'; end
% Store working directory and subdirectory containing the files needed to run this example
DREAM_dir = pwd; EXAMPLE_dir = [pwd,slash_dir,'example_',num2str(example)]; CONV_dir = [pwd,slash_dir,'diagnostics'];
% Add subdirectory to search path
addpath(EXAMPLE_dir); addpath(CONV_dir); addpath(DREAM_dir);
evalstr = strcat('example_',num2str(example)); eval(evalstr)
ParSet = GenParSet(chain);
toc
%%
% mode shape is more accurate and reliable than MAC.