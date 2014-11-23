// Nightbloom 2.0
// by Solo Mornington

// THIS NOTICE MUST REMAIN INTACT:
// Copyright 2010, Solo Mornington
// License: Use freely for non-commercial uses. Modifications are encouraged,
// but modifications must keep this copyright notice, and must also be
// licensed only for non-commercial use. Contact Solo Mornington for
// commercial-use licensing.
// Definitive source and updates available here:
// http://github.com/SoloMornington/
// ** end notice

// INSTRUCTIONS:
//
// This script is the DNA for a type of desert flora discovered initially at
// Burning Life, 2008, called Nightbloom. You can use it to create your own
// Nightbloom. Here's how:
//
// 1) Rez a prim.
// 2) Shift-drag copy the prim. You now have two prims.
// 3) Right-click one of the prims and 'take' it. The taken prim is now in your inventory.
// 4) Locate this prim in your inventory. It should be in the 'Recent Items' tab.
// 5) Edit the remaining rezzed prim. Select the 'Contents' tab in the edit window.
// 6) Drag the taken prim from your inventory to the Contents tab of the edited prim.
// 7) You should now have a prim with another prim in it's inventory.
// 8) Add the Nightbloom 2.0 script to the prim. You can do this by dragging it from
//      inventory, or by creating a new script and copy/pasting it. Be sure it is
//      compiled as mono.
// 9) The script will ask permission to link and delink prims. Grant this permission
//      by clicking 'Yes.'
// 10) The Nightbloom should begin building itself. You might need to adjust its
//        position a little bit to suit the surroundings.


// globals for animation
// the begin and end of each phase
// lists are strided lists. Each stride is size, position, rotation per prim.
// each phase has two lists: begin and end. These have one stride per prim.

list gStalkBegin = [
<0.08009, -0.67521, -1.22210>, <10.00000, 1.81924, 0.50577>, <0.13002, 0.49834, -0.82940, 0.21645>,
<-0.31227, -1.19681, 0.58900>, <10.00000, 1.81924, 0.50577>, <-0.05909, -0.23461, -0.94096, 0.23679>,
<0.10898, 0.53270, 1.05100>,
<10.00000, 1.81924, 0.50577>,
<-0.15801, -0.84250, -0.50617, 0.09499>,
<-0.05020, 1.37020, -0.55240>,
<10.00000, 1.81924, 0.50577>,
<0.24501, 0.93885, -0.23408, 0.06113>,
<-0.13249, 0.06898, 0.22523>,
<6.57251, 1.81924, 0.50577>,
<-0.04324, 0.66935, 0.74015, 0.04777>,
<-0.17563, 0.51947, 0.15912>,
<5.34842, 1.81924, 0.50577>,
<-0.04578, -0.99769, -0.05023, 0.00225>,
<0.16980, -0.57068, 0.04846>,
<5.43288, 1.81924, 0.50577>,
<0.00016, 0.05026, -0.99873, 0.00214>,
<-0.12173, 0.11122, -0.05267>,
<5.54474, 1.81924, 0.50577>,
<0.00163, 0.74174, -0.67069, 0.00134>,
<0.26790, 0.30671, 0.63049>,
<4.01846, 1.81900, 0.50577>,
<-0.27907, -0.81047, -0.48697, 0.16768>,
<-0.25534, 0.39041, 0.27080>,
<10.00000, 1.81924, 0.50577>,
<-0.13338, -0.97998, -0.14650, 0.01986>,
<-0.43166, -0.81918, -0.33025>,
<10.00000, 1.81924, 0.50577>,
<0.03008, 0.14470, -0.96830, 0.20140>,
<0.16293, 0.47573, -1.13773>,
<10.00000, 1.81924, 0.50577>,
<0.17061, 0.78565, -0.58113, 0.12621>,
<-0.31551, -0.43705, 1.04514>,
<10.00000, 1.81924, 0.50577>,
<-0.12621, -0.58128, -0.78556, 0.17054>,
<0.64467, 0.50225, -0.21033>,
<3.00000, 1.81924, 0.50577>,
<0.37912, 0.89316, -0.22268, 0.09461>,
<0.18744, -0.55010, 0.34921>,
<4.12000, 1.81900, 0.50577>,
<-0.08116, -0.22792, -0.91407, 0.32549>,
<0.34512, -0.32698, -0.56097>,
<3.00000, 1.81900, 0.50577>,
<0.17610, 0.48397, -0.80549, 0.29317>
];

