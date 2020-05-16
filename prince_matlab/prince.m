%% Initialization
clear; close all; clc

%% ========== Part 1: Loading Data ==========

fprintf('Loading Data...\n')

% load from ppi_network
% gene network 8919*8919 
% ppi_network(i, j) == 1 means gene i relates to gene j
load('ppi_network.mat');

% load from g_p_network
% gene phenotype network 8919*5080
% g_p_network(i, j) == 1 means gene i relates to disease j
load('g_p_network.mat');

% load from phenotype_network
% disease phenotype network 5080*5081
% first column ID
% phenotype_network(i, j) == 1 means disease i relates to disease j
load('phenotype_network');

size_p = length(ppi_network(1, :)); %8919
size_d = length(phenotype_network(:, 1)); %5081
 
%% ========== Part 2: Normalize PPI network ==========

fprintf('\nNormalizing PPI network...\n');

S = normalize_ppi(ppi_network, size_p);

% ========== Part 3: Initialize query phenotype with genes ==========

% constant value
alpha = 0.1;
iters = 30;
tests_count = 1;
test_iter = 0;
p_id = 0;

while(test_iter < tests_count)
    % Test cases control
    test_iter = test_iter + 1;
    fprintf('\n----------test%d---------\n', test_iter);
    % input query phenotype id
    p_id = input('\nPlease input phenotype_id:\n');
    
    % enrich Query phenotype
    fprintf('\nEnriching query phenotype with its 5 most similar ones...\n');
    Q = similar_phenotype(p_id, phenotype_network, size_d);
    
    % init PR matrix
    fprintf('\nInitializing Y matrix...\n');
    Y = init_Y(Q, g_p_network, size_p);
    
    % Random Walk with Restart
    fprintf('\nRandom Walk with Restart...\n');
    F = Y;
    F = RWR(Y, S, alpha, iters);
    
    % print top 10 related genes
    fprintf('\nRelated genes(top10):\n');
    [idx, genes, values] = top10genes(F, gene_name);
    for i = 1:10
        fprintf('\n\t[%d]\t%s\t%.6f\n', idx(i), cell2mat(genes(i)), values(i));
    end
end;
