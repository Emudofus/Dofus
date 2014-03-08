package com.ankamagames.dofus.misc.utils
{
   public class DateFormat extends Object
   {
      
      public function DateFormat() {
         super();
      }
      
      public static var MONTHS:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
      
      public static var DAYS:Array = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
      
      public static function formatDate(param1:String, param2:Date) : String {
         var formatStyle:String = param1;
         var date:Date = param2;
         var leadZero:Function = function(param1:int):String
         {
            return param1 < 10?"0" + String(param1):String(param1);
         };
         var dateFormated:String = formatStyle;
         dateFormated = dateFormated.replace(new RegExp("d","g"),leadZero(date.date));
         dateFormated = dateFormated.replace(new RegExp("j","g"),String(date.date));
         dateFormated = dateFormated.replace(new RegExp("w","g"),String(date.day));
         if(dateFormated.search("z") != -1)
         {
            dateFormated = dateFormated.replace(new RegExp("z","g"),String(DateFormat.dayOfYear(date.fullYear,date.month,date.date)));
         }
         dateFormated = dateFormated.replace(new RegExp("m","g"),leadZero(date.month + 1));
         dateFormated = dateFormated.replace(new RegExp("n","g"),String(date.month + 1));
         if(dateFormated.search("t") != -1)
         {
            dateFormated = dateFormated.replace(new RegExp("t","g"),String(DateFormat.numberOfDaysInMonth(date.month,DateFormat.leapYear(date.fullYear))));
         }
         dateFormated = dateFormated.replace(new RegExp("L","g"),DateFormat.leapYear(date.fullYear)?"1":"0");
         dateFormated = dateFormated.replace(new RegExp("Y","g"),String(date.fullYear));
         dateFormated = dateFormated.replace(new RegExp("y","g"),String(date.fullYear).substr(2));
         dateFormated = dateFormated.replace(new RegExp("g","g"),date.hours <= 12?date.hours:date.hours - 12);
         dateFormated = dateFormated.replace(new RegExp("G","g"),date.hours);
         dateFormated = dateFormated.replace(new RegExp("h","g"),leadZero(date.hours <= 12?date.hours:date.hours - 12));
         dateFormated = dateFormated.replace(new RegExp("H","g"),leadZero(date.hours));
         dateFormated = dateFormated.replace(new RegExp("i","g"),leadZero(date.minutes));
         dateFormated = dateFormated.replace(new RegExp("s","g"),leadZero(date.seconds));
         dateFormated = dateFormated.replace(new RegExp("u","g"),leadZero(date.milliseconds));
         dateFormated = dateFormated.replace(new RegExp("U","g"),String(date.time));
         dateFormated = dateFormated.replace(new RegExp("a","g"),"[{(a)}]");
         dateFormated = dateFormated.replace(new RegExp("A","g"),"[{(A)}]");
         dateFormated = dateFormated.replace(new RegExp("D","g"),"[{(D)}]");
         dateFormated = dateFormated.replace(new RegExp("l","g"),"[{(l)}]");
         dateFormated = dateFormated.replace(new RegExp("M","g"),"[{(M)}]");
         dateFormated = dateFormated.replace(new RegExp("F","g"),"[{(F)}]");
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(a\\)\\}\\]","g"),date.hours < 12?"am":"pm");
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(A\\)\\}\\]","g"),date.hours < 12?"AM":"PM");
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(D\\)\\}\\]","g"),String(DateFormat.DAYS[date.day]).substr(0,3));
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(l\\)\\}\\]","g"),DateFormat.DAYS[date.day]);
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(M\\)\\}\\]","g"),String(DateFormat.MONTHS[date.month]).substr(0,3));
         dateFormated = dateFormated.replace(new RegExp("\\[\\{\\(F\\)\\}\\]","g"),DateFormat.MONTHS[date.month]);
         return dateFormated;
      }
      
      public static function dayOfYear(param1:uint, param2:uint, param3:uint) : uint {
         if(param2 == 0)
         {
            return param3-1;
         }
         var _loc4_:Boolean = leapYear(param1);
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < param2)
         {
            _loc5_ = _loc5_ + DateFormat.numberOfDaysInMonth(_loc6_,_loc4_);
            _loc6_++;
         }
         return _loc5_ + param3-1;
      }
      
      public static function leapYear(param1:uint) : Boolean {
         return param1 % 4 == 0 && !(param1 % 100 == 0) || param1 % 100 == 0;
      }
      
      public static function numberOfDaysInMonth(param1:uint, param2:Boolean=false) : uint {
         if(param1 == 1)
         {
            return param2?29:28;
         }
         if(param1 <= 6 && (param1 & 1) == 1)
         {
            return 30;
         }
         if(param1 > 6 && (param1 & 1) == 0)
         {
            return 30;
         }
         return 31;
      }
   }
}
