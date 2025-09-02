fs = 16000;                 
nBits_list = [2, 4,5,6,8, 12, 24, 32]; 
base_bits = 16;
nChannels = 1;               
timeRec = 10;                

audioObj = audiorecorder(fs, base_bits, nChannels);

disp("Start Recording...");
recordblocking(audioObj, timeRec);
disp("Recording Complete!");

recordedAudio = getaudiodata(audioObj);

audiowrite('Audio_Original.wav', recordedAudio, fs);

% Plot Original Audio Segment
t = linspace(0, 0.1, round(0.1 * fs));
orig_segment = recordedAudio(1:length(t));

for i = 1:length(nBits_list)
    bits = nBits_list(i);
    quantLevels = 2^bits;
    quantizedAudio = round(recordedAudio * (quantLevels/2 - 1)) / (quantLevels/2 - 1);

    filename = sprintf('Audio_%dBits.wav', bits);
    audiowrite(filename, quantizedAudio, fs);

    quant_segment = quantizedAudio(1:length(t));

    % Plot both Original and Quantized
    figure;
    plot(t, orig_segment, 'b', 'LineWidth', 1.5); hold on;
    plot(t, quant_segment, 'r', 'LineWidth', 1.5);
    title(['Original vs Quantized Audio (' num2str(bits) '-bit)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original', [num2str(bits) '-bit Quantized']);
    grid on;
end
