-- Periodization Tracker - Seed Data
USE periodization_tracker;

-- -----------------------------------------------------
-- users
-- -----------------------------------------------------
INSERT INTO `users` (`username`, `age`, `gender`, `weight`, `height`) VALUES
  ('anatoly_pisarenko', 28, 'Male',           109, 181),
  ('vasily_alexeev',    24, 'Female',         62,  168),
  ('asen_zlatev',       35, 'Male',           92,  185),
  ('naim_suleymanoglu', 30, 'Female',         58,  165),
  ('piros_dimas',       22, 'AlphabetPerson', 71,  174),
  ('valerios_leonidis', 40, 'Male',           100, 178);

-- -----------------------------------------------------
-- target_types
-- -----------------------------------------------------
INSERT INTO `target_types` (`name`) VALUES
  ('muscle'),
  ('tendon'),
  ('joint'),
  ('nervous system'),
  ('cardio-vascular'),
  ('brain');

-- -----------------------------------------------------
-- exercise_types
-- -----------------------------------------------------
INSERT INTO `exercise_types` (`name`) VALUES
  ('barbell'),
  ('dumbell'),
  ('freeweight'),
  ('cardio-vascular'),
  ('calistenic'),
  ('pliometric'),
  ('isometric');

-- -----------------------------------------------------
-- repetition_types
-- -----------------------------------------------------
INSERT INTO `repetition_types` (`name`) VALUES
  ('slow'),
  ('fast'),
  ('intentional'),
  ('long-length partial'),
  ('short-length partial'),
  ('isometric'),
  ('concentric only'),
  ('eccentric only');

-- -----------------------------------------------------
-- pp_aspects
-- -----------------------------------------------------
INSERT INTO `pp_aspects` (`name`) VALUES
  ('absolute strength'),
  ('relative strength'),
  ('power'),
  ('speed'),
  ('hypertrophy'),
  ('coordination'),
  ('technique'),
  ('reaction time'),
  ('cardio-vascular endurance'),
  ('muscular endurance');

-- -----------------------------------------------------
-- targets
-- -----------------------------------------------------
SET @muscle_type_id  = (SELECT `target_type_id` FROM `target_types` WHERE `name` = 'muscle');
SET @tendon_type_id  = (SELECT `target_type_id` FROM `target_types` WHERE `name` = 'tendon');
SET @joint_type_id   = (SELECT `target_type_id` FROM `target_types` WHERE `name` = 'joint');

