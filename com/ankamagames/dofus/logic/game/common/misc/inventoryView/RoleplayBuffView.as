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
      
      public function RoleplayBuffView(param1:HookLock) {
         this._hookLock = new HookLock();
         super();
         this._hookLock = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayBuffView));
      
      private var _content:Vector.<ItemWrapper>;
      
      private var _hookLock:HookLock;
      
      public function initialize(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:ItemWrapper = null;
         this._content = new Vector.<ItemWrapper>();
         for each (_loc2_ in param1)
         {
            if(this.isListening(_loc2_))
            {
               this.addItem(_loc2_,0);
            }
         }
      }
      
      public function get name() : String {
         return "roleplayBuff";
      }
      
      public function get content() : Vector.<ItemWrapper> {
         return this._content;
      }
      
      public function addItem(param1:ItemWrapper, param2:int) : void {
         this._content.unshift(param1);
         this.updateView();
      }
      
      public function removeItem(param1:ItemWrapper, param2:int) : void {
         var _loc3_:int = this.content.indexOf(param1);
         if(_loc3_ == -1)
         {
            _log.warn("L\'item qui doit être supprimé n\'est pas présent dans la liste");
         }
         this.content.splice(_loc3_,1);
         this.updateView();
      }
      
      public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void {
         this.updateView();
      }
      
      public function isListening(param1:ItemWrapper) : Boolean {
         return param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_MUTATION || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_MALUS || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_MALUS || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ROLEPLAY_BUFFER || param1.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_FOLLOWER;
      }
      
      public function updateView() : void {
         this._hookLock.addHook(InventoryHookList.RoleplayBuffViewContent,[this.content]);
      }
      
      public function empty() : void {
         this._content = new Vector.<ItemWrapper>();
         this.updateView();
      }
   }
}
