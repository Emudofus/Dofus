package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   
   public class InteractiveElementMouseOverMessage extends Object implements Message
   {
      
      public function InteractiveElementMouseOverMessage(param1:InteractiveElement, param2:*) {
         super();
         this._ie = param1;
         this._sprite = param2;
      }
      
      private var _ie:InteractiveElement;
      
      private var _sprite;
      
      public function get interactiveElement() : InteractiveElement {
         return this._ie;
      }
      
      public function get sprite() : * {
         return this._sprite;
      }
   }
}