list gStalkEnd = [
<-4.34810, -0.67520, -1.22210>,
<10.00000, 1.81924, 0.50577>,
<0.13002, 0.49834, -0.82940, 0.21645>,
<-4.08590, -1.19680, 0.58900>,
<10.00000, 1.81924, 0.50577>,
<-0.05909, -0.23461, -0.94096, 0.23679>,
<-4.06580, 0.53270, 1.05100>,
<10.00000, 1.81924, 0.50577>,
<-0.15801, -0.84250, -0.50617, 0.09499>,
<-4.27480, 1.37020, -0.55240>,
<10.00000, 1.81924, 0.50577>,
<0.24501, 0.93885, -0.23408, 0.06113>,
<-1.30273, 0.06898, 0.22523>,
<6.57251, 1.81924, 0.50577>,
<-0.04324, 0.66935, 0.74015, 0.04777>,
<-0.70260, 0.51947, 0.15912>,
<5.34842, 1.81924, 0.50577>,
<-0.04578, -0.99769, -0.05023, 0.00225>,
<-1.13893, -0.57068, 0.04846>,
<5.43288, 1.81924, 0.50577>,
<0.00016, 0.05026, -0.99873, 0.00214>,
<-0.98658, 0.11121, -0.05267>,
<5.54474, 1.81924, 0.50577>,
<0.00163, 0.74174, -0.67069, 0.00134>,
<-1.32678, 0.30671, 0.63049>,
<4.01846, 1.81900, 0.50577>,
<-0.27907, -0.81047, -0.48697, 0.16768>,
<-4.19777, 0.39040, 0.27080>,
<10.00000, 1.81924, 0.50577>,
<-0.13338, -0.97998, -0.14650, 0.01986>,
<-3.96629, -0.81919, -0.33025>,
<10.00000, 1.81924, 0.50577>,
<0.03008, 0.14470, -0.96830, 0.20140>,
<-4.20553, 0.47574, -1.13773>,
<10.00000, 1.81924, 0.50577>,
<0.17061, 0.78565, -0.58113, 0.12621>,
<-3.64947, -0.43705, 1.04514>,
<10.00000, 1.81924, 0.50577>,
<-0.12621, -0.58128, -0.78556, 0.17054>,
<-1.50680, 0.50225, -0.21033>,
<3.00000, 1.81924, 0.50577>,
<0.37912, 0.89316, -0.22268, 0.09461>,
<-1.20396, -0.55010, 0.34921>,
<4.12000, 1.81900, 0.50577>,
<-0.08116, -0.22792, -0.91407, 0.32549>,
<-0.85416, -0.32697, -0.56097>,
<3.00000, 1.81900, 0.50577>,
<0.17610, 0.48397, -0.80549, 0.29317>
];

list gWiltBegin = [
<-2.41197, 1.76992, 3.37611>,
<10.00000, 1.81924, 0.50577>,
<-0.20366, 0.47307, -0.78730, -0.33896>,
<-2.48165, 3.49578, -1.80620>,
<10.00000, 1.81924, 0.50577>,
<0.09946, -0.22047, -0.88452, -0.39890>,
<-2.52980, -1.83160, -3.39540>,
<10.00000, 1.81924, 0.50577>,
<0.36059, -0.77769, -0.46718, -0.21661>,
<-2.20398, -3.57466, 1.96251>,
<10.00000, 1.81924, 0.50577>,
<-0.42800, 0.87080, -0.21710, -0.10670>,
<-2.53910, 0.43830, -3.44310>,
<9.59545, 1.81924, 0.50577>,
<-0.25058, 0.62218, 0.68800, 0.27705>,
<-2.20590, -3.98320, -0.29560>,
<9.81393, 1.81924, 0.50577>,
<0.44802, -0.89261, -0.04494, -0.02257>,
<-2.50860, 4.05650, 0.51520>,
<9.81731, 1.81924, 0.50577>,
<-0.02107, 0.04563, -0.90638, -0.41946>,
<-2.42240, -0.28850, 3.90900>,
<9.82179, 1.81924, 0.50577>,
<-0.30019, 0.67830, -0.61329, -0.27142>,
<-4.77210, -0.21160, -0.34410>,
<9.76074, 1.81923, 0.50577>,
<-0.01137, -0.85709, -0.51499, 0.00683>,
<-3.16190, -1.97420, -0.55450>,
<10.00000, 1.81924, 0.50577>,
<0.19295, -0.97001, -0.14498, -0.02890>,
<-3.13417, 1.74410, 0.57719>,
<10.00000, 1.81924, 0.50577>,
<-0.02653, 0.14542, -0.97299, -0.17732>,
<-3.58060, -0.64640, 1.94280>,
<10.00000, 1.81924, 0.50577>,
<-0.15683, 0.78852, -0.58325, -0.11599>,
<-3.16190, 0.52310, -1.88230>,
<10.00000, 1.81924, 0.50577>,
<0.11605, -0.58339, -0.78841, -0.15684>,
<-4.14310, -0.40270, 0.27070>,
<9.72000, 1.81924, 0.50577>,
<0.01556, 0.97017, -0.24189, 0.00395>,
<-3.69400, 0.59990, -0.26240>,
<10.00000, 1.81924, 0.50577>,
<-0.00002, -0.24192, -0.97030, -0.00001>,
<-4.50180, 0.21370, 0.45590>,
<9.72000, 1.81923, 0.50577>,
<0.00713, 0.51498, -0.85709, 0.01199>
];

