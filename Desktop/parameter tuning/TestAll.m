% addpath(genpath(pwd));

% NumReturn2U = [5,7]
% cluster_method = 'hkmeans';


% num_wordsList = [5000,1000,10000];
% num_iterationsList = [10,30,20];
% num_treesList = [3,2];
% for j = 2:10
% for num_w = 1:3
%     num_words = num_wordsList(num_w);
%     for num_i = 1:3
%         num_iterations = num_iterationsList(num_i);
%         for num_t = 1:2
%             num_trees = num_treesList(num_t);
%                 indexOfCroV = j;
%                 parametersSummary(indexOfCroV,cluster_method,num_words,num_iterations,num_trees);
%             %     parametersSummary(indexOfCroV,num_levels,num_branches,NumReturn,NumReturn2U);
%                 delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
%                 delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
%             end
%         end
%     end
% end
% 
% %% test 0713
% % num_branchesList = [15]; num_levelsList = [5];
% % num_iterationsList = [20];
% % NumReturnList = [15];NumReturn2UList = [4];
% 
% % NumReturn = 15;
% % NumReturn2U = 4;
% % num_iterations = 20;
% % num_branches = 17;
% % num_levels = 6;
% % weight_GV = 0.8;
% % for j = 4
% %             indexOfCroV = j;
% %             parametersSummary(indexOfCroV,num_iterations,num_branches,num_levels,NumReturn,NumReturn2U,weight_GV);
% %             delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
% %             delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
% %  end
%     
% NumReturn = 15;
% NumReturn2U = 4;
% num_iterations = 20;
% num_branchesList = [14,15,17];
% num_levelsList = [4,5,6];
% weight_GV = 0.8;
% 
% for j = 1:5
% %     for i_weight_GV = 1:size(weight_GVList,2)
% %         fprintf('weight_GV %d',i_weight_GV);
% %         weight_GV = weight_GVList(i_weight_GV);
% 
% %             for i_NumReturn = 1:size(NumReturnList,2)
% %                 NumReturn = NumReturnList(i_NumReturn);
% %                 for i_NumReturn2U = 1:size(NumReturn2UList,2)
% %                     NumReturn2U = NumReturn2UList(i_NumReturn2U);
% 
% %                   for i_num_iterations = 1:size(num_iterationsList,2)
% %                       num_iterations = num_iterationsList(i_num_iterations);
% 
%                         for i_num_branches = 1:size(num_branchesList,2)
%                             fprintf('num branch %d',i_num_branches);
%                             num_branches = num_branchesList(i_num_branches);
%                             for i_num_levels = 1: size(num_levelsList,2)
%                                 fprintf('num levels %d',i_num_levels);
%                                 num_levels = num_levelsList(i_num_levels);
% 
%                                         indexOfCroV = j;
%                                         parametersSummary(indexOfCroV,num_iterations,num_branches,num_levels,NumReturn,NumReturn2U,weight_GV);
%                                         delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
%                                         delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
%                              end
%                          end
% %                     end
% %                 end
% %             end
% %     end
% end

% num_branchesList = [15]; num_levelsList = [5];
% num_iterationsList = [20];
% NumReturnList = [15];NumReturn2UList = [4];


%% test 2:
NumReturn2UList = [4,5,3,6];
NumReturnList = [15,10,20,25];
num_iterations = 18;

num_levels = 5;
num_branches = 17;

weight_GVList = [0.8,0.7,0.9];

for j = 5
     for i_weight_GV = 1:size(weight_GVList,2)
         
         fprintf('weight_GV %d',i_weight_GV);
         weight_GV = weight_GVList(i_weight_GV);

            for i_NumReturn = 1:size(NumReturnList,2)
                fprintf('i_NumReturn %d',i_NumReturn);
                NumReturn = NumReturnList(i_NumReturn);
                parfor i_NumReturn2U = 1:size(NumReturn2UList,2)
%                     for i_NumReturn2U = 4
                    fprintf('i_NumReturn2U %d',i_NumReturn2U);
                    NumReturn2U = NumReturn2UList(i_NumReturn2U);
                    index_for_parfor = i_NumReturn2U;
%                   for i_num_iterations = 1:size(num_iterationsList,2)
%                       num_iterations = num_iterationsList(i_num_iterations);

%                         for i_num_branches = 1:size(num_branchesList,2)
%                             fprintf('num branch %d',i_num_branches);
%                             num_branches = num_branchesList(i_num_branches);
% %                             for i_num_levels = 1: size(num_levelsList,2)
% %                                 fprintf('num levels %d',i_num_levels);
%                                 num_levels = 18;

%                                         indexOfCroV = j;
                                        parametersSummary(index_for_parfor,j,num_iterations,num_branches,num_levels,NumReturn,NumReturn2U,weight_GV);
%                                         delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
%                                         delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
%                              end
%                          end
%                     end
                end
            end
    end
end
%% test3
% num_branches = 15;
% num_levels = 5;
% num_iterations = [20,10,25,30,40];
% NumReturn = 15;
% NumReturn2U = 4;
% weight_GVList = 0.8;
% 
% for j = 1:5
% %     for i_weight_GV = 1:size(weight_GVList,2)
% %         fprintf('weight_GV %d',i_weight_GV);
% %         weight_GV = weight_GVList(i_weight_GV);
% 
% %             for i_NumReturn = 1:size(NumReturnList,2)
% %                 NumReturn = NumReturnList(i_NumReturn);
% %                 for i_NumReturn2U = 1:size(NumReturn2UList,2)
% %                     NumReturn2U = NumReturn2UList(i_NumReturn2U);
% 
%                   for i_num_iterations = 1:size(num_iterationsList,2)
%                       fprintf('num_iteration %d',i_num_iterations);
%                       num_iterations = num_iterationsList(i_num_iterations);
% 
% %                         for i_num_branches = 1:size(num_branchesList,2)
% %                             num_branches = num_branchesList(i_num_branches);
% %                             for i_num_levels = 1: size(num_levelsList,2)
% %                                 num_levels = num_levelsList(i_num_levels);
%                                         indexOfCroV = j;
%                                         parametersSummary(indexOfCroV,num_iterations,num_branches,num_levels,NumReturn,NumReturn2U,weight_GV);
%                                         delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
%                                         delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
% %                              end
% %                          end
% %                     end
% %                 end
% %             end
%     end
% end


% 
% if_distList = {'l1','l2','ham','cos','jac'};
% if_normList = {'none','l0','l1','l2'};
% if_weightList = {'none','bin','tf','tfidf'};
% for j = 9:10
%     for num_if_dist = 1
%         if_dist = if_distList{num_if_dist};
%         for num_if_norm = 3
%             if_norm = if_normList{num_if_norm};
%             for num_i = 1:4
%                 num_iterations = num_iterationsList(num_i);
%                 for num_if_weight = 4
%                     if_weight = if_weightList{num_if_weight};
%                         indexOfCroV = j;
%                         parametersSummary(indexOfCroV,num_iterations,if_weight,if_norm,if_dist);
%                         delete(fullfile(['words_TRAIN_CroV',num2str(j),'.mat']));
%                         delete(fullfile(['indexf_CroV',num2str(j),'.mat']));    
%                 end
%             end
%         end
%     end
% end