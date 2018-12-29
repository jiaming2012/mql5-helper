//+------------------------------------------------------------------+
//|                                                       Logger.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#ifndef CONFIGUTILS
#define CONFIGUTILS
   #include <Packages\ConfigUtils.mqh>
#endif 

#ifdef LOGGER_DEPRECATED
   #define __PREFIX  
   #define __LOG_SIGNATURE               __LINE__, __FUNCTION__
   #define __LOG_DECLARATION             int __LINE__macro, string __FUNCTION__macro
#else
   #define __PREFIX                      traceback._LINE = __LINE__
   #define __LOG_SIGNATURE               traceback
   #define __LOG_DECLARATION             Traceback& trace
#endif 


#define _LOG_DEBUG(obj,message)                               {__PREFIX; obj.log(message, LOG_TYPE_DEBUG, __LOG_SIGNATURE);}
#define _LOG_EXTENSIVE(obj,message)                           {__PREFIX; obj.log(message, LOG_TYPE_EXTENSIVE, __LOG_SIGNATURE);}
#define _LOG_INFO(obj,message)                                {__PREFIX; obj.log(message, LOG_TYPE_INFO, __LOG_SIGNATURE);}
#define _LOG_INFO_UUID(obj,message)                           {__PREFIX; obj.log(message, LOG_TYPE_INFO, __LOG_SIGNATURE, false, __LINE__);}
#define _LOG_WARNING(obj,message)                             {__PREFIX; obj.log(message, LOG_TYPE_WARNING, __LOG_SIGNATURE);}
#define _LOG_DEV_WARNING(obj,message)                         {__PREFIX; obj.log(message, LOG_TYPE_DEV_WARNING, __LOG_SIGNATURE);}
#define _LOG_LOW(obj,message)                                 {__PREFIX; obj.log(message, LOG_TYPE_LOW, __LOG_SIGNATURE);}
#define _LOG_HIGH(obj,message)                                {__PREFIX; obj.log(message, LOG_TYPE_HIGH, __LOG_SIGNATURE);}
#define _LOG_SYSTEM(obj,message)                              {__PREFIX; obj.log(message, LOG_TYPE_SYSTEM, __LOG_SIGNATURE);}
#define _LOG_NETWORK(obj,message)                             {__PREFIX; obj.log(message, LOG_TYPE_NETWORK, __LOG_SIGNATURE);}

#define _LOG_SYSTEM_LINE_FILTERING(obj,message)               {__PREFIX; obj.log(message, LOG_TYPE_SYSTEM, __LOG_SIGNATURE, false, __LINE__);}
#define _LOG_NETWORK_LINE_FILTERING(obj,message)              {__PREFIX; obj.log(message, LOG_TYPE_NETWORK, __LOG_SIGNATURE, false, __LINE__);}

//--- ERROR messages: attach error description to end of message
#define _LOG_DEBUG_ERROR(obj,message)                         _LOG_DEBUG(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_INFO_ERROR(obj,message)                          _LOG_INFO(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_LOW_ERROR(obj,message)                           _LOG_LOW(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_HIGH_ERROR(obj,message)                          _LOG_HIGH(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_DEV_WARNING_ERROR(obj,message)                   _LOG_DEV_WARNING(obj,message + ", e="+ErrorDescription(GetLastError()));

//--- RAW messages: override_filtering=true
#define _LOG_DEBUG_RAW(obj,message)                           {__PREFIX; obj.log(message, LOG_TYPE_DEBUG, __LOG_SIGNATURE, true);}
#define _LOG_EXTENSIVE_RAW(obj,message)                       {__PREFIX; obj.log(message, LOG_TYPE_EXTENSIVE, __LOG_SIGNATURE, true);}
#define _LOG_INFO_RAW(obj,message)                            {__PREFIX; obj.log(message, LOG_TYPE_INFO, __LOG_SIGNATURE, true);}
#define _LOG_LOW_RAW(obj,message)                             {__PREFIX; obj.log(message, LOG_TYPE_LOW, __LOG_SIGNATURE, true);}
#define _LOG_HIGH_RAW(obj,message)                            {__PREFIX; obj.log(message, LOG_TYPE_HIGH, __LOG_SIGNATURE, true);}
#define _LOG_DEV_WARNING_RAW(obj,message)                     {__PREFIX; obj.log(message, LOG_TYPE_DEV_WARNING, __LOG_SIGNATURE, true);}

//--- ERROR and RAW
#define _LOG_INFO_ERROR_RAW(obj,message)                      {__PREFIX; obj.log(message + ", e="+ErrorDescription(GetLastError()), LOG_TYPE_INFO, __LOG_SIGNATURE, true);}
#define _LOG_LOW_ERROR_RAW(obj,message)                       {__PREFIX; obj.log(message+", e="+ErrorDescription(GetLastError()), LOG_TYPE_LOW, __LOG_SIGNATURE, true);}
#define _LOG_HIGH_ERROR_RAW(obj,message)                      {__PREFIX; obj.log(message+", e="+ErrorDescription(GetLastError()), LOG_TYPE_HIGH, __LOG_SIGNATURE, true);}

//--- Log one variable
#define _LOG_DEBUG_1(obj,variable)                            {__PREFIX; obj.log_variable(#variable, variable, LOG_TYPE_DEBUG, __LOG_SIGNATURE);}
#define _LOG_DEBUG_1_RAW(obj,variable)                        {__PREFIX; obj.log_variable(#variable, variable, LOG_TYPE_DEBUG, __LOG_SIGNATURE,true);}
#define _LOG_EXTENSIVE_1(obj,variable)                        {__PREFIX; obj.log_variable(#variable, variable, LOG_TYPE_EXTENSIVE, __LOG_SIGNATURE);}
#define _LOG_EXTENSIVE_1_RAW(obj,variable)                    {__PREFIX; obj.log_variable(#variable, variable, LOG_TYPE_EXTENSIVE, __LOG_SIGNATURE,true);}
#define _LOG_HIGH_1(obj,variable)                             {__PREFIX; obj.log_variable(#variable, variable, LOG_TYPE_HIGH, __LOG_SIGNATURE);}
#define _LOG_HIGH_1_ERROR(obj,variable)                       {__PREFIX; obj.log_variable(#variable, variable, "e", ErrorDescription(GetLastError()), LOG_TYPE_HIGH, __LOG_SIGNATURE, "");}

//--- Log two variables
#define _LOG_EXTENSIVE_2(obj,var1,compare,var2)               {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_EXTENSIVE,__LOG_SIGNATURE,compare);}
#define _LOG_EXTENSIVE_2_RAW(obj,var1,compare,var2)           {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_EXTENSIVE,__LOG_SIGNATURE,compare,true);}
#define _LOG_HIGH_2(obj,var1,compare,var2)                    {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_HIGH,__LOG_SIGNATURE,compare);}
#define _LOG_DEBUG_2(obj,var1,compare,var2)                   {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_DEBUG,__LOG_SIGNATURE,compare);}
#define _LOG_DEBUG_2_RAW(obj,var1,compare,var2)               {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_DEBUG,__LOG_SIGNATURE,compare,true);}
#define _LOG_INFO_2(obj,var1,compare,var2)                    {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_INFO,__LOG_SIGNATURE,compare);}
#define _LOG_INFO_2_RAW(obj,var1,compare,var2)                {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,LOG_TYPE_INFO,__LOG_SIGNATURE,compare,true);}

