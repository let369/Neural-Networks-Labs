function isi_result=isi(spiketimes)
% ISI produces interspike intervals from spike times
% ISI(spiketimes) returns the interspike intervals
% of SPIKETIMES 
if (length(spiketimes)>1)
    isi_result = diff(spiketimes);
else
    isi_result = [];
end
