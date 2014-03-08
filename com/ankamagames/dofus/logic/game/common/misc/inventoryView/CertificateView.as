package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   
   public class CertificateView extends Object implements IInventoryView
   {
      
      public function CertificateView(hookLock:HookLock) {
         super();
         this._hookLock = hookLock;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CertificateView));
      
      private var _content:Vector.<ItemWrapper>;
      
      private var _hookLock:HookLock;
      
      public function initialize(items:Vector.<ItemWrapper>) : void {
         var item:ItemWrapper = null;
         this._content = new Vector.<ItemWrapper>();
         for each (item in items)
         {
            if(this.isListening(item))
            {
               this.addItem(item,0);
            }
         }
      }
      
      public function get name() : String {
         return "certificate";
      }
      
      public function get content() : Vector.<ItemWrapper> {
         return this._content;
      }
      
      public function addItem(item:ItemWrapper, invisible:int) : void {
         this._content.unshift(item);
         this.updateView();
      }
      
      public function removeItem(item:ItemWrapper, invisible:int) : void {
         var idx:int = this.content.indexOf(item);
         if(idx == -1)
         {
            _log.warn("L\'item qui doit être supprimé n\'est pas présent dans la liste");
            return;
         }
         this.content.splice(idx,1);
         this.updateView();
      }
      
      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void {
         this.updateView();
      }
      
      public function isListening(item:ItemWrapper) : Boolean {
         return item.isCertificate;
      }
      
      public function updateView() : void {
         this._hookLock.addHook(MountHookList.MountStableUpdate,[null,null,this.content]);
      }
      
      public function empty() : void {
         this._content = new Vector.<ItemWrapper>();
         this.updateView();
      }
   }
}
