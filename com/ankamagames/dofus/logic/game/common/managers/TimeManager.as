package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.misc.Month;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class TimeManager extends Object implements IDestroyable
   {
      
      public function TimeManager() {
         this._log = Log.getLogger(getQualifiedClassName(TimeManager));
         super();
         if(_self != null)
         {
            throw new SingletonError("TimeManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _self:TimeManager;
      
      public static function getInstance() : TimeManager {
         if(_self == null)
         {
            _self = new TimeManager();
         }
         return _self;
      }
      
      protected var _log:Logger;
      
      private var _bTextInit:Boolean = false;
      
      private var _nameYears:String;
      
      private var _nameMonths:String;
      
      private var _nameDays:String;
      
      private var _nameHours:String;
      
      private var _nameMinutes:String;
      
      private var _nameSeconds:String;
      
      private var _nameAnd:String;
      
      public var serverTimeLag:Number = 0;
      
      public var serverUtcTimeLag:Number = 0;
      
      public var timezoneOffset:Number = 0;
      
      public var dofusTimeYearLag:int = 0;
      
      public function destroy() : void {
         _self = null;
      }
      
      public function reset() : void {
         this.serverTimeLag = 0;
         this.dofusTimeYearLag = 0;
         this.timezoneOffset = 0;
      }
      
      public function getTimestamp() : Number {
         var date:Date = new Date();
         return date.getTime() + this.serverTimeLag;
      }
      
      public function getUtcTimestamp() : Number {
         var date:Date = new Date();
         return date.getTime() + this.serverUtcTimeLag;
      }
      
      public function formatClock(time:Number, unchanged:Boolean=false, useTimezoneOffset:Boolean=false) : String {
         var timeToUse:Number = time;
         if((unchanged) && (timeToUse > 0))
         {
            timeToUse = timeToUse - this.serverTimeLag;
         }
         var date:Array = this.getDateFromTime(timeToUse,useTimezoneOffset);
         var hour:String = date[1] >= 10?date[1].toString():"0" + date[1];
         var minute:String = date[0] >= 10?date[0].toString():"0" + date[0];
         return hour + ":" + minute;
      }
      
      public function formatDateIRL(time:Number, useTimezoneOffset:Boolean=false) : String {
         var date:Array = this.getDateFromTime(time,useTimezoneOffset);
         var day:String = date[2] > 9?date[2].toString():"0" + date[2];
         var month:String = date[3] > 9?date[3].toString():"0" + date[3];
         return I18n.getUiText("ui.time.dateNumbers",[day,month,date[4]]);
      }
      
      public function formatDateIG(time:Number) : String {
         var date:Array = this.getDateFromTime(time);
         var nyear:Number = date[4] + this.dofusTimeYearLag;
         var month:String = Month.getMonthById(date[3] - 1).name;
         return I18n.getUiText("ui.time.dateLetters",[date[2],month,nyear]);
      }
      
      public function getDateIG(time:Number) : Array {
         var date:Array = this.getDateFromTime(time);
         var nyear:Number = date[4] + this.dofusTimeYearLag;
         var month:String = Month.getMonthById(date[3] - 1).name;
         return [date[2],month,nyear];
      }
      
      public function getDuration(time:Number, short:Boolean=false, addSeconds:Boolean=false) : String {
         var result:String = null;
         var hour:String = null;
         var minute:String = null;
         var second:String = null;
         var nsecond:* = NaN;
         var day:String = null;
         var month:String = null;
         var year:String = null;
         if(!this._bTextInit)
         {
            this.initText();
         }
         var date:Date = new Date(time);
         if(addSeconds)
         {
            nsecond = date.getUTCSeconds();
         }
         var nminute:Number = date.getUTCMinutes();
         var nhour:Number = date.getUTCHours();
         var nday:Number = date.getUTCDate() - 1;
         var nmonth:Number = date.getUTCMonth();
         var nyear:Number = date.getUTCFullYear() - 1970;
         if(!short)
         {
            if(addSeconds)
            {
               second = nsecond > 1?nsecond + " " + PatternDecoder.combine(this._nameSeconds,"f",false):nsecond + " " + PatternDecoder.combine(this._nameSeconds,"f",true);
            }
            minute = nminute > 1?nminute + " " + PatternDecoder.combine(this._nameMinutes,"f",false):nminute + " " + PatternDecoder.combine(this._nameMinutes,"f",true);
            hour = nhour > 1?nhour + " " + PatternDecoder.combine(this._nameHours,"f",false):nhour + " " + PatternDecoder.combine(this._nameHours,"f",true);
            day = nday > 1?nday + " " + PatternDecoder.combine(this._nameDays,"f",false):nday + " " + PatternDecoder.combine(this._nameDays,"f",true);
            month = nmonth > 1?nmonth + " " + PatternDecoder.combine(this._nameMonths,"f",false):nmonth + " " + PatternDecoder.combine(this._nameMonths,"f",true);
            year = nyear > 1?nyear + " " + PatternDecoder.combine(this._nameYears,"f",false):nyear + " " + PatternDecoder.combine(this._nameYears,"f",true);
            if(nyear == 0)
            {
               if(nmonth == 0)
               {
                  if(nday == 0)
                  {
                     if(nhour == 0)
                     {
                        if(addSeconds)
                        {
                           if(nminute == 0)
                           {
                              result = second;
                           }
                           else
                           {
                              result = minute + " " + this._nameAnd + " " + second;
                           }
                        }
                        else
                        {
                           result = minute;
                        }
                     }
                     else
                     {
                        result = hour + " " + this._nameAnd + " " + minute;
                     }
                  }
                  else
                  {
                     result = day + " " + this._nameAnd + " " + hour;
                  }
               }
               else
               {
                  result = month + " " + this._nameAnd + " " + day;
               }
            }
            else
            {
               result = year + " " + this._nameAnd + " " + month;
            }
            return result;
         }
         hour = nhour >= 10?nhour.toString():"0" + nhour;
         minute = nminute >= 10?nminute.toString():"0" + nminute;
         if(addSeconds)
         {
            second = nsecond >= 10?nsecond.toString():"0" + nsecond;
            return hour + ":" + minute + ":" + second;
         }
         return hour + ":" + minute;
      }
      
      public function getDateFromTime(timeUTC:Number, useTimezoneOffset:Boolean=false) : Array {
         var date:Date = null;
         var nday:* = NaN;
         var nmonth:* = NaN;
         var nyear:* = NaN;
         var nhour:* = NaN;
         var nminute:* = NaN;
         var date0:Date = null;
         if(timeUTC == 0)
         {
            date0 = new Date();
            date = new Date(date0.getTime() + this.serverTimeLag);
         }
         else
         {
            date = new Date(timeUTC + this.serverTimeLag);
         }
         if(useTimezoneOffset)
         {
            nday = date.getDate();
            nmonth = date.getMonth() + 1;
            nyear = date.getFullYear();
            nhour = date.getHours();
            nminute = date.getMinutes();
         }
         else
         {
            nday = date.getUTCDate();
            nmonth = date.getUTCMonth() + 1;
            nyear = date.getUTCFullYear();
            nhour = date.getUTCHours();
            nminute = date.getUTCMinutes();
         }
         return [nminute,nhour,nday,nmonth,nyear];
      }
      
      private function initText() : void {
         this._nameYears = I18n.getUiText("ui.time.years");
         this._nameMonths = I18n.getUiText("ui.time.months");
         this._nameDays = I18n.getUiText("ui.time.days");
         this._nameHours = I18n.getUiText("ui.time.hours");
         this._nameMinutes = I18n.getUiText("ui.time.minutes");
         this._nameSeconds = I18n.getUiText("ui.time.seconds");
         this._nameAnd = I18n.getUiText("ui.common.and").toLowerCase();
         this._bTextInit = true;
      }
   }
}
