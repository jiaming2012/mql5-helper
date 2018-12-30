//+------------------------------------------------------------------+
//|                                                    Unittestss.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#define T_(func)                                if(!func)      return false
#define RUN(func)                               if(!func)      return;
#define BEGIN_TEST                              START_TEST(__FUNCTION__); bool ___last_result=false; TradeRecord trades[]; __TRACE__
#define END_TEST                                return STOP_TEST();
#define WAIT_TRUE(event, timeout_seconds)       _ustart=GetMicrosecondCount(); while(!(event)) { if((GetMicrosecondCount()-_ustart) / 1000000.0 >= timeout_seconds) { comment("after " + (string)timeout_seconds + " seconds, line=" + (string)__LINE__, "TIMED OUT"); break; } Sleep(250); } WAIT_RESULT=event
#define WAIT(event, timeout_seconds, func)      WAIT_TRUE(event, timeout_seconds); T_(func)

#define SECS
#define IGNORE_MAGIC                            -1

//Assertion macros
#define ASSERTION_TRUE(x)                          assertTrue(x, __LINE__)
#define ASSERTION_FALSE(x)                         assertFalse(x, __LINE__)
#define ASSERTION_EQUALS(x, y)                     assertEquals(x, y, __LINE__)
#define ASSERTION_NOT_EQUALS(x, y)                 assertNotEquals(x, y, __LINE__)
#define ASSERTION_CONTAINS(x, y)                   assertContains(x, y, __LINE__)
#define ASSERTION_NOT_CONTAINS(x, y)               assertNotContains(x, y, __LINE__)
#define ASSERTION_ORDERED(x, y)                    assertEquals(x, y, __LINE__, true)
#define ASSERTION_UNORDERED(x, y)                  assertEquals(x, y, __LINE__, false)
#define ASSERTION_GREATER_THAN(x, y)               assertGreaterThan(x, y, __LINE__)
#define ASSERTION_GREATER_THAN_OR_EQUAL(x, y)      assertGreaterThanOrEqual(x, y, __LINE__)
#define ASSERTION_LESS_THAN(x, y)                  assertLessThan(x, y, __LINE__)
#define ASSERTION_LESS_THAN_OR_EQUAL(x, y)         assertLessThanOrEqual(x, y, __LINE__)
#define ASSERTION_BUY_TRADE_COUNT(x)               assertTradeCount(x, OP_BUY, Symbol(), __LINE__)
#define ASSERTION_SELL_TRADE_COUNT(x)              assertTradeCount(x, OP_SELL, Symbol(), __LINE__)
#define ASSERTION_TRADE_COUNT(x)                   assertTradeCount(x, __LINE__)

#define ASSERT_TRUE(x)                             T_(ASSERTION_TRUE(x))
#define ASSERT_FALSE(x)                            T_(ASSERTION_FALSE(x))
#define ASSERT_EQUALS(x, y)                        T_(ASSERTION_EQUALS(x, y))
#define ASSERT_NOT_EQUALS(x, y)                    T_(ASSERTION_NOT_EQUALS(x, y))
#define ASSERT_CONTAINS(x, y)                      T_(ASSERTION_CONTAINS(x, y))
#define ASSERT_NOT_CONTAINS(x, y)                  T_(ASSERTION_NOT_CONTAINS(x, y))
#define ASSERT_ORDERED(x, y)                       T_(ASSERTION_ORDERED(x, y))
#define ASSERT_UNORDERED(x, y)                     T_(ASSERTION_UNORDERED(x, y))
#define ASSERT_GREATER_THAN(x, y)                  T_(ASSERTION_GREATER_THAN(x, y))
#define ASSERT_GREATER_THAN_OR_EQUAL(x, y)         T_(ASSERTION_GREATER_THAN_OR_EQUAL(x, y))
#define ASSERT_LESS_THAN(x, y)                     T_(ASSERTION_LESS_THAN(x, y))
#define ASSERT_LESS_THAN_OR_EQUAL(x, y)            T_(ASSERTION_LESS_THAN_OR_EQUAL(x, y))
#define ASSERT_BUY_TRADE_COUNT(x)                  T_(ASSERTION_BUY_TRADE_COUNT(x))
#define ASSERT_SELL_TRADE_COUNT(x)                 T_(ASSERTION_SELL_TRADE_COUNT(x))
#define ASSERT_TRADE_COUNT(x)                      T_(ASSERTION_TRADE_COUNT(x))

#define ASSERT_TRUE_OR_GET_LAST_ERROR(x)           ___last_result = assertTrue(x, __LINE__); if(!___last_result) { \
                                                    COMMENT("last error=" + ErrorDescription(GetLastError())); return false; }
                                                    
#define DEBUG_LINE_BREAK                           MessageBox("Break: line=" + (string)__LINE__, "Debug Break")

#define FAIL(x)                                    T_(fail(x, __LINE__))

#define COMMENT(msg)                               comment(msg, __LINE__)
#define COMMENT_1(var)                             comment(#var+"="+(string)var, __LINE__)

#define SUSPEND_TICK_RESET                      b_reset_prices = false;

#ifdef PERIOD
   #define MANAGER_SEND_TICK(symbol, prc)                                                 ManagerSendTick(symbol, prc, PERIOD)
   #define MANAGER_SEND_TICK_B(symbol, bid, ask)                                          ManagerSendTick(symbol, bid, ask, PERIOD)
   #define MANAGER_SEND_TICK_DELTA(symbol, bid_delta_in_points, ask_delta_in_points)      MANAGER_SEND_TICK_B(symbol, \
                                                                                           MarketInfo(symbol, MODE_BID) + (bid_delta_in_points*MarketInfo(symbol, MODE_POINT)), \
                                                                                           MarketInfo(symbol, MODE_ASK) + (ask_delta_in_points*MarketInfo(symbol, MODE_POINT)))
#endif 

ulong _ustart;
bool WAIT_RESULT;

#ifndef TESTSERVER
#define TESTSERVER
   #include <Testing/TestServer.mqh>
#endif 

#ifndef ARRAYSTRING
#define ARRAYSTRING
   #include <Arrays/ArrayString.mqh>
#endif 

#ifndef ARRAYDOUBLE
#define ARRAYDOUBLE
   #include <Arrays/ArrayDouble.mqh>
#endif 

#ifndef ARRAYLONG
#define ARRAYLONG
   #include <Arrays/ArrayLong.mqh>
#endif 

#ifndef ARRAYINT
#define ARRAYINT
   #include <Arrays/ArrayInt.mqh>
#endif 

#ifndef UTILS2
#define UTILS2
   #include <Utils2.mqh>
#endif 

#include <stdlib.mqh>
#include <Packages\StdOut.mqh>
#include <Packages\DllUtils.mqh>
#include <Packages\TCPClient.mqh>

#import "projects\\TerminalInterface\\TerminalInterface.dll"
   void LaunchProgram(string terminal_path, int type, string program_name, bool maximize_window=false);
   void TerminalLogin(int handle, string login, string passwd, string server);
#import

input string TRADING_LOGIN="20";
input string TRADING_PASSWD="test747";
input string TRADING_SERVER="52.192.37.22";

