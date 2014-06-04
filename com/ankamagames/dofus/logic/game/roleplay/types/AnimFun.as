package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public final class AnimFun extends Object
   {
      
      public function AnimFun(pActorId:int, pAnimName:String, pDelayTime:int, pFastAnim:Boolean) {
         super();
         this._actorId = pActorId;
         this._animName = pAnimName;
         this._delayTime = pDelayTime;
         this._fastAnim = pFastAnim;
      }
      
      protected static const _log:Logger;
      
      private var _actorId:int;
      
      private var _animName:String;
      
      private var _delayTime:int;
      
      private var _fastAnim:Boolean;
      
      public function get actorId() : int {
         return this._actorId;
      }
      
      public function get delayTime() : int {
         return this._delayTime;
      }
      
      public function get fastAnim() : Boolean {
         return this._fastAnim;
      }
      
      public function get animName() : String {
         return this._animName;
      }
      
      public function toString() : String {
         return "[AnimFun " + this._actorId + " " + this._animName + " " + this._delayTime + " " + this._fastAnim + "]";
      }
   }
}
