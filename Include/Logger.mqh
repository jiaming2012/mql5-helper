//+------------------------------------------------------------------+
//|                                                       Logger.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#define __PREFIX                      traceback._LINE = __LINE__
#define __LOG_SIGNATURE               traceback
#define __LOG_DECLARATION             Traceback& trace

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

//--- ERROR messages: attach error description to end of message
#define _LOG_DEBUG_ERROR(obj,message)                         _LOG_DEBUG(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_INFO_ERROR(obj,message)                          _LOG_INFO(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_LOW_ERROR(obj,message)                           _LOG_LOW(obj,message + ", e="+ErrorDescription(GetLastError()));
#define _LOG_HIGH_ERROR(obj,message)                          _LOG_HIGH(obj,message + ", e="+ErrorDescription(GetLastError()));

//--- Log file
#define _LOG_FILE_OPENING_ERROR(logger,filename)              _LOG_HIGH_ERROR(logger, "Failed to open file " + filename);

//---- DEFAULT LOGGER
#define LOG_DEBUG(message)                               _LOG_DEBUG(logger,message)
#define LOG_EXTENSIVE(message)                           _LOG_EXTENSIVE(logger,message)
#define LOG_INFO(message)                                _LOG_INFO(logger,message)
#define LOG_INFO_UUID(message)                           _LOG_INFO_UUID(logger,message)
#define LOG_WARNING(message)                             _LOG_WARNING(logger,message)
#define LOG_LOW(message)                                 _LOG_LOW(logger,message)
#define LOG_HIGH(message)                                _LOG_HIGH(logger,message)
#define LOG_SYSTEM(message)                              _LOG_SYSTEM(logger,message)
#define LOG_NETWORK(message)                             _LOG_NETWORK(logger,message)

//--- ERROR messages: attach error description to end of message
#define LOG_DEBUG_ERROR(message)                         _LOG_DEBUG_ERROR(logger,message)
#define LOG_INFO_ERROR(message)                          _LOG_INFO_ERROR(logger,message)
#define LOG_LOW_ERROR(message)                           _LOG_LOW_ERROR(logger,message)
#define LOG_HIGH_ERROR(message)                          _LOG_HIGH_ERROR(logger,message)

#ifndef ARRAYINT
#define ARRAYINT
   #include <Arrays/ArrayInt.mqh>
#endif

#ifndef ARRAYSTRING
#define ARRAYSTRING
   #include <Arrays/ArrayString.mqh>
#endif

#ifndef ENABLE_TRACEBACK_OBJ
  #define ENABLE_TRACEBACK_OBJ
#endif 

#ifndef TRACEBACK 
#define TRACEBACK
   #include <Traceback.mqh>
#endif 

enum LOG_TYPE { LOG_TYPE_DEBUG,
               LOG_TYPE_EXTENSIVE,
               LOG_TYPE_INFO,
               LOG_TYPE_WARNING,
               LOG_TYPE_LOW,
               LOG_TYPE_HIGH,
               LOG_TYPE_SYSTEM,
               LOG_TYPE_NETWORK };

class Logger
{
 protected:
  CArrayInt timestamp;
  CArrayString msg;
  CArrayInt p_message_type;
  static CArrayString p_static_config_files;
  string p_program_name;
  string p_config_file_path;
  string p_display_name;
  
  void log(const string full_description, string message, string traceback, LOG_TYPE type);
  
  template<typename T>
  void string_repr(const T &val, string &OUT_repr[], int &size);
  
  template<typename T>
  string string_repr(T val);
  
  template<typename T>
  void string_repr(const T &val[], string &OUT_repr[], int &size);
 
 public:
  void log(const string message, LOG_TYPE type, Traceback& trace);
  void log(const string message, LOG_TYPE type, int __LINE__macro, string __FUNCTION__macro);
   
  Logger(string __FILE__macro);
};

CArrayString Logger::p_static_config_files;

//--------------------------------------------------------------
Logger::Logger(string __FILE__macro)
{
 string res[];
 
 StringSplit(__FILE__macro, '.', res);
 
 p_program_name = res[0];
 
 p_static_config_files.Add(p_program_name);
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
Logger::log(const string message, LOG_TYPE type, Traceback &trace)
{
 string full_traceback = trace.description();
 string site_traceback = StringSubstr(full_traceback, 3);   // chop off first '<- '
 string full_description = "'" + message + "'" + full_traceback;
 log(full_description, message, site_traceback, type);
}
//--------------------------------------------------------------
Logger::log(const string message, LOG_TYPE type, int __LINE__macro, string __FUNCTION__macro)
{
 string traceback = p_display_name + " (" + (string)__LINE__macro + "): " + __FUNCTION__macro;
 string full_description= traceback + ": " + message;
 log(full_description, message, traceback, type);
}
//--------------------------------------------------------------
Logger::log(const string full_description, string message, string traceback, LOG_TYPE type)
/*
switch must match order of LOG_TYPE enum (defined in Super\Enums.mqh)
*/
{ 
  switch(type)
  {
   case LOG_TYPE_DEBUG:
     Print("[DEBUG] ", full_description);
    
    break;
    
   case LOG_TYPE_EXTENSIVE:
      Print("[DEBUG_EXT] ", full_description);
    
    break;
    
   case LOG_TYPE_INFO:
     Print("[INFO] ", full_description);
     
    break;
    
   case LOG_TYPE_WARNING:
     Print("[WARNING] ", full_description);
        
    break;
    
   case LOG_TYPE_LOW:
      Print("[LOW] ", full_description);
        
    break;
    
   case LOG_TYPE_HIGH:
      Print("[HIGH] ", full_description);
        
    break;
   
   case LOG_TYPE_SYSTEM:
      Print("[SYSTEM] ", full_description);
        
    break;
    
   case LOG_TYPE_NETWORK:
      Print("[NETWORK] ", full_description);
        
    break;
  }
}

