package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.components.Grid;
   
   public class ItemRightClickMessage extends ComponentMessage
   {
      
      public function ItemRightClickMessage(grid:Grid, gridItem:GridItem) {
         super(grid);
         this._gridItem = gridItem;
      }
      
      private var _gridItem:GridItem;
      
      public function get item() : GridItem {
         return this._gridItem;
      }
   }
}
