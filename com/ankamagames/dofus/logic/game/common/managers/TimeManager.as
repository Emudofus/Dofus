package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.utils.*;

    public class TimeManager extends Object implements IDestroyable
    {
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
        public var timezoneOffset:Number = 0;
        public var dofusTimeYearLag:int = 0;
        private static var _self:TimeManager;

        public function TimeManager()
        {
            this._log = Log.getLogger(getQualifiedClassName(TimeManager));
            if (_self != null)
            {
                throw new SingletonError("TimeManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public function reset() : void
        {
            this.serverTimeLag = 0;
            this.dofusTimeYearLag = 0;
            this.timezoneOffset = 0;
            return;
        }// end function

        public function getTimestamp() : Number
        {
            var _loc_1:* = new Date();
            return _loc_1.getTime() + this.serverTimeLag;
        }// end function

        public function formatClock(param1:Number, param2:Boolean = false, param3:Boolean = false) : String
        {
            var _loc_4:* = param1;
            if (param2 && _loc_4 > 0)
            {
                _loc_4 = _loc_4 - this.serverTimeLag;
            }
            var _loc_5:* = this.getDateFromTime(_loc_4, param3);
            var _loc_6:* = this.getDateFromTime(_loc_4, param3)[1] >= 10 ? (_loc_5[1].toString()) : ("0" + _loc_5[1]);
            var _loc_7:* = _loc_5[0] >= 10 ? (_loc_5[0].toString()) : ("0" + _loc_5[0]);
            return _loc_6 + ":" + _loc_7;
        }// end function

        public function formatDateIRL(param1:Number, param2:Boolean = false) : String
        {
            var _loc_3:* = this.getDateFromTime(param1, param2);
            var _loc_4:* = _loc_3[2] > 9 ? (_loc_3[2].toString()) : ("0" + _loc_3[2]);
            var _loc_5:* = _loc_3[3] > 9 ? (_loc_3[3].toString()) : ("0" + _loc_3[3]);
            return I18n.getUiText("ui.time.dateNumbers", [_loc_4, _loc_5, _loc_3[4]]);
        }// end function

        public function formatDateIG(param1:Number) : String
        {
            var _loc_2:* = this.getDateFromTime(param1);
            var _loc_3:* = _loc_2[4] + this.dofusTimeYearLag;
            var _loc_4:* = Month.getMonthById((_loc_2[3] - 1)).name;
            return I18n.getUiText("ui.time.dateLetters", [_loc_2[2], _loc_4, _loc_3]);
        }// end function

        public function getDuration(param1:Number, param2:Boolean = false, param3:Boolean = false) : String
        {
            var _loc_4:String = null;
            var _loc_11:String = null;
            var _loc_12:String = null;
            var _loc_13:String = null;
            var _loc_14:Number = NaN;
            var _loc_15:String = null;
            var _loc_16:String = null;
            var _loc_17:String = null;
            if (!this._bTextInit)
            {
                this.initText();
            }
            var _loc_5:* = new Date(param1);
            if (param3)
            {
                _loc_14 = _loc_5.getUTCSeconds();
            }
            var _loc_6:* = _loc_5.getUTCMinutes();
            var _loc_7:* = _loc_5.getUTCHours();
            var _loc_8:* = _loc_5.getUTCDate() - 1;
            var _loc_9:* = _loc_5.getUTCMonth();
            var _loc_10:* = _loc_5.getUTCFullYear() - 1970;
            if (!param2)
            {
                if (param3)
                {
                    _loc_13 = _loc_14 > 1 ? (_loc_14 + " " + PatternDecoder.combine(this._nameSeconds, "f", false)) : (_loc_14 + " " + PatternDecoder.combine(this._nameSeconds, "f", true));
                }
                _loc_12 = _loc_6 > 1 ? (_loc_6 + " " + PatternDecoder.combine(this._nameMinutes, "f", false)) : (_loc_6 + " " + PatternDecoder.combine(this._nameMinutes, "f", true));
                _loc_11 = _loc_7 > 1 ? (_loc_7 + " " + PatternDecoder.combine(this._nameHours, "f", false)) : (_loc_7 + " " + PatternDecoder.combine(this._nameHours, "f", true));
                _loc_15 = _loc_8 > 1 ? (_loc_8 + " " + PatternDecoder.combine(this._nameDays, "f", false)) : (_loc_8 + " " + PatternDecoder.combine(this._nameDays, "f", true));
                _loc_16 = _loc_9 > 1 ? (_loc_9 + " " + PatternDecoder.combine(this._nameMonths, "f", false)) : (_loc_9 + " " + PatternDecoder.combine(this._nameMonths, "f", true));
                _loc_17 = _loc_10 > 1 ? (_loc_10 + " " + PatternDecoder.combine(this._nameYears, "f", false)) : (_loc_10 + " " + PatternDecoder.combine(this._nameYears, "f", true));
                if (_loc_10 == 0)
                {
                    if (_loc_9 == 0)
                    {
                        if (_loc_8 == 0)
                        {
                            if (_loc_7 == 0)
                            {
                                if (param3)
                                {
                                    if (_loc_6 == 0)
                                    {
                                        _loc_4 = _loc_13;
                                    }
                                    else
                                    {
                                        _loc_4 = _loc_12 + " " + this._nameAnd + " " + _loc_13;
                                    }
                                }
                                else
                                {
                                    _loc_4 = _loc_12;
                                }
                            }
                            else
                            {
                                _loc_4 = _loc_11 + " " + this._nameAnd + " " + _loc_12;
                            }
                        }
                        else
                        {
                            _loc_4 = _loc_15 + " " + this._nameAnd + " " + _loc_11;
                        }
                    }
                    else
                    {
                        _loc_4 = _loc_16 + " " + this._nameAnd + " " + _loc_15;
                    }
                }
                else
                {
                    _loc_4 = _loc_17 + " " + this._nameAnd + " " + _loc_16;
                }
                return _loc_4;
            }
            else
            {
                _loc_11 = _loc_7 >= 10 ? (_loc_7.toString()) : ("0" + _loc_7);
                _loc_12 = _loc_6 >= 10 ? (_loc_6.toString()) : ("0" + _loc_6);
                _loc_13 = _loc_14 >= 10 ? (_loc_14.toString()) : ("0" + _loc_14);
                return _loc_11 + ":" + _loc_12 + ":" + _loc_13;
            }
            ;
            return _loc_11 + ":" + _loc_12;
        }// end function

        public function getDateFromTime(param1:Number, param2:Boolean = false) : Array
        {
            var _loc_3:Date = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Date = null;
            if (param1 == 0)
            {
                _loc_9 = new Date();
                _loc_3 = new Date(_loc_9.getTime() + this.serverTimeLag);
            }
            else
            {
                _loc_3 = new Date(param1 + this.serverTimeLag);
            }
            if (param2)
            {
                _loc_4 = _loc_3.getDate();
                _loc_5 = _loc_3.getMonth() + 1;
                _loc_6 = _loc_3.getFullYear();
                _loc_7 = _loc_3.getHours();
                _loc_8 = _loc_3.getMinutes();
            }
            else
            {
                _loc_4 = _loc_3.getUTCDate();
                _loc_5 = _loc_3.getUTCMonth() + 1;
                _loc_6 = _loc_3.getUTCFullYear();
                _loc_7 = _loc_3.getUTCHours();
                _loc_8 = _loc_3.getUTCMinutes();
            }
            return [_loc_8, _loc_7, _loc_4, _loc_5, _loc_6];
        }// end function

        private function initText() : void
        {
            this._nameYears = I18n.getUiText("ui.time.years");
            this._nameMonths = I18n.getUiText("ui.time.months");
            this._nameDays = I18n.getUiText("ui.time.days");
            this._nameHours = I18n.getUiText("ui.time.hours");
            this._nameMinutes = I18n.getUiText("ui.time.minutes");
            this._nameSeconds = I18n.getUiText("ui.time.seconds");
            this._nameAnd = I18n.getUiText("ui.common.and").toLowerCase();
            this._bTextInit = true;
            return;
        }// end function

        public static function getInstance() : TimeManager
        {
            if (_self == null)
            {
                _self = new TimeManager;
            }
            return _self;
        }// end function

    }
}
