package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.internalDatacenter.items.SimpleTextureWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.PresetWrapper;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayPointCellFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class InventoryApi extends Object implements IApi
   {
      
      public function InventoryApi() {
         this._log = Log.getLogger(getQualifiedClassName(InventoryApi));
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
      
      public function getStorageObjectGID(param1:uint, param2:uint=1) : Object {
         var _loc6_:ItemWrapper = null;
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         var _loc5_:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each (_loc6_ in _loc5_)
         {
            if(!(!(_loc6_.objectGID == param1) || _loc6_.position < 63 || (_loc6_.linked)))
            {
               if(_loc6_.quantity >= param2 - _loc4_)
               {
                  _loc3_.push(
                     {
                        "objectUID":_loc6_.objectUID,
                        "quantity":param2 - _loc4_
                     });
                  _loc4_ = param2;
                  return _loc3_;
               }
               _loc3_.push(
                  {
                     "objectUID":_loc6_.objectUID,
                     "quantity":_loc6_.quantity
                  });
               _loc4_ = _loc4_ + _loc6_.quantity;
            }
         }
         return null;
      }
      
      public function getStorageObjectsByType(param1:uint) : Array {
         var _loc4_:ItemWrapper = null;
         var _loc2_:Array = new Array();
         var _loc3_:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each (_loc4_ in _loc3_)
         {
            if(!(!(_loc4_.typeId == param1) || _loc4_.position < 63))
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function getItemQty(param1:uint, param2:uint=0) : uint {
         var _loc5_:ItemWrapper = null;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each (_loc5_ in _loc4_)
         {
            if(!(_loc5_.position < 63 || !(_loc5_.objectGID == param1) || param2 > 0 && !(_loc5_.objectUID == param2)))
            {
               _loc3_ = _loc3_ + _loc5_.quantity;
            }
         }
         return _loc3_;
      }
      
      public function getItem(param1:uint) : ItemWrapper {
         return InventoryManager.getInstance().inventory.getItem(param1);
      }
      
      public function getEquipementItemByPosition(param1:uint) : ItemWrapper {
         if(param1 > 15 && !(param1 == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION))
         {
            return null;
         }
         var _loc2_:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         return _loc2_[param1];
      }
      
      public function getEquipement() : Vector.<ItemWrapper> {
         var _loc1_:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         return _loc1_;
      }
      
      public function getEquipementForPreset() : Array {
         var _loc3_:Uri = null;
         var _loc5_:* = false;
         var _loc6_:ItemWrapper = null;
         var _loc7_:MountWrapper = null;
         var _loc1_:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         var _loc2_:Array = new Array(16);
         var _loc4_:* = 0;
         while(_loc4_ < 16)
         {
            _loc5_ = false;
            for each (_loc6_ in _loc1_)
            {
               if(_loc6_)
               {
                  if(_loc6_.position == _loc4_)
                  {
                     _loc2_[_loc4_] = _loc6_;
                     _loc5_ = true;
                  }
               }
               else
               {
                  if(_loc4_ == 8 && (PlayedCharacterManager.getInstance().isRidding))
                  {
                     _loc7_ = MountWrapper.create();
                     _loc2_[_loc4_] = _loc7_;
                     _loc5_ = true;
                  }
               }
            }
            if(!_loc5_)
            {
               switch(_loc4_)
               {
                  case 9:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                  case 14:
                     _loc3_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                     break;
                  default:
                     _loc3_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc4_);
               }
               _loc2_[_loc4_] = SimpleTextureWrapper.create(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getVoidItemForPreset(param1:int) : SimpleTextureWrapper {
         var _loc2_:Uri = null;
         switch(param1)
         {
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc2_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
               break;
            default:
               _loc2_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + param1);
         }
         return SimpleTextureWrapper.create(_loc2_);
      }
      
      public function getCurrentWeapon() : ItemWrapper {
         return this.getEquipementItemByPosition(CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON) as ItemWrapper;
      }
      
      public function getPresets() : Array {
         var _loc4_:PresetWrapper = null;
         var _loc1_:Array = new Array();
         var _loc2_:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
         var _loc3_:* = 0;
         while(_loc3_ < 8)
         {
            _loc4_ = InventoryManager.getInstance().presets[_loc3_];
            if(_loc4_)
            {
               _loc1_.push(_loc4_);
            }
            else
            {
               _loc1_.push(SimpleTextureWrapper.create(_loc2_));
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function removeSelectedItem() : Boolean {
         var _loc2_:RoleplayPointCellFrame = null;
         var _loc1_:InventoryManagementFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         if((_loc1_) && (_loc1_.roleplayPointCellFrame) && (_loc1_.roleplayPointCellFrame.object))
         {
            _loc2_ = Kernel.getWorker().getFrame(RoleplayPointCellFrame) as RoleplayPointCellFrame;
            if(_loc2_)
            {
               _loc2_.cancelShow();
            }
            else
            {
               Kernel.getWorker().removeFrame(_loc1_.roleplayPointCellFrame.object as RoleplayPointCellFrame);
               _loc1_.roleplayPointCellFrame = null;
            }
            return true;
         }
         return false;
      }
   }
}
