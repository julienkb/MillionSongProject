x = zeros(10000, 107);
for song = 1:10000
    x(song, :) = extract_song_info(HDF5_Song_File_Reader(all_files{song}));
    if mod(song, 250) == 0
        song
    end
end