/**
 * @file
 * Implements Multi meta strategy.
 */

// Prevents processing this includes file multiple times.
#ifndef STG_META_MULTI_MQH
#define STG_META_MULTI_MQH

// User input params.
INPUT2_GROUP("Meta Multi strategy: main params");
INPUT2 unsigned int Meta_Multi_Active_Strategies = (1 << 3) + (1 << 4) + (1 << 5) + (1 << 6) + (1 << 8) + (1 << 11) +
                                                   (1 << 15) + (1 << 20) + (1 << 21) + (1 << 22) + (1 << 23) +
                                                   (1 << 24);  // Active strategies
INPUT2_GROUP("Meta Multi strategy: common params");
INPUT2 float Meta_Multi_LotSize = 0;                // Lot size
INPUT2 int Meta_Multi_SignalOpenMethod = 0;         // Signal open method
INPUT2 float Meta_Multi_SignalOpenLevel = 0;        // Signal open level
INPUT2 int Meta_Multi_SignalOpenFilterMethod = 32;  // Signal open filter method
INPUT2 int Meta_Multi_SignalOpenFilterTime = 3;     // Signal open filter time (0-31)
INPUT2 int Meta_Multi_SignalOpenBoostMethod = 0;    // Signal open boost method
INPUT2 int Meta_Multi_SignalCloseMethod = 0;        // Signal close method
INPUT2 int Meta_Multi_SignalCloseFilter = 32;       // Signal close filter (-127-127)
INPUT2 float Meta_Multi_SignalCloseLevel = 0;       // Signal close level
INPUT2 int Meta_Multi_PriceStopMethod = 0;          // Price limit method
INPUT2 float Meta_Multi_PriceStopLevel = 2;         // Price limit level
INPUT2 int Meta_Multi_TickFilterMethod = 32;        // Tick filter method (0-255)
INPUT2 float Meta_Multi_MaxSpread = 4.0;            // Max spread to trade (in pips)
INPUT2 short Meta_Multi_Shift = 0;                  // Shift
INPUT2 float Meta_Multi_OrderCloseLoss = 80;        // Order close loss
INPUT2 float Meta_Multi_OrderCloseProfit = 80;      // Order close profit
INPUT2 int Meta_Multi_OrderCloseTime = -30;         // Order close time in mins (>0) or bars (<0)

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

class Stg_Meta_Multi : public Strategy {
 protected:
  DictStruct<long, Ref<Strategy>> strats;

 public:
  Stg_Meta_Multi(StgParams &_sparams, TradeParams &_tparams, ChartParams &_cparams, string _name = "")
      : Strategy(_sparams, _tparams, _cparams, _name) {}

  static Stg_Meta_Multi *Init(ENUM_TIMEFRAMES _tf = NULL, EA *_ea = NULL) {
    // Initialize strategy initial values.
    Stg_Meta_Multi_Params_Defaults stg_multi_defaults;
    StgParams _stg_params(stg_multi_defaults);
    // Initialize Strategy instance.
    ChartParams _cparams(_tf, _Symbol);
    TradeParams _tparams;
    Strategy *_strat = new Stg_Meta_Multi(_stg_params, _tparams, _cparams, "(Meta) Multi");
    return _strat;
  }

  /**
   * Event on strategy's init.
   */
  void OnInit() {}

