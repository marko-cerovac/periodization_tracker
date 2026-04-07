-- Periodization Tracker - Seed Data
USE periodization_tracker;

-- -----------------------------------------------------
-- users
-- -----------------------------------------------------
INSERT INTO `users` (`username`, `password`, `gender`) VALUES
  ('anatoly_pisarenko', '4eNmC2SXiAO41mwwH0xAEFmDnQCphGzPR5WP+WLtTkw=', 'Male'),
  ('vasily_alexeev',    'PHq+Du3qTe/lsxmv/Jpila2U362tUZh2pMPsrDARAvg=', 'Female'),
  ('asen_zlatev',       '$2a$10$abcdefghijklmnopqrstuv', 'Male'),
  ('naim_suleymanoglu', '$2a$10$zyxwvutsrqponmlkjihgf', 'Female'),
  ('piros_dimas',       '$2a$10$abcdefghijklmnopqrstuv', 'AlphabetPerson'),
  ('valerios_leonidis', '$2a$10$zyxwvutsrqponmlkjihgf', 'Male');

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
  ('balance'),
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
INSERT INTO `sessions` (`name`, `description`) VALUES
  -- anatoly: olympic weightlifting sessions
  ('Clean&Jerk strength session',  'A session that works on strength in the clean&jerk'),
  ('Snatch technique session',     'A session focused on snatch technique and positional work'),
  ('Front squat session',          'A heavy front squat session for leg strength'),
  ('Back squat session',           'A heavy back squat session for posterior chain development'),
  ('Pulls and deadlifts session',  'A session targeting clean and snatch pulls and deadlifts'),
  -- naim: bodybuilding-style splits
  ('Chest and Triceps',            'A heavy chest and triceps session'),
  ('Back and Biceps',              'A heavy back and biceps session'),
  ('Shoulders and Traps',          'A shoulder and trap isolation session'),
  ('Legs',                         'A full leg session targeting quads, hamstrings, and glutes'),
  ('Arms',                         'An isolation session for biceps and triceps volume'),
  -- piros: powerlifting sessions
  ('Squat day',                    'A competition squat session with accessory work'),
  ('Bench press day',              'A competition bench press session with accessory work'),
  ('Deadlift day',                 'A competition deadlift session with accessory work'),
  ('Upper body accessory day',     'A session targeting upper body weak points'),
  -- vasily: endurance and conditioning
  ('Tempo run session',            'A moderate-intensity steady-state running session'),
  ('Interval training session',    'A high-intensity interval running session'),
  ('Long run session',             'A low-intensity long-distance endurance run'),
  ('Rowing endurance session',     'A long-duration low-intensity rowing session'),
  -- asen: body composition
  ('Push day',                     'A push session targeting chest, shoulders, and triceps'),
  ('Pull day',                     'A pull session targeting back and biceps'),
  ('Leg day',                      'A leg session targeting quads, hamstrings, glutes, and calves'),
  ('Cardio and core session',      'A conditioning session combining cardio and core work'),
  -- valerios: mobility and power
  ('Mobility and prehab session',  'A session focused on joint mobility and injury prevention'),
  ('Plyometric session',           'An explosive plyometric session for power development'),
  ('Full body strength session',   'A full body compound movement session for strength maintenance'),
  -- anatoly: additional olympic weightlifting sessions
  ('Snatch max effort session',        'A session targeting a heavy single in the snatch'),
  ('Power snatch session',             'A session developing the power snatch from the hang and floor'),
  ('Power clean session',              'A session developing the power clean for rate of force development'),
  ('Muscle snatch session',            'A technique session using the muscle snatch to reinforce the turnover'),
  ('Snatch balance session',           'A session drilling the snatch balance for overhead stability'),
  ('Overhead squat session',           'A session targeting overhead squat strength and positional control'),
  ('Clean pull session',               'A session focusing on clean pulls for posterior chain and bar speed'),
  ('Snatch pull session',              'A session focusing on snatch pulls for back and trap development'),
  ('Jerk technique session',           'A session dedicated to jerk footwork, timing, and lockout'),
  ('Clean and jerk complex session',   'A session combining multiple C&J variations into a single complex'),
  -- naim: additional bodybuilding sessions
  ('Heavy squat session',              'A low-rep high-intensity squat session for strength development'),
  ('Romanian deadlift session',        'A session targeting hamstrings and glutes through RDLs'),
  ('Incline bench session',            'A session targeting the upper chest with incline pressing variations'),
  ('Lateral raise specialisation',     'A high-volume session targeting side deltoid development'),
  ('Rear delt and face pull session',  'A session targeting rear delts and external rotators for shoulder health'),
  ('Leg press and leg curl session',   'A machine-based leg session targeting quads and hamstrings'),
  ('Pull-ups and rows session',        'A session targeting lat width and mid-back thickness'),
  ('Tricep specialisation session',    'A high-volume isolation session for tricep development'),
  ('Bicep specialisation session',     'A high-volume isolation session for bicep and brachialis development'),
  ('Calf and forearm session',         'A session targeting calf hypertrophy and forearm strength'),
  -- piros: additional powerlifting sessions
  ('Max effort squat session',         'A session working up to a heavy squat variation single'),
  ('Dynamic effort squat session',     'A session performing speed squats against bands or chains'),
  ('Max effort bench session',         'A session working up to a heavy bench press variation single'),
  ('Dynamic effort bench session',     'A session performing speed bench press for rate of force development'),
  ('Max effort deadlift session',      'A session working up to a heavy deadlift variation single'),
  ('Dynamic effort deadlift session',  'A session performing speed pulls for explosive hip extension'),
  ('Pause squat session',              'A session using paused squats to build strength out of the hole'),
  ('Close grip bench session',         'A session targeting tricep strength with close grip bench pressing'),
  ('Squat and deadlift combo session', 'A session pairing squat and deadlift work for posterior chain overload'),
  ('Lower body accessory session',     'A session targeting weak points in the lower body pull and squat pattern'),
  -- vasily: additional endurance and conditioning sessions
  ('Bike endurance session',           'A long steady-state cycling session for aerobic base development'),
  ('Swim technique session',           'A session improving swim stroke mechanics and breathing pattern'),
  ('Hill sprints session',             'A session performing repeated hill sprints for speed-endurance'),
  ('Fartlek session',                  'An unstructured running session alternating between fast and slow efforts'),
  ('Track interval session',           'A structured track session targeting VO2max through short intervals'),
  ('Recovery run session',             'A very low intensity run to promote blood flow and active recovery'),
  ('Circuit training session',         'A full body circuit session combining strength and cardio elements'),
  ('Stair climbing session',           'A session using stair climbing for lower body endurance and power'),
  ('Core stability session',           'A session targeting deep core stability and anti-rotation strength'),
  ('Cross-training session',           'A mixed-modality session combining rowing, cycling, and running'),
  -- asen: additional body composition sessions
  ('Chest specialisation session',     'A high-volume session targeting chest from multiple angles'),
  ('Back specialisation session',      'A high-volume session targeting lat, rhomboid, and trap development'),
  ('Glute and hamstring session',      'A session targeting glute and hamstring hypertrophy through hip hinge movements'),
  ('Shoulder specialisation session',  'A high-volume session targeting all three deltoid heads'),
  ('Arm specialisation session',       'A session combining high-volume bicep and tricep isolation work'),
  ('HIIT session',                     'A high-intensity interval training session for fat loss and conditioning'),
  ('Upper body pump session',          'A moderate-weight high-rep session targeting upper body muscle fullness'),
  ('Lower body pump session',          'A moderate-weight high-rep session targeting lower body muscle fullness'),
  ('Abs and core session',             'A session targeting rectus abdominis, obliques, and core stability'),
  ('Full body circuit session',        'A full body circuit targeting all major muscle groups for conditioning'),
  -- valerios: additional longevity and power sessions
  ('Box jump session',                 'A plyometric session using box jumps for lower body power development'),
  ('Medicine ball session',            'An explosive session using medicine ball throws for upper body power'),
  ('Kettlebell session',               'A session using kettlebell swings and carries for full body conditioning'),
  ('Balance and coordination session', 'A session targeting proprioception, balance, and movement coordination'),
  ('Hip hinge session',                'A session drilling the hip hinge pattern for posterior chain health'),
  ('Upper body resistance session',    'A moderate-intensity upper body session for strength maintenance'),
  ('Lower body resistance session',    'A moderate-intensity lower body session for functional strength'),
  ('Loaded carry session',             'A session using farmers walks and suitcase carries for full body stability'),
  ('Flexibility and stretching session', 'A dedicated flexibility session targeting major muscle groups'),
  ('Tendon conditioning session',      'A session using isometric and eccentric work to condition tendons');


