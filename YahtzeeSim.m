% Specify the number of simulations
num_simulations = 1000;
num_simulations0 = num_simulations;
% Initialize the counters
num_0_of_a_kind = 0;
num_2_of_a_kind = 0;
num_3_of_a_kind = 0;
num_4_of_a_kind = 0;
num_5_of_a_kind = 0;
givenarray = cell(6, 6);
for i = 1:6
    for j = 1:6
        givenarray{i,j} = 0;
    end
end

%const
arrTrue = {true,true,true,true,true,true};
for i = 1:num_simulations
    %initialize dice
    dice = {-1,-1,-1,-1,-1}; %array to keep track of dice
    
    keeper = {false,false,false,false,false}; %array to keep track of which rolls are kept
    %ofAkind for each trial

    kind_1 = 0;
    kind_2 = 0;
    kind_3 = 0;
    for k = 1:3 %go through maximum num of trials
        occ = {0,0,0,0,0,0}; %array to keep track of occurence of each number
        for j = 1:5 %replace dice
            if ~keeper{j}
                dice{j} = randi([1,6]);
            end
        end

        for j = 1:5 % update occurence values
            occ{dice{j}} = occ{dice{j}} + 1;
        end

        ofAkind = max(cell2mat(occ)); %max occurence
        %disp(occ);
        %disp(dice);
        %disp(keeper)
        %disp(ofAkind);
        %disp("----");
        if ofAkind == 0
            ofAkind = 1;
        end
        
        if ofAkind > 1 %if of a kind
            mode_dice = find(cell2mat(occ) == ofAkind);
            for j = 1:5
                if dice{j} == mode_dice
                    keeper{j} = true; %lockout dice
                end
            end
        end

        if k == 1
            kind_1 = ofAkind;
        elseif k == 2
            kind_2 = ofAkind;
        elseif k == 3
            kind_3 = ofAkind;
        end

        if(isequal(keeper,arrTrue)) %if all dice are the same, sim ends
            if k == 1
                kind_1 = 5;
            elseif k == 2
                kind_2 = 5;
            elseif k == 3
                kind_3 = 5;
            end
            break;
        end
    end
    %analyse results
    %disp(occ);
    %disp(kind_3);
    if kind_2 <= kind_3 && kind_1 <= kind_2
        if kind_1 == 1
            num_0_of_a_kind = num_0_of_a_kind + 1;
        elseif kind_1 == 2
            num_2_of_a_kind = num_2_of_a_kind + 1;
        elseif kind_1 == 3
            num_3_of_a_kind = num_3_of_a_kind + 1;
        elseif kind_1 == 4
            num_4_of_a_kind = num_4_of_a_kind + 1;
        elseif kind_1 == 5
            num_5_of_a_kind = num_5_of_a_kind + 1;
        end
        %disp(kind_1);
        %disp(kind_2);
        %disp(kind_3);
        givenarray{kind_1,kind_2} = givenarray{kind_1,kind_2} + 1;
        givenarray{kind_2,kind_3} = givenarray{kind_2,kind_3} + 1;
    else
        num_simulations = num_simulations + 1;
    end
end
% Calculate the probabilities
P_0_of_a_kind = num_0_of_a_kind / num_simulations0;
P_2_of_a_kind = num_2_of_a_kind / num_simulations0;
P_3_of_a_kind = num_3_of_a_kind / num_simulations0;
P_4_of_a_kind = num_4_of_a_kind / num_simulations0;
P_5_of_a_kind = num_5_of_a_kind / num_simulations0;
P_2_given_2 = givenarray{2,2} / (givenarray{2,2} + givenarray{2,3} + givenarray{2,4} + givenarray{2,5});
P_3_given_2 = givenarray{2,3} / (givenarray{2,2} + givenarray{2,3} + givenarray{2,4} + givenarray{2,5});
P_4_given_2 = givenarray{2,4} / (givenarray{2,2} + givenarray{2,3} + givenarray{2,4} + givenarray{2,5});
P_5_given_2 = givenarray{2,5} / (givenarray{2,2} + givenarray{2,3} + givenarray{2,4} + givenarray{2,5});
P_3_given_3 = givenarray{3,3} / (givenarray{3,3} + givenarray{3,4} + givenarray{3,5});
P_4_given_3 = givenarray{3,4} / (givenarray{3,3} + givenarray{3,4} + givenarray{3,5});
P_5_given_3 = givenarray{3,5} / (givenarray{3,3} + givenarray{3,4} + givenarray{3,5});
P_4_given_4 = givenarray{4,4} / (givenarray{4,4} + givenarray{4,5});
P_5_given_4 = givenarray{4,5} / (givenarray{4,4} + givenarray{4,5});

