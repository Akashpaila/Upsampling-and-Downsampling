fs_list = [100, 1000, 4000, 8000, 22000, 32000, 44100, 50000]; 
nBits = 16;
nChannels = 2;  
timeRec = 10; 

fs_base = 16000;
audioObj = audiorecorder(fs_base, nBits, nChannels);

disp("Start Recording...");
recordblocking(audioObj, timeRec);
disp("Recording Complete!");

recordedAudio = getaudiodata(audioObj);

audiowrite('Audio_Original_Stereo.wav', recordedAudio, fs_base);

for i = 1:length(fs_list)
    fs = fs_list(i);
    resampledAudio = resample(recordedAudio, fs, fs_base);
    filename = sprintf('Audio_%dHz_Stereo.wav', fs);
    audiowrite(filename, resampledAudio, fs);
   
    t = linspace(0, 1, round(0.1 * fs));
    segment = resampledAudio(1:length(t), :); 

    figure;
    plot(t, segment);
    title(['Stereo Waveform at ' num2str(fs) ' Hz']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Left Channel', 'Right Channel');
    grid on;
end
