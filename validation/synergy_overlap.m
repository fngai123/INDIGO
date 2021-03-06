%Find overlap with other files
function sharedSynergy = synergy_overlap(files)
arguments
    files cell
end

sharedSynergy = cell(length(files));

for i = 1:length(files)
    [synergy_scores_A, synergy_interactions_A] = find_synergy(files{i});
    synergy_interactions_A = string(synergy_interactions_A); 
    
    for j = 1:length(files)  
        if j > i
            [synergy_scores_B, synergy_interactions_B] = find_synergy(files{j});
            synergy_interactions_B = string(synergy_interactions_B); 

            [Lia,Locb] = ismember(synergy_interactions_A, synergy_interactions_B, 'rows','legacy');
            synergy_interactions_A_final = synergy_interactions_A(Lia,:);
            synergy_scores_A_final = synergy_scores_A(Lia);


            Locb = nonzeros(Locb);
            synergy_scores_B_final = synergy_scores_B(Locb);

            drugsShared = synergy_interactions_A_final;
           
            %Write this to an excel file!
            if ~isempty(drugsShared)
                drugsShared_fullnames = get_fullnames(drugsShared);
                output = [cellstr(drugsShared),drugsShared_fullnames, num2cell(synergy_scores_A_final),num2cell(synergy_scores_B_final)];
                sheetName = sprintf('%s_%s', erase(files{i},'.xlsx'),erase(files{j},'.xlsx'));
                writecell(output,'synergy_interactions.xlsx','Sheet',sheetName);
                sharedSynergy{i,j} = output;
            end    
        end
    end
end
end
