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
      
      public function isKnownEmote(param1:int) : Boolean {
         return !(this._emotes.indexOf(param1) == -1);
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ShortcutWrapper = null;
         var _loc3_:EmoteListMessage = null;
         var _loc4_:uint = 0;
         var _loc5_:EmoteAddMessage = null;
         var _loc6_:EmoteWrapper = null;
         var _loc7_:Emoticon = null;
         var _loc8_:EmoteWrapper = null;
         var _loc9_:String = null;
         var _loc10_:EmoteRemoveMessage = null;
         var _loc11_:String = null;
         var _loc12_:EmotePlayRequestAction = null;
         var _loc13_:Emoticon = null;
         var _loc14_:EmoteWrapper = null;
         var _loc15_:EmotePlayRequestMessage = null;
         var _loc16_:IEntity = null;
         var _loc17_:EmotePlayMessage = null;
         var _loc18_:GameContextActorInformations = null;
         var _loc19_:EmotePlayMassiveMessage = null;
         var _loc20_:EmotePlayErrorMessage = null;
         var _loc21_:String = null;
         var _loc22_:LifePointsRegenBeginMessage = null;
         var _loc23_:LifePointsRegenEndMessage = null;
         var _loc24_:* = undefined;
         var _loc25_:EmoteWrapper = null;
         var _loc26_:* = undefined;
         var _loc27_:uint = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:Emoticon = null;
         var _loc31_:TiphonEntityLook = null;
         var _loc32_:String = null;
         var _loc33_:* = false;
         var _loc34_:* = false;
         var _loc35_:* = undefined;
         var _loc36_:GameContextActorInformations = null;
         var _loc37_:TiphonEntityLook = null;
         var _loc38_:String = null;
         var _loc39_:* = false;
         var _loc40_:* = false;
         var _loc41_:String = null;
         switch(true)
         {
            case param1 is EmoteListMessage:
               _loc3_ = param1 as EmoteListMessage;
               this._emotes = new Array();
               this._emotesList.splice(0,this._emotesList.length);
               _loc4_ = 0;
               for each (_loc24_ in _loc3_.emoteIds)
               {
                  this._emotes.push(_loc24_);
                  _loc25_ = EmoteWrapper.create(_loc24_,_loc4_);
                  this._emotesList.push(_loc25_);
                  _loc4_++;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (_loc2_ in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((_loc2_) && _loc2_.type == 4)
                  {
                     if(this._emotes.indexOf(_loc2_.id) != -1)
                     {
                        _loc2_.active = true;
                     }
                     else
                     {
                        _loc2_.active = false;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
               return true;
            case param1 is EmoteAddMessage:
               _loc5_ = param1 as EmoteAddMessage;
               for (_loc26_ in this._emotes)
               {
                  if(this._emotes[_loc26_] == _loc5_.emoteId)
                  {
                     return true;
                  }
               }
               for each (_loc6_ in this._emotesList)
               {
                  if(_loc6_.id == _loc5_.emoteId)
                  {
                     return true;
                  }
               }
               _loc7_ = Emoticon.getEmoticonById(_loc5_.emoteId);
               if(!_loc7_)
               {
                  return true;
               }
               this._emotes.push(_loc5_.emoteId);
               _loc8_ = EmoteWrapper.create(_loc5_.emoteId,this._emotes.length);
               this._emotesList.push(_loc8_);
               if(!StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + _loc5_.emoteId))
               {
                  StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + _loc5_.emoteId,true);
                  _loc27_ = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.emotes"),I18n.getUiText("ui.common.emoteAdded",[_loc7_.name]),NotificationTypeEnum.TUTORIAL,"new_emote_" + _loc5_.emoteId);
                  NotificationManager.getInstance().addButtonToNotification(_loc27_,I18n.getUiText("ui.common.details"),"OpenSmileys",[1,true],true,130);
                  NotificationManager.getInstance().sendNotification(_loc27_);
               }
               _loc9_ = I18n.getUiText("ui.common.emoteAdded",[Emoticon.getEmoticonById(_loc5_.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc9_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (_loc2_ in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((_loc2_) && (_loc2_.type == 4) && _loc2_.id == _loc5_.emoteId)
                  {
                     _loc2_.active = true;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case param1 is EmoteRemoveMessage:
               _loc10_ = param1 as EmoteRemoveMessage;
               _loc28_ = 0;
               while(_loc28_ < this._emotes.length)
               {
                  if(this._emotes[_loc28_] == _loc10_.emoteId)
                  {
                     this._emotes[_loc28_] = null;
                     this._emotes.splice(_loc28_,1);
                     break;
                  }
                  _loc28_++;
               }
               _loc29_ = 0;
               while(_loc29_ < this._emotesList.length)
               {
                  if(this._emotesList[_loc29_].id == _loc10_.emoteId)
                  {
                     this._emotesList[_loc29_] = null;
                     this._emotesList.splice(_loc29_,1);
                     break;
                  }
                  _loc29_++;
               }
               _loc11_ = I18n.getUiText("ui.common.emoteRemoved",[Emoticon.getEmoticonById(_loc10_.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc11_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each (_loc2_ in InventoryManager.getInstance().shortcutBarItems)
               {
                  if((_loc2_) && (_loc2_.type == 4) && _loc2_.id == _loc10_.emoteId)
                  {
                     _loc2_.active = false;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case param1 is EmotePlayRequestAction:
               _loc12_ = param1 as EmotePlayRequestAction;
               _loc13_ = Emoticon.getEmoticonById(_loc12_.emoteId);
               if(!_loc13_)
               {
                  return true;
               }
               _loc14_ = EmoteWrapper.getEmoteWrapperById(_loc13_.id);
               if(!_loc14_ || (_loc14_) && (_loc14_.timer > 0))
               {
                  return true;
               }
               EmoteWrapper.getEmoteWrapperById(_loc13_.id).timerToStart = _loc13_.cooldown;
               _loc15_ = new EmotePlayRequestMessage();
               _loc15_.initEmotePlayRequestMessage(_loc12_.emoteId);
               _loc16_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if(!_loc16_)
               {
                  return true;
               }
               if((_loc16_ as IMovable).isMoving)
               {
                  this.roleplayMovementFrame.setFollowingMessage(_loc15_);
                  (_loc16_ as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(_loc15_);
               }
               return true;
            case param1 is EmotePlayMessage:
               _loc17_ = param1 as EmotePlayMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               delete this.roleplayEntitiesFrame.lastStaticAnimations[[_loc17_.actorId]];
               _loc18_ = this.roleplayEntitiesFrame.getEntityInfos(_loc17_.actorId);
               AccountManager.getInstance().setAccountFromId(_loc17_.actorId,_loc17_.accountId);
               if(_loc18_ is GameRolePlayCharacterInformations && (this.socialFrame.isIgnored(GameRolePlayCharacterInformations(_loc18_).name,_loc17_.accountId)))
               {
                  return true;
               }
               if(_loc17_.emoteId == 0)
               {
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc18_,AnimationEnum.ANIM_STATIQUE));
               }
               else
               {
                  if(!_loc18_)
                  {
                     return true;
                  }
                  _loc30_ = Emoticon.getEmoticonById(_loc17_.emoteId);
                  if(!_loc30_)
                  {
                     _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + _loc17_.emoteId + "].");
                     return true;
                  }
                  _loc31_ = EntityLookAdapter.fromNetwork(_loc18_.look);
                  _loc32_ = _loc30_.getAnimName(TiphonUtility.getLookWithoutMount(_loc31_));
                  _loc33_ = _loc30_.persistancy;
                  _loc34_ = _loc30_.eight_directions;
                  this.roleplayEntitiesFrame.currentEmoticon = _loc17_.emoteId;
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc18_,_loc32_,_loc17_.emoteStartTime,!_loc33_,_loc34_));
               }
               return true;
            case param1 is EmotePlayMassiveMessage:
               _loc19_ = param1 as EmotePlayMassiveMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               for each (_loc35_ in _loc19_.actorIds)
               {
                  _loc36_ = this.roleplayEntitiesFrame.getEntityInfos(_loc35_);
                  if(_loc19_.emoteId == 0)
                  {
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc36_,AnimationEnum.ANIM_STATIQUE));
                  }
                  else
                  {
                     _loc37_ = EntityLookAdapter.fromNetwork(_loc36_.look);
                     _loc38_ = Emoticon.getEmoticonById(_loc19_.emoteId).getAnimName(TiphonUtility.getLookWithoutMount(_loc37_));
                     _loc39_ = Emoticon.getEmoticonById(_loc19_.emoteId).persistancy;
                     _loc40_ = Emoticon.getEmoticonById(_loc19_.emoteId).eight_directions;
                     this.roleplayEntitiesFrame.currentEmoticon = _loc19_.emoteId;
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(_loc36_,_loc38_,_loc19_.emoteStartTime,!_loc39_,_loc40_));
                  }
               }
               return true;
            case param1 is EmotePlayErrorMessage:
               _loc20_ = param1 as EmotePlayErrorMessage;
               _loc21_ = I18n.getUiText("ui.common.cantUseEmote");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc21_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case param1 is LifePointsRegenBeginMessage:
               _loc22_ = param1 as LifePointsRegenBeginMessage;
               this._interval = setInterval(this.interval,_loc22_.regenRate * 100);
               KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin,null);
               return true;
            case param1 is LifePointsRegenEndMessage:
               _loc23_ = param1 as LifePointsRegenEndMessage;
               if(this._bEmoteOn)
               {
                  if(_loc23_.lifePointsGained != 0)
                  {
                     _loc41_ = I18n.getUiText("ui.common.emoteRestoreLife",[_loc23_.lifePointsGained]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc41_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._bEmoteOn = false;
               }
               clearInterval(this._interval);
               PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc23_.lifePoints;
               PlayedCharacterManager.getInstance().characteristics.maxLifePoints = _loc23_.maxLifePoints;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               return true;
            default:
               return false;
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