//--- Log three variables
#define _LOG_EXTENSIVE_3(obj,var1,var2,var3)                  {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_EXTENSIVE,__LOG_SIGNATURE);}
#define _LOG_EXTENSIVE_3_RAW(obj,var1,var2,var3)              {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_EXTENSIVE,__LOG_SIGNATURE,true);}
#define _LOG_DEBUG_3(obj,var1,var2,var3)                      {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_DEBUG,__LOG_SIGNATURE);}
#define _LOG_DEBUG_3_RAW(obj,var1,var2,var3)                  {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_DEBUG,__LOG_SIGNATURE,true);}
#define _LOG_HIGH_3(obj,var1,var2,var3)                       {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_HIGH,__LOG_SIGNATURE);}
#define _LOG_INFO_3(obj,var1,var2,var3)                       {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,LOG_TYPE_INFO,__LOG_SIGNATURE);}

//--- Log four variables
#define _LOG_DEBUG_4(obj,var1,var2,var3,var4)                 {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,LOG_TYPE_DEBUG,__LOG_SIGNATURE);}
#define _LOG_DEBUG_4_RAW(obj,var1,var2,var3,var4)             {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,LOG_TYPE_DEBUG,__LOG_SIGNATURE,true);}

//--- Log five variables
#define _LOG_DEBUG_5(obj,var1,var2,var3,var4,var5)            {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,#var5,var5,LOG_TYPE_DEBUG,__LOG_SIGNATURE);}
#define _LOG_DEBUG_5_RAW(obj,var1,var2,var3,var4,var5)        {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,#var5,var5,LOG_TYPE_DEBUG,__LOG_SIGNATURE,true);}
#define _LOG_DEBUG_5_UUID(obj,var1,var2,var3,var4,var5)       {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,#var5,var5,LOG_TYPE_DEBUG,__LOG_SIGNATURE,false,__LINE__);}
#define _LOG_INFO_5(obj,var1,var2,var3,var4,var5)             {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,#var5,var5,LOG_TYPE_INFO,__LOG_SIGNATURE);}

//--- Log six variables
#define _LOG_INFO_6(obj,var1,var2,var3,var4,var5,var6)        {__PREFIX; obj.log_variable(#var1,var1,#var2,var2,#var3,var3,#var4,var4,#var5,var5,#var6,var6,LOG_TYPE_INFO,__LOG_SIGNATURE);}

//--- Log file
#define _LOG_FILE_OPENING_ERROR(logger,filename)              _LOG_HIGH_ERROR(logger, "Failed to open file " + filename);

//--- Don't log to website
#define _LOG_HIGH_NO_SITE(obj,message)                        {__PREFIX; obj.log(message, LOG_TYPE_HIGH, __LOG_SIGNATURE, false, 0, true);}
#define _LOG_HIGH_NO_SITE_UUID(obj,message)                   {__PREFIX; obj.log(message, LOG_TYPE_HIGH, __LOG_SIGNATURE, false, __LINE__, true);}
#define _LOG_HIGH_ERROR_NO_SITE(obj,message)                   _LOG_HIGH_NO_SITE(obj,message + ", e="+ErrorDescription(GetLastError()));


//---- DEFAULT LOGGER
#define LOG_DEBUG(message)                               _LOG_DEBUG(logger,message)
#define LOG_EXTENSIVE(message)                           _LOG_EXTENSIVE(logger,message)
#define LOG_INFO(message)                                _LOG_INFO(logger,message)
#define LOG_INFO_UUID(message)                           _LOG_INFO_UUID(logger,message)
#define LOG_WARNING(message)                             _LOG_WARNING(logger,message)
#define LOG_DEV_WARNING(message)                         _LOG_DEV_WARNING(logger,message)
#define LOG_LOW(message)                                 _LOG_LOW(logger,message)
#define LOG_HIGH(message)                                _LOG_HIGH(logger,message)
#define LOG_SYSTEM(message)                              _LOG_SYSTEM(logger,message)
#define LOG_NETWORK(message)                             _LOG_NETWORK(logger,message)

#define LOG_SYSTEM_LINE_FILTERING(message)               _LOG_SYSTEM_LINE_FILTERING(logger,message)
#define LOG_NETWORK_LINE_FILTERING(message)              _LOG_NETWORK_LINE_FILTERING(logger, message)

#define LOG_HIGH_NO_SITE(message)                        _LOG_HIGH_NO_SITE(logger,message)
#define LOG_HIGH_ERROR_NO_SITE(message)                  _LOG_HIGH_ERROR_NO_SITE(logger,message)
#define LOG_HIGH_NO_SITE_UUID(message)                   _LOG_HIGH_NO_SITE_UUID(logger,message)

//--- ERROR messages: attach error description to end of message
#define LOG_DEBUG_ERROR(message)                         _LOG_DEBUG_ERROR(logger,message)
#define LOG_INFO_ERROR(message)                          _LOG_INFO_ERROR(logger,message)
#define LOG_LOW_ERROR(message)                           _LOG_LOW_ERROR(logger,message)
#define LOG_HIGH_ERROR(message)                          _LOG_HIGH_ERROR(logger,message)
#define LOG_DEV_WARNING_ERROR(message)                   _LOG_DEV_WARNING_ERROR(logger,message)

//--- RAW messages: override_filtering=true
#define LOG_DEBUG_RAW(message)                           _LOG_DEBUG_RAW(logger,message)
#define LOG_EXTENSIVE_RAW(message)                       _LOG_EXTENSIVE_RAW(logger,message)
#define LOG_INFO_RAW(message)                            _LOG_INFO_RAW(logger,message)
#define LOG_LOW_RAW(message)                             _LOG_LOW_RAW(logger,message)
#define LOG_HIGH_RAW(message)                            _LOG_HIGH_RAW(logger,message)
#define LOG_DEV_WARNING_RAW(message)                     _LOG_DEV_WARNING_RAW(logger,message)

//--- ERROR and RAW
#define LOG_INFO_ERROR_RAW(message)                      _LOG_INFO_ERROR_RAW(logger,message)
#define LOG_LOW_ERROR_RAW(message)                       _LOG_LOW_ERROR_RAW(logger,message)
#define LOG_HIGH_ERROR_RAW(message)                      _LOG_HIGH_ERROR_RAW(logger,message)

//--- Log one variable
#define LOG_DEBUG_1(variable)                            _LOG_DEBUG_1(logger,variable)
#define LOG_DEBUG_1_RAW(variable)                        _LOG_DEBUG_1_RAW(logger,variable)
#define LOG_EXTENSIVE_1(variable)                        _LOG_EXTENSIVE_1(logger,variable)
#define LOG_EXTENSIVE_1_RAW(variable)                    _LOG_EXTENSIVE_1_RAW(logger,variable)
#define LOG_HIGH_1(variable)                             _LOG_HIGH_1(logger,variable)
#define LOG_HIGH_1_ERROR(variable)                       _LOG_HIGH_1_ERROR(logger,variable)

