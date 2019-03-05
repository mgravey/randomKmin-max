% init data 

rng(10)

N=10000;
array=rand(N,1);
array(randperm(N,3))=-1;
posi=randperm(N,7)
array(posi)=-0.5;

k=5;

numberOfTest=100000;
values_wrong=nan(numberOfTest,k);
indexes_wrong=nan(numberOfTest,k);
values_true=nan(numberOfTest,k);
indexes_true=nan(numberOfTest,k);
values_exp=nan(numberOfTest,k);
indexes_exp=nan(numberOfTest,k);
values_expC=nan(numberOfTest,k);
indexes_expC=nan(numberOfTest,k);

for i=1:numberOfTest
    [values_wrong(i,:),indexes_wrong(i,:)]=mink(array+rand(numel(array),1)*0.0001,k);
    [values_true(i,:),indexes_true(i,:)]=minkrandom(array,k);
    [values_exp(i,:),indexes_exp(i,:)]=randomSort(array,k);
    [values_expC(i,:),indexes_expC(i,:)]=randomkmin(array,k,i);
end


n=[];

uv = unique(indexes_wrong);
n  = [n histc(indexes_wrong(:),uv)];
uv = unique(indexes_true);
n  = [n histc(indexes_true(:),uv)];
uv = unique(indexes_exp);
n  = [n histc(indexes_exp(:),uv)];
uv = unique(indexes_expC);
n  = [n histc(indexes_expC(:),uv)];

n