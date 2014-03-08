package com.ankamagames.dofus.misc.utils
{
   public class DateFormat extends Object
   {
      
      public function DateFormat() {
         super();
      }
      
      public static var MONTHS:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
      
      public static var DAYS:Array = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
      
      public static function formatDate(formatStyle:String, date:Date) : String {
         var leadZero:Function = function(num:int):String
         {
            return num < 10?"0" + String(num):String(num);
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
      
      public static function dayOfYear(year:uint, month:uint, day:uint) : uint {
         if(month == 0)
         {
            return day - 1;
         }
         var isLeapYear:Boolean = leapYear(year);
         var total:uint = 0;
         var i:uint = 0;
         while(i < month)
         {
            total = total + DateFormat.numberOfDaysInMonth(i,isLeapYear);
            i++;
         }
         return total + day - 1;
      }
      
      public static function leapYear(year:uint) : Boolean {
         return (year % 4 == 0) && (!(year % 100 == 0)) || (year % 100 == 0);
      }
      
      public static function numberOfDaysInMonth(month:uint, isLeapYear:Boolean=false) : uint {
         if(month == 1)
         {
            return isLeapYear?29:28;
         }
         if((month <= 6) && ((month & 1) == 1))
         {
            return 30;
         }
         if((month > 6) && ((month & 1) == 0))
         {
            return 30;
         }
         return 31;
      }
   }
}
