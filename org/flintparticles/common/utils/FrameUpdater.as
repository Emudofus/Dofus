package org.flintparticles.common.utils
{
   import flash.events.EventDispatcher;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   import org.flintparticles.common.events.UpdateEvent;
   
   public class FrameUpdater extends EventDispatcher
   {
      
      public function FrameUpdater() {
         super();
         this._shape = new Shape();
         this._shape.addEventListener(Event.ENTER_FRAME,this.frameUpdate,false,0,true);
         this._time = getTimer();
      }
      
      private static var _instance:FrameUpdater;
      
      public static function get instance() : FrameUpdater {
         if(_instance == null)
         {
            _instance = new FrameUpdater();
         }
         return _instance;
      }
      
      private var _shape:Shape;
      
      private var _time:Number;
      
      private function frameUpdate(param1:Event) : void {
         var _loc2_:int = this._time;
         this._time = getTimer();
         var _loc3_:Number = (this._time - _loc2_) * 0.001;
         dispatchEvent(new UpdateEvent(UpdateEvent.UPDATE,_loc3_));
      }
   }
}