-- -----------------------------------------------------
-- exercises
-- -----------------------------------------------------
SET @barbell_exercise_type    = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='barbell');
SET @dumbell_exercise_type    = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='dumbell');
SET @freeweight_exercise_type = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='freeweight');
SET @cardio_exercise_type     = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='cardio-vascular');
SET @calistenic_exercise_type = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='calistenic');
SET @pliometric_exercise_type = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='pliometric');
SET @isometric_exercise_type  = (SELECT `exercise_type_id` FROM `exercise_types` WHERE `name` ='isometric');

INSERT INTO `exercises` (`name`, `description`, `exercise_type_id`) VALUES
  -- Barbell exercises
  ('Clean&Jerk', 'One of the two basic olympic movements', @barbell_exercise_type),
  ('Snatch', 'One of the two basic olympic movements', @barbell_exercise_type),
  ('Clean Pull', 'Tall variation of the Clean&Jerk movement', @barbell_exercise_type),
  ('Snatch Pull', 'Tall variation of the snatch movement', @barbell_exercise_type),
  ('Back Squat', 'A compound lower body movement targeting quads, hamstrings, and glutes', @barbell_exercise_type),
  ('Front Squat', 'A compound lower body movement with emphasis on quads and core', @barbell_exercise_type),
  ('Deadlift', 'A fundamental compound movement targeting the entire posterior chain', @barbell_exercise_type),
  ('Bench Press', 'A fundamental upper body pressing movement targeting chest, shoulders, and triceps', @barbell_exercise_type),
  ('Overhead Press', 'A standing shoulder pressing movement targeting delts, triceps, and core', @barbell_exercise_type),
  ('Bent Over Row', 'A compound pulling movement targeting back and biceps', @barbell_exercise_type),
  ('Romanian Deadlift', 'A hip-hinge movement emphasizing hamstrings and lower back', @barbell_exercise_type),
  ('Power Clean', 'An explosive olympic variation emphasizing power development', @barbell_exercise_type),
  ('Power Snatch', 'An explosive olympic variation emphasizing speed and power', @barbell_exercise_type),
  ('Push Press', 'A standing shoulder press variation using leg drive', @barbell_exercise_type),
  ('Close Grip Bench Press', 'A bench press variation with closer grip targeting triceps', @barbell_exercise_type),
  ('Lat Pulldown', 'A lat exercise that uses vertical pulling', @barbell_exercise_type),
  -- Dumbbell exercises
  ('Dumbbell Bench Press', 'A horizontal pressing movement offering greater range of motion', @dumbell_exercise_type),
  ('Dumbbell Row', 'A single-arm rowing movement targeting back and biceps', @dumbell_exercise_type),
  ('Dumbbell Overhead Press', 'A shoulder pressing movement with dumbbells', @dumbell_exercise_type),
  ('Dumbbell Curl', 'An isolation movement for bicep development', @dumbell_exercise_type),
  ('Dumbbell Lateral Raise', 'An isolation movement targeting side deltoids', @dumbell_exercise_type),
  ('Dumbbell Squat', 'A goblet-style squat variation using dumbbells', @dumbell_exercise_type),
  ('Dumbbell Deadlift', 'A deadlift variation using dumbbells', @dumbell_exercise_type),
  -- Freeweight exercises
  ('Pull up', 'A movement in which a person pulls themselves up on a bar', @freeweight_exercise_type),
  ('Chin up', 'An underhand grip pull-up variation targeting biceps', @freeweight_exercise_type),
  ('Push up', 'A bodyweight pressing movement targeting chest, shoulders, and triceps', @freeweight_exercise_type),
  ('Dip', 'A compound upper body pressing movement using body weight', @freeweight_exercise_type),
  ('L-sit', 'An isometric core and shoulder stability movement', @freeweight_exercise_type),
  ('Handstand Hold', 'An inverted balance movement targeting shoulders and core', @freeweight_exercise_type),
  -- Cardio-vascular exercises
  ('Running', 'Steady-state or interval running for cardiovascular conditioning', @cardio_exercise_type),
  ('Cycling', 'Stationary or outdoor cycling for aerobic development', @cardio_exercise_type),
  ('Rowing', 'Machine-based rowing for full-body cardiovascular work', @cardio_exercise_type),
  ('Swimming', 'Pool-based aerobic activity targeting all major muscle groups', @cardio_exercise_type),
  ('Jump Rope', 'A high-intensity conditioning tool for footwork and coordination', @cardio_exercise_type),
  ('Stair Climbing', 'A lower body intensive cardio movement', @cardio_exercise_type),
  -- Calisthenic exercises
  ('Bodyweight Squat', 'A fundamental lower body movement using only body weight', @calistenic_exercise_type),
  ('Bodyweight Lunge', 'A unilateral lower body movement for leg strength and balance', @calistenic_exercise_type),
  ('Pike Push up', 'A shoulder-focused calisthenic movement', @calistenic_exercise_type),
  ('Diamond Push up', 'A tricep-focused push-up variation', @calistenic_exercise_type),
  ('Plank', 'A core stability isometric movement', @calistenic_exercise_type),
  ('Hollow Body Hold', 'A gymnastics core position for stability and rigidity', @calistenic_exercise_type),
  -- Plyometric exercises
  ('Box Jump', 'An explosive lower body movement targeting power and coordination', @pliometric_exercise_type),
  ('Broad Jump', 'A horizontal jump movement for lower body power', @pliometric_exercise_type),
  ('Burpee', 'A full-body explosive movement combining jumping and pushing', @pliometric_exercise_type),
  ('Medicine Ball Throw', 'An explosive upper body throwing movement for power development', @pliometric_exercise_type),
  ('Jump Lunge', 'An explosive unilateral lower body movement', @pliometric_exercise_type),
  ('Clap Push up', 'An upper body plyometric variation targeting explosive power', @pliometric_exercise_type),
  ('Kettlebell Swing', 'A dynamic hip-hinge explosive movement for power and conditioning', @pliometric_exercise_type),
  -- Isometric exercises
  ('Wall Sit', 'An isometric lower body hold targeting quads', @isometric_exercise_type),
  ('Dead Bug Hold', 'An isometric core stability movement', @isometric_exercise_type),
  ('Pallof Hold', 'An isometric anti-rotation core exercise', @isometric_exercise_type),
  ('Suitcase Carry', 'An isometric core stability loaded carry', @isometric_exercise_type),
  ('Farmers Carry', 'A bilateral loaded carry for grip and core strength', @isometric_exercise_type),
  -- Additional barbell exercises
  ('Incline Bench Press', 'An upper chest and front delt focused pressing variation', @barbell_exercise_type),
  ('Decline Bench Press', 'A lower chest focused pressing variation', @barbell_exercise_type),
  ('Pendulum Squat', 'A machine-based squat variation with angle adjustment', @barbell_exercise_type),
  ('Pause Squat', 'A squat variation with a pause at the bottom for strength development', @barbell_exercise_type),
  ('Pin Press', 'A pressing variation starting from a dead stop to build lock-out strength', @barbell_exercise_type),
  ('Deficit Deadlift', 'A deadlift variation performed from an elevated platform for increased range of motion', @barbell_exercise_type),
  ('Sumo Deadlift', 'A wide-stance deadlift variation emphasizing quads and adductors', @barbell_exercise_type),
  ('Trap Bar Deadlift', 'A neutral-grip deadlift variation reducing stress on lower back', @barbell_exercise_type),
  ('High Bar Squat', 'A squat variation with bar positioned high on traps for increased quad emphasis', @barbell_exercise_type),
  ('Hack Squat', 'A machine-based squat with locked torso angle', @barbell_exercise_type),
  -- Additional dumbbell exercises
  ('Dumbbell Turkish Get-up', 'A complex full-body movement combining strength and mobility', @dumbell_exercise_type),
  ('Dumbbell Pulover', 'A chest and shoulder stretch-based movement', @dumbell_exercise_type),
  ('Dumbbell Fly', 'An isolation pectoral movement', @dumbell_exercise_type),
  ('Dumbbell Tricep Extension', 'An isolation tricep movement', @dumbell_exercise_type),
  ('Dumbbell Hammer Curl', 'A bicep variation with neutral grip', @dumbell_exercise_type),
  ('Dumbbell Front Raise', 'An isolation front deltoid movement', @dumbell_exercise_type),
  ('Dumbbell Reverse Fly', 'An isolation rear deltoid movement', @dumbell_exercise_type),
  ('Dumbbell Step-up', 'A unilateral lower body movement emphasizing quads', @dumbell_exercise_type),
  ('Dumbbell Bulgarian Split Squat', 'A unilateral lower body movement with rear foot elevated', @dumbell_exercise_type),
  ('Dumbbell Suitcase Carry', 'An anti-lateral flexion core movement', @dumbell_exercise_type),
  -- Additional freeweight exercises
  ('Muscle Up', 'A gymnastics movement combining pull-up and dip', @freeweight_exercise_type),
  ('Pseudo Planche Push-up', 'A strength-building variation working towards planche', @freeweight_exercise_type),
  ('Archer Push-up', 'A unilateral push-up progression', @freeweight_exercise_type),
  ('Typewriter Pull-up', 'A lateral pull-up variation', @freeweight_exercise_type),
  ('Explosive Push-up', 'A plyometric upper body variation', @freeweight_exercise_type),
  ('Decline Push-up', 'A feet-elevated push-up variation targeting upper chest', @freeweight_exercise_type),
  ('Bulgarian Bodyweight Squat', 'A unilateral squat with rear foot elevated', @freeweight_exercise_type),
  ('Pistol Squat', 'A single-leg squat requiring extreme mobility and strength', @freeweight_exercise_type),
  ('Shrimp Squat', 'A single-leg squat variation', @freeweight_exercise_type),
  ('Human Flag Hold', 'An advanced gymnastics shoulder strength hold', @freeweight_exercise_type),
  -- Additional cardio-vascular exercises
  ('Elliptical', 'Low-impact cardiovascular machine', @cardio_exercise_type),
  ('Treadmill Sprint', 'High-intensity short-duration running', @cardio_exercise_type),
  ('Rowing Machine Interval', 'High-intensity interval rowing', @cardio_exercise_type),
  ('Battle Ropes', 'A full-body high-intensity conditioning tool', @cardio_exercise_type),
  ('Assault Bike Sprint', 'High-intensity air-resistance biking', @cardio_exercise_type),
  ('Sled Push', 'An anaerobic lower body conditioning movement', @cardio_exercise_type),
  ('Sled Drag', 'A loaded carry variation with resistance', @cardio_exercise_type),
  ('Tire Flip', 'A full-body explosive movement for power and conditioning', @cardio_exercise_type),
  ('Rope Climb', 'An upper body and grip strength intensive movement', @cardio_exercise_type),
  ('Obstacle Course Sprint', 'A complex movement pattern running combined with obstacles', @cardio_exercise_type),
  -- Additional calisthenic exercises
  ('Decline Sit-up', 'A core movement on an inclined surface', @calistenic_exercise_type),
  ('Hanging Knee Raise', 'A suspended core movement targeting lower abs', @calistenic_exercise_type),
  ('Parallel Bar Dip', 'A compound upper body pressing movement', @calistenic_exercise_type),
  ('Reverse Hyperextension', 'A posterior chain and lower back movement', @calistenic_exercise_type),
  ('Inchworm', 'A full-body dynamic stretching and strength movement', @calistenic_exercise_type),
  ('Bear Crawl', 'A locomotive movement targeting core and shoulder stability', @calistenic_exercise_type),
  ('Leopard Crawl', 'A lateral crawling pattern for shoulder stability', @calistenic_exercise_type),
  ('Crab Walk', 'A posterior-facing crawl targeting shoulders and glutes', @calistenic_exercise_type),
  ('Nordic Hamstring Curl', 'A eccentric hamstring-focused movement', @calistenic_exercise_type),
  ('Pistol Squat Progression', 'A single-leg squat training progression', @calistenic_exercise_type),
  -- Additional plyometric exercises
  ('Depth Jump', 'A drop from height followed by maximal rebound', @pliometric_exercise_type),
  ('Lateral Bound', 'A lateral explosive movement for side-to-side power', @pliometric_exercise_type),
  ('Single-leg Hop', 'A unilateral explosive movement for single-leg power', @pliometric_exercise_type),
  ('Tuck Jump', 'An explosive vertical jump with knee drive', @pliometric_exercise_type),
  ('Bounding', 'An explosive running movement emphasizing power', @pliometric_exercise_type),
  ('Kettlebell Snatch', 'An explosive hip extension movement', @pliometric_exercise_type),
  ('Kettlebell Clean', 'A dynamic kettlebell pulling movement', @pliometric_exercise_type),
  ('Wall Ball Throw', 'An explosive full-body throwing movement', @pliometric_exercise_type),
  ('Slam Ball', 'An overhead explosive throwing movement', @pliometric_exercise_type),
  ('Plyometric Lunge', 'An explosive alternating lunge movement', @pliometric_exercise_type),
  -- Additional isometric exercises
  ('Half Kneeling Carry', 'An asymmetrical loaded carry for core and glute stability', @isometric_exercise_type),
  ('Bottom Position Squat Hold', 'An isometric squat hold at the bottom position', @isometric_exercise_type),
  ('Overhead Carry', 'A loaded overhead carry for shoulder stability', @isometric_exercise_type),
  ('Bear Hug Carry', 'A chest-held loaded carry for core stability', @isometric_exercise_type),
  ('Single-leg Stance', 'A balance and proprioception movement', @isometric_exercise_type),
  ('Handstand Hold Against Wall', 'A shoulder and core isometric hold', @isometric_exercise_type),
  ('Dead Hang', 'A suspended grip and shoulder stability movement', @isometric_exercise_type),
  ('Reverse Plank', 'A posterior chain isometric movement', @isometric_exercise_type),
  ('Side Plank', 'A lateral core stability isometric movement', @isometric_exercise_type),
  ('Jefferson Curl Hold', 'A spinal mobility and core stability position', @isometric_exercise_type);


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