list gWiltEnd = [
<-0.70915, 2.09035, 3.97877>,
<10.00000, 1.81924, 0.50577>,
<0.31205, -0.40976, 0.68191, 0.51935>,
<-0.55090, 4.29225, -2.22969>,
<10.00000, 1.81924, 0.50577>,
<-0.15482, 0.18586, 0.74576, 0.62075>,
<-0.76227, -2.17103, -4.03377>,
<10.00000, 1.81924, 0.50577>,
<-0.52627, 0.67665, 0.40647, 0.31618>,
<-0.71538, -4.21922, 2.25468>,
<10.00000, 1.81924, 0.50577>,
<0.59302, -0.76799, 0.19146, 0.14785>,
<-0.75410, 0.51148, -4.35453>,
<9.59545, 1.81924, 0.50577>,
<-0.39366, 0.54308, 0.60054, 0.43526>,
<-0.69824, -4.81665, -0.53549>,
<9.81393, 1.81924, 0.50577>,
<-0.62381, 0.77995, 0.03927, 0.03141>,
<-0.82690, 4.72202, 0.42188>,
<9.81731, 1.81924, 0.50577>,
<0.02973, -0.04054, 0.80457, 0.59173>,
<-0.74399, -0.42080, 4.71378>,
<9.82179, 1.81924, 0.50577>,
<0.45537, -0.58553, 0.52941, 0.41173>,
<-0.77658, -2.09395, -3.88429>,
<9.76074, 1.81923, 0.50577>,
<-0.50673, 0.69134, 0.41541, 0.30449>,
<-1.20799, -4.52233, -1.23466>,
<10.00000, 1.81924, 0.50577>,
<-0.56374, 0.81262, 0.12144, 0.08430>,
<-1.20787, 4.16144, 1.14765>,
<10.00000, 1.81924, 0.50577>,
<0.08339, -0.12207, 0.81674, 0.55774>,
<-0.97907, -1.14211, 3.87151>,
<10.00000, 1.81924, 0.50577>,
<0.46969, -0.65252, 0.48262, 0.34740>,
<-0.70488, 1.51670, -4.20872>,
<10.00000, 1.81924, 0.50577>,
<-0.37234, 0.46388, 0.62690, 0.50316>,
<-0.83064, -3.76812, 2.25150>,
<9.72000, 1.81924, 0.50577>,
<0.58504, -0.77410, 0.19298, 0.14583>,
<-1.08765, 4.23129, -2.19325>,
<10.00000, 1.81924, 0.50577>,
<-0.14218, 0.19571, 0.78499, 0.57032>,
<-0.84912, 1.76353, 3.37071>,
<9.72000, 1.81923, 0.50577>,
<0.32171, -0.43956, 0.67673, 0.49530>
];

list gDieBegin = [
<-0.77730, 2.07750, 3.95470>,
<10.00000, 1.81924, 0.50577>,
<-0.30803, 0.41279, -0.68695, -0.51266>,
<-0.62810, 4.26040, -2.21270>,
<10.00000, 1.81924, 0.50577>,
<0.15280, -0.18752, -0.75243, -0.61264>,
<-0.83300, -2.15740, -4.00820>,
<10.00000, 1.81924, 0.50577>,
<0.52011, -0.68140, -0.40932, -0.31248>,
<-0.77490, -4.19340, 2.24300>,
<10.00000, 1.81924, 0.50577>,
<-0.58684, 0.77273, -0.19264, -0.14631>,
<-0.82550, 0.50860, -4.31810>,
<9.59545, 1.81924, 0.50577>,
<-0.38833, 0.54690, 0.60476, 0.42937>,
<-0.75850, -4.78330, -0.52590>,
<9.81393, 1.81924, 0.50577>,
<0.61726, -0.78515, -0.03953, -0.03108>,
<-0.89420, 4.69540, 0.42560>,
<9.81731, 1.81924, 0.50577>,
<-0.02940, 0.04078, -0.80929, -0.58525>,
<-0.81110, -0.41550, 4.68160>,
<9.82179, 1.81924, 0.50577>,
<-0.44962, 0.58995, -0.53341, -0.40653>,
<-0.93640, -2.01870, -3.74270>,
<9.76074, 1.81923, 0.50577>,
<0.48870, -0.70419, -0.42313, -0.29366>,
<-1.28615, -4.42040, -1.20745>,
<10.00000, 1.81924, 0.50577>,
<0.55033, -0.82176, -0.12281, -0.08230>,
<-1.28492, 4.06475, 1.12483>,
<10.00000, 1.81924, 0.50577>,
<-0.08133, 0.12345, -0.82597, -0.54398>,
<-1.08313, -1.12228, 3.79436>,
<10.00000, 1.81924, 0.50577>,
<-0.45846, 0.66046, -0.48849, -0.33909>,
<-0.80316, 1.47696, -4.11566>,
<10.00000, 1.81924, 0.50577>,
<0.36337, -0.47094, -0.63645, -0.49103>,
<-0.96310, -3.63350, 2.17230>,
<9.72000, 1.81924, 0.50577>,
<-0.56430, 0.78934, -0.19678, -0.14066>,
<-1.19190, 4.08600, -2.11600>,
<10.00000, 1.81924, 0.50577>,
<0.13722, -0.19922, -0.79908, -0.55042>,
<-0.99520, 1.70150, 3.25410>,
<9.72000, 1.81923, 0.50577>,
<-0.31028, 0.44646, -0.69011, -0.47765>
];

