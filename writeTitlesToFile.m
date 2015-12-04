fileID = fopen('songTitles.csv','w');
for i = 1:cnt
   fprintf(fileID, '"');
   fprintf(fileID, songInfo{i});
   fprintf(fileID, '","');
   fprintf(fileID, songInfo{i+cnt});
   fprintf(fileID, '"\n');
end
fclose(fileID);