//--- Log two variables
#define LOG_EXTENSIVE_2(var1,compare,var2)               _LOG_EXTENSIVE_2(logger,var1,compare,var2)
#define LOG_EXTENSIVE_2_RAW(var1,compare,var2)           _LOG_EXTENSIVE_2_RAW(logger,var1,compare,var2)
#define LOG_HIGH_2(var1,compare,var2)                    _LOG_HIGH_2(logger,var1,compare,var2)
#define LOG_DEBUG_2(var1,compare,var2)                   _LOG_DEBUG_2(logger,var1,compare,var2)
#define LOG_DEBUG_2_RAW(var1,compare,var2)               _LOG_DEBUG_2_RAW(logger,var1,compare,var2)
#define LOG_INFO_2(var1,compare,var2)                    _LOG_INFO_2(logger,var1,compare,var2)
#define LOG_INFO_2_RAW(var1,compare,var2)                _LOG_INFO_2_RAW(logger,var1,compare,var2)

//--- Log three variables
#define LOG_EXTENSIVE_3(var1,var2,var3)                  _LOG_EXTENSIVE_3(logger,var1,var2,var3) 
#define LOG_EXTENSIVE_3_RAW(var1,var2,var3)              _LOG_EXTENSIVE_3_RAW(logger,var1,var2,var3)      
#define LOG_DEBUG_3(var1,var2,var3)                      _LOG_DEBUG_3(logger,var1,var2,var3)  
#define LOG_DEBUG_3_RAW(var1,var2,var3)                  _LOG_DEBUG_3_RAW(logger,var1,var2,var3)    
#define LOG_HIGH_3(var1,var2,var3)                       _LOG_HIGH_3(logger,var1,var2,var3)  
#define LOG_INFO_3(var1,var2,var3)                       _LOG_INFO_3(logger,var1,var2,var3)        

//--- Log four variables
#define LOG_DEBUG_4(var1,var2,var3,var4)                 _LOG_DEBUG_4(logger,var1,var2,var3,var4)
#define LOG_DEBUG_4_RAW(var1,var2,var3,var4)             _LOG_DEBUG_4_RAW(logger,var1,var2,var3,var4)

//--- Log five variables
#define LOG_DEBUG_5(var1,var2,var3,var4,var5)            _LOG_DEBUG_5(logger,var1,var2,var3,var4,var5)
#define LOG_DEBUG_5_RAW(var1,var2,var3,var4,var5)        _LOG_DEBUG_5_RAW(logger,var1,var2,var3,var4,var5)
#define LOG_DEBUG_5_UUID(var1,var2,var3,var4,var5)       _LOG_DEBUG_5_UUID(logger,var1,var2,var3,var4,var5)
#define LOG_INFO_5(var1,var2,var3,var4,var5)             _LOG_INFO_5(logger,var1,var2,var3,var4,var5)

//--- Log six variables
#define LOG_INFO_6(var1,var2,var3,var4,var5,var6)        _LOG_INFO_6(logger,var1,var2,var3,var4,var5,var6)

//--- Special logger macros
#define LOG_FILE_OPENING_ERROR(filename)                 _LOG_FILE_OPENING_ERROR(logger,filename)
#define LOG_LAST_ERROR(conditional)                      if(!(conditional))  {  LOG_HIGH_ERROR(#conditional + " returned false"); }

#ifndef ARRAYINT
#define ARRAYINT
   #include <Arrays/ArrayInt.mqh>
#endif

#ifndef ARRAYSTRING
#define ARRAYSTRING
   #include <Arrays/ArrayString.mqh>
#endif

#ifndef AUTOSAVEARRAYSTRING
#define AUTOSAVEARRAYSTRING
   #include <Arrays/AutoSaveArrayString.mqh>
#endif 

#ifndef ARRAYDATETIME
#define ARRAYDATETIME
   #include <Arrays/ArrayDatetime.mqh>
#endif

#ifndef BASEDIR
#define BASEDIR
 string BASE_DIR="";
#endif

#ifndef ENABLE_TRACEBACK_OBJ
  #define ENABLE_TRACEBACK_OBJ
#endif 

#ifndef TRACEBACK 
#define TRACEBACK
   #include <Traceback.mqh>
#endif 

#ifndef STDLIB
#define STDLIB 
   #include <stdlib.mqh>
#endif 

#ifndef ENUMS
#define ENUMS
   #include <Super\Enums.mqh>
#endif 


bool DISABLE_LOGGING = false;
    
string LOGGER_TEMPLATE = 
"# Prority delay is minutes before an identical message will be logged\n"
"# LOW, HIGH, NETWORK messages always printed to terminal logs; additional option to open alert message\n"
"\n"
"# DEBUG		         Typically of interest only when diagnosing problems.\n"
"# DEBUG_EXTENSIVE   Detailed debug messages"
"# INFO		         Confirmation that things are working as expected.\n"
"# WARNING	         An indication that something unexpected happened, or indicative of some problem in the near future (e.g. ‘disk space low’). The software is still working as expected.\n"
"# DEV_WARNING       A warning message intended for dev use only\n"
"# LOW		         An error that is not critical to trading operations.\n"
"# HIGH   	         A serious error, indicating that the program itself may be unable to continue running.\n"
"# SYSTEM            A problem occurring with connect to trade terminal\n"
"# NETWORK           A problem occurring with connect to internet, etc.\n"
"\n"
"LOGGING_DEBUG = FALSE\n"
"LOGGING_DEBUG_EXTENSIVE = FALSE\n"
"LOGGING_INFO = TRUE\n"
"LOGGING_WARNING = TRUE\n"
"LOGGING_DEV_WARNING = TRUE\n"
"ALERT_LOGGING_LOW = FALSE\n"
"ALERT_LOGGING_HIGH = FALSE\n"
"ALERT_LOGGING_SYSTEM = FALSE\n"
"ALERT_LOGGING_NETWORK = FALSE\n"
"\n"
"SITE_LOGGING_DEBUG = FALSE\n"
"SITE_LOGGING_EXTENSIVE = FALSE\n"
"SITE_LOGGING_INFO = TRUE\n"
"SITE_LOGGING_WARNING = TRUE\n"
"SITE_LOGGING_DEV_WARNING = TRUE\n"
"SITE_LOGGING_LOW = TRUE\n"
"SITE_LOGGING_HIGH = TRUE\n"
"SITE_LOGGING_SYSTEM = TRUE\n"
"SITE_LOGGING_NETWORK = TRUE\n"
"\n"
"LOGGING_DEBUG_DELAY = 5\n"
"LOGGING_EXTENSIVE_DELAY = 5\n"
"LOGGING_INFO_DELAY = 5\n"
"LOGGING_WARNING_DELAY = 5\n"
"LOGGING_DEV_WARNING_DELAY = 2.5\n"
"LOGGING_LOW_DELAY = 2.5\n"
"LOGGING_HIGH_DELAY = 1\n"
"LOGGING_SYSTEM_DELAY = 0.5\n"
"LOGGING_NETWORK_DELAY = 0.25\n"
"\n"
"SHOW_LOG_VARIABLES_ON_EA_ATTACH = FALSE";