INSERT INTO `targets` (`name`, `latin_name`, `description`, `target_type_id`) VALUES
  -- muscles
  ('lower pectoralis',  'pectoralis major',               'The lower chest muscle',                                    @muscle_type_id),
  ('upper pectoralis',  'pectoralis minor',               'The upper chest muscle',                                    @muscle_type_id),
  ('lats',              'latissimus dorsi',               'The largest muscle of the back',                            @muscle_type_id),
  ('front deltoids',    'pars clavicularis deltoidei',    'The front part of the shoulder muscle',                     @muscle_type_id),
  ('side deltoids',     'pars acromialis deltoidei',      'The outer part of the shoulder muscle',                     @muscle_type_id),
  ('rear deltoids',     'pars spinalis deltoidei',        'The rear part of the shoulder muscle',                      @muscle_type_id),
  ('trapezius',         'musculus trapezius',             'The muscle of the upper mid back',                          @muscle_type_id),
  ('biceps',            'biceps brachii',                 'The two-headed flexor muscle of the upper arm',             @muscle_type_id),
  ('triceps',           'triceps brachii',                'The three-headed extensor muscle of the upper arm',         @muscle_type_id),
  ('quadriceps',        'musculus quadriceps femoris',    'The four-headed extensor muscle of the front thigh',        @muscle_type_id),
  ('hamstrings',        'musculi flexores genus',         'The group of muscles on the back of the thigh',             @muscle_type_id),
  ('glutes',            'gluteus maximus',                'The largest muscle of the gluteal group',                   @muscle_type_id),
  ('gluteus medius',    'gluteus medius',                 'The hip abductor muscle on the outer pelvis',               @muscle_type_id),
  ('calves',            'gastrocnemius',                  'The two-headed calf muscle powering plantarflexion',        @muscle_type_id),
  ('soleus',            'musculus soleus',                'The deep calf muscle, primary in slow plantarflexion',      @muscle_type_id),
  ('rhomboids',         'musculi rhomboidei',             'The retractors of the scapula in the upper back',           @muscle_type_id),
  ('serratus anterior', 'musculus serratus anterior',     'The muscle that protracts and stabilises the scapula',      @muscle_type_id),
  ('erector spinae',    'musculi erector spinae',         'The column of muscles that extends and stabilises the spine',@muscle_type_id),
  ('rectus abdominis',  'musculus rectus abdominis',      'The central abdominal muscle responsible for trunk flexion', @muscle_type_id),
  ('obliques',          'musculi obliqui abdominis',      'The lateral abdominal muscles for rotation and flexion',    @muscle_type_id),
  ('hip flexors',       'musculus iliopsoas',             'The primary hip flexor connecting spine to femur',          @muscle_type_id),
  ('adductors',         'musculi adductores femoris',     'The inner-thigh muscles that adduct the leg',               @muscle_type_id),
  ('tibialis anterior', 'musculus tibialis anterior',     'The shin muscle responsible for dorsiflexion of the foot',  @muscle_type_id),
  -- tendons (commonly stressed in plyometric training)
  ('patellar tendon',   'ligamentum patellae',            'The tendon connecting the kneecap to the tibia',            @tendon_type_id),
  ('achilles tendon',   'tendo calcaneus',                'The tendon connecting the calf muscles to the heel bone',   @tendon_type_id),
  ('quadriceps tendon', 'tendo musculi quadricipitis',    'The tendon connecting the quadriceps to the patella',       @tendon_type_id),
  ('proximal hamstring tendon', 'tendo proximalis ischiocruralis', 'The tendon attaching the hamstrings to the ischial tuberosity', @tendon_type_id),
  ('peroneal tendons',  'tendines musculorum peroneorum', 'The tendons running behind the lateral malleolus',          @tendon_type_id),
  ('plantar fascia',    'aponeurosis plantaris',          'The thick band of tissue along the sole supporting the arch', @tendon_type_id),
  -- joints
  ('knee joint',        'articulatio genus',              'The hinge joint between the femur and tibia',               @joint_type_id),
  ('hip joint',         'articulatio coxae',              'The ball-and-socket joint between the femur and pelvis',    @joint_type_id),
  ('shoulder joint',    'articulatio humeri',             'The ball-and-socket joint of the glenohumeral complex',     @joint_type_id),
  ('ankle joint',       'articulatio talocruralis',       'The hinge joint between the tibia, fibula, and talus',      @joint_type_id),
  ('elbow joint',       'articulatio cubiti',             'The hinge joint between the humerus and the forearm bones', @joint_type_id),
  ('wrist joint',       'articulatio radiocarpalis',      'The condyloid joint between the radius and carpal bones',   @joint_type_id);



-- -----------------------------------------------------
-- training_plans
-- -----------------------------------------------------
SET @anatoly_id = (SELECT `user_id` FROM `users` WHERE `username` = 'anatoly_pisarenko');
SET @vasily_id  = (SELECT `user_id` FROM `users` WHERE `username` = 'vasily_alexeev');
SET @asen_id    = (SELECT `user_id` FROM `users` WHERE `username` = 'asen_zlatev');
SET @naim_id    = (SELECT `user_id` FROM `users` WHERE `username` = 'naim_suleymanoglu');
SET @piros_id   = (SELECT `user_id` FROM `users` WHERE `username` = 'piros_dimas');
SET @valerios_id = (SELECT `user_id` FROM `users` WHERE `username` = 'valerios_leonidis');

INSERT INTO `training_plans` (`name`, `description`, `user_id`) VALUES
  ('2026 competition plan',       'A plan for the 2026 competition season',                       @anatoly_id),
  ('2025 competition plan',       'A plan for the 2025 competition season',                       @anatoly_id),
  ('off-season hypertrophy',      'An off-season plan focused on building muscle mass',           @anatoly_id),
  ('summer beach body plan',      'A plan for getting a summer beach body',                       @asen_id),
  ('fat loss plan',               'A caloric deficit plan combining cardio and resistance work',  @asen_id),
  ('absolute strength plan',      'A plan for developing maximal absolute strength',              @piros_id),
  ('peaking block',               'A short-term plan to peak for a one-rep-max attempt',         @piros_id),
  ('endurance base build',        'A plan for building aerobic base and muscular endurance',      @vasily_id),
  ('technique refinement plan',   'A plan focused on improving movement mechanics and skill',    @vasily_id),
  ('powerlifting prep',           'A meet preparation plan for squat, bench, and deadlift',      @naim_id),
  ('tendon conditioning plan',    'A plan focused on tendon stiffness and plyometric capacity',  @naim_id),
  ('senior maintenance plan',     'A low-intensity plan for maintaining strength and mobility',  @valerios_id),
  ('power development plan',      'A plan targeting explosive power and rate of force development', @valerios_id);

