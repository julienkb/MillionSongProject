%% Set up environment
addpath('mksqlite');

% set up Million Song paths
global MillionSong MSDsubset
MillionSong='cs229project/MillionSongSubset';  % or 'MillionSong' for full set?
msd_data_path=[MillionSong,'/data'];
msd_addf_path=[MillionSong,'/AdditionalFiles'];
MSDsubset = 'subset_'; % or '' for full set
msd_addf_prefix=[msd_addf_path,'/',MSDsubset];
% Check that we can actually read the dataset
assert(exist(msd_data_path,'dir')==7,['msd_data_path ',msd_data_path,' not found...']);

% path to the Million Song Dataset code
msd_code_path='cs229project/MatlabSrc';
assert(exist(msd_code_path,'dir')==7,['msd_code_path ',msd_code_path,' not found.']);
% add to the path
addpath([msd_code_path]);


%% Simple file access
%
% The Million Song Dataset stores the Echo Nest Analyze features
% and meta data for each track in its own HDF5 data file, organized
% into file hierarchy based on the Echo Nest hash codes.  First, we
% build a list of all h5 files under our data tree.  Then we load
% one file, look at the methods available, and plot the chroma for
% the first part of the file.  

% Build a list of all the files in the dataset
all_files = findAllFiles(msd_data_path);
cnt = length(all_files);
disp(['Number of h5 files found: ',num2str(cnt)]);

fileID = fopen('songYears.csv','w');
% Get info from the first file using our wrapper
for i = 1:cnt
    h5 = HDF5_Song_File_Reader(all_files{i});
    fprintf(fileID, '%d"\n', h5.get_year());
%     disp(['artist name is: ',h5.get_artist_name()]);
%     disp([' song title is: ',h5.get_title()]);
end
h5 = HDF5_Song_File_Reader(all_files{1});

