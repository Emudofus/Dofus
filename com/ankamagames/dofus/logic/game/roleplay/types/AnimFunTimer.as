package com.ankamagames.dofus.logic.game.roleplay.types
{
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   
   public final class AnimFunTimer extends Object
   {
      
      public function AnimFunTimer(actorId:int, time:int, animId:int, callBack:Function) {
         super();
         this._callBack = callBack;
         this.actorId = actorId;
         this.animId = animId;
         this._timer = new Timer(time,1);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
      }
      
      public var actorId:int;
      
      public var animId:int;
      
      private var _callBack:Function;
      
      private var _timer:Timer;
      
      public function destroy() : void {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer = null;
         }
      }
      
      public function get running() : Boolean {
         return this._timer.running;
      }
      
      private function onTimer(e:Event) : void {
         this._callBack(this);
         this.destroy();
      }
   }
}
