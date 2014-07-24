package com.ankamagames.arena.dofusmodule.event
{
   import flash.events.Event;
   
   public class SSODofusEvent extends Event
   {
      
      public function SSODofusEvent(type:String, nick:String, token:String, gameId:int) {
         super(type,false,false);
         this._nick = nick;
         this._token = token;
         this._gameId = gameId;
      }
      
      public function get gameId() : int {
         return this._gameId;
      }
      
      public function get token() : String {
         return this._token;
      }
      
      public function get nick() : String {
         return this._nick;
      }
      
      override public function clone() : Event {
         return new SSODofusEvent(type,this._nick,this._token,this._gameId);
      }
      
      private var _nick:String = "";
      
      private var _token:String = "";
      
      private var _gameId:int = 0;
   }
}