list gDieEnd = [
<0.70974, 2.07755, 3.95474>,
<10.00000, 1.81924, 0.50577>,
<0.35927, -0.36905, 0.61416, 0.59794>,
<1.40376, 4.26048, -2.21266>,
<10.00000, 1.81924, 0.50577>,
<-0.18028, 0.16132, 0.64733, 0.72280>,
<0.84213, -2.15733, -4.00816>,
<10.00000, 1.81924, 0.50577>,
<-0.60987, 0.60238, 0.36184, 0.36642>,
<0.44877, -4.19335, 2.24302>,
<10.00000, 1.81924, 0.50577>,
<0.64565, -0.72430, 0.18057, 0.16098>,
<1.88444, 0.47666, -3.99881>,
<9.59545, 1.81924, 0.50577>,
<-0.50140, 0.44553, 0.49267, 0.55441>,
<1.72331, -4.28772, -0.47593>,
<9.81393, 1.81924, 0.50577>,
<-0.77257, 0.63294, 0.03187, 0.03889>,
<1.57153, 4.36169, 0.39238>,
<9.81731, 1.81924, 0.50577>,
<0.03782, -0.03312, 0.65690, 0.75230>,
<1.78312, -0.36195, 4.15073>,
<9.82179, 1.81924, 0.50577>,
<0.57492, -0.46869, 0.42377, 0.51982>,
<1.42512, -2.01862, -3.74265>,
<9.76074, 1.81923, 0.50577>,
<-0.62954, 0.58172, 0.34956, 0.37828>,
<1.81283, -4.05247, -1.09470>,
<10.00000, 1.81924, 0.50577>,
<-0.76106, 0.63162, 0.09438, 0.11379>,
<0.96046, 4.07459, 1.12787>,
<10.00000, 1.81924, 0.50577>,
<0.10430, -0.10477, 0.70095, 0.69772>,
<1.94269, -1.10587, 3.74007>,
<10.00000, 1.81924, 0.50577>,
<0.63153, -0.49756, 0.36800, 0.46710>,
<1.88982, 1.34820, -3.69370>,
<10.00000, 1.81924, 0.50577>,
<-0.45334, 0.38511, 0.52045, 0.61262>,
<0.37765, -3.63345, 2.17233>,
<9.72000, 1.81924, 0.50577>,
<0.65003, -0.72039, 0.17959, 0.16204>,
<0.74427, 4.08607, -2.11596>,
<10.00000, 1.81924, 0.50577>,
<-0.16670, 0.17529, 0.70314, 0.66864>,
<0.43262, 2.04997, 3.90935>,
<9.72000, 1.81923, 0.50577>,
<0.35668, -0.40949, 0.62425, 0.56162>
];

// globals for constituting object

// constant describing the PRIM_TYPE stuff for petals
// separate from size, which is described in the anim target frames
list gPetalGeometry = [PRIM_TYPE, PRIM_TYPE_TORUS, 0, <0.0, 0.4, 0.0>, 0.90, <0.0, 0.0, 0.0>, <1.0, 0.4, 0.0>, <0.0, 0.0, 0.0>, <0.5, 1.0, 0.0>, <0.0, 0.0, 0.0>, 1.0, 0.000000, 0.95];

// constant describing PRIM_TYPE stuff for base prim
list gBaseParams = [PRIM_TYPE, PRIM_TYPE_TORUS, 0, <0.0, 1.0, 0.0>, 0.95, <-1.0, 0.7, 0.0>, <1.0, 0.2, 0.0>, <0.0, 0.0, 0.0>, <0.5, 1.0, 0.0>, <0.0, 0.0, 0.0>, 4.0, -0.45, 0.8,
    PRIM_SIZE, <0.503269, 2.607437, 2.635803>,
    PRIM_ROTATION, <-0.5, 0.5, 0.5, 0.5>,
    PRIM_PHYSICS, FALSE,
    PRIM_TEMP_ON_REZ, FALSE
    ];

