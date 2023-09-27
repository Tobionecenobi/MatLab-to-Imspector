%%MAKE SURE YOU HAVE DONE FOLLOWING IN IMSPECTOR!!! 
    %--------> PRESS: tool->server <---------

%First I want to make all the matlab scripts from imspector available
addpath(genpath('C:\Imspector\Versions\16.3.16129-w2224-win64\matlab'))

%Secondly import the library for imspector
import specmx.*
import omex.*

%Thirdly do black magic that is not documented
omex_initialize();

%connect to local Imspector server and open measurement
im = specmx.get_application();
%OBS!!! ONE CANNOT USE "FILENAME" ONLY 'FILENAME' WITH ONE ->'<- ON EACH
%SIDE OF THE FILE NAME
measurements = im.open('INSERT FILE NAME HERE');

%Set threshold
threshold = 210;

%Open a file one can write to aka. output file
file = fopen('data_analysis_example_output.txt', 'w');

%for each stack in the measurement 
for name = 0:length(measurements.stack_names())-1
    %Get the stack
    stack = measurements.stack(name);
    %Get the data from the stack (DEV: REMEMBER TO RUN MATLAB AS ADMINSTRATOR)
    data = stack.data;
    pixelrow = data(:,1,1);
    %Compute the mean and std
    mn = mean(pixelrow);
    standard_deviation = std(double(pixelrow));
    %Display and save values to file
    disp("The stack" + num2str(name) + " first pixel row has mean " + num2str(mn) + " and std " + num2str(standard_deviation))
    fprintf(file, "The stack" + num2str(name) + " first pixel row has mean " + num2str(mn) + " and std " + num2str(standard_deviation) +"\n");

    %apply mask (all values smaller threshold)
    % Create a logical matrix where entries are true if corresponding entry in data is less than threshold
    mask = pixelrow < threshold;

    % To "mask" the data (i.e., set the values below threshold to NaN)
    masked_data = pixelrow;
    masked_data(mask) = NaN;  % Set the values where mask is true to NaN
    
    %Compute the mean and std
    mn = mean(masked_data, 'omitmissing');
    standard_deviation = std(double(masked_data), 'omitmissing');
    %Display and save values to file
    disp("The stack" + num2str(name) + " first pixel row has mean " + num2str(mn) + " and std " + num2str(standard_deviation))
    fprintf(file, "The stack" + num2str(name) + " first pixel row has mean " + num2str(mn) + " and std " + num2str(standard_deviation) +"\n");
end
fclose(file);