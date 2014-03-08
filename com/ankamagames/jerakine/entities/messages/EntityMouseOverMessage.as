package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityMouseOverMessage extends EntityInteractionMessage
   {
      
      public function EntityMouseOverMessage(entity:IInteractive, virtual:Boolean=false) {
         super(entity);
         this.virtual = virtual;
      }
      
      public var virtual:Boolean;
   }
}
