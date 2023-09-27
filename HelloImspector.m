%%MAKE SURE YOU HAVE DONE FOLLOWING IN IMSPECTOR!!! 
    %--------> PRESS: tool->server <---------

%First I want to make all the matlab scripts from imspector available
addpath(genpath('C:\Imspector\Versions\16.3.16129-w2224-win64\matlab'))

%Secondly import the library for imspector
import specmx.*
import omex.*

%Thirdly do black magic that is not documented
omex_initialize();

%connect to local Imspector server
im = specmx.get_application();

%Print host and version 
disp("Connected to Imspector " + im.version() + " on " + im.host())