-- -----------------------------------------------------
-- exercise_targets_pp_aspects
-- -----------------------------------------------------

SET @absolute_strength_pp_type  = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'absolute strength');
SET @relative_strength_pp_type  = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'relative strength');
SET @power_pp_type              = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'power');
SET @speed_pp_type              = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'speed');
SET @balance_pp_type            = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'balance');
SET @hypertrophy_pp_type        = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'hypertrophy');
SET @coordination_pp_type       = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'coordination');
SET @technique_pp_type          = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'technique');
SET @reaction_time_pp_type      = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'reaction time');
SET @cardio_endurance_pp_type   = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'cardio-vascular endurance');
SET @muscular_endurance_pp_type = (SELECT `pp_aspect_id` FROM `pp_aspects` WHERE `name` = 'muscular endurance');

INSERT INTO `exercise_targets_pp_aspects` (`exercise_id`, `pp_aspect_id`) VALUES
  -- Bench Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @hypertrophy_pp_type),
  -- Clean&Jerk
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @technique_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @coordination_pp_type),
  -- Pull up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @hypertrophy_pp_type),
  -- Snatch
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @technique_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @speed_pp_type),
  -- Back Squat
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @muscular_endurance_pp_type),
  -- Front Squat
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @technique_pp_type),
  -- Deadlift
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @power_pp_type),
  -- Overhead Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @coordination_pp_type),
  -- Bent Over Row
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @muscular_endurance_pp_type),
  -- Romanian Deadlift
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @power_pp_type),
  -- Power Clean
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @technique_pp_type),
  -- Power Snatch
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Snatch'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Snatch'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Snatch'), @technique_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Snatch'), @coordination_pp_type),
  -- Push Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push Press'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push Press'), @hypertrophy_pp_type),
  -- Close Grip Bench Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Close Grip Bench Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Close Grip Bench Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Close Grip Bench Press'), @power_pp_type),
  -- Dumbbell Bench Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bench Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bench Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bench Press'), @relative_strength_pp_type),
  -- Dumbbell Row
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Row'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Row'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Row'), @muscular_endurance_pp_type),
  -- Dumbbell Overhead Press
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @coordination_pp_type),
  -- Dumbbell Curl
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @relative_strength_pp_type),
  -- Dumbbell Lateral Raise
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Lateral Raise'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Lateral Raise'), @muscular_endurance_pp_type),
  -- Dumbbell Squat
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Squat'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Squat'), @relative_strength_pp_type),
  -- Dumbbell Deadlift
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Deadlift'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Deadlift'), @power_pp_type),
  -- Chin up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Chin up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Chin up'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Chin up'), @muscular_endurance_pp_type),
  -- Push up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @hypertrophy_pp_type),
  -- Dip
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), @muscular_endurance_pp_type),
  -- L-sit
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'L-sit'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'L-sit'), @coordination_pp_type),
  -- Handstand Hold
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Handstand Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Handstand Hold'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Handstand Hold'), @balance_pp_type),
  -- Running
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @muscular_endurance_pp_type),
  -- Cycling
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), @power_pp_type),
  -- Rowing
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @power_pp_type),
  -- Swimming
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @coordination_pp_type),
  -- Jump Rope
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Rope'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Rope'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Rope'), @speed_pp_type),
  -- Stair Climbing
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Stair Climbing'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Stair Climbing'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Stair Climbing'), @muscular_endurance_pp_type),
  -- Bodyweight Squat
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), @technique_pp_type),
  -- Bodyweight Lunge
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Lunge'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Lunge'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Lunge'), @coordination_pp_type),
  -- Pike Push up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pike Push up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pike Push up'), @hypertrophy_pp_type),
  -- Diamond Push up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Diamond Push up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Diamond Push up'), @hypertrophy_pp_type),
  -- Plank
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plank'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plank'), @muscular_endurance_pp_type),
  -- Hollow Body Hold
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hollow Body Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hollow Body Hold'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hollow Body Hold'), @technique_pp_type),
  -- Box Jump
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @coordination_pp_type),
  -- Broad Jump
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Broad Jump'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Broad Jump'), @relative_strength_pp_type),
  -- Burpee
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), @muscular_endurance_pp_type),
  -- Medicine Ball Throw
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Medicine Ball Throw'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Medicine Ball Throw'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Medicine Ball Throw'), @coordination_pp_type),
  -- Jump Lunge
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Lunge'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Lunge'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Lunge'), @coordination_pp_type),
  -- Clap Push up
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clap Push up'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clap Push up'), @coordination_pp_type),
  -- Kettlebell Swing
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @muscular_endurance_pp_type),
  -- Wall Sit
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Wall Sit'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Wall Sit'), @muscular_endurance_pp_type),
  -- Dead Bug Hold
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dead Bug Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dead Bug Hold'), @coordination_pp_type),
  -- Pallof Hold
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pallof Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pallof Hold'), @coordination_pp_type),
  -- Suitcase Carry
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Suitcase Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Suitcase Carry'), @muscular_endurance_pp_type),
  -- Farmers Carry
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Farmers Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Farmers Carry'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Farmers Carry'), @absolute_strength_pp_type),
  -- Additional barbell exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Bench Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Bench Press'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pendulum Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pendulum Squat'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pause Squat'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pause Squat'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pin Press'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pin Press'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deficit Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deficit Deadlift'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sumo Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sumo Deadlift'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Trap Bar Deadlift'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Trap Bar Deadlift'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'High Bar Squat'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'High Bar Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hack Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hack Squat'), @muscular_endurance_pp_type),
  -- Additional dumbbell exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Turkish Get-up'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Turkish Get-up'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Turkish Get-up'), @technique_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Pulover'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Pulover'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Fly'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Fly'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Tricep Extension'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Tricep Extension'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Hammer Curl'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Hammer Curl'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Front Raise'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Front Raise'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Reverse Fly'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Reverse Fly'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Step-up'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Step-up'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bulgarian Split Squat'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bulgarian Split Squat'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Suitcase Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Suitcase Carry'), @muscular_endurance_pp_type),
  -- Additional freeweight exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Muscle Up'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Muscle Up'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Muscle Up'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pseudo Planche Push-up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pseudo Planche Push-up'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Archer Push-up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Archer Push-up'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Typewriter Pull-up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Typewriter Pull-up'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Explosive Push-up'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Explosive Push-up'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Push-up'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Push-up'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bulgarian Bodyweight Squat'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bulgarian Bodyweight Squat'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pistol Squat'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pistol Squat'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Shrimp Squat'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Shrimp Squat'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Human Flag Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Human Flag Hold'), @coordination_pp_type),
  -- Additional cardio-vascular exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Elliptical'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Elliptical'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Treadmill Sprint'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Treadmill Sprint'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing Machine Interval'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing Machine Interval'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Battle Ropes'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Battle Ropes'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Assault Bike Sprint'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Assault Bike Sprint'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sled Push'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sled Push'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sled Drag'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Sled Drag'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Tire Flip'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Tire Flip'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rope Climb'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rope Climb'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Obstacle Course Sprint'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Obstacle Course Sprint'), @speed_pp_type),
  -- Additional calisthenic exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Sit-up'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Decline Sit-up'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hanging Knee Raise'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Hanging Knee Raise'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Parallel Bar Dip'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Parallel Bar Dip'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Reverse Hyperextension'), @hypertrophy_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Reverse Hyperextension'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Inchworm'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Inchworm'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bear Crawl'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bear Crawl'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Leopard Crawl'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Leopard Crawl'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Crab Walk'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Crab Walk'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Nordic Hamstring Curl'), @absolute_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pistol Squat Progression'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pistol Squat Progression'), @coordination_pp_type),
  -- Additional plyometric exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Depth Jump'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Depth Jump'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Lateral Bound'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Lateral Bound'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Single-leg Hop'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Single-leg Hop'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Tuck Jump'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Tuck Jump'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bounding'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bounding'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Snatch'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Snatch'), @speed_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Clean'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Clean'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Wall Ball Throw'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Wall Ball Throw'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Slam Ball'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Slam Ball'), @cardio_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plyometric Lunge'), @power_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plyometric Lunge'), @coordination_pp_type),
  -- Additional isometric exercises
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Half Kneeling Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Half Kneeling Carry'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bottom Position Squat Hold'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bottom Position Squat Hold'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Carry'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bear Hug Carry'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bear Hug Carry'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Single-leg Stance'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Single-leg Stance'), @balance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Handstand Hold Against Wall'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Handstand Hold Against Wall'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dead Hang'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dead Hang'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Reverse Plank'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Reverse Plank'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Side Plank'), @relative_strength_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Side Plank'), @muscular_endurance_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jefferson Curl Hold'), @coordination_pp_type),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jefferson Curl Hold'), @muscular_endurance_pp_type);


