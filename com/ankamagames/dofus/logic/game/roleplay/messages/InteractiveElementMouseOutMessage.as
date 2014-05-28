package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   
   public class InteractiveElementMouseOutMessage extends Object implements Message
   {
      
      public function InteractiveElementMouseOutMessage(ie:InteractiveElement) {
         super();
         this._ie = ie;
      }
      
      private var _ie:InteractiveElement;
      
      public function get interactiveElement() : InteractiveElement {
         return this._ie;
      }
   }
}
