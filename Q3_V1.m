%% Step 1: Loading the Data
data0=importdata('PAMAP2_Dataset/Protocol/subject101.dat');

%% Step 2: Preprocess data
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

% %remove the linear effect of time on heart rate
% data(:,3)=detrend(data(:,3),'linear');

%% Step 3: Exploratory Data Analysis
figure
subplot(4,3,1)
plot(data(:,1),data(:,2),'k')
axis tight
ylabel('activityID')
subplot(4,3,3)
plot(data(:,1),data(:,3),'k')
ylabel('Heart Rate')
axis tight

subplot(4,3,4)
plot(data1(:,1),data1(:,5),'k')
hold on
plot(data(:,1),data(:,5),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,5)
plot(data1(:,1),data1(:,6),'k')
hold on
plot(data(:,1),data(:,6),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,6)
plot(data1(:,1),data1(:,7),'k')
hold on
plot(data(:,1),data(:,7),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight


subplot(4,3,7)
plot(data1(:,1),data1(:,15),'k')
hold on
plot(data(:,1),data(:,15),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,8)
plot(data1(:,1),data1(:,16),'k')
hold on
plot(data(:,1),data(:,16),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,9)
plot(data1(:,1),data1(:,17),'k')
hold on
plot(data(:,1),data(:,17),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight


subplot(4,3,10)
plot(data1(:,1),data1(:,25),'k')
hold on
plot(data(:,1),data(:,25),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,11)
plot(data1(:,1),data1(:,26),'k')
hold on
plot(data(:,1),data(:,26),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,12)
plot(data1(:,1),data1(:,27),'k')
hold on
plot(data(:,1),data(:,27),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight


%% Step 4: Data Splitting
% seperate xdata and ydata for training and testing dataset
t=data(:,1);
Xdata=data(:,3:end);
Ydata=data(:,2);

%Split traing data into 0.7 of sample for training and 0.3 of sample for validation.
cvpart = cvpartition(Ydata,'holdout',0.3);

Xtrain = Xdata(training(cvpart),:);
Xtest =  Xdata(test(cvpart),:);
Ytrain = Ydata(training(cvpart),:);
Ytest =  Ydata(test(cvpart),:);

%% Step 5: Random Forest Model
bag = fitensemble(Xtrain,Ytrain,'Bag',400,'Tree',...
    'type','classification');

%% Step 6: Validation
figure;
plot(loss(bag,Xtest,Ytest,'mode','cumulative'));
xlabel('Number of trees');
ylabel('Test classification error');
pred=predict(bag,Xtest);
figure;plot(Ytest);hold on;plot(pred,'r')

%% Step 7:Predicting the Test Sets
testdata0=importdata('PAMAP2_Dataset/Optional/subject101.dat');
testdata=preprocess(testdata0);
predtest=predict(bag,testdata(:,3:end));
figure;plot(testdata(:,2));hold on;plot(predtest,'r')