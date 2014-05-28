package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class MapElementRollOutMessage extends ComponentMessage
   {
      
      public function MapElementRollOutMessage(target:GraphicContainer, targetedElement:MapElement) {
         super(target);
         this._targetedElement = targetedElement;
         _target = target;
      }
      
      private var _targetedElement:MapElement;
      
      public function get targetedElement() : MapElement {
         return this._targetedElement;
      }
   }
}
