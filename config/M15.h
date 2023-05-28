/*
 * @file
 * Defines default strategy parameter values for the given timeframe.
 */

// Defines indicator's parameter values for the given pair symbol and timeframe.
struct Indi_Meta_Multi_Params_M15 : IndiMeta_MultiParams {
  Indi_Meta_Multi_Params_M15() : IndiMeta_MultiParams(indi_demo_defaults, PERIOD_M15) { shift = 0; }
} indi_demo_m15;

// Defines strategy's parameter values for the given pair symbol and timeframe.
struct Stg_Meta_Multi_Params_M15 : StgParams {
  // Struct constructor.
  Stg_Meta_Multi_Params_M15() : StgParams(stg_demo_defaults) {}
} stg_demo_m15;
