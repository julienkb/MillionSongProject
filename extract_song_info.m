function [features] = extract_song_info(h5)
features = zeros(1, 107);

% Metadata
features(1) = h5.get_artist_familiarity();
features(2) = h5.get_duration();
features(3) = h5.get_end_of_fade_in();
features(4) = h5.get_energy();
features(5) = h5.get_key();
features(6) = h5.get_start_of_fade_out();
features(7) = h5.get_loudness();
features(8) = h5.get_mode();
features(9) = h5.get_tempo();
features(10) = h5.get_time_signature();
features(11) = h5.get_danceability();

% h5.get_bars_start()
% h5.get_sections_start()
% h5.get_segments_start()
% h5.get_beats_start()
% h5.get_tatums_start()
% h5.get_segments_loudness_start()

pitches = h5.get_segments_pitches();
timbres = h5.get_segments_timbre();

length = size(pitches, 2);
for i = 0 : 3
   slice = 1 + floor(i * length/4);
   begin = 12 + 24 * i;
   end_idx = 12 + 24 * i + (24-1);
   features(begin: end_idx) = [pitches(:, slice)' timbres(:, slice)'];
end

% h5.get_segments_loudness_max()
% h5.get_segments_loudness_max_time()

% h5.get_analysis_sample_rate()

% h5.get_artist_terms()

% h5.get_year()
% h5.get_artist_hotttnesss()
% h5.get_song_hotttnesss()

% h5.get_beats_confidence()
% h5.get_mode_confidence()
% h5.get_key_confidence()
% h5.get_tatums_confidence()
% h5.get_artist_longitude()
% h5.get_time_signature_confidence()
% h5.get_sections_confidence()
% h5.get_bars_confidence()
% h5.get_segments_confidence()
