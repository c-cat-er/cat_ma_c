% 飛行器參數
function pa=Parameters()
    pa.m = 1e3;           % 飛行器質量
    pa.Jyy = 1e4;         % 繞y軸的轉動慣量
    pa.S = 10;            % 翼面積
    pa.mu = 9.8;          % 重力常數
    pa.RE = 6.4e6;        % 地球半徑
    pa.x0 = 10 * rand(1,5); % 初始狀態
    pa.c = 4;
    pa.ce = 5;
    pa.delta_T = 0.5;
    pa.rho = 0.5;
    pa.b = 0.1;
    pa.wo = 50;
    pa.wc = 20;
end