-- -----------------------------------------------------
-- training_blocks
-- -----------------------------------------------------
INSERT INTO `training_blocks` (`name`, `description`, `duration`, `user_id`) VALUES
  -- anatoly: full conjugate-style periodization cycle
  ('2026 accumulation phase',      'General physical preparedness accumulation phase for the 2026 season',  84, @anatoly_id),
  ('2026 transmutation phase',     'Power transmutation phase for the 2026 season',                         42, @anatoly_id),
  ('2026 realisation phase',       'Performance realisation phase for the 2026 season',                     21, @anatoly_id),
  ('2025 accumulation phase',      'General physical preparedness accumulation phase for the 2025 season',  84, @anatoly_id),
  ('2025 transmutation phase',     'Power transmutation phase for the 2025 season',                         42, @anatoly_id),
  ('2025 realisation phase',       'Performance realisation phase for the 2025 season',                     21, @anatoly_id),
  -- naim: bulking and strength blocks
  ('clean bulk',                   'A clean bulk focused on lean muscle gain',                              84, @naim_id),
  ('dirty bulk',                   'A caloric surplus bulk for maximum mass gain',                          63, @naim_id),
  ('powerlifting strength block',  'A linear progression block targeting squat, bench, and deadlift',      56, @naim_id),
  ('deload week',                  'A low-volume recovery block to reduce accumulated fatigue',              7, @naim_id),
  -- piros: strength and peaking
  ('strength foundation block',    'A high-volume block establishing a base of absolute strength',         56, @piros_id),
  ('intensity ramp block',         'A block progressively increasing intensity toward a peak',             28, @piros_id),
  ('peaking block',                'A low-volume, high-intensity block leading up to a max attempt',       14, @piros_id),
  -- vasily: endurance and technique
  ('aerobic base block',           'A long-duration block building the aerobic energy system',             56, @vasily_id),
  ('technique drilling block',     'A block dedicated to movement pattern refinement and skill work',      28, @vasily_id),
  ('lactate threshold block',      'A block targeting lactate threshold through tempo and interval work',  42, @vasily_id),
  -- asen: body composition
  ('hypertrophy block',            'A moderate-intensity, high-volume block targeting muscle growth',      56, @asen_id),
  ('cut block',                    'A caloric deficit block combining resistance and cardio work',         42, @asen_id),
  ('maintenance block',            'A low-volume block for maintaining gains during a dietary break',      28, @asen_id),
  -- valerios: longevity and power
  ('joint prep block',             'A low-intensity block focused on joint health and mobility',           28, @valerios_id),
  ('power development block',      'A plyometric and speed-focused block for explosive power',             42, @valerios_id),
  ('senior strength block',        'A moderate-intensity block for maintaining functional strength',       56, @valerios_id);

