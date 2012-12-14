package com.ankamagames.dofus.logic.game.common.types
{
    import flash.utils.*;

    public class PartyFightInformationsData extends Object
    {
        private var _fightMapId:int;
        private var _fightId:int;
        private var _timeUntilFightbegin:Timer;
        private var _memberName:String;
        private var _memberId:int;
        private var _timeBeforeStart:uint;
        private var _fightStartDate:Number;

        public function PartyFightInformationsData(param1:int, param2:int, param3:String, param4:int, param5:uint)
        {
            this._fightMapId = param1;
            this._fightId = param2;
            this._memberName = param3;
            this._timeBeforeStart = param5;
            this._timeUntilFightbegin = new Timer(this._timeBeforeStart, 1);
            this._memberId = param4;
            var _loc_6:* = new Date();
            this._fightStartDate = _loc_6.getTime() + this._timeBeforeStart as Number;
            return;
        }// end function

        public function get fightMapId() : int
        {
            return this._fightMapId;
        }// end function

        public function set fightMapId(param1:int) : void
        {
            this._fightMapId = param1;
            return;
        }// end function

        public function get fightId() : int
        {
            return this._fightId;
        }// end function

        public function set fightId(param1:int) : void
        {
            this._fightId = param1;
            return;
        }// end function

        public function get timeUntilFightbegin() : Timer
        {
            return this._timeUntilFightbegin;
        }// end function

        public function set timeUntilFightbegin(param1:Timer) : void
        {
            this._timeUntilFightbegin = param1;
            return;
        }// end function

        public function get memberName() : String
        {
            return this._memberName;
        }// end function

        public function set memberName(param1:String) : void
        {
            this._memberName = param1;
            return;
        }// end function

        public function get timeBeforeStart() : uint
        {
            return this._timeBeforeStart;
        }// end function

        public function set timeBeforeStart(param1:uint) : void
        {
            this._timeBeforeStart = param1;
            return;
        }// end function

        public function get fightStartDate() : uint
        {
            return this._fightStartDate;
        }// end function

        public function get memberId() : int
        {
            return this._memberId;
        }// end function

    }
}
