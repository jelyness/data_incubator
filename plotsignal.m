function plotsignal(data)
figure('position',[500 300 700 660])
subplot(4,3,1)
plot(data(:,1),data(:,2),'k')
axis tight
ylabel('activityID')
subplot(4,3,3)
plot(data(:,1),data(:,3),'k')
ylabel('Heart Rate')
axis tight

subplot(4,3,4)
% plot(data1(:,1),data1(:,5),'k')
% hold on
plot(data(:,1),data(:,5),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,5)
% plot(data1(:,1),data1(:,6),'k')
% hold on
plot(data(:,1),data(:,6),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,6)
% plot(data1(:,1),data1(:,7),'k')
% hold on
plot(data(:,1),data(:,7),'r')
% legend('Original signal','Filtered signal')
title('IMU band accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight


subplot(4,3,7)
% plot(data1(:,1),data1(:,15),'k')
% hold on
plot(data(:,1),data(:,15),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,8)
% plot(data1(:,1),data1(:,16),'k')
% hold on
plot(data(:,1),data(:,16),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,9)
% plot(data1(:,1),data1(:,17),'k')
% hold on
plot(data(:,1),data(:,17),'r')
% legend('Original signal','Filtered signal')
title('IMU chest accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight


subplot(4,3,10)
% plot(data1(:,1),data1(:,25),'k')
% hold on
plot(data(:,1),data(:,25),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel X')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,11)
% plot(data1(:,1),data1(:,26),'k')
% hold on
plot(data(:,1),data(:,26),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel Y')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight

subplot(4,3,12)
% plot(data1(:,1),data1(:,27),'k')
% hold on
plot(data(:,1),data(:,27),'r')
% legend('Original signal','Filtered signal')
title('IMU ankle accel Z')
xlabel('Time (s)')
ylabel('Acceleration')
axis tight