// constant describing all the prim params we want for all the prims
// this turns off flexi, light, shiny... etc.
list gInitPrim = [
    PRIM_TEXT, "", <1,1,1>, 1.0,
    PRIM_BUMP_SHINY, ALL_SIDES, PRIM_SHINY_NONE, PRIM_BUMP_NONE,
    PRIM_POINT_LIGHT, FALSE, <1,1,1>, 0.0, 0.0, 0.0,
    PRIM_FULLBRIGHT, ALL_SIDES, FALSE,
    PRIM_FLEXIBLE, FALSE, 0, 1.0, 1.0, 1.0, 1.0, <1,1,1>,
    PRIM_TEXGEN, ALL_SIDES, PRIM_TEXGEN_DEFAULT,
    PRIM_GLOW, ALL_SIDES, 0.0,
    PRIM_COLOR, ALL_SIDES, <1,1,1>, 1.0
    ];

string gTexture = "29167591-7579-40c0-a387-3b4560d92ef5"; // UUID of our favorite texture

float gMaxGlow = 0.4; // the petals glow a bit on the tips. this is the maximum glow

integer gPrimsInObject = 17; // how many prims should this object have?

// globals for timing...
float gTimer = 10.0; // basic timer interval
                    // the sun position only updates every 10 seconds so
                    // this is completely adequate.

// these mark the noon and midnight values for the sun
float gNoon = 0.886396;
float gMidnight = -0.44422;

// constants for phases. these are strictly not needed, but make our
// code more readable.
integer PHASE_STALK = 0;
integer PHASE_BLOOM = 1;
integer PHASE_WILT = 2;
integer PHASE_DIE = 3;

// END CONSTANTS, START VARIABLES......

integer gPhase = 0; // which growth phase are we in?

integer gDied = FALSE; // this should be a state-scope variable in state die,
                        // but LSL doesn't allow such things.

// we copy the current phase animation data to gCurrentBegin and End.
// That way we can use just one set of code for the whole thing
// if only LSL had multidimensional arrays....
list gCurrentBegin;
list gCurrentEnd;


integer whichPhase()
{
    // function returns an integer depending on which
    // phase we're in. these are equivalent to
    // the quadrants of the day.
    // 0 stalk, 1 bloom, 2 wilt, 3 die

    // look at sun direction to determine phase
    vector sun = llGetSunDirection();
    if (sun.x > 0.0) // AM
    {
        if (sun.z <= 0.0) return PHASE_WILT; // AM nighttime, wilt phase
    }
    else // PM
    {
        if (sun.z > 0.0) return PHASE_STALK; // afternoon, stalk phase
        return PHASE_BLOOM; // PM nighttime, bloom phase
    }
    return PHASE_DIE; // default is die phase
}

float phasePercentage()
{
    // 'percentage' is a misnomer. it's between 0.0 and 1.0, inclusive.
    // binary decisions about which phase we're in are easy,
    // but the percentage part is tricky, especially since
    // we need constants for noon and midnight.
    // get the position of the sun above (or below) the horizon
    vector sun = llGetSunDirection();
    float sunZ = sun.z;
    // set up a return value
    float percentage = 0.0;
    // now we do some math depending on whether the sun is up or down
    // for the second half of night or day, we have to invert the
    // percentage.
    if (sunZ < 0.0) // sun down
    {
        percentage = sunZ / gMidnight; // bloom phase
        if (sun.x > 0.0) // wilt phase
            percentage = 1.0 - percentage;
    }
    else // sun up
    {
        percentage = sunZ / gNoon; // die phase
        if (sun.x <= 0.0) // stalk phase
            percentage = 1.0 - percentage;
    }
    if (percentage > 1.0) percentage = 1.0;
    if (percentage < 0.0) percentage = 0.0;
    return percentage;
}

rotation rotBetween(rotation a, rotation b, float f)
{
    // nicked from here: http://forums.secondlife.com/showthread.php?p=536622
    float angleBetween = llAngleBetween(a, b);
    if ( angleBetween > PI )
    angleBetween = angleBetween - TWO_PI;
    return a*llAxisAngle2Rot(llRot2Axis(b/a)*a, angleBetween*f);
}

vector vecBetween(vector from, vector to, float percent)
{
    // find the between value, percent between from to to.
    return from - ((from - to) * percent);
}

animatePetals(float percent, list extraParams)
{
    // this function does most of the math heavy lifting for animation
    // it looks at gCurrentBegin/End for animation end points
    // and moves the petals where they should be, in between those points.
    integer i;
    integer offset;
    for (i=0; i<16; ++i)
    {
        offset = i * 3; // offset per prim within begin/end list
        // gather the info from the lists
        vector beginPos = llList2Vector(gCurrentBegin, offset);
        vector endPos = llList2Vector(gCurrentEnd, offset);
        vector beginSize = llList2Vector(gCurrentBegin, offset+1);
        vector endSize = llList2Vector(gCurrentEnd, offset+1);
        rotation beginRot = llList2Rot(gCurrentBegin, offset+2);
        rotation endRot = llList2Rot(gCurrentEnd, offset+2);
        // do the math and update the prim
        llSetLinkPrimitiveParamsFast(i + 2, // arrays are 0-based, petals are 2-based
            [PRIM_POSITION, vecBetween(beginPos, endPos, percent),
            PRIM_SIZE, vecBetween(beginSize, endSize, percent),
            PRIM_ROT_LOCAL, rotBetween(beginRot, endRot, percent)]// /llGetRootRotation()]
            + extraParams);
    }
}

