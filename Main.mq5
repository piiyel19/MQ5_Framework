
#include <Trade\Trade.mqh>

CTrade Trade;
input int shift=0;

#include "File_Macd.mq5";
#include "File_Rsi.mq5";
#include "File_Ema50.mq5";
#include "File_Ema8_14_Cross.mq5";

void OnTick()
{
   datetime time  = iTime(Symbol(),Period(),shift);
   double   open  = iOpen(Symbol(),Period(),shift);
   double   high  = iHigh(Symbol(),Period(),shift);
   double   low   = iLow(Symbol(),Period(),shift);
   double   close = iClose(NULL,PERIOD_CURRENT,shift);
   long     volume= iVolume(Symbol(),0,shift);
   int      bars  = iBars(NULL,0);
   
   
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   
   double macd_signal = macd_signal();
   double rsi_signal = rsi_signal();
   double ema50_signal = ema50_signal();
   double ema8_14_signal = ema8_14_signal();
   /*
   if(macd_signal=="Buy")
   {
      ObjectCreate(_Symbol,"Macd Buy",OBJ_ARROW_BUY,0,TimeCurrent(),Ask);
   }
   
   if(macd_signal=="Sell")
   {
      ObjectCreate(_Symbol,"Macd Sell",OBJ_ARROW_SELL,0,TimeCurrent(),Bid);
   }
   */
   
   double macd_check = NormalizeDouble(macd_signal,2);
   if(macd_check>0)
   {
      ObjectCreate(0,"MACD",OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetString(0,"MACD",OBJPROP_TEXT,"MACD > 0 ("+NormalizeDouble(macd_signal,2)+")");
      ObjectSetInteger(0,"MACD",OBJPROP_XDISTANCE,400);
      ObjectSetInteger(0,"MACD",OBJPROP_YDISTANCE,20);
      ObjectSetInteger(0,"MACD",OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,"MACD",OBJPROP_COLOR,clrAliceBlue);
      
      
      //Print("Positif : ",NormalizeDouble(macd_signal,2));
      if(rsi_signal>50)
      {
         //Print("Positif : ",rsi_signal);
         ObjectCreate(0,"RSI",OBJ_LABEL,0,0,0,0,0,0,0);
         ObjectSetString(0,"RSI",OBJPROP_TEXT,"RSI Signal : More > 50 ("+NormalizeDouble(rsi_signal,2)+")");
         ObjectSetInteger(0,"RSI",OBJPROP_XDISTANCE,400);
         ObjectSetInteger(0,"RSI",OBJPROP_YDISTANCE,50);
         ObjectSetInteger(0,"RSI",OBJPROP_CORNER,CORNER_LEFT_UPPER);
         ObjectSetInteger(0,"RSI",OBJPROP_COLOR,clrAliceBlue);
         
         
         
         if(close>ema50_signal)
         {
            
            
            //Print("Buy :" ,close," vs ",ema50_signal);
            if(ema50_signal!=0)
            {
               
               ObjectCreate(0,"CLOSE CONDITION",OBJ_LABEL,0,0,0,0,0,0,0);
               ObjectSetString(0,"CLOSE CONDITION",OBJPROP_TEXT,"Close Up Price Ema50 : ("+NormalizeDouble(close,2)+")");
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_XDISTANCE,400);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_YDISTANCE,80);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_CORNER,CORNER_LEFT_UPPER);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_COLOR,clrAliceBlue);
               
               
               //Print("Positif :" ,ema8_14_signal);
               if(ema8_14_signal!=0)
               {
                  ObjectCreate(0,"EMA814",OBJ_LABEL,0,0,0,0,0,0,0);
                  ObjectSetString(0,"EMA814",OBJPROP_TEXT,"Cross Down Ema 8 14 : ("+NormalizeDouble(ema8_14_signal,2)+")");
                  ObjectSetInteger(0,"EMA814",OBJPROP_XDISTANCE,400);
                  ObjectSetInteger(0,"EMA814",OBJPROP_YDISTANCE,120);
                  ObjectSetInteger(0,"EMA814",OBJPROP_CORNER,CORNER_LEFT_UPPER);
                  ObjectSetInteger(0,"EMA814",OBJPROP_COLOR,clrAliceBlue);
                  
                  if(NormalizeDouble(macd_check,0)>0){
                    //Trade.Buy(0.01, NULL, Ask, (Ask-400 * _Point), (Ask+200 * _Point), NULL );
                  }
                  
                  Print("Positif :" ,ema8_14_signal);
               }
               
               
               
            }
            
            ObjectCreate(0,"Trend",OBJ_LABEL,0,0,0,0,0,0,0);
            ObjectSetString(0,"Trend",OBJPROP_TEXT,"Price Trend : Up (Buy)");
            ObjectSetInteger(0,"Trend",OBJPROP_XDISTANCE,400);
            ObjectSetInteger(0,"Trend",OBJPROP_YDISTANCE,150);
            ObjectSetInteger(0,"Trend",OBJPROP_CORNER,CORNER_LEFT_UPPER);
            ObjectSetInteger(0,"Trend",OBJPROP_COLOR,clrAliceBlue);
         }
         
         /*
         if(close<ema50_signal)
         {
            //Print("Sell :" ,close," vs ",ema50_signal);
            if(ema50_signal!=0)
            {
               if(ema8_14_signal!=0)
               {
                  Print("Negatif :" ,ema8_14_signal);
               }
               
            }
         }
         */
      }
   }
   
   if(macd_check<0)
   {
   
      ObjectCreate(0,"MACD",OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetString(0,"MACD",OBJPROP_TEXT,"MACD < 0 ("+NormalizeDouble(macd_signal,2)+")");
      ObjectSetInteger(0,"MACD",OBJPROP_XDISTANCE,400);
      ObjectSetInteger(0,"MACD",OBJPROP_YDISTANCE,20);
      ObjectSetInteger(0,"MACD",OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,"MACD",OBJPROP_COLOR,clrAliceBlue);
      
      
      //Print("Negatif : ",NormalizeDouble(macd_signal,2));
      //Print("Negatif : ",rsi_signal);
      if(rsi_signal<50)
      {
         ObjectCreate(0,"RSI",OBJ_LABEL,0,0,0,0,0,0,0);
         ObjectSetString(0,"RSI",OBJPROP_TEXT,"RSI Signal : Less < 50 ("+NormalizeDouble(rsi_signal,2)+")");
         ObjectSetInteger(0,"RSI",OBJPROP_XDISTANCE,400);
         ObjectSetInteger(0,"RSI",OBJPROP_YDISTANCE,50);
         ObjectSetInteger(0,"RSI",OBJPROP_CORNER,CORNER_LEFT_UPPER);
         ObjectSetInteger(0,"RSI",OBJPROP_COLOR,clrAliceBlue);
      
         /*
         if(close>ema50_signal)
         {
            //Print("Buy :" ,close," vs ",ema50_signal);
            if(ema50_signal!=0)
            {
               //Print("Positif :" ,ema8_14_signal);
               if(ema8_14_signal!=0)
               {
                  Print("Positif :" ,ema8_14_signal);
               }
            }
         }
         */
         
         if(close>ema50_signal)
         {
            
            
            //Print("Negatif :" ,close," vs ",ema50_signal);
            if(ema50_signal!=0)
            {
               
               ObjectCreate(0,"CLOSE CONDITION",OBJ_LABEL,0,0,0,0,0,0,0);
               ObjectSetString(0,"CLOSE CONDITION",OBJPROP_TEXT,"Close Down Price Ema50 : ("+NormalizeDouble(close,2)+")");
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_XDISTANCE,400);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_YDISTANCE,80);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_CORNER,CORNER_LEFT_UPPER);
               ObjectSetInteger(0,"CLOSE CONDITION",OBJPROP_COLOR,clrAliceBlue);
            
               //Print("Negatif :" ,ema8_14_signal);
               if(ema8_14_signal!=0)
               {
                  ObjectCreate(0,"EMA814",OBJ_LABEL,0,0,0,0,0,0,0);
                  ObjectSetString(0,"EMA814",OBJPROP_TEXT,"Cross EMA 8 14 : ("+NormalizeDouble(ema8_14_signal,2)+")");
                  ObjectSetInteger(0,"EMA814",OBJPROP_XDISTANCE,400);
                  ObjectSetInteger(0,"EMA814",OBJPROP_YDISTANCE,120);
                  ObjectSetInteger(0,"EMA814",OBJPROP_CORNER,CORNER_LEFT_UPPER);
                  ObjectSetInteger(0,"EMA814",OBJPROP_COLOR,clrAliceBlue);
                  
                  
                  if((NormalizeDouble(macd_check,0)<0) && (PositionsTotal() < 1)) {
                     //Trade.Buy(0.10, NULL, Ask, (Ask-200 * _Point), (Ask+150 * _Point), NULL );
                  }
                  
               
                  Print("Negatif :" ,ema8_14_signal);
               }
               
               
               
            }
            
            
            ObjectCreate(0,"Trend",OBJ_LABEL,0,0,0,0,0,0,0);
            ObjectSetString(0,"Trend",OBJPROP_TEXT,"Price Trend : Down(Sell)");
            ObjectSetInteger(0,"Trend",OBJPROP_XDISTANCE,400);
            ObjectSetInteger(0,"Trend",OBJPROP_YDISTANCE,150);
            ObjectSetInteger(0,"Trend",OBJPROP_CORNER,CORNER_LEFT_UPPER);
            ObjectSetInteger(0,"Trend",OBJPROP_COLOR,clrAliceBlue);
         }
       }
   }
   
   //Print("OK");
   
   
}
