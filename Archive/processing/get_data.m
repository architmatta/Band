function[sound_train, sound_test] = get_data()

sound_train = {
              '..\data\vehicle040.wav'; ... 
              '..\data\vehicle042.wav'; ...
              '..\data\vehicle043.wav'; ...
              '..\data\vehicle045.wav'; ...
              '..\data\vehicle047.wav'; ...
              %'..\data\sound1.wav'; ...
              %'..\data\sound2.wav'; ...
              %'..\data\sound3.wav'; ...
              '..\data\sound4.wav'; ...
              '..\data\sound5.wav'; ...
              '..\data\sound6.wav'; ...
              '..\data\sound7.wav'; ...
              '..\data\sound8.wav'; ...
              '..\data\sound9.wav'; ...
              '..\data\sound10.wav'; ...
              '..\data\sound11.wav'; ...
              '..\data\sound12.wav'; ...
              '..\data\sound13.wav'; ...
              '..\data\sound14.wav'; ...
              '..\data\sound15.wav'; ...
              '..\data\sound16.wav'; ...
              '..\data\sound17.wav'; ...
              '..\data\sound18.wav'; ...
              '..\data\sound19.wav'; ...
              '..\data\sound20.wav'; ...
              '..\data\sound21.wav'; ...
              '..\data\sound22.wav'; ...
              '..\data\sound23.wav'; ...
} ;

sound_train = char(sound_train);
          
sound_test = {
              '..\data\sound24.wav', ...
              '..\data\sound25.wav', ...
              '..\data\sound26.wav', ...
              '..\data\sound27.wav', ...
              '..\data\traffic1.wav', ...
              '..\data\traffic2.wav', ...
              '..\data\random1.wav', ...
              '..\data\random2.wav', ...
              '..\data\random3.wav', ...
              '..\data\random3.wav', ...
} ;

sound_test = char(sound_test);