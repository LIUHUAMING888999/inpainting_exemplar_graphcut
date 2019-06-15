function [ patchsize ] = get_patchSize( p,lambda1,lambda2,alpha,pdata )
%GET_PATCHSIZE 此处显示有关此函数的摘要
%   此处显示详细说明
lambda1_v= lambda1(p);
    lambda12_v= lambda2(p);
    
%     pdata =300;
%     alpha=0.3;
    temp  = alpha+(1-alpha)*exp(-1*pdata/(abs(lambda1_v-lambda12_v) ));
    
    
    ppt=[ 14.3073 -174.1446  408.2293 -385.8482  146.2264   -1.7730];
    psz =  floor( polyval(ppt,temp));
    if mod(psz,2)==0
        psz=psz+1;
    end
    psz= min(psz,33);
    psz= max(7,psz);
    patchsize =psz;
end

