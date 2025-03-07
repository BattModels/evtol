function [FlightOutput,L,n] = BasicMission(AeroProps, MissionProps, AtmosProps)

%% 
TakeOffOutput = ...
    TakeOff(AeroProps.f, AeroProps.FM, AeroProps.disk_load,AeroProps.Nhov,...
    MissionProps.VC, MissionProps.H0,...
    AeroProps.MTOM,...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL, AeroProps.rotortype);    
%%
TransitionUpOutput = ...
    TransUp(AeroProps.f, AeroProps.cd0, AeroProps.FM, AeroProps.K,...
    AeroProps.area_load, AeroProps.disk_load, AeroProps.Nhov, AeroProps.Ncli, ...
    MissionProps.H0, MissionProps.tup, MissionProps.Vv, ...
    AeroProps.MTOM,...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL);
%%    
ClimbOutput = ...
    AeroClimb(AeroProps.cd0, AeroProps.K, AeroProps.area_load, AeroProps.Ncli,...
    MissionProps.H0, MissionProps.Vv, MissionProps.Hc, ...
    AeroProps.MTOM, ...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL);
%%    
CruiseOutput = ...
    Cruise(AeroProps.cd0, AeroProps.K, AeroProps.area_load, ...
    AeroProps.Ncru, MissionProps.VCr, AeroProps.LD, ...
    MissionProps.Hc, ...
    AeroProps.Range, AeroProps.MTOM, ...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL);
%%    
DescentOutput = ...
    Descent(AeroProps.cd0, AeroProps.K, AeroProps.area_load, AeroProps.Ncli,...
    MissionProps.H0, MissionProps.VD, MissionProps.Hc, ...
    AeroProps.MTOM, ...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL);
%%
TransitionDownOutput = ...
    TransDown(AeroProps.f, AeroProps.cd0, AeroProps.FM, AeroProps.K,...
    AeroProps.area_load, AeroProps.disk_load, AeroProps.Ncli, AeroProps.Nhov, ...
    MissionProps.H0, MissionProps.tdn, MissionProps.VD, ...
    AeroProps.MTOM,...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL);
%%
LandingOutput = ...
    Land(AeroProps.f, AeroProps.FM, AeroProps.disk_load,AeroProps.Nhov,...
    MissionProps.VDVL, MissionProps.H0,...
    AeroProps.MTOM,...
    AtmosProps.TGL, AtmosProps.PGL, AtmosProps.DGL, AeroProps.rotortype);    
%%

x = {TakeOffOutput, TransitionUpOutput, ...
    ClimbOutput, CruiseOutput, DescentOutput,...
    TransitionDownOutput, LandingOutput};
[FlightOutput,L,n] = FlyMission(x);
end