package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class MapElementRollOverMessage extends ComponentMessage
   {
      
      public function MapElementRollOverMessage(param1:GraphicContainer, param2:MapElement) {
         super(param1);
         this._targetedElement = param2;
         _target = param1;
      }
      
      private var _targetedElement:MapElement;
      
      public function get targetedElement() : MapElement {
         return this._targetedElement;
      }
   }
}