-- -----------------------------------------------------
-- sessions
-- -----------------------------------------------------
INSERT INTO `sessions` (`name`, `description`, `user_id`) VALUES
  -- anatoly: olympic weightlifting sessions
  ('Clean&Jerk strength session',  'A session that works on strength in the clean&jerk',           @anatoly_id),
  ('Snatch technique session',     'A session focused on snatch technique and positional work',     @anatoly_id),
  ('Front squat session',          'A heavy front squat session for leg strength',                  @anatoly_id),
  ('Back squat session',           'A heavy back squat session for posterior chain development',    @anatoly_id),
  ('Pulls and deadlifts session',  'A session targeting clean and snatch pulls and deadlifts',      @anatoly_id),
  -- naim: bodybuilding-style splits
  ('Chest and Triceps',            'A heavy chest and triceps session',                             @naim_id),
  ('Back and Biceps',              'A heavy back and biceps session',                               @naim_id),
  ('Shoulders and Traps',          'A shoulder and trap isolation session',                         @naim_id),
  ('Legs',                         'A full leg session targeting quads, hamstrings, and glutes',    @naim_id),
  ('Arms',                         'An isolation session for biceps and triceps volume',            @naim_id),
  -- piros: powerlifting sessions
  ('Squat day',                    'A competition squat session with accessory work',               @piros_id),
  ('Bench press day',              'A competition bench press session with accessory work',         @piros_id),
  ('Deadlift day',                 'A competition deadlift session with accessory work',            @piros_id),
  ('Upper body accessory day',     'A session targeting upper body weak points',                    @piros_id),
  -- vasily: endurance and conditioning
  ('Tempo run session',            'A moderate-intensity steady-state running session',             @vasily_id),
  ('Interval training session',    'A high-intensity interval running session',                     @vasily_id),
  ('Long run session',             'A low-intensity long-distance endurance run',                   @vasily_id),
  ('Rowing endurance session',     'A long-duration low-intensity rowing session',                  @vasily_id),
  -- asen: body composition
  ('Push day',                     'A push session targeting chest, shoulders, and triceps',        @asen_id),
  ('Pull day',                     'A pull session targeting back and biceps',                      @asen_id),
  ('Leg day',                      'A leg session targeting quads, hamstrings, glutes, and calves', @asen_id),
  ('Cardio and core session',      'A conditioning session combining cardio and core work',         @asen_id),
  -- valerios: mobility and power
  ('Mobility and prehab session',  'A session focused on joint mobility and injury prevention',     @valerios_id),
  ('Plyometric session',           'An explosive plyometric session for power development',         @valerios_id),
  ('Full body strength session',   'A full body compound movement session for strength maintenance', @valerios_id),
  -- anatoly: additional olympic weightlifting sessions
  ('Snatch max effort session',        'A session targeting a heavy single in the snatch',                              @anatoly_id),
  ('Power snatch session',             'A session developing the power snatch from the hang and floor',                 @anatoly_id),
  ('Power clean session',              'A session developing the power clean for rate of force development',            @anatoly_id),
  ('Muscle snatch session',            'A technique session using the muscle snatch to reinforce the turnover',         @anatoly_id),
  ('Snatch balance session',           'A session drilling the snatch balance for overhead stability',                  @anatoly_id),
  ('Overhead squat session',           'A session targeting overhead squat strength and positional control',            @anatoly_id),
  ('Clean pull session',               'A session focusing on clean pulls for posterior chain and bar speed',           @anatoly_id),
  ('Snatch pull session',              'A session focusing on snatch pulls for back and trap development',              @anatoly_id),
  ('Jerk technique session',           'A session dedicated to jerk footwork, timing, and lockout',                    @anatoly_id),
  ('Clean and jerk complex session',   'A session combining multiple C&J variations into a single complex',             @anatoly_id),
  -- naim: additional bodybuilding sessions
  ('Heavy squat session',              'A low-rep high-intensity squat session for strength development',               @naim_id),
  ('Romanian deadlift session',        'A session targeting hamstrings and glutes through RDLs',                        @naim_id),
  ('Incline bench session',            'A session targeting the upper chest with incline pressing variations',          @naim_id),
  ('Lateral raise specialisation',     'A high-volume session targeting side deltoid development',                      @naim_id),
  ('Rear delt and face pull session',  'A session targeting rear delts and external rotators for shoulder health',      @naim_id),
  ('Leg press and leg curl session',   'A machine-based leg session targeting quads and hamstrings',                    @naim_id),
  ('Pull-ups and rows session',        'A session targeting lat width and mid-back thickness',                          @naim_id),
  ('Tricep specialisation session',    'A high-volume isolation session for tricep development',                        @naim_id),
  ('Bicep specialisation session',     'A high-volume isolation session for bicep and brachialis development',          @naim_id),
  ('Calf and forearm session',         'A session targeting calf hypertrophy and forearm strength',                     @naim_id),
  -- piros: additional powerlifting sessions
  ('Max effort squat session',         'A session working up to a heavy squat variation single',                        @piros_id),
  ('Dynamic effort squat session',     'A session performing speed squats against bands or chains',                     @piros_id),
  ('Max effort bench session',         'A session working up to a heavy bench press variation single',                  @piros_id),
  ('Dynamic effort bench session',     'A session performing speed bench press for rate of force development',          @piros_id),
  ('Max effort deadlift session',      'A session working up to a heavy deadlift variation single',                     @piros_id),
  ('Dynamic effort deadlift session',  'A session performing speed pulls for explosive hip extension',                  @piros_id),
  ('Pause squat session',              'A session using paused squats to build strength out of the hole',               @piros_id),
  ('Close grip bench session',         'A session targeting tricep strength with close grip bench pressing',            @piros_id),
  ('Squat and deadlift combo session', 'A session pairing squat and deadlift work for posterior chain overload',        @piros_id),
  ('Lower body accessory session',     'A session targeting weak points in the lower body pull and squat pattern',      @piros_id),
  -- vasily: additional endurance and conditioning sessions
  ('Bike endurance session',           'A long steady-state cycling session for aerobic base development',              @vasily_id),
  ('Swim technique session',           'A session improving swim stroke mechanics and breathing pattern',               @vasily_id),
  ('Hill sprints session',             'A session performing repeated hill sprints for speed-endurance',                @vasily_id),
  ('Fartlek session',                  'An unstructured running session alternating between fast and slow efforts',     @vasily_id),
  ('Track interval session',           'A structured track session targeting VO2max through short intervals',           @vasily_id),
  ('Recovery run session',             'A very low intensity run to promote blood flow and active recovery',            @vasily_id),
  ('Circuit training session',         'A full body circuit session combining strength and cardio elements',            @vasily_id),
  ('Stair climbing session',           'A session using stair climbing for lower body endurance and power',             @vasily_id),
  ('Core stability session',           'A session targeting deep core stability and anti-rotation strength',            @vasily_id),
  ('Cross-training session',           'A mixed-modality session combining rowing, cycling, and running',              @vasily_id),
  -- asen: additional body composition sessions
  ('Chest specialisation session',     'A high-volume session targeting chest from multiple angles',                    @asen_id),
  ('Back specialisation session',      'A high-volume session targeting lat, rhomboid, and trap development',           @asen_id),
  ('Glute and hamstring session',      'A session targeting glute and hamstring hypertrophy through hip hinge movements', @asen_id),
  ('Shoulder specialisation session',  'A high-volume session targeting all three deltoid heads',                       @asen_id),
  ('Arm specialisation session',       'A session combining high-volume bicep and tricep isolation work',               @asen_id),
  ('HIIT session',                     'A high-intensity interval training session for fat loss and conditioning',      @asen_id),
  ('Upper body pump session',          'A moderate-weight high-rep session targeting upper body muscle fullness',       @asen_id),
  ('Lower body pump session',          'A moderate-weight high-rep session targeting lower body muscle fullness',       @asen_id),
  ('Abs and core session',             'A session targeting rectus abdominis, obliques, and core stability',            @asen_id),
  ('Full body circuit session',        'A full body circuit targeting all major muscle groups for conditioning',        @asen_id),
  -- valerios: additional longevity and power sessions
  ('Box jump session',                 'A plyometric session using box jumps for lower body power development',         @valerios_id),
  ('Medicine ball session',            'An explosive session using medicine ball throws for upper body power',          @valerios_id),
  ('Kettlebell session',               'A session using kettlebell swings and carries for full body conditioning',      @valerios_id),
  ('Balance and coordination session', 'A session targeting proprioception, balance, and movement coordination',        @valerios_id),
  ('Hip hinge session',                'A session drilling the hip hinge pattern for posterior chain health',           @valerios_id),
  ('Upper body resistance session',    'A moderate-intensity upper body session for strength maintenance',              @valerios_id),
  ('Lower body resistance session',    'A moderate-intensity lower body session for functional strength',               @valerios_id),
  ('Loaded carry session',             'A session using farmers walks and suitcase carries for full body stability',    @valerios_id),
  ('Flexibility and stretching session', 'A dedicated flexibility session targeting major muscle groups',               @valerios_id),
  ('Tendon conditioning session',      'A session using isometric and eccentric work to condition tendons',             @valerios_id);

