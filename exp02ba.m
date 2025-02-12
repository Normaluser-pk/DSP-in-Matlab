%overlap save method
clear all

n1 = 2:11;
x1 = [3,-1,0,1,3,2,0,1,2,1];n1m=min(n1);

n2 = 2:4;
x2 = [1,1,1 ];n2m=min(n2);


subplot(3,1,1)
stem(n1,x1);
xlabel('Time'),ylabel('Amplitude'),title("Original Signal 1");
subplot(3,1,2)
stem(n2,x2);
xlabel('Time'),ylabel('Amplitude'),title("Original Signal 2");

l1=length(x1);
l2=length(x2);M=3;
N=l1+l2-1;
L=l2+M-1;
dl=L-l2;
dx=l2-mod(l1,l2);
w1=[];
for i=1:dx
    w1=[w1 0];
end
w1=[w1 x1];
for i=1:dx
    w1=[w1 0];
    x2=[x2 0];
end

function a = cm(m)
    xnum = m;
    a = [];  
    c = length(xnum);
    a = [a xnum(c)];
    for i = 1:length(xnum)-1
        a = [a xnum(i)];
    end
end

iter=fix(l1/l2)+1;temp1=1;
y=[];y1=[];
for i=1:(iter)
    temp_ar=[];
    for j=1:l2
        temp_ar=[temp_ar w1(temp1)];
        temp1=temp1+1;
    end
    temp2=temp1;
    for m=1:dx
        temp_ar=[temp_ar w1(temp2)];
        temp2=temp1+m;
    end
    z = [];
    z=[z temp_ar'];
    a=temp_ar;
    for o=1:length(temp_ar)-1
        a=cm(a);
        z=[z a'];
    end
    y1=z*x2';
    for j=1:dx

        flag=1;
        y1(flag)=[];
    end
    y=[y y1'];
    disp(y)
end

Y = (n1m+n2m):(n1m+n2m+N)-1;
if length(y)>length(Y)
    p=length(y);
    for i=1:(length(y)-length(Y))
        y(p)=[];
        p=p-1;
    end
end
disp("convolved signal")
disp(y)
subplot(3,1,3)
stem(Y,y)
xlabel('Time'),ylabel('Amplitude'),title("Convolved Signal (overlap save method)");