-- -----------------------------------------------------
-- exercise_hits_targets
-- -----------------------------------------------------
INSERT INTO `exercise_hits_targets` (`exercise_id`, `target_id`) VALUES
  -- Clean&Jerk targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'trapezius')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  -- Snatch targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), (SELECT `target_id` FROM `targets` WHERE `name` = 'trapezius')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  -- Back Squat targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  -- Front Squat targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'rectus abdominis')),
  -- Deadlift targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), (SELECT `target_id` FROM `targets` WHERE `name` = 'trapezius')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lats')),
  -- Bench Press targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lower pectoralis')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  -- Overhead Press targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'side deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), (SELECT `target_id` FROM `targets` WHERE `name` = 'trapezius')),
  -- Bent Over Row targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lats')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), (SELECT `target_id` FROM `targets` WHERE `name` = 'rhomboids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), (SELECT `target_id` FROM `targets` WHERE `name` = 'biceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  -- Pull up targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lats')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'biceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'rhomboids')),
  -- Dumbbell Curl targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), (SELECT `target_id` FROM `targets` WHERE `name` = 'biceps')),
  -- Dumbbell Lateral Raise targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Lateral Raise'), (SELECT `target_id` FROM `targets` WHERE `name` = 'side deltoids')),
  -- Push up targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lower pectoralis')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  -- Dip targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lower pectoralis')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dip'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  -- Box Jump targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), (SELECT `target_id` FROM `targets` WHERE `name` = 'calves')),
  -- Burpee targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lower pectoralis')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  -- Kettlebell Swing targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  -- Plank targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plank'), (SELECT `target_id` FROM `targets` WHERE `name` = 'rectus abdominis')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plank'), (SELECT `target_id` FROM `targets` WHERE `name` = 'obliques')),
  -- Wall Sit targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Wall Sit'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  -- Running targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), (SELECT `target_id` FROM `targets` WHERE `name` = 'calves')),
  -- Bodyweight Squat targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  -- Cycling targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), (SELECT `target_id` FROM `targets` WHERE `name` = 'quadriceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), (SELECT `target_id` FROM `targets` WHERE `name` = 'glutes')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Cycling'), (SELECT `target_id` FROM `targets` WHERE `name` = 'calves')),
  -- Rowing targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lats')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'biceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'erector spinae')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), (SELECT `target_id` FROM `targets` WHERE `name` = 'hamstrings')),
  -- Swimming targets
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), (SELECT `target_id` FROM `targets` WHERE `name` = 'lats')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), (SELECT `target_id` FROM `targets` WHERE `name` = 'front deltoids')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), (SELECT `target_id` FROM `targets` WHERE `name` = 'triceps')),
  ((SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), (SELECT `target_id` FROM `targets` WHERE `name` = 'biceps'));