particlePetals(float percent)
{
    // do some data-thinning... if the change isn't subtantial
    // don't do an update. Each particle update is a full-prim
    // update, per prim, and thus laggy.

    ///  if (llFabs(percent - gLastParticlePercent) < 0.1) return;
    // gLastParticlePercent = gPe;

    // start and end scale let the particle size change dynamically
    // as the animation proceeds.
    float startScale = 0.6 * percent;
    float endScale = startScale * 2;
    llLinkParticleSystem( LINK_ALL_OTHERS, [
        PSYS_PART_START_SCALE, <startScale, startScale, 0>,
        PSYS_PART_END_SCALE, <endScale, endScale, 0>,
        PSYS_PART_START_COLOR, <1,1,.9>,    PSYS_PART_END_COLOR, <1,1,1>,
        PSYS_PART_START_ALPHA, .8,            PSYS_PART_END_ALPHA, .0,
        PSYS_SRC_BURST_PART_COUNT, 1,
        PSYS_SRC_BURST_RATE,  0.05,
        PSYS_PART_MAX_AGE, 0.75,
        PSYS_SRC_MAX_AGE, 0.0,
        PSYS_SRC_PATTERN, 2,
        PSYS_SRC_ACCEL, <0.0,0.0,1.5>,
        PSYS_SRC_BURST_SPEED_MIN, .1,   PSYS_SRC_BURST_SPEED_MAX, .3,
        PSYS_SRC_ANGLE_BEGIN,  5*DEG_TO_RAD,
        PSYS_PART_FLAGS, ( 0
                                | PSYS_PART_INTERP_COLOR_MASK
                                | PSYS_PART_INTERP_SCALE_MASK
                                | PSYS_PART_EMISSIVE_MASK
                                | PSYS_PART_WIND_MASK
        )]
    );
}

// #pragma mark animation functions

// These animation functions exist because they need to be called from
// state_entry and timer events of their states. Rather than duplicating code
// we refactor the code out to these functions.

animate_stalk()
{
    // we gather the percentage and do some math on it.
    // we want the stalk animation to end before the sun
    // phase ends, so we ramp up the linearity a little.
    // there's probably a real mathematical term for that,
    // but I don't know it.
    float percentage = phasePercentage() * 1.5;
    // ...make sure we never go over 1.0
    if (percentage > 1.0) percentage = 1.0;
    // we want to add some glow to the edges of the petals
    list glowFaces = [PRIM_GLOW, 0, gMaxGlow * percentage];
    // perform an animation, with glow added.
    animatePetals(percentage, glowFaces);
}

animate_bloom()
{
    // store the percentage
    float percentage = phasePercentage();
    // we want to ramp down the glow in a linear fashion.
    // assemble the list...
    list glowFaces = [PRIM_GLOW, 0, gMaxGlow * (1.0 - percentage)];
    // perform an animation, including glow.
    animatePetals(percentage, glowFaces);
    // show the particles
    particlePetals(percentage);
    // and we want to add light to prim number ten...
    llSetLinkPrimitiveParamsFast(10, [PRIM_POINT_LIGHT, TRUE, <0.98, 1.0, 0.5>, (1.0 * percentage), (15.0 * percentage), 0.75]);
}

animate_wilt()
{
    // store the percentage
    float percent = phasePercentage();
    float inversePercent = 1.0 - percent;
    // perform an animation
    animatePetals(percent, []);
    // we want the particles to fade out, so we do their complement
    particlePetals(inversePercent);
    // and fade out the light on prim 10.
    llSetLinkPrimitiveParamsFast(10, [PRIM_POINT_LIGHT, TRUE, <0.98, 1.0, 0.5>, (1.0 * inversePercent), (15.0 * inversePercent), 0.75]);
}

animate_die()
{
    // store the percentage
    float percent = phasePercentage();
    // we have two different goals here, depending on whether we're partway
    // through this phase or not.
    if (percent < 0.2)
    {
        // fade out the alpha
        animatePetals(percent * 5.0, [PRIM_COLOR, ALL_SIDES, <1,1,1>, 1.0 - (percent * 5.0)]);
    }
    else // percent >= 0.2
    {
        if (!gDied) // gDied is FALSE
        {
//            llOwnerSay("died part 2");
            // first mark that we did this already,
            // and we don't need to do it again
            gDied = TRUE;
            // we switch out the data so we can get to the stalk phase.
            gCurrentBegin = gStalkBegin;
            gCurrentEnd = gStalkBegin;
        }
        // this is a bit suboptimal, since it will do all the math
        // to 'tween' the petals even though they won't move.
        // but it's better than writing another function or loop.
        // because I'm lazy.
        animatePetals(percent, [PRIM_COLOR, ALL_SIDES, <1,1,1>, (percent - 0.2) * 1.2]);
    }
}



