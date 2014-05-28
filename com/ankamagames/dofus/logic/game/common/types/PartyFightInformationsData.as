package com.ankamagames.dofus.logic.game.common.types
{
   import flash.utils.Timer;
   
   public class PartyFightInformationsData extends Object
   {
      
      public function PartyFightInformationsData(fightMapId:int, fightId:int, memberName:String, memberId:int, timeBeforeStart:uint) {
         super();
         this._fightMapId = fightMapId;
         this._fightId = fightId;
         this._memberName = memberName;
         this._timeBeforeStart = timeBeforeStart;
         this._timeUntilFightbegin = new Timer(this._timeBeforeStart,1);
         this._memberId = memberId;
         var currentDate:Date = new Date();
         this._fightStartDate = currentDate.getTime() + this._timeBeforeStart as Number;
      }
      
      private var _fightMapId:int;
      
      private var _fightId:int;
      
      private var _timeUntilFightbegin:Timer;
      
      private var _memberName:String;
      
      private var _memberId:int;
      
      private var _timeBeforeStart:uint;
      
      private var _fightStartDate:Number;
      
      public function get fightMapId() : int {
         return this._fightMapId;
      }
      
      public function set fightMapId(value:int) : void {
         this._fightMapId = value;
      }
      
      public function get fightId() : int {
         return this._fightId;
      }
      
      public function set fightId(value:int) : void {
         this._fightId = value;
      }
      
      public function get timeUntilFightbegin() : Timer {
         return this._timeUntilFightbegin;
      }
      
      public function set timeUntilFightbegin(value:Timer) : void {
         this._timeUntilFightbegin = value;
      }
      
      public function get memberName() : String {
         return this._memberName;
      }
      
      public function set memberName(value:String) : void {
         this._memberName = value;
      }
      
      public function get timeBeforeStart() : uint {
         return this._timeBeforeStart;
      }
      
      public function set timeBeforeStart(value:uint) : void {
         this._timeBeforeStart = value;
      }
      
      public function get fightStartDate() : uint {
         return this._fightStartDate;
      }
      
      public function get memberId() : int {
         return this._memberId;
      }
   }
}
