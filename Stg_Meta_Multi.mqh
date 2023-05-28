/**
 * @file
 * Implements Meta_Multi strategy based on the Meta_Multi indicator.
 */

// User input params.
INPUT_GROUP("Meta_Multi strategy: strategy params");
INPUT float Meta_Multi_LotSize = 0;                // Lot size
INPUT int Meta_Multi_SignalOpenMethod = 0;         // Signal open method
INPUT float Meta_Multi_SignalOpenLevel = 0;        // Signal open level
INPUT int Meta_Multi_SignalOpenFilterMethod = 32;  // Signal open filter method
INPUT int Meta_Multi_SignalOpenFilterTime = 3;     // Signal open filter time (0-31)
INPUT int Meta_Multi_SignalOpenBoostMethod = 0;    // Signal open boost method
INPUT int Meta_Multi_SignalCloseMethod = 0;        // Signal close method
INPUT int Meta_Multi_SignalCloseFilter = 32;       // Signal close filter (-127-127)
INPUT float Meta_Multi_SignalCloseLevel = 0;       // Signal close level
INPUT int Meta_Multi_PriceStopMethod = 0;          // Price limit method
INPUT float Meta_Multi_PriceStopLevel = 2;         // Price limit level
INPUT int Meta_Multi_TickFilterMethod = 32;        // Tick filter method (0-255)
INPUT float Meta_Multi_MaxSpread = 4.0;            // Max spread to trade (in pips)
INPUT short Meta_Multi_Shift = 0;                  // Shift
INPUT float Meta_Multi_OrderCloseLoss = 80;        // Order close loss
INPUT float Meta_Multi_OrderCloseProfit = 80;      // Order close profit
INPUT int Meta_Multi_OrderCloseTime = -30;         // Order close time in mins (>0) or bars (<0)
INPUT_GROUP("Meta_Multi strategy: Meta_Multi indicator params");
INPUT int Meta_Multi_Indi_Meta_Multi_Shift = 0;                                        // Shift
INPUT ENUM_IDATA_SOURCE_TYPE Meta_Multi_Indi_Meta_Multi_SourceType = IDATA_INDICATOR;  // Source type

// Structs.

// Defines struct with default user strategy values.
struct Stg_Meta_Multi_Params_Defaults : StgParams {
  Stg_Meta_Multi_Params_Defaults()
      : StgParams(::Meta_Multi_SignalOpenMethod, ::Meta_Multi_SignalOpenFilterMethod, ::Meta_Multi_SignalOpenLevel,
                  ::Meta_Multi_SignalOpenBoostMethod, ::Meta_Multi_SignalCloseMethod, ::Meta_Multi_SignalCloseFilter,
                  ::Meta_Multi_SignalCloseLevel, ::Meta_Multi_PriceStopMethod, ::Meta_Multi_PriceStopLevel,
                  ::Meta_Multi_TickFilterMethod, ::Meta_Multi_MaxSpread, ::Meta_Multi_Shift) {
    Set(STRAT_PARAM_LS, Meta_Multi_LotSize);
    Set(STRAT_PARAM_OCL, Meta_Multi_OrderCloseLoss);
    Set(STRAT_PARAM_OCP, Meta_Multi_OrderCloseProfit);
    Set(STRAT_PARAM_OCT, Meta_Multi_OrderCloseTime);
    Set(STRAT_PARAM_SOFT, Meta_Multi_SignalOpenFilterTime);
  }
};

#ifdef __config__
// Loads pair specific param values.
#include "config/H1.h"
#include "config/H4.h"
#include "config/H8.h"
#include "config/M1.h"
#include "config/M15.h"
#include "config/M30.h"
#include "config/M5.h"
#endif

class Stg_Meta_Multi : public Strategy {
 public:
  Stg_Meta_Multi(StgParams &_sparams, TradeParams &_tparams, ChartParams &_cparams, string _name = "")
      : Strategy(_sparams, _tparams, _cparams, _name) {}

  static Stg_Meta_Multi *Init(ENUM_TIMEFRAMES _tf = NULL) {
    // Initialize strategy initial values.
    Stg_Meta_Multi_Params_Defaults stg_demo_defaults;
    StgParams _stg_params(stg_demo_defaults);
#ifdef __config__
    SetParamsByTf<StgParams>(_stg_params, _tf, stg_demo_m1, stg_demo_m5, stg_demo_m15, stg_demo_m30, stg_demo_h1,
                             stg_demo_h4, stg_demo_h8);
#endif
    // Initialize indicator.
    // Initialize Strategy instance.
    ChartParams _cparams(_tf, _Symbol);
    TradeParams _tparams;
    Strategy *_strat = new Stg_Meta_Multi(_stg_params, _tparams, _cparams, "Meta_Multi");
    return _strat;
  }

  /**
   * Event on strategy's init.
   */
  void OnInit() {}

  /**
   * Check strategy's opening signal.
   */
  bool SignalOpen(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    // Indi_Meta_Multi *_indi = GetIndicator();
    bool _result = false;
    if (!_result) {
      // Returns false when indicator data is not valid.
      return false;
    }
    return _result;
  }
};
