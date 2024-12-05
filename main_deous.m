clc,clear

addpath(genpath('completion'));
addpath(genpath('data_stripes'));
addpath('assess_fold');
%11; 12; 13; 21; 22; 23; 31; 32; 33 分9种情形

load('J:\Program Files\papers\subspace_nolocal\destriping\data_stripes\simu\KSC\KSC_R22.mat')
[M,N,B]=size(img); methodname={'noisy','ours'};
%for i=1:B
Run_ours=1;

Nhsi=Is;
i=1;   enList=1;
Re_hsi{i}=Nhsi; 
[PSNR(i),SSIM(i),FSIM(i),SAM(i),ERGAS(i)] = evaluate(img,Re_hsi{i},M,N);

i=i+1;
if Run_ours
    addpath('J:\Program Files\papers\subspace_nolocal\destriping\completion\ours');
   opts_ours.lambda1=2; %2
   opts_ours.lambda2=3; %5 10 3
   opts_ours.mu=1; %1
   opts_ours.max_Iter=50; %50
   opts_ours.img=img;
    tic;
  [denoising_ours]=our_destriping(Nhsi,opts_ours);
  Re_hsi{i}=denoising_ours;
    Time(i)=toc;
    [PSNR(i), SSIM(i),FSIM(i),SAM(i),ERGAS(i)] = evaluate(img, Re_hsi{i},M,N);    
    disp([methodname{i},' done in' num2str(Time(i)),'s.']);
    disp([methodname{i},' MPSNR=' num2str(PSNR(i)), 'MSSIM=' num2str(SSIM(i))]);
    enList=[enList,i];   
  %  save('J:\Program Files\papers\subspace_nolocal\destriping\results\WDC\33\Our','denoising_ours');
end

showHSIResult_for_simu(Re_hsi,img,0,1,methodname,enList,20,B);  





