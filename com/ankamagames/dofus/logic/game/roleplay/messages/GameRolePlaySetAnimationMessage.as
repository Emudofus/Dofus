package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   
   public class GameRolePlaySetAnimationMessage extends Object implements Message
   {
      
      public function GameRolePlaySetAnimationMessage(param1:GameContextActorInformations, param2:String, param3:uint=0, param4:Boolean=true, param5:Boolean=true, param6:Boolean=false) {
         super();
         this._informations = param1;
         this._animation = param2;
         this._duration = param3;
         this._instant = param4;
         this._directions8 = param5;
         this._playStaticOnly = param6;
      }
      
      private var _informations:GameContextActorInformations;
      
      private var _animation:String;
      
      private var _duration:uint;
      
      private var _instant:Boolean;
      
      private var _directions8:Boolean;
      
      private var _playStaticOnly:Boolean;
      
      public function get informations() : GameContextActorInformations {
         return this._informations;
      }
      
      public function get animation() : String {
         return this._animation;
      }
      
      public function get duration() : uint {
         return this._duration;
      }
      
      public function get instant() : Boolean {
         return this._instant;
      }
      
      public function get directions8() : Boolean {
         return this._directions8;
      }
      
      public function get playStaticOnly() : Boolean {
         return this._playStaticOnly;
      }
   }
}
