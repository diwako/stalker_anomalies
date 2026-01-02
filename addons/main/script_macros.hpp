//diwako_anomalies script macros
#include "\x\cba\addons\main\script_macros_common.hpp"

#ifdef DISABLE_COMPILE_CACHE
  #undef PREP
  #define PREP(fncName) DFUNC(fncName) = compileScript [QPATHTOF(functions\DOUBLES(fn,fncName).sqf)]
#else
  #undef PREP
  #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fn,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef SUBPREP
    #undef SUBPREP
#endif

#ifdef DISABLE_COMPILE_CACHE
    #define SUBPREP(sub,fncName) DFUNC(fncName) = compileScript [QPATHTOF(functions\sub\DOUBLES(fn,fncName).sqf)]
#else
    #define SUBPREP(sub,fncName) [QPATHTOF(functions\sub\DOUBLES(fn,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

#define CHECK_FOLDER_1 anomalies
#define CHECK_FOLDER_2 blowout
#define CHECK_FOLDER_3 procedural

#define MEATGRINDER_MIN_COOL_DOWN 5.8
#define SPRINGBOARD_MIN_COOL_DOWN 1.25
#define TELEPORT_MIN_COOL_DOWN 0.15
#define CLICKER_MIN_COOL_DOWN 1.25

#define CLICKER_EXPLODE_TIME 1
#define SYSTEM_CHECK RUN_CHECK(CHECK_FOLDER_1,CHECK_FOLDER_2,CHECK_FOLDER_3)
#define RUN_CHECK(var1,var2,var3) !(call compileScript [QPATHTOF(BUILD_CHECK_FILE(var1,var2,var3))])

#define GRID_INACTIVE 0
#define GRID_PARTIAL 1
#define GRID_ACTIVE 2
