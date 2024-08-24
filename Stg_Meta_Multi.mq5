/**
 * @file
 * Implements Multi meta strategy.
 */

// Includes conditional compilation directives.
#include "config/define.h"

// Includes EA31337 framework.
#include <EA31337-classes/EA.mqh>
#include <EA31337-classes/Strategy.mqh>

// Includes indicator classes.
#include <EA31337-classes/Indicators/Bitwise/indicators.h>
#include <EA31337-classes/Indicators/Price/indicators.h>
#include <EA31337-classes/Indicators/Special/indicators.h>
#include <EA31337-classes/Indicators/indicators.h>

// Includes other strategy files.
#ifndef __strategies__
#include <EA31337-strategies/enum.h>
#include <EA31337-strategies/includes.h>
#include <EA31337-strategies/manager.h>
#endif
#ifdef __strategies_meta__
#include "../enum.h"
#include "../includes.h"
#include "../manager.h"
#endif

// Inputs.
input int Active_Tfs = M15B + M30B + H1B + H2B + H3B + H4B + H6B +
                       H8B;               // Timeframes (M1=1,M2=2,M5=16,M15=256,M30=1024,H1=2048,H2=4096,H3,H4,H6,H8)
input ENUM_LOG_LEVEL Log_Level = V_INFO;  // Log level.
input bool Info_On_Chart = true;          // Display info on chart.

// Includes strategy class.
#include "Stg_Meta_Multi.mqh"

// Defines.
#define ea_name "Strategy Meta_Multi"
#define ea_version "2.000"
#define ea_desc "Strategy based on EA31337 framework."
#define ea_link "https://github.com/EA31337/Strategy-Meta_Multi"
#define ea_author "EA31337 Ltd"

// Properties.
#property version ea_version
#ifdef __MQL4__
#property description ea_name
#property description ea_desc
#endif
#property link ea_link
#property copyright "Copyright 2016-2024, EA31337 Ltd"

// Class variables.
EA *ea;

/* EA event handler functions */

/**
 * Implements "Init" event handler function.
 *
 * Invoked once on EA startup.
 */
int OnInit() {
  bool _result = true;
  EAParams ea_params(__FILE__, Log_Level);
  ea = new EA(ea_params);
  _result &= ea.StrategyAdd<Stg_Meta_Multi>(Active_Tfs);
  for (DictStructIterator<long, Ref<Strategy>> iter = ea.GetStrategies().Begin(); iter.IsValid(); ++iter) {
    Stg_Meta_Multi *_strat = iter.Value().Ptr();
    _strat.SetStrategies(ea);
  }
  return (_result ? INIT_SUCCEEDED : INIT_FAILED);
}

/**
 * Implements "Tick" event handler function (EA only).
 *
 * Invoked when a new tick for a symbol is received, to the chart of which the Expert Advisor is attached.
 */
void OnTick() {
  ea.ProcessTick();
  if (!ea.GetTerminal().IsOptimization()) {
    ea.UpdateInfoOnChart();
  }
}

/**
 * Implements "Deinit" event handler function.
 *
 * Invoked once on EA exit.
 */
void OnDeinit(const int reason) { Object::Delete(ea); }
