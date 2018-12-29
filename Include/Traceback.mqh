//+------------------------------------------------------------------+
//|                                                    Traceback.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#define __INFO__    "File " + __FILE__ + ", line " + (string)__LINE__ + ", in " + __FUNCTION__ + " -> "
#define __DESC__    
#define __LOG__ __FILE__, __FUNCTION__, __LINE__

#ifndef LOGGER_DEPRECATED
   #define __TRACE__ TRACEBACK Traceback traceback(__LOG__);
   #define BEGIN __TRACE__
   #define UPDATE_TRACEBACK traceback._LINE = __LINE__;
   #define __ UPDATE_TRACEBACK
   #define TRACEBACK_DESCRIPTION(display_func) UPDATE_TRACEBACK display_func(traceback.description())
#else
   #define __TRACE__
   #define __
   #define FUNCTION
   #define BEGIN
#endif 

#ifndef ARRAYSTRING
#define ARRAYSTRING
   #include <Arrays/ArrayString.mqh>
#endif 
   
class Traceback
{
protected:
 static int counter;
 static Traceback* last;
 static Traceback* first;
 Traceback* prev;
 
public:
 string _FILE;
 string _FUNCTION;
 int _LINE;
 string description();
 Traceback(string file, string function, int line);
 ~Traceback();
};

Traceback* Traceback::first = NULL;
Traceback* Traceback::last = NULL;

static int Traceback::counter = 0;

Traceback::~Traceback()
{
 last = prev;
 counter--;
}

Traceback::Traceback(string file,string function,int line)
 : _FILE(file), _FUNCTION(function), _LINE(line)
 { 
  if(counter==0)
   first = GetPointer(this);
  
  prev = last;
  
  last = GetPointer(this); 

  counter++;
 }
 
 
string Traceback::description()
{
 Traceback* tr = last;
 CArrayString msg;
 string desc = NULL;
 
 do
 {
  msg.Add(tr._FUNCTION + " (" + tr._FILE + "," + " " + (string)tr._LINE + ")");
  
  tr = tr.prev;
 } 
 while(tr != NULL);
 
 int total = msg.Total();
 
 for(int i=0; i<total; i++)
  desc += " <- " + msg[i];
 
 return desc;
}