-- -----------------------------------------------------
-- training_plan_has_training_blocks
-- -----------------------------------------------------
SET @plan_2026_comp        = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = '2026 competition plan');
SET @plan_2025_comp        = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = '2025 competition plan');
SET @plan_off_hypertrophy  = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'off-season hypertrophy');
SET @plan_beach_body       = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'summer beach body plan');
SET @plan_fat_loss         = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'fat loss plan');
SET @plan_abs_strength     = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'absolute strength plan');
SET @plan_peaking          = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'peaking block');
SET @plan_endurance        = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'endurance base build');
SET @plan_technique        = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'technique refinement plan');
SET @plan_pl_prep          = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'powerlifting prep');
SET @plan_tendon           = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'tendon conditioning plan');
SET @plan_senior           = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'senior maintenance plan');
SET @plan_power_dev        = (SELECT `training_plan_id` FROM `training_plans` WHERE `name` = 'power development plan');

SET @block_2026_accum      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2026 accumulation phase');
SET @block_2026_trans      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2026 transmutation phase');
SET @block_2026_real       = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2026 realisation phase');
SET @block_2025_accum      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2025 accumulation phase');
SET @block_2025_trans      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2025 transmutation phase');
SET @block_2025_real       = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = '2025 realisation phase');
SET @block_clean_bulk      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'clean bulk');
SET @block_dirty_bulk      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'dirty bulk');
SET @block_pl_strength     = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'powerlifting strength block');
SET @block_deload          = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'deload week');
SET @block_str_foundation  = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'strength foundation block');
SET @block_intensity_ramp  = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'intensity ramp block');
SET @block_peaking         = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'peaking block');
SET @block_aerobic_base    = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'aerobic base block');
SET @block_technique       = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'technique drilling block');
SET @block_lactate         = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'lactate threshold block');
SET @block_hypertrophy     = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'hypertrophy block');
SET @block_cut             = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'cut block');
SET @block_maintenance     = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'maintenance block');
SET @block_joint_prep      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'joint prep block');
SET @block_power_dev       = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'power development block');
SET @block_senior_str      = (SELECT `training_block_id` FROM `training_blocks` WHERE `name` = 'senior strength block');

