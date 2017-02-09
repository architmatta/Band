function [feature] = calc_feat(output)
mean_A = sum(output( :,3))/length(output( :,3));
mean_L = sum(output(1:8, 1))/8;
feature(1) = sum(output(2:4, 4).*output(2:4, 3))/sum(output(2:4, 3));
feature(2) = output(2, 4);
feature(3) = output(7,4);
feature(4) = output(2, 4)/output(1, 4);
feature(5) = output(1, 3)/output(2, 3); 
feature(7) = sum(output(1:8, 1));
feature(8) = output(2, 1)+ output(4, 1);
feature(9) = sum((output(z, 1)-mean_L)*(output(z, 1)-mean_L));
feature(6)
feature(10) 
feature(11)
feature(12)
feature(13)
feature(14)
feature(15)
feature(16)