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

#define LOG_DEBUG(message)                               {__PREFIX; logger.log(message, LOG_TYPE_DEBUG, traceback);}
#define LOG_EXTENSIVE(message)                           {__PREFIX; logger.log(message, LOG_TYPE_EXTENSIVE, traceback);}
#define LOG_INFO(message)                                {__PREFIX; logger.log(message, LOG_TYPE_INFO, traceback);}
#define LOG_WARNING(message)                             {__PREFIX; logger.log(message, LOG_TYPE_WARNING, traceback);}
#define LOG_LOW(message)                                 {__PREFIX; logger.log(message, LOG_TYPE_LOW, traceback);}
#define LOG_HIGH(message)                                {__PREFIX; logger.log(message, LOG_TYPE_HIGH, traceback);}
#define LOG_SYSTEM(message)                              {__PREFIX; logger.log(message, LOG_TYPE_SYSTEM, traceback);}
#define LOG_NETWORK(message)                             {__PREFIX; logger.log(message, LOG_TYPE_NETWORK, traceback);}

//--- ERROR messages: attach error description to end of message
#define LOG_DEBUG_ERROR(message)                         LOG_DEBUG(message + ", e="+ErrorDescription(GetLastError()));
#define LOG_INFO_ERROR(message)                          LOG_INFO(message + ", e="+ErrorDescription(GetLastError()));
#define LOG_LOW_ERROR(message)                           LOG_LOW(message + ", e="+ErrorDescription(GetLastError()));
#define LOG_HIGH_ERROR(message)                          LOG_HIGH(message + ", e="+ErrorDescription(GetLastError()));

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
  string p_log_file_path;
  string p_display_name;
  
  void log(const string full_description, LOG_TYPE type);
  
  string deriveLogFilePath(const string &path[], const int path_len);
  
  string display(string full_description, LOG_TYPE type);
 
 public:
  void log(const string message, LOG_TYPE type, Traceback& trace);
  void log(const string message, LOG_TYPE type, int __LINE__macro, string __FUNCTION__macro);
   
  Logger(string __PATH__macro);
};

CArrayString Logger::p_static_config_files;

//--------------------------------------------------------------
string Logger::deriveLogFilePath(const string &path[], const int path_len)
{
   string custom_path="logger\\";
   
   //Append file path (after \MQL5\) to custom path
   for(int i=9; i<path_len-1; i++)
    custom_path += path[i] + "\\";
    
   //Create directory, if not exists
   FolderCreate(custom_path);
   
   //Append file name
   custom_path += "\\" + path[path_len-1];
    
   //Strip off the file extension
   custom_path = StringSubstr(custom_path, 0, StringLen(custom_path)-4);
   
   //Add new extension
   custom_path += ".log";
   
   return custom_path;
}
//--------------------------------------------------------------
Logger::Logger(string __PATH__macro)
{
 string res[];
 string path[];
 
 StringSplit(__PATH__macro, '\\', path);
 
 int path_len=ArraySize(path);
 string filename = path[path_len-1];
 
 StringSplit(filename, '.', res);
 
 p_program_name = res[0];
 
 p_static_config_files.Add(p_program_name);
 
 p_log_file_path = deriveLogFilePath(path, path_len);
}
//--------------------------------------------------------------
Logger::log(const string message, LOG_TYPE type, Traceback &trace)
{
 string full_traceback = trace.description();
 string site_traceback = StringSubstr(full_traceback, 3);   // chop off '<- '
 string full_description = "'" + message + "'" + full_traceback;
 log(full_description, type);
}
//--------------------------------------------------------------
Logger::log(const string message, LOG_TYPE type, int __LINE__macro, string __FUNCTION__macro)
{
 string traceback = p_display_name + " (" + (string)__LINE__macro + "): " + __FUNCTION__macro;
 string full_description= traceback + ": " + message;
 log(full_description, type);
}
//--------------------------------------------------------------
string Logger::display(string full_description, LOG_TYPE type)
{
 switch(type)
  {
   case LOG_TYPE_DEBUG:
     return("[DEBUG] " + full_description);
    
   case LOG_TYPE_EXTENSIVE:
     return("[DEBUG_EXT] " + full_description);
    
   case LOG_TYPE_INFO:
     return("[INFO] " + full_description);
    
   case LOG_TYPE_WARNING:
     return("[WARNING] " + full_description);
        
   case LOG_TYPE_LOW:
     return("[LOW] " + full_description);

   case LOG_TYPE_HIGH:
     return("[HIGH] " + full_description);
        
   case LOG_TYPE_SYSTEM:
     return("[SYSTEM] " + full_description);

   case LOG_TYPE_NETWORK:
     return("[NETWORK] " + full_description);
     
   default:
     return("[ERROR] logger failed to match log type");
  }
}
//--------------------------------------------------------------
Logger::log(const string full_description, LOG_TYPE type)
/*
switch must match order of LOG_TYPE enum (defined in Super\Enums.mqh)
*/
{ 
  string display_msg = display(full_description, type);
  
  //--- log to console
  Print(display_msg);
  
  //--- log to file
  int handle=FileOpen(p_log_file_path, FILE_WRITE|FILE_READ);
  if(handle>=0)
   {
    FileSeek(handle, 0, SEEK_END);
    FileWrite(handle, display_msg);
    FileClose(handle);
   } 
  else
   {
    Print("[SYSTEM] Could not open custom log file, " + p_log_file_path + ", e=" + (string)GetLastError());
   }
}