INSERT INTO `training_plan_has_training_blocks` (`training_plan_id`, `training_block_id`) VALUES
  -- anatoly: 2026 competition plan (full periodization cycle)
  (@plan_2026_comp,       @block_2026_accum),
  (@plan_2026_comp,       @block_2026_trans),
  (@plan_2026_comp,       @block_2026_real),
  -- anatoly: 2025 competition plan (full periodization cycle)
  (@plan_2025_comp,       @block_2025_accum),
  (@plan_2025_comp,       @block_2025_trans),
  (@plan_2025_comp,       @block_2025_real),
  -- anatoly: off-season hypertrophy (accumulation + deload)
  (@plan_off_hypertrophy, @block_2026_accum),
  (@plan_off_hypertrophy, @block_deload),
  -- naim: powerlifting prep (bulk → strength → deload)
  (@plan_pl_prep,         @block_clean_bulk),
  (@plan_pl_prep,         @block_pl_strength),
  (@plan_pl_prep,         @block_deload),
  -- naim: tendon conditioning plan
  (@plan_tendon,          @block_dirty_bulk),
  (@plan_tendon,          @block_pl_strength),
  -- piros: absolute strength plan (foundation → intensity ramp)
  (@plan_abs_strength,    @block_str_foundation),
  (@plan_abs_strength,    @block_intensity_ramp),
  -- piros: peaking plan (intensity ramp → peak → deload)
  (@plan_peaking,         @block_intensity_ramp),
  (@plan_peaking,         @block_peaking),
  (@plan_peaking,         @block_deload),
  -- vasily: endurance base build (aerobic base → lactate threshold)
  (@plan_endurance,       @block_aerobic_base),
  (@plan_endurance,       @block_lactate),
  -- vasily: technique refinement plan
  (@plan_technique,       @block_technique),
  (@plan_technique,       @block_aerobic_base),
  -- asen: summer beach body (hypertrophy → cut)
  (@plan_beach_body,      @block_hypertrophy),
  (@plan_beach_body,      @block_cut),
  -- asen: fat loss plan (cut → maintenance)
  (@plan_fat_loss,        @block_cut),
  (@plan_fat_loss,        @block_maintenance),
  -- valerios: senior maintenance plan (joint prep → senior strength)
  (@plan_senior,          @block_joint_prep),
  (@plan_senior,          @block_senior_str),
  -- valerios: power development plan (joint prep → power dev)
  (@plan_power_dev,       @block_joint_prep),
  (@plan_power_dev,       @block_power_dev);

-- -----------------------------------------------------
-- training_block_has_sessions
-- -----------------------------------------------------
-- Anatoly sessions
SET @sess_clean_jerk_str   = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session');
SET @sess_snatch_tech      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session');
SET @sess_front_squat      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Front squat session');
SET @sess_back_squat       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back squat session');
SET @sess_pulls_dl         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pulls and deadlifts session');
SET @sess_snatch_max       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session');
SET @sess_power_snatch     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power snatch session');
SET @sess_power_clean      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session');
SET @sess_muscle_snatch    = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Muscle snatch session');
SET @sess_snatch_balance   = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch balance session');
SET @sess_overhead_squat   = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Overhead squat session');
SET @sess_clean_pull       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean pull session');
SET @sess_snatch_pull      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch pull session');
SET @sess_jerk_tech        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Jerk technique session');
SET @sess_cj_complex       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean and jerk complex session');

