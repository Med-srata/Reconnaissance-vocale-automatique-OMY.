
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette fonction permet de calculer les erreurs  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Erj,Erl,fid]=erreur(audio,f,ValPro)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de calculer la moyenne d'erreurs de justesse.%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Extraire les paramètres %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parametres=parametreAp(audio);
    a=Parametres(1);
    VarS=Parametres(2);
    MoyS=Parametres(4);
    Puiss=Parametres(5);
    Energ=Parametres(6);
    MoyenA=ValPro(1,1);
    MoyenE=ValPro(1,6);
    MoyenM=ValPro(1,4);
    MoyenVS=ValPro(1,2);
    MoyenP=ValPro(1,5);
    EcartM=ValPro(3,4);
    EcartVS=ValPro(3,2);
    EcartEn=ValPro(3,6);
    EcartPui=ValPro(3,5);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%les erreurs de justesse %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    eja=abs(a-MoyenA);%Erreur de coefficient de dépendance.
    ejv=abs(MoyenVS-VarS);%Erreur de variance.
    ejm=abs(MoyenM-MoyS) ;%Erreur de moyenne.
    eje=abs(Energ-MoyenE)*1e-2;%Erreur d'energie.
    ejb=abs(Puiss-MoyenP);%Erreur de puissance.
    Erj=(eja+ejv+ejm+eje+ejb)/5;%Moyenne des erreurs de justesse.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de deduire la fidelité %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intervelle des valeurs de moyenne %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    malM=[MoyenM-EcartM,MoyenM+EcartM];
    bienM=[MoyenM-2*EcartM,MoyenM+2*EcartM];
    topM=[MoyenM-3*EcartM,MoyenM+2*EcartM];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intervelle des valeurs de variance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    malV=[MoyenVS-EcartVS,MoyenVS+EcartVS];
    bienV=[MoyenVS-2*EcartVS,MoyenVS+2*EcartVS];
    topV=[MoyenVS-3*EcartVS,MoyenVS+2*EcartVS];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intervelle des valeurs d'energie %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    malE=[MoyenE-EcartEn,MoyenE+EcartEn];
    bienE=[MoyenE-2*EcartEn,MoyenE+2*EcartEn];
    topE=[MoyenE-3*EcartEn,MoyenE+3*EcartEn];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intervelle des valeurs de puissance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    malP=[MoyenP-EcartPui,MoyenP+EcartPui];
    bienP=[MoyenP-2*EcartPui,MoyenP+2*EcartPui];
    topP=[MoyenP-3*EcartPui,MoyenP+3*EcartPui];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Deduire la fidelité %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fidelité de variance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ge(VarS,malV(1,1))&& le(VarS,malV(1,2))
        fideliteV=99;%pourcentage
    else
        if ge(VarS,bienV(1,1))&& le(VarS,bienV(1,2))
            fideliteV=95;%pourcentage
        else
            if ge(VarS,topV(1,1))&& le(VarS,topV(1,2))
                fideliteV=60;%pourcentage
            else
               fideliteV=-99;%pourcentage
            end

        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fidelité de moyenne %%
%%%%%%%%%%%%%%%%%%%%%%%%%

    if ge(MoyS,malM(1,1))&& le(MoyS,malM(1,2))
        fideliteM=99;%pourcentage
    else
        if ge(MoyS,bienM(1,1))&& le(MoyS,bienM(1,2))
            fideliteM=95;%pourcentage
        else
            if ge(MoyS,topM(1,1))&& le(MoyS,topM(1,2))
                fideliteM=60;%pourcentage
            else
               fideliteM=-99;%pourcentage
            end
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%
%% Fidelité d'energie %%
%%%%%%%%%%%%%%%%%%%%%%%%

    if ge(Energ,malE(1,1))&& le(Energ,malE(1,2))
        fideliteE=99;%pourcentage
    else
        if ge(Energ,bienE(1,1))&& le(Energ,bienE(1,2))
            fideliteE=6;%pourcentage
        else
            if ge(Energ,topE(1,1))&& le(Energ,topE(1,2))
                fideliteE=40;%pourcentage
            else
               fideliteE=-99;%pourcentage
            end
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fidelité de puissance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ge(Puiss,malP(1,1))&& le(Puiss,malP(1,2))
        fideliteP=99;%pourcentage
    else
        if ge(Puiss,bienP(1,1))&& le(Puiss,bienP(1,2))
            fideliteP=95;%pourcentage
        else
            if ge(Puiss,topP(1,1))&& le(Puiss,topP(1,2))
                fideliteP=60;%pourcentage
            else
               fideliteP=-99;%pourcentage
            end
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=(fideliteP+fideliteE+fideliteV+fideliteM)/4;%Fidelité moyenne.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de calculer la moyenne d'erreurs du liniarité.%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Extraire les paramètres %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [Y23,Y26,Y35,Y65]=moindcarre(f);
    Y=zeros(22,4);
    for i=1:22
        Y(i,1)=f(4,i);
        Y(i,2)=f(6,i);
        Y(i,3)=f(5,i);
        Y(i,4)=f(2,i);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Distances de projection des valeurs des échantillions %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [~, distM]= dsearchn (transpose(Y23), Y(:,1));
    [~, distP]= dsearchn (transpose(Y26), Y(:,3));
    [~, distE]= dsearchn (transpose(Y35),Y(:,2));
    [~, distPE]= dsearchn (transpose(Y65), Y(:,2));
    distMax=max(distM);
    distPMax=max(distP);
    distEMax=max(distE);
    distPEMax=max(distPE);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Distances de projection des valeurs de signal nouveau %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [~, distMn]= dsearchn (transpose(Y23), MoyS);
    [~, distPn]= dsearchn (transpose(Y26), Puiss);
    [~, distEn]= dsearchn (transpose(Y35), VarS);
    [~, distPEn]= dsearchn (transpose(Y65), Energ);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% La moyenne d'erreurs du liniarité %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Erl=(abs(distMn-distMax)+abs(distPMax-distPn)+abs(distEn-distEMax)*1e-2+abs(distPEn-distPEMax))/5;
    
end