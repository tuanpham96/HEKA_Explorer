function getRecording(app, ind_rec)

dt_ms = 1000/double(app.data_table.SR(ind_rec));
results = struct('channels', struct(), 'stimulus', struct(), ...
    'dt_ms', dt_ms, 't', '', 'num_sweeps', double(app.data_table.nSweeps(ind_rec)));

variable_names = struct; 
current_varind = 1; 
% Get monitored channel data
channel_units = app.data_table.ChUnit{ind_rec};
channel_names = app.data_table.ChName{ind_rec};
channel_data  = app.data_table.dataRaw{ind_rec};

num_channels = length(channel_data);
for ind_chan = 1:num_channels
    chan_unit  = channel_units{ind_chan};
    chan_datum = channel_data{ind_chan};
    
    switch upper(chan_unit)
        case 'A'
            chan_unit  = 'nA';
            chan_datum = chan_datum * 1e9;
            chan_ylim = [-4, 0.5]; 
        case 'V'
            chan_unit  = 'mV';
            chan_datum = chan_datum * 1e3;
            chan_ylim = [-90, 60]; 
        otherwise
            error('%s is not an acceptable channel unit as this point', chan_unit);
    end
    
    channel_units{ind_chan} = chan_unit;
    channel_data{ind_chan} = chan_datum;
    
    variable_names.(sprintf('var%d', current_varind)) = struct(...
        'original_name', channel_names{ind_chan}, ...
        'new_name', channel_names{ind_chan}, ...
        'identity', 'channels', ...
        'index', ind_chan, ...
        'unit', chan_unit, ...
        'save', 1, ...
        'color', 'k', ...
        'axes_indices', [], ...
        'ylim', chan_ylim ...
        );
    current_varind = current_varind + 1; 
end

results.channels.names = channel_names;
results.channels.units = channel_units;
results.channels.data  = channel_data;
results.channels.num   = num_channels;

% Get stimulus data
stim_data = app.data_table.stimWave{ind_rec};
stim_units = app.data_table.stimUnit{ind_rec};
stim_names = fieldnames(stim_data);
num_stims = length(stim_names);
stim_units = cellfun(@(x) x(1), stim_units, 'uni', 0);

for ind_stim = 1:num_stims
    variable_names.(sprintf('var%d', current_varind)) = struct(...
        'original_name', stim_names{ind_stim}, ...
        'new_name', stim_names{ind_stim}, ...
        'identity', 'stimulus', ...
        'index', ind_stim, ...
        'unit', stim_units{ind_stim}, ...
        'save', 1, ...
        'color', 'r', ...
        'axes_indices', [], ...
        'ylim', 'auto' ...
        );    
    current_varind = current_varind + 1; 
end
results.stimulus.names = stim_names;
results.stimulus.units = stim_units;
results.stimulus.data  = cellfun(@(x) stim_data.(x), stim_names, 'uni', 0);
results.stimulus.num   = num_stims;

% Time vector
len_dat = size(channel_data{1},1);
results.t = dt_ms*(0:(len_dat-1));

% Update properties of apps to save these data 
app.current_data = results;
app.current_variables = variable_names; 

app.current_settings.xlim = 'auto'; 
end