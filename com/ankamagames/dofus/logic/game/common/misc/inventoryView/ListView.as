package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.IHookLock;
   
   public class ListView extends Object implements IInventoryView
   {
      
      public function ListView(param1:IHookLock) {
         this._view = new Vector.<ItemWrapper>();
         super();
         this._hookLock = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ListView));
      
      protected var _view:Vector.<ItemWrapper>;
      
      protected var _hookLock:IHookLock;
      
      public function get name() : String {
         throw new Error("get name() is abstract method, it should be implemented");
      }
      
      public function initialize(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:ItemWrapper = null;
         this._view.splice(0,this._view.length);
         for each (_loc2_ in param1)
         {
            this._view.push(_loc2_);
         }
         this.updateView();
      }
      
      public function get content() : Vector.<ItemWrapper> {
         return this._view;
      }
      
      public function addItem(param1:ItemWrapper, param2:int) : void {
         this._view.push(param1);
      }
      
      public function removeItem(param1:ItemWrapper, param2:int) : void {
         var _loc3_:int = this._view.indexOf(param1);
         if(_loc3_ == -1)
         {
            throw new Error("Demande de suppression d\'un item (id " + param1.objectUID + ") qui n\'existe pas dans la vue " + this.name);
         }
         else
         {
            this._view.splice(_loc3_,1);
            return;
         }
      }
      
      public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void {
         var _loc4_:int = this._view.indexOf(param1);
         if(_loc4_ == -1)
         {
            throw new Error("Demande de modification d\'un item (id " + param1.objectUID + ") qui n\'existe pas dans la vue " + this.name);
         }
         else
         {
            this._view[_loc4_] = param1;
            return;
         }
      }
      
      public function isListening(param1:ItemWrapper) : Boolean {
         throw new Error("isListening() is abstract method, it should be implemented");
      }
      
      public function updateView() : void {
         throw new Error("updateView() is abstract method, it should be implemented");
      }
      
      public function empty() : void {
         this._view = new Vector.<ItemWrapper>();
         this.updateView();
      }
   }
}
