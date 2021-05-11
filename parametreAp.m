
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette fonction permet d'extraire  les parametres d'un signal vocal original %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Parametres=parametreAp(audio)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de la suppression du silence de la parole à l'aide de l'analyse de cadre par  cadre.(ZCR).%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lecture d'audio.
    data=audio;
    data = data(1:end,1)/max(data(1:end,1));
    
%Faire le cadrage.
    fs=44100;
    f_d = 0.025;
    f_size = round(f_d * fs);
    n = length(data);
    n_f = floor(n/f_size); 
    temp = 0;
    for i = 1 : n_f

       frames(i,:) = data(temp + 1 : temp + f_size);
       temp = temp + f_size;
    end
    % Suppression de silence basé sur l'amplitude maximale.
    m_amp = abs(max(frames,[],2));
    id = find(m_amp > 0.03); 
    fr_ws = frames(id,:);
    
% Reconstruire le signal
    data_r = reshape(fr_ws',1,[]);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de filtrer le signal de bruit à l'aide d'un filtre butterworth-passe-bande.%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choix d'un filtre.

    Fs = 500;
    o = 5;%Ordre de filtre.
    wn = [3 7]*2/Fs;% fréquence de coupure 
    [b,a] = butter(o,wn,'bandpass');% a et b sont les coefficients de fonction de transfert de ce filtre.
    
% Filtrage de signal

    y_filt = filter(b,a,data_r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie est reservée pour extraire les paramètres du signal.%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [X,Y] = envelope(y_filt);% Extraire les envelopes (haut et bas) d'un signal.
    Y=abs(Y);
    Parametres=[1:6];
    Parametres(1)=(Y/X);% Coefficient de dépendance.
    Parametres(2)=var(y_filt);% Variance de signal.
    Parametres(3)=sqrt(Parametres(2));% Ecart type de signal.
    Parametres(4)=mean(y_filt);% Moyenne de signal.
    Parametres(5)=bandpower(y_filt);% Puissance de signal.
    Parametres(6)=sum(abs(y_filt).^2);% Energie de signal.
end
