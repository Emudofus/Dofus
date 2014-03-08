package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityClickMessage extends EntityInteractionMessage
   {
      
      public function EntityClickMessage(param1:IInteractive) {
         super(param1);
      }
   }
}