A = [P_0_of_a_kind,P_2_of_a_kind,P_3_of_a_kind,P_4_of_a_kind,P_5_of_a_kind,P_2_given_2,P_3_given_2,P_4_given_2,P_5_given_2,P_3_given_3,P_4_given_3,P_5_given_3,P_4_given_4,P_5_given_4]; 
%store calculated probabilities in this array
B= [0.0926,0.6944,0.1929,0.0193,0.0008,0.5556,0.3704,0.0694,0.0046,0.6944,0.2778,0.0278,0.8333,0.1667];
%Theoretical Array is B


% Display the results
fprintf('Probability of rolling 0 of a kind: %.4f\n', P_0_of_a_kind);
fprintf('Probability of rolling 2 of a kind: %.4f\n', P_2_of_a_kind);
fprintf('Probability of rolling 3 of a kind: %.4f\n', P_3_of_a_kind);
fprintf('Probability of rolling 4 of a kind: %.4f\n', P_4_of_a_kind);
fprintf('Probability of rolling 5 of a kind: %.4f\n', P_5_of_a_kind);
fprintf('Probability of rolling 2 of a kind given 2 of a kind: %.4f\n', P_2_given_2);
fprintf('Probability of rolling 3 of a kind given 2 of a kind: %.4f\n',P_3_given_2);
fprintf('Probability of rolling 4 of a kind given 2 of a kind: %.4f\n', P_4_given_2);
fprintf('Probability of rolling 5 of a kind given 2 of a kind: %.4f\n',P_5_given_2);
fprintf('Probability of rolling 3 of a kind given 3 of a kind: %.4f\n', P_3_given_3);
fprintf('Probability of rolling 4 of a kind given 3 of a kind: %.4f\n',P_4_given_3);
fprintf('Probability of rolling 5 of a kind given 3 of a kind: %.4f\n', P_5_given_3);
fprintf('Probability of rolling 4 of a kind given 4 of a kind: %.4f\n',P_4_given_4);
fprintf('Probability of rolling 5 of a kind given 4 of a kind: %.4f\n', P_5_given_4);
fprintf('Mean of all computed probabilities: %.4f\n',mean(A));
fprintf('Mean of all theoretical probabilities: %.4f\n', mean(B));
fprintf('Variance of all probabilities: %.4f\n',var(A-B));



tiledlayout(2,2)

nexttile
histogram (A,14);
xlabel('Value');
ylabel('Frequency (Number of occurrences)');
title('Histogram of Computed');

nexttile
histogram(B,14);
xlabel('Value');
ylabel('Frequency (Number of occurrences)');
title('Histogram of Theoretical');

nexttile
X = categorical ({'Theoretical','Computed'});
Y = [mean(A),mean(B)];
bar(X,Y);
title('Averages of Both Theoretical and Computed Probabilities');
xlabel('Calculations');
ylabel('Average');


nexttile
variance = var(A - B);
plot(1:length(A), A, 'bo', 1:length(B), B, 'ro', 'LineWidth', 2);
hold on;
plot(1:length(variance), variance, 'g', 'LineWidth', 2);
legend('Computed', 'Theoretical');
xlabel('Index');
ylabel('Probability');
title('Theoretical and Computational Instances');






