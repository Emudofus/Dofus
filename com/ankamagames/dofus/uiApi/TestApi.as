package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.datacenter.items.Item;
   import flash.profiler.showRedrawRegions;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TestApi extends Object implements IApi
   {
      
      public function TestApi() {
         this._log = Log.getLogger(getQualifiedClassName(DataApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getTestInventory(len:uint) : Vector.<ItemWrapper> {
         var item:Item = null;
         var inventory:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         var i:uint = 0;
         while(i < len)
         {
            item = null;
            while(!item)
            {
               item = Item.getItemById(Math.floor(Math.random() * 1000));
            }
            inventory.push(ItemWrapper.create(63,i,item.id,0,null));
            i++;
         }
         return inventory;
      }
      
      public function showTrace(active:Boolean = true) : void {
         showRedrawRegions(active,40349);
      }
   }
}