default
{
    state_entry()
    {
        llMessageLinked(LINK_THIS, -2377, "", NULL_KEY);
        // 'default' isn't very descriptive a name. let's go to a state
        // with a better name.
        state linkPermission;
    }
}

// linkPermission state is where we ask for link permissions.
state linkPermission
{
    state_entry()
    {
        // Tell the user what this means....
        llOwnerSay("This script needs permission to rez and link prims to itself. Please grant this permission.");
        // and ask out loud.
        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
    }

    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_CHANGE_LINKS)
        {
            // yay we got permission!
            state rezLink;
        }
    }

    touch_start(integer count)
    {
        // we have a touch_start event so that if the user messes up they can
        // just click the object and get another try.
        // we go through this detectedKey rigamarole so that only the owner
        // can do the touch.
        integer i;
        for (i = 0; i < count; ++i)
        {
            if (llDetectedKey(i) == llGetOwner())
            {
                // tell the user... AGAIN.
                llOwnerSay("This script needs permission to rez and link prims to itself. Please grant this permission.");
                // and ask for perms... AGAIN.
                llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
            }
        }
    }
}

// state rezLink is where we rez the first object in inventory
// and link it until we have enough prims.
state rezLink
{
    state_entry()
    {
        // the nightbloom tells you some important info...
        llSay(0,"Nightbloom 2.0 is a piece of software licensed for use under a non-commercial copyleft license. Learn more about the Nightbloom and get the latest source code here: http://github.com/SoloMornington/nightbloom2");
        // make sure we don't already have enough prims
        // (state_exit will get rid of excess prims)
        if (llGetObjectPrimCount(llGetKey()) >= gPrimsInObject) state initPrims;
        // next make sure there's an inventory object to rez
        if (llGetInventoryNumber(INVENTORY_OBJECT) > 0)
        {
            // we have something to rez, so start rezzing...
            string objName = llGetInventoryName(INVENTORY_OBJECT, 0);
            llRezObject(objName, llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 0);
        }
        else
        {
            // nothing in inventory to rez, so tell the user
            // the changed event will happen when they put a prim in the inventory
            llOwnerSay("This object does not contain any other objects in its inventory. We need another prim to rez and link in.");
        }
    }

    object_rez(key obj)
    {
        // we created an object, so link it in.
        llCreateLink(obj, TRUE); // true means this prim remains as
        // do we have enough prims yet?
        if (llGetObjectPrimCount(llGetKey()) >= gPrimsInObject)
        {
            // note that we could have too many prims, if the inventory object
            // has more than one prim in it.
            // that's why we have the state_exit event. :-)
            state initPrims;
        }
        else
        {
            // not enough prims, so rez another
            string objName = llGetInventoryName(INVENTORY_OBJECT, 0);
            // rezzing an object will cause object_rez to fire again.
            llRezObject(objName, llGetPos(), ZERO_VECTOR, ZERO_ROTATION, 0);
        }
    }

    changed(integer what)
    {
        if (what & CHANGED_INVENTORY)
        {
            if (llGetInventoryNumber(INVENTORY_OBJECT) > 0)
            {
                // we have something to rez, so start rezzing...
                string objName = llGetInventoryName(INVENTORY_OBJECT, 0);
                llRezObject(objName, ZERO_VECTOR, ZERO_VECTOR, ZERO_ROTATION, 0);
            }
            else
            {
                // still nothing in inventory to rez, so tell the user
                llOwnerSay("This object does not contain any other objects in its inventory. We need another prim to rez and link in.");
            }
        }
    }

    state_exit()
    {
        // we might have too many prims, because our artist friends might
        // get clever and put this script into existing objects.
        // so we want to unlink a few of those prims.
        // the problem is that they'd then be just sitting around.
        // so we turn this object temp, unlink, and then go back to not-temp
        // this is a little risky, but will probably work for everyone.
        // setting temp....
        llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_TEMP_ON_REZ, TRUE]);
        // delinking spare prims....
        integer prims;
        while ((prims = llGetObjectPrimCount(llGetKey())) > gPrimsInObject)
        {
            // it doesn't matter which prim, as long as it's not the root.
            // and not a seated avatar.
            llBreakLink(gPrimsInObject);
        }
        // and now setting not temp.
        llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_TEMP_ON_REZ, FALSE]);
    }
}

