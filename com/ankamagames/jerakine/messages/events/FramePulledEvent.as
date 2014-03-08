package com.ankamagames.jerakine.messages.events
{
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Frame;
   
   public class FramePulledEvent extends Event
   {
      
      public function FramePulledEvent(param1:Frame) {
         super(EVENT_FRAME_PULLED,false,false);
         this._frame = param1;
      }
      
      public static const EVENT_FRAME_PULLED:String = "event_frame_pulled";
      
      private var _frame:Frame;
      
      public function get frame() : Frame {
         return this._frame;
      }
   }
}