class Logger
{
 protected:
  CArrayDatetime timestamp;
  CArrayString msg;
  CArrayInt p_uuid;
  CArrayInt p_message_type;
  static CArrayString p_static_config_files;
  string p_program_name;
  string p_config_file_path;
  string p_display_name;
  
  bool CreateFileIfNotExists(string path);
  
  void log(const string full_description, string message, string traceback, LOG_TYPE type, bool override_filtering, uint log_uuid, bool disable_site);
  
  void post_to_site(LOG_TYPE type, string message, string traceback);
  
  template<typename T>
  void string_repr(const T &val, string &OUT_repr[], int &size);
  
  template<typename T>
  string string_repr(T val);
  
  template<typename T>
  void string_repr(const T &val[], string &OUT_repr[], int &size);
  
  bool LOGGING_DEBUG;
  bool LOGGING_EXTENSIVE;
  bool LOGGING_INFO;
  bool LOGGING_WARNING;
  bool LOGGING_DEV_WARNING;
  bool ALERT_LOGGING_LOW;
  bool ALERT_LOGGING_HIGH;
  bool ALERT_LOGGING_SYSTEM;
  bool ALERT_LOGGING_NETWORK;
  
  bool SITE_LOGGING_DEBUG;
  bool SITE_LOGGING_EXTENSIVE;
  bool SITE_LOGGING_INFO;
  bool SITE_LOGGING_WARNING;
  bool SITE_LOGGING_DEV_WARNING;
  bool SITE_LOGGING_LOW;
  bool SITE_LOGGING_HIGH;
  bool SITE_LOGGING_SYSTEM;
  bool SITE_LOGGING_NETWORK;
  
  double LOGGING_DEBUG_DELAY;
  double LOGGING_EXTENSIVE_DELAY;  
  double LOGGING_INFO_DELAY;
  double LOGGING_WARNING_DELAY;
  double LOGGING_DEV_WARNING_DELAY;
  double LOGGING_LOW_DELAY;
  double LOGGING_HIGH_DELAY;
  double LOGGING_SYSTEM_DELAY;
  double LOGGING_NETWORK_DELAY;
  
  bool SHOW_LOG_VARIABLES_ON_EA_ATTACH;
 
 public:
  void log(const string message, LOG_TYPE, Traceback& trace, bool override_filtering, uint log_uuid, bool disable_site);
  void log(const string message, LOG_TYPE, int __LINE__macro, string __FUNCTION__macro, bool override_filtering, uint uuid, bool disable_site);
  
