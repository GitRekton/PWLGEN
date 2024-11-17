clear all;

hb1 = HalfBridge(15,0);
hb1.init(-1);

hb2 = HalfBridge(15,0);
hb2.init(-1);

hbridge = HBridge(hb1, hb2);

%% begin
hbridge.moveForwardInTime(1e-6);

hbridge.hb1.swtch(1,1e-6);
hbridge.hb2.swtch(-1,1e-6);

hbridge.moveForwardInTime(1e-6);

hbridge.hb1.swtch(1,1e-6);
hbridge.hb2.swtch(1,1e-6);


hbridge.moveForwardInTime(10e-6); % 6

hbridge.hb1.swtch(1,1e-6);
hbridge.hb2.swtch(-1,1e-6);

hbridge.moveForwardInTime(1e-6); % 8

hbridge.hb1.swtch(-1,1e-6);
hbridge.hb2.swtch(-1,1e-6);


hbridge.moveForwardInTime(1e-6); % 8

hbridge.exportAllSignalsToPWL();

