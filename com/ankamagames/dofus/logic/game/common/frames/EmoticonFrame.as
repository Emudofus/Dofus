package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteAddMessage;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteRemoveMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMassiveMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenBeginMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenEndMessage;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import flash.utils.setInterval;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.utils.clearInterval;
   
   public class EmoticonFrame extends Object implements Frame
   {
      
      public function EmoticonFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoticonFrame));
      
      private var _emotes:Array;
      
      private var _emotesList:Array;
      
      private var _interval:Number;
      
      private var _bEmoteOn:Boolean = false;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get emotes() : Array {
         this._emotes.sort(Array.NUMERIC);
         return this._emotes;
      }
      
      public function get emotesList() : Array {
         this._emotesList.sortOn("order",Array.NUMERIC);
         return this._emotesList;
      }
      
      private function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function pushed() : Boolean {
         this._emotes = new Array();
         this._emotesList = new Array();
         return true;
      }
      
      public function isKnownEmote(id:int) : Boolean {
         return !(this._emotes.indexOf(id) == -1);
      }
      
      public function process(msg:Message) : Boolean {
         var shortcut:ShortcutWrapper = null;
         var elmsg:EmoteListMessage = null;
         var pos:uint = 0;
         var eamsg:EmoteAddMessage = null;
         var ew:EmoteWrapper = null;
         var em:Emoticon = null;
         var emoteWAdd:EmoteWrapper = null;
         var addText:String = null;
         var ermsg:EmoteRemoveMessage = null;
         var removeText:String = null;
         var epra:EmotePlayRequestAction = null;
         var emoteObj:Emoticon = null;
         var emote:EmoteWrapper = null;
         var eprmsg:EmotePlayRequestMessage = null;
         var playerEntity:IEntity = null;
         var epmsg:EmotePlayMessage = null;
         var entityInfo:GameContextActorInformations = null;
         var epmmsg:EmotePlayMassiveMessage = null;
         var epemsg:EmotePlayErrorMessage = null;
         var errorText:String = null;
         var lprbmsg:LifePointsRegenBeginMessage = null;
         var lpremsg:LifePointsRegenEndMessage = null;
         var id:* = undefined;
         var emoteW:EmoteWrapper = null;
         var i:* = undefined;
         var eamsgNid:uint = 0;
         var ire:* = 0;
         var ire2:* = 0;
         var e:Emoticon = null;
         var tiphonLook:TiphonEntityLook = null;
         var anim:String = null;
         var persistancy:* = false;
         var directions8:* = false;
         var actor:* = undefined;
         var mEntityInfo:GameContextActorInformations = null;
         var tiphonMassiveLook:TiphonEntityLook = null;
         var mAnim:String = null;
         var mPersistancy:* = false;
         var mDirections8:* = false;
         var regenText:String = null;
         switch(true)
         {
            case msg is EmoteListMessage:
               elmsg = msg as EmoteListMessage;
               this._emotes = new Array();
               this._emotesList.splice(0,this._emotesList.length);
               pos = 0;
               for each (id in elmsg.emoteIds)
               {
                  this._emotes.push(id);
                  emoteW = EmoteWrapper.create(id,pos);
                  this._emotesList.push(emoteW);
                  pos++;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((shortcut) && (shortcut.type == 4))
                  {
                     if(this._emotes.indexOf(shortcut.id) != -1)
                     {
                        shortcut.active = true;
                     }
                     else
                     {
                        shortcut.active = false;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
               return true;
            case msg is EmoteAddMessage:
               eamsg = msg as EmoteAddMessage;
               for (i in this._emotes)
               {
                  if(this._emotes[i] == eamsg.emoteId)
                  {
                     return true;
                  }
               }
               for each (ew in this._emotesList)
               {
                  if(ew.id == eamsg.emoteId)
                  {
                     return true;
                  }
               }
               em = Emoticon.getEmoticonById(eamsg.emoteId);
               if(!em)
               {
                  return true;
               }
               this._emotes.push(eamsg.emoteId);
               emoteWAdd = EmoteWrapper.create(eamsg.emoteId,this._emotes.length);
               this._emotesList.push(emoteWAdd);
               if(!StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + eamsg.emoteId))
               {
                  StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + eamsg.emoteId,true);
                  eamsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.emotes"),I18n.getUiText("ui.common.emoteAdded",[em.name]),NotificationTypeEnum.TUTORIAL,"new_emote_" + eamsg.emoteId);
                  NotificationManager.getInstance().addButtonToNotification(eamsgNid,I18n.getUiText("ui.common.details"),"OpenSmileys",[1,true],true,130);
                  NotificationManager.getInstance().sendNotification(eamsgNid);
               }
               addText = I18n.getUiText("ui.common.emoteAdded",[Emoticon.getEmoticonById(eamsg.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,addText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((shortcut) && (shortcut.type == 4) && (shortcut.id == eamsg.emoteId))
                  {
                     shortcut.active = true;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case msg is EmoteRemoveMessage:
               ermsg = msg as EmoteRemoveMessage;
               ire = 0;
               while(ire < this._emotes.length)
               {
                  if(this._emotes[ire] == ermsg.emoteId)
                  {
                     this._emotes[ire] = null;
                     this._emotes.splice(ire,1);
                     break;
                  }
                  ire++;
               }
               ire2 = 0;
               while(ire2 < this._emotesList.length)
               {
                  if(this._emotesList[ire2].id == ermsg.emoteId)
                  {
                     this._emotesList[ire2] = null;
                     this._emotesList.splice(ire2,1);
                     break;
                  }
                  ire2++;
               }
               removeText = I18n.getUiText("ui.common.emoteRemoved",[Emoticon.getEmoticonById(ermsg.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,removeText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((shortcut) && (shortcut.type == 4) && (shortcut.id == ermsg.emoteId))
                  {
                     shortcut.active = false;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case msg is EmotePlayRequestAction:
               epra = msg as EmotePlayRequestAction;
               emoteObj = Emoticon.getEmoticonById(epra.emoteId);
               if(!emoteObj)
               {
                  return true;
               }
               emote = EmoteWrapper.getEmoteWrapperById(emoteObj.id);
               if((!emote) || (emote) && (emote.timer > 0))
               {
                  return true;
               }
               EmoteWrapper.getEmoteWrapperById(emoteObj.id).timerToStart = emoteObj.cooldown;
               eprmsg = new EmotePlayRequestMessage();
               eprmsg.initEmotePlayRequestMessage(epra.emoteId);
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if(!playerEntity)
               {
                  return true;
               }
               if((playerEntity as IMovable).isMoving)
               {
                  this.roleplayMovementFrame.setFollowingMessage(eprmsg);
                  (playerEntity as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(eprmsg);
               }
               return true;
            case msg is EmotePlayMessage:
               epmsg = msg as EmotePlayMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               delete this.roleplayEntitiesFrame.lastStaticAnimations[[epmsg.actorId]];
               entityInfo = this.roleplayEntitiesFrame.getEntityInfos(epmsg.actorId);
               AccountManager.getInstance().setAccountFromId(epmsg.actorId,epmsg.accountId);
               if((entityInfo is GameRolePlayCharacterInformations) && (this.socialFrame.isIgnored(GameRolePlayCharacterInformations(entityInfo).name,epmsg.accountId)))
               {
                  return true;
               }
               if(epmsg.emoteId == 0)
               {
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(entityInfo,AnimationEnum.ANIM_STATIQUE));
               }
               else
               {
                  if(!entityInfo)
                  {
                     return true;
                  }
                  e = Emoticon.getEmoticonById(epmsg.emoteId);
                  if(!e)
                  {
                     _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + epmsg.emoteId + "].");
                     return true;
                  }
                  tiphonLook = EntityLookAdapter.fromNetwork(entityInfo.look);
                  anim = e.getAnimName(TiphonUtility.getLookWithoutMount(tiphonLook));
                  persistancy = e.persistancy;
                  directions8 = e.eight_directions;
                  this.roleplayEntitiesFrame.currentEmoticon = epmsg.emoteId;
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(entityInfo,anim,epmsg.emoteStartTime,!persistancy,directions8));
               }
               return true;
            case msg is EmotePlayMassiveMessage:
               epmmsg = msg as EmotePlayMassiveMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               for each (actor in epmmsg.actorIds)
               {
                  mEntityInfo = this.roleplayEntitiesFrame.getEntityInfos(actor);
                  if(epmmsg.emoteId == 0)
                  {
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo,AnimationEnum.ANIM_STATIQUE));
                  }
                  else
                  {
                     tiphonMassiveLook = EntityLookAdapter.fromNetwork(mEntityInfo.look);
                     mAnim = Emoticon.getEmoticonById(epmmsg.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(tiphonMassiveLook));
                     mPersistancy = Emoticon.getEmoticonById(epmmsg.emoteId).persistancy;
                     mDirections8 = Emoticon.getEmoticonById(epmmsg.emoteId).eight_directions;
                     this.roleplayEntitiesFrame.currentEmoticon = epmmsg.emoteId;
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo,mAnim,epmmsg.emoteStartTime,!mPersistancy,mDirections8));
                  }
               }
               return true;
            case msg is EmotePlayErrorMessage:
               epemsg = msg as EmotePlayErrorMessage;
               errorText = I18n.getUiText("ui.common.cantUseEmote");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorText,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is LifePointsRegenBeginMessage:
               lprbmsg = msg as LifePointsRegenBeginMessage;
               this._interval = setInterval(this.interval,lprbmsg.regenRate * 100);
               KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin,null);
               return true;
            case msg is LifePointsRegenEndMessage:
               lpremsg = msg as LifePointsRegenEndMessage;
               if(this._bEmoteOn)
               {
                  if(lpremsg.lifePointsGained != 0)
                  {
                     regenText = I18n.getUiText("ui.common.emoteRestoreLife",[lpremsg.lifePointsGained]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,regenText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._bEmoteOn = false;
               }
               clearInterval(this._interval);
               PlayedCharacterManager.getInstance().characteristics.lifePoints = lpremsg.lifePoints;
               PlayedCharacterManager.getInstance().characteristics.maxLifePoints = lpremsg.maxLifePoints;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         if(this._interval)
         {
            clearInterval(this._interval);
         }
         return true;
      }
      
      public function interval() : void {
         if((PlayedCharacterManager.getInstance()) && (PlayedCharacterManager.getInstance().characteristics))
         {
            PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.lifePoints + 1;
            if(PlayedCharacterManager.getInstance().characteristics.lifePoints >= PlayedCharacterManager.getInstance().characteristics.maxLifePoints)
            {
               clearInterval(this._interval);
               PlayedCharacterManager.getInstance().characteristics.lifePoints = PlayedCharacterManager.getInstance().characteristics.maxLifePoints;
            }
            KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList,true);
         }
      }
   }
}
