/*
 * @file
 * Defines default strategy parameter values for the given timeframe.
 */

// Defines indicator's parameter values for the given pair symbol and timeframe.
struct Indi_Meta_Multi_Params_H1 : IndiMeta_MultiParams {
  Indi_Meta_Multi_Params_H1() : IndiMeta_MultiParams(indi_demo_defaults, PERIOD_H1) { shift = 0; }
} indi_demo_h1;

// Defines strategy's parameter values for the given pair symbol and timeframe.
struct Stg_Meta_Multi_Params_H1 : StgParams {
  // Struct constructor.
  Stg_Meta_Multi_Params_H1() : StgParams(stg_demo_defaults) {}
} stg_demo_h1;
