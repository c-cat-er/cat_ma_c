% 題：生產良率分析
% 1. 導入數據
% 將製造過程中的良率數據從 CSV 或 Excel 文件中導入 MATLAB。
data = readtable('yield_data.csv');

% 2. 數據清理和篩選
% 使用 MATLAB 的數據預處理工具箱清理缺失值和異常值。
data = rmmissing(data); % eg. NaN、NULL、""。
data = rmoutliers(data);
% rmoutliers() 默認使用 四分位距法 (IQR Method) 來判定異常值。

% 3. 良率計算
% 計算不同工藝條件下的平均良率，使用統計函數來分析波動。
meanYield = groupsummary(data, 'Process_Condition', 'mean', 'Yield'); %%
% groupsummary 函數會根據 Process_Condition 進行分組，然後計算每個 Process_Condition 對應的良率 (Yield) 的平均值。

% meanYield = mean(data.Yield);
% stdYield = std(data.Yield);

% 4. 可視化良率波動
% 條型圖 - 展示不同工藝條件下的平均良率。
figure; % 新建圖形窗口
bar(meanYield.Process_Condition, meanYield.mean_Yield); % x,y 軸數據 %%
title('Yield Analysis under Different Process Conditions');
xlabel('Process Condition');
ylabel('Yield (%)');

% 折線圖 - 
figure;
plot(meanYield.Process_Condition, meanYield.mean_Yield, '-o'); % 使用折線圖展示
title('Yield Analysis with Line Chart');
xlabel('Process Condition');
ylabel('Yield (%)');

% 散點圖 - 展示工藝參數與良率的關係
figure;
scatter(data.Parameter1, data.Yield);
title('Scatter Plot of Parameter1 vs Yield');
xlabel('Parameter1');
ylabel('Yield (%)');
