package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.components.Grid;
   
   public class ItemRightClickMessage extends ComponentMessage
   {
      
      public function ItemRightClickMessage(param1:Grid, param2:GridItem) {
         super(param1);
         this._gridItem = param2;
      }
      
      private var _gridItem:GridItem;
      
      public function get item() : GridItem {
         return this._gridItem;
      }
   }
}