-- -----------------------------------------------------
-- session_targets_pp_aspects
-- -----------------------------------------------------
INSERT INTO `session_targets_pp_aspects` (`session_id`, `pp_aspect_id`) VALUES
  -- anatoly: olympic weightlifting sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Front squat session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Front squat session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Back squat session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Back squat session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pulls and deadlifts session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pulls and deadlifts session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Power snatch session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Power snatch session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Muscle snatch session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch balance session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Overhead squat session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Overhead squat session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean pull session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch pull session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Jerk technique session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean and jerk complex session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean and jerk complex session'), @technique_pp_type),
  -- naim: bodybuilding sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Legs'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Arms'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Incline bench session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lateral raise specialisation'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Rear delt and face pull session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg press and leg curl session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull-ups and rows session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Tricep specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Bicep specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Calf and forearm session'), @hypertrophy_pp_type),
  -- piros: powerlifting sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat day'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body accessory day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort squat session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort squat session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort bench session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort deadlift session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pause squat session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Close grip bench session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat and deadlift combo session'), @absolute_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body accessory session'), @hypertrophy_pp_type),
  -- vasily: endurance and conditioning sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Interval training session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Interval training session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Long run session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Bike endurance session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), @technique_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Hill sprints session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Hill sprints session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Fartlek session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Track interval session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Track interval session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Recovery run session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Circuit training session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Circuit training session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Stair climbing session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Stair climbing session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Core stability session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Cross-training session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Cross-training session'), @muscular_endurance_pp_type),
  -- asen: body composition sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Back specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Glute and hamstring session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulder specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Arm specialisation session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), @cardio_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body pump session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body pump session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body pump session'), @hypertrophy_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body pump session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Abs and core session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body circuit session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body circuit session'), @cardio_endurance_pp_type),
  -- valerios: longevity and power sessions
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Mobility and prehab session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), @speed_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Medicine ball session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Medicine ball session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), @power_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Balance and coordination session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Hip hinge session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body resistance session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body resistance session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body resistance session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body resistance session'), @muscular_endurance_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Loaded carry session'), @relative_strength_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Flexibility and stretching session'), @coordination_pp_type),
  ((SELECT `session_id` FROM `sessions` WHERE `name` = 'Tendon conditioning session'), @relative_strength_pp_type);

