package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public final class AnimFun extends Object
   {
      
      public function AnimFun(param1:int, param2:String, param3:int, param4:Boolean)
      {
         super();
         this._actorId = param1;
         this._animName = param2;
         this._delayTime = param3;
         this._fastAnim = param4;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimFun));
      
      private var _actorId:int;
      
      private var _animName:String;
      
      private var _delayTime:int;
      
      private var _fastAnim:Boolean;
      
      public function get actorId() : int
      {
         return this._actorId;
      }
      
      public function get delayTime() : int
      {
         return this._delayTime;
      }
      
      public function get fastAnim() : Boolean
      {
         return this._fastAnim;
      }
      
      public function get animName() : String
      {
         return this._animName;
      }
      
      public function toString() : String
      {
         return "[AnimFun " + this._actorId + " " + this._animName + " " + this._delayTime + " " + this._fastAnim + "]";
      }
   }
}
