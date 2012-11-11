package com.ankamagames.dofus.misc.utils
{

    public class DateFormat extends Object
    {
        public static var MONTHS:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        public static var DAYS:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

        public function DateFormat()
        {
            return;
        }// end function

        public static function formatDate(param1:String, param2:Date) : String
        {
            var formatStyle:* = param1;
            var date:* = param2;
            var leadZero:* = function (param1:int) : String
            {
                return param1 < 10 ? ("0" + String(param1)) : (String(param1));
            }// end function
            ;
            var dateFormated:* = formatStyle;
            dateFormated = dateFormated.replace(/d""d/g, DateFormat.leadZero(date.date));
            dateFormated = dateFormated.replace(/j""j/g, String(date.date));
            dateFormated = dateFormated.replace(/w""w/g, String(date.day));
            if (dateFormated.search("z") != -1)
            {
                dateFormated = dateFormated.replace(/z""z/g, String(DateFormat.dayOfYear(date.fullYear, date.month, date.date)));
            }
            dateFormated = dateFormated.replace(/m""m/g, DateFormat.leadZero((date.month + 1)));
            dateFormated = dateFormated.replace(/n""n/g, String((date.month + 1)));
            if (dateFormated.search("t") != -1)
            {
                dateFormated = dateFormated.replace(/t""t/g, String(DateFormat.numberOfDaysInMonth(date.month, DateFormat.leapYear(date.fullYear))));
            }
            dateFormated = dateFormated.replace(/L""L/g, DateFormat.leapYear(date.fullYear) ? ("1") : ("0"));
            dateFormated = dateFormated.replace(/Y""Y/g, String(date.fullYear));
            dateFormated = dateFormated.replace(/y""y/g, String(date.fullYear).substr(2));
            dateFormated = dateFormated.replace(/g""g/g, date.hours <= 12 ? (date.hours) : (date.hours - 12));
            dateFormated = dateFormated.replace(/G""G/g, date.hours);
            dateFormated = dateFormated.replace(/h""h/g, DateFormat.leadZero(date.hours <= 12 ? (date.hours) : (date.hours - 12)));
            dateFormated = dateFormated.replace(/H""H/g, DateFormat.leadZero(date.hours));
            dateFormated = dateFormated.replace(/i""i/g, DateFormat.leadZero(date.minutes));
            dateFormated = dateFormated.replace(/s""s/g, DateFormat.leadZero(date.seconds));
            dateFormated = dateFormated.replace(/u""u/g, DateFormat.leadZero(date.milliseconds));
            dateFormated = dateFormated.replace(/U""U/g, String(date.time));
            dateFormated = dateFormated.replace(/a""a/g, "[{(a)}]");
            dateFormated = dateFormated.replace(/A""A/g, "[{(A)}]");
            dateFormated = dateFormated.replace(/D""D/g, "[{(D)}]");
            dateFormated = dateFormated.replace(/l""l/g, "[{(l)}]");
            dateFormated = dateFormated.replace(/M""M/g, "[{(M)}]");
            dateFormated = dateFormated.replace(/F""F/g, "[{(F)}]");
            dateFormated = dateFormated.replace(/\[\{\(a\)\}\]""\[\{\(a\)\}\]/g, date.hours < 12 ? ("am") : ("pm"));
            dateFormated = dateFormated.replace(/\[\{\(A\)\}\]""\[\{\(A\)\}\]/g, date.hours < 12 ? ("AM") : ("PM"));
            dateFormated = dateFormated.replace(/\[\{\(D\)\}\]""\[\{\(D\)\}\]/g, String(DateFormat.DAYS[date.day]).substr(0, 3));
            dateFormated = dateFormated.replace(/\[\{\(l\)\}\]""\[\{\(l\)\}\]/g, DateFormat.DAYS[date.day]);
            dateFormated = dateFormated.replace(/\[\{\(M\)\}\]""\[\{\(M\)\}\]/g, String(DateFormat.MONTHS[date.month]).substr(0, 3));
            dateFormated = dateFormated.replace(/\[\{\(F\)\}\]""\[\{\(F\)\}\]/g, DateFormat.MONTHS[date.month]);
            return dateFormated;
        }// end function

        public static function dayOfYear(param1:uint, param2:uint, param3:uint) : uint
        {
            if (param2 == 0)
            {
                return (param3 - 1);
            }
            var _loc_4:* = leapYear(param1);
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < param2)
            {
                
                _loc_5 = _loc_5 + DateFormat.numberOfDaysInMonth(_loc_6, _loc_4);
                _loc_6 = _loc_6 + 1;
            }
            return _loc_5 + param3 - 1;
        }// end function

        public static function leapYear(param1:uint) : Boolean
        {
            return param1 % 4 == 0 && param1 % 100 != 0 || param1 % 100 == 0;
        }// end function

        public static function numberOfDaysInMonth(param1:uint, param2:Boolean = false) : uint
        {
            if (param1 == 1)
            {
                return param2 ? (29) : (28);
            }
            else
            {
                if (param1 <= 6 && (param1 & 1) == 1)
                {
                    return 30;
                }
                if (param1 > 6 && (param1 & 1) == 0)
                {
                    return 30;
                }
            }
            return 31;
        }// end function

    }
}
