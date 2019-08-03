clear
clc

u_1 = [10;10]
u_2 = [22 ; 10]
sig = [4 4 ; 4 9]
s_1 = randnum(u_1,sig,1000);
s_2 = randnum(u_2,sig,1000);

mean_s_1 = zeros(1,2);
x = zeros(1,2);
for j = 1:1000
for i = 1 : 2
x(i) = s_1(i,j);
end
mean_s_1 = mean_s_1 + x;
end
mean_s_1 = mean_s_1./1000;


mean_s_2 = zeros(1,2);
x = zeros(1,2);
for j = 1:1000
for i = 1 : 2
x(i) = s_2(i,j);
end
mean_s_2 = mean_s_2 + x;
end
mean_s_2 = mean_s_2./1000;
for i=1:1000
s_1(:,i) = s_1(:,i) - mean_s_1(:);
s_2(:,i) = s_2(:,i) - mean_s_2(:);

end
S_x_1 = (1/999).*(s_1*s_1');
S_x_2 = (1/999).*(s_2*s_2');
[V_1 D_1] = eig(S_x_1);
[V_2 D_2] = eig(S_x_2);
pca_1 = V_1(:,2)
pca_2 = V_2(:,2)
s_1 = randnum(u_1,sig,1000);
s_2 = randnum(u_2,sig,1000);
proj_1 = pca_1'  * s_1;
proj_2 = pca_2'  * s_2;
x  = linspace(0,30,100);
y_line_1 = pca_1(2)/pca_1(1)*(x - mean_s_1(1)) + mean_s_1(2)
figure;
plot(s_1(1,:),s_1(2,:),'+')
hold on
plot(x, y_line_1);
title('class 1');
figure;
y_line_2 = pca_2(2)/pca_2(1)* (x - mean_s_2(1)) + mean_s_2(2)
plot(s_2(1,:),s_2(2,:),'+')
hold on;
plot(x ,y_line_2);
title('class 2');

figure;
plot(proj_1,0,'r+');
title('class 1 proj');
figure;
plot(proj_2,0, 'b+');
title('class 2 proj');