bool CheckCondition(bool condition)
{
 return condition;
}

struct TradeInfo
{
 int ticket;
 string symbol;
 double lots;
 ENUM_ORDER_TYPE cmd;
 string cmt;
 int magic;
};

struct ManagerCreds
{
 string host;
 int login;
 string passwd;
 
 ManagerCreds();
 ManagerCreds(string HOST, int LOGIN, string PASSWD);
 ManagerCreds(const ManagerCreds& creds);
};

ManagerCreds::ManagerCreds(string HOST,int LOGIN,string PASSWD)
{
 host = HOST;
 login = LOGIN;
 passwd = PASSWD;
}

ManagerCreds::ManagerCreds(const ManagerCreds& _creds)
{
 host = _creds.host;
 login = _creds.login;
 passwd = _creds.passwd;
}

class TestChart
{
 private:
  long p_id;
  Logger logger;
  
 public:
  long id() const { return p_id; }
  string symbol() const { return ChartSymbol(p_id); }
  bool ScreenShot(string filename, ENUM_CHART_MODE mode);
  
  TestChart(string program_name, string symbol, ENUM_TIMEFRAMES timeframe, string template_name);
  ~TestChart();
};

TestChart::~TestChart()
{
 ChartClose(p_id);
}

TestChart::TestChart(string program_name=NULL, string symbol=NULL, ENUM_TIMEFRAMES timeframe=PERIOD_CURRENT, string template_name=NULL)
 : logger(__FILE__)
{
 int period = (timeframe==PERIOD_CURRENT) ? Period() : (int)timeframe;

 p_id = ChartOpen(symbol, timeframe);
 
 if(template_name!=NULL)
  ChartApplyTemplate(p_id, template_name);
 
 ChartSetInteger(p_id, CHART_SCALE, 0, 4);
   
 ChartSetInteger(p_id, CHART_SHOW_ASK_LINE, 1);
 
 if(program_name!=NULL)
 {
  StringReplace(program_name, "\\", "/");
  LaunchProgram(TerminalPath(), 0, program_name);
 }
}

bool TestChart::ScreenShot(string filename, ENUM_CHART_MODE mode=CHART_CANDLES)
{
 ChartSetInteger(p_id, CHART_MODE, mode);
 
 string timestamp = TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS);
 StringReplace(timestamp, ":", "_");
 StringReplace(timestamp, " ", "_");
 
 filename += "_" + timestamp;
 
 bool result = ChartScreenShot(p_id, "Unittests\\Screenshots\\" + WindowExpertName() + "\\" + filename + ".gif", 800, 600);
 
 logger.log("[SCREENSHOT] " + filename + " sent", LOG_TYPE_INFO, __LINE__, __FUNCTION__, true);
 
 //--- Must send tick for ChartScreenShot to execute
 RefreshRates();
 string symbol = ChartSymbol(p_id);
 double bid = MarketInfo(symbol, MODE_BID);
 double ask = MarketInfo(symbol, MODE_ASK);
 double point = MarketInfo(symbol, MODE_POINT);
 ENUM_TIMEFRAMES period = (ENUM_TIMEFRAMES)ChartPeriod(p_id);
 
 double new_ask = ask + point;
 
 TestServer::ManagerSendTick(symbol, bid, new_ask);
 
 logger.log("Sent tick to activte screenshot -> (" + symbol + ", " + (string)bid + ", " + (string)new_ask + ") @ " + TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS), LOG_TYPE_INFO, __LINE__, __FUNCTION__);
 
 return result;
}


class Unittests
{
 private:
  int counter_passed;
  int counter_failed;
  string p_calling_function;
  ulong p_start_test_time;
  ulong p_init_time;
  CArrayString p_tick_symbol;
  CArrayDouble p_tick_starting_bid;
  CArrayDouble p_tick_starting_ask;
  CArrayLong p_tick_open_time;
  CArrayInt p_trade_booknum;
  CArrayString p_trade_symbol;
  CArrayInt p_trade_login;
  TestChart* ptr_test_charts[];
  StdOut stdout;
  TCPClient cl;
 
  template <typename T>
  void print_array(const T &arr[]);
  
  template <typename T>
  void print_array(const T &arr);
 
  void print_results();
  void print_trades(TradeInfo& trade[]);
  void test_clean_up();
  void remove_trade(int pos);
  bool run(bool, string, string, int, string);
  int get_trade_count(TradeInfo& trades[], string symbol, int magic);
  int get_trade_count(TradeInfo& trades[], int side, string symbol, int magic);
  string p_filepath;
  long p_time_diff;
  ManagerCreds p_manager_creds;
  Logger logger;
  
  bool _ClockSet(datetime x);
  
 protected:
  int passed_tests;
  bool b_reset_prices;
  void print_trades();
  
 public:
  bool assertTrue(bool x, int __LINE__macro, string msg=NULL);
  bool assertFalse(bool x, int __LINE__macro, string msg=NULL);
  
  bool assertLessThan(double x, double y, int __LINE__macro, string msg=NULL);
  bool assertGreaterThan(double x, double y, int __LINE__macro, string msg=NULL);
  bool assertLessThanOrEqual(double x, double y, int __LINE__macro, string msg=NULL);
  bool assertGreaterThanOrEqual(double x, double y, int __LINE__macro, string msg=NULL);
  
  bool assertEquals(int x, int y, int __LINE__macro, string msg=NULL);
  bool assertEquals(uint x, uint y, int __LINE__macro, string msg=NULL);
  bool assertEquals(double x, double y, int __LINE__macro, double threshold, string msg=NULL);
  bool assertEquals(string x, string y, int __LINE__macro, string msg=NULL);
  bool assertEquals(datetime x, datetime y, int __LINE__macro, string msg=NULL);
  bool assertEquals(long x, long y, int __LINE__macro, string msg=NULL);
  
  template <typename T>
  bool assertNotEquals(T x, T y, int __LINE__macro, string msg=NULL);
  
  template <typename T1, typename T2>
  bool assertEquals(const T1 &x[], const T2 &y[], int __LINE__macro, bool ordered, string msg);
  
  template <typename CArrayType1, typename CArrayType2>
  bool assertEquals(const CArrayType1 &x, const CArrayType2 &y, int __LINE__macro, bool ordered=true, string msg=NULL);
  
  template <typename T>
  bool assertContains(const T &x[], const T &y[], int __LINE__macro, string msg);
  
  template <typename CArrayType>
  bool assertContains(const CArrayType &x, const CArrayType &y, int __LINE__macro, string msg=NULL);
  
  template <typename T>
  bool assertNotContains(const T &x[], const T &y[], int __LINE__macro, string msg);
  
  template <typename CArrayType>
  bool assertNotContains(const CArrayType &x, const CArrayType &y, int __LINE__macro, string msg=NULL);
  
  bool assertTradeCount(int open_trades_count, int __LINE__macro, string msg=NULL);
  bool assertTradeCount(int open_trades_count, string symbol, int __LINE__macro, int magic, string msg=NULL);
  bool assertTradeCount(int open_trades_count, int cmd, string symbol, int __LINE__macro, int magic, string msg=NULL);
  