-- Naim sessions
SET @sess_chest_tri        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps');
SET @sess_back_bi          = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps');
SET @sess_shoulders_traps  = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps');
SET @sess_legs             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Legs');
SET @sess_arms             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Arms');
SET @sess_heavy_squat      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session');
SET @sess_rdl              = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session');
SET @sess_incline_bench    = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Incline bench session');
SET @sess_lateral_raise    = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lateral raise specialisation');
SET @sess_rear_delt        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rear delt and face pull session');
SET @sess_leg_press        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg press and leg curl session');
SET @sess_pullups_rows     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull-ups and rows session');
SET @sess_tricep_spec      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tricep specialisation session');
SET @sess_bicep_spec       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bicep specialisation session');
SET @sess_calf_forearm     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Calf and forearm session');

-- Piros sessions
SET @sess_squat_day        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat day');
SET @sess_bench_day        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day');
SET @sess_deadlift_day     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day');
SET @sess_upper_acc        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body accessory day');
SET @sess_max_squat        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort squat session');
SET @sess_de_squat         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort squat session');
SET @sess_max_bench        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session');
SET @sess_de_bench         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort bench session');
SET @sess_max_deadlift     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session');
SET @sess_de_deadlift      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort deadlift session');
SET @sess_pause_squat      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pause squat session');
SET @sess_cg_bench         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Close grip bench session');
SET @sess_squat_dl_combo   = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat and deadlift combo session');
SET @sess_lower_acc        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body accessory session');

-- Vasily sessions
SET @sess_tempo_run        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session');
SET @sess_interval_run     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Interval training session');
SET @sess_long_run         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Long run session');
SET @sess_rowing_endo      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session');
SET @sess_bike_endo        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bike endurance session');
SET @sess_swim_tech        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session');
SET @sess_hill_sprints     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Hill sprints session');
SET @sess_fartlek          = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Fartlek session');
SET @sess_track_interval   = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Track interval session');
SET @sess_recovery_run     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Recovery run session');
SET @sess_circuit          = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Circuit training session');
SET @sess_stairs           = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Stair climbing session');
SET @sess_core_stab        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Core stability session');
SET @sess_cross_train      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cross-training session');

-- Asen sessions
SET @sess_push             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day');
SET @sess_pull             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day');
SET @sess_leg_day          = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day');
SET @sess_cardio_core      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session');
SET @sess_chest_spec       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest specialisation session');
SET @sess_back_spec        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back specialisation session');
SET @sess_glute_ham        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Glute and hamstring session');
SET @sess_shoulder_spec    = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulder specialisation session');
SET @sess_arm_spec         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Arm specialisation session');
SET @sess_hiit             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session');
SET @sess_upper_pump       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body pump session');
SET @sess_lower_pump       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body pump session');
SET @sess_abs_core         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Abs and core session');
SET @sess_full_circuit     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body circuit session');

