function sort_fix_record_undone()
% when doning parameter tuning test, the for loop may by stopped half way
% some test may be missed or duplicated
% the scripts is to deal with the record-hkmean record
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rebuild_flag = 0;
cal = 0;

%% back up the .mat file
% if the testing parameters are related to the build of BOW & INF, 
% then the mat file should be rebuild
% otherwise, the building can be skip - rebuild_flag = 0;

bool_cBOW = 'keep';
switch bool_cBOW
    case 'change'
        rebuild_flag = 1;
    case 'keep'
        rebuild_flag = 0;
end

num_CroV = 5;

% destination of the backup folder
path_backup=fullfile('/home','rips_tc','Desktop','parameter tuning','recordMat_backup');
if(~exist(path_backup,'dir'))
    mkdir(path_backup);
end

%record backup
RECORD_MAT='record_hkmean_return+2U+weight.mat';
[path,name,ext]=fileparts(RECORD_MAT);
WRIRE2MAT_clean= fullfile(path_backup,[name,'_clean',ext]);

WRIRE2MAT_missed= fullfile(path_backup,[name,'_missed',ext]);
% BUILD_MAT = fullfile(path_backup,name,'_build',ext);

if(~exist(fullfile(path_backup,RECORD_MAT),'file'))
    copyfile(RECORD_MAT,path_backup);
end
% load the record data, struct recordData 
recordData=importdata(RECORD_MAT);

%% get the size of the record mat file
% num of parameters = NUM_COLUMN - 2
% the last column is the num_corv and the first column is the accracy of
% each test
% num_rank = the nun of test + 1(head)

NUM_COLUMN = size(recordData.row,2);
NUM_RANK =  size(recordData.row,1);
INDEX= 1:NUM_RANK;
% check_flags = 

%% initialize the INT representation of the record
%--------------------------------------
% check str and float, for each row, sum the parameters by str combination
% use str to build hash table, since that the int is to large 
%--------------------------------------
    record2int.result = recordData.row(2:NUM_RANK,1);

% 1.change the string parameters into num, by mapping 
    str_record = { };
    
% check string parameters
for j = 1:NUM_COLUMN
    flag = 1;
    while(~isnumeric(recordData.row{2,j}) && flag)
        str_record = [recordData.row(2,j);str_record];
        for k = 1:NUM_RANK
            if(~strcmp(recordData.row{2,j},recordData.row{k,j}))
                str_record = [recordData.row{k,j};str_record];
            end
        end
        flag = 0;
    end
end

myKeys = str_record(1:size(str_record,1),1);
myValues = 1:size(str_record,1);
mapObj = containers.Map(myKeys,myValues);
valueSet = values(mapObj);

% the column which is originally all str now represent by num
    for j = 2:NUM_COLUMN
        if(~isnumeric(recordData.row{2,j}))
            KeySet = recordData.row(2:NUM_RANK,j);KeySet = KeySet';
            valueSet = values(mapObj,KeySet);valueSet = valueSet';
            recordData.row(2:NUM_RANK,j)= valueSet;
        end
    end
    
    
% 2. check float - ensure the int representation of the record data do not
% contain . 
for j = 2:NUM_COLUMN
    if((recordData.row{2,j})<1)
        temp_col = recordData.row(2:NUM_RANK,j);
        temp_col_ = cellfun(@(x) uint8(x*100),temp_col,'un',0);
        recordData.row(2:NUM_RANK,j) = temp_col_;
    end
end


record2int.para = num2cell(zeros(NUM_RANK-1,1));% the first row is 0
record2int.para_only = num2cell(zeros(NUM_RANK-1,1));

% combine all parameters: column 2 to NUM_COLUMN-1
for j = 2:NUM_COLUMN-1
        temp_col = recordData.row(2:NUM_RANK,j);
%             temp_col_ = cellfun(@(x) x*(100)^(NUM_COLUMN-j),temp_col,'un',0);
        temp_col = cellfun(@(x) num2str(x),temp_col,'un',0);
        record2int.para_only = cellfun(@(x) num2str(x),record2int.para_only,'un',0);
        record2int.para_only = cellfun(@(x,y) [y,x],temp_col,record2int.para_only,'un',0);
        % un defeault 1 -then output is double not cell
end

% combine all parameters plus the num_crov: column 2 to NUM_COLUMN
for j = 2:NUM_COLUMN
        temp_col = recordData.row(2:NUM_RANK,j);
        temp_col = cellfun(@(x) num2str(x),temp_col,'un',0);
        record2int.para = cellfun(@(x) num2str(x),record2int.para,'un',0);
        record2int.para = cellfun(@(x,y) [y,x],temp_col,record2int.para,'un',0);
        % un defeault 1 -then output is double not cell
end    
%     temp = recordData.row(2:NUM_RANK,NUM_COLUMN);
%     record2int.crov = cellfun(@sum,temp);
        record2int.crov = recordData.row(2:NUM_RANK,NUM_COLUMN);
        
%% check2 whether the two TEST have the same parameters:
%--------------------------------------
% struct record_clean {result,comp_flag,ave_result}
% struct record2int {para_only,para,crov}
%   members in record_clean and record2int have same num of rank, 
%   1 less than record data
%------------------------------------- 
    labels = record2int.para_only;
    [para_set,index_set,ic] = unique(labels,'stable');
    NUM_crovtest = size(para_set,1);
    record_clean.result = cell(NUM_crovtest,1);
    record_clean.comp_flag = zeros(NUM_crovtest,1);
    record_clean.ave_result = zeros(NUM_crovtest,1);
    
    for i = 1: NUM_crovtest
        
         index_same_para = [];
         retest_ncrov = [];
         
%     find index of the test which have the same parameters setting
%     if ith ic value = jth ic value, then i and j have the same parameters
%     setting
        for j = 1:size(ic,1)
            if(ic(j)) == i
                index_same_para = [j;index_same_para];
            end
        end
%     find the result for cross vaildation 1 to 5 of the ith test
        complete_flag = 0;
        re_itest = zeros(1,num_CroV);
            
%  check for esch test having the same parameters setting, 
%  find crov 1 to 5           
        for ncrov = 1:num_CroV
            k = 1;
            found_flag = 0;
            
        % find the corresponf record of ncorv(1 to 5)
        % add the result to the list    
            while(k<=size(index_same_para,1) && flag)
           
            if(record2int.crov{index_same_para(k)} == ncrov)
                re_itest(ncrov) = record2int.result{index_same_para(k)};
                found_flag = 1; 
            end
            k = k+1;
            end
            
        % for the unfound num_corv, record the ncrov to
        % retres_crov and pass to retest function
            if(~found_flag)
                retest_ncrov= [ncrov,retest_ncrov];
            end
        end   
% check done
% -------------------------------------
        record_clean.result{i}= num2cell(re_itest);
        
            if(nnz(re_itest)==5)
                complete_flag = 1;
            else
                complete_flag = 0;
            end
            
            disp(re_itest);
            disp(retest_ncrov);
            
            record_clean.comp_flag(i) = complete_flag;
            % with this index, can find the corresponding parameters
            index_orig = index_same_para(1)+1;            
            if(complete_flag)
                accuracy = mean(re_itest);
                record_clean.ave_result(i) = accuracy;
%                 fix_2record(index_orig,RECORD_MAT,accuracy)
            else
                cal = cal+1;
                fix_test(index_orig,retest_ncrov,rebuild_flag,RECORD_MAT);
                
            end
            
            
    end
    disp(cal);
    save(WRIRE2MAT_clean,'record_clean');
end
%     save(BUILD_MAT,record_build);