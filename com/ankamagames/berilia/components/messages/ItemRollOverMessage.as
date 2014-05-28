package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class ItemRollOverMessage extends ComponentMessage
   {
      
      public function ItemRollOverMessage(target:GraphicContainer, gridItem:GridItem) {
         super(target);
         this._gridItem = gridItem;
      }
      
      private var _gridItem:GridItem;
      
      public function get item() : GridItem {
         return this._gridItem;
      }
   }
}
