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
      
      public static const CLICK:uint;
      
      public static const OVER:uint;
      
      public static const OUT:uint;
      
      public static function getEvents(interactionType:uint) : Array {
         switch(interactionType)
         {
            case CLICK:
               return [MouseEvent.CLICK];
            case OVER:
               return [MouseEvent.MOUSE_OVER];
            case OUT:
               return [MouseEvent.MOUSE_OUT,Event.REMOVED_FROM_STAGE];
            default:
               throw new JerakineError("Unknown interaction type " + interactionType + ".");
         }
      }
      
      public static function getMessage(eventType:String) : Class {
         switch(eventType)
         {
            case MouseEvent.CLICK:
               return EntityClickMessage;
            case MouseEvent.MOUSE_OVER:
               return EntityMouseOverMessage;
            case Event.REMOVED_FROM_STAGE:
            case MouseEvent.MOUSE_OUT:
               return EntityMouseOutMessage;
            default:
               throw new JerakineError("Unknown event type for an interaction \'" + eventType + "\'.");
         }
      }
   }
}