  bool assertObjectExists(string name, const TestChart &chart, int __LINE__macro, string msg=NULL);
  
  bool fail(string msg, int __LINE_macro);
  
  string print_new_section();
  string strip(string macro);
  void write(const string msg);
  void comment(const string msg, const string header);
  void comment(const string msg, int __LINE__macro, const string header);
  //bool ScreenShot(string filename, long chart_id, ENUM_CHART_MODE mode);
  
  void START_TEST(string __FUNCTION__macro);
  bool STOP_TEST();
  
  bool TestOrderClose(int ticket, double lots, double prc, int slippage, color arrow_color);
  int TestOrderSend(const string symbol, int cmd, double volume, double price, int slippage, double stoploss, double takeprofit, const string comment, int magic, datetime expiration, color arrow_code);
  bool ManagerConnect();
  int ManagerTradesRequest(TradeRecord& trades[]);
  int ManagerTradesRequest(TradeRecord& trades[], int login);
  int ManagerTradesRequest(TradeRecord& trades[], string symbol);
  int ManagerTradesRequest(TradeRecord& trades[], int login, string symbol);
  bool ManagerTradesCloseAll();
  bool ManagerTradesCloseAll(int login);
  bool ManagerTradesCloseAll(int login, string symbol);
  bool ManagerTradesCloseAll(string symbol);
  bool ManagerTradesClose(int& booknum[]);
  bool ManagerTradesClose(int booknum, double lots, double price=0);
  int ManagerTradeOpen(int login, string symbol, int cmd, double lots, double prc=0, double sl=0, double tp=0, string cmt=NULL);
  bool ManagerTradeInfo(int booknum, MqlTrade& info);
  void ManagerClosedTradeInfo(int booknum, ClosedTradeInfo& info);
  bool ManagerSendTick(string symbol, double prc, ENUM_TIMEFRAMES period);
  bool ManagerSendTick(string symbol, double bid, double ask, ENUM_TIMEFRAMES period);
  
  bool ClockSet(datetime x);
  bool NewBar(string symbol=NULL, ENUM_TIMEFRAMES period=PERIOD_CURRENT);
  bool NewTerminalLogin(string login, string passwd, string server);
  
  TestChart* Chart(string program_name, string symbol, ENUM_TIMEFRAMES timeframe, string template_name);
  
  Unittests(string __FILE__macro, string manager_host, int manager_login, string mangager_passwd, int remote_clock_port, string TEST_TYPE, bool manager_connected);
  ~Unittests();
};


bool Unittests::NewTerminalLogin(string login, string passwd, string server_host)
{
 __TRACE__
 
 LOG_INFO("Attempting to connect");
 ResetLastError();
 
 if(!IsConnected())
 {
  int handle = WindowHandle(Symbol(), Period());
  const int RETRIES = 3;
  const int TIMEOUT_SECS = 12;
  ulong _start = GetMicrosecondCount();
  
  for(int i=0; i<RETRIES; i++)
  {
   TerminalLogin(handle, login, passwd, server_host);
   
   while((GetMicrosecondCount()-_start) / 1000000.0 < TIMEOUT_SECS)
   {
    if(IsConnected()) {
     LOG_INFO("Successfully connected");
     return true;
    }
    
    Sleep(250);
   }
  }//end for
  
  LOG_HIGH_ERROR("Could not connect");
  return false;
 }
 else
 {
  Alert("Already connected");
  return true;
 }
}


template <typename CArrayType>
bool Unittests::assertNotContains(const CArrayType &x, const CArrayType &y, int __LINE__macro, string msg=NULL)
{
 int x_total=x.Total();
 int y_total=y.Total();
 bool result=false;
 
 for(int i=0; i<y_total; i++)
 {
  bool found_y=false;
  
  for(int j=0; j<x_total; j++)
  {
   if(x[j]==y[i]) {
    found_y=true;
    break;
   }
  }
  
  if(!found_y) {
   result=true;
   break;
  }
 }
 
 if(!result)
 {
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
 
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);;
}  


template <typename T>
bool Unittests::assertNotContains(const T &x[], const T &y[], int __LINE__macro, string msg="")
{
 int x_total=ArraySize(x);
 int y_total=ArraySize(y);
 bool result=false;
 
 for(int i=0; i<y_total; i++)
 {
  bool found_y=false;
  
  for(int j=0; j<x_total; j++)
  {
   if(x[j]==y[i]) {
    found_y=true;
    break;
   }
  }
  
  if(!found_y) {
   result=true;
   break;
  }
 }
 
 if(!result)
 {
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
 
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);;
}  


template <typename CArrayType>
bool Unittests::assertContains(const CArrayType &x, const CArrayType &y, int __LINE__macro, string msg=NULL)
{
 int x_total=x.Total();
 int y_total=y.Total();
 bool result=true;
 
 for(int i=0; i<y_total; i++)
 {
  bool found_y=false;
  
  for(int j=0; j<x_total; j++)
  {
   if(x[j]==y[i]) {
    found_y=true;
    break;
   }
  }
  
  if(!found_y) 
  {
   result=false;
   break;
  } 
 }
 
 if(!result)
 {
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
 
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);;
}  


template <typename T>
bool Unittests::assertContains(const T &x[], const T &y[], int __LINE__macro, string msg="")
{
 int x_total=ArraySize(x);
 int y_total=ArraySize(y);
 bool result=true;
 
 for(int i=0; i<y_total; i++)
 {
  bool found_y=false;
  
  for(int j=0; j<x_total; j++)
  {
   if(x[j]==y[i]) {
    found_y=true;
    break;
   }
  }
  
  if(!found_y)
  {
   result=false;
   break;
  } 
 }
 
 if(!result)
 {
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
 
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);
}  

bool Unittests::assertObjectExists(string object_name,const TestChart &chart,int __LINE__macro,string msg=NULL)
{
 long chart_id = chart.id();
 bool result = run(ObjectFind(chart_id, object_name) >= 0, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  int total = ObjectsTotal(chart_id, -1, -1);
  write("Unable to find object(name)=" + object_name);
  write("Printing (total=" + (string)total + ") object names for ChartSymbol=" + ChartSymbol(chart_id) + ", chart_id=" + (string)chart_id);
  
  for(int i=0; i<total; i++)
   write(ObjectName(chart_id, i, -1, -1));
 }
 
 return result;
}