  /**
   * Sets active strategies.
   */
  bool SetStrategies(EA *_ea = NULL) {
    bool _result = true;
    long _magic_no = Get<long>(STRAT_PARAM_ID);
    ENUM_TIMEFRAMES _tf = Get<ENUM_TIMEFRAMES>(STRAT_PARAM_TF);
    for (int _sid = 0; _sid < sizeof(int) * 8; ++_sid) {
      if ((Meta_Multi_Active_Strategies & (1 << _sid)) != 0) {
        switch (_sid) {
          case 1 << 0:
            _result &= StrategyAdd(STRAT_ADX);
            break;
          case 1 << 1:
            _result &= StrategyAdd(STRAT_AMA);
            break;
          case 1 << 2:
            _result &= StrategyAdd(STRAT_ASI);
            break;
          case 1 << 3:
            _result &= StrategyAdd(STRAT_ATR);
            break;
          case 1 << 4:
            _result &= StrategyAdd(STRAT_ALLIGATOR);
            break;
          case 1 << 5:
            _result &= StrategyAdd(STRAT_AWESOME);
            break;
          case 1 << 6:
            _result &= StrategyAdd(STRAT_BANDS);
            break;
          case 1 << 7:
            _result &= StrategyAdd(STRAT_CCI);
            break;
          case 1 << 8:
            _result &= StrategyAdd(STRAT_CHAIKIN);
            break;
          case 1 << 9:
            _result &= StrategyAdd(STRAT_DEMA);
            break;
          case 1 << 10:
            _result &= StrategyAdd(STRAT_DEMARKER);
            break;
          case 1 << 11:
            _result &= StrategyAdd(STRAT_ENVELOPES);
            break;
          case 1 << 12:
            _result &= StrategyAdd(STRAT_GATOR);
            break;
          case 1 << 13:
            _result &= StrategyAdd(STRAT_HEIKEN_ASHI);
            break;
          case 1 << 14:
            _result &= StrategyAdd(STRAT_ICHIMOKU);
            break;
          case 1 << 15:
            _result &= StrategyAdd(STRAT_INDICATOR);
            break;
          case 1 << 16:
            _result &= StrategyAdd(STRAT_MACD);
            break;
          case 1 << 17:
            _result &= StrategyAdd(STRAT_MFI);
            break;
          case 1 << 18:
            _result &= StrategyAdd(STRAT_OBV);
            break;
          case 1 << 19:
            _result &= StrategyAdd(STRAT_OSMA);
            break;
          case 1 << 20:
            _result &= StrategyAdd(STRAT_PATTERN);
            break;
          case 1 << 21:
            _result &= StrategyAdd(STRAT_PINBAR);
            break;
          case 1 << 22:
            _result &= StrategyAdd(STRAT_PIVOT);
            break;
          case 1 << 23:
            _result &= StrategyAdd(STRAT_RSI);
            break;
          case 1 << 24:
            _result &= StrategyAdd(STRAT_RVI);
            break;
          case 1 << 25:
            _result &= StrategyAdd(STRAT_SAR);
            break;
          case 1 << 26:
            _result &= StrategyAdd(STRAT_STDDEV);
            break;
          case 1 << 27:
            _result &= StrategyAdd(STRAT_STOCHASTIC);
            break;
          case 1 << 28:
            _result &= StrategyAdd(STRAT_WPR);
            break;
          case 1 << 29:
            _result &= StrategyAdd(STRAT_ZIGZAG);
            break;
          case 1 << 30:
            _result &= StrategyAdd(STRAT_MOMENTUM);
            break;
          case 1 << 31:
            _result &= StrategyAdd(STRAT_MA);
            break;
          default:
            logger.Warning(StringFormat("Unknown strategy: %d", _sid), __FUNCTION_LINE__, GetName());
            break;
        }
      }
    }
    return _result;
  }

  /**
   * Sets strategy.
   */
  bool StrategyAdd(ENUM_STRATEGY _sid, long _index = -1) {
    ENUM_TIMEFRAMES _tf = Get<ENUM_TIMEFRAMES>(STRAT_PARAM_TF);
    Ref<Strategy> _strat = StrategiesManager::StrategyInitByEnum(_sid, _tf);
    if (!_strat.IsSet()) {
      _strat = StrategiesMetaManager::StrategyInitByEnum((ENUM_STRATEGY_META)_sid, _tf);
    }
    if (_strat.IsSet()) {
      _strat.Ptr().Set<long>(STRAT_PARAM_ID, Get<long>(STRAT_PARAM_ID));
      _strat.Ptr().Set<ENUM_TIMEFRAMES>(STRAT_PARAM_TF, _tf);
      _strat.Ptr().Set<int>(STRAT_PARAM_TYPE, _sid);
      _strat.Ptr().OnInit();
      if (_index >= 0) {
        strats.Set(_index, _strat);
      } else {
        strats.Push(_strat);
      }
    }
    return _strat.IsSet();
  }

  /**
   * Check strategy's opening signal.
   */
  bool SignalOpen(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    bool _result = false;
    for (DictStructIterator<long, Ref<Strategy>> iter = strats.Begin(); iter.IsValid() && !_result; ++iter) {
      Strategy *_strat = iter.Value().Ptr();
      _level = _level == 0.0f ? _strat.Get<float>(STRAT_PARAM_SOL) : _level;
      _method = _method == 0 ? _strat.Get<int>(STRAT_PARAM_SOM) : _method;
      _shift = _shift == 0 ? _strat.Get<int>(STRAT_PARAM_SHIFT) : _shift;
      _result |= _strat.SignalOpen(_cmd, _method, _level, _shift);
    }
    return _result;
  }

  /**
   * Check strategy's closing signal.
   */
  bool SignalClose(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    bool _result = false;
    for (DictStructIterator<long, Ref<Strategy>> iter = strats.Begin(); iter.IsValid() && !_result; ++iter) {
      Strategy *_strat = iter.Value().Ptr();
      _level = _level == 0.0f ? _strat.Get<float>(STRAT_PARAM_SCL) : _level;
      _method = _method == 0 ? _strat.Get<int>(STRAT_PARAM_SCM) : _method;
      _shift = _shift == 0 ? _strat.Get<int>(STRAT_PARAM_SHIFT) : _shift;
      _result |= _strat.SignalClose(_cmd, _method, _level, _shift);
    }
    return _result;
  }
};

#endif  // STG_META_MULTI_MQH
