package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
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
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getStorageObjectGID(pObjectGID:uint, quantity:uint = 1) : Object {
         var iw:ItemWrapper = null;
         var returnItems:Array = new Array();
         var numberReturn:uint = 0;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(iw in inventory)
         {
            if(!((!(iw.objectGID == pObjectGID)) || (iw.position < 63) || (iw.linked)))
            {
               if(iw.quantity >= quantity - numberReturn)
               {
                  returnItems.push(
                     {
                        "objectUID":iw.objectUID,
                        "quantity":quantity - numberReturn
                     });
                  numberReturn = quantity;
                  return returnItems;
               }
               returnItems.push(
                  {
                     "objectUID":iw.objectUID,
                     "quantity":iw.quantity
                  });
               numberReturn = numberReturn + iw.quantity;
            }
         }
         return null;
      }
      
      public function getStorageObjectsByType(objectType:uint) : Array {
         var iw:ItemWrapper = null;
         var returnItems:Array = new Array();
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(iw in inventory)
         {
            if(!((!(iw.typeId == objectType)) || (iw.position < 63)))
            {
               returnItems.push(iw);
            }
         }
         return returnItems;
      }
      
      public function getItemQty(pObjectGID:uint, pObjectUID:uint = 0) : uint {
         var item:ItemWrapper = null;
         var quantity:uint = 0;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(item in inventory)
         {
            if(!((item.position < 63) || (!(item.objectGID == pObjectGID)) || (pObjectUID > 0) && (!(item.objectUID == pObjectUID))))
            {
               quantity = quantity + item.quantity;
            }
         }
         return quantity;
      }
      
      public function getItem(objectUID:uint) : ItemWrapper {
         return InventoryManager.getInstance().inventory.getItem(objectUID);
      }
      
      public function getEquipementItemByPosition(pPosition:uint) : ItemWrapper {
         if((pPosition > 15) && (!(pPosition == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION)))
         {
            return null;
         }
         var equipementList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         return equipementList[pPosition];
      }
      
      public function getEquipement() : Vector.<ItemWrapper> {
         var equipementList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         return equipementList;
      }
      
      public function getEquipementForPreset() : Array {
         var emptyUri:Uri = null;
         var objExists:* = false;
         var item:ItemWrapper = null;
         var mountFakeItemWrapper:MountWrapper = null;
         var equipmentList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         var equipmentPreset:Array = new Array(16);
         var i:int = 0;
         while(i < 16)
         {
            objExists = false;
            for each(item in equipmentList)
            {
               if(item)
               {
                  if(item.position == i)
                  {
                     equipmentPreset[i] = item;
                     objExists = true;
                  }
               }
            }
            if(!objExists)
            {
               switch(i)
               {
                  case 9:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                  case 14:
                     emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                     break;
                  default:
                     emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + i);
               }
               equipmentPreset[i] = SimpleTextureWrapper.create(emptyUri);
            }
            i++;
         }
         return equipmentPreset;
      }
      
      public function getVoidItemForPreset(index:int) : SimpleTextureWrapper {
         var emptyUri:Uri = null;
         switch(index)
         {
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
               break;
            default:
               emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + index);
         }
         return SimpleTextureWrapper.create(emptyUri);
      }
      
      public function getCurrentWeapon() : ItemWrapper {
         return this.getEquipementItemByPosition(CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON) as ItemWrapper;
      }
      
      public function getPresets() : Array {
         var preset:PresetWrapper = null;
         var presets:Array = new Array();
         var emptyUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
         var i:int = 0;
         while(i < 8)
         {
            preset = InventoryManager.getInstance().presets[i];
            if(preset)
            {
               presets.push(preset);
            }
            else
            {
               presets.push(SimpleTextureWrapper.create(emptyUri));
            }
            i++;
         }
         return presets;
      }
      
      public function removeSelectedItem() : Boolean {
         var rpcfrm:RoleplayPointCellFrame = null;
         var frm:InventoryManagementFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         if((frm) && (frm.roleplayPointCellFrame) && (frm.roleplayPointCellFrame.object))
         {
            rpcfrm = Kernel.getWorker().getFrame(RoleplayPointCellFrame) as RoleplayPointCellFrame;
            if(rpcfrm)
            {
               rpcfrm.cancelShow();
            }
            else
            {
               Kernel.getWorker().removeFrame(frm.roleplayPointCellFrame.object as RoleplayPointCellFrame);
               frm.roleplayPointCellFrame = null;
            }
            return true;
         }
         return false;
      }
   }
}
