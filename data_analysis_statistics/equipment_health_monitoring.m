% 題：設備健康監控
% 1. 收集設備運行數據
% 將設備運行參數數據導入 MATLAB，如振動、溫度等。
equipmentData = readtable('equipment_data.csv');

% 2. 設備性能指標計算
% 計算均值、方差等指標來評估設備的健康狀態。
meanTemp = mean(equipmentData.Temperature);

% 3. 可視化運行狀況
% 使用時間序列圖表來顯示設備的健康狀況。
plot(equipmentData.Time, equipmentData.Temperature);
title('Equipment Health Monitoring');
xlabel('Time');
ylabel('Temperature (°C)');
