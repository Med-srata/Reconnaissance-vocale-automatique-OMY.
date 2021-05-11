
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette fonction permet d'appliquer la méthode des moindres carrés  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [Y23,Y26,Y35,Y65]=moindcarre(f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de trouver le coefficients des fonctions affines de la méthode des moindres carrés %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Les coefficients Vars/Moys:
    a23=(mean(f(2,:).*f(4,:))-mean(f(2,:)).*mean(f(4,:)))/(mean(f(2,:).^2)-mean(f(2,:)).^2);%a23: la pente 
    b23=mean(f(4,:))-a23*mean(f(2,:));%b23 : l'ordonnée à l'origine
    %Les coefficients Vars/Energ:
    a35=(mean(f(2,:).*f(6,:))-mean(f(2,:)).*mean(f(6,:)))/(mean(f(2,:).^2)-mean(f(2,:)).^2);%a35: la pente 
    b35=mean(f(6,:))-a35*mean(f(2,:));%b35 : l'ordonnée à l'origine
    %Les coefficients  Vars/Puissance:
    a26=(mean(f(2,:).*f(5,:))-mean(f(2,:)).*mean(f(5,:)))/(mean(f(2,:).^2)-mean(f(2,:)).^2);%a26: la pente 
    b26=mean(f(5,:))-a26*mean(f(2,:));%b26 : l'ordonnée à l'origine
    %Les coefficients Puissance/Energ:
    a65=(mean(f(5,:).*f(6,:))-mean(f(5,:)).*mean(f(6,:)))/(mean(f(5,:).^2)-mean(f(5,:)).^2);%a65: la pente 
    b65=mean(f(6,:))-a65*mean(f(5,:));%b65 : l'ordonnée à l'origine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cette partie permet  de deduire les fonctions affines de la méthode des moindres carrés et de les tracer %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    t=0:0.001:max(f(2,:));%Intervalle de definition.
    Y23=a23.*t+b23;% Vars/Moys.

    t=0:0.001:max(f(2,:));%Intervalle de definition.
    Y26=a26.*t+b26;% Vars/Puissance.
    Y35=a35.*t+b35;% Vars/Energ.

    t=0:0.001:max(f(5,:));
    Y65=a65.*t+b65;% Puissance/Energ.
end

