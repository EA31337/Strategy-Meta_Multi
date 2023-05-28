/*
 * @file
 * Defines default strategy parameter values for the given timeframe.
 */

// Defines indicator's parameter values for the given pair symbol and timeframe.
struct Indi_Meta_Multi_Params_M30 : IndiMeta_MultiParams {
  Indi_Meta_Multi_Params_M30() : IndiMeta_MultiParams(indi_demo_defaults, PERIOD_M30) { shift = 0; }
} indi_demo_m30;

// Defines strategy's parameter values for the given pair symbol and timeframe.
struct Stg_Meta_Multi_Params_M30 : StgParams {
  // Struct constructor.
  Stg_Meta_Multi_Params_M30() : StgParams(stg_demo_defaults) {}
} stg_demo_m30;
