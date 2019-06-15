I =  (img_pry{1});
imshow(I);
set(gcf, 'Position',  [200, 200, 1000, 1000])
I = double(I);
hold on;
global xp;
global yp;
bl = [xp+(m-1)/2, yp-(m-1)/2];
br = [xp+(m-1)/2, yp+(m-1)/2];
tl = [xp-(m-1)/2, yp-(m-1)/2];
tr = [xp-(m-1)/2, yp+(m-1)/2];
targety = [ones(1,m)*bl(1), ones(1,m)*tl(1), tl(1):bl(1), tr(1):br(1)];
targetx = [bl(2):br(2), tl(2):tr(2), ones(1,m)*tl(2), ones(1,m)*tr(2)];
plot(targety, targetx, 'r', 'LineWidth', 2);
for j = 1:5
    yp = indexm{1}(index{1}(j))+floor(m/2);
    xp = indexn{1}(index{1}(j))+ floor(n/2);
    bl = [xp+(m-1)/2, yp-(m-1)/2];
    br = [xp+(m-1)/2, yp+(m-1)/2];
    tl = [xp-(m-1)/2, yp-(m-1)/2];
    tr = [xp-(m-1)/2, yp+(m-1)/2];
   
   targety = [ones(1,m)*bl(1), ones(1,m)*tl(1), tl(1):bl(1), tr(1):br(1)];
targetx = [bl(2):br(2), tl(2):tr(2), ones(1,m)*tl(2), ones(1,m)*tr(2)];

    plot(targety, targetx, 'b', 'LineWidth', 1);
end
      pause(2); 
