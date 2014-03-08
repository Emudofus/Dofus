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
      
      public function initializeMountLists(stables:Vector.<MountClientData>, paddocks:Vector.<MountClientData>) : void {
         var mcd:MountClientData = null;
         this._stableList = new Array();
         if(stables)
         {
            for each (mcd in stables)
            {
               this._stableList.push(MountData.makeMountData(mcd,true,this._mountXpRatio));
            }
         }
         this._paddockList = new Array();
         if(paddocks)
         {
            for each (mcd in paddocks)
            {
               this._paddockList.push(MountData.makeMountData(mcd,true,this._mountXpRatio));
            }
         }
      }
      
      public function process(msg:Message) : Boolean {
         var mount:MountData = null;
         var miipra:MountInformationInPaddockRequestAction = null;
         var miiprmsg:MountInformationInPaddockRequestMessage = null;
         var playerEntity:IMovable = null;
         var mtfra:MountFeedRequestAction = null;
         var mrrmsg:MountReleaseRequestMessage = null;
         var msrmsg:MountSterilizeRequestMessage = null;
         var mrra:MountRenameRequestAction = null;
         var mountRenameRequestMessage:MountRenameRequestMessage = null;
         var msxrra:MountSetXpRatioRequestAction = null;
         var msxrpmsg:MountSetXpRatioRequestMessage = null;
         var mira:MountInfoRequestAction = null;
         var mirmsg:MountInformationRequestMessage = null;
         var eromsmsg:ExchangeRequestOnMountStockMessage = null;
         var mrmsg:MountRenamedMessage = null;
         var mountId:* = NaN;
         var mountName:String = null;
         var ehmsa:ExchangeHandleMountStableAction = null;
         var ehmsmsg:ExchangeHandleMountStableMessage = null;
         var emsbamsg:ExchangeMountStableBornAddMessage = null;
         var emsamsg:ExchangeMountStableAddMessage = null;
         var emsrmsg:ExchangeMountStableRemoveMessage = null;
         var empamsg:ExchangeMountPaddockAddMessage = null;
         var emprmsg:ExchangeMountPaddockRemoveMessage = null;
         var mdmsg:MountDataMessage = null;
         var isRiding:* = false;
         var player:AnimatedCharacter = null;
         var rpEntitiesFrame:RoleplayEntitiesFrame = null;
         var meemsg:MountEquipedErrorMessage = null;
         var typeError:String = null;
         var ewmsg:ExchangeWeightMessage = null;
         var esokmmsg:ExchangeStartOkMountMessage = null;
         var esomwopmsg:ExchangeStartOkMountWithOutPaddockMessage = null;
         var umbmsg:UpdateMountBoostMessage = null;
         var mountToUpdate:Object = null;
         var meiuomsg:MountEmoteIconUsedOkMessage = null;
         var mountSprite:TiphonSprite = null;
         var emtfpmsg:ExchangeMountTakenFromPaddockMessage = null;
         var takenMessage:String = null;
         var mremsg:MountReleasedMessage = null;
         var mtrrmsg:MountToggleRidingRequestMessage = null;
         var mfrmsg:MountFeedRequestMessage = null;
         var i:* = 0;
         var currentEmote:Emoticon = null;
         var lastStaticAnim:String = null;
         var m:Object = null;
         var boost:UpdateMountBoost = null;
         var intBoost:UpdateMountIntBoost = null;
         var animationName:String = null;
         var seq:SerialSequencer = null;
         switch(true)
         {
            case msg is MountInformationInPaddockRequestAction:
               miipra = msg as MountInformationInPaddockRequestAction;
               miiprmsg = new MountInformationInPaddockRequestMessage();
               miiprmsg.initMountInformationInPaddockRequestMessage(miipra.mountId);
               ConnectionsHandler.getConnection().send(miiprmsg);
               return true;
            case msg is MountToggleRidingRequestAction:
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IMovable;
               if((playerEntity) && (!playerEntity.isMoving))
               {
                  mtrrmsg = new MountToggleRidingRequestMessage();
                  mtrrmsg.initMountToggleRidingRequestMessage();
                  ConnectionsHandler.getConnection().send(mtrrmsg);
               }
               return true;
            case msg is MountFeedRequestAction:
               mtfra = msg as MountFeedRequestAction;
               if(Kernel.getWorker().getFrame(FightBattleFrame) == null)
               {
                  mfrmsg = new MountFeedRequestMessage();
                  mfrmsg.initMountFeedRequestMessage(mtfra.mountId,mtfra.mountLocation,mtfra.mountFoodUid,mtfra.quantity);
                  ConnectionsHandler.getConnection().send(mfrmsg);
               }
               return true;
            case msg is MountReleaseRequestAction:
               mrrmsg = new MountReleaseRequestMessage();
               mrrmsg.initMountReleaseRequestMessage();
               ConnectionsHandler.getConnection().send(mrrmsg);
               return true;
            case msg is MountSterilizeRequestAction:
               msrmsg = new MountSterilizeRequestMessage();
               msrmsg.initMountSterilizeRequestMessage();
               ConnectionsHandler.getConnection().send(msrmsg);
               return true;
            case msg is MountRenameRequestAction:
               mrra = msg as MountRenameRequestAction;
               mountRenameRequestMessage = new MountRenameRequestMessage();
               mountRenameRequestMessage.initMountRenameRequestMessage(mrra.newName?mrra.newName:"",mrra.mountId);
               ConnectionsHandler.getConnection().send(mountRenameRequestMessage);
               return true;
            case msg is MountSetXpRatioRequestAction:
               msxrra = msg as MountSetXpRatioRequestAction;
               msxrpmsg = new MountSetXpRatioRequestMessage();
               msxrpmsg.initMountSetXpRatioRequestMessage(msxrra.xpRatio > MAX_XP_RATIO?MAX_XP_RATIO:msxrra.xpRatio);
               ConnectionsHandler.getConnection().send(msxrpmsg);
               return true;
            case msg is MountInfoRequestAction:
               mira = msg as MountInfoRequestAction;
               mirmsg = new MountInformationRequestMessage();
               mirmsg.initMountInformationRequestMessage(mira.mountId,mira.time);
               ConnectionsHandler.getConnection().send(mirmsg);
               return true;
            case msg is ExchangeRequestOnMountStockAction:
               eromsmsg = new ExchangeRequestOnMountStockMessage();
               eromsmsg.initExchangeRequestOnMountStockMessage();
               ConnectionsHandler.getConnection().send(eromsmsg);
               return true;
            case msg is MountSterilizedMessage:
               mountId = MountSterilizedMessage(msg).mountId;
               mount = MountData.getMountFromCache(mountId);
               if(mount)
               {
                  mount.reproductionCount = -1;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSterilized,mountId);
               return true;
            case msg is MountRenamedMessage:
               mrmsg = msg as MountRenamedMessage;
               mountId = mrmsg.mountId;
               mountName = mrmsg.name;
               mount = MountData.getMountFromCache(mountId);
               if(mount)
               {
                  mount.name = mountName;
               }
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRenamed,mountId,mountName);
               return true;
            case msg is ExchangeHandleMountStableAction:
               ehmsa = msg as ExchangeHandleMountStableAction;
               ehmsmsg = new ExchangeHandleMountStableMessage();
               ehmsmsg.initExchangeHandleMountStableMessage(ehmsa.actionType,ehmsa.rideId);
               ConnectionsHandler.getConnection().send(ehmsmsg);
               return true;
            case msg is ExchangeMountStableBornAddMessage:
               emsbamsg = msg as ExchangeMountStableBornAddMessage;
               mount = MountData.makeMountData(emsbamsg.mountDescription,true,this._mountXpRatio);
               mount.borning = true;
               if(this._stableList)
               {
                  this._stableList.push(mount);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountStableAddMessage:
               emsamsg = msg as ExchangeMountStableAddMessage;
               if(this._stableList)
               {
                  this._stableList.push(MountData.makeMountData(emsamsg.mountDescription,true,this._mountXpRatio));
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountStableRemoveMessage:
               emsrmsg = msg as ExchangeMountStableRemoveMessage;
               i = 0;
               while(i < this._stableList.length)
               {
                  if(this._stableList[i].id == emsrmsg.mountId)
                  {
                     this._stableList.splice(i,1);
                     break;
                  }
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountPaddockAddMessage:
               empamsg = msg as ExchangeMountPaddockAddMessage;
               this._paddockList.push(MountData.makeMountData(empamsg.mountDescription,true,this._mountXpRatio));
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case msg is ExchangeMountPaddockRemoveMessage:
               emprmsg = msg as ExchangeMountPaddockRemoveMessage;
               i = 0;
               while(i < this._paddockList.length)
               {
                  if(this._paddockList[i].id == emprmsg.mountId)
                  {
                     this._paddockList.splice(i,1);
                     break;
                  }
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case msg is MountXpRatioMessage:
               this._mountXpRatio = MountXpRatioMessage(msg).ratio;
               mount = PlayedCharacterManager.getInstance().mount;
               if(mount)
               {
                  mount.xpRatio = this._mountXpRatio;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountXpRatio,this._mountXpRatio);
               return true;
            case msg is MountDataMessage:
               mdmsg = msg as MountDataMessage;
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.CertificateMountData,MountData.makeMountData(mdmsg.mountData,false,this.mountXpRatio));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.PaddockedMountData,MountData.makeMountData(mdmsg.mountData,false,this.mountXpRatio));
               }
               return true;
            case msg is MountRidingMessage:
               isRiding = MountRidingMessage(msg).isRiding;
               player = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               rpEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if((player) && (rpEntitiesFrame))
               {
                  currentEmote = Emoticon.getEmoticonById(rpEntitiesFrame.currentEmoticon);
                  if(player.getAnimation().indexOf("_Statique_") != -1)
                  {
                     lastStaticAnim = player.getAnimation();
                  }
                  else
                  {
                     if((currentEmote) && (currentEmote.persistancy))
                     {
                        lastStaticAnim = player.getAnimation().replace("_","_Statique_");
                     }
                  }
                  if(lastStaticAnim)
                  {
                     (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).lastStaticAnimations[player.id] = {"anim":lastStaticAnim};
                  }
                  player.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               PlayedCharacterManager.getInstance().isRidding = isRiding;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,isRiding);
               return true;
            case msg is MountEquipedErrorMessage:
               meemsg = MountEquipedErrorMessage(msg);
               switch(meemsg.errorType)
               {
                  case MountEquipedErrorEnum.UNSET:
                     typeError = "UNSET";
                     break;
                  case MountEquipedErrorEnum.SET:
                     typeError = "SET";
                     break;
                  case MountEquipedErrorEnum.RIDING:
                     typeError = "RIDING";
                     KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,false);
                     break;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountEquipedError,typeError);
               return true;
            case msg is ExchangeWeightMessage:
               ewmsg = msg as ExchangeWeightMessage;
               this._inventoryWeight = ewmsg.currentWeight;
               this._inventoryMaxWeight = ewmsg.maxWeight;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight,ewmsg.currentWeight,ewmsg.maxWeight);
               return true;
            case msg is ExchangeStartOkMountMessage:
               esokmmsg = msg as ExchangeStartOkMountMessage;
               TooltipManager.hideAll();
               this.initializeMountLists(esokmmsg.stabledMountsDescription,esokmmsg.paddockedMountsDescription);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case msg is MountSetMessage:
               PlayedCharacterManager.getInstance().mount = MountData.makeMountData(MountSetMessage(msg).mountData,false,this.mountXpRatio);
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSet);
               return true;
            case msg is MountUnSetMessage:
               PlayedCharacterManager.getInstance().mount = null;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountUnSet);
               return true;
            case msg is ExchangeStartOkMountWithOutPaddockMessage:
               esomwopmsg = msg as ExchangeStartOkMountWithOutPaddockMessage;
               this.initializeMountLists(esomwopmsg.stabledMountsDescription,null);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case msg is UpdateMountBoostMessage:
               umbmsg = msg as UpdateMountBoostMessage;
               mountToUpdate = null;
               for each (m in this._paddockList)
               {
                  if(m.id == umbmsg.rideId)
                  {
                     mountToUpdate = m;
                     break;
                  }
               }
               if(!mountToUpdate)
               {
                  _log.error("Can\'t find " + umbmsg.rideId + " ride ID for update mount boost");
                  return true;
               }
               for each (boost in umbmsg.boostToUpdateList)
               {
                  if(boost is UpdateMountIntBoost)
                  {
                     intBoost = boost as UpdateMountIntBoost;
                     switch(intBoost.type)
                     {
                        case UpdatableMountBoostEnum.ENERGY:
                           mountToUpdate.energy = intBoost.value;
                           continue;
                        case UpdatableMountBoostEnum.LOVE:
                           mountToUpdate.love = intBoost.value;
                           continue;
                        case UpdatableMountBoostEnum.MATURITY:
                           mountToUpdate.maturity = intBoost.value;
                           continue;
                        case UpdatableMountBoostEnum.SERENITY:
                           mountToUpdate.serenity = intBoost.value;
                           continue;
                        case UpdatableMountBoostEnum.STAMINA:
                           mountToUpdate.stamina = intBoost.value;
                           continue;
                        case UpdatableMountBoostEnum.TIREDNESS:
                           mountToUpdate.boostLimiter = intBoost.value;
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
            case msg is MountEmoteIconUsedOkMessage:
               meiuomsg = msg as MountEmoteIconUsedOkMessage;
               mountSprite = DofusEntities.getEntity(meiuomsg.mountId) as TiphonSprite;
               if(mountSprite)
               {
                  animationName = null;
                  switch(meiuomsg.reactionType)
                  {
                     case 1:
                        animationName = "AnimEmoteRest_Statique";
                        break;
                     case 2:
                        animationName = "AnimAttaque0";
                        break;
                     case 3:
                        animationName = "AnimEmoteCaresse";
                        break;
                     case 4:
                        animationName = "AnimEmoteReproductionF";
                        break;
                     case 5:
                        animationName = "AnimEmoteReproductionM";
                        break;
                  }
                  if(animationName)
                  {
                     seq = new SerialSequencer();
                     seq.addStep(new PlayAnimationStep(mountSprite,animationName,false));
                     seq.addStep(new SetAnimationStep(mountSprite,AnimationEnum.ANIM_STATIQUE));
                     seq.start();
                  }
               }
               return true;
            case msg is ExchangeMountTakenFromPaddockMessage:
               emtfpmsg = msg as ExchangeMountTakenFromPaddockMessage;
               takenMessage = I18n.getUiText("ui.mount.takenFromPaddock",[emtfpmsg.name,"[" + emtfpmsg.worldX + "," + emtfpmsg.worldY + "]",emtfpmsg.ownername]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,takenMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is MountReleasedMessage:
               mremsg = msg as MountReleasedMessage;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountReleased,mremsg.mountId);
               return true;
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