-- -----------------------------------------------------
-- sets
-- -----------------------------------------------------
SET @slow_rep_id       = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'slow');
SET @fast_rep_id       = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'fast');
SET @intentional_rep   = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'intentional');
SET @long_partial_rep  = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'long-length partial');
SET @short_partial_rep = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'short-length partial');
SET @isometric_rep     = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'isometric');
SET @concentric_rep    = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'concentric only');
SET @eccentric_rep     = (SELECT `repetition_type_id` FROM `repetition_types` WHERE `name` = 'eccentric only');

INSERT INTO `sets` (`number_of_repetitions`, `rest_duration`, `weight`, `rpe`, `block`, `exercise_id`, `repetition_type_id`, `session_id`, `is_done`) VALUES
  -- anatoly: Clean&Jerk strength session
  (2, 120, 100, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), TRUE),
  (2, 120, 110, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), TRUE),
  (2, 120, 120, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean&Jerk'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), TRUE),
  (3, 90, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), TRUE),
  (3, 90, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), TRUE),
  -- Snatch technique session
  (3, 90, 60, 5, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  (3, 90, 70, 5, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  (3, 90, 75, 6, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  (5, 60, NULL, 4, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  (5, 60, NULL, 4, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  (5, 60, NULL, 4, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), TRUE),
  -- piros: Bench press day
  (5, 180, 130, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (5, 180, 135, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (5, 180, 140, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (8, 120, 110, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (8, 120, 110, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (10, 90, 90, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (10, 90, 90, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (12, 60, NULL, 5, 4, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  (12, 60, NULL, 5, 4, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), TRUE),
  -- vasily: Tempo run session
  (1, 600, NULL, 5, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  (6, 90, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  (6, 90, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  -- asen: Push day
  (4, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (4, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (4, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (8, 90, 60, 6, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (10, 90, 50, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (10, 90, 50, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (10, 90, 50, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Lateral Raise'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Lateral Raise'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), TRUE),
  -- valerios: Box jump session
  (5, 180, NULL, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  (5, 180, NULL, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  (5, 180, NULL, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  (8, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  (8, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  (8, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Front Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), TRUE),
  -- naim: Chest and Triceps
  (8, 120, 100, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (8, 120, 100, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (8, 120, 100, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (8, 120, 100, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (10, 90, 80, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (10, 90, 80, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (10, 90, 80, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Incline Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  (15, 45, NULL, 4, 4, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Push up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), TRUE),
  -- Pull day
  (6, 120, NULL, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (6, 120, NULL, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (6, 120, NULL, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pull up'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (8, 90, 100, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (8, 90, 100, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (8, 90, 100, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (10, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  (10, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), TRUE),
  -- Leg day
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (8, 120, 120, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (8, 120, 120, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (8, 120, 120, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (10, 90, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Lunge'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  (10, 90, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Lunge'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), TRUE),
  -- Deadlift day
  (3, 180, 200, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (3, 180, 210, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (3, 180, 220, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (5, 120, 180, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (5, 120, 180, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (5, 120, 180, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (6, 90, 150, 6, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Trap Bar Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  (6, 90, 150, 6, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Trap Bar Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), TRUE),
  -- Running (long run)
  (1, 1800, NULL, 4, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Long run session'), TRUE),
  -- Plyometric session
  (6, 180, NULL, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), TRUE),
  (6, 180, NULL, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), TRUE),
  (8, 120, NULL, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Broad Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), TRUE),
  (8, 120, NULL, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Broad Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), TRUE),
  -- Cardio and core session
  (1, 900, NULL, 5, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), TRUE),
  (10, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), TRUE),
  (10, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Burpee'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), TRUE),
  (20, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Plank'), @isometric_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), TRUE),
  -- HIIT session
  (8, 60, 60, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Rope'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  (8, 60, 60, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Jump Rope'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  (6, 60, NULL, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  (6, 60, NULL, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Box Jump'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  (10, 45, NULL, 6, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  (10, 45, NULL, 6, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bodyweight Squat'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), TRUE),
  -- Rowing endurance session
  (1, 1200, NULL, 5, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), TRUE),
  (8, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), TRUE),
  (8, 120, NULL, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Rowing'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), TRUE),
  -- Snatch max effort session
  (2, 150, 85, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), TRUE),
  (2, 150, 90, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), TRUE),
  (2, 150, 95, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), TRUE),
  (5, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), TRUE),
  (5, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Snatch Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), TRUE),
  -- Heavy squat session
  (6, 180, 160, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), TRUE),
  (6, 180, 165, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), TRUE),
  (6, 180, 170, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), TRUE),
  (4, 120, 150, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pause Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), TRUE),
  (4, 120, 150, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pause Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), TRUE),
  -- Max effort bench session
  (3, 180, 120, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), TRUE),
  (3, 180, 125, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), TRUE),
  (3, 180, 130, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), TRUE),
  (5, 120, 100, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pin Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), TRUE),
  (5, 120, 100, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Pin Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), TRUE),
  -- Max effort deadlift session
  (2, 180, 220, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), TRUE),
  (2, 180, 230, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), TRUE),
  (2, 180, 240, 9, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), TRUE),
  (5, 120, 200, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deficit Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), TRUE),
  (5, 120, 200, 7, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deficit Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), TRUE),
  -- Power clean session
  (5, 120, 90, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), TRUE),
  (5, 120, 95, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), TRUE),
  (5, 120, 100, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Power Clean'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), TRUE),
  (6, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), TRUE),
  (6, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Clean Pull'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), TRUE),
  -- Romanian deadlift session
  (8, 120, 120, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session'), TRUE),
  (8, 120, 125, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session'), TRUE),
  (8, 120, 125, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Romanian Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session'), TRUE),
  -- Back and Biceps
  (6, 120, 110, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (6, 120, 110, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (6, 120, 110, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (6, 120, 110, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bent Over Row'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (10, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Lat Pulldown'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (10, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Lat Pulldown'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (10, 90, 70, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Lat Pulldown'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  (12, 60, NULL, 5, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Dumbbell Curl'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), TRUE),
  -- Tempo run
  (1, 600, NULL, 6, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @intentional_rep, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  (3, 120, NULL, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  (3, 120, NULL, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Running'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), TRUE),
  -- Kettlebell session
  (8, 90, 24, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), TRUE),
  (8, 90, 24, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), TRUE),
  (8, 90, 24, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Swing'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), TRUE),
  (6, 120, 32, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Snatch'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), TRUE),
  (6, 120, 32, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Kettlebell Snatch'), @fast_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), TRUE),
  -- Shoulders and Traps
  (8, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), TRUE),
  (8, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), TRUE),
  (8, 120, 80, 7, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Overhead Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), TRUE),
  (6, 120, 100, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), TRUE),
  (6, 120, 100, 6, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), TRUE),
  -- Full body strength session
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 150, 8, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Back Squat'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 130, 8, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 130, 8, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 130, 8, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Bench Press'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 180, 8, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  (5, 180, 180, 8, 3, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Deadlift'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), TRUE),
  -- Swimming
  (6, 120, NULL, 6, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), TRUE),
  (6, 120, NULL, 6, 1, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), TRUE),
  (8, 90, NULL, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), TRUE),
  (8, 90, NULL, 5, 2, (SELECT `exercise_id` FROM `exercises` WHERE `name` = 'Swimming'), @slow_rep_id, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), TRUE);


-- -----------------------------------------------------
-- user_logs
-- -----------------------------------------------------
INSERT INTO `user_logs` (`date`, `age`, `weight`, `height`, `bodyfat_percentage`, `satisfaction`, `user_id`) VALUES
  -- anatoly_pisarenko
  ('2026-01-15 08:00:00', 28, 110.5, 181.1, 18.5, 7, @anatoly_id),
  ('2026-02-15 08:30:00', 28, 111.2, 181.1, 17.8, 8, @anatoly_id),
  ('2026-03-15 09:00:00', 28, 109.8, 181.1, 16.9, 8, @anatoly_id),
  ('2026-04-01 07:45:00', 29, 109.2, 181.1, 16.2, 9, @anatoly_id),
  ('2026-04-07 08:15:00', 29, 108.5, 181.1, 15.8, 9, @anatoly_id),
  -- vasily_alexeev
  ('2026-01-20 07:00:00', 24, 63.0, 168.2, 22.1, 6, @vasily_id),
  ('2026-02-20 07:30:00', 24, 62.8, 168.2, 21.5, 7, @vasily_id),
  ('2026-03-20 08:00:00', 24, 62.1, 168.2, 20.8, 7, @vasily_id),
  ('2026-04-05 07:15:00', 24, 62.5, 168.2, 21.0, 8, @vasily_id),
  -- asen_zlatev
  ('2026-01-10 08:00:00', 35, 93.5, 185.3, 24.0, 5, @asen_id),
  ('2026-02-10 08:30:00', 35, 92.8, 185.3, 23.2, 6, @asen_id),
  ('2026-03-10 09:00:00', 35, 91.5, 185.3, 22.0, 7, @asen_id),
  ('2026-04-02 08:00:00', 35, 92.0, 185.3, 22.5, 7, @asen_id),
  ('2026-04-07 08:45:00', 36, 91.8, 185.3, 22.1, 8, @asen_id),
  -- naim_suleymanoglu
  ('2026-01-05 07:30:00', 30, 59.0, 165.4, 20.5, 7, @naim_id),
  ('2026-02-05 08:00:00', 30, 59.5, 165.4, 19.8, 8, @naim_id),
  ('2026-03-05 07:45:00', 30, 60.2, 165.4, 19.2, 8, @naim_id),
  ('2026-04-03 08:30:00', 30, 58.4, 165.4, 18.5, 9, @naim_id),
  ('2026-04-07 07:00:00', 30, 58.2, 165.4, 18.0, 9, @naim_id),
  -- piros_dimas
  ('2026-01-25 09:00:00', 22, 72.0, 174.5, 15.5, 8, @piros_id),
  ('2026-02-25 09:30:00', 22, 71.8, 174.5, 14.8, 8, @piros_id),
  ('2026-03-25 08:45:00', 22, 71.5, 174.5, 14.2, 9, @piros_id),
  ('2026-04-06 09:15:00', 22, 71.0, 174.5, 13.8, 9, @piros_id),
  -- valerios_leonidis
  ('2026-01-30 08:00:00', 40, 102.0, 178.6, 28.0, 5, @valerios_id),
  ('2026-02-28 08:30:00', 40, 101.5, 178.6, 27.5, 6, @valerios_id),
  ('2026-03-30 09:00:00', 40, 100.8, 178.6, 26.8, 6, @valerios_id),
  ('2026-04-04 08:15:00', 40, 100.5, 178.6, 26.2, 7, @valerios_id),
  ('2026-04-07 08:00:00', 41, 100.2, 178.6, 25.8, 7, @valerios_id);

-- -----------------------------------------------------
-- session_logs
-- -----------------------------------------------------
INSERT INTO `session_logs` (`date`, `difficulty`, `session_id`, `user_id`) VALUES
  -- anatoly_pisarenko: 15 sessions
  ('2026-04-01 09:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean&Jerk strength session'), @anatoly_id),
  ('2026-04-02 09:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch technique session'), @anatoly_id),
  ('2026-04-03 08:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Front squat session'), @anatoly_id),
  ('2026-04-04 10:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back squat session'), @anatoly_id),
  ('2026-04-05 09:15:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pulls and deadlifts session'), @anatoly_id),
  ('2026-04-06 08:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch max effort session'), @anatoly_id),
  ('2026-03-30 09:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power snatch session'), @anatoly_id),
  ('2026-03-28 10:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Power clean session'), @anatoly_id),
  ('2026-03-26 09:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Muscle snatch session'), @anatoly_id),
  ('2026-03-24 08:45:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch balance session'), @anatoly_id),
  ('2026-03-22 10:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Overhead squat session'), @anatoly_id),
  ('2026-03-20 09:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean pull session'), @anatoly_id),
  ('2026-03-18 08:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Snatch pull session'), @anatoly_id),
  ('2026-03-16 09:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Jerk technique session'), @anatoly_id),
  ('2026-03-14 10:30:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Clean and jerk complex session'), @anatoly_id),
  -- vasily_alexeev: 14 sessions
  ('2026-04-01 07:00:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tempo run session'), @vasily_id),
  ('2026-04-02 07:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Interval training session'), @vasily_id),
  ('2026-04-03 06:45:00', 5, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Long run session'), @vasily_id),
  ('2026-04-04 07:15:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rowing endurance session'), @vasily_id),
  ('2026-04-05 06:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bike endurance session'), @vasily_id),
  ('2026-04-06 08:00:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Swim technique session'), @vasily_id),
  ('2026-03-30 07:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Hill sprints session'), @vasily_id),
  ('2026-03-28 07:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Fartlek session'), @vasily_id),
  ('2026-03-26 06:45:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Track interval session'), @vasily_id),
  ('2026-03-24 07:00:00', 5, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Recovery run session'), @vasily_id),
  ('2026-03-22 08:30:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Circuit training session'), @vasily_id),
  ('2026-03-20 07:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Stair climbing session'), @vasily_id),
  ('2026-03-18 06:45:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Core stability session'), @vasily_id),
  ('2026-03-16 07:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cross-training session'), @vasily_id),
  -- asen_zlatev: 12 sessions
  ('2026-04-01 17:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Push day'), @asen_id),
  ('2026-04-02 17:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull day'), @asen_id),
  ('2026-04-03 18:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg day'), @asen_id),
  ('2026-04-04 17:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Cardio and core session'), @asen_id),
  ('2026-04-05 18:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest specialisation session'), @asen_id),
  ('2026-04-06 17:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back specialisation session'), @asen_id),
  ('2026-03-30 17:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Glute and hamstring session'), @asen_id),
  ('2026-03-28 18:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulder specialisation session'), @asen_id),
  ('2026-03-26 17:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Arm specialisation session'), @asen_id),
  ('2026-03-24 18:15:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'HIIT session'), @asen_id),
  ('2026-03-22 17:45:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body pump session'), @asen_id),
  ('2026-03-20 18:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body pump session'), @asen_id),
  -- naim_suleymanoglu: 15 sessions
  ('2026-04-01 19:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Chest and Triceps'), @naim_id),
  ('2026-04-02 19:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Back and Biceps'), @naim_id),
  ('2026-04-03 19:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Shoulders and Traps'), @naim_id),
  ('2026-04-04 19:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Legs'), @naim_id),
  ('2026-04-05 19:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Arms'), @naim_id),
  ('2026-04-06 19:45:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Heavy squat session'), @naim_id),
  ('2026-03-30 19:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Romanian deadlift session'), @naim_id),
  ('2026-03-28 19:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Incline bench session'), @naim_id),
  ('2026-03-26 19:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lateral raise specialisation'), @naim_id),
  ('2026-03-24 19:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Rear delt and face pull session'), @naim_id),
  ('2026-03-22 19:15:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Leg press and leg curl session'), @naim_id),
  ('2026-03-20 19:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pull-ups and rows session'), @naim_id),
  ('2026-03-18 19:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Tricep specialisation session'), @naim_id),
  ('2026-03-16 19:45:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bicep specialisation session'), @naim_id),
  ('2026-03-14 19:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Calf and forearm session'), @naim_id),
  -- piros_dimas: 13 sessions
  ('2026-04-01 16:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat day'), @piros_id),
  ('2026-04-02 16:30:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Bench press day'), @piros_id),
  ('2026-04-03 16:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Deadlift day'), @piros_id),
  ('2026-04-04 16:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body accessory day'), @piros_id),
  ('2026-04-05 16:15:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort squat session'), @piros_id),
  ('2026-04-06 16:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort squat session'), @piros_id),
  ('2026-03-30 16:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort bench session'), @piros_id),
  ('2026-03-28 16:30:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort bench session'), @piros_id),
  ('2026-03-26 16:00:00', 9, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Max effort deadlift session'), @piros_id),
  ('2026-03-24 16:45:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Dynamic effort deadlift session'), @piros_id),
  ('2026-03-22 16:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Pause squat session'), @piros_id),
  ('2026-03-20 16:30:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Close grip bench session'), @piros_id),
  ('2026-03-18 16:00:00', 8, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Squat and deadlift combo session'), @piros_id),
  -- valerios_leonidis: 11 sessions
  ('2026-04-01 10:00:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Mobility and prehab session'), @valerios_id),
  ('2026-04-02 10:30:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Plyometric session'), @valerios_id),
  ('2026-04-03 11:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Full body strength session'), @valerios_id),
  ('2026-04-04 10:15:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Box jump session'), @valerios_id),
  ('2026-04-05 10:45:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Medicine ball session'), @valerios_id),
  ('2026-04-06 11:00:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Kettlebell session'), @valerios_id),
  ('2026-03-30 10:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Balance and coordination session'), @valerios_id),
  ('2026-03-28 10:30:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Hip hinge session'), @valerios_id),
  ('2026-03-26 11:00:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Upper body resistance session'), @valerios_id),
  ('2026-03-24 10:15:00', 7, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Lower body resistance session'), @valerios_id),
  ('2026-03-22 10:45:00', 6, (SELECT `session_id` FROM `sessions` WHERE `name` = 'Loaded carry session'), @valerios_id);
