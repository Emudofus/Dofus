package com.ankamagames.jerakine.entities.messages
{
   import com.ankamagames.jerakine.messages.CancelableMessage;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   
   public class EntityMouseOutMessage extends EntityInteractionMessage implements CancelableMessage
   {
      
      public function EntityMouseOutMessage(param1:IInteractive) {
         super(param1);
      }
      
      private var _cancel:Boolean;
      
      public function set cancel(param1:Boolean) : void {
         this._cancel = param1;
      }
      
      public function get cancel() : Boolean {
         return this._cancel;
      }
   }
}
