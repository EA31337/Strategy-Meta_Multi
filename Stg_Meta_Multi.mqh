/**
 * @file
 * Implements Meta Multi strategy.
 */

// User input params.
INPUT2_GROUP("Meta Multi strategy: main params");
INPUT2 ulong Meta_Multi_Active_Strategies = (1 << STRAT_ALLIGATOR) + (1 << STRAT_AWESOME) + (1 << STRAT_BANDS) +
                                            (1 << STRAT_ENVELOPES) + (1 << STRAT_ICHIMOKU);  // Active strategies
// (1 << STRAT_PATTERN) +
// (1 << STRAT_PINBAR) + (1 << STRAT_PIVOT) + (1 << STRAT_MACD) +
// (1 << STRAT_RSI) + (1 << STRAT_RVI) + (1 << STRAT_SAR);
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
    Stg_Meta_Multi_Params_Defaults stg_demo_defaults;
    StgParams _stg_params(stg_demo_defaults);
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
          case STRAT_NONE:
            break;
          case STRAT_AC:
            _result &= StrategyAdd<Stg_AC>(_tf, _magic_no, _sid);
            break;
          case STRAT_AD:
            _result &= StrategyAdd<Stg_AD>(_tf, _magic_no, _sid);
            break;
          case STRAT_ADX:
            _result &= StrategyAdd<Stg_ADX>(_tf, _magic_no, _sid);
            break;
          case STRAT_AMA:
            _result &= StrategyAdd<Stg_AMA>(_tf, _magic_no, _sid);
            break;
          case STRAT_ASI:
            _result &= StrategyAdd<Stg_ASI>(_tf, _magic_no, _sid);
            break;
          case STRAT_ATR:
            _result &= StrategyAdd<Stg_ATR>(_tf, _magic_no, _sid);
            break;
          case STRAT_ALLIGATOR:
            _result &= StrategyAdd<Stg_Alligator>(_tf, _magic_no, _sid);
            break;
          case STRAT_AWESOME:
            _result &= StrategyAdd<Stg_Awesome>(_tf, _magic_no, _sid);
            break;
          case STRAT_BWMFI:
            _result &= StrategyAdd<Stg_BWMFI>(_tf, _magic_no, _sid);
            break;
          case STRAT_BANDS:
            _result &= StrategyAdd<Stg_Bands>(_tf, _magic_no, _sid);
            break;
          case STRAT_BEARS_POWER:
            _result &= StrategyAdd<Stg_BearsPower>(_tf, _magic_no, _sid);
            break;
          case STRAT_BULLS_POWER:
            _result &= StrategyAdd<Stg_BullsPower>(_tf, _magic_no, _sid);
            break;
          case STRAT_CCI:
            _result &= StrategyAdd<Stg_CCI>(_tf, _magic_no, _sid);
            break;
          case STRAT_CHAIKIN:
            _result &= StrategyAdd<Stg_Chaikin>(_tf, _magic_no, _sid);
            break;
          case STRAT_DEMA:
            _result &= StrategyAdd<Stg_DEMA>(_tf, _magic_no, _sid);
            break;
          case STRAT_DEMARKER:
            _result &= StrategyAdd<Stg_DeMarker>(_tf, _magic_no, _sid);
            break;
          case STRAT_ENVELOPES:
            _result &= StrategyAdd<Stg_Envelopes>(_tf, _magic_no, _sid);
            break;
          case STRAT_FORCE:
            _result &= StrategyAdd<Stg_Force>(_tf, _magic_no, _sid);
            break;
          case STRAT_FRACTALS:
            _result &= StrategyAdd<Stg_Fractals>(_tf, _magic_no, _sid);
            break;
          case STRAT_GATOR:
            _result &= StrategyAdd<Stg_Gator>(_tf, _magic_no, _sid);
            break;
          case STRAT_HEIKEN_ASHI:
            _result &= StrategyAdd<Stg_HeikenAshi>(_tf, _magic_no, _sid);
            break;
          case STRAT_ICHIMOKU:
            _result &= StrategyAdd<Stg_Ichimoku>(_tf, _magic_no, _sid);
            break;
          case STRAT_INDICATOR:
            _result &= StrategyAdd<Stg_Indicator>(_tf, _magic_no, _sid);
            break;
          case STRAT_MA:
            _result &= StrategyAdd<Stg_MA>(_tf, _magic_no, _sid);
            break;
          case STRAT_MACD:
            _result &= StrategyAdd<Stg_MACD>(_tf, _magic_no, _sid);
            break;
          case STRAT_META_MULTI:
            _result &= StrategyAdd<Stg_Meta_Multi>(_tf, _magic_no, _sid);
            break;
          case STRAT_MFI:
            _result &= StrategyAdd<Stg_MFI>(_tf, _magic_no, _sid);
            break;
          case STRAT_MOMENTUM:
            _result &= StrategyAdd<Stg_Momentum>(_tf, _magic_no, _sid);
            break;
          case STRAT_OBV:
            _result &= StrategyAdd<Stg_OBV>(_tf, _magic_no, _sid);
            break;
          case STRAT_OSMA:
            _result &= StrategyAdd<Stg_OsMA>(_tf, _magic_no, _sid);
            break;
          case STRAT_PATTERN:
            _result &= StrategyAdd<Stg_Pattern>(_tf, _magic_no, _sid);
            break;
          case STRAT_PINBAR:
            _result &= StrategyAdd<Stg_Pinbar>(_tf, _magic_no, _sid);
            break;
          case STRAT_PIVOT:
            _result &= StrategyAdd<Stg_Pivot>(_tf, _magic_no, _sid);
            break;
          case STRAT_RSI:
            _result &= StrategyAdd<Stg_RSI>(_tf, _magic_no, _sid);
            break;
          case STRAT_RVI:
            _result &= StrategyAdd<Stg_RVI>(_tf, _magic_no, _sid);
            break;
          case STRAT_SAR:
            _result &= StrategyAdd<Stg_SAR>(_tf, _magic_no, _sid);
            break;
          case STRAT_STDDEV:
            _result &= StrategyAdd<Stg_StdDev>(_tf, _magic_no, _sid);
            break;
          case STRAT_STOCHASTIC:
            _result &= StrategyAdd<Stg_Stochastic>(_tf, _magic_no, _sid);
            break;
          case STRAT_WPR:
            _result &= StrategyAdd<Stg_WPR>(_tf, _magic_no, _sid);
            break;
          case STRAT_ZIGZAG:
            _result &= StrategyAdd<Stg_ZigZag>(_tf, _magic_no, _sid);
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
   * Adds strategy to specific timeframe.
   *
   * @param
   *   _tf - timeframe to add the strategy.
   *   _magic_no - unique order identified
   *
   * @return
   *   Returns true if the strategy has been initialized correctly, otherwise false.
   */
  template <typename SClass>
  bool StrategyAdd(ENUM_TIMEFRAMES _tf, long _magic_no = 0, int _type = 0) {
    bool _result = true;
    _magic_no = _magic_no > 0 ? _magic_no : rand();
    Ref<Strategy> _strat = ((SClass *)NULL).Init(_tf);
    _strat.Ptr().Set<long>(STRAT_PARAM_ID, _magic_no);
    _strat.Ptr().Set<ENUM_TIMEFRAMES>(STRAT_PARAM_TF, _tf);
    _strat.Ptr().Set<int>(STRAT_PARAM_TYPE, _type);
    _strat.Ptr().OnInit();
    _result &= strats.Push(_strat);
    return _result;
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
