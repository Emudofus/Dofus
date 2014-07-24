package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.JobsApi;
   import d2api.ContextMenuApi;
   import d2api.SoundApi;
   import d2api.StorageApi;
   import flash.utils.Timer;
   import d2components.GraphicContainer;
   import d2components.EntityDisplayer;
   import d2components.Label;
   import d2components.Slot;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import flash.events.TimerEvent;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   
   public class SmithMagic extends Object
   {
      
      public function SmithMagic() {
         super();
      }
      
      public static const TOOLTIP_SMITH_MAGIC:String = "tooltipSmithMagic";
      
      public static const CRAFT_IMPOSSIBLE:int = 0;
      
      public static const CRAFT_FAILED:int = 1;
      
      public static const CRAFT_SUCCESS:int = 2;
      
      public static const CRAFT_NEARLY_SUCCESS:int = 3;
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      private static const SKILL_TYPE_AMULET:int = 169;
      
      private static const SKILL_TYPE_RING:int = 168;
      
      private static const SKILL_TYPE_BELT:int = 164;
      
      private static const SKILL_TYPE_BOOTS:int = 163;
      
      private static const SKILL_TYPE_HAT:int = 166;
      
      private static const SKILL_TYPE_CLOAK:int = 165;
      
      private static const SKILL_TYPE_BAG:int = 167;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var jobsApi:JobsApi;
      
      public var menuApi:ContextMenuApi;
      
      public var soundApi:SoundApi;
      
      public var storageApi:StorageApi;
      
      protected var _skill:Object;
      
      protected var _job;
      
      protected var _skillLevel:int;
      
      protected var _refill_item:Object = null;
      
      protected var _refill_qty:int;
      
      protected var _lastScrollbarValue:int;
      
      protected var _showDamages:Boolean = true;
      
      protected var _waitingObject:Object;
      
      protected var _waitingSlot:Object;
      
      protected var _altClickedSlot:Object;
      
      protected var _multiCraft:Boolean;
      
      protected var _isRepair:Boolean;
      
      protected var _keepScrollbar:Boolean;
      
      private var _mergeButtonTimer:Timer;
      
      private var _mergeButtonTimerOut:Boolean;
      
      private var _mergeResultGot:Boolean;
      
      public var ctn_slots:GraphicContainer;
      
      public var objectCtr:GraphicContainer;
      
      public var ctr_item:GraphicContainer;
      
      public var ctn_arrow:GraphicContainer;
      
      public var ed_playedCharacter:EntityDisplayer;
      
      public var lbl_title:Label;
      
      public var slot_item:Slot;
      
      public var slot_rune:Slot;
      
      public var slot_sign:Slot;
      
      public var btn_mergeAll:ButtonContainer;
      
      public var btn_mergeOnce:ButtonContainer;
      
      public var btn_stop:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public function main(args:Object) : void {
         var slot:Slot = null;
         var jobExperience:Object = null;
         this.btn_mergeAll.soundId = SoundEnum.OK_BUTTON;
         this.btn_mergeOnce.soundId = SoundEnum.OK_BUTTON;
         this.sysApi.disableWorldInteraction();
         this.sysApi.addHook(ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(DropStart,this.onDropStart);
         this.sysApi.addHook(DropEnd,this.onDropEnd);
         this.sysApi.addHook(ExchangeCraftResult,this.onExchangeCraftResult);
         this.sysApi.addHook(ExchangeItemAutoCraftStoped,this.onExchangeItemAutoCraftStoped);
         this.sysApi.addHook(DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(MouseCtrlDoubleClick,this.onMouseCtrlDoubleClick);
         this.sysApi.addHook(MouseAltDoubleClick,this.onMouseAltDoubleClick);
         this.sysApi.addHook(UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(ObjectModified,this.onObjectModified);
         this.sysApi.addHook(ObjectSelected,this.onObjectSelected);
         this.uiApi.addComponentHook(this.ed_playedCharacter,"onRelease");
         this.uiApi.addComponentHook(this.ed_playedCharacter,"onRightClick");
         this.ed_playedCharacter.mouseEnabled = true;
         this.ed_playedCharacter.handCursor = true;
         this.ctn_arrow.visible = false;
         this.objectCtr.visible = false;
         this._skill = this.jobsApi.getSkillFromId(args.skillId);
         this._job = this._skill.parentJob;
         this._isRepair = this._skill.isRepair;
         if((args.crafterInfos) && (!(args.crafterInfos.id == this.playerApi.id())))
         {
            this._skillLevel = args.crafterInfos.skillLevel;
         }
         else
         {
            jobExperience = this.jobsApi.getJobExperience(this._job);
            this._skillLevel = jobExperience.currentLevel;
         }
         this.lbl_title.text = this._skill.name;
         this.setMergeButtonDisabled(true);
         this.btn_stop.disabled = true;
         this.createSlots();
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            slot.dropValidator = this.dropValidatorFunction as Function;
            slot.processDrop = this.processDropFunction as Function;
            this.uiApi.addComponentHook(slot,"onRollOver");
            this.uiApi.addComponentHook(slot,"onRollOut");
            this.uiApi.addComponentHook(slot,"onDoubleClick");
            this.uiApi.addComponentHook(slot,"onRightClick");
            this.uiApi.addComponentHook(slot,"onRelease");
         }
         this.ed_playedCharacter.look = this.playerApi.getPlayedCharacterInfo().entityLook;
         this.ed_playedCharacter.yOffset = 30;
         this.ed_playedCharacter.scale = 1.3;
         this.ed_playedCharacter.direction = 3;
         this._mergeButtonTimer = new Timer(400,1);
         this._mergeButtonTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onMergeButtonTimer);
         this._mergeButtonTimerOut = false;
         this._mergeResultGot = false;
      }
      
      public function unload() : void {
         this.sysApi.enableWorldInteraction();
         this._mergeButtonTimer.stop();
         this._mergeButtonTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onMergeButtonTimer);
         this.uiApi.unloadUi("itemBoxSmith");
         this.storageApi.removeAllItemMasks("smithMagic");
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new LeaveDialogRequest());
         this.sysApi.sendAction(new CloseInventory());
      }
      
      public function unfillSelectedSlot(qty:int) : void {
         this.unfillSlot(this._waitingSlot,qty);
      }
      
      public function fillDefaultSlot(item:Object, qty:int = -1) : void {
         var slot:Object = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.dropValidatorFunction(slot,item,null))
            {
               if(qty == -1)
               {
                  switch(slot)
                  {
                     case this.slot_item:
                     case this.slot_sign:
                        qty = 1;
                        break;
                     case this.slot_rune:
                        qty = item.quantity;
                        break;
                  }
               }
               this.fillSlot(slot,item,qty);
               return;
            }
         }
      }
      
      public function getMatchingSlot(item:Object) : Object {
         var slot:Object = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.isValidSlot(slot,item))
            {
               return slot;
            }
         }
         return null;
      }
      
      public function getMatchingSlotFromUID(itemUID:int) : Object {
         var slot:Object = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if((slot.data) && (slot.data.objectUID == itemUID))
            {
               return slot;
            }
         }
         return null;
      }
      
      protected function createSlots() : void {
         this.slot_item = this.uiApi.createComponent("Slot") as Slot;
         this.slot_rune = this.uiApi.createComponent("Slot") as Slot;
         this.slot_sign = this.uiApi.createComponent("Slot") as Slot;
         this.slot_item.width = this.slot_rune.width = this.slot_sign.width = 45;
         this.slot_item.height = this.slot_rune.height = this.slot_sign.height = 45;
         this.slot_item.highlightTexture = this.slot_rune.highlightTexture = this.slot_sign.highlightTexture = this.uiApi.createUri(this.uiApi.me().getConstant("over_uri"));
         this.slot_item.selectedTexture = this.slot_rune.selectedTexture = this.slot_sign.selectedTexture = this.uiApi.createUri(this.uiApi.me().getConstant("selected_uri"));
         this.slot_item.acceptDragTexture = this.slot_rune.acceptDragTexture = this.slot_sign.acceptDragTexture = this.uiApi.createUri(this.uiApi.me().getConstant("acceptDrop_uri"));
         this.slot_item.refuseDragTexture = this.slot_rune.refuseDragTexture = this.slot_sign.refuseDragTexture = this.uiApi.createUri(this.uiApi.me().getConstant("refuseDrop_uri"));
         this.slot_item.y = 0;
         this.slot_rune.y = 0;
         this.slot_sign.y = 0;
         this.slot_item.name = "slot_item";
         this.slot_rune.name = "slot_rune";
         this.slot_sign.name = "slot_sign";
         if(this._isRepair == true)
         {
            this.slot_item.x = 30;
            this.slot_rune.x = 89;
            this.slot_sign.x = 117;
            this.slot_item.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + this.pictoNameFromSkillId(this._skill.id));
            this.slot_rune.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "reparation_tx_pictoPotion");
            this.slot_sign.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "craftSolo_tx_SlotVerrouille");
            this.slot_sign.visible = false;
         }
         else
         {
            this.slot_item.x = 0;
            this.slot_rune.x = 59;
            this.slot_sign.x = 117;
            this.slot_item.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + this.pictoNameFromSkillId(this._skill.id));
            this.slot_rune.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Forgemagie_tx_slot2");
            if(this._skillLevel < 100)
            {
               this.slot_sign.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "craftSolo_tx_SlotVerrouille");
            }
            else
            {
               this.slot_sign.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "craft_tx_slotSignature");
            }
         }
         this.slot_item.css = this.slot_rune.css = this.slot_sign.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "normal.css");
         this.slot_item.finalize();
         this.slot_rune.finalize();
         this.slot_sign.finalize();
         this.ctn_slots.addChild(this.slot_item);
         this.ctn_slots.addChild(this.slot_rune);
         this.ctn_slots.addChild(this.slot_sign);
      }
      
      protected function pictoNameFromSkillId(skillId:int) : String {
         switch(skillId)
         {
            case SKILL_TYPE_AMULET:
               return "tx_slotItem0";
            case SKILL_TYPE_RING:
               return "tx_slotItem2";
            case SKILL_TYPE_BELT:
               return "tx_slotItem3";
            case SKILL_TYPE_BOOTS:
               return "tx_slotItem5";
            case SKILL_TYPE_HAT:
               return "tx_slotItem6";
            case SKILL_TYPE_CLOAK:
            case SKILL_TYPE_BAG:
               return "tx_slotItem7";
            default:
               return "tx_slotItem1";
         }
      }
      
      protected function displayItem(item:Object, keepScrollbar:Boolean = false, showDamages:Boolean = true) : void {
         var object:Object = this.dataApi.getItem(item.objectGID);
         this.modCommon.createItemBox("itemBoxSmith",this.ctr_item,item);
         this.ctn_arrow.visible = true;
         this.objectCtr.visible = true;
      }
      
      protected function onUiLoaded(name:String) : void {
      }
      
      protected function onObjectModified(item:Object) : void {
      }
      
      protected function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean {
         return this.isValidSlot(target,data);
      }
      
      protected function isValidSlot(target:Object, d:Object) : Boolean {
         if(!this._skill)
         {
            return false;
         }
         var item:Object = this.dataApi.getItem(d.objectGID);
         switch(target)
         {
            case this.slot_item:
               if(this._skill.modifiableItemType != item.typeId)
               {
                  return false;
               }
               return true;
            case this.slot_rune:
               if(((!this._skill.isForgemagus) || (!(item.typeId == SMITHMAGIC_RUNE_ID))) && (!(item.typeId == SMITHMAGIC_POTION_ID)))
               {
                  return false;
               }
               return true;
            case this.slot_sign:
               if((!this.slot_sign.visible) || (!(item.id == SIGNATURE_RUNE_ID)))
               {
                  return false;
               }
               return true;
            default:
               return false;
         }
      }
      
      protected function processDropFunction(target:Object, d:Object, source:Object) : void {
         if(this.dropValidatorFunction(target,d,source))
         {
            switch(target)
            {
               case this.slot_item:
               case this.slot_sign:
                  this.fillSlot(target,d,1);
                  break;
               case this.slot_rune:
                  if(d.info1 > 1)
                  {
                     this._waitingObject = d;
                     this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDropToSlot);
                  }
                  else
                  {
                     this.fillSlot(this.slot_rune,d,1);
                  }
                  break;
            }
         }
      }
      
      protected function onValidQtyDropToSlot(qty:Number) : void {
         this.fillDefaultSlot(this._waitingObject,qty);
      }
      
      protected function onValidQtyDropToInventory(qty:Number) : void {
         this.unfillSelectedSlot(qty);
      }
      
      protected function fillSlot(slot:Object, item:Object, qty:int) : void {
         if((!(slot.data == null)) && ((slot == this.slot_item) || (slot == this.slot_sign) || (slot == this.slot_rune) && (!(slot.data.objectGID == item.objectGID))))
         {
            this.unfillSlot(slot,-1);
            this._refill_item = item;
            this._refill_qty = qty;
         }
         else
         {
            this.sysApi.sendAction(new ExchangeObjectMove(item.objectUID,qty));
         }
      }
      
      protected function unfillSlot(slot:Object, qty:int = -1) : void {
         if(qty == -1)
         {
            qty = slot.data.quantity;
         }
         switch(slot)
         {
            case this.slot_rune:
               this._showDamages = true;
               break;
         }
         this.sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID,-qty));
      }
      
      protected function setMergeButtonDisabled(disabled:Boolean) : void {
         if(this._mergeButtonTimer)
         {
            this._mergeButtonTimer.stop();
         }
         this.btn_mergeAll.disabled = disabled;
         this.btn_mergeOnce.disabled = disabled;
      }
      
      public function onDoubleClick(target:Object) : void {
         if(target.data)
         {
            this.unfillSlot(target,1);
         }
      }
      
      public function onMouseCtrlDoubleClick(target:Object) : void {
         var slotClicked:* = false;
         if(target.data)
         {
            slotClicked = false;
            if((target == this.slot_item) || (target == this.slot_rune) || (target == this.slot_sign))
            {
               slotClicked = true;
            }
            if(!slotClicked)
            {
               return;
            }
            this.unfillSlot(target,-1);
         }
      }
      
      public function onMouseAltDoubleClick(target:Object) : void {
         var slotClicked:* = false;
         if(target.data)
         {
            slotClicked = false;
            if((target == this.slot_item) || (target == this.slot_rune) || (target == this.slot_sign))
            {
               slotClicked = true;
            }
            if(!slotClicked)
            {
               return;
            }
            this._altClickedSlot = target;
            this.modCommon.openQuantityPopup(1,target.data.quantity,target.data.quantity,this.onValidQty);
         }
      }
      
      private function onValidQty(qty:Number) : void {
         this.unfillSlot(this._altClickedSlot,qty);
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:Object) : void {
         if(target.data)
         {
            this.uiApi.showTooltip(target.data,target,false,"standard",0,0,0,"itemName",null,
               {
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
         }
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target == this.ed_playedCharacter)
         {
            this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
         }
         else if(target.data)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
         
      }
      
      private function onDropStart(src:Object) : void {
         var slot:Object = null;
         this._waitingSlot = src;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.dropValidatorFunction(slot,src.data,null))
            {
               slot.selected = true;
            }
         }
      }
      
      private function onDropEnd(src:Object) : void {
         var slot:Object = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            slot.selected = false;
         }
      }
      
      private function onExchangeObjectModified(item:Object) : void {
         var slot:Object = this.getMatchingSlot(item);
         this.storageApi.addItemMask(item.objectUID,"smithMagic",item.quantity);
         this.storageApi.releaseHooks();
         slot.data = item;
         switch(slot)
         {
            case this.slot_item:
               this.displayItem(item,true,this._showDamages);
               break;
         }
      }
      
      private function onExchangeObjectAdded(item:Object) : void {
         var slot:Object = this.getMatchingSlot(item);
         if((slot.data) && (!(slot.data.objectUID == item.objectUID)))
         {
            this.storageApi.removeItemMask(slot.data.objectUID,"smithMagic");
         }
         slot.data = item;
         this.storageApi.addItemMask(item.objectUID,"smithMagic",item.quantity);
         this.storageApi.releaseHooks();
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         if(!item.isWeapon)
         {
            this._showDamages = false;
         }
         switch(slot)
         {
            case this.slot_item:
               this.displayItem(item,false,this._showDamages);
               break;
            case this.slot_rune:
               if(item.typeId == SMITHMAGIC_POTION_ID)
               {
                  this._showDamages = true;
               }
               else
               {
                  this._showDamages = false;
               }
               if(this.slot_item.data)
               {
                  this.displayItem(this.slot_item.data,true,this._showDamages);
               }
               break;
         }
         if((this.slot_item.data) && (this.slot_rune.data))
         {
            this.setMergeButtonDisabled(false);
         }
      }
      
      protected function onExchangeObjectRemoved(itemUID:int) : void {
         this.storageApi.removeItemMask(itemUID,"smithMagic");
         this.storageApi.releaseHooks();
         var slot:Object = this.getMatchingSlotFromUID(itemUID);
         if(slot)
         {
            slot.data = null;
            this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
            switch(slot)
            {
               case this.slot_item:
                  this.ctn_arrow.visible = false;
                  break;
            }
            if(this._refill_item != null)
            {
               this.fillSlot(slot,this._refill_item,this._refill_qty);
               this._refill_item = null;
            }
            if((this.slot_item.data == null) || (this.slot_rune.data == null))
            {
               this.setMergeButtonDisabled(true);
            }
         }
      }
      
      public function onObjectSelected(item:Object) : void {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            this.modCommon.createItemBox("itemBoxSmith",this.ctr_item,item.data);
            this.ctn_arrow.visible = false;
            this.objectCtr.visible = true;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_mergeAll:
               this._multiCraft = true;
               this.setMergeButtonDisabled(true);
               this.sysApi.sendAction(new ExchangeReplay(-1));
               this.sysApi.sendAction(new ExchangeReady(true));
               break;
            case this.btn_mergeOnce:
               this._multiCraft = false;
               this.setMergeButtonDisabled(true);
               this._mergeButtonTimer.start();
               this._mergeButtonTimerOut = false;
               this._mergeResultGot = false;
               this.sysApi.sendAction(new ExchangeReady(true));
               break;
            case this.btn_stop:
               this.sysApi.sendAction(new ExchangeReplayStop());
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.ed_playedCharacter:
               this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
               break;
            default:
               if((!(target.name.indexOf("slot") == -1)) && (target.data))
               {
                  this.onObjectSelected(target);
               }
         }
      }
      
      public function onExchangeCraftResult(result:int, item:Object) : void {
         switch(result)
         {
            case CRAFT_IMPOSSIBLE:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.noResult"),[this.uiApi.getText("ui.common.ok")]);
               this.sysApi.sendAction(new ExchangeReady(false));
            case CRAFT_FAILED:
            case CRAFT_SUCCESS:
            case CRAFT_NEARLY_SUCCESS:
               if(item)
               {
                  if(this.slot_item.data)
                  {
                     this.slot_item.data = this.dataApi.getItemWrapper(item.objectGID,item.position,this.slot_item.data.objectUID,item.quantity,item.effectsList);
                  }
                  this.displayItem(item,true,this._showDamages);
               }
               break;
         }
         if(this._multiCraft > 0)
         {
            this.setMergeButtonDisabled(true);
            this.btn_stop.disabled = false;
            this.btn_mergeAll.soundId = SoundEnum.CANCEL_BUTTON;
         }
         else
         {
            this._mergeResultGot = true;
            if(this._mergeButtonTimerOut)
            {
               this.setMergeButtonDisabled(false);
            }
         }
      }
      
      public function onMergeButtonTimer(e:TimerEvent) : void {
         this._mergeButtonTimerOut = true;
         if(this._mergeResultGot)
         {
            this.setMergeButtonDisabled(false);
         }
      }
      
      public function processDropToInventory(target:Object, d:Object, source:Object) : void {
         if(d.info1 > 1)
         {
            this._waitingObject = d;
            this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDropToInventory);
         }
         else
         {
            this.unfillSelectedSlot(1);
         }
      }
      
      public function onDoubleClickItemInventory(item:Object, qty:int = 1) : void {
         if((item.id == SIGNATURE_RUNE_ID) || (item.id == SMITHMAGIC_RUNE_ID))
         {
            qty = 1;
         }
         this.fillDefaultSlot(item,qty);
      }
      
      public function onExchangeItemAutoCraftStoped(reason:int) : void {
         this.btn_stop.disabled = true;
         this.btn_mergeAll.soundId = SoundEnum.OK_BUTTON;
         if((this.slot_item.data) && (this.slot_rune.data))
         {
            this.setMergeButtonDisabled(false);
         }
      }
      
      public function onExchangeLeave(sucess:Boolean) : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function getIsAvailableItem(item:Object) : Boolean {
         if(!this.dataApi)
         {
            return true;
         }
         return !(this.getMatchingSlot(item) == null);
      }
      
      public function get skill() : Object {
         return this._skill;
      }
   }
}
