nstep =100; %Number of timesteps to integrate over
Inoise = 0.1;
IO = 1+Inoise*randn(1,nstep); %input current in nA
dt = 1; % time step in ms
tau_vector = [3 10 30] ; %membrane time constant in ns
theta_vector = [2 4 11]; % threshold in mV
Rin_vector = [2 5 20]; %Input resistance in M??hm
v = zeros(1,nstep);
tspike = [];
t = (1:nstep)*dt;

figHandleTau = figure; %figure for Tau
figHandleTheta = figure; %figure for Theta
figHandleRin = figure; %figure for Rin

Rin = Rin_vector(2); %assigning starting values (middle) for the constants 
theta = theta_vector(2);

legendInfo = cell(1,3); %initialization of legend cell for the figures
i=1; %initialization of i that counts the legends that we are gonna have in our figure
for tau=tau_vector %sweep of tau value while keeping the other 2 variables constant
	for n=2:nstep
		v(n)=v(n-1) + dt*(-v(n-1)/tau + Rin*IO(n)/tau);
		if (v(n) > theta)
			v(n) = 0;
			tspike = [tspike t(n)];
		end
	end
	figure(figHandleTau) %use of figure command so that our plots for the diffeerent sweeps be in different figures
	legendInfo{i} = ['Tau = ' num2str(tau) ' Mean Spike interval = ' num2str(mean(isi(tspike)))]; %add the values of the sweeping var as legend + the mean of interval spikes
	tspike = []; %initialization of tspike table for the next sweep
	hold all %hold all command so that all plots of this iteration are represented at the same figure
	title('Parameter Sweeping for Tau');
	xlabel('Time');
	ylabel('Voltage');
	plot(t,v)
	i=i+1; %increment of legend count
end
% downwards we have 2 same iterations for Rin and theta

theta = theta_vector(2);
tau = tau_vector(2);
i=1;
legend(legendInfo)
for Rin=Rin_vector
	 for n=2:nstep
		 v(n)=v(n-1) + dt*(-v(n-1)/tau + Rin*IO(n)/tau);
		 if (v(n) > theta)
			 v(n) = 0;
			 tspike = [tspike t(n)];
		 end
	 end
	 figure(figHandleRin)
	 legendInfo{i} = ['Rin = ' num2str(Rin) ' Mean Spike interval = ' num2str(mean(isi(tspike)))];
	 tspike = [];
	 hold all
	 title('Parameter Sweeping for Rin');
	 xlabel('Time');
	 ylabel('Voltage');
	 plot(t,v)
	 i=i+1;
end
 
legend(legendInfo)

Rin = Rin_vector(2);
tau = tau_vector(2);

i=1;
legend(legendInfo)
for theta=theta_vector
	 for n=2:nstep
		 v(n)=v(n-1) + dt*(-v(n-1)/tau + Rin*IO(n)/tau);
		 if (v(n) > theta)
			 v(n) = 0;
			 tspike = [tspike t(n)];
		 end
	 end
	 figure(figHandleTheta)
	 legendInfo{i} = ['Theta = ' num2str(theta) ' Mean Spike interval = ' num2str(mean(isi(tspike)))];
	 tspike = [];
	 hold all
	 title('Parameter Sweeping for Theta');
	 xlabel('Time');
	 ylabel('Voltage');
	 plot(t,v)
	 i=i+1;
 end
 legend(legendInfo)
                         
