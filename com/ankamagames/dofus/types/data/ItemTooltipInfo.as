package com.ankamagames.dofus.types.data
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   
   public class ItemTooltipInfo extends Object
   {
      
      public function ItemTooltipInfo(itemWrapper:ItemWrapper, shortcutKey:String=null) {
         super();
         this.itemWrapper = itemWrapper;
         this.shortcutKey = shortcutKey;
      }
      
      public var itemWrapper:ItemWrapper;
      
      public var shortcutKey:String;
   }
}