state initPrims
{
    state_entry()
    {
        // make sure everything's all set for animation
        // we have 17 prims: 1 base and 16 petals.
        // stop all particles
        llLinkParticleSystem(LINK_SET, []);
        // set our params for the base object
        llSetLinkPrimitiveParamsFast(LINK_THIS, gBaseParams + gInitPrim +
            [PRIM_TEXTURE, ALL_SIDES, gTexture, <10.0, 10.0, 0.0>, <0.0, 0.0, 0.0>, 0.0,
            PRIM_NAME, "Nightbloom 2.0",
            PRIM_DESC, "GPL. Source Here: http://github.com/SoloMornington"
            ]);
        // set the geometry params for the petals
        // set the petals to be very small so they are essentially invisible.
        list petal = gPetalGeometry + gInitPrim + [
            PRIM_SIZE, <0.01,0.01,0.01>,
            PRIM_POSITION, <0,0,0>,
            PRIM_TEXTURE, ALL_SIDES, gTexture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0
            ];
        // we tried LINK_ALL_OTHERS, but it turns out that's limited to 10 prims
        integer i;
        for (i=2; i<=17; ++i)
            llSetLinkPrimitiveParamsFast(i, petal);
        // and finally start the animation process
        state phase;
    }
}


// #pragma mark ANIMATION STATES BEGIN HERE

// state phase is where we do all phase choices.
// since a function can't change state, we do it here.
state phase
{
    state_entry()
    {
        // find out which phase, from the function...
        gPhase = whichPhase();
        // go to the proper state depending on what we learned.
        if (gPhase == PHASE_STALK) state stalk;
        if (gPhase == PHASE_BLOOM) state bloom;
        if (gPhase == PHASE_WILT) state wilt;
        state die; // PHASE_DIE
    }
}

// all of these phase-specific states are very similar, with some
// tweaking for the different effects each has.
// notably glow in stalk and bloom, particles in bloom and wilt,
// and die is split into two parts.

// nightbloom 1.x had four scripts per petal so that each could
// perform these similar-but-unique functions.

state stalk
{
    state_entry()
    {
//        llOwnerSay("stalk");
        // set up our data sets...
        gCurrentBegin = gStalkBegin;
        gCurrentEnd = gStalkEnd;
        // turn off particles.
        llLinkParticleSystem(LINK_SET, []);
        // make sure we're opaque
        llSetLinkPrimitiveParams(LINK_SET, [PRIM_COLOR, ALL_SIDES, <1,1,1>, 1.0]);
        // start the timer ticking....
        llSetTimerEvent(gTimer);
        // do some animating
        animate_stalk();
    }

    timer()
    {
        // make sure we're in the proper phase state
        if (whichPhase() != gPhase) state phase;
        animate_stalk();
    }
}

state bloom
{
    state_entry()
    {
//        llOwnerSay("bloom");
        // set up our data sets...
        gCurrentBegin = gStalkEnd;
        gCurrentEnd = gWiltBegin;
        // turn off particles.
        llLinkParticleSystem(LINK_SET, []);
        // start the timer ticking....
        llSetTimerEvent(gTimer);
        // do some animating
        animate_bloom();
    }

    timer()
    {
        // make sure we're in the proper phase state
        if (whichPhase() != gPhase) state phase;
        // animate....?
        animate_bloom();
    }
}

state wilt
{
    state_entry()
    {
//        llOwnerSay("wilt");
        // set up our data sets...
        gCurrentBegin = gWiltBegin;
        gCurrentEnd = gDieBegin;
        // start the timer ticking....
        llSetTimerEvent(gTimer);
        // turn off glow to be sure
        llSetLinkPrimitiveParamsFast(LINK_SET, [PRIM_GLOW, ALL_SIDES, 0.0]);
        // do some animating
        animate_wilt();
    }

    timer()
    {
        // make sure we're in the proper phase state
        if (whichPhase() != gPhase) state phase;
        // animate!
        animate_wilt();
    }
}

state die
{
    state_entry()
    {
//        llOwnerSay("die");
        // set up our data sets...
        gCurrentBegin = gDieBegin;
        gCurrentEnd = gDieEnd;
        // half-way through this animation, we want to switch out some data
        // and reverse the alpha fade-out.
        // we accomplish this by having a flag called gDied which will
        // turn TRUE halfway through this animation phase.
        gDied = FALSE; // make sure and init this global.
        // start the timer ticking....
        llSetTimerEvent(gTimer);
        // turn off particles completely
        llLinkParticleSystem(LINK_SET, []);
        // do some animating
        animate_die();
        // turn off any remaining point lights.
        llSetLinkPrimitiveParamsFast(LINK_SET, [PRIM_POINT_LIGHT, FALSE, <1,1,1>, 0.0, 0.0, 0.0]);
    }

    timer()
    {
        // make sure we're in the proper phase state
        if (whichPhase() != gPhase) state phase;
        // and call the animation function
        animate_die();
    }
}

// fin. call it art.
