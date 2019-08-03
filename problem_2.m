clear
clc
scrdir = dir('C:\Users\Amir\Desktop\test\*.png');
Z_test = zeros(2500,100);
Z_train = zeros(2500,540);
for i=1 : length(scrdir)
direction = strcat('C:\Users\Amir\Desktop\test\',scrdir(i).name);
X = imread(direction);
Vec = X(:);
Z_test(:,i)=Vec;
end
U= uint8(reshape(Z_test(:,1),[50 , 50]));
figure;
imshow(U);
title('image of test');
scrdir = dir('C:\Users\Amir\Desktop\train\*.png');
for i=1 : length(scrdir)
direction = strcat('C:\Users\Amir\Desktop\train\',scrdir(i).name);
X = imread(direction);
Vec = X(:);
Z_train(:,i)=Vec;
end
U= uint8(reshape(Z_train(:,540),[50 , 50]));
figure;
imshow(U);
title('image of train');

mean_train = zeros(1,2500);
x = zeros(1,2500);
for j = 1:540
for i = 1 : 2500
x(i) = Z_train(i,j);
end
mean_train = mean_train + x;
end
mean_train = mean_train./540;
mean_train = uint8(reshape(mean_train,[50 , 50]));
figure;
imshow(mean_train);
title('mean_train');



mean_test = zeros(1,2500);
x = zeros(1,2500);
for j = 1:100
for i = 1 : 2500
x(i) = Z_test(i,j);
end
mean_test = mean_test + x;
end
mean_test = mean_test./100;
mean_test = uint8(reshape(mean_test,[50 , 50]));
figure;
imshow(mean_test);
title(' mean_test');

for i=1:100
Z_test(:,i) = Z_test(:,i) - double(mean_test(:));
end
figure;
imshow(reshape(Z_test(:,25),[50 50]))
title('image_test – mean');

for i = 1:540
Z_train(:,i) = Z_train(:,i) - double(mean_train(:));
end
figure;
imshow(reshape(Z_train(:,25),[50 50]));
title('image_train – mean');
S_x = (1/539).*(Z_train*Z_train'); 
[V D] = eig(S_x);
M = zeros(2500,10);
for i = 1:10
p_img(:,i) = V(:,2500-i+1);
end
p_img = 255.*p_img;
for i =1:10
p_img(:,i)=double(p_img(:,i)) + double(mean_train(:));
figure
p_img = uint8(p_img);
imshow(reshape(p_img(:,i),[50,50]));
title(strcat('pca image',string(i)))
end

[V D] = eig(Z_test*Z_test');
U = V;
[V D] = eig(Z_test'*Z_test);

for i = 1 :50
changed = D(i,i);
D(i,i) = D(101-i, 101-i);
D(101-i, 101-i) = changed;
end
sigma = zeros(2500,100);
sigma(1:100,1:100) = sqrt(D);
error = zeros(1,100);
for r = 1 : 99
error(r) = sigma(r+1,r+1);
end
plot(error);
