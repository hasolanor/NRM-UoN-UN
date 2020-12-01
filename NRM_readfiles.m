function [exp] = NRM_readfiles(files,plotting)
%readfiles function reads the experimental data from txt files
%   files: string array with files name. One file corresponds one
%   experiment.
%   plotting: boleaan variable indicating if plotting

for i=1:length(files)
    fileID=fopen(files(i),'r');
    [A, count] = fscanf(fileID,'%f %f');
    fclose(fileID);
    A = reshape(A,2,0.5*count)';    
    exp(i).t=A(:,1)'; exp(i).c=A(:,2)';
    
    %Computing cumulative and derivative
    exp(i).C=NRM_cumfunction(exp(i).t,exp(i).c); %Same size of exp.t
    exp(i).dc=NRM_derivative(exp(i).t,exp(i).c); %Size: size of exp.t-2
    
    %Plotting option
    if (plotting=="true")
        figure(1)
        plot(exp(i).t, exp(i).c,'*'); hold on;
        
        figure(2)
        plot(exp(i).t, exp(i).C,'*'); hold on;
    end
    clear A
 end
end
