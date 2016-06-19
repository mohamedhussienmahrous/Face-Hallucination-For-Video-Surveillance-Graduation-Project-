function [ K ] = Untitled5(inputpatch,arrayofpicture,numberofpic,threshold,flag,NK )
d=[];
inputpatch = fun(inputpatch,threshold,flag);
for i=1:numberofpic
    [H ,w]=size(arrayofpicture(i,:));
    d=[d; reshape(arrayofpicture(i,:),[1,H*w])];
    %%fun(arrayofpicture(i,:),threshold,flag)
end
MLd = createns(d,'NSMethod','kdtree','Distance','minkowski');
K=knnsearch(MLd,inputpatch,'K',NK);
end