void Unittests::ManagerClosedTradeInfo(int booknum, ClosedTradeInfo& info)
{
 __TRACE__
 
 TestServer::ManagerClosedTradeInfo(booknum, info);
 
 if(info.symbol == "")
  logger.log("#" + (string)booknum + "symbol == ''", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
  
 if(info.close_time == 0)
  logger.log("#" + (string)booknum + "close_time == 0", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
 
 if(MathAbs(info.close_price) < DBL_EPSILON)
  logger.log("#" + (string)booknum + "close_price == " + (string)info.close_price, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
 
 return;
}

bool Unittests::TestOrderClose(int ticket, double lots=0, double prc=0, int slippage=10, color arrow_color=clrNONE)
{
 __TRACE__
 
 if(OrderSelect(ticket, SELECT_BY_TICKET))
 {
  if(MathAbs(lots) < DBL_EPSILON)
   lots = OrderLots();
   
  if(MathAbs(prc) < DBL_EPSILON)
  {
   string symbol = OrderSymbol();
   int type = OrderType();
   
   if(type==OP_BUY)
    prc = MarketInfo(symbol, MODE_BID);
    
   if(type==OP_SELL)
    prc = MarketInfo(symbol, MODE_ASK);
  }
 }
 else
 {
  logger.log("Unable to select #" + (string)ticket, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
  return false;
 }

 bool ans = OrderClose(ticket, lots, prc, slippage, arrow_color);
 
 if(!ans)
 {
  int e = GetLastError();
  logger.log("Failed to close #" + (string)ticket + " with e='" + ErrorDescription(e) + "' (" + (string)e + ")", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
 }
 
 return ans;
}

int Unittests::TestOrderSend(const string symbol,int cmd,double volume,double price=0,int slippage=10,double stoploss=0,double takeprofit=0,const string comment=NULL,int magic=0,datetime expiration=0,color arrow_code=clrNONE)
{
 __TRACE__
 
 int e=0;
 
 if(cmd==OP_BUY)
  price = MarketInfo(symbol, MODE_ASK);
  
 if(cmd==OP_SELL)
  price = MarketInfo(symbol, MODE_BID);

 int ticket = OrderSend(symbol, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, expiration, arrow_code);

 if(ticket < 0)
 {
  e = GetLastError();
  logger.log("ticket < 0, e=" + (string)e + ", " + ErrorDescription(e), LOG_TYPE_LOW, __LINE__, __FUNCTION__, true);

  if(e==0)        //NO_ERR
  {
   Sleep(3000);
   
   ticket = OrderSend(symbol, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, expiration, arrow_code);
  }

  if(e==6)        //
  {
   NewTerminalLogin(TRADING_LOGIN, TRADING_PASSWD, TRADING_SERVER);
   
   Sleep(3000);
 
   if(IsConnected())
    ticket = OrderSend(symbol, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, expiration, arrow_code);
   else
    Alert("Still not connected");
  }

  if(e==136)      //ERR_OFF_QUOTES
  {
   double bid = MarketInfo(symbol, MODE_BID);
   double ask = MarketInfo(symbol, MODE_ASK);
   double point = MarketInfo(symbol, MODE_POINT);
  
   ManagerSendTick(symbol, bid, ask + point, (ENUM_TIMEFRAMES)Period());
   
   ticket = OrderSend(symbol, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, expiration, arrow_code);
   
   e = GetLastError();
  }
 }
 
 //--- report error
  if(ticket < 0)
   logger.log("Could not open trade w/ e= '" + ErrorDescription(e) + "' (" + (string)e + "), symbol=" + symbol + ", cmd=" + EnumToString((ENUM_ORDER_TYPE)cmd) + ", volume=" + DoubleToStr(volume, 2) + ", price=" + DoubleToStr(price, 5) + ", sl=" + DoubleToStr(stoploss, 5) + ", tp=" + DoubleToStr(takeprofit, 5), LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
 
 return ticket;
}

bool Unittests::NewBar(string symbol=NULL, ENUM_TIMEFRAMES period=PERIOD_CURRENT)
/* 
Automatically sends a new tick after re-setting the clock
*/
{
 __TRACE__
 
 const int EXTRA = 10;
 period = (period==PERIOD_CURRENT) ? (ENUM_TIMEFRAMES)Period() : period;
 int time_in_period = period * 60;
 datetime open_time = TestServer::TimeServer();
 int time_remaining = time_in_period - (int)MathMod(open_time, time_in_period);
 
 if(open_time == 0) {
  logger.log("local history is empty (not loaded)", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
  return false;
 }
 
 logger.log("[NEW BAR] " + TimeToStr(open_time, TIME_DATE|TIME_MINUTES|TIME_SECONDS) + " -> " + TimeToStr(open_time + time_remaining + EXTRA, TIME_DATE|TIME_MINUTES|TIME_SECONDS), LOG_TYPE_DEBUG, __LINE__, __FUNCTION__, true);
 
 datetime previous = iTime(symbol, period, 0);
 
 bool result = ClockSet(open_time + time_remaining + EXTRA);
 
 return result;
}

bool Unittests::ManagerConnect(void)
{
 __TRACE__
 
 const int RETRIES = 3;
 bool bIsConnected = false;
 
 for(int i=0; i<RETRIES; i++) {
  bIsConnected = TestServer::ManagerConnect(p_manager_creds.host, p_manager_creds.login, p_manager_creds.passwd) > 0;
  
  if(bIsConnected)
   break;
  
  int x = 3;
  logger.log("Still not connected, sleeping for " + (string)x + " seconds", LOG_TYPE_LOW, __LINE__, __FUNCTION__);
  Sleep(x * 1000);
 }
 
 if(!bIsConnected)
  logger.log("Unable to connect to manager, RETRIES=" + (string)RETRIES, LOG_TYPE_HIGH, __LINE__, __FUNCTION__);
 
 //--- log inital server time if not already previously logged
  if(MathAbs(p_time_diff) < DBL_EPSILON)
  {
   uint time_server = TestServer::TimeServer();
   p_time_diff = (time_server > 0) ? (int)(time_server - TimeLocal()) : 0;
  }
 
 return bIsConnected;
}

bool Unittests::ClockSet(datetime x)
{
 __TRACE__
 
 bool result = _ClockSet(x);
 
 if(result)
  logger.log("[CLOCK SET] success", LOG_TYPE_DEBUG, __LINE__, __FUNCTION__, true);
 else
  logger.log("[CLOCK SET] timed out", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
  
 if(!TestServer::ManagerIsConnected())
  ManagerConnect();
 
 return result;
}


bool Unittests::_ClockSet(datetime x)
{
  __TRACE__
  
  const int TIME_EPSILON = 59;   //SECONDS
  const int TIMEOUT = 20;        //SECONDS
  uint current = TestServer::TimeServer();
  
  string msg = "set_clock;" + TimeToStr(x, TIME_DATE|TIME_MINUTES|TIME_SECONDS);
  
  int diff = (int)((uint)x - current);
  
  int ret = cl.send(msg);
  
  datetime d1 = TimeLocal();
  
  Sleep(3000);
  
  NewTerminalLogin(TRADING_LOGIN, TRADING_PASSWD, TRADING_SERVER);
  
  while(TimeLocal() - d1 < TIMEOUT)
  {
   if(!TestServer::ManagerIsConnected())
    ManagerConnect();
 
   int new_diff = (int)((uint)x - TestServer::TimeServer());
   
   if(MathAbs(new_diff) < TIME_EPSILON) // seconds
   {  
    //--- send tick to update TimeCurrent() to server clock
     string symbol = "EURUSD";
     double bid = MarketInfo(symbol, MODE_BID);
     double ask = MarketInfo(symbol, MODE_ASK);
     double point = MarketInfo(symbol, MODE_POINT);
     
     ManagerSendTick(symbol, bid, ask + point, PERIOD_M1);
 
     bool result = MathAbs((uint)x - TimeCurrent()) < TIME_EPSILON;
     
     if(!result)
     {
      logger.log("x: " + TimeToStr(x, TIME_DATE|TIME_MINUTES|TIME_SECONDS), LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
      logger.log("TimeCurrent(): " + TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS), LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
     }
     
     return result; 
   }
   
   Sleep(250);
  }

  logger.log(" Clock failed to update", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
  comment("_ClockSet(), x=" + TimeToStr(x, TIME_DATE|TIME_MINUTES|TIME_SECONDS), "TIMED OUT");
  return false;  
}

TestChart* Unittests::Chart(string program_name=NULL, string symbol=NULL, ENUM_TIMEFRAMES timeframe=0, string template_name=NULL)
{
 TestChart* chart = new TestChart(program_name, symbol, timeframe, template_name);
 
 int idx = ArraySize(ptr_test_charts);
 
 ArrayResize(ptr_test_charts, idx+1);
 
 ptr_test_charts[idx] = chart;
 
 return chart;
}

//---not in use bc you have to send tick after taking screenshot for it to work
/*
bool Unittests::_ScreenShot(string filename, long chart_id=0, ENUM_CHART_MODE mode=CHART_BARS)
{
 ChartSetInteger(chart_id, CHART_MODE, mode);
 
 return ChartScreenShot(chart_id, "Unittests\\Screenshots\\" + WindowExpertName() + "\\" + filename + ".gif", 800, 600);
}
*/

void Unittests::write(const string msg)
{
 int handle = FileOpen(p_filepath, FILE_READ|FILE_WRITE, '\0');
 
 FileSeek(handle, 0, SEEK_END);
 
 FileWrite(handle, msg);
 
 FileClose(handle); 
}

void Unittests::comment(const string msg, const string header="COMMENT")
{
 string output = "[" + header + "] " + msg;
 
 write(output);
 
 Print(output);
}

void Unittests::comment(const string msg, int __LINE__macro, const string header="COMMENT")
{
 string output = "[" + header + "] " + msg + "|  line=" + (string)__LINE__macro;
 
 write(output);
 
 Print(output);
}

int Unittests::ManagerTradesRequest(TradeRecord& trades[])
{
 __TRACE__
 return TestServer::ManagerTradesRequest(trades);
}


int Unittests::ManagerTradesRequest(TradeRecord& trades[], int login)
{
 __TRACE__
 return TestServer::ManagerTradesRequest(trades, login);
}


int Unittests::ManagerTradesRequest(TradeRecord& trades[], string symbol)
{
 __TRACE__
 return TestServer::ManagerTradesRequest(trades, symbol);
}


int Unittests::ManagerTradesRequest(TradeRecord& trades[], int login, string symbol)
{
 __TRACE__
 return TestServer::ManagerTradesRequest(trades, login, symbol);
}


bool Unittests::ManagerTradesCloseAll()
{
 __TRACE__
 
 bool res = TestServer::ManagerTradesCloseAll();
 
 if(res)
 {
  p_trade_booknum.Clear();
  p_trade_symbol.Clear();
  p_trade_login.Clear();
 }
 else
  logger.log("Error deleting all trades", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


bool Unittests::ManagerTradesCloseAll(int login, string symbol)
{
 __TRACE__
 
 if(symbol==NULL)       symbol=Symbol();
 
 bool res = TestServer::ManagerTradesCloseAll(login, symbol);
 
 if(res)
 {
  int total = p_trade_symbol.Total();
  
  for(int i=total-1; i>=0; i--)
  {
   if(p_trade_symbol[i]==symbol && p_trade_login[i]==login)
    remove_trade(i);
  }
 }
 else
  logger.log("Error deleting symbol=" + (string)symbol + ", login=" + (string)login, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


bool Unittests::ManagerTradesCloseAll(int login)
{
 __TRACE__
 
 bool res = TestServer::ManagerTradesCloseAll(login);
 
 if(res)
 {
  int total = p_trade_symbol.Total();
  
  for(int i=total-1; i>=0; i--)
  {
   if(p_trade_login[i]==login)
    remove_trade(i);
  }
 }
 else
  logger.log("Error deleting login=" + (string)login, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


bool Unittests::ManagerTradesCloseAll(string symbol)
{
 __TRACE__
 
 if(symbol==NULL)       symbol=Symbol();
 
 bool res = TestServer::ManagerTradesCloseAll(symbol);
 
 if(res)
 {
  int total = p_trade_symbol.Total();
  
  for(int i=total-1; i>=0; i--)
  {
   if(p_trade_symbol[i]==symbol)
    remove_trade(i);
  }
 }
 else
  logger.log("Error deleting symbol=" + symbol, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


bool Unittests::ManagerTradesClose(int& booknum[])
{
 __TRACE__
 
 bool res = TestServer::ManagerTradesClose(booknum);
 
 if(res)
 {
  int total = ArraySize(booknum);
  
  for(int i=total-1; i>=0; i--)
  {
   int pos = p_trade_booknum.SearchLinear(booknum[i]);
   remove_trade(pos);
  }
 }
 else
  logger.log("Error deleting booknum[]", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


bool Unittests::ManagerTradesClose(int booknum, double lots=0, double price=0)
{
 __TRACE__
 
 if(MathAbs(lots) < DBL_EPSILON) {
  MqlTrade info;
  if(TestServer::ManagerTradeInfo(booknum, info))
   lots = info.lots;
 }
 
 bool res = TestServer::ManagerTradesClose(booknum, lots, price);
 
 if(res)
 {
  int pos = p_trade_booknum.SearchLinear(booknum);
  remove_trade(pos);
 }
 else
  logger.log("Error deleting booknum=" + (string)booknum + ", lots=" + (string)lots, LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false);
 
 return res;
}


int Unittests::ManagerTradeOpen(int login,string symbol,int cmd,double lots,double prc=0.000000,double sl=0.000000,double tp=0.000000,string cmt=NULL)
{
 int booknum = TestServer::ManagerTradeOpen(login, symbol, cmd, lots, prc, sl, tp, cmt);
 
 if(booknum > 0)
 {
  p_trade_login.Add(login);
  p_trade_booknum.Add(booknum);
  p_trade_symbol.Add(symbol);
 }
 
 return booknum;
}


bool Unittests::ManagerTradeInfo(int booknum,MqlTrade &info)
{
 __TRACE__
 return TestServer::ManagerTradeInfo(booknum, info);
}


bool Unittests::ManagerSendTick(string symbol, double bid, double ask, ENUM_TIMEFRAMES period)
{
 __TRACE__

 RefreshRates();
 symbol = (symbol==NULL) ? Symbol() : symbol;
 int digits = (int)MarketInfo(symbol, MODE_DIGITS);
 
 period = (period==PERIOD_CURRENT) ? (ENUM_TIMEFRAMES)Period() : period;
 symbol = (symbol==NULL) ? Symbol() : symbol;
 
 bool new_tick = p_tick_symbol.SearchLinear(symbol) < 0;
 double old_bid = MarketInfo(symbol, MODE_BID);
 double old_ask = MarketInfo(symbol, MODE_ASK);
 
 if(!TestServer::ManagerIsConnected()) {
  bool bIsConnected = false;
  for(int i=0; i<3 && !bIsConnected; i++)
  {
   logger.log("Attempt #" + (string)i + " ManagerConnect()", LOG_TYPE_DEBUG, __LINE__, __FUNCTION__, false);
   bIsConnected = ManagerConnect();
  }
 }
 
 bool ret = TestServer::ManagerSendTick(symbol, bid, ask);
 
 if(ret && new_tick)
 {
  p_tick_symbol.Add(symbol);
  p_tick_starting_bid.Add(old_bid);
  p_tick_starting_ask.Add(old_ask);
  p_tick_open_time.Add(iTime(symbol, period, 0));
 }

 if(ret)
 {
  const string log_msg = "[NEW TICK] (" + symbol + ", " + DoubleToStr(old_bid, digits) + ", " + DoubleToStr(old_ask, digits) + ") -> (" + DoubleToStr(bid, digits) + ", " + DoubleToStr(ask, digits) + ") sent @ " + TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES|TIME_SECONDS);
  logger.log(log_msg, LOG_TYPE_INFO, __LINE__, __FUNCTION__, true);
 
  const string std_log_msg = "sent tick: (" + symbol + ", " + DoubleToStr(bid, digits) + ", " + DoubleToStr(ask, digits) + ")";
  stdout << std_log_msg;
 }
 else
  logger.log("Send tick failed!", LOG_TYPE_HIGH, __LINE__, __FUNCTION__, true);
 
 return ret;
}


bool Unittests::ManagerSendTick(string symbol, double prc, ENUM_TIMEFRAMES period)
{
 __TRACE__
 return ManagerSendTick(symbol, prc, prc, period);
}


void Unittests::remove_trade(int pos)
{
 if(pos >= 0)
 {
  p_trade_login.Delete(pos);
  p_trade_booknum.Delete(pos);
  p_trade_symbol.Delete(pos);
 }
}


void Unittests::test_clean_up(void)
{
  __TRACE__
  
  int total;
  
 //--- Reset global variables
   GlobalVariablesDeleteAll("DISABLE-");
   
 //--- Reset prices back to starting price
  if(b_reset_prices)
  {
   total = p_tick_symbol.Total();
   for(int i=0; i<total; i++)
   {
    TestServer::ManagerSendTick(p_tick_symbol[i], p_tick_starting_bid[i], p_tick_starting_ask[i]); 
   }
  }
  
  b_reset_prices = true;
  
 //--- Close any trades opened via manager
  int bknum[];
  total = p_trade_booknum.Total();
  
  if(total > 0)
  {
    ArrayResize(bknum, total);
    for(int i=total-1; i>=0; i--)
    {
     bknum[i] = p_trade_booknum[i];
    }
  
    TestServer::ManagerTradesClose(bknum);
  }
  
 //--- Delete any objects from main chart
  long main_chart_id=0;
  int obj_total=ObjectsTotal(main_chart_id);
  
  for(int i=obj_total-1; i>=0; i--)
  {
   string name=ObjectName(main_chart_id, i);
   if(!ObjectDelete(main_chart_id, name))
    LOG_HIGH_ERROR("Failed to delete obj=" + name);
  }
  
 //--- Close own trades
  while(OrdersTotal() > 0 && !IsStopped()) {
   TestServer::ManagerTradesCloseAll(AccountNumber());
   Sleep(100);
  }
}


Unittests::~Unittests(void)
{
 __TRACE__
 
 if(counter_failed == 0) {
  write("Passed " + IntegerToString(passed_tests) + " test(s)");
 }

 write(print_new_section());
 print_results();
 write(print_new_section());
 
 if(counter_failed > 0)
 {
  write("TEST FAILED !!");
  Print("Test(s) failed !!");
 }
 else
 {
  write("ALL TESTS PASSED !!!"); 
  Print("Test(s) passed !!");
 }
 
 write("time took: " + DoubleToStr((GetMicrosecondCount() - p_init_time) / 1000000.0, 6) +" second(s)");
 write("Finished test at local time " + TimeToStr(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS));
 write(print_new_section());
 
 test_clean_up();

 //--- Delete candles from server
  int total = p_tick_symbol.Total();
  for(int i=total-1; i>=0; i--)
  {
   //Alert("Deleting tick from ", p_tick_symbol[i], " ... ", TimeToStr(p_tick_open_time[i], TIME_DATE|TIME_MINUTES|TIME_SECONDS));
   
   //--- if freezing occurs, consider deleting only if ArraySize(rates) > 0
    //RateInfo rates[];
    //TestServer::ManagerChartRequest(p_tick_symbol[i], PERIOD_M5, rates, p_tick_open_time[i]);
    //Alert("siz: ", ArraySize(rates));
   
   TestServer::ManagerChartDelete(p_tick_symbol[i], p_tick_open_time[i]);
  }

 //--- Close any left open test charts
  int size = ArraySize(ptr_test_charts);
  
  for(int i=size-1; i>=0; i--)
  {
   if(CheckPointer(ptr_test_charts[i]) != POINTER_INVALID)
    delete ptr_test_charts[i];
  }

 //--- Reset server clock
  if(p_time_diff > 0)
  {
   datetime original_time = (datetime)(TimeLocal() + p_time_diff);
   logger.log("dryrun: reset clock to " + TimeToStr(original_time, TIME_DATE|TIME_MINUTES|TIME_SECONDS), LOG_TYPE_INFO, __LINE__, __FUNCTION__, false);
   //_ClockSet(original_time);
  }
  else
   Print("[DEBUG] p_time_diff == 0");
}


Unittests::Unittests(string __FILE__macro, string manager_host, int manager_login, string manager_passwd, int remote_clock_port, string TEST_TYPE=NULL, bool manager_connect=true) 
  : logger(__FILE__), stdout("UNITTESTS"), cl(manager_host, remote_clock_port, false), p_time_diff(0), p_manager_creds(manager_host, manager_login, manager_passwd)
{
 __TRACE__
 
 if(!IsConnected())
  NewTerminalLogin(TRADING_LOGIN, TRADING_PASSWD, TRADING_SERVER);
 
 p_init_time = GetMicrosecondCount();

 counter_passed = 0;
 counter_failed = 0;
 passed_tests = 0;
 
 string temp[];
 StringSplit(__FILE__macro, '.', temp);
 FolderCreate("Unittests\\Logs");
 
 if(TEST_TYPE!=NULL)
  p_filepath = "Unittests\\Logs\\" + temp[0] + "__" + TEST_TYPE + ".txt";
 else
  p_filepath = "Unittests\\Logs\\" + temp[0] + ".txt";
 
 uint time_server = 0;
 
 if(manager_connect)
  ManagerConnect();      //nec for  TimeServer to work

 write(print_new_section());
 write("Starting " + __FILE__macro + " at local time " + TimeToStr(TimeLocal(), TIME_DATE|TIME_MINUTES|TIME_SECONDS));
 write(print_new_section());
 
 Print("****************************************************** START NEW TEST ******************************************************");
}


bool Unittests::STOP_TEST()
{
 write("[OK] Passed " + strip(p_calling_function) + " in " + DoubleToStr((GetMicrosecondCount() - p_start_test_time) / 1000000.0, 6) + " second(s)");
 passed_tests++;
 write(print_new_section());
 
 test_clean_up();
 
 return true;
}


void Unittests::START_TEST(string __FUNCTION__macro)
{
 p_start_test_time = GetMicrosecondCount();
 p_calling_function = __FUNCTION__macro;
 write("Begin: " + strip(p_calling_function));
 Print("[BEGIN] ", strip(p_calling_function));
}


void Unittests::print_trades(TradeInfo& trade[])
{
 int total = ArraySize(trade);
 
 for(int i=0; i<total; i++)
 {
  if(OrderSelect(i,SELECT_BY_POS))
  {
   ENUM_ORDER_TYPE type = (ENUM_ORDER_TYPE)OrderType();
   write("#" + (string)trade[i].ticket + ": " + trade[i].symbol + " - " + EnumToString(trade[i].cmd) + " - lots=" + DoubleToStr(trade[i].lots, 2) + " - cmt=" + trade[i].cmt + " - magic=" + (string)trade[i].magic);
  }
 }
}


void Unittests::print_trades(void)
{
 int total = OrdersTotal();
 
 comment("Printing trades, total = " + (string)total);
 
 for(int i=0; i<total; i++)
 {
  if(OrderSelect(i,SELECT_BY_POS))
  {
   ENUM_ORDER_TYPE type = (ENUM_ORDER_TYPE)OrderType();
   write("#" + (string)OrderTicket() + ": " + OrderSymbol() + " - " + EnumToString(type) + " - lots=" + DoubleToStr(OrderLots(), 2) + " - cmt=" + OrderComment() + " - magic=" + (string)OrderMagicNumber());
  }
 }
}


void Unittests::print_results(void)
{
  write("assertions passed: " + (string)counter_passed);
  write("assertions failed: " + (string)counter_failed);
}


template <typename T>
void Unittests::print_array(const T &arr[])
{
 int size=ArraySize(arr);
 for(int i=0; i<size; i++)
  write((string)i + ": " + (string)arr[i]);
}


template <typename T>
void Unittests::print_array(const T &arr)
{
 int size=arr.Total();
 for(int i=0; i<size; i++)
  write((string)i + ": " + (string)arr[i]);
}


template <typename CArrayType1, typename CArrayType2>
bool Unittests::assertEquals(const CArrayType1 &x, const CArrayType2 &y, int __LINE__macro, bool ordered=true, string msg=NULL)
{
 __TRACE__
 
 int t1=x.Total();
 int t2=y.Total();
 string type_x=typename(x);
 string type_y=typename(y);
 bool result;
 
 result = t1==t2;
 
 if(result)
 {
  if(ordered)
  { 
   for(int i=0; i<t1; i++)
   {
    if(type_x=="CArrayDouble")
     result = MathAbs(x[i]-y[i] < DBL_EPSILON);
    else
     result = x[i]==y[i];
    
    if(!result)
     break;
   }
  }
  else
  {
   for(int i=0; i<t1; i++)
   {
    bool match=false;
    
    for(int j=0; j<t2; j++)
    {
     if(type_x=="CArrayDouble")
     {
      if(MathAbs(x[i]-y[j] < DBL_EPSILON)) {
       match=true;
       break;
      }
     }
     else
     {
      if(x[i]==y[j]) {
       match=true;
       break;
      }
     }
    }
    
    if(!match) {
     result = false;
     break;
    }
   }
  } 
 }
 
 if(!result) {
  if(ordered)
   write("[ORDERED ARRAYS]");
  else
   write("[UNORDERED ARRAYS]");
 
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
  
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);
}


template <typename T1, typename T2>
bool Unittests::assertEquals(const T1 &x[], const T2 &y[], int __LINE__macro, bool ordered=true, string msg=NULL)
{
 __TRACE__
 
 int t1=ArraySize(x);
 int t2=ArraySize(y);
 string type_x=typename(x);
 string type_y=typename(y);
 bool result;
 
 result = t1==t2;
 
 if(result)
 {
  if(ordered)
  { 
   for(int i=0; i<t1; i++)
   {
    if(type_x=="double")
     result = MathAbs(x[i]-y[i] < DBL_EPSILON);
    else
     result = x[i]==y[i];
    
    if(!result)
     break;
   }
  }
  else
  {
   for(int i=0; i<t1; i++)
   {
    bool match=false;
    
    for(int j=0; j<t2; j++)
    {
     if(type_x=="double")
     {
      if(MathAbs(x[i]-y[j] < DBL_EPSILON)) {
       match=true;
       break;
      }
     }
     else
     {
      if(x[i]==y[j]) {
       match=true;
       break;
      }
     }
    }
    
    if(!match) {
     result = false;
     break;
    }
   }
  } 
 }
 
 if(!result) {
  if(ordered)
   write("[ORDERED ARRAYS]");
  else
   write("[UNORDERED ARRAYS]");
 
  write("x-array ------------------");
  print_array(x);
  write("y-array ------------------");
  print_array(y);
  write(print_new_section());
 }
  
 return run(result, __FUNCTION__, p_calling_function, __LINE__macro, msg);;
}


template <typename T>
bool Unittests::assertNotEquals(T x,T y,int __LINE__macro,string msg=NULL)
{
 bool result = run(x!=y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertEquals(int x, int y, int __LINE__macro, string msg=NULL)
{
 bool result = run(x==y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertEquals(uint x, uint y, int __LINE__macro, string msg=NULL)
{
 bool result = run(x==y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertEquals(long x, long y, int __LINE__macro, string msg=NULL)
{
 bool result = run(x==y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertEquals(datetime x, datetime y, int __LINE__macro, string msg=NULL)
{
 bool result = run(x==y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + TimeToStr(x, TIME_DATE|TIME_MINUTES|TIME_SECONDS));
  write("y = " + TimeToStr(x, TIME_DATE|TIME_MINUTES|TIME_SECONDS));
 }
 
 return result;
}


bool Unittests::assertEquals(double x, double y, int __LINE__macro, double threshold=0.00001, string msg=NULL)
{
 double res=MathAbs(x-y);
 bool result = run(res < threshold, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + (string)x);
  write("y = " + (string)y);
  write("threshold=" + (string)threshold);
  write("|x-y|=" + (string)res);
 }
 
 return result;
}


bool Unittests::assertEquals(string x, string y, int __LINE__macro, string msg=NULL)
{
 bool result = run(x==y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("x = " + x);
  write("y = " + y);
 }
 
 return result;
}


bool Unittests::assertFalse(bool x, int __LINE__macro, string msg=NULL)
{
 bool result = run(!x, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
  write("x = " + (string)x);
 
 return result;
}


bool Unittests::assertGreaterThanOrEqual(double x,double y,int __LINE__macro,string msg=NULL)
{
 bool result = run(x >= y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
 {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertGreaterThan(double x,double y,int __LINE__macro,string msg=NULL)
{
 bool result = run(x > y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
 {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertLessThanOrEqual(double x,double y,int __LINE__macro,string msg=NULL)
{
 bool result = run(x <= y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
 {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertLessThan(double x,double y,int __LINE__macro,string msg=NULL)
{
 bool result = run(x < y, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
 {
  write("x = " + (string)x);
  write("y = " + (string)y);
 }
 
 return result;
}


bool Unittests::assertTrue(bool x, int __LINE__macro, string msg=NULL)
{
 bool result = run(x, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result)
  write("x = " + (string)x);
 
 return result;
}


bool Unittests::fail(string msg, int __LINE__macro)
{
 return run(false, __FUNCTION__, p_calling_function, __LINE__macro, msg);
}

bool Unittests::run(bool result, 
                   string Unittests__FUNCTION__macro, 
                   string calling_FUNCTION__macro,
                   int __LINE__macro,
                   string msg=NULL)
{
 if((bool)GlobalVariableGet("UNITTESTS_STOP_TEST"))
 {
  counter_failed++;
  
  write("Failed: " + Unittests__FUNCTION__macro + "::" + calling_FUNCTION__macro + ", line=" + (string)__LINE__macro);
  comment("Stopped by user", "KILL TEST");
  
  GlobalVariableSet("UNITTESTS_STOP_TEST", 0);
  return false;
 }
 
 if(!result)
 {
  counter_failed++;
  
  write("Failed: " + Unittests__FUNCTION__macro + "::" + calling_FUNCTION__macro + ", line=" + (string)__LINE__macro);
  if(msg!=NULL)
   write("msg=" + msg);

  return false;
 }
 
 counter_passed++;
 return true;
}

bool Unittests::assertTradeCount(int open_trades_count, int cmd, string symbol, int __LINE__macro, int magic=IGNORE_MAGIC, string msg=NULL)
{
 if(symbol==NULL)
  symbol = Symbol();
  
 TradeInfo trades[];
 int actual_count = get_trade_count(trades, cmd, symbol, magic);
 bool result = run(open_trades_count==actual_count, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("expected_count = " + (string)open_trades_count);
  write("actual_count = " + (string)actual_count);
  print_trades(trades);
 }
  
 return result;
}

bool Unittests::assertTradeCount(int open_trades_count, string symbol, int __LINE__macro, int magic=IGNORE_MAGIC, string msg=NULL)
{
 if(symbol==NULL)
  symbol = Symbol();
  
 TradeInfo trades[];
 int actual_count = get_trade_count(trades, symbol, magic);
 bool result = run(open_trades_count==actual_count, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("expected_count = " + (string)open_trades_count);
  write("actual_count = " + (string)actual_count);
  print_trades(trades);
 }
  
 return result;
}

bool Unittests::assertTradeCount(int open_trades_count, int __LINE__macro, string msg=NULL)
{
 int actual_count = OrdersTotal();
 bool result = run(open_trades_count==actual_count, __FUNCTION__, p_calling_function, __LINE__macro, msg);
 
 if(!result) {
  write("expected_count = " + (string)open_trades_count);
  write("actual_count = " + (string)actual_count);
  print_trades();
 }
 
 return result;
}

int Unittests::get_trade_count(TradeInfo& trades[], int cmd, string symbol, int magic=IGNORE_MAGIC)
{
 if(symbol==NULL)    symbol = Symbol();
 
 int total = OrdersTotal();
 ArrayResize(trades, total);
 int count = 0;

 if(magic >= 0)
 {
  for(int i=0; i<total; i++)
  {
   if(OrderSelect(i,SELECT_BY_POS) && OrderSymbol()==symbol && OrderType()==cmd && OrderMagicNumber()==magic)
   {
    trades[count].symbol = OrderSymbol();
    trades[count].cmd = (ENUM_ORDER_TYPE)OrderType();
    trades[count].cmt = OrderComment();
    trades[count].lots = OrderLots();
    trades[count].magic = OrderMagicNumber();
    trades[count].ticket = OrderTicket();
    
    count++;
   }
  }
 }
 else
 {
  for(int i=0; i<total; i++)
  {
   if(OrderSelect(i,SELECT_BY_POS) && OrderType()==cmd && OrderSymbol()==symbol)
   {
    trades[count].symbol = OrderSymbol();
    trades[count].cmd = (ENUM_ORDER_TYPE)OrderType();
    trades[count].cmt = OrderComment();
    trades[count].lots = OrderLots();
    trades[count].magic = OrderMagicNumber();
    trades[count].ticket = OrderTicket();
    
    count++;
   }
  }
 }
 
 ArrayResize(trades, count);
 
 return count;
}

int Unittests::get_trade_count(TradeInfo& trades[], string symbol, int magic=IGNORE_MAGIC)
{
 if(symbol==NULL)    symbol = Symbol();
 
 int total = OrdersTotal();
 ArrayResize(trades, total);
 int count = 0;

 if(magic >= 0)
 {
  for(int i=0; i<total; i++)
  {
   if(OrderSelect(i,SELECT_BY_POS) && OrderSymbol()==symbol && OrderMagicNumber()==magic)
   {
    trades[count].symbol = OrderSymbol();
    trades[count].cmd = (ENUM_ORDER_TYPE)OrderType();
    trades[count].cmt = OrderComment();
    trades[count].lots = OrderLots();
    trades[count].magic = OrderMagicNumber();
    trades[count].ticket = OrderTicket();
    
    count++;
   }
  }
 }
 else
 {
  for(int i=0; i<total; i++)
  {
   if(OrderSelect(i,SELECT_BY_POS) && OrderSymbol()==symbol)
   {
    trades[count].symbol = OrderSymbol();
    trades[count].cmd = (ENUM_ORDER_TYPE)OrderType();
    trades[count].cmt = OrderComment();
    trades[count].lots = OrderLots();
    trades[count].magic = OrderMagicNumber();
    trades[count].ticket = OrderTicket();
    
    count++;
   }
  }
 }
 
 ArrayResize(trades, count);
 
 return count;
}

string Unittests::print_new_section(void)
{
 return("----------------------------------------------------");
}

string Unittests::strip(string macro)
{
 int pos = -1;
 
 pos = StringFind(macro, "::");
 
 if(pos >= 0)
  return StringSubstr(macro, pos+2);
  
 return macro;
}

//+------------------------------------------------------------------+
int OrdersTotal(string symbol)
{
 int total = OrdersTotal();
 int count = 0;
 symbol = (symbol==NULL) ? Symbol() : symbol;
 
 for(int i=0; i<total; i++)
 {
  if(OrderSelect(i,SELECT_BY_POS) && OrderSymbol()==symbol)
   count++;
 }
 
 return count;
}

//+------------------------------------------------------------------+
int OrdersTotal(string symbol, ENUM_ORDER_TYPE type)
{
 int total = OrdersTotal();
 int count = 0;
 symbol = (symbol==NULL) ? Symbol() : symbol;
 
 for(int i=0; i<total; i++)
 {
  if(OrderSelect(i,SELECT_BY_POS) && OrderSymbol()==symbol && OrderType()==type)
   count++;
 }
 
 return count;
}
