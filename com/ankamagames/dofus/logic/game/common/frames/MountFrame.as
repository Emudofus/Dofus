package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationInPaddockRequestMessage;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountReleaseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizeRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRenameRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetXpRatioRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnMountStockMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRenamedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeHandleMountStableMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableBornAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountStableRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountPaddockAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountPaddockRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountDataMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountEquipedErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeWeightMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountWithOutPaddockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.UpdateMountBoostMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountEmoteIconUsedOkMessage;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountTakenFromPaddockMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountReleasedMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountToggleRidingRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountFeedRequestMessage;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountBoost;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountIntBoost;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizedMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountXpRatioMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRidingMessage;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.network.enums.MountEquipedErrorEnum;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetMessage;
   import com.ankamagames.dofus.network.enums.UpdatableMountBoostEnum;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountUnSetMessage;
   
   public class MountFrame extends Object implements Frame
   {
      
      public function MountFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MountFrame));
      
      public static const MAX_XP_RATIO:uint = 90;
      
      private var _mountDialogFrame:MountDialogFrame;
      
      private var _mountXpRatio:uint;
      
      private var _stableList:Array;
      
      private var _paddockList:Array;
      
      private var _inventoryWeight:uint;
      
      private var _inventoryMaxWeight:uint;
      
      public function get priority() : int {
         return 0;
      }
      
      public function get mountXpRatio() : uint {
         return this._mountXpRatio;
      }
      
      public function get stableList() : Array {
         return this._stableList;
      }
      
      public function get paddockList() : Array {
         return this._paddockList;
      }
      
      public function pushed() : Boolean {
         this._mountDialogFrame = new MountDialogFrame();
         return true;
      }
      
      public function initializeMountLists(param1:Vector.<MountClientData>, param2:Vector.<MountClientData>) : void {
         var _loc3_:MountClientData = null;
         this._stableList = new Array();
         if(param1)
         {
            for each (_loc3_ in param1)
            {
               this._stableList.push(MountData.makeMountData(_loc3_,true,this._mountXpRatio));
            }
         }
         this._paddockList = new Array();
         if(param2)
         {
            for each (_loc3_ in param2)
            {
               this._paddockList.push(MountData.makeMountData(_loc3_,true,this._mountXpRatio));
            }
         }
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:MountData = null;
         var _loc3_:MountInformationInPaddockRequestAction = null;
         var _loc4_:MountInformationInPaddockRequestMessage = null;
         var _loc5_:IMovable = null;
         var _loc6_:MountFeedRequestAction = null;
         var _loc7_:MountReleaseRequestMessage = null;
         var _loc8_:MountSterilizeRequestMessage = null;
         var _loc9_:MountRenameRequestAction = null;
         var _loc10_:MountRenameRequestMessage = null;
         var _loc11_:MountSetXpRatioRequestAction = null;
         var _loc12_:MountSetXpRatioRequestMessage = null;
         var _loc13_:MountInfoRequestAction = null;
         var _loc14_:MountInformationRequestMessage = null;
         var _loc15_:ExchangeRequestOnMountStockMessage = null;
         var _loc16_:MountRenamedMessage = null;
         var _loc17_:* = NaN;
         var _loc18_:String = null;
         var _loc19_:ExchangeHandleMountStableAction = null;
         var _loc20_:ExchangeHandleMountStableMessage = null;
         var _loc21_:ExchangeMountStableBornAddMessage = null;
         var _loc22_:ExchangeMountStableAddMessage = null;
         var _loc23_:ExchangeMountStableRemoveMessage = null;
         var _loc24_:ExchangeMountPaddockAddMessage = null;
         var _loc25_:ExchangeMountPaddockRemoveMessage = null;
         var _loc26_:MountDataMessage = null;
         var _loc27_:* = false;
         var _loc28_:AnimatedCharacter = null;
         var _loc29_:RoleplayEntitiesFrame = null;
         var _loc30_:MountEquipedErrorMessage = null;
         var _loc31_:String = null;
         var _loc32_:ExchangeWeightMessage = null;
         var _loc33_:ExchangeStartOkMountMessage = null;
         var _loc34_:ExchangeStartOkMountWithOutPaddockMessage = null;
         var _loc35_:UpdateMountBoostMessage = null;
         var _loc36_:Object = null;
         var _loc37_:MountEmoteIconUsedOkMessage = null;
         var _loc38_:TiphonSprite = null;
         var _loc39_:ExchangeMountTakenFromPaddockMessage = null;
         var _loc40_:String = null;
         var _loc41_:MountReleasedMessage = null;
         var _loc42_:MountToggleRidingRequestMessage = null;
         var _loc43_:MountFeedRequestMessage = null;
         var _loc44_:* = 0;
         var _loc45_:Emoticon = null;
         var _loc46_:String = null;
         var _loc47_:Object = null;
         var _loc48_:UpdateMountBoost = null;
         var _loc49_:UpdateMountIntBoost = null;
         var _loc50_:String = null;
         var _loc51_:SerialSequencer = null;
         switch(true)
         {
            case param1 is MountInformationInPaddockRequestAction:
               _loc3_ = param1 as MountInformationInPaddockRequestAction;
               _loc4_ = new MountInformationInPaddockRequestMessage();
               _loc4_.initMountInformationInPaddockRequestMessage(_loc3_.mountId);
               ConnectionsHandler.getConnection().send(_loc4_);
               return true;
            case param1 is MountToggleRidingRequestAction:
               _loc5_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IMovable;
               if((_loc5_) && !_loc5_.isMoving)
               {
                  _loc42_ = new MountToggleRidingRequestMessage();
                  _loc42_.initMountToggleRidingRequestMessage();
                  ConnectionsHandler.getConnection().send(_loc42_);
               }
               return true;
            case param1 is MountFeedRequestAction:
               _loc6_ = param1 as MountFeedRequestAction;
               if(Kernel.getWorker().getFrame(FightBattleFrame) == null)
               {
                  _loc43_ = new MountFeedRequestMessage();
                  _loc43_.initMountFeedRequestMessage(_loc6_.mountId,_loc6_.mountLocation,_loc6_.mountFoodUid,_loc6_.quantity);
                  ConnectionsHandler.getConnection().send(_loc43_);
               }
               return true;
            case param1 is MountReleaseRequestAction:
               _loc7_ = new MountReleaseRequestMessage();
               _loc7_.initMountReleaseRequestMessage();
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is MountSterilizeRequestAction:
               _loc8_ = new MountSterilizeRequestMessage();
               _loc8_.initMountSterilizeRequestMessage();
               ConnectionsHandler.getConnection().send(_loc8_);
               return true;
            case param1 is MountRenameRequestAction:
               _loc9_ = param1 as MountRenameRequestAction;
               _loc10_ = new MountRenameRequestMessage();
               _loc10_.initMountRenameRequestMessage(_loc9_.newName?_loc9_.newName:"",_loc9_.mountId);
               ConnectionsHandler.getConnection().send(_loc10_);
               return true;
            case param1 is MountSetXpRatioRequestAction:
               _loc11_ = param1 as MountSetXpRatioRequestAction;
               _loc12_ = new MountSetXpRatioRequestMessage();
               _loc12_.initMountSetXpRatioRequestMessage(_loc11_.xpRatio > MAX_XP_RATIO?MAX_XP_RATIO:_loc11_.xpRatio);
               ConnectionsHandler.getConnection().send(_loc12_);
               return true;
            case param1 is MountInfoRequestAction:
               _loc13_ = param1 as MountInfoRequestAction;
               _loc14_ = new MountInformationRequestMessage();
               _loc14_.initMountInformationRequestMessage(_loc13_.mountId,_loc13_.time);
               ConnectionsHandler.getConnection().send(_loc14_);
               return true;
            case param1 is ExchangeRequestOnMountStockAction:
               _loc15_ = new ExchangeRequestOnMountStockMessage();
               _loc15_.initExchangeRequestOnMountStockMessage();
               ConnectionsHandler.getConnection().send(_loc15_);
               return true;
            case param1 is MountSterilizedMessage:
               _loc17_ = MountSterilizedMessage(param1).mountId;
               _loc2_ = MountData.getMountFromCache(_loc17_);
               if(_loc2_)
               {
                  _loc2_.reproductionCount = -1;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSterilized,_loc17_);
               return true;
            case param1 is MountRenamedMessage:
               _loc16_ = param1 as MountRenamedMessage;
               _loc17_ = _loc16_.mountId;
               _loc18_ = _loc16_.name;
               _loc2_ = MountData.getMountFromCache(_loc17_);
               if(_loc2_)
               {
                  _loc2_.name = _loc18_;
               }
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRenamed,_loc17_,_loc18_);
               return true;
            case param1 is ExchangeHandleMountStableAction:
               _loc19_ = param1 as ExchangeHandleMountStableAction;
               _loc20_ = new ExchangeHandleMountStableMessage();
               _loc20_.initExchangeHandleMountStableMessage(_loc19_.actionType,_loc19_.rideId);
               ConnectionsHandler.getConnection().send(_loc20_);
               return true;
            case param1 is ExchangeMountStableBornAddMessage:
               _loc21_ = param1 as ExchangeMountStableBornAddMessage;
               _loc2_ = MountData.makeMountData(_loc21_.mountDescription,true,this._mountXpRatio);
               _loc2_.borning = true;
               if(this._stableList)
               {
                  this._stableList.push(_loc2_);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case param1 is ExchangeMountStableAddMessage:
               _loc22_ = param1 as ExchangeMountStableAddMessage;
               if(this._stableList)
               {
                  this._stableList.push(MountData.makeMountData(_loc22_.mountDescription,true,this._mountXpRatio));
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case param1 is ExchangeMountStableRemoveMessage:
               _loc23_ = param1 as ExchangeMountStableRemoveMessage;
               _loc44_ = 0;
               while(_loc44_ < this._stableList.length)
               {
                  if(this._stableList[_loc44_].id == _loc23_.mountId)
                  {
                     this._stableList.splice(_loc44_,1);
                     break;
                  }
                  _loc44_++;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case param1 is ExchangeMountPaddockAddMessage:
               _loc24_ = param1 as ExchangeMountPaddockAddMessage;
               this._paddockList.push(MountData.makeMountData(_loc24_.mountDescription,true,this._mountXpRatio));
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case param1 is ExchangeMountPaddockRemoveMessage:
               _loc25_ = param1 as ExchangeMountPaddockRemoveMessage;
               _loc44_ = 0;
               while(_loc44_ < this._paddockList.length)
               {
                  if(this._paddockList[_loc44_].id == _loc25_.mountId)
                  {
                     this._paddockList.splice(_loc44_,1);
                     break;
                  }
                  _loc44_++;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case param1 is MountXpRatioMessage:
               this._mountXpRatio = MountXpRatioMessage(param1).ratio;
               _loc2_ = PlayedCharacterManager.getInstance().mount;
               if(_loc2_)
               {
                  _loc2_.xpRatio = this._mountXpRatio;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountXpRatio,this._mountXpRatio);
               return true;
            case param1 is MountDataMessage:
               _loc26_ = param1 as MountDataMessage;
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.CertificateMountData,MountData.makeMountData(_loc26_.mountData,false,this.mountXpRatio));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.PaddockedMountData,MountData.makeMountData(_loc26_.mountData,false,this.mountXpRatio));
               }
               return true;
            case param1 is MountRidingMessage:
               _loc27_ = MountRidingMessage(param1).isRiding;
               _loc28_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               _loc29_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if((_loc28_) && (_loc29_))
               {
                  _loc45_ = Emoticon.getEmoticonById(_loc29_.currentEmoticon);
                  if(_loc28_.getAnimation().indexOf("_Statique_") != -1)
                  {
                     _loc46_ = _loc28_.getAnimation();
                  }
                  else
                  {
                     if((_loc45_) && (_loc45_.persistancy))
                     {
                        _loc46_ = _loc28_.getAnimation().replace("_","_Statique_");
                     }
                  }
                  if(_loc46_)
                  {
                     (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).lastStaticAnimations[_loc28_.id] = {"anim":_loc46_};
                  }
                  _loc28_.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               PlayedCharacterManager.getInstance().isRidding = _loc27_;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,_loc27_);
               return true;
            case param1 is MountEquipedErrorMessage:
               _loc30_ = MountEquipedErrorMessage(param1);
               switch(_loc30_.errorType)
               {
                  case MountEquipedErrorEnum.UNSET:
                     _loc31_ = "UNSET";
                     break;
                  case MountEquipedErrorEnum.SET:
                     _loc31_ = "SET";
                     break;
                  case MountEquipedErrorEnum.RIDING:
                     _loc31_ = "RIDING";
                     KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,false);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountEquipedError,_loc31_);
               return true;
            case param1 is ExchangeWeightMessage:
               _loc32_ = param1 as ExchangeWeightMessage;
               this._inventoryWeight = _loc32_.currentWeight;
               this._inventoryMaxWeight = _loc32_.maxWeight;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight,_loc32_.currentWeight,_loc32_.maxWeight);
               return true;
            case param1 is ExchangeStartOkMountMessage:
               _loc33_ = param1 as ExchangeStartOkMountMessage;
               TooltipManager.hideAll();
               this.initializeMountLists(_loc33_.stabledMountsDescription,_loc33_.paddockedMountsDescription);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case param1 is MountSetMessage:
               PlayedCharacterManager.getInstance().mount = MountData.makeMountData(MountSetMessage(param1).mountData,false,this.mountXpRatio);
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSet);
               return true;
            case param1 is MountUnSetMessage:
               PlayedCharacterManager.getInstance().mount = null;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountUnSet);
               return true;
            case param1 is ExchangeStartOkMountWithOutPaddockMessage:
               _loc34_ = param1 as ExchangeStartOkMountWithOutPaddockMessage;
               this.initializeMountLists(_loc34_.stabledMountsDescription,null);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case param1 is UpdateMountBoostMessage:
               _loc35_ = param1 as UpdateMountBoostMessage;
               _loc36_ = null;
               for each (_loc47_ in this._paddockList)
               {
                  if(_loc47_.id == _loc35_.rideId)
                  {
                     _loc36_ = _loc47_;
                     break;
                  }
               }
               if(!_loc36_)
               {
                  _log.error("Can\'t find " + _loc35_.rideId + " ride ID for update mount boost");
                  return true;
               }
               for each (_loc48_ in _loc35_.boostToUpdateList)
               {
                  if(_loc48_ is UpdateMountIntBoost)
                  {
                     _loc49_ = _loc48_ as UpdateMountIntBoost;
                     switch(_loc49_.type)
                     {
                        case UpdatableMountBoostEnum.ENERGY:
                           _loc36_.energy = _loc49_.value;
                           continue;
                        case UpdatableMountBoostEnum.LOVE:
                           _loc36_.love = _loc49_.value;
                           continue;
                        case UpdatableMountBoostEnum.MATURITY:
                           _loc36_.maturity = _loc49_.value;
                           continue;
                        case UpdatableMountBoostEnum.SERENITY:
                           _loc36_.serenity = _loc49_.value;
                           continue;
                        case UpdatableMountBoostEnum.STAMINA:
                           _loc36_.stamina = _loc49_.value;
                           continue;
                        case UpdatableMountBoostEnum.TIREDNESS:
                           _loc36_.boostLimiter = _loc49_.value;
                        default:
                           continue;
                     }
                  }
                  else
                  {
                     continue;
                  }
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case param1 is MountEmoteIconUsedOkMessage:
               _loc37_ = param1 as MountEmoteIconUsedOkMessage;
               _loc38_ = DofusEntities.getEntity(_loc37_.mountId) as TiphonSprite;
               if(_loc38_)
               {
                  _loc50_ = null;
                  switch(_loc37_.reactionType)
                  {
                     case 1:
                        _loc50_ = "AnimEmoteRest_Statique";
                        break;
                     case 2:
                        _loc50_ = "AnimAttaque0";
                        break;
                     case 3:
                        _loc50_ = "AnimEmoteCaresse";
                        break;
                     case 4:
                        _loc50_ = "AnimEmoteReproductionF";
                        break;
                     case 5:
                        _loc50_ = "AnimEmoteReproductionM";
                        break;
                  }
                  if(_loc50_)
                  {
                     _loc51_ = new SerialSequencer();
                     _loc51_.addStep(new PlayAnimationStep(_loc38_,_loc50_,false));
                     _loc51_.addStep(new SetAnimationStep(_loc38_,AnimationEnum.ANIM_STATIQUE));
                     _loc51_.start();
                  }
               }
               return true;
            case param1 is ExchangeMountTakenFromPaddockMessage:
               _loc39_ = param1 as ExchangeMountTakenFromPaddockMessage;
               _loc40_ = I18n.getUiText("ui.mount.takenFromPaddock",[_loc39_.name,"[" + _loc39_.worldX + "," + _loc39_.worldY + "]",_loc39_.ownername]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc40_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is MountReleasedMessage:
               _loc41_ = param1 as MountReleasedMessage;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountReleased,_loc41_.mountId);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function get inventoryWeight() : uint {
         return this._inventoryWeight;
      }
      
      public function get inventoryMaxWeight() : uint {
         return this._inventoryMaxWeight;
      }
   }
}
