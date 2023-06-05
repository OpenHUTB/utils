# run matlab script background
nohup matlab -nosplash -nodisplay -nodesktop -r 'try; cd /home/ubuntu/dong/brain/auditory/music_genre_fMRI; extract_MTF_feature; catch; end; quit' > /tmp/matlab.log &