  //--- log_variable: simple types, CArrayObj, arrays of simple types
   template <typename T1>
   void log_variable(const string var1_name, T1 var1, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
   template <typename T1>
   void log_variable(const string var1_name, const T1 &var1, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
   template <typename T1>
   void log_variable(const string var1_name, const T1 &var1[], LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
  template <typename T1, typename T2>
  void log_variable(string var1_name, T1 var1, string var2_name, T2 var2, LOG_TYPE, __LOG_DECLARATION, string comparison, bool override_filtering, uint uuid);
  
  template <typename T1, typename T2, typename T3>
  void log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
  template <typename T1, typename T2, typename T3, typename T4>
  void log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
  template <typename T1, typename T2, typename T3, typename T4, typename T5>
  void log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, string var5_name, T5 var5, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
  template <typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
  void log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, string var5_name, T5 var5, string var6_name, T6 var6, LOG_TYPE, __LOG_DECLARATION, bool override_filtering, uint uuid);
  
  void disable(LOG_TYPE type);
  void enable(LOG_TYPE type);
  void load();
 
 Logger(string __FILE__macro, string config_file_name=NULL);
};
//--------------------------------------------------------------
void Logger::post_to_site(LOG_TYPE type,string message,string traceback)
{
  if(StringFind(message, "\n") >= 0)
  {
   int s1=StringFind(message, "\n");
   string first_line=StringSubstr(message, 0, s1);
   log("Failed to log message for multiple lines: " + first_line + " ...", LOG_TYPE_HIGH, __LINE__, __FUNCTION__);
   return;
  }

  log("Attempting to post type=["+EnumToString(type)+"], msg="+message+", trace="+traceback+" to site", LOG_TYPE_EXTENSIVE, __LINE__, __FUNCTION__, true, 0, true);
  
  //--- Create unique filename
   string filepath = SITE_REPORTING_PATH;
   string fullpath, fname;
   int i=1;
   
   do {
    fname = StringConcatenate((int)TimeLocal(), "_", i, ".txt");
    fullpath = StringConcatenate(filepath, fname);
    i++;
   }
   while(FileIsExist(fullpath));
   
   string level=NULL;
   
   switch(type)
   {
    case LOG_TYPE_DEBUG: level="D"; break;
    case LOG_TYPE_EXTENSIVE: level="E"; break;
    case LOG_TYPE_INFO: level="I"; break;
    case LOG_TYPE_WARNING: level="W"; break;
    case LOG_TYPE_DEV_WARNING: level="V"; break;
    case LOG_TYPE_LOW: level="L"; break;
    case LOG_TYPE_HIGH: level="H"; break;
    case LOG_TYPE_SYSTEM: level="S"; break;
    case LOG_TYPE_NETWORK: level="N"; break;
   }
   
   int handle=FileOpen(fullpath, FILE_WRITE, '\t');
   
   if(handle>=0)
   {
    FileWrite(handle, TimeToStr(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS));
    FileWrite(handle, level);
    FileWrite(handle, message);
    FileWrite(handle, traceback);
    FileWrite(handle, Symbol());
    FileWrite(handle, Period());
    
    FileClose(handle);
   }
   else
    log("Unable to open file=" + fullpath + ", e=" + ErrorDescription(GetLastError()), LOG_TYPE_HIGH, __LINE__, __FUNCTION__, false, 0, true);
}
//--------------------------------------------------------------
template <typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
void Logger::log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, string var5_name, T5 var5, string var6_name, T6 var6, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
 __TRACE__
 
 string str1=NULL, str2=NULL, str3=NULL, str4=NULL, str5=NULL, str6=NULL;

 string type1=typename(T1), type2=typename(T2), type3=typename(T3), type4=typename(T4), type5=typename(T5), type6=typename(T6);
 
 if(type1=="datetime")
  str1=TimeToStr((datetime)var1, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str1=(string)var1;
  
  if(type2=="datetime")
  str2=TimeToStr((datetime)var2, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str2=(string)var2;
  
 if(type3=="datetime")
  str3=TimeToStr((datetime)var3, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str3=(string)var3;
  
 if(type4=="datetime")
  str4=TimeToStr((datetime)var4, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str4=(string)var4;
  
 if(type5=="datetime")
  str5=TimeToStr((datetime)var5, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str5=(string)var5;
  
 if(type6=="datetime")
  str6=TimeToStr((datetime)var6, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str6=(string)var6;
 
 log("[VAR] " + var1_name + "=" + str1 + ", " + var2_name + "=" + str2 + ", " + var3_name + "=" + str3 + ", " + var4_name + "=" + str4 + ", " + var5_name + "=" + str5 + ", " + var6_name + "=" + str6, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1, typename T2, typename T3, typename T4, typename T5>
void Logger::log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, string var5_name, T5 var5, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
 __TRACE__
 
 string str1=NULL, str2=NULL, str3=NULL, str4=NULL, str5=NULL;

 string type1=typename(T1), type2=typename(T2), type3=typename(T3), type4=typename(T4), type5=typename(T5);
 
 if(type1=="datetime")
  str1=TimeToStr((datetime)var1, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str1=(string)var1;
  
  if(type2=="datetime")
  str2=TimeToStr((datetime)var2, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str2=(string)var2;
  
 if(type3=="datetime")
  str3=TimeToStr((datetime)var3, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str3=(string)var3;
  
 if(type4=="datetime")
  str4=TimeToStr((datetime)var4, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str4=(string)var4;
  
 if(type5=="datetime")
  str5=TimeToStr((datetime)var5, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str5=(string)var5;
 
 log("[VAR] " + var1_name + "=" + str1 + ", " + var2_name + "=" + str2 + ", " + var3_name + "=" + str3 + ", " + var4_name + "=" + str4 + ", " + var5_name + "=" + str5, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1, typename T2, typename T3, typename T4>
void Logger::log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, string var4_name, T4 var4, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
 __TRACE__
 
 string str1=NULL, str2=NULL, str3=NULL, str4=NULL;

 string type1=typename(T1), type2=typename(T2), type3=typename(T3), type4=typename(T4);
 
 if(type1=="datetime")
  str1=TimeToStr((datetime)var1, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str1=(string)var1;
  
  if(type2=="datetime")
  str2=TimeToStr((datetime)var2, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str2=(string)var2;
  
 if(type3=="datetime")
  str3=TimeToStr((datetime)var3, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str3=(string)var3;
  
 if(type4=="datetime")
  str4=TimeToStr((datetime)var4, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str4=(string)var4;
 
 log("[VAR] " + var1_name + "=" + str1 + ", " + var2_name + "=" + str2 + ", " + var3_name + "=" + str3 + ", " + var4_name + "=" + str4, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1, typename T2, typename T3>
void Logger::log_variable(string var1_name, T1 var1, string var2_name, T2 var2, string var3_name, T3 var3, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
 BEGIN
 
 string str1=NULL, str2=NULL, str3=NULL;

 string type1=typename(T1), type2=typename(T2), type3=typename(T3);
 
 if(type1=="datetime")
  str1=TimeToStr((datetime)var1, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str1=(string)var1;
  
  if(type2=="datetime")
  str2=TimeToStr((datetime)var2, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str2=(string)var2;
  
 if(type3=="datetime")
  str3=TimeToStr((datetime)var3, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str3=(string)var3;
 
 log("[VAR] " + var1_name + "=" + str1 + ", " + var2_name + "=" + str2 + ", " + var3_name + "=" + str3, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1, typename T2>
void Logger::log_variable(string var1_name, T1 var1, string var2_name, T2 var2, LOG_TYPE log_type, __LOG_DECLARATION, string comparison="", bool override_filtering=false, uint uuid=0)
{
 BEGIN
 
 string str1=NULL, str2=NULL;
 string type1=typename(T1), type2=typename(T2);
 
 if(type1=="datetime")
  str1=TimeToStr((datetime)var1, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str1=(string)var1;
  
  if(type2=="datetime")
  str2=TimeToStr((datetime)var2, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else
  str2=(string)var2;
  
 log("[VAR] " + var1_name + "=" + str1 + ", " + var2_name + "=" + str2, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1>
void Logger::log_variable(const string var1_name, const T1 &var1[], LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
  __TRACE__
  
  string str1=NULL;
  string type1 = typename(T1);
  string repr[];
  int size;
  
  string_repr(var1, repr, size);
  
  string output="";
  for(int i=0; i<size; i++)
  {
   output += "[" + (string)i + "]=" + repr[i] + ", ";
  }
  
  //--- Remove last comma
   int len=StringLen(output);
   if(len > 0)
    output = StringSubstr(output, 0, len-2);

  log("[VAR] " + var1_name + ": " + output, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1>
void Logger::log_variable(const string var1_name, const T1 &var1, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
  __TRACE__
  
  string str1=NULL;
  string type1 = typename(T1);
  string repr[];
  int size;
  
  string_repr(var1, repr, size);
  
  string output="";
  for(int i=0; i<size; i++)
  {
   output += "[" + (string)i + "]=" + repr[i] + ", ";
  }
  
  //--- Remove last comma
   int len=StringLen(output);
   if(len > 0)
    output = StringSubstr(output, 0, len-2);
  
  log("[VAR] " + var1_name + "=" + output, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T1>
void Logger::log_variable(const string var1_name, T1 var1, LOG_TYPE log_type, __LOG_DECLARATION, bool override_filtering=false, uint uuid=0)
{
  BEGIN
  
  string str1=string_repr(var1);

  log("[VAR] " + var1_name + "=" + str1, log_type, __LOG_SIGNATURE, override_filtering, uuid);
}
//--------------------------------------------------------------
template <typename T>
void Logger::string_repr(const T &val, string &OUT_repr[], int &size)
{
 string type = typename(T);
 size=val.Total();
 ArrayResize(OUT_repr, size);
 
 if(type=="CArrayDatetime")
 {
  for(int i=0; i<size; i++)
   OUT_repr[i]=TimeToStr((datetime)val[i], TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 }
 else
 {
  for(int i=0; i<size; i++)
   OUT_repr[i]=(string)val[i];
 }
  
  return;
}
//--------------------------------------------------------------
template <typename T>
void Logger::string_repr(const T &val[], string &OUT_repr[], int &size)
{
 string type = typename(T);
 size=ArraySize(val);
 ArrayResize(OUT_repr, size);
 
 if(type=="datetime")
 {
  for(int i=0; i<size; i++)
   OUT_repr[i]=TimeToStr((datetime)val[i], TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 }
 else
 {
  for(int i=0; i<size; i++)
   OUT_repr[i]=(string)val[i];
 }
 
 return;
}
//--------------------------------------------------------------
template <typename T>
string Logger::string_repr(T val)
{
 string type = typename(T);
 
 if(type=="datetime")
  return TimeToStr((datetime)val, TIME_DATE|TIME_MINUTES|TIME_SECONDS);  //cast to datetime to remove complier warning message if T is type!=datetime
 else 
  return (string)val;
  
 return "";
}
//--------------------------------------------------------------
void Logger::disable(LOG_TYPE type)
{
 switch(type)
 {
  case LOG_TYPE_DEBUG:
   LOGGING_DEBUG = false;
   break;
   
  case LOG_TYPE_EXTENSIVE:
   LOGGING_EXTENSIVE = false;
   break;
   
  case LOG_TYPE_INFO:
   LOGGING_INFO = false;
   break;
   
  case LOG_TYPE_WARNING:
   LOGGING_WARNING = false;
   break;
   
  case LOG_TYPE_DEV_WARNING:
   LOGGING_DEV_WARNING = false;
   break;
   
  case LOG_TYPE_LOW:
   ALERT_LOGGING_LOW = false;
   break;
   
  case LOG_TYPE_HIGH:
   ALERT_LOGGING_HIGH = false;
   break;
  
  case LOG_TYPE_NETWORK:
   ALERT_LOGGING_NETWORK = false;
   break;
 }
}
//--------------------------------------------------------------
void Logger::enable(LOG_TYPE type)
{
 switch(type)
 {
  case LOG_TYPE_DEBUG:
   LOGGING_DEBUG = true;
   break;
   
  case LOG_TYPE_EXTENSIVE:
   LOGGING_EXTENSIVE = true;
   break;
   
  case LOG_TYPE_INFO:
   LOGGING_INFO = true;
   break;
   
  case LOG_TYPE_WARNING:
   LOGGING_WARNING = true;
   break;
   
  case LOG_TYPE_DEV_WARNING:
   LOGGING_DEV_WARNING = true;
   break;
   
  case LOG_TYPE_LOW:
   ALERT_LOGGING_LOW = true;
   break;
   
  case LOG_TYPE_HIGH:
   ALERT_LOGGING_HIGH = true;
   break;
  
  case LOG_TYPE_NETWORK:
   ALERT_LOGGING_NETWORK = true;
   break;
 }
}
//--------------------------------------------------------------

//initalization of of static variables at the global level
CArrayString Logger::p_static_config_files;

//--------------------------------------------------------------
void Logger::load()
{
 __TRACE__
 
 Sleep(200);   // wait in case web server overwrites logger file 
 string filename = BASE_DIR + "\\logger\\" + p_program_name + "_config.txt";
 
 if(p_program_name=="default") 
 {
  if(CreateFileIfNotExists(filename)) 
  {
   int handle = FileOpen(filename,FILE_WRITE);
   if(handle >= 0)
   {
    string display = "Creating the following file: Files\\" + filename;
    FileWrite(handle, LOGGER_TEMPLATE);
    Print(display);
    __ post_to_site(LOG_TYPE_DEV_WARNING, display, traceback.description());
    FileClose(handle);
   }
   else
   {
    __ post_to_site(LOG_TYPE_HIGH, "CreateFileIfNotExists() failed, filename=" + filename, traceback.description());
   }
  }
 }
 
 CArrayString variable, value;
 string expected[] = {  "LOGGING_DEBUG",
                        "LOGGING_DEBUG_EXTENSIVE",
                        "LOGGING_INFO",
                        "LOGGING_WARNING",
                        "LOGGING_DEV_WARNING",
                        "ALERT_LOGGING_LOW",
                        "ALERT_LOGGING_HIGH",
                        "ALERT_LOGGING_SYSTEM",
                        "ALERT_LOGGING_NETWORK",
                        
                        "SITE_LOGGING_DEBUG",
                        "SITE_LOGGING_EXTENSIVE",
                        "SITE_LOGGING_INFO",
                        "SITE_LOGGING_WARNING",
                        "SITE_LOGGING_DEV_WARNING",
                        "SITE_LOGGING_LOW",
                        "SITE_LOGGING_HIGH",
                        "SITE_LOGGING_SYSTEM",
                        "SITE_LOGGING_NETWORK",
                        
                        "LOGGING_DEBUG_DELAY",
                        "LOGGING_EXTENSIVE_DELAY",
                        "LOGGING_INFO_DELAY",
                        "LOGGING_WARNING_DELAY",
                        "LOGGING_DEV_WARNING_DELAY",
                        "LOGGING_LOW_DELAY",
                        "LOGGING_HIGH_DELAY",
                        "LOGGING_SYSTEM_DELAY",
                        "LOGGING_NETWORK_DELAY",
                        
                        "SHOW_LOG_VARIABLES_ON_EA_ATTACH"};
 string not_found[];
 
 ConfigFileLoader(filename, variable, value, expected, not_found);
 
 int err_size = ArraySize(not_found);
 if(err_size > 0)
 {
  string err_msg = "Load failed for unable to load following variable(s) from " + filename + ":\n";
  for(int i=0; i<err_size; i++)
   err_msg += not_found[i] + "\n";
  Print(err_msg);
  ExpertRemove();
 }

 int expected_total = ArraySize(expected);
 for(int i=0; i<expected_total; i++) 
 {
  int pos = variable.SearchLinear(expected[i]);
  
  string val = value[pos];
  if(!StringToUpper(val))
  {
   Print("StringToUpper() failed @ ", __FUNCTION__, "(", __LINE__, "), val=", val, ", e=", ErrorDescription(GetLastError()));
   ExpertRemove();
  }
  
  bool b_value = (val=="TRUE") ? true : false;
  
  if(expected[i]=="LOGGING_DEBUG")
   LOGGING_DEBUG = b_value;
  else if(expected[i]=="LOGGING_DEBUG_EXTENSIVE")
   LOGGING_EXTENSIVE = b_value;
  else if(expected[i]=="LOGGING_INFO")
   LOGGING_INFO = b_value;
  else if(expected[i]=="LOGGING_WARNING")
   LOGGING_WARNING = b_value;
  else if(expected[i]=="LOGGING_DEV_WARNING")
   LOGGING_DEV_WARNING = b_value;
  else if(expected[i]=="ALERT_LOGGING_LOW")
   ALERT_LOGGING_LOW = b_value;
  else if(expected[i]=="ALERT_LOGGING_HIGH")
   ALERT_LOGGING_HIGH = b_value;
  else if(expected[i]=="ALERT_LOGGING_SYSTEM")
   ALERT_LOGGING_SYSTEM = b_value;
  else if(expected[i]=="ALERT_LOGGING_NETWORK")
   ALERT_LOGGING_NETWORK = b_value;
  
  else if(expected[i]=="SITE_LOGGING_DEBUG")
   SITE_LOGGING_DEBUG = b_value;
  else if(expected[i]=="SITE_LOGGING_EXTENSIVE")
   SITE_LOGGING_EXTENSIVE = b_value;
  else if(expected[i]=="SITE_LOGGING_INFO")
   SITE_LOGGING_INFO = b_value;
  else if(expected[i]=="SITE_LOGGING_WARNING")
   SITE_LOGGING_WARNING = b_value;
  else if(expected[i]=="SITE_LOGGING_DEV_WARNING")
   SITE_LOGGING_DEV_WARNING = b_value;
  else if(expected[i]=="SITE_LOGGING_LOW")
   SITE_LOGGING_LOW = b_value;
  else if(expected[i]=="SITE_LOGGING_HIGH")
   SITE_LOGGING_HIGH = b_value;
  else if(expected[i]=="SITE_LOGGING_SYSTEM")
   SITE_LOGGING_SYSTEM = b_value;
  else if(expected[i]=="SITE_LOGGING_NETWORK")
   SITE_LOGGING_NETWORK = b_value;
   
  else if(expected[i]=="LOGGING_DEBUG_DELAY")
   LOGGING_DEBUG_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_EXTENSIVE_DELAY")
   LOGGING_EXTENSIVE_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_INFO_DELAY")
   LOGGING_INFO_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_WARNING_DELAY")
   LOGGING_WARNING_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_DEV_WARNING_DELAY")
   LOGGING_DEV_WARNING_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_LOW_DELAY")
   LOGGING_LOW_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_HIGH_DELAY")
   LOGGING_HIGH_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_SYSTEM_DELAY")
   LOGGING_SYSTEM_DELAY = (double)value[pos];
  else if(expected[i]=="LOGGING_NETWORK_DELAY")
   LOGGING_NETWORK_DELAY = (double)value[pos];
   
  else if(expected[i]=="SHOW_LOG_VARIABLES_ON_EA_ATTACH")
   SHOW_LOG_VARIABLES_ON_EA_ATTACH = b_value;
  else {
   Print("[UNKNOWN ERROR] unable to load logger!!!");
   ExpertRemove();
  }
 }

 string success_msg = StringConcatenate("Setting following variables from ", filename,":\n\n");
  
 success_msg += "LOGGING_DEBUG = " + (string)LOGGING_DEBUG + "\n";
 success_msg += "LOGGING_DEBUG_EXTENSIVE = " + (string)LOGGING_EXTENSIVE + "\n";
 success_msg += "LOGGING_INFO = " + (string)LOGGING_INFO + "\n";
 success_msg += "LOGGING_WARNING = " + (string)LOGGING_WARNING + "\n";    
 success_msg += "LOGGING_DEV_WARNING = " + (string)LOGGING_DEV_WARNING + "\n";
 success_msg += "ALERT_LOGGING_LOW = " + (string)ALERT_LOGGING_LOW + "\n";
 success_msg += "ALERT_LOGGING_HIGH = " + (string)ALERT_LOGGING_HIGH + "\n";
 success_msg += "ALERT_LOGGING_SYSTEM = " + (string)ALERT_LOGGING_SYSTEM + "\n";
 success_msg += "ALERT_LOGGING_NETWORK = " + (string)ALERT_LOGGING_NETWORK + "\n";
 
 success_msg += "SITE_LOGGING_DEBUG = " + (string)SITE_LOGGING_DEBUG + "\n";
 success_msg += "SITE_LOGGING_EXTENSIVE = " + (string)SITE_LOGGING_EXTENSIVE + "\n";
 success_msg += "SITE_LOGGING_INFO = " + (string)SITE_LOGGING_INFO + "\n";
 success_msg += "SITE_LOGGING_WARNING = " + (string)SITE_LOGGING_WARNING + "\n";
 success_msg += "SITE_LOGGING_DEV_WARNING = " + (string)SITE_LOGGING_DEV_WARNING + "\n";
 success_msg += "SITE_LOGGING_LOW = " + (string)SITE_LOGGING_LOW + "\n";
 success_msg += "SITE_LOGGING_HIGH = " + (string)SITE_LOGGING_HIGH + "\n";
 success_msg += "SITE_LOGGING_SYSTEM = " + (string)SITE_LOGGING_SYSTEM + "\n";
 success_msg += "SITE_LOGGING_NETWORK = " + (string)SITE_LOGGING_NETWORK + "\n";
 
 success_msg += "LOGGING_DEBUG_DELAY = " + (string)LOGGING_DEBUG_DELAY + "\n";
 success_msg += "LOGGING_EXTENSIVE_DELAY = " + (string)LOGGING_EXTENSIVE_DELAY + "\n";
 success_msg += "LOGGING_INFO_DELAY = " + (string)LOGGING_INFO_DELAY + "\n";
 success_msg += "LOGGING_WARNING_DELAY = " + (string)LOGGING_WARNING_DELAY + "\n";    
 success_msg += "LOGGING_DEV_WARNING_DELAY = " + (string)LOGGING_DEV_WARNING_DELAY + "\n";
 success_msg += "LOGGING_LOW_DELAY = " + (string)LOGGING_LOW_DELAY + "\n";
 success_msg += "LOGGING_HIGH_DELAY = " + (string)LOGGING_HIGH_DELAY + "\n";
 success_msg += "LOGGING_SYSTEM_DELAY = " + (string)LOGGING_SYSTEM_DELAY + "\n";
 success_msg += "LOGGING_NETWORK_DELAY = " + (string)LOGGING_NETWORK_DELAY + "\n";
 
 success_msg += "SHOW_LOG_VARIABLES_ON_EA_ATTACH = " + (string)SHOW_LOG_VARIABLES_ON_EA_ATTACH + "\n";
 
 if(SHOW_LOG_VARIABLES_ON_EA_ATTACH && p_static_config_files.SearchLinear(p_program_name) < 0)
  Print(success_msg);
  
 p_config_file_path = filename;
}
//--------------------------------------------------------------
Logger::log(const string message, LOG_TYPE type, Traceback &trace, bool override_filtering=false, uint log_uuid=0, bool disable_site=false)
{
 string full_traceback = trace.description();
 string site_traceback = StringSubstr(full_traceback, 3);   // chop off first '<- '
 string full_description=StringConcatenate("\"", message, "\"", full_traceback);
 log(full_description, message, site_traceback, type, override_filtering, log_uuid, disable_site);
}
//--------------------------------------------------------------
Logger::log(const string message, LOG_TYPE type, int __LINE__macro, string __FUNCTION__macro, bool override_filtering=false, uint log_uuid=0, bool disable_site=false)
{
 string traceback = StringConcatenate(p_display_name, " (", (string)__LINE__macro, "): ", __FUNCTION__macro);
 string full_description= StringConcatenate(traceback, ": ", message);
 log(full_description, message, traceback, type, override_filtering, log_uuid, disable_site);
}
//--------------------------------------------------------------
Logger::log(const string full_description, string message, string traceback, LOG_TYPE type, bool override_filtering=false, uint log_uuid=0, bool disable_site=false)
/*
switch must match order of LOG_TYPE enum (defined in Super\Enums.mqh)
*/
{
 if(DISABLE_LOGGING)
  return;
  
 int pos;
 
 if(log_uuid > 0)
   pos = p_uuid.SearchLinear(log_uuid);
 else
   pos = msg.SearchLinear(full_description);

 if(pos>=0 && p_message_type[pos]==type)
 {
  switch(type)
  {
   case LOG_TYPE_DEBUG:
    if(LOGGING_DEBUG)
    {
     if(TimeLocal() - timestamp[pos] >= LOGGING_DEBUG_DELAY * 60 || override_filtering)
     {
      Print("[DEBUG] ", full_description);
      
      if(SITE_LOGGING_DEBUG && !disable_site)
        post_to_site(type, message, traceback);
      
      timestamp.Update(pos, TimeLocal());
     }
    }
    
    break;
    
   case LOG_TYPE_EXTENSIVE:
    if(LOGGING_EXTENSIVE)
    {
     if(TimeLocal() - timestamp[pos] >= LOGGING_EXTENSIVE_DELAY * 60 || override_filtering)
     {
      Print("[DEBUG_EXT] ", full_description);
      
      if(SITE_LOGGING_EXTENSIVE && !disable_site)
        post_to_site(type, message, traceback);
      
      timestamp.Update(pos, TimeLocal());
     }
    }
    
    break;
    
   case LOG_TYPE_INFO:
    if(LOGGING_INFO)
    {
     if(TimeLocal() - timestamp[pos] >= LOGGING_INFO_DELAY * 60 || override_filtering)
     {
      Print("[INFO] ", full_description);
      
      if(SITE_LOGGING_INFO && !disable_site)
        post_to_site(type, message, traceback);
      
      timestamp.Update(pos, TimeLocal());
     }
    }
    
    break;
    
   case LOG_TYPE_WARNING:
    if(LOGGING_WARNING)
    {
     if(TimeLocal() - timestamp[pos] >= LOGGING_WARNING_DELAY * 60 || override_filtering)
     {
      Print("[WARNING] ", full_description);
      
      if(SITE_LOGGING_WARNING && !disable_site)
        post_to_site(type, message, traceback);
      
      timestamp.Update(pos, TimeLocal());
     }
    }
    break;
  
  case LOG_TYPE_DEV_WARNING:
    if(LOGGING_DEV_WARNING)
    {
     if(TimeLocal() - timestamp[pos] >= LOGGING_DEV_WARNING_DELAY * 60 || override_filtering)
     {
      Print("[DEV_WARNING] ", full_description);
      
      if(SITE_LOGGING_DEV_WARNING && !disable_site)
        post_to_site(type, message, traceback);
      
      timestamp.Update(pos, TimeLocal());
     }
    }
    break;
    
      
   case LOG_TYPE_LOW:
    if(TimeLocal() - timestamp[pos] >= LOGGING_LOW_DELAY * 60 || override_filtering)
    {
     if(ALERT_LOGGING_LOW)
      Alert("[LOW] ", full_description);
     else
      Print("[LOW] ", full_description);
      
     if(SITE_LOGGING_LOW && !disable_site)
        post_to_site(type, message, traceback);
      
     timestamp.Update(pos, TimeLocal());
    }   
    
    break;
    
   case LOG_TYPE_HIGH:
    if(TimeLocal() - timestamp[pos] >= LOGGING_HIGH_DELAY * 60 || override_filtering)
    {
     if(ALERT_LOGGING_HIGH)
      Alert("[HIGH] ", full_description);
     else
      Print("[HIGH] ", full_description);
     
     if(SITE_LOGGING_HIGH && !disable_site)
        post_to_site(type, message, traceback);
        
     timestamp.Update(pos, TimeLocal());
    }
    
    break;
    
  case LOG_TYPE_SYSTEM:
    if(TimeLocal() - timestamp[pos] >= LOGGING_SYSTEM_DELAY * 60 || override_filtering)
    { 
     if(ALERT_LOGGING_SYSTEM)
      Alert("[SYSTEM] ", full_description);
     else
      Print("[SYSTEM] ", full_description);
     
     if(SITE_LOGGING_SYSTEM && !disable_site)
        post_to_site(type, message, traceback);
        
     timestamp.Update(pos, TimeLocal());
    }
    
    break; 
    
  case LOG_TYPE_NETWORK:
    if(TimeLocal() - timestamp[pos] >= LOGGING_NETWORK_DELAY * 60 || override_filtering)
    { 
     if(ALERT_LOGGING_NETWORK)
      Alert("[NETWORK] ", full_description);
     else
      Print("[NETWORK] ", full_description);
     
     if(SITE_LOGGING_NETWORK && !disable_site)
        post_to_site(type, message, traceback);
        
     timestamp.Update(pos, TimeLocal());
    }
    
    break; 
  }
 }
 else
 {
  timestamp.Add(TimeLocal());
  msg.Add(full_description);
  p_message_type.Add(type);
  p_uuid.Add(log_uuid);
 
  switch(type)
  {
   case LOG_TYPE_DEBUG:
    if(LOGGING_DEBUG)
     Print("[DEBUG] ", full_description);
     
    if(SITE_LOGGING_DEBUG && !disable_site)
        post_to_site(type, message, traceback);
    
    break;
    
   case LOG_TYPE_EXTENSIVE:
     if(LOGGING_EXTENSIVE)
      Print("[DEBUG_EXT] ", full_description);
      
     if(SITE_LOGGING_EXTENSIVE && !disable_site)
        post_to_site(type, message, traceback);
    
    break;
    
   case LOG_TYPE_INFO:
    if(LOGGING_INFO)
     Print("[INFO] ", full_description);
     
    if(SITE_LOGGING_INFO && !disable_site)
        post_to_site(type, message, traceback);
     
    break;
    
   case LOG_TYPE_WARNING:
    if(LOGGING_WARNING)
     Print("[WARNING] ", full_description);
    
    if(SITE_LOGGING_WARNING && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
    
   case LOG_TYPE_DEV_WARNING:
    if(LOG_TYPE_DEV_WARNING)
     Print("[DEV_WARNING] ", full_description);
    
    if(SITE_LOGGING_DEV_WARNING && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
    
   case LOG_TYPE_LOW:
     if(ALERT_LOGGING_LOW)
      Alert("[LOW] ", full_description);
     else
      Print("[LOW] ", full_description);
     
     if(SITE_LOGGING_LOW && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
    
   case LOG_TYPE_HIGH:
     if(ALERT_LOGGING_HIGH)
      Alert("[HIGH] ", full_description);
     else
      Print("[HIGH] ", full_description);
     
     if(SITE_LOGGING_HIGH && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
   
   case LOG_TYPE_SYSTEM:
     if(ALERT_LOGGING_SYSTEM)
      Alert("[SYSTEM] ", full_description);
     else
      Print("[SYSTEM] ", full_description);
     
     if(SITE_LOGGING_SYSTEM && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
    
   case LOG_TYPE_NETWORK:
     if(ALERT_LOGGING_NETWORK)
      Alert("[NETWORK] ", full_description);
     else
      Print("[NETWORK] ", full_description);
     
     if(SITE_LOGGING_NETWORK && !disable_site)
        post_to_site(type, message, traceback);
        
    break;
  }
 }
}
//--------------------------------------------------------------
Logger::Logger(string __FILE__macro, string config_file_name=NULL)
{ 
 string res[];
 
 StringSplit(__FILE__macro, '.', res);
 p_display_name = res[0];
 
 if(config_file_name==NULL)
  p_program_name = p_display_name;
 else {
  StringSplit(config_file_name, '.', res);
  p_program_name = res[0];
 }
 
 load();
 
 p_static_config_files.Add(p_program_name);
}
//--------------------------------------------------------------
bool Logger::CreateFileIfNotExists(string path)
{
 string res[];
 StringReplace(path, "//", "/");
 StringSplit(path,'/',res);
 
 string p = "";
 int size = ArraySize(res);
 for(int i=0; i<size-1; i++) 
 {
  FolderCreate(p + res[i]);
  p += res[i] + "//";
 }
    
 if(!FileIsExist(path))
 {
  int handle = FileOpen(path, FILE_WRITE);
  if(handle >= 0)
  FileClose(handle);
  return true;
 }
 
 return false; 
}
