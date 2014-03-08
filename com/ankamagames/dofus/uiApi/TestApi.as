package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import __AS3__.vec.Vector;
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
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getTestInventory(param1:uint) : Vector.<ItemWrapper> {
         var _loc4_:Item = null;
         var _loc2_:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         var _loc3_:uint = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = null;
            while(!_loc4_)
            {
               _loc4_ = Item.getItemById(Math.floor(Math.random() * 1000));
            }
            _loc2_.push(ItemWrapper.create(63,_loc3_,_loc4_.id,0,null));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function showTrace(param1:Boolean=true) : void {
         showRedrawRegions(param1,40349);
      }
   }
}
