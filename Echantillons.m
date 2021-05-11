%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette fonction permet d'extraire  les valeurs Moy/Var/Ecart  des echantillons %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ValPro,Valeur]=Echantillons(audioA)

    Valeur=zeros(6,305);%305 échantillons
    
% Extraire  les parametres d'un signal vocal original.

    for i=1:61
        Parametres=parametreAp(audioA(i));
        Valeur(1,i)=Parametres(1);% Coefficient de dépendance.
        Valeur(2,i)=Parametres(2);% Variance de signal.
        Valeur(3,i)=Parametres(3);% Ecart type de signal.
        Valeur(4,i)=Parametres(4);% Moyenne de signal.
        Valeur(5,i)=Parametres(5);% Puissance de signal.
        Valeur(6,i)=Parametres(6);% Energie de signal.
    end
    
% Extraire  les parametres les parametres d'un signal vocal modifié 4 fois aleatoirement.

    p=61;
    
    for i=1:61
        for j=0:3
            Parametres=parametreRanAp(audioA(i));% Coefficient de dépendance.
            Valeur(1,i+j+p)=Parametres(1);% Variance de signal.
            Valeur(2,i+j+p)=Parametres(2);% Variance de signal.
            Valeur(3,i+j+p)=Parametres(3);% Ecart type de signal.
            Valeur(4,i+j+p)=Parametres(4);% Moyenne de signal.
            Valeur(5,i+j+p)=Parametres(5);% Puissance de signal.
            Valeur(6,i+j+p)=Parametres(6);% Energie de signal.
        end
        p=p+3;
    end
 
% Calcule de Moy/Var/Ecart de 6 parametres .

    ValPro=zeros(3,6);
    
    for i=1:6
        ValPro(1,i)=mean(Valeur(i,:));
        ValPro(2,i)=var(Valeur(i,:));
        ValPro(3,i)=sqrt(ValPro(2,i));
    end
    
end






