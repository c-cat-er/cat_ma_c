% 題：缺陷率分析
% 1. 導入缺陷數據
% 使用 readtable 或 xlsread 導入生產中缺陷數據。
defectData = readtable('defect_data.csv');

% 2. 數據篩選與清理
% 處理缺失值，並進行異常值檢測。
defectData = rmmissing(defectData);

% 3. 缺陷率計算
% 分析不同工藝步驟下的缺陷數據。
defectRate = groupsummary(defectData, 'Step', 'mean', 'DefectCount');

% 4. 缺陷率可視化
% 直方圖
figure;
histogram(defectRate.mean_DefectCount);
title('Defect Count Histogram');
xlabel('Mean Defect Count');
ylabel('Frequency');

% 散點圖 - 展示缺陷數據的分佈。
figure;
scatter(defectRate.Step, defectRate.mean_DefectCount);
title('Defect Rate Analysis');
xlabel('Production Step');
ylabel('Mean Defect Count');

% 箱型圖 - 呈現不同條件下的缺陷率分佈。
% 在使用箱型圖時，我們通常會對某個分組變量進行分組，這個分組變量可以用來將缺陷數據進行細分，並更好地了解不同組之間的分佈情況。
if ismember('ParameterGroup', defectData.Properties.VariableNames)
    figure;
    boxplot(defectData.DefectCount, defectData.ParameterGroup);
    title('Defect Rate Distribution by Parameter Group');
    xlabel('Parameter Group');
    ylabel('Defect Count');
else
    warning('ParameterGroup column not found in defectData.');
end
