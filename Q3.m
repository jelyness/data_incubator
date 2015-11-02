%% Step 1: Loading the Raw Data
data0{1}=importdata('PAMAP2_Dataset/Protocol/subject101.dat');
data0{2}=importdata('PAMAP2_Dataset/Protocol/subject102.dat');
data0{3}=importdata('PAMAP2_Dataset/Protocol/subject103.dat');
data0{4}=importdata('PAMAP2_Dataset/Protocol/subject104.dat');
data0{5}=importdata('PAMAP2_Dataset/Protocol/subject105.dat');
data0{6}=importdata('PAMAP2_Dataset/Protocol/subject106.dat');
data0{7}=importdata('PAMAP2_Dataset/Protocol/subject107.dat');
data0{8}=importdata('PAMAP2_Dataset/Protocol/subject108.dat');
data0{9}=importdata('PAMAP2_Dataset/Protocol/subject109.dat');

%% Step 2: Preprocess data
data=[];
for i=1:9
    data=[data;preprocess(data0{i})];
end

%% Step 3: Exploratory Data Analysis
plotsignal(data(1:size(data0{1},1),:));

%% Step 4: Data Splitting
% seperate xdata and ydata for training and testing dataset
t=data(:,1);
Xdata=data(:,3:end);
Ydata=data(:,2);

%Split traing data into training, validation and test.
cvpart = cvpartition(Ydata,'holdout',0.3);
Xtrain0 = Xdata(training(cvpart),:);
Ytrain0 = Ydata(training(cvpart),:);
Xtest = Xdata(test(cvpart),:);
Ytest =  Ydata(test(cvpart),:);

cvpart2 = cvpartition(Ytrain,'holdout',0.3);
Xtrain = Xtrain0(training(cvpart2),:);
XValid = Xtrain0(test(cvpart2),:);
Ytrain = Ytrain0(training(cvpart2),:);
YValid = Ytrain0(test(cvpart2),:);


%% Step 5: Random Forest Model
bag = fitensemble(Xtrain,Ytrain,'Bag',40,'Tree',...
    'type','classification');

%% Step 6: Validation
figure;
plot(loss(bag,XValid,YValid,'mode','cumulative'));
xlabel('Number of trees');
ylabel('Test classification error');
pred=predict(bag,XValid);
figure;
subplot(2,1,1)
plot(YValid,'k');
ylabel('Actual activityID')

subplot(2,1,2)
plot(pred,'r');
ylabel('Predicted activityID')
xlabel('Time (s)')

activityID=unique(data(:,2));
ActualTime=zeros(1,length(activityID));
EstTime=zeros(1,length(activityID));
for i=1:length(activityID)
    ActualTime(i)=length(find(YValid==activityID(i)))*0.01;
    EstTime(i)=length(find(pred==activityID(i)))*0.01;
end

%% Step 7:Predicting the Test Sets
predtest=predict(bag,Xtest);
figure;plot(Ytest);hold on;plot(predtest,'r');
figure;
subplot(2,1,1)
plot(Ytest,'k');
ylabel('Actual activityID')

subplot(2,1,2)
plot(predtest,'r');
ylabel('Predicted activityID')
xlabel('Time (s)')

ActualTime=zeros(1,length(activityID));
EstTime=zeros(1,length(activityID));
for i=1:length(activityID)
    ActualTime(i)=length(find(Ytest==activityID(i)));
    EstTime(i)=length(find(predtest==activityID(i)));
end
error=sum(Ytest-predtest)/length(Ytest);