function data=preprocess(data0)

% remove uselessdata from IMU sensory 5-7,and 14-17
notselectindx=[8:10 17:20 25:27 34:37 42:44 51:54];
indx=setxor(notselectindx,1:size(data0,2));
data1=data0(:,indx);

% handle missing values NaN
data1(:,3)=handleNaN(data1(:,3));
for i=4:size(data1,2)
    data1(:,i)=handleNaN(data1(:,i));
end
ind=find(isnan(data1(:,5))==0&isnan(data1(:,15))==0&isnan(data1(:,25))==0&isnan(data1(:,3))==0);
data1=data1(ind,:);

% Signal Noise Removal: 
% The Hampel filter helps to remove outliers from a signal without overly smoothing the data.
fs = 100;
data=data1;
for i=4:size(data1,2)
    data(:,i)=medfilt1(data1(:,i),3); 
end

% % remove the linear effect of time on heart rate
% data(:,3)=detrend(data(:,3),'linear');