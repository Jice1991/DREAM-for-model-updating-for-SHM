function [fx] = Evaluate_model(x,DREAMPar,Meas_info,f_handle);
% This function computes the likelihood and log-likelihood of each d-vector
% of x values
%
% Code both for sequential and parallel evaluation of model ( = pdf )
%
% Written by Jasper A. Vrugt

global DREAM_dir EXAMPLE_dir;

% Check whether to store the output of each model evaluation (function call)
if ( strcmp(lower(DREAMPar.modout),'yes') ) && ( Meas_info.N > 0 ),
    
    % Create initial fx of size model output by DREAMPar.N
    fx = NaN(Meas_info.N,DREAMPar.N);
    
end;

% Now evaluate the model
if ( DREAMPar.CPU == 1 )         % Sequential evaluation
    
    cd(EXAMPLE_dir)
    
    % Loop over each d-vector of parameter values of x using 1 worker
    for ii = 1:DREAMPar.N,      
        
        % Execute the model and return the model simulation
        fx(:,ii) = f_handle(x(ii,:));
        
    end;

    cd(DREAM_dir)
    
elseif ( DREAMPar.CPU > 1 )      % Parallel evaluation
    
    % If IO writing with model --> worker needs to go to own directory
    if strcmp(lower(DREAMPar.IO),'yes'),
        
        % Loop over each d-vector of parameter values of x using N workers
        parfor ii = 1:DREAMPar.N,
            
            % Determine work ID
            t = getCurrentTask();
            
            % Go to right directory (t.id is directory number)
            evalstr = strcat(EXAMPLE_dir,'\',num2str(t.id)); cd(evalstr)
            
            % Execute the model and return the model simulation
            fx(:,ii) = f_handle( [ x(ii,:) t.id ] );
            
        end;
        
    else
        
        cd(EXAMPLE_dir)
        
        % Loop over each d-vector of parameter values of x using N workers    
        parfor ii = 1:DREAMPar.N,
            
            % Execute the model and return the model simulation
            fx(:,ii) = f_handle(x(ii,:));
            
        end;

        cd(DREAM_dir)

    end;
    
end;