package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.preset.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.inventory.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.messages.game.inventory.preset.*;
    import com.ankamagames.dofus.network.messages.game.shortcut.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.dofus.network.types.game.inventory.preset.*;
    import com.ankamagames.dofus.network.types.game.shortcut.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.utils.*;

    public class InventoryManagementFrame extends Object implements Frame
    {
        private var _objectUIDToDrop:int;
        private var _objectGIDToDrop:uint;
        private var _quantityToDrop:uint;
        private var _currentPointUseUIDObject:uint;
        private var _movingObjectUID:int;
        private var _movingObjectPreviousPosition:int;
        private var _soundApi:SoundApi;
        private var _roleplayPointCellFrame:WeakReference;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryManagementFrame));

        public function InventoryManagementFrame()
        {
            this._soundApi = new SoundApi();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get mountFrame() : MountFrame
        {
            return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
        }// end function

        public function get roleplayPointCellFrame() : WeakReference
        {
            return this._roleplayPointCellFrame;
        }// end function

        public function set roleplayPointCellFrame(param1:WeakReference) : void
        {
            this._roleplayPointCellFrame = param1;
            return;
        }// end function

        public function pushed() : Boolean
        {
            InventoryManager.getInstance();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var icapmsg:InventoryContentAndPresetMessage;
            var presetWrappers:Array;
            var icmsg:InventoryContentMessage;
            var oam:ObjectAddedMessage;
            var osam:ObjectsAddedMessage;
            var oqm:ObjectQuantityMessage;
            var osqm:ObjectsQuantityMessage;
            var kumsg:KamasUpdateMessage;
            var iwmsg:InventoryWeightMessage;
            var ommsg:ObjectMovementMessage;
            var sbcmsg:ShortcutBarContentMessage;
            var sCProperties:Object;
            var sbrmsg:ShortcutBarRefreshMessage;
            var inventoryMgr:InventoryManager;
            var sRProperties:Object;
            var sbrmmsg:ShortcutBarRemovedMessage;
            var sbara:ShortcutBarAddRequestAction;
            var sbarmsg:ShortcutBarAddRequestMessage;
            var swap:Boolean;
            var sbrra:ShortcutBarRemoveRequestAction;
            var sbrrmsg:ShortcutBarRemoveRequestMessage;
            var sbsra:ShortcutBarSwapRequestAction;
            var sbsrmsg:ShortcutBarSwapRequestMessage;
            var pspa:PresetSetPositionAction;
            var hiddenObjects:Vector.<ItemWrapper>;
            var presetItem:ItemWrapper;
            var ospa:ObjectSetPositionAction;
            var itw:ItemWrapper;
            var ospmsg2:ObjectSetPositionMessage;
            var omdmsg:ObjectModifiedMessage;
            var odmsg:ObjectDeletedMessage;
            var osdmsg:ObjectsDeletedMessage;
            var positions:Array;
            var doa:DeleteObjectAction;
            var odmsg2:ObjectDeleteMessage;
            var oua:ObjectUseAction;
            var iw:ItemWrapper;
            var commonMod:Object;
            var fncUseItem:Function;
            var nbFood:int;
            var nbBonus:int;
            var view:IInventoryView;
            var oda:ObjectDropAction;
            var itemItem:Item;
            var objectName:String;
            var ouocmsg:ObjectUseOnCellMessage;
            var ouoca:ObjectUseOnCellAction;
            var ipudmsg:InventoryPresetUpdateMessage;
            var newPW:PresetWrapper;
            var ipiumsg:InventoryPresetItemUpdateMessage;
            var ipda:InventoryPresetDeleteAction;
            var ipdmsg:InventoryPresetDeleteMessage;
            var ipdrmsg:InventoryPresetDeleteResultMessage;
            var ipsa:InventoryPresetSaveAction;
            var ipsmsg:InventoryPresetSaveMessage;
            var ipsrmsg:InventoryPresetSaveResultMessage;
            var ipua:InventoryPresetUseAction;
            var ipumsg:InventoryPresetUseMessage;
            var ipurmsg:InventoryPresetUseResultMessage;
            var ipira:InventoryPresetItemUpdateRequestAction;
            var ipiurmsg:InventoryPresetItemUpdateRequestMessage;
            var ipiremsg:InventoryPresetItemUpdateErrorMessage;
            var reason:String;
            var preset:Preset;
            var osait:ObjectItem;
            var shortcutQty:ShortcutWrapper;
            var objoqm:ObjectItemQuantity;
            var shortcutsQty:ShortcutWrapper;
            var shorto:Shortcut;
            var shorts:Shortcut;
            var shortcuti:ShortcutObjectItem;
            var shortcutp:ShortcutObjectPreset;
            var shortcutsm:ShortcutSmiley;
            var shortcute:ShortcutEmote;
            var shortcuts:ShortcutSpell;
            var realitem:ItemWrapper;
            var effect:EffectInstance;
            var ospmsg:ObjectSetPositionMessage;
            var osdit:uint;
            var t:ItemWrapper;
            var odropmsg:ObjectDropMessage;
            var shortcutipud:ShortcutWrapper;
            var reason1:String;
            var reason2:String;
            var reason3:String;
            var msg:* = param1;
            switch(true)
            {
                case msg is InventoryContentAndPresetMessage:
                {
                    icapmsg = msg as InventoryContentAndPresetMessage;
                    InventoryManager.getInstance().inventory.initializeFromObjectItems(icapmsg.objects);
                    InventoryManager.getInstance().inventory.kamas = icapmsg.kamas;
                    PlayedCharacterManager.getInstance().inventory = InventoryManager.getInstance().realInventory;
                    if (PlayedCharacterManager.getInstance().characteristics)
                    {
                        PlayedCharacterManager.getInstance().characteristics.kamas = icapmsg.kamas;
                    }
                    if (InventoryManager.getInstance().inventory && InventoryManager.getInstance().inventory.getView("equipment") && InventoryManager.getInstance().inventory.getView("equipment").content && InventoryManager.getInstance().inventory.getView("equipment").content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] && InventoryManager.getInstance().inventory.getView("equipment").content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].typeId == Inventory.PETSMOUNT_TYPE_ID)
                    {
                        PlayedCharacterManager.getInstance().isPetsMounting = true;
                    }
                    presetWrappers = new Array(8);
                    var _loc_3:int = 0;
                    var _loc_4:* = icapmsg.presets;
                    while (_loc_4 in _loc_3)
                    {
                        
                        preset = _loc_4[_loc_3];
                        presetWrappers[preset.presetId] = PresetWrapper.create(preset.presetId, preset.symbolId, preset.objects, preset.mount);
                    }
                    InventoryManager.getInstance().presets = presetWrappers;
                    return true;
                }
                case msg is InventoryContentMessage:
                {
                    if (getQualifiedClassName(msg) != getQualifiedClassName(InventoryContentMessage))
                    {
                        return false;
                    }
                    icmsg = msg as InventoryContentMessage;
                    InventoryManager.getInstance().inventory.initializeFromObjectItems(icmsg.objects);
                    InventoryManager.getInstance().inventory.kamas = icmsg.kamas;
                    if (InventoryManager.getInstance().inventory && InventoryManager.getInstance().inventory.getView("equipment") && InventoryManager.getInstance().inventory.getView("equipment").content && InventoryManager.getInstance().inventory.getView("equipment").content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] && InventoryManager.getInstance().inventory.getView("equipment").content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].typeId == Inventory.PETSMOUNT_TYPE_ID)
                    {
                        PlayedCharacterManager.getInstance().isPetsMounting = true;
                    }
                    PlayedCharacterManager.getInstance().inventory = InventoryManager.getInstance().realInventory;
                    if (PlayedCharacterManager.getInstance().characteristics)
                    {
                        PlayedCharacterManager.getInstance().characteristics.kamas = icmsg.kamas;
                    }
                    InventoryManager.getInstance().presets = new Array(8);
                    return true;
                }
                case msg is ObjectAddedMessage:
                {
                    oam = msg as ObjectAddedMessage;
                    InventoryManager.getInstance().inventory.addObjectItem(oam.object);
                    return true;
                }
                case msg is ObjectsAddedMessage:
                {
                    osam = msg as ObjectsAddedMessage;
                    var _loc_3:int = 0;
                    var _loc_4:* = osam.object;
                    while (_loc_4 in _loc_3)
                    {
                        
                        osait = _loc_4[_loc_3];
                        InventoryManager.getInstance().inventory.addObjectItem(osait);
                    }
                    return true;
                }
                case msg is ObjectQuantityMessage:
                {
                    oqm = msg as ObjectQuantityMessage;
                    if (this._objectUIDToDrop == oqm.objectUID)
                    {
                        this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                        this._objectUIDToDrop = -1;
                    }
                    InventoryManager.getInstance().inventory.modifyItemQuantity(oqm.objectUID, oqm.quantity);
                    var _loc_3:int = 0;
                    var _loc_4:* = InventoryManager.getInstance().shortcutBarItems;
                    while (_loc_4 in _loc_3)
                    {
                        
                        shortcutQty = _loc_4[_loc_3];
                        if (shortcutQty && shortcutQty.id == oqm.objectUID)
                        {
                            shortcutQty.quantity = oqm.quantity;
                            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                        }
                    }
                    return true;
                }
                case msg is ObjectsQuantityMessage:
                {
                    osqm = msg as ObjectsQuantityMessage;
                    var _loc_3:int = 0;
                    var _loc_4:* = osqm.objectsUIDAndQty;
                    while (_loc_4 in _loc_3)
                    {
                        
                        objoqm = _loc_4[_loc_3];
                        InventoryManager.getInstance().inventory.modifyItemQuantity(objoqm.objectUID, objoqm.quantity);
                        var _loc_5:int = 0;
                        var _loc_6:* = InventoryManager.getInstance().shortcutBarItems;
                        while (_loc_6 in _loc_5)
                        {
                            
                            shortcutsQty = _loc_6[_loc_5];
                            if (shortcutsQty && shortcutsQty.id == objoqm.objectUID)
                            {
                                shortcutsQty.quantity = objoqm.quantity;
                            }
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 0);
                    return true;
                }
                case msg is KamasUpdateMessage:
                {
                    kumsg = msg as KamasUpdateMessage;
                    InventoryManager.getInstance().inventory.kamas = kumsg.kamasTotal;
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.KamasUpdate, kumsg.kamasTotal);
                    return true;
                }
                case msg is InventoryWeightMessage:
                {
                    iwmsg = msg as InventoryWeightMessage;
                    PlayedCharacterManager.getInstance().inventoryWeight = iwmsg.weight;
                    PlayedCharacterManager.getInstance().inventoryWeightMax = iwmsg.weightMax;
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.InventoryWeight, iwmsg.weight, iwmsg.weightMax);
                    InventoryManager.getInstance().inventory.releaseHooks();
                    return true;
                }
                case msg is ObjectMovementMessage:
                {
                    ommsg = msg as ObjectMovementMessage;
                    InventoryManager.getInstance().inventory.modifyItemPosition(ommsg.objectUID, ommsg.position);
                    return true;
                }
                case msg is ShortcutBarContentMessage:
                {
                    sbcmsg = msg as ShortcutBarContentMessage;
                    if (sbcmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
                    {
                        InventoryManager.getInstance().shortcutBarItems = new Array();
                        var _loc_3:int = 0;
                        var _loc_4:* = sbcmsg.shortcuts;
                        while (_loc_4 in _loc_3)
                        {
                            
                            shorto = _loc_4[_loc_3];
                            sCProperties = this.getShortcutWrapperPropFromShortcut(shorto);
                            InventoryManager.getInstance().shortcutBarItems[shorto.slot] = ShortcutWrapper.create(shorto.slot, sCProperties.id, sCProperties.type, sCProperties.gid);
                        }
                    }
                    else if (sbcmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                    {
                        InventoryManager.getInstance().shortcutBarSpells = new Array();
                        var _loc_3:int = 0;
                        var _loc_4:* = sbcmsg.shortcuts;
                        while (_loc_4 in _loc_3)
                        {
                            
                            shorts = _loc_4[_loc_3];
                            sCProperties = this.getShortcutWrapperPropFromShortcut(shorts);
                            InventoryManager.getInstance().shortcutBarSpells[shorts.slot] = ShortcutWrapper.create(shorts.slot, sCProperties.id, sCProperties.type, sCProperties.gid);
                        }
                        if (PlayedCharacterManager.getInstance().spellsInventory == PlayedCharacterManager.getInstance().playerSpellList)
                        {
                            PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, sbcmsg.barType);
                    return true;
                }
                case msg is ShortcutBarRefreshMessage:
                {
                    sbrmsg = msg as ShortcutBarRefreshMessage;
                    inventoryMgr = InventoryManager.getInstance();
                    sRProperties = this.getShortcutWrapperPropFromShortcut(sbrmsg.shortcut);
                    if (sbrmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
                    {
                        if (inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot])
                        {
                            inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot, sRProperties.id, sRProperties.type, sRProperties.gid);
                        }
                        else
                        {
                            inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot, sRProperties.id, sRProperties.type, sRProperties.gid);
                        }
                    }
                    else if (sbrmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                    {
                        if (inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot])
                        {
                            inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot, sRProperties.id, sRProperties.type, sRProperties.gid);
                        }
                        else
                        {
                            inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot, sRProperties.id, sRProperties.type, sRProperties.gid);
                        }
                        if (PlayedCharacterManager.getInstance().spellsInventory == PlayedCharacterManager.getInstance().playerSpellList)
                        {
                            PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, sbrmsg.barType);
                    return true;
                }
                case msg is ShortcutBarRemovedMessage:
                {
                    sbrmmsg = msg as ShortcutBarRemovedMessage;
                    if (sbrmmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
                    {
                        InventoryManager.getInstance().shortcutBarItems[sbrmmsg.slot] = null;
                    }
                    else if (sbrmmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
                    {
                        InventoryManager.getInstance().shortcutBarSpells[sbrmmsg.slot] = null;
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, sbrmmsg.barType);
                    return true;
                }
                case msg is ShortcutBarAddRequestAction:
                {
                    sbara = msg as ShortcutBarAddRequestAction;
                    sbarmsg = new ShortcutBarAddRequestMessage();
                    swap;
                    if (sbara.barType == 0)
                    {
                        shortcuti = new ShortcutObjectItem();
                        shortcuti.itemUID = sbara.id;
                        shortcuti.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(sbara.barType, shortcuti);
                    }
                    else if (sbara.barType == 1)
                    {
                        shortcutp = new ShortcutObjectPreset();
                        shortcutp.presetId = sbara.id;
                        shortcutp.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(0, shortcutp);
                    }
                    else if (sbara.barType == 3)
                    {
                        shortcutsm = new ShortcutSmiley();
                        shortcutsm.smileyId = sbara.id;
                        shortcutsm.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(0, shortcutsm);
                    }
                    else if (sbara.barType == 4)
                    {
                        shortcute = new ShortcutEmote();
                        shortcute.emoteId = sbara.id;
                        shortcute.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(0, shortcute);
                    }
                    else if (sbara.barType == 2)
                    {
                        shortcuts = new ShortcutSpell();
                        shortcuts.spellId = sbara.id;
                        shortcuts.slot = sbara.slot;
                        sbarmsg.initShortcutBarAddRequestMessage(1, shortcuts);
                    }
                    ConnectionsHandler.getConnection().send(sbarmsg);
                    return true;
                }
                case msg is ShortcutBarRemoveRequestAction:
                {
                    sbrra = msg as ShortcutBarRemoveRequestAction;
                    sbrrmsg = new ShortcutBarRemoveRequestMessage();
                    sbrrmsg.initShortcutBarRemoveRequestMessage(sbrra.barType, sbrra.slot);
                    ConnectionsHandler.getConnection().send(sbrrmsg);
                    return true;
                }
                case msg is ShortcutBarSwapRequestAction:
                {
                    sbsra = msg as ShortcutBarSwapRequestAction;
                    sbsrmsg = new ShortcutBarSwapRequestMessage();
                    sbsrmsg.initShortcutBarSwapRequestMessage(sbsra.barType, sbsra.firstSlot, sbsra.secondSlot);
                    ConnectionsHandler.getConnection().send(sbsrmsg);
                    return true;
                }
                case msg is PresetSetPositionAction:
                {
                    pspa = msg as PresetSetPositionAction;
                    hiddenObjects = new Vector.<ItemWrapper>;
                    var _loc_3:int = 0;
                    var _loc_4:* = InventoryManager.getInstance().inventory.getView("real").content;
                    while (_loc_4 in _loc_3)
                    {
                        
                        realitem = _loc_4[_loc_3];
                        if (Item.getItemById(realitem.objectGID).typeId == Inventory.HIDDEN_TYPE_ID)
                        {
                            hiddenObjects.push(realitem);
                            if (realitem.effects && realitem.effects.length)
                            {
                                var _loc_5:int = 0;
                                var _loc_6:* = realitem.effects;
                                while (_loc_6 in _loc_5)
                                {
                                    
                                    effect = _loc_6[_loc_5];
                                    if (effect.effectId == 707)
                                    {
                                        if ((int(effect.parameter2) - 1) == pspa.presetId)
                                        {
                                            presetItem = realitem;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (presetItem)
                    {
                        this._movingObjectUID = presetItem.objectUID;
                        this._movingObjectPreviousPosition = 0;
                        ospmsg = new ObjectSetPositionMessage();
                        ospmsg.initObjectSetPositionMessage(presetItem.objectUID, pspa.position, 1);
                        ConnectionsHandler.getConnection().send(ospmsg);
                    }
                    return true;
                }
                case msg is ObjectSetPositionAction:
                {
                    ospa = msg as ObjectSetPositionAction;
                    itw = InventoryManager.getInstance().inventory.getItem(ospa.objectUID);
                    this._movingObjectUID = ospa.objectUID;
                    if (!itw)
                    {
                        this._movingObjectPreviousPosition = 8;
                    }
                    else
                    {
                        this._movingObjectPreviousPosition = itw.position;
                    }
                    ospmsg2 = new ObjectSetPositionMessage();
                    ospmsg2.initObjectSetPositionMessage(ospa.objectUID, ospa.position, ospa.quantity);
                    ConnectionsHandler.getConnection().send(ospmsg2);
                    return true;
                }
                case msg is ObjectModifiedMessage:
                {
                    omdmsg = msg as ObjectModifiedMessage;
                    InventoryManager.getInstance().inventory.modifyObjectItem(omdmsg.object);
                    return true;
                }
                case msg is ObjectDeletedMessage:
                {
                    odmsg = msg as ObjectDeletedMessage;
                    if (this._objectUIDToDrop == odmsg.objectUID)
                    {
                        this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                        this._objectUIDToDrop = -1;
                    }
                    InventoryManager.getInstance().inventory.removeItem(odmsg.objectUID, -1);
                    return true;
                }
                case msg is ObjectsDeletedMessage:
                {
                    osdmsg = msg as ObjectsDeletedMessage;
                    positions = new Array();
                    var _loc_3:int = 0;
                    var _loc_4:* = osdmsg.objectUID;
                    while (_loc_4 in _loc_3)
                    {
                        
                        osdit = _loc_4[_loc_3];
                        InventoryManager.getInstance().inventory.removeItem(osdit, -1);
                    }
                    return true;
                }
                case msg is DeleteObjectAction:
                {
                    doa = msg as DeleteObjectAction;
                    odmsg2 = new ObjectDeleteMessage();
                    odmsg2.initObjectDeleteMessage(doa.objectUID, doa.quantity);
                    ConnectionsHandler.getConnection().send(odmsg2);
                    return true;
                }
                case msg is ObjectUseAction:
                {
                    oua = msg as ObjectUseAction;
                    iw = InventoryManager.getInstance().inventory.getItem(oua.objectUID);
                    if (!iw)
                    {
                        _log.error("Impossible de retrouver l\'objet d\'UID " + oua.objectUID);
                        return true;
                    }
                    if (!iw.usable && !iw.targetable)
                    {
                        _log.error("L\'objet " + iw.name + " n\'est pas utilisable.");
                        return true;
                    }
                    commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    fncUseItem = function () : void
            {
                useItem(oua, iw);
                return;
            }// end function
            ;
                    nbFood;
                    nbBonus;
                    view = InventoryManager.getInstance().inventory.getView("roleplayBuff");
                    var _loc_3:int = 0;
                    var _loc_4:* = view.content;
                    while (_loc_4 in _loc_3)
                    {
                        
                        t = _loc_4[_loc_3];
                        switch(t.position)
                        {
                            case CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD:
                            {
                                if (t.objectGID != iw.objectGID)
                                {
                                    nbFood = (nbFood + 1);
                                }
                                break;
                            }
                            case CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS:
                            case CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS:
                            {
                                nbBonus = (nbBonus + 1);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    if (iw.type.needUseConfirm)
                    {
                        commonMod.openPopup(I18n.getUiText("ui.common.confirm"), I18n.getUiText("ui.common.confirmationUseItem", [iw.name]), [I18n.getUiText("ui.common.yes"), I18n.getUiText("ui.common.no")], [fncUseItem, null], fncUseItem, function () : void
            {
                return;
            }// end function
            );
                    }
                    else
                    {
                        this.useItem(oua, iw);
                    }
                    return true;
                }
                case msg is ObjectDropAction:
                {
                    oda = msg as ObjectDropAction;
                    if (Kernel.getWorker().contains(FightContextFrame))
                    {
                        return true;
                    }
                    this._objectUIDToDrop = oda.objectUID;
                    this._objectGIDToDrop = oda.objectGID;
                    this._quantityToDrop = oda.quantity;
                    commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    itemItem = Item.getItemById(oda.objectGID);
                    objectName = itemItem.name;
                    if (Dofus.getInstance().options.confirmItemDrop)
                    {
                        commonMod.openPopup(I18n.getUiText("ui.common.confirm"), I18n.getUiText("ui.common.confirmationDropItem", [oda.quantity, objectName]), [I18n.getUiText("ui.common.yes"), I18n.getUiText("ui.common.no")], [this.onAcceptDrop, this.onRefuseDrop], this.onAcceptDrop, this.onRefuseDrop);
                    }
                    else
                    {
                        odropmsg = new ObjectDropMessage();
                        odropmsg.initObjectDropMessage(this._objectUIDToDrop, this._quantityToDrop);
                        ConnectionsHandler.getConnection().send(odropmsg);
                    }
                    return true;
                }
                case msg is ObjectUseOnCellAction:
                {
                    ouocmsg = new ObjectUseOnCellMessage();
                    ouoca = msg as ObjectUseOnCellAction;
                    ouocmsg.initObjectUseOnCellMessage(ouoca.objectUID, ouoca.targetedCell);
                    ConnectionsHandler.getConnection().send(ouocmsg);
                    break;
                }
                case msg is InventoryPresetUpdateMessage:
                {
                    ipudmsg = msg as InventoryPresetUpdateMessage;
                    newPW = PresetWrapper.create(ipudmsg.preset.presetId, ipudmsg.preset.symbolId, ipudmsg.preset.objects, ipudmsg.preset.mount);
                    InventoryManager.getInstance().presets[ipudmsg.preset.presetId] = newPW;
                    var _loc_3:int = 0;
                    var _loc_4:* = InventoryManager.getInstance().shortcutBarItems;
                    while (_loc_4 in _loc_3)
                    {
                        
                        shortcutipud = _loc_4[_loc_3];
                        if (shortcutipud && shortcutipud.realItem is PresetWrapper && (shortcutipud.realItem as PresetWrapper).id == ipudmsg.preset.presetId)
                        {
                            shortcutipud.update(shortcutipud.slot, shortcutipud.id, shortcutipud.type, shortcutipud.gid);
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                    return true;
                }
                case msg is InventoryPresetItemUpdateMessage:
                {
                    ipiumsg = msg as InventoryPresetItemUpdateMessage;
                    InventoryManager.getInstance().presets[ipiumsg.presetId].updateObject(ipiumsg.presetItem);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                    return true;
                }
                case msg is InventoryPresetDeleteAction:
                {
                    ipda = msg as InventoryPresetDeleteAction;
                    ipdmsg = new InventoryPresetDeleteMessage();
                    ipdmsg.initInventoryPresetDeleteMessage(ipda.presetId);
                    ConnectionsHandler.getConnection().send(ipdmsg);
                    return true;
                }
                case msg is InventoryPresetDeleteResultMessage:
                {
                    ipdrmsg = msg as InventoryPresetDeleteResultMessage;
                    if (ipdrmsg.code == PresetDeleteResultEnum.PRESET_DEL_OK)
                    {
                        InventoryManager.getInstance().presets[ipdrmsg.presetId] = null;
                        KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                        KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetSelected, -1);
                    }
                    else
                    {
                        switch(ipdrmsg.code)
                        {
                            case PresetDeleteResultEnum.PRESET_DEL_ERR_UNKNOWN:
                            {
                                reason1;
                                break;
                            }
                            case PresetDeleteResultEnum.PRESET_DEL_ERR_BAD_PRESET_ID:
                            {
                                reason1;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError, reason1);
                    }
                    return true;
                }
                case msg is InventoryPresetSaveAction:
                {
                    ipsa = msg as InventoryPresetSaveAction;
                    ipsmsg = new InventoryPresetSaveMessage();
                    ipsmsg.initInventoryPresetSaveMessage(ipsa.presetId, ipsa.symbolId, ipsa.saveEquipment);
                    ConnectionsHandler.getConnection().send(ipsmsg);
                    return true;
                }
                case msg is InventoryPresetSaveResultMessage:
                {
                    ipsrmsg = msg as InventoryPresetSaveResultMessage;
                    switch(ipsrmsg.code)
                    {
                        case PresetSaveResultEnum.PRESET_SAVE_ERR_UNKNOWN:
                        {
                            break;
                        }
                        case PresetSaveResultEnum.PRESET_SAVE_ERR_TOO_MANY:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case msg is InventoryPresetUseAction:
                {
                    ipua = msg as InventoryPresetUseAction;
                    ipumsg = new InventoryPresetUseMessage();
                    ipumsg.initInventoryPresetUseMessage(ipua.presetId);
                    ConnectionsHandler.getConnection().send(ipumsg);
                    return true;
                }
                case msg is InventoryPresetUseResultMessage:
                {
                    ipurmsg = msg as InventoryPresetUseResultMessage;
                    if (ipurmsg.code != PresetUseResultEnum.PRESET_USE_OK)
                    {
                        switch(ipurmsg.code)
                        {
                            case PresetUseResultEnum.PRESET_USE_ERR_UNKNOWN:
                            {
                                reason3;
                                break;
                            }
                            case PresetUseResultEnum.PRESET_USE_ERR_BAD_PRESET_ID:
                            {
                                reason3;
                                break;
                            }
                            case PresetUseResultEnum.PRESET_USE_ERR_CRITERION:
                            {
                                reason3;
                                break;
                            }
                            case PresetUseResultEnum.PRESET_USE_OK_PARTIAL:
                            {
                                reason3;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError, reason3);
                    }
                    return true;
                }
                case msg is InventoryPresetItemUpdateRequestAction:
                {
                    ipira = msg as InventoryPresetItemUpdateRequestAction;
                    ipiurmsg = new InventoryPresetItemUpdateRequestMessage();
                    ipiurmsg.initInventoryPresetItemUpdateRequestMessage(ipira.presetId, ipira.position, ipira.objUid);
                    ConnectionsHandler.getConnection().send(ipiurmsg);
                    return true;
                }
                case msg is InventoryPresetItemUpdateErrorMessage:
                {
                    ipiremsg = msg as InventoryPresetItemUpdateErrorMessage;
                    switch(ipiremsg.code)
                    {
                        case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_UNKNOWN:
                        {
                            reason;
                            break;
                        }
                        case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_PRESET_ID:
                        {
                            reason;
                            break;
                        }
                        case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_OBJECT_ID:
                        {
                            reason;
                            break;
                        }
                        case PresetSaveUpdateErrorEnum.PRESET_UPDATE_ERR_BAD_POSITION:
                        {
                            reason;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError, reason);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function onAcceptDrop() : void
        {
            var _loc_1:* = new ObjectDropMessage();
            _loc_1.initObjectDropMessage(this._objectUIDToDrop, this._quantityToDrop);
            if (!PlayedCharacterManager.getInstance().isFighting)
            {
                ConnectionsHandler.getConnection().send(_loc_1);
            }
            return;
        }// end function

        public function onRefuseDrop() : void
        {
            return;
        }// end function

        private function onCellPointed(param1:Boolean, param2:uint, param3:int) : void
        {
            var _loc_4:ObjectUseOnCellMessage = null;
            var _loc_5:ObjectUseOnCharacterMessage = null;
            if (param1)
            {
                if (param3 < 0)
                {
                    _loc_4 = new ObjectUseOnCellMessage();
                    _loc_4.initObjectUseOnCellMessage(this._currentPointUseUIDObject, param2);
                    ConnectionsHandler.getConnection().send(_loc_4);
                }
                else
                {
                    _loc_5 = new ObjectUseOnCharacterMessage();
                    _loc_5.initObjectUseOnCharacterMessage(this._currentPointUseUIDObject, param3);
                    ConnectionsHandler.getConnection().send(_loc_5);
                }
                this._currentPointUseUIDObject = 0;
            }
            return;
        }// end function

        private function useItem(param1:ObjectUseAction, param2:ItemWrapper) : void
        {
            var _loc_3:Texture = null;
            var _loc_4:ObjectUseMultipleMessage = null;
            var _loc_5:ObjectUseMessage = null;
            if (this._roleplayPointCellFrame && this._roleplayPointCellFrame.object && param1.objectUID == this._currentPointUseUIDObject)
            {
                Kernel.getWorker().removeFrame(this._roleplayPointCellFrame.object as RoleplayPointCellFrame);
                this._roleplayPointCellFrame = null;
            }
            if (param1.useOnCell && param2.targetable)
            {
                if (!Kernel.getWorker().getFrame(FightContextFrame))
                {
                    this._currentPointUseUIDObject = param1.objectUID;
                    _loc_3 = new Texture();
                    _loc_3.uri = param2.iconUri;
                    _loc_3.finalize();
                    if (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame)
                    {
                        this._roleplayPointCellFrame = new WeakReference(new RoleplayPointCellFrame(this.onCellPointed, _loc_3));
                        Kernel.getWorker().addFrame(this._roleplayPointCellFrame.object as Frame);
                    }
                }
            }
            else if (param1.quantity > 1)
            {
                _loc_4 = new ObjectUseMultipleMessage();
                _loc_4.initObjectUseMultipleMessage(param1.objectUID, param1.quantity);
                ConnectionsHandler.getConnection().send(_loc_4);
            }
            else
            {
                _loc_5 = new ObjectUseMessage();
                _loc_5.initObjectUseMessage(param1.objectUID);
                ConnectionsHandler.getConnection().send(_loc_5);
            }
            return;
        }// end function

        private function addObject(param1:ObjectItem) : void
        {
            InventoryManager.getInstance().inventory.addObjectItem(param1);
            return;
        }// end function

        private function getShortcutWrapperPropFromShortcut(param1:Object) : Object
        {
            var _loc_2:uint = 0;
            var _loc_4:uint = 0;
            var _loc_3:uint = 0;
            if (param1 is ShortcutObjectItem)
            {
                _loc_2 = (param1 as ShortcutObjectItem).itemUID;
                _loc_3 = (param1 as ShortcutObjectItem).itemGID;
                _loc_4 = 0;
            }
            else if (param1 is ShortcutObjectPreset)
            {
                _loc_2 = (param1 as ShortcutObjectPreset).presetId;
                _loc_4 = 1;
            }
            else if (param1 is ShortcutEmote)
            {
                _loc_2 = (param1 as ShortcutEmote).emoteId;
                _loc_4 = 4;
            }
            else if (param1 is ShortcutSmiley)
            {
                _loc_2 = (param1 as ShortcutSmiley).smileyId;
                _loc_4 = 3;
            }
            else if (param1 is ShortcutSpell)
            {
                _loc_2 = (param1 as ShortcutSpell).spellId;
                _loc_4 = 2;
            }
            return {id:_loc_2, gid:_loc_3, type:_loc_4};
        }// end function

    }
}
