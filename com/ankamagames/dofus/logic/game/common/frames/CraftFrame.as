package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOkMultiCraftMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftWithInformationMessage;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangePlayerMultiCraftRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemGoldAddAsPaymentAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemGoldAddAsPaymentMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemObjectAddAsPaymentAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemObjectAddAsPaymentMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayStopMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeSetCraftRecipeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemAutoCraftStopedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeGoldPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRemovedPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeModifiedPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeClearPaymentForCraftMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectModifiedInBagMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectPutInBagMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeObjectRemovedFromBagMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeObjectUseInWorkshopAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectUseInWorkshopMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCrafterMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMulticraftCustomerMessage;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeReplayCountModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeItemAutoCraftRemainingMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftSlotCountIncreasedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectIdMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultMagicWithObjectDescMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeCraftResultWithObjectDescMessage;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.enums.PaymentTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.network.enums.ExchangeReplayStopReasonEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   
   public class CraftFrame extends Object implements Frame
   {
      
      public function CraftFrame() {
         this.playerList = new PlayerExchangeCraftList();
         this.otherPlayerList = new PlayerExchangeCraftList();
         this.paymentCraftList = new PaymentCraftList();
         this._crafterInfos = new PlayerInfo();
         this._customerInfos = new PlayerInfo();
         this.bagList = new Array();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CraftFrame));
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      public var playerList:PlayerExchangeCraftList;
      
      public var otherPlayerList:PlayerExchangeCraftList;
      
      public var paymentCraftList:PaymentCraftList;
      
      private var _crafterInfos:PlayerInfo;
      
      private var _customerInfos:PlayerInfo;
      
      public var bagList:Array;
      
      private var _isCrafter:Boolean;
      
      private var _recipes:Array;
      
      private var _skillId:int;
      
      private var _craftType:int;
      
      private var _smithMagicOldObject:ItemWrapper;
      
      private var _success:Boolean;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      private function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get crafterInfos() : PlayerInfo {
         return this._crafterInfos;
      }
      
      public function get customerInfos() : PlayerInfo {
         return this._customerInfos;
      }
      
      public function get skillId() : int {
         return this._skillId;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get commonExchangeFrame() : CommonExchangeManagementFrame {
         return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
      }
      
      public function processExchangeOkMultiCraftMessage(param1:ExchangeOkMultiCraftMessage) : void {
         PlayedCharacterManager.getInstance().isInExchange = true;
         var _loc2_:ExchangeOkMultiCraftMessage = param1 as ExchangeOkMultiCraftMessage;
         if(_loc2_.role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
         {
            this.playerList.isCrafter = true;
            this.otherPlayerList.isCrafter = false;
            this._crafterInfos.id = PlayedCharacterManager.getInstance().id;
            if(this.crafterInfos.id == _loc2_.initiatorId)
            {
               this._customerInfos.id = _loc2_.otherId;
            }
            else
            {
               this._customerInfos.id = _loc2_.initiatorId;
            }
         }
         else
         {
            this.playerList.isCrafter = false;
            this.otherPlayerList.isCrafter = true;
            this._customerInfos.id = PlayedCharacterManager.getInstance().id;
            if(this.customerInfos.id == _loc2_.initiatorId)
            {
               this._crafterInfos.id = _loc2_.otherId;
            }
            else
            {
               this._crafterInfos.id = _loc2_.initiatorId;
            }
         }
         var _loc3_:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.crafterInfos.id);
         if(_loc3_)
         {
            this._crafterInfos.look = EntityLookAdapter.getRiderLook(_loc3_.look);
            this._crafterInfos.name = (_loc3_ as GameRolePlayNamedActorInformations).name;
         }
         else
         {
            this._crafterInfos.look = null;
            this._crafterInfos.name = "";
         }
         var _loc4_:GameContextActorInformations = this.roleplayContextFrame.entitiesFrame.getEntityInfos(this.customerInfos.id);
         if(_loc4_)
         {
            this._customerInfos.look = EntityLookAdapter.getRiderLook(_loc4_.look);
            this._customerInfos.name = (_loc4_ as GameRolePlayNamedActorInformations).name;
         }
         else
         {
            this._customerInfos.look = null;
            this._customerInfos.name = "";
         }
         var _loc5_:* = "";
         var _loc6_:uint = _loc2_.initiatorId;
         if(_loc2_.initiatorId == PlayedCharacterManager.getInstance().id)
         {
            if(_loc2_.initiatorId == this.crafterInfos.id)
            {
               this._isCrafter = true;
               _loc5_ = this.customerInfos.name;
            }
            else
            {
               this._isCrafter = false;
               _loc5_ = this.crafterInfos.name;
            }
         }
         else
         {
            if(_loc2_.otherId == this.crafterInfos.id)
            {
               this._isCrafter = false;
               _loc5_ = this.crafterInfos.name;
            }
            else
            {
               this._isCrafter = true;
               _loc5_ = this.customerInfos.name;
            }
         }
         if(!this.socialFrame.isIgnored(_loc5_))
         {
            KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftRequest,_loc2_.role,_loc5_,_loc6_);
         }
      }
      
      public function processExchangeStartOkCraftWithInformationMessage(param1:ExchangeStartOkCraftWithInformationMessage) : void {
         PlayedCharacterManager.getInstance().isInExchange = true;
         var _loc2_:ExchangeStartOkCraftWithInformationMessage = param1 as ExchangeStartOkCraftWithInformationMessage;
         this._skillId = _loc2_.skillId;
         var _loc3_:Array = Recipe.getAllRecipesForSkillId(_loc2_.skillId,_loc2_.nbCase);
         this._isCrafter = true;
         var _loc4_:Skill = Skill.getSkillById(this._skillId);
         if(_loc4_.isForgemagus)
         {
            this._craftType = 1;
         }
         else
         {
            if(_loc4_.isRepair)
            {
               this._craftType = 2;
            }
            else
            {
               this._craftType = 0;
            }
         }
         KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft,_loc3_,_loc2_.skillId,_loc2_.nbCase);
      }
      
      public function pushed() : Boolean {
         this._success = false;
         return true;
      }
      
      public function pulled() : Boolean {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this.playerList = new PlayerExchangeCraftList();
         this.otherPlayerList = new PlayerExchangeCraftList();
         this.bagList = new Array();
         this._crafterInfos = new PlayerInfo();
         this._customerInfos = new PlayerInfo();
         this.paymentCraftList = new PaymentCraftList();
         this._smithMagicOldObject = null;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ExchangePlayerMultiCraftRequestAction = null;
         var _loc3_:ExchangePlayerMultiCraftRequestMessage = null;
         var _loc4_:ExchangeItemGoldAddAsPaymentAction = null;
         var _loc5_:uint = 0;
         var _loc6_:ExchangeItemGoldAddAsPaymentMessage = null;
         var _loc7_:ExchangeItemObjectAddAsPaymentAction = null;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:ItemWrapper = null;
         var _loc11_:ExchangeItemObjectAddAsPaymentMessage = null;
         var _loc12_:ExchangeReplayStopAction = null;
         var _loc13_:ExchangeReplayStopMessage = null;
         var _loc14_:ExchangeSetCraftRecipeAction = null;
         var _loc15_:ExchangeSetCraftRecipeMessage = null;
         var _loc16_:ExchangeCraftResultMessage = null;
         var _loc17_:uint = 0;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:ItemWrapper = null;
         var _loc21_:* = false;
         var _loc22_:ExchangeItemAutoCraftStopedMessage = null;
         var _loc23_:String = null;
         var _loc24_:* = false;
         var _loc25_:ExchangeStartOkCraftMessage = null;
         var _loc26_:uint = 0;
         var _loc27_:ExchangeGoldPaymentForCraftMessage = null;
         var _loc28_:ExchangeItemPaymentForCraftMessage = null;
         var _loc29_:ItemWrapper = null;
         var _loc30_:ExchangeRemovedPaymentForCraftMessage = null;
         var _loc31_:ExchangeModifiedPaymentForCraftMessage = null;
         var _loc32_:ItemWrapper = null;
         var _loc33_:ItemWrapper = null;
         var _loc34_:Array = null;
         var _loc35_:ExchangeClearPaymentForCraftMessage = null;
         var _loc36_:ExchangeObjectModifiedInBagMessage = null;
         var _loc37_:ExchangeObjectPutInBagMessage = null;
         var _loc38_:ObjectItem = null;
         var _loc39_:ItemWrapper = null;
         var _loc40_:ExchangeObjectRemovedFromBagMessage = null;
         var _loc41_:uint = 0;
         var _loc42_:ExchangeObjectUseInWorkshopAction = null;
         var _loc43_:ExchangeObjectUseInWorkshopMessage = null;
         var _loc44_:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = null;
         var _loc45_:ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage = null;
         var _loc46_:ExchangeMultiCraftCrafterCanUseHisRessourcesMessage = null;
         var _loc47_:ExchangeStartOkMulticraftCrafterMessage = null;
         var _loc48_:Array = null;
         var _loc49_:Skill = null;
         var _loc50_:ExchangeStartOkMulticraftCustomerMessage = null;
         var _loc51_:Array = null;
         var _loc52_:Skill = null;
         var _loc53_:ExchangeReplayAction = null;
         var _loc54_:ExchangeReplayMessage = null;
         var _loc55_:ExchangeReplayCountModifiedMessage = null;
         var _loc56_:ExchangeItemAutoCraftRemainingMessage = null;
         var _loc57_:ExchangeCraftSlotCountIncreasedMessage = null;
         var _loc58_:ExchangeLeaveMessage = null;
         var _loc59_:ExchangeCraftResultWithObjectIdMessage = null;
         var _loc60_:ExchangeCraftResultMagicWithObjectDescMessage = null;
         var _loc61_:String = null;
         var _loc62_:* = false;
         var _loc63_:Vector.<ObjectEffect> = null;
         var _loc64_:EffectInstance = null;
         var _loc65_:Array = null;
         var _loc66_:String = null;
         var _loc67_:String = null;
         var _loc68_:ExchangeCraftResultWithObjectDescMessage = null;
         var _loc69_:ObjectEffect = null;
         var _loc70_:* = false;
         var _loc71_:ObjectEffect = null;
         var _loc72_:* = 0;
         var _loc73_:* = 0;
         var _loc74_:* = 0;
         var _loc75_:EffectInstanceInteger = null;
         var _loc76_:EffectInstanceDice = null;
         var _loc77_:ObjectEffect = null;
         var _loc78_:* = false;
         var _loc79_:ObjectEffect = null;
         var _loc80_:EffectInstanceMinMax = null;
         var _loc81_:Object = null;
         var _loc82_:ItemWrapper = null;
         var _loc83_:ItemWrapper = null;
         var _loc84_:ItemWrapper = null;
         var _loc85_:ItemWrapper = null;
         var _loc86_:ItemWrapper = null;
         switch(true)
         {
            case param1 is ExchangePlayerMultiCraftRequestAction:
               _loc2_ = param1 as ExchangePlayerMultiCraftRequestAction;
               _loc3_ = new ExchangePlayerMultiCraftRequestMessage();
               _loc3_.initExchangePlayerMultiCraftRequestMessage(_loc2_.exchangeType,_loc2_.target,_loc2_.skillId);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is ExchangeOkMultiCraftMessage:
               this.processExchangeOkMultiCraftMessage(param1 as ExchangeOkMultiCraftMessage);
               return true;
            case param1 is ExchangeItemGoldAddAsPaymentAction:
               _loc4_ = param1 as ExchangeItemGoldAddAsPaymentAction;
               if(_loc4_.onlySuccess)
               {
                  _loc5_ = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
               }
               else
               {
                  _loc5_ = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
               }
               _loc6_ = new ExchangeItemGoldAddAsPaymentMessage();
               _loc6_.initExchangeItemGoldAddAsPaymentMessage(_loc5_,_loc4_.kamas);
               ConnectionsHandler.getConnection().send(_loc6_);
               return true;
            case param1 is ExchangeItemObjectAddAsPaymentAction:
               _loc7_ = param1 as ExchangeItemObjectAddAsPaymentAction;
               if(_loc7_.onlySuccess)
               {
                  _loc8_ = PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY;
                  _loc9_ = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               else
               {
                  _loc8_ = PaymentTypeEnum.PAYMENT_IN_ANY_CASE;
                  _loc9_ = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               _loc11_ = new ExchangeItemObjectAddAsPaymentMessage();
               _loc11_.initExchangeItemObjectAddAsPaymentMessage(_loc8_,_loc7_.isAdd,_loc7_.objectUID,_loc7_.quantity);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is ExchangeReplayStopAction:
               _loc12_ = param1 as ExchangeReplayStopAction;
               _loc13_ = new ExchangeReplayStopMessage();
               _loc13_.initExchangeReplayStopMessage();
               ConnectionsHandler.getConnection().send(_loc13_);
               return true;
            case param1 is ExchangeSetCraftRecipeAction:
               _loc14_ = param1 as ExchangeSetCraftRecipeAction;
               _loc15_ = new ExchangeSetCraftRecipeMessage();
               _loc15_.initExchangeSetCraftRecipeMessage(_loc14_.recipeId);
               ConnectionsHandler.getConnection().send(_loc15_);
               return true;
            case param1 is ExchangeCraftResultMessage:
               _loc16_ = param1 as ExchangeCraftResultMessage;
               _loc17_ = _loc16_.getMessageId();
               _loc20_ = null;
               _loc21_ = false;
               switch(_loc17_)
               {
                  case ExchangeCraftResultMessage.protocolId:
                     _loc19_ = I18n.getUiText("ui.craft.noResult");
                     break;
                  case ExchangeCraftResultWithObjectIdMessage.protocolId:
                     _loc59_ = param1 as ExchangeCraftResultWithObjectIdMessage;
                     _loc20_ = ItemWrapper.create(63,0,_loc59_.objectGenericId,1,null,false);
                     _loc18_ = Item.getItemById(_loc59_.objectGenericId).name;
                     _loc19_ = I18n.getUiText("ui.craft.failed");
                     _loc21_ = _loc59_.craftResult == 2;
                     break;
                  case ExchangeCraftResultMagicWithObjectDescMessage.protocolId:
                     _loc60_ = param1 as ExchangeCraftResultMagicWithObjectDescMessage;
                     _loc61_ = "";
                     _loc62_ = false;
                     _loc63_ = _loc60_.objectInfo.effects;
                     _loc65_ = new Array();
                     if(this._smithMagicOldObject)
                     {
                        for each (_loc69_ in this._smithMagicOldObject.effectsList)
                        {
                           _loc65_.push(_loc69_);
                           if(_loc69_ is ObjectEffectInteger || _loc69_ is ObjectEffectDice)
                           {
                              _loc70_ = false;
                              for each (_loc71_ in _loc63_)
                              {
                                 if((_loc71_ is ObjectEffectInteger || _loc71_ is ObjectEffectDice) && _loc71_.actionId == _loc69_.actionId)
                                 {
                                    _loc70_ = true;
                                    _loc72_ = Effect.getEffectById(_loc69_.actionId).bonusType;
                                    _loc73_ = Effect.getEffectById(_loc71_.actionId).bonusType;
                                    if(_loc71_ is ObjectEffectInteger)
                                    {
                                       _loc72_ = _loc72_ * ObjectEffectInteger(_loc69_).value;
                                       _loc73_ = _loc73_ * ObjectEffectInteger(_loc71_).value;
                                       if(_loc73_ != _loc72_)
                                       {
                                          _loc74_ = _loc73_ - _loc72_;
                                          _loc75_ = new EffectInstanceInteger();
                                          _loc75_.effectId = _loc71_.actionId;
                                          if(_loc74_ > 0)
                                          {
                                             _loc62_ = true;
                                          }
                                          _loc75_.value = ObjectEffectInteger(_loc71_).value - ObjectEffectInteger(_loc69_).value;
                                          _loc61_ = _loc61_ + (" " + _loc75_.description + ",");
                                          _loc61_ = _loc61_.replace("+-","-");
                                          _loc61_ = _loc61_.replace("--","+");
                                          _loc64_ = _loc75_;
                                       }
                                    }
                                    else
                                    {
                                       if(_loc71_ is ObjectEffectDice)
                                       {
                                          _loc72_ = ObjectEffectDice(_loc69_).diceNum;
                                          _loc73_ = ObjectEffectDice(_loc71_).diceNum;
                                          if(_loc73_ != _loc72_)
                                          {
                                             _loc74_ = _loc73_ - _loc72_;
                                             if(_loc69_.actionId == ActionIdConverter.ACTION_ITEM_CHANGE_DURABILITY)
                                             {
                                                _loc61_ = _loc61_ + (" +" + _loc74_ + ",");
                                                _loc74_ = _loc73_;
                                             }
                                             _loc76_ = new EffectInstanceDice();
                                             _loc76_.effectId = _loc71_.actionId;
                                             if(_loc74_ > 0)
                                             {
                                                _loc62_ = true;
                                             }
                                             _loc76_.diceNum = _loc74_;
                                             _loc76_.diceSide = _loc74_;
                                             _loc76_.value = ObjectEffectDice(_loc71_).diceConst;
                                             _loc64_ = _loc76_;
                                             _loc61_ = _loc61_ + (" " + _loc64_.description + ",");
                                             _loc61_ = _loc61_.replace("+-","-");
                                             _loc61_ = _loc61_.replace("--","+");
                                          }
                                       }
                                    }
                                 }
                              }
                              if(!_loc70_)
                              {
                                 _loc75_ = new EffectInstanceInteger();
                                 _loc75_.effectId = _loc69_.actionId;
                                 _loc75_.value = -ObjectEffectInteger(_loc69_).value;
                                 _loc61_ = _loc61_ + (" " + _loc75_.description + ",");
                                 _loc61_ = _loc61_.replace("+-","-");
                                 _loc61_ = _loc61_.replace("--","+");
                                 _loc64_ = _loc75_;
                              }
                           }
                        }
                     }
                     for each (_loc77_ in _loc63_)
                     {
                        _loc78_ = true;
                        for each (_loc79_ in _loc65_)
                        {
                           if(_loc77_ is ObjectEffectInteger || _loc77_ is ObjectEffectMinMax)
                           {
                              if(_loc77_.actionId == _loc79_.actionId)
                              {
                                 _loc78_ = false;
                                 _loc65_.splice(_loc65_.indexOf(_loc79_),1);
                              }
                           }
                           else
                           {
                              _loc78_ = false;
                           }
                        }
                        if(_loc78_)
                        {
                           if(_loc77_ is ObjectEffectMinMax)
                           {
                              _loc80_ = new EffectInstanceMinMax();
                              _loc80_.effectId = _loc77_.actionId;
                              _loc80_.min = ObjectEffectMinMax(_loc77_).min;
                              _loc80_.max = ObjectEffectMinMax(_loc77_).max;
                              _loc64_ = _loc80_;
                              _loc62_ = true;
                           }
                           else
                           {
                              if(_loc77_ is ObjectEffectInteger)
                              {
                                 _loc75_ = new EffectInstanceInteger();
                                 _loc75_.effectId = _loc77_.actionId;
                                 _loc75_.value = ObjectEffectInteger(_loc77_).value;
                                 if(_loc75_.value > 0)
                                 {
                                    _loc62_ = true;
                                 }
                                 _loc61_ = _loc61_ + (" " + _loc75_.description + ",");
                                 _loc64_ = _loc75_;
                              }
                           }
                        }
                     }
                     _loc66_ = "";
                     if(_loc60_.magicPoolStatus == 2)
                     {
                        _loc66_ = " +" + I18n.getUiText("ui.craft.smithResidualMagic");
                     }
                     else
                     {
                        if(_loc60_.magicPoolStatus == 3)
                        {
                           _loc66_ = " -" + I18n.getUiText("ui.craft.smithResidualMagic");
                        }
                     }
                     _loc67_ = "";
                     if(_loc62_)
                     {
                        _loc67_ = _loc67_ + (I18n.getUiText("ui.craft.success") + I18n.getUiText("ui.common.colon"));
                     }
                     else
                     {
                        _loc67_ = _loc67_ + (I18n.getUiText("ui.craft.failure") + I18n.getUiText("ui.common.colon"));
                     }
                     _loc67_ = _loc67_ + _loc61_;
                     if(_loc66_ != "")
                     {
                        _loc67_ = _loc67_ + _loc66_;
                     }
                     else
                     {
                        _loc67_ = _loc67_.substring(0,_loc67_.length-1);
                     }
                     if(_loc61_ == "" && _loc66_ == "")
                     {
                        _loc67_ = _loc67_.substring(0,_loc67_.length - (I18n.getUiText("ui.common.colon").length-1));
                     }
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc67_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                     _loc20_ = ItemWrapper.create(63,_loc60_.objectInfo.objectUID,_loc60_.objectInfo.objectGID,1,_loc60_.objectInfo.effects,false);
                     this._smithMagicOldObject = _loc20_.clone();
                     _loc21_ = _loc60_.craftResult == 2;
                     break;
                  case ExchangeCraftResultWithObjectDescMessage.protocolId:
                     _loc68_ = param1 as ExchangeCraftResultWithObjectDescMessage;
                     _loc20_ = ItemWrapper.create(63,_loc68_.objectInfo.objectUID,_loc68_.objectInfo.objectGID,1,_loc68_.objectInfo.effects,false);
                     if(_loc68_.objectInfo.objectGID == 0)
                     {
                        break;
                     }
                     _loc18_ = HyperlinkItemManager.newChatItem(_loc20_);
                     switch(true)
                     {
                        case this._crafterInfos.id == PlayedCharacterManager.getInstance().id:
                           _loc19_ = I18n.getUiText("ui.craft.successTarget",[_loc18_,this._customerInfos.name]);
                           break;
                        case this._customerInfos.id == PlayedCharacterManager.getInstance().id:
                           _loc19_ = I18n.getUiText("ui.craft.successOther",[this._crafterInfos.name,_loc18_]);
                           break;
                        default:
                           _loc19_ = I18n.getUiText("ui.craft.craftSuccessSelf",[_loc18_]);
                     }
                     _loc21_ = _loc68_.craftResult == 2;
                     break;
               }
               if(_loc21_)
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_OK);
               }
               else
               {
                  SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CRAFT_KO);
               }
               if((_loc19_) && !(_loc19_ == ""))
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc19_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftResult,_loc16_.craftResult,_loc20_);
               return true;
            case param1 is ExchangeItemAutoCraftStopedMessage:
               _loc22_ = param1 as ExchangeItemAutoCraftStopedMessage;
               _loc23_ = "";
               _loc24_ = true;
               switch(_loc22_.reason)
               {
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_CRAFT:
                     _loc23_ = I18n.getUiText("ui.craft.autoCraftStopedInvalidRecipe");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                     _loc23_ = I18n.getUiText("ui.craft.autoCraftStopedNoRessource");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                     _loc23_ = I18n.getUiText("ui.craft.autoCraftStopedOk");
                     break;
                  case ExchangeReplayStopReasonEnum.STOPPED_REASON_USER:
                     _loc23_ = I18n.getUiText("ui.craft.autoCraftStoped");
                     _loc24_ = false;
                     break;
               }
               if(_loc24_)
               {
                  _loc81_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  _loc81_.openPopup(I18n.getUiText("ui.popup.information"),_loc23_,[I18n.getUiText("ui.common.ok")]);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc23_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftStoped,_loc22_.reason);
               return true;
            case param1 is ExchangeStartOkCraftMessage:
               _loc25_ = param1 as ExchangeStartOkCraftMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               _loc26_ = _loc25_.getMessageId();
               switch(_loc26_)
               {
                  case ExchangeStartOkCraftMessage.protocolId:
                     KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkCraft);
                     break;
                  case ExchangeStartOkCraftWithInformationMessage.protocolId:
                     this.processExchangeStartOkCraftWithInformationMessage(param1 as ExchangeStartOkCraftWithInformationMessage);
                     break;
               }
               return true;
            case param1 is ExchangeGoldPaymentForCraftMessage:
               _loc27_ = param1 as ExchangeGoldPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               if(_loc27_.onlySuccess)
               {
                  this.paymentCraftList.kamaPaymentOnlySuccess = _loc27_.goldSum;
               }
               else
               {
                  this.paymentCraftList.kamaPayment = _loc27_.goldSum;
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case param1 is ExchangeItemPaymentForCraftMessage:
               _loc28_ = param1 as ExchangeItemPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               _loc29_ = ItemWrapper.create(63,_loc28_.object.objectUID,_loc28_.object.objectGID,_loc28_.object.quantity,_loc28_.object.effects,false);
               this.addObjetPayment(_loc28_.onlySuccess,_loc29_);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case param1 is ExchangeRemovedPaymentForCraftMessage:
               _loc30_ = param1 as ExchangeRemovedPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               this.removeObjetPayment(_loc30_.objectUID,_loc30_.onlySuccess);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case param1 is ExchangeModifiedPaymentForCraftMessage:
               _loc31_ = param1 as ExchangeModifiedPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               _loc32_ = ItemWrapper.getItemFromUId(_loc31_.object.objectUID);
               _loc33_ = ItemWrapper.create(63,_loc31_.object.objectUID,_loc31_.object.objectGID,_loc31_.object.quantity,_loc31_.object.effects,false);
               if(_loc31_.onlySuccess)
               {
                  _loc34_ = this.paymentCraftList.objectsPaymentOnlySuccess;
               }
               else
               {
                  _loc34_ = this.paymentCraftList.objectsPayment;
               }
               _loc34_.splice(_loc34_.indexOf(_loc32_),1,_loc33_);
               KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
               return true;
            case param1 is ExchangeClearPaymentForCraftMessage:
               _loc35_ = param1 as ExchangeClearPaymentForCraftMessage;
               if(this.commonExchangeFrame)
               {
                  this.commonExchangeFrame.incrementEchangeSequence();
               }
               switch(_loc35_.paymentType)
               {
                  case PaymentTypeEnum.PAYMENT_IN_ANY_CASE:
                     this.paymentCraftList.kamaPayment = 0;
                     for each (_loc82_ in this.paymentCraftList.objectsPayment)
                     {
                        InventoryManager.getInstance().inventory.removeItemMask(_loc82_.objectUID,"paymentAlways");
                     }
                     this.paymentCraftList.objectsPayment = new Array();
                     break;
                  case PaymentTypeEnum.PAYMENT_ON_SUCCESS_ONLY:
                     this.paymentCraftList.kamaPaymentOnlySuccess = 0;
                     for each (_loc83_ in this.paymentCraftList.objectsPaymentOnlySuccess)
                     {
                        InventoryManager.getInstance().inventory.removeItemMask(_loc83_.objectUID,"paymentSuccess");
                     }
                     this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
                     break;
               }
               return true;
            case param1 is ExchangeObjectModifiedInBagMessage:
               _loc36_ = param1 as ExchangeObjectModifiedInBagMessage;
               for each (_loc84_ in this.bagList)
               {
                  if(_loc84_.objectUID == _loc36_.object.objectUID)
                  {
                     _loc85_ = ItemWrapper.create(63,_loc36_.object.objectUID,_loc36_.object.objectGID,_loc36_.object.quantity,_loc36_.object.effects,false);
                     this.bagList.splice(this.bagList.indexOf(_loc84_),1,_loc85_);
                     break;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,_loc36_.remote);
               return true;
            case param1 is ExchangeObjectPutInBagMessage:
               _loc37_ = param1 as ExchangeObjectPutInBagMessage;
               _loc38_ = _loc37_.object;
               _loc39_ = ItemWrapper.create(63,_loc38_.objectUID,_loc38_.objectGID,_loc38_.quantity,_loc38_.effects,false);
               this.bagList.push(_loc39_);
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,_loc37_.remote);
               return true;
            case param1 is ExchangeObjectRemovedFromBagMessage:
               _loc40_ = param1 as ExchangeObjectRemovedFromBagMessage;
               _loc41_ = 0;
               for each (_loc86_ in this.bagList)
               {
                  if(_loc86_.objectUID == _loc40_.objectUID)
                  {
                     this.bagList.splice(_loc41_,1);
                     break;
                  }
                  _loc41_++;
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.BagListUpdate,this.bagList,_loc40_.remote);
               return true;
            case param1 is ExchangeObjectUseInWorkshopAction:
               _loc42_ = param1 as ExchangeObjectUseInWorkshopAction;
               _loc43_ = new ExchangeObjectUseInWorkshopMessage();
               _loc43_.initExchangeObjectUseInWorkshopMessage(_loc42_.objectUID,_loc42_.quantity);
               ConnectionsHandler.getConnection().send(_loc43_);
               return true;
            case param1 is ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction:
               _loc44_ = param1 as ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
               _loc45_ = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage();
               _loc45_.initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(_loc44_.allow);
               ConnectionsHandler.getConnection().send(_loc45_);
               return true;
            case param1 is ExchangeMultiCraftCrafterCanUseHisRessourcesMessage:
               _loc46_ = param1 as ExchangeMultiCraftCrafterCanUseHisRessourcesMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeMultiCraftCrafterCanUseHisRessources,_loc46_.allowed);
               return true;
            case param1 is ExchangeStartOkMulticraftCrafterMessage:
               _loc47_ = param1 as ExchangeStartOkMulticraftCrafterMessage;
               _loc48_ = Recipe.getAllRecipesForSkillId(_loc47_.skillId,_loc47_.maxCase);
               this._skillId = _loc47_.skillId;
               _loc49_ = Skill.getSkillById(this._skillId);
               if(_loc49_.isForgemagus)
               {
                  this._craftType = 1;
               }
               else
               {
                  if(_loc49_.isRepair)
                  {
                     this._craftType = 2;
                  }
                  else
                  {
                     this._craftType = 0;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft,_loc47_.skillId,_loc48_,_loc47_.maxCase,this.crafterInfos,this.customerInfos);
               return true;
            case param1 is ExchangeStartOkMulticraftCustomerMessage:
               _loc50_ = param1 as ExchangeStartOkMulticraftCustomerMessage;
               _loc51_ = Recipe.getAllRecipesForSkillId(_loc50_.skillId,_loc50_.maxCase);
               this.crafterInfos.skillLevel = _loc50_.crafterJobLevel;
               this._skillId = _loc50_.skillId;
               _loc52_ = Skill.getSkillById(this._skillId);
               if(_loc52_.isForgemagus)
               {
                  this._craftType = 1;
               }
               else
               {
                  if(_loc52_.isRepair)
                  {
                     this._craftType = 2;
                  }
                  else
                  {
                     this._craftType = 0;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkMultiCraft,_loc50_.skillId,_loc51_,_loc50_.maxCase,this.crafterInfos,this.customerInfos);
               return true;
            case param1 is ExchangeReplayAction:
               _loc53_ = param1 as ExchangeReplayAction;
               _loc54_ = new ExchangeReplayMessage();
               _loc54_.initExchangeReplayMessage(_loc53_.count);
               ConnectionsHandler.getConnection().send(_loc54_);
               return true;
            case param1 is ExchangeReplayCountModifiedMessage:
               _loc55_ = param1 as ExchangeReplayCountModifiedMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeReplayCountModified,_loc55_.count);
               return true;
            case param1 is ExchangeItemAutoCraftRemainingMessage:
               _loc56_ = param1 as ExchangeItemAutoCraftRemainingMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeItemAutoCraftRemaining,_loc56_.count);
               return true;
            case param1 is ExchangeCraftSlotCountIncreasedMessage:
               _loc57_ = param1 as ExchangeCraftSlotCountIncreasedMessage;
               _loc48_ = Recipe.getAllRecipesForSkillId(this._skillId,_loc57_.newMaxSlot);
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeCraftSlotCountIncreased,_loc57_.newMaxSlot,_loc48_);
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc58_ = param1 as ExchangeLeaveMessage;
               if(_loc58_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = _loc58_.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      private function resetLists() : void {
         this.paymentCraftList.kamaPayment = 0;
         this.paymentCraftList.kamaPaymentOnlySuccess = 0;
         this.paymentCraftList.objectsPayment = new Array();
         this.paymentCraftList.objectsPaymentOnlySuccess = new Array();
      }
      
      public function addCraftComponent(param1:Boolean, param2:ItemWrapper) : void {
         var _loc3_:PlayerExchangeCraftList = null;
         if(param1)
         {
            _loc3_ = this.otherPlayerList;
         }
         else
         {
            _loc3_ = this.playerList;
         }
         _loc3_.componentList.push(param2);
         this.sendUpdateHook(_loc3_);
         if(!(this._craftType == 0) && !(param2.typeId == SMITHMAGIC_RUNE_ID) && !(param2.typeId == SMITHMAGIC_POTION_ID) && !(param2.objectGID == SIGNATURE_RUNE_ID))
         {
            this._smithMagicOldObject = param2.clone();
         }
      }
      
      public function modifyCraftComponent(param1:Boolean, param2:ItemWrapper) : void {
         var _loc3_:PlayerExchangeCraftList = null;
         if(param1)
         {
            _loc3_ = this.otherPlayerList;
         }
         else
         {
            _loc3_ = this.playerList;
         }
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.componentList.length)
         {
            if(_loc3_.componentList[_loc4_].objectGID == param2.objectGID && _loc3_.componentList[_loc4_].objectUID == param2.objectUID)
            {
               _loc3_.componentList.splice(_loc4_,1,param2);
            }
            _loc4_++;
         }
         this.sendUpdateHook(_loc3_);
      }
      
      public function removeCraftComponent(param1:Boolean, param2:uint) : void {
         var _loc5_:ItemWrapper = null;
         var _loc6_:ItemWrapper = null;
         var _loc3_:uint = 0;
         var _loc4_:PlayerExchangeCraftList = new PlayerExchangeCraftList();
         for each (_loc5_ in this.otherPlayerList.componentList)
         {
            if(_loc5_.objectUID == param2)
            {
               this.otherPlayerList.componentList.splice(_loc3_,1);
               this.sendUpdateHook(this.otherPlayerList);
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         for each (_loc6_ in this.playerList.componentList)
         {
            if(_loc6_.objectUID == param2)
            {
               this.playerList.componentList.splice(_loc3_,1);
               this.sendUpdateHook(this.playerList);
               break;
            }
            _loc3_++;
         }
      }
      
      public function addObjetPayment(param1:Boolean, param2:ItemWrapper) : void {
         if(param1)
         {
            this.paymentCraftList.objectsPaymentOnlySuccess.push(param2);
         }
         else
         {
            this.paymentCraftList.objectsPayment.push(param2);
         }
      }
      
      public function removeObjetPayment(param1:uint, param2:Boolean) : void {
         var _loc4_:Array = null;
         var _loc5_:ItemWrapper = null;
         var _loc3_:uint = 0;
         if(param2)
         {
            _loc4_ = this.paymentCraftList.objectsPaymentOnlySuccess;
         }
         else
         {
            _loc4_ = this.paymentCraftList.objectsPayment;
         }
         for each (_loc5_ in _loc4_)
         {
            if(_loc5_.objectUID == param1)
            {
               _loc4_.splice(_loc3_,1);
            }
            _loc3_++;
         }
         KernelEventsManager.getInstance().processCallback(CraftHookList.PaymentCraftList,this.paymentCraftList,true);
      }
      
      private function sendUpdateHook(param1:PlayerExchangeCraftList) : void {
         switch(param1)
         {
            case this.otherPlayerList:
               KernelEventsManager.getInstance().processCallback(CraftHookList.OtherPlayerListUpdate,param1);
               break;
            case this.playerList:
               KernelEventsManager.getInstance().processCallback(CraftHookList.PlayerListUpdate,param1);
               break;
         }
      }
   }
}
class PaymentCraftList extends Object
{
   
   function PaymentCraftList() {
      super();
      this.kamaPaymentOnlySuccess = 0;
      this.objectsPaymentOnlySuccess = new Array();
      this.kamaPayment = 0;
      this.objectsPayment = new Array();
   }
   
   public var kamaPaymentOnlySuccess:uint;
   
   public var objectsPaymentOnlySuccess:Array;
   
   public var kamaPayment:uint;
   
   public var objectsPayment:Array;
}
class PlayerExchangeCraftList extends Object
{
   
   function PlayerExchangeCraftList() {
      super();
      this.componentList = new Array();
      this.isCrafter = false;
   }
   
   public var componentList:Array;
   
   public var isCrafter:Boolean;
}
import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class PlayerInfo extends Object
{
   
   function PlayerInfo() {
      super();
   }
   
   public var id:uint;
   
   public var name:String;
   
   public var look:TiphonEntityLook;
   
   public var skillLevel:int;
}
