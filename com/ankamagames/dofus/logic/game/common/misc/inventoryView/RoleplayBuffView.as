package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;


   public class RoleplayBuffView extends Object implements IInventoryView
   {
         

      public function RoleplayBuffView(hookLock:HookLock) {
         this._hookLock=new HookLock();
         super();
         this._hookLock=hookLock;
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayBuffView));

      private var _content:Vector.<ItemWrapper>;

      private var _hookLock:HookLock;

      public function initialize(items:Vector.<ItemWrapper>) : void {
         var item:ItemWrapper = null;
         this._content=new Vector.<ItemWrapper>();
         for each (item in items)
         {
            if(this.isListening(item))
            {
               this.addItem(item,0);
            }
         }
      }

      public function get name() : String {
         return "roleplayBuff";
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
         if(idx==-1)
         {
            _log.warn("L\'item qui doit �tre supprim� n\'est pas pr�sent dans la liste");
         }
         this.content.splice(idx,1);
         this.updateView();
      }

      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void {
         this.updateView();
      }

      public function isListening(item:ItemWrapper) : Boolean {
         return (item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_MUTATION)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_MALUS)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_MALUS)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_ROLEPLAY_BUFFER)||(item.position==CharacterInventoryPositionEnum.INVENTORY_POSITION_FOLLOWER);
      }

      public function updateView() : void {
         this._hookLock.addHook(InventoryHookList.RoleplayBuffViewContent,[this.content]);
      }

      public function empty() : void {
         this._content=new Vector.<ItemWrapper>();
         this.updateView();
      }
   }

}