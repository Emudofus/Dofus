package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   
   public class EquipmentView extends Object implements IInventoryView
   {
      
      public function EquipmentView(param1:HookLock) {
         this._content = new Vector.<ItemWrapper>(62);
         super();
         this._hookLock = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EquipmentView));
      
      private var _content:Vector.<ItemWrapper>;
      
      private var _hookLock:HookLock;
      
      private var _initializing:Boolean;
      
      public function initialize(param1:Vector.<ItemWrapper>) : void {
         var _loc2_:ItemWrapper = null;
         this._initializing = true;
         this._content = new Vector.<ItemWrapper>(62);
         for each (_loc2_ in param1)
         {
            if(this.isListening(_loc2_))
            {
               this.addItem(_loc2_,0);
            }
         }
         this._initializing = false;
         this._hookLock.addHook(InventoryHookList.EquipmentViewContent,[this.content]);
      }
      
      public function get name() : String {
         return "equipment";
      }
      
      public function get content() : Vector.<ItemWrapper> {
         return this._content;
      }
      
      public function addItem(param1:ItemWrapper, param2:int) : void {
         this.content[param1.position] = param1;
         if(param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            PlayedCharacterManager.getInstance().currentWeapon = param1 as WeaponWrapper;
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         if(!this._initializing)
         {
            this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[param1,-1]);
         }
      }
      
      public function removeItem(param1:ItemWrapper, param2:int) : void {
         this.content[param1.position] = null;
         if(param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            PlayedCharacterManager.getInstance().currentWeapon = null;
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[null,param1.position]);
      }
      
      public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void {
         if(this.content[param2.position] == param1)
         {
            this.content[param2.position] = null;
         }
         this.content[param1.position] = param1;
         if(param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            this._hookLock.addHook(InventoryHookList.WeaponUpdate,[]);
         }
         this._hookLock.addHook(InventoryHookList.EquipmentObjectMove,[param1,param2.position]);
      }
      
      public function isListening(param1:ItemWrapper) : Boolean {
         return param1.position <= 61;
      }
      
      public function updateView() : void {
      }
      
      public function empty() : void {
      }
   }
}
