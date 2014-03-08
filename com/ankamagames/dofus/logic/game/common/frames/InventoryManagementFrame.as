package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryContentAndPresetMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryContentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectQuantityMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsQuantityMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.KamasUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryWeightMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectMovementMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarContentMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRefreshMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRemovedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarAddRequestMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRemoveRequestMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarSwapRequestMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PresetSetPositionAction;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsDeletedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDeleteMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectDropAction;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseOnCellMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseOnCellAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetUpdateMessage;
   import com.ankamagames.dofus.internalDatacenter.items.PresetWrapper;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetItemUpdateMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetDeleteAction;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetDeleteMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetDeleteResultMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetSaveAction;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetSaveMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetSaveCustomAction;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetSaveCustomMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetSaveResultMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetUseAction;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetUseMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetUseResultMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.InventoryPresetItemUpdateRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetItemUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.preset.InventoryPresetItemUpdateErrorMessage;
   import com.ankamagames.dofus.network.types.game.inventory.preset.Preset;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectItem;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectPreset;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSmiley;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutEmote;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSpell;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectSetPositionMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDropMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import __AS3__.vec.*;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.ObjectErrorEnum;
   import com.ankamagames.dofus.network.enums.PresetDeleteResultEnum;
   import com.ankamagames.dofus.network.enums.PresetSaveResultEnum;
   import com.ankamagames.dofus.network.enums.PresetUseResultEnum;
   import com.ankamagames.dofus.network.enums.PresetSaveUpdateErrorEnum;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseOnCharacterMessage;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseMultipleMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayPointCellFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   
   public class InventoryManagementFrame extends Object implements Frame
   {
      
      public function InventoryManagementFrame() {
         this._soundApi = new SoundApi();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryManagementFrame));
      
      private var _objectUIDToDrop:int;
      
      private var _objectGIDToDrop:uint;
      
      private var _quantityToDrop:uint;
      
      private var _currentPointUseUIDObject:uint;
      
      private var _movingObjectUID:int;
      
      private var _movingObjectPreviousPosition:int;
      
      private var _objectPositionModification:Boolean;
      
      private var _soundApi:SoundApi;
      
      private var _roleplayPointCellFrame:WeakReference;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get mountFrame() : MountFrame {
         return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
      }
      
      public function get roleplayPointCellFrame() : WeakReference {
         return this._roleplayPointCellFrame;
      }
      
      public function set roleplayPointCellFrame(val:WeakReference) : void {
         this._roleplayPointCellFrame = val;
      }
      
      public function getWrappersFromShortcuts(shortcuts:Vector.<Shortcut>) : Array {
         var shortcutProperties:Object = null;
         var shortcut:Shortcut = null;
         var wrappers:Array = new Array();
         for each (shortcut in shortcuts)
         {
            shortcutProperties = this.getShortcutWrapperPropFromShortcut(shortcut);
            wrappers[shortcut.slot] = ShortcutWrapper.create(shortcut.slot,shortcutProperties.id,shortcutProperties.type,shortcutProperties.gid);
         }
         return wrappers;
      }
      
      public function pushed() : Boolean {
         InventoryManager.getInstance().init();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var icapmsg:InventoryContentAndPresetMessage = null;
         var presetWrappers:Array = null;
         var icmsg:InventoryContentMessage = null;
         var oam:ObjectAddedMessage = null;
         var osam:ObjectsAddedMessage = null;
         var oqm:ObjectQuantityMessage = null;
         var osqm:ObjectsQuantityMessage = null;
         var kumsg:KamasUpdateMessage = null;
         var iwmsg:InventoryWeightMessage = null;
         var ommsg:ObjectMovementMessage = null;
         var sbcmsg:ShortcutBarContentMessage = null;
         var sCProperties:Object = null;
         var sbrmsg:ShortcutBarRefreshMessage = null;
         var inventoryMgr:InventoryManager = null;
         var sRProperties:Object = null;
         var sbrmmsg:ShortcutBarRemovedMessage = null;
         var sbara:ShortcutBarAddRequestAction = null;
         var sbarmsg:ShortcutBarAddRequestMessage = null;
         var swap:Boolean = false;
         var sbrra:ShortcutBarRemoveRequestAction = null;
         var sbrrmsg:ShortcutBarRemoveRequestMessage = null;
         var sbsra:ShortcutBarSwapRequestAction = null;
         var sbsrmsg:ShortcutBarSwapRequestMessage = null;
         var pspa:PresetSetPositionAction = null;
         var hiddenObjects:Vector.<ItemWrapper> = null;
         var presetItem:ItemWrapper = null;
         var ospa:ObjectSetPositionAction = null;
         var itw:ItemWrapper = null;
         var omdmsg:ObjectModifiedMessage = null;
         var odmsg:ObjectDeletedMessage = null;
         var osdmsg:ObjectsDeletedMessage = null;
         var positions:Array = null;
         var doa:DeleteObjectAction = null;
         var odmsg2:ObjectDeleteMessage = null;
         var oua:ObjectUseAction = null;
         var iw:ItemWrapper = null;
         var commonMod:Object = null;
         var fncUseItem:Function = null;
         var nbFood:int = 0;
         var nbBonus:int = 0;
         var view:IInventoryView = null;
         var oda:ObjectDropAction = null;
         var itemItem:Item = null;
         var objectName:String = null;
         var ouocmsg:ObjectUseOnCellMessage = null;
         var ouoca:ObjectUseOnCellAction = null;
         var oemsg:ObjectErrorMessage = null;
         var ipudmsg:InventoryPresetUpdateMessage = null;
         var newPW:PresetWrapper = null;
         var ipiumsg:InventoryPresetItemUpdateMessage = null;
         var ipda:InventoryPresetDeleteAction = null;
         var ipdmsg:InventoryPresetDeleteMessage = null;
         var ipdrmsg:InventoryPresetDeleteResultMessage = null;
         var ipsa:InventoryPresetSaveAction = null;
         var ipsmsg:InventoryPresetSaveMessage = null;
         var ipsca:InventoryPresetSaveCustomAction = null;
         var ipscmsg:InventoryPresetSaveCustomMessage = null;
         var ipsrmsg:InventoryPresetSaveResultMessage = null;
         var ipua:InventoryPresetUseAction = null;
         var ipumsg:InventoryPresetUseMessage = null;
         var ipurmsg:InventoryPresetUseResultMessage = null;
         var ipira:InventoryPresetItemUpdateRequestAction = null;
         var ipiurmsg:InventoryPresetItemUpdateRequestMessage = null;
         var ipiremsg:InventoryPresetItemUpdateErrorMessage = null;
         var reason:String = null;
         var equipmentView:IInventoryView = null;
         var preset:Preset = null;
         var osait:ObjectItem = null;
         var shortcutQty:ShortcutWrapper = null;
         var objoqm:ObjectItemQuantity = null;
         var shortcutsQty:ShortcutWrapper = null;
         var itwm:ItemWrapper = null;
         var shortcuti:ShortcutObjectItem = null;
         var shortcutp:ShortcutObjectPreset = null;
         var shortcutsm:ShortcutSmiley = null;
         var shortcute:ShortcutEmote = null;
         var shortcuts:ShortcutSpell = null;
         var realitem:ItemWrapper = null;
         var effect:EffectInstance = null;
         var ospmsg:ObjectSetPositionMessage = null;
         var ospmsg2:ObjectSetPositionMessage = null;
         var osdit:uint = 0;
         var t:ItemWrapper = null;
         var odropmsg:ObjectDropMessage = null;
         var shortcutipud:ShortcutWrapper = null;
         var reason1:String = null;
         var reason2:String = null;
         var reason3:String = null;
         switch(true)
         {
            case msg is InventoryContentAndPresetMessage:
               icapmsg = msg as InventoryContentAndPresetMessage;
               InventoryManager.getInstance().inventory.initializeFromObjectItems(icapmsg.objects);
               InventoryManager.getInstance().inventory.kamas = icapmsg.kamas;
               PlayedCharacterManager.getInstance().inventory = InventoryManager.getInstance().realInventory;
               if(PlayedCharacterManager.getInstance().characteristics)
               {
                  PlayedCharacterManager.getInstance().characteristics.kamas = icapmsg.kamas;
               }
               if(InventoryManager.getInstance().inventory)
               {
                  equipmentView = InventoryManager.getInstance().inventory.getView("equipment");
                  if((equipmentView) && (equipmentView.content))
                  {
                     if((equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS]) && (equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].typeId == Inventory.PETSMOUNT_TYPE_ID))
                     {
                        PlayedCharacterManager.getInstance().isPetsMounting = true;
                     }
                     if(equipmentView.content[CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION])
                     {
                        PlayedCharacterManager.getInstance().hasCompanion = true;
                     }
                  }
               }
               presetWrappers = new Array(8);
               for each (preset in icapmsg.presets)
               {
                  presetWrappers[preset.presetId] = PresetWrapper.create(preset.presetId,preset.symbolId,preset.objects,preset.mount);
               }
               InventoryManager.getInstance().presets = presetWrappers;
               return true;
            case msg is InventoryContentMessage:
               if(getQualifiedClassName(msg) != getQualifiedClassName(InventoryContentMessage))
               {
                  return false;
               }
               icmsg = msg as InventoryContentMessage;
               InventoryManager.getInstance().inventory.initializeFromObjectItems(icmsg.objects);
               InventoryManager.getInstance().inventory.kamas = icmsg.kamas;
               if(InventoryManager.getInstance().inventory)
               {
                  equipmentView = InventoryManager.getInstance().inventory.getView("equipment");
                  if((equipmentView) && (equipmentView.content))
                  {
                     if((equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS]) && (equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].typeId == Inventory.PETSMOUNT_TYPE_ID))
                     {
                        PlayedCharacterManager.getInstance().isPetsMounting = true;
                     }
                     if(equipmentView.content[CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION])
                     {
                        PlayedCharacterManager.getInstance().hasCompanion = true;
                     }
                  }
               }
               PlayedCharacterManager.getInstance().inventory = InventoryManager.getInstance().realInventory;
               if(PlayedCharacterManager.getInstance().characteristics)
               {
                  PlayedCharacterManager.getInstance().characteristics.kamas = icmsg.kamas;
               }
               InventoryManager.getInstance().presets = new Array(8);
               return true;
            case msg is ObjectAddedMessage:
               oam = msg as ObjectAddedMessage;
               InventoryManager.getInstance().inventory.addObjectItem(oam.object);
               return true;
            case msg is ObjectsAddedMessage:
               osam = msg as ObjectsAddedMessage;
               for each (osait in osam.object)
               {
                  InventoryManager.getInstance().inventory.addObjectItem(osait);
               }
               return true;
            case msg is ObjectQuantityMessage:
               oqm = msg as ObjectQuantityMessage;
               if(this._objectUIDToDrop == oqm.objectUID)
               {
                  this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                  this._objectUIDToDrop = -1;
               }
               InventoryManager.getInstance().inventory.modifyItemQuantity(oqm.objectUID,oqm.quantity);
               for each (shortcutQty in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((shortcutQty) && (shortcutQty.id == oqm.objectUID))
                  {
                     shortcutQty.quantity = oqm.quantity;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case msg is ObjectsQuantityMessage:
               osqm = msg as ObjectsQuantityMessage;
               for each (objoqm in osqm.objectsUIDAndQty)
               {
                  InventoryManager.getInstance().inventory.modifyItemQuantity(objoqm.objectUID,objoqm.quantity);
                  for each (shortcutsQty in InventoryManager.getInstance().shortcutBarItems)
                  {
                     if((shortcutsQty) && (shortcutsQty.id == objoqm.objectUID))
                     {
                        shortcutsQty.quantity = objoqm.quantity;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
               return true;
            case msg is KamasUpdateMessage:
               kumsg = msg as KamasUpdateMessage;
               InventoryManager.getInstance().inventory.kamas = kumsg.kamasTotal;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.KamasUpdate,kumsg.kamasTotal);
               InventoryManager.getInstance().inventory.releaseHooks();
               return true;
            case msg is InventoryWeightMessage:
               iwmsg = msg as InventoryWeightMessage;
               PlayedCharacterManager.getInstance().inventoryWeight = iwmsg.weight;
               PlayedCharacterManager.getInstance().inventoryWeightMax = iwmsg.weightMax;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.InventoryWeight,iwmsg.weight,iwmsg.weightMax);
               InventoryManager.getInstance().inventory.releaseHooks();
               return true;
            case msg is ObjectMovementMessage:
               ommsg = msg as ObjectMovementMessage;
               InventoryManager.getInstance().inventory.modifyItemPosition(ommsg.objectUID,ommsg.position);
               if((this._objectPositionModification) && (ommsg.position <= 16) && (ommsg.position >= 0) && (!Berilia.getInstance().getUi("storage")))
               {
                  itwm = InventoryManager.getInstance().inventory.getItem(ommsg.objectUID);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.item.inUse",[itwm.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  this._objectPositionModification = false;
               }
               return true;
            case msg is ShortcutBarContentMessage:
               sbcmsg = msg as ShortcutBarContentMessage;
               if(sbcmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarItems = this.getWrappersFromShortcuts(sbcmsg.shortcuts);
               }
               else
               {
                  if(sbcmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                  {
                     InventoryManager.getInstance().shortcutBarSpells = this.getWrappersFromShortcuts(sbcmsg.shortcuts);
                     PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbcmsg.barType);
               return true;
            case msg is ShortcutBarRefreshMessage:
               sbrmsg = msg as ShortcutBarRefreshMessage;
               inventoryMgr = InventoryManager.getInstance();
               sRProperties = this.getShortcutWrapperPropFromShortcut(sbrmsg.shortcut);
               if(sbrmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  if(inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot])
                  {
                     inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
                  else
                  {
                     inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
               }
               else
               {
                  if(sbrmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                  {
                     if(inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot])
                     {
                        inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                     }
                     else
                     {
                        inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                     }
                     if(PlayedCharacterManager.getInstance().spellsInventory == PlayedCharacterManager.getInstance().playerSpellList)
                     {
                        PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbrmsg.barType);
               return true;
            case msg is ShortcutBarRemovedMessage:
               sbrmmsg = msg as ShortcutBarRemovedMessage;
               if(sbrmmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarItems[sbrmmsg.slot] = null;
               }
               else
               {
                  if(sbrmmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                  {
                     InventoryManager.getInstance().shortcutBarSpells[sbrmmsg.slot] = null;
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbrmmsg.barType);
               return true;
            case msg is ShortcutBarAddRequestAction:
               sbara = msg as ShortcutBarAddRequestAction;
               sbarmsg = new ShortcutBarAddRequestMessage();
               swap = false;
               if(sbara.barType == 0)
               {
                  shortcuti = new ShortcutObjectItem();
                  shortcuti.itemUID = sbara.id;
                  shortcuti.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(sbara.barType,shortcuti);
               }
               else
               {
                  if(sbara.barType == 1)
                  {
                     shortcutp = new ShortcutObjectPreset();
                     shortcutp.presetId = sbara.id;
                     shortcutp.slot = sbara.slot;
                     sbarmsg.initShortcutBarAddRequestMessage(0,shortcutp);
                  }
                  else
                  {
                     if(sbara.barType == 3)
                     {
                        shortcutsm = new ShortcutSmiley();
                        shortcutsm.smileyId = sbara.id;
                        shortcutsm.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(0,shortcutsm);
                     }
                     else
                     {
                        if(sbara.barType == 4)
                        {
                           shortcute = new ShortcutEmote();
                           shortcute.emoteId = sbara.id;
                           shortcute.slot = sbara.slot;
                           sbarmsg.initShortcutBarAddRequestMessage(0,shortcute);
                        }
                        else
                        {
                           if(sbara.barType == 2)
                           {
                              shortcuts = new ShortcutSpell();
                              shortcuts.spellId = sbara.id;
                              shortcuts.slot = sbara.slot;
                              sbarmsg.initShortcutBarAddRequestMessage(1,shortcuts);
                           }
                        }
                     }
                  }
               }
               ConnectionsHandler.getConnection().send(sbarmsg);
               return true;
            case msg is ShortcutBarRemoveRequestAction:
               sbrra = msg as ShortcutBarRemoveRequestAction;
               sbrrmsg = new ShortcutBarRemoveRequestMessage();
               sbrrmsg.initShortcutBarRemoveRequestMessage(sbrra.barType,sbrra.slot);
               ConnectionsHandler.getConnection().send(sbrrmsg);
               return true;
            case msg is ShortcutBarSwapRequestAction:
               sbsra = msg as ShortcutBarSwapRequestAction;
               sbsrmsg = new ShortcutBarSwapRequestMessage();
               sbsrmsg.initShortcutBarSwapRequestMessage(sbsra.barType,sbsra.firstSlot,sbsra.secondSlot);
               ConnectionsHandler.getConnection().send(sbsrmsg);
               return true;
            case msg is PresetSetPositionAction:
               pspa = msg as PresetSetPositionAction;
               hiddenObjects = new Vector.<ItemWrapper>();
               loop5:
               for each (realitem in InventoryManager.getInstance().inventory.getView("real").content)
               {
                  if(Item.getItemById(realitem.objectGID).typeId == Inventory.HIDDEN_TYPE_ID)
                  {
                     hiddenObjects.push(realitem);
                     if((realitem.effects) && (realitem.effects.length))
                     {
                        for each (effect in realitem.effects)
                        {
                           if(effect.effectId == 707)
                           {
                              if(int(effect.parameter2) - 1 == pspa.presetId)
                              {
                                 presetItem = realitem;
                                 break loop5;
                              }
                           }
                        }
                     }
                  }
               }
               if(presetItem)
               {
                  this._movingObjectUID = presetItem.objectUID;
                  this._movingObjectPreviousPosition = 0;
                  ospmsg = new ObjectSetPositionMessage();
                  ospmsg.initObjectSetPositionMessage(presetItem.objectUID,pspa.position,1);
                  ConnectionsHandler.getConnection().send(ospmsg);
               }
               return true;
            case msg is ObjectSetPositionAction:
               ospa = msg as ObjectSetPositionAction;
               itw = InventoryManager.getInstance().inventory.getItem(ospa.objectUID);
               if((itw) && (!(itw.position == ospa.position)))
               {
                  this._movingObjectUID = ospa.objectUID;
                  if(!itw)
                  {
                     this._movingObjectPreviousPosition = 8;
                  }
                  else
                  {
                     this._movingObjectPreviousPosition = itw.position;
                  }
                  this._objectPositionModification = true;
                  ospmsg2 = new ObjectSetPositionMessage();
                  ospmsg2.initObjectSetPositionMessage(ospa.objectUID,ospa.position,ospa.quantity);
                  ConnectionsHandler.getConnection().send(ospmsg2);
               }
               return true;
            case msg is ObjectModifiedMessage:
               omdmsg = msg as ObjectModifiedMessage;
               InventoryManager.getInstance().inventory.modifyObjectItem(omdmsg.object);
               return true;
            case msg is ObjectDeletedMessage:
               odmsg = msg as ObjectDeletedMessage;
               if(this._objectUIDToDrop == odmsg.objectUID)
               {
                  this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                  this._objectUIDToDrop = -1;
               }
               InventoryManager.getInstance().inventory.removeItem(odmsg.objectUID,-1);
               return true;
            case msg is ObjectsDeletedMessage:
               osdmsg = msg as ObjectsDeletedMessage;
               positions = new Array();
               for each (osdit in osdmsg.objectUID)
               {
                  InventoryManager.getInstance().inventory.removeItem(osdit,-1);
               }
               return true;
            case msg is DeleteObjectAction:
               doa = msg as DeleteObjectAction;
               odmsg2 = new ObjectDeleteMessage();
               odmsg2.initObjectDeleteMessage(doa.objectUID,doa.quantity);
               ConnectionsHandler.getConnection().send(odmsg2);
               return true;
            case msg is ObjectUseAction:
               oua = msg as ObjectUseAction;
               iw = InventoryManager.getInstance().inventory.getItem(oua.objectUID);
               if(!iw)
               {
                  _log.error("Impossible de retrouver l\'objet d\'UID " + oua.objectUID);
                  return true;
               }
               if((!iw.usable) && (!iw.targetable))
               {
                  _log.error("L\'objet " + iw.name + " n\'est pas utilisable.");
                  return true;
               }
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               fncUseItem = function():void
               {
                  useItem(oua,iw);
               };
               nbFood = 0;
               nbBonus = 0;
               view = InventoryManager.getInstance().inventory.getView("roleplayBuff");
               for each (t in view.content)
               {
                  switch(t.position)
                  {
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD:
                        if(t.objectGID != iw.objectGID)
                        {
                           nbFood++;
                        }
                        continue;
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS:
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS:
                        nbBonus++;
                        continue;
                  }
               }
               if(iw.type.needUseConfirm)
               {
                  commonMod.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.common.confirmationUseItem",[iw.name]),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[fncUseItem,null],fncUseItem,function():void
                  {
                  });
               }
               else
               {
                  this.useItem(oua,iw);
               }
               return true;
            case msg is ObjectDropAction:
               oda = msg as ObjectDropAction;
               if(Kernel.getWorker().contains(FightContextFrame))
               {
                  return true;
               }
               itemItem = Item.getItemById(oda.objectGID);
               if(itemItem.type.superTypeId == 14)
               {
                  return true;
               }
               this._objectUIDToDrop = oda.objectUID;
               this._objectGIDToDrop = oda.objectGID;
               this._quantityToDrop = oda.quantity;
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               objectName = itemItem.name;
               if(Dofus.getInstance().options.confirmItemDrop)
               {
                  commonMod.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.common.confirmationDropItem",[oda.quantity,objectName]),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[this.onAcceptDrop,this.onRefuseDrop],this.onAcceptDrop,this.onRefuseDrop);
               }
               else
               {
                  odropmsg = new ObjectDropMessage();
                  odropmsg.initObjectDropMessage(this._objectUIDToDrop,this._quantityToDrop);
                  ConnectionsHandler.getConnection().send(odropmsg);
               }
               return true;
            case msg is ObjectUseOnCellAction:
               ouocmsg = new ObjectUseOnCellMessage();
               ouoca = msg as ObjectUseOnCellAction;
               ouocmsg.initObjectUseOnCellMessage(ouoca.objectUID,ouoca.targetedCell);
               ConnectionsHandler.getConnection().send(ouocmsg);
               break;
            case msg is ObjectErrorMessage:
               oemsg = msg as ObjectErrorMessage;
               if(oemsg.reason == ObjectErrorEnum.MIMICRY_OBJECT_ERROR)
               {
                  return false;
               }
               this._objectPositionModification = false;
               return false;
            case msg is InventoryPresetUpdateMessage:
               ipudmsg = msg as InventoryPresetUpdateMessage;
               newPW = PresetWrapper.create(ipudmsg.preset.presetId,ipudmsg.preset.symbolId,ipudmsg.preset.objects,ipudmsg.preset.mount);
               InventoryManager.getInstance().presets[ipudmsg.preset.presetId] = newPW;
               for each (shortcutipud in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((shortcutipud) && (shortcutipud.realItem is PresetWrapper) && ((shortcutipud.realItem as PresetWrapper).id == ipudmsg.preset.presetId))
                  {
                     shortcutipud.update(shortcutipud.slot,shortcutipud.id,shortcutipud.type,shortcutipud.gid);
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
               return true;
            case msg is InventoryPresetItemUpdateMessage:
               ipiumsg = msg as InventoryPresetItemUpdateMessage;
               InventoryManager.getInstance().presets[ipiumsg.presetId].updateObject(ipiumsg.presetItem);
               KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
               return true;
            case msg is InventoryPresetDeleteAction:
               ipda = msg as InventoryPresetDeleteAction;
               ipdmsg = new InventoryPresetDeleteMessage();
               ipdmsg.initInventoryPresetDeleteMessage(ipda.presetId);
               ConnectionsHandler.getConnection().send(ipdmsg);
               return true;
            case msg is InventoryPresetDeleteResultMessage:
               ipdrmsg = msg as InventoryPresetDeleteResultMessage;
               if(ipdrmsg.code == PresetDeleteResultEnum.PRESET_DEL_OK)
               {
                  InventoryManager.getInstance().presets[ipdrmsg.presetId] = null;
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetSelected,-1);
               }
               else
               {
                  switch(ipdrmsg.code)
                  {
                     case PresetDeleteResultEnum.PRESET_DEL_ERR_UNKNOWN:
                        reason1 = "unknown";
                        break;
                     case PresetDeleteResultEnum.PRESET_DEL_ERR_BAD_PRESET_ID:
                        reason1 = "badId";
                        break;
                  }
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,reason1);
               }
               return true;
            case msg is InventoryPresetSaveAction:
               ipsa = msg as InventoryPresetSaveAction;
               ipsmsg = new InventoryPresetSaveMessage();
               ipsmsg.initInventoryPresetSaveMessage(ipsa.presetId,ipsa.symbolId,ipsa.saveEquipment);
               ConnectionsHandler.getConnection().send(ipsmsg);
               return true;
            case msg is InventoryPresetSaveCustomAction:
               ipsca = msg as InventoryPresetSaveCustomAction;
               ipscmsg = new InventoryPresetSaveCustomMessage();
               ipscmsg.initInventoryPresetSaveCustomMessage(ipsca.presetId,ipsca.symbolId,ipsca.itemsPositions,ipsca.itemsUids);
               ConnectionsHandler.getConnection().send(ipscmsg);
               return true;
            case msg is InventoryPresetSaveResultMessage:
               ipsrmsg = msg as InventoryPresetSaveResultMessage;
               if(ipsrmsg.code != PresetSaveResultEnum.PRESET_SAVE_OK)
               {
                  switch(ipsrmsg.code)
                  {
                     case PresetSaveResultEnum.PRESET_SAVE_ERR_UNKNOWN:
                        reason2 = "unknown";
                        break;
                     case PresetSaveResultEnum.PRESET_SAVE_ERR_TOO_MANY:
                        reason2 = "tooMany";
                        break;
                  }
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,reason2);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetSelected,ipsrmsg.presetId);
               }
               return true;
            case msg is InventoryPresetUseAction:
               ipua = msg as InventoryPresetUseAction;
               ipumsg = new InventoryPresetUseMessage();
               ipumsg.initInventoryPresetUseMessage(ipua.presetId);
               ConnectionsHandler.getConnection().send(ipumsg);
               return true;
            case msg is InventoryPresetUseResultMessage:
               ipurmsg = msg as InventoryPresetUseResultMessage;
               if(ipurmsg.code != PresetUseResultEnum.PRESET_USE_OK)
               {
                  switch(ipurmsg.code)
                  {
                     case PresetUseResultEnum.PRESET_USE_ERR_UNKNOWN:
                        reason3 = "unknown";
                        break;
                     case PresetUseResultEnum.PRESET_USE_ERR_BAD_PRESET_ID:
                        reason3 = "badId";
                        break;
                     case PresetUseResultEnum.PRESET_USE_ERR_CRITERION:
                        reason3 = "criterion";
                        break;
                     case PresetUseResultEnum.PRESET_USE_OK_PARTIAL:
                        reason3 = "usePartial";
                        break;
                  }
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,reason3);
               }
               else
               {
                  if(!Berilia.getInstance().getUi("storage"))
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.preset.inUse",[ipurmsg.presetId + 1]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               return true;
            case msg is InventoryPresetItemUpdateRequestAction:
               ipira = msg as InventoryPresetItemUpdateRequestAction;
               ipiurmsg = new InventoryPresetItemUpdateRequestMessage();
               ipiurmsg.initInventoryPresetItemUpdateRequestMessage(ipira.presetId,ipira.position,ipira.objUid);
               ConnectionsHandler.getConnection().send(ipiurmsg);
               return true;
            case msg is InventoryPresetItemUpdateErrorMessage:
               ipiremsg = msg as InventoryPresetItemUpdateErrorMessage;
               switch(ipiremsg.code)
               {
                  case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_UNKNOWN:
                     reason = "unknown";
                     break;
                  case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_PRESET_ID:
                     reason = "badId";
                     break;
                  case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_OBJECT_ID:
                     reason = "badObjectId";
                     break;
                  case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_POSITION:
                     reason = "badPosition";
                     break;
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,reason);
               return true;
         }
         return false;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function onAcceptDrop() : void {
         var odropmsg:ObjectDropMessage = new ObjectDropMessage();
         odropmsg.initObjectDropMessage(this._objectUIDToDrop,this._quantityToDrop);
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            ConnectionsHandler.getConnection().send(odropmsg);
         }
      }
      
      public function onRefuseDrop() : void {
      }
      
      private function onCellPointed(success:Boolean, cellId:uint, entityId:int) : void {
         var oucmsg:ObjectUseOnCellMessage = null;
         var ouCharmsg:ObjectUseOnCharacterMessage = null;
         if(success)
         {
            if(entityId < 0)
            {
               oucmsg = new ObjectUseOnCellMessage();
               oucmsg.initObjectUseOnCellMessage(this._currentPointUseUIDObject,cellId);
               ConnectionsHandler.getConnection().send(oucmsg);
            }
            else
            {
               ouCharmsg = new ObjectUseOnCharacterMessage();
               ouCharmsg.initObjectUseOnCharacterMessage(this._currentPointUseUIDObject,entityId);
               ConnectionsHandler.getConnection().send(ouCharmsg);
            }
            this._currentPointUseUIDObject = 0;
         }
      }
      
      private function useItem(oua:ObjectUseAction, iw:ItemWrapper) : void {
         var cursorIcon:Texture = null;
         var oummsg:ObjectUseMultipleMessage = null;
         var oumsg:ObjectUseMessage = null;
         if((this._roleplayPointCellFrame) && (this._roleplayPointCellFrame.object) && (oua.objectUID == this._currentPointUseUIDObject))
         {
            Kernel.getWorker().removeFrame(this._roleplayPointCellFrame.object as RoleplayPointCellFrame);
            this._roleplayPointCellFrame = null;
         }
         if((oua.useOnCell) && (iw.targetable))
         {
            if(!Kernel.getWorker().getFrame(FightContextFrame))
            {
               this._currentPointUseUIDObject = oua.objectUID;
               cursorIcon = new Texture();
               cursorIcon.uri = iw.iconUri;
               cursorIcon.finalize();
               if(Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame)
               {
                  this._roleplayPointCellFrame = new WeakReference(new RoleplayPointCellFrame(this.onCellPointed,cursorIcon));
                  Kernel.getWorker().addFrame(this._roleplayPointCellFrame.object as Frame);
               }
            }
         }
         else
         {
            if(oua.quantity > 1)
            {
               oummsg = new ObjectUseMultipleMessage();
               oummsg.initObjectUseMultipleMessage(oua.objectUID,oua.quantity);
               ConnectionsHandler.getConnection().send(oummsg);
            }
            else
            {
               oumsg = new ObjectUseMessage();
               oumsg.initObjectUseMessage(oua.objectUID);
               ConnectionsHandler.getConnection().send(oumsg);
            }
         }
      }
      
      private function addObject(objectItem:ObjectItem) : void {
         InventoryManager.getInstance().inventory.addObjectItem(objectItem);
      }
      
      private function getShortcutWrapperPropFromShortcut(shortcut:Shortcut) : Object {
         var id:uint = 0;
         var type:uint = 0;
         var gid:uint = 0;
         if(shortcut is ShortcutObjectItem)
         {
            id = (shortcut as ShortcutObjectItem).itemUID;
            gid = (shortcut as ShortcutObjectItem).itemGID;
            type = 0;
         }
         else
         {
            if(shortcut is ShortcutObjectPreset)
            {
               id = (shortcut as ShortcutObjectPreset).presetId;
               type = 1;
            }
            else
            {
               if(shortcut is ShortcutEmote)
               {
                  id = (shortcut as ShortcutEmote).emoteId;
                  type = 4;
               }
               else
               {
                  if(shortcut is ShortcutSmiley)
                  {
                     id = (shortcut as ShortcutSmiley).smileyId;
                     type = 3;
                  }
                  else
                  {
                     if(shortcut is ShortcutSpell)
                     {
                        id = (shortcut as ShortcutSpell).spellId;
                        type = 2;
                     }
                  }
               }
            }
         }
         return 
            {
               "id":id,
               "gid":gid,
               "type":type
            };
      }
   }
}
