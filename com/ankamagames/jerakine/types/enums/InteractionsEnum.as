package com.ankamagames.jerakine.types.enums
{
   import flash.events.MouseEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   
   public class InteractionsEnum extends Object
   {
      
      public function InteractionsEnum() {
         super();
      }
      
      public static const CLICK:uint = 1 << 0;
      
      public static const OVER:uint = 1 << 1;
      
      public static const OUT:uint = 1 << 2;
      
      public static function getEvents(param1:uint) : Array {
         switch(param1)
         {
            case CLICK:
               return [MouseEvent.CLICK];
            case OVER:
               return [MouseEvent.MOUSE_OVER];
            case OUT:
               return [MouseEvent.MOUSE_OUT,Event.REMOVED_FROM_STAGE];
            default:
               throw new JerakineError("Unknown interaction type " + param1 + ".");
         }
      }
      
      public static function getMessage(param1:String) : Class {
         switch(param1)
         {
            case MouseEvent.CLICK:
               return EntityClickMessage;
            case MouseEvent.MOUSE_OVER:
               return EntityMouseOverMessage;
            case Event.REMOVED_FROM_STAGE:
            case MouseEvent.MOUSE_OUT:
               return EntityMouseOutMessage;
            default:
               throw new JerakineError("Unknown event type for an interaction \'" + param1 + "\'.");
         }
      }
   }
}
