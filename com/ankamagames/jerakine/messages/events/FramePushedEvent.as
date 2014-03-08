package com.ankamagames.jerakine.messages.events
{
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Frame;
   
   public class FramePushedEvent extends Event
   {
      
      public function FramePushedEvent(param1:Frame) {
         super(EVENT_FRAME_PUSHED,false,false);
         this._frame = param1;
      }
      
      public static const EVENT_FRAME_PUSHED:String = "event_frame_pushed";
      
      private var _frame:Frame;
      
      public function get frame() : Frame {
         return this._frame;
      }
   }
}