-- Valerios sessions
SET @sess_mobility         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Mobility and prehab session');
SET @sess_plyo             = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session');
SET @sess_full_strength    = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session');
SET @sess_box_jump         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session');
SET @sess_med_ball         = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Medicine ball session');
SET @sess_kettlebell       = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session');
SET @sess_balance          = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Balance and coordination session');
SET @sess_hip_hinge        = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Hip hinge session');
SET @sess_upper_resist     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body resistance session');
SET @sess_lower_resist     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body resistance session');
SET @sess_loaded_carry     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Loaded carry session');
SET @sess_flex_stretch     = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Flexibility and stretching session');
SET @sess_tendon_cond      = (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tendon conditioning session');

INSERT INTO `training_block_has_sessions` (`training_block_id`, `session_id`) VALUES
  -- Anatoly: 2026 accumulation phase
  (@block_2026_accum, @sess_clean_jerk_str),
  (@block_2026_accum, @sess_snatch_tech),
  (@block_2026_accum, @sess_front_squat),
  (@block_2026_accum, @sess_back_squat),
  (@block_2026_accum, @sess_pulls_dl),
  -- Anatoly: 2026 transmutation phase
  (@block_2026_trans, @sess_snatch_max),
  (@block_2026_trans, @sess_power_snatch),
  (@block_2026_trans, @sess_power_clean),
  -- Anatoly: 2026 realisation phase
  (@block_2026_real, @sess_clean_jerk_str),
  (@block_2026_real, @sess_snatch_tech),
  -- Anatoly: 2025 accumulation phase
  (@block_2025_accum, @sess_muscle_snatch),
  (@block_2025_accum, @sess_snatch_balance),
  (@block_2025_accum, @sess_overhead_squat),
  (@block_2025_accum, @sess_clean_pull),
  (@block_2025_accum, @sess_snatch_pull),
  -- Anatoly: 2025 transmutation phase
  (@block_2025_trans, @sess_jerk_tech),
  (@block_2025_trans, @sess_cj_complex),
  (@block_2025_trans, @sess_power_clean),
  -- Anatoly: 2025 realisation phase
  (@block_2025_real, @sess_clean_jerk_str),
  (@block_2025_real, @sess_cj_complex),
  -- Naim: clean bulk
  (@block_clean_bulk, @sess_chest_tri),
  (@block_clean_bulk, @sess_back_bi),
  (@block_clean_bulk, @sess_shoulders_traps),
  (@block_clean_bulk, @sess_legs),
  (@block_clean_bulk, @sess_arms),
  -- Naim: dirty bulk
  (@block_dirty_bulk, @sess_heavy_squat),
  (@block_dirty_bulk, @sess_rdl),
  (@block_dirty_bulk, @sess_incline_bench),
  (@block_dirty_bulk, @sess_lateral_raise),
  -- Naim: powerlifting strength block
  (@block_pl_strength, @sess_chest_tri),
  (@block_pl_strength, @sess_legs),
  (@block_pl_strength, @sess_rear_delt),
  (@block_pl_strength, @sess_pullups_rows),
  -- Naim: deload week
  (@block_deload, @sess_mobility),
  -- Piros: strength foundation block
  (@block_str_foundation, @sess_squat_day),
  (@block_str_foundation, @sess_bench_day),
  (@block_str_foundation, @sess_deadlift_day),
  (@block_str_foundation, @sess_upper_acc),
  -- Piros: intensity ramp block
  (@block_intensity_ramp, @sess_max_squat),
  (@block_intensity_ramp, @sess_max_bench),
  (@block_intensity_ramp, @sess_max_deadlift),
  (@block_intensity_ramp, @sess_lower_acc),
  -- Piros: peaking block
  (@block_peaking, @sess_pause_squat),
  (@block_peaking, @sess_cg_bench),
  (@block_peaking, @sess_max_squat),
  -- Vasily: aerobic base block
  (@block_aerobic_base, @sess_long_run),
  (@block_aerobic_base, @sess_rowing_endo),
  (@block_aerobic_base, @sess_bike_endo),
  (@block_aerobic_base, @sess_recovery_run),
  -- Vasily: technique drilling block
  (@block_technique, @sess_swim_tech),
  (@block_technique, @sess_circuit),
  -- Vasily: lactate threshold block
  (@block_lactate, @sess_tempo_run),
  (@block_lactate, @sess_interval_run),
  (@block_lactate, @sess_hill_sprints),
  (@block_lactate, @sess_track_interval),
  -- Asen: hypertrophy block
  (@block_hypertrophy, @sess_chest_spec),
  (@block_hypertrophy, @sess_back_spec),
  (@block_hypertrophy, @sess_glute_ham),
  (@block_hypertrophy, @sess_shoulder_spec),
  (@block_hypertrophy, @sess_arm_spec),
  (@block_hypertrophy, @sess_upper_pump),
  (@block_hypertrophy, @sess_lower_pump),
  -- Asen: cut block
  (@block_cut, @sess_push),
  (@block_cut, @sess_pull),
  (@block_cut, @sess_leg_day),
  (@block_cut, @sess_hiit),
  (@block_cut, @sess_cardio_core),
  -- Asen: maintenance block
  (@block_maintenance, @sess_push),
  (@block_maintenance, @sess_leg_day),
  (@block_maintenance, @sess_abs_core),
  -- Valerios: joint prep block
  (@block_joint_prep, @sess_mobility),
  (@block_joint_prep, @sess_flex_stretch),
  (@block_joint_prep, @sess_balance),
  -- Valerios: power development block
  (@block_power_dev, @sess_plyo),
  (@block_power_dev, @sess_box_jump),
  (@block_power_dev, @sess_med_ball),
  (@block_power_dev, @sess_kettlebell),
  -- Valerios: senior strength block
  (@block_senior_str, @sess_full_strength),
  (@block_senior_str, @sess_hip_hinge),
  (@block_senior_str, @sess_upper_resist),
  (@block_senior_str, @sess_lower_resist),
  (@block_senior_str, @sess_loaded_carry),
  (@block_senior_str, @sess_tendon_cond);
