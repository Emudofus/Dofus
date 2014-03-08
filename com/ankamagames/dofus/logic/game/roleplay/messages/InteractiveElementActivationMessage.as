package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class InteractiveElementActivationMessage extends Object implements Message
   {
      
      public function InteractiveElementActivationMessage(param1:InteractiveElement, param2:MapPoint, param3:uint) {
         super();
         this._ie = param1;
         this._position = param2;
         this._skillInstanceId = param3;
      }
      
      private var _ie:InteractiveElement;
      
      private var _position:MapPoint;
      
      private var _skillInstanceId:uint;
      
      public function get interactiveElement() : InteractiveElement {
         return this._ie;
      }
      
      public function get position() : MapPoint {
         return this._position;
      }
      
      public function get skillInstanceId() : uint {
         return this._skillInstanceId;
      }
   }
}
