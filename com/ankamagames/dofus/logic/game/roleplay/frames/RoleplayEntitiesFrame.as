package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapInformationsRequestMessage;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedMapUpdateMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapChangeOrientationsMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayShowChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayRemoveChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundAddedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.objects.ObjectGroundListAddedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockRemoveItemRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.GameDataPaddockObjectListAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.GameDataPlayFarmObjectAnimationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.MapNpcsQuestStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HousePropertiesMessage;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.Sprite;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionEmote;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.dofus.logic.game.roleplay.types.Fight;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.factories.RolePlayEntitiesFactory;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.types.entities.RoleplayObjectEntity;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.dofus.logic.game.roleplay.types.GroundObject;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockMoveItemRequestMessage;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;


   public class RoleplayEntitiesFrame extends AbstractEntitiesFrame implements Frame
   {
         

      public function RoleplayEntitiesFrame() {
         this._paddockItem=new Dictionary();
         this._groundObjectCache=new Cache(20,new LruGarbageCollector());
         this._usableEmotes=new Array();
         this._npcList=new Dictionary(true);
         super();
      }



      private var _fights:Dictionary;

      private var _objects:Dictionary;

      private var _uri:Dictionary;

      private var _paddockItem:Dictionary;

      private var _fightNumber:uint = 0;

      private var _timeout:Number;

      private var _loader:IResourceLoader;

      private var _groundObjectCache:ICache;

      private var _currentPaddockItemCellId:uint;

      private var _usableEmotes:Array;

      private var _currentEmoticon:uint = 0;

      private var _bRequestingAura:Boolean = false;

      private var _playersId:Array;

      private var _npcList:Dictionary;

      private var _housesList:Dictionary;

      private var _emoteTimesBySprite:Dictionary;

      private var _waitForMap:Boolean;

      public function get currentEmoticon() : uint {
         return this._currentEmoticon;
      }

      public function set currentEmoticon(emoteId:uint) : void {
         this._currentEmoticon=emoteId;
      }

      public function get usableEmoticons() : Array {
         return this._usableEmotes;
      }

      public function get fightNumber() : uint {
         return this._fightNumber;
      }

      public function get currentSubAreaId() : uint {
         return _currentSubAreaId;
      }

      public function get currentSubAreaSide() : int {
         return _currentSubAreaSide;
      }

      public function get playersId() : Array {
         return this._playersId;
      }

      public function get housesInformations() : Dictionary {
         return this._housesList;
      }

      public function get fights() : Dictionary {
         return this._fights;
      }

      public function get isCreatureMode() : Boolean {
         return _creaturesMode;
      }

      override public function pushed() : Boolean {
         var mirmsg:MapInformationsRequestMessage = null;
         this.initNewMap();
         this._playersId=new Array();
         this._emoteTimesBySprite=new Dictionary();
         _humanNumber=0;
         if(MapDisplayManager.getInstance().currentMapRendered)
         {
            mirmsg=new MapInformationsRequestMessage();
            mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
            ConnectionsHandler.getConnection().send(mirmsg);
         }
         else
         {
            this._waitForMap=true;
         }
         this._loader=ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
         _interactiveElements=new Vector.<InteractiveElement>();
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._usableEmotes=new Array();
         return super.pushed();
      }

      override public function process(msg:Message) : Boolean {
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var newSubArea:SubArea = null;
         var newCreatureMode:* = false;
         var mapWithNoMonsters:* = false;
         var emoteId:* = 0;
         var emoteStartTime:* = NaN;
         var imumsg:InteractiveMapUpdateMessage = null;
         var smumsg:StatedMapUpdateMessage = null;
         var houseInformations:HouseInformations = null;
         var grpsamsg:GameRolePlayShowActorMessage = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         var gmcomsg:GameMapChangeOrientationMessage = null;
         var gmcomsg2:GameMapChangeOrientationsMessage = null;
         var num:* = 0;
         var grsamsg:GameRolePlaySetAnimationMessage = null;
         var characterEntity:AnimatedCharacter = null;
         var cmsmsg:CharacterMovementStoppedMessage = null;
         var characterEntityStopped:AnimatedCharacter = null;
         var grpsclmsg:GameRolePlayShowChallengeMessage = null;
         var gfosumsg:GameFightOptionStateUpdateMessage = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfrtmmsg:GameFightRemoveTeamMemberMessage = null;
         var grprcmsg:GameRolePlayRemoveChallengeMessage = null;
         var gcremsg:GameContextRemoveElementMessage = null;
         var playerCompt:uint = 0;
         var mfcmsg:MapFightCountMessage = null;
         var ogamsg:ObjectGroundAddedMessage = null;
         var ogrmsg:ObjectGroundRemovedMessage = null;
         var oglamsg:ObjectGroundListAddedMessage = null;
         var comptObjects:uint = 0;
         var prira:PaddockRemoveItemRequestAction = null;
         var prirmsg:PaddockRemoveItemRequestMessage = null;
         var pmira:PaddockMoveItemRequestAction = null;
         var cursorIcon:Texture = null;
         var iw:ItemWrapper = null;
         var gdpormsg:GameDataPaddockObjectRemoveMessage = null;
         var roleplayContextFrame:RoleplayContextFrame = null;
         var gdpoamsg:GameDataPaddockObjectAddMessage = null;
         var gdpolamsg:GameDataPaddockObjectListAddMessage = null;
         var gdpfoamsg:GameDataPlayFarmObjectAnimationMessage = null;
         var mnqsumsg:MapNpcsQuestStatusUpdateMessage = null;
         var scmsg:ShowCellMessage = null;
         var roleplayContextFrame2:RoleplayContextFrame = null;
         var name:String = null;
         var text:String = null;
         var sza:StartZoomAction = null;
         var player:DisplayObject = null;
         var scmamsg:SwitchCreatureModeAction = null;
         var mirmsg:MapInformationsRequestMessage = null;
         var mciwcmsg:MapComplementaryInformationsWithCoordsMessage = null;
         var mcidihmsg:MapComplementaryInformationsDataInHouseMessage = null;
         var playerHouse:* = false;
         var actor:GameRolePlayActorInformations = null;
         var actor1:GameRolePlayActorInformations = null;
         var ac:AnimatedCharacter = null;
         var hi:GameRolePlayCharacterInformations = null;
         var option:* = undefined;
         var emote:Emoticon = null;
         var staticOnly:* = false;
         var time:Date = null;
         var animNameLook:TiphonEntityLook = null;
         var fight:FightCommonInformations = null;
         var house:HouseInformations = null;
         var houseWrapper:HouseWrapper = null;
         var numDoors:* = 0;
         var i:* = 0;
         var hpmsg:HousePropertiesMessage = null;
         var mo:MapObstacle = null;
         var rpInfos:GameRolePlayCharacterInformations = null;
         var k:* = 0;
         var orientation:ActorOrientation = null;
         var myAura:Emoticon = null;
         var rpEmoticonFrame:EmoticonFrame = null;
         var emoteId2:uint = 0;
         var aura:Emoticon = null;
         var eprmsg:EmotePlayRequestMessage = null;
         var playerId:uint = 0;
         var objectId:uint = 0;
         var item:PaddockItem = null;
         var cellId:uint = 0;
         var npc:TiphonSprite = null;
         var questClip:Sprite = null;
         var iq:* = 0;
         var nbnpcqnr:* = 0;
         var q:Quest = null;
         var rect:Rectangle = null;
         var id:* = undefined;
         switch(true)
         {
            case msg is MapLoadedMessage:
               if(this._waitForMap)
               {
                  mirmsg=new MapInformationsRequestMessage();
                  mirmsg.initMapInformationsRequestMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                  ConnectionsHandler.getConnection().send(mirmsg);
                  this._waitForMap=false;
               }
               return false;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg=msg as MapComplementaryInformationsDataMessage;
               this.initNewMap();
               _interactiveElements=mcidmsg.interactiveElements;
               this._fightNumber=mcidmsg.fights.length;
               if(msg is MapComplementaryInformationsWithCoordsMessage)
               {
                  mciwcmsg=msg as MapComplementaryInformationsWithCoordsMessage;
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse=false;
                  PlayedCharacterManager.getInstance().isInHisHouse=false;
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mciwcmsg.worldX,mciwcmsg.worldY);
                  _worldPoint=new WorldPointWrapper(mciwcmsg.mapId,true,mciwcmsg.worldX,mciwcmsg.worldY);
               }
               else
               {
                  if(msg is MapComplementaryInformationsDataInHouseMessage)
                  {
                     mcidihmsg=msg as MapComplementaryInformationsDataInHouseMessage;
                     playerHouse=PlayerManager.getInstance().nickname==mcidihmsg.currentHouse.ownerName;
                     PlayedCharacterManager.getInstance().isInHouse=true;
                     if(playerHouse)
                     {
                        PlayedCharacterManager.getInstance().isInHisHouse=true;
                     }
                     PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                     KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,playerHouse,mcidihmsg.currentHouse.ownerId,mcidihmsg.currentHouse.ownerName,mcidihmsg.currentHouse.price,mcidihmsg.currentHouse.isLocked,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY,HouseWrapper.manualCreate(mcidihmsg.currentHouse.modelId,-1,mcidihmsg.currentHouse.ownerName,!(mcidihmsg.currentHouse.price==0)));
                     _worldPoint=new WorldPointWrapper(mcidihmsg.mapId,true,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                  }
                  else
                  {
                     _worldPoint=new WorldPointWrapper(mcidmsg.mapId);
                     if(PlayedCharacterManager.getInstance().isInHouse)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                     }
                     PlayedCharacterManager.getInstance().isInHouse=false;
                     PlayedCharacterManager.getInstance().isInHisHouse=false;
                  }
               }
               _currentSubAreaId=mcidmsg.subAreaId;
               _currentSubAreaSide=mcidmsg.subareaAlignmentSide;
               newSubArea=SubArea.getSubAreaById(_currentSubAreaId);
               PlayedCharacterManager.getInstance().currentMap=_worldPoint;
               PlayedCharacterManager.getInstance().currentSubArea=newSubArea;
               TooltipManager.hide();
               updateCreaturesLimit();
               newCreatureMode=false;
               for each (actor in mcidmsg.actors)
               {
                  _humanNumber++;
                  if((_creaturesLimit==0)||(_creaturesLimit>50)&&(_humanNumber>=_creaturesLimit))
                  {
                     _creaturesMode=true;
                  }
                  if((actor.contextualId<0)&&(this._playersId)&&(this._playersId.indexOf(actor.contextualId)==-1))
                  {
                     this._playersId.push(actor.contextualId);
                  }
               }
               mapWithNoMonsters=true;
               emoteId=0;
               emoteStartTime=0;
               for each (actor1 in mcidmsg.actors)
               {
                  ac=this.addOrUpdateActor(actor1) as AnimatedCharacter;
                  if(ac)
                  {
                     hi=actor1 as GameRolePlayCharacterInformations;
                     if(hi)
                     {
                        emoteId=0;
                        emoteStartTime=0;
                        for each (option in hi.humanoidInfo.options)
                        {
                           if(option is HumanOptionEmote)
                           {
                              emoteId=option.emoteId;
                              emoteStartTime=option.emoteStartTime;
                           }
                        }
                        if(emoteId>0)
                        {
                           emote=Emoticon.getEmoticonById(emoteId);
                           if(emote.persistancy)
                           {
                              this._currentEmoticon=emote.id;
                              if(!emote.aura)
                              {
                                 staticOnly=false;
                                 time=new Date();
                                 if(time.getTime()-emoteStartTime>=emote.duration)
                                 {
                                    staticOnly=true;
                                 }
                                 animNameLook=EntityLookAdapter.fromNetwork(hi.look);
                                 this.process(new GameRolePlaySetAnimationMessage(actor1,emote.getAnimName(animNameLook),emoteStartTime,!emote.persistancy,emote.eight_directions,staticOnly));
                              }
                           }
                        }
                     }
                  }
                  if(mapWithNoMonsters)
                  {
                     if(actor1 is GameRolePlayGroupMonsterInformations)
                     {
                        mapWithNoMonsters=false;
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.MapWithMonsters);
                     }
                  }
                  if(actor1 is GameRolePlayCharacterInformations)
                  {
                     ChatAutocompleteNameManager.getInstance().addEntry((actor1 as GameRolePlayCharacterInformations).name,0);
                  }
               }
               for each (fight in mcidmsg.fights)
               {
                  this.addFight(fight);
               }
               this._housesList=new Dictionary();
               for each (house in mcidmsg.houses)
               {
                  houseWrapper=HouseWrapper.create(house);
                  numDoors=house.doorsOnMap.length;
                  i=0;
                  while(i<numDoors)
                  {
                     this._housesList[house.doorsOnMap[i]]=houseWrapper;
                     i++;
                  }
                  hpmsg=new HousePropertiesMessage();
                  hpmsg.initHousePropertiesMessage(house);
                  Kernel.getWorker().process(hpmsg);
               }
               for each (mo in mcidmsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state==MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               imumsg=new InteractiveMapUpdateMessage();
               imumsg.initInteractiveMapUpdateMessage(mcidmsg.interactiveElements);
               Kernel.getWorker().process(imumsg);
               smumsg=new StatedMapUpdateMessage();
               smumsg.initStatedMapUpdateMessage(mcidmsg.statedElements);
               Kernel.getWorker().process(smumsg);
               KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.mapCoordinates,_currentSubAreaSide);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               AnimFunManager.getInstance().initializeByMap(mcidmsg.mapId);
               this.switchPokemonMode();
               return true;
            case msg is HousePropertiesMessage:
               houseInformations=(msg as HousePropertiesMessage).properties;
               houseWrapper=HouseWrapper.create(houseInformations);
               numDoors=houseInformations.doorsOnMap.length;
               i=0;
               while(i<numDoors)
               {
                  this._housesList[houseInformations.doorsOnMap[i]]=houseWrapper;
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(HookList.HouseProperties,houseInformations.houseId,houseInformations.doorsOnMap,houseInformations.ownerName,houseInformations.isOnSale,houseInformations.modelId);
               return true;
            case msg is GameRolePlayShowActorMessage:
               grpsamsg=msg as GameRolePlayShowActorMessage;
               updateCreaturesLimit();
               _humanNumber++;
               this.addOrUpdateActor(grpsamsg.informations);
               if(this.switchPokemonMode())
               {
                  return true;
               }
               if(grpsamsg.informations is GameRolePlayCharacterInformations)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry((grpsamsg.informations as GameRolePlayCharacterInformations).name,0);
               }
               if((grpsamsg.informations is GameRolePlayCharacterInformations)&&(PlayedCharacterManager.getInstance().characteristics.alignmentInfos.pvpEnabled))
               {
                  rpInfos=grpsamsg.informations as GameRolePlayCharacterInformations;
                  switch(PlayedCharacterManager.getInstance().levelDiff(rpInfos.alignmentInfos.characterPower-grpsamsg.informations.contextualId))
                  {
                     case -1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                        break;
                     case 1:
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                        break;
                  }
               }
               AnimFunManager.getInstance().restart();
               this._bRequestingAura=false;
               return true;
            case msg is GameContextRefreshEntityLookMessage:
               gcrelmsg=msg as GameContextRefreshEntityLookMessage;
               updateActorLook(gcrelmsg.id,gcrelmsg.look,true);
               return true;
            case msg is GameMapChangeOrientationMessage:
               gmcomsg=msg as GameMapChangeOrientationMessage;
               updateActorOrientation(gmcomsg.orientation.id,gmcomsg.orientation.direction);
               return true;
            case msg is GameMapChangeOrientationsMessage:
               gmcomsg2=msg as GameMapChangeOrientationsMessage;
               num=gmcomsg2.orientations.length;
               k=0;
               while(k<num)
               {
                  orientation=gmcomsg2.orientations[k];
                  updateActorOrientation(orientation.id,orientation.direction);
                  k++;
               }
               return true;
            case msg is GameRolePlaySetAnimationMessage:
               grsamsg=msg as GameRolePlaySetAnimationMessage;
               characterEntity=DofusEntities.getEntity(grsamsg.informations.contextualId) as AnimatedCharacter;
               if(grsamsg.animation==AnimationEnum.ANIM_STATIQUE)
               {
                  this._currentEmoticon=0;
                  characterEntity.setAnimation(grsamsg.animation);
                  this._emoteTimesBySprite[characterEntity.name]=0;
               }
               else
               {
                  if(!characterEntity.hasAnimation(grsamsg.animation,characterEntity.getDirection()))
                  {
                     _log.error("GameRolePlaySetAnimationMessage : l\'animation "+grsamsg.animation+"_"+characterEntity.getDirection()+" n\'a pas ete trouvee");
                  }
                  else
                  {
                     if(!_creaturesMode)
                     {
                        this._emoteTimesBySprite[characterEntity.name]=grsamsg.duration;
                        if(!grsamsg.directions8)
                        {
                           if(characterEntity.getDirection()%2==0)
                           {
                              characterEntity.setDirection(characterEntity.getDirection()+1);
                           }
                        }
                        characterEntity.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
                        characterEntity.setAnimation(grsamsg.animation);
                        if(grsamsg.playStaticOnly)
                        {
                           if((characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET))&&(characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length))
                           {
                              characterEntity.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
                           }
                           characterEntity.stopAnimationAtLastFrame();
                        }
                     }
                  }
               }
               return true;
            case msg is CharacterMovementStoppedMessage:
               cmsmsg=msg as CharacterMovementStoppedMessage;
               characterEntityStopped=DofusEntities.getEntity(PlayedCharacterManager.getInstance().infos.id) as AnimatedCharacter;
               if(((OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront)&&(characterEntityStopped.getDirection()==DirectionsEnum.DOWN))&&(!(characterEntityStopped.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE)==-1))&&(PlayedCharacterManager.getInstance().state==PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING))
               {
                  rpEmoticonFrame=Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                  for each (emoteId2 in rpEmoticonFrame.emotes)
                  {
                     aura=Emoticon.getEmoticonById(emoteId2);
                     if(aura.aura)
                     {
                        if((!myAura)||(aura.weight<myAura.weight))
                        {
                           myAura=aura;
                        }
                     }
                  }
                  if(myAura)
                  {
                     eprmsg=new EmotePlayRequestMessage();
                     eprmsg.initEmotePlayRequestMessage(myAura.id);
                     ConnectionsHandler.getConnection().send(eprmsg);
                  }
               }
               return true;
            case msg is GameRolePlayShowChallengeMessage:
               grpsclmsg=msg as GameRolePlayShowChallengeMessage;
               this.addFight(grpsclmsg.commonsInfos);
               return true;
            case msg is GameFightOptionStateUpdateMessage:
               gfosumsg=msg as GameFightOptionStateUpdateMessage;
               this.updateSwordOptions(gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               KernelEventsManager.getInstance().processCallback(HookList.GameFightOptionStateUpdate,gfosumsg.fightId,gfosumsg.teamId,gfosumsg.option,gfosumsg.state);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg=msg as GameFightUpdateTeamMessage;
               this.updateFight(gfutmsg.fightId,gfutmsg.team);
               return true;
            case msg is GameFightRemoveTeamMemberMessage:
               gfrtmmsg=msg as GameFightRemoveTeamMemberMessage;
               this.removeFighter(gfrtmmsg.fightId,gfrtmmsg.teamId,gfrtmmsg.charId);
               return true;
            case msg is GameRolePlayRemoveChallengeMessage:
               grprcmsg=msg as GameRolePlayRemoveChallengeMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GameRolePlayRemoveFight,grprcmsg.fightId);
               this.removeFight(grprcmsg.fightId);
               return true;
            case msg is GameContextRemoveElementMessage:
               gcremsg=msg as GameContextRemoveElementMessage;
               playerCompt=0;
               for each (playerId in this._playersId)
               {
                  if(playerId==gcremsg.id)
                  {
                     this._playersId.splice(playerCompt,1);
                  }
                  else
                  {
                     playerCompt++;
                  }
               }
               removeActor(gcremsg.id);
               return true;
            case msg is MapFightCountMessage:
               mfcmsg=msg as MapFightCountMessage;
               trace("Nombre de combat(s) sur la carte : "+mfcmsg.fightCount);
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,mfcmsg.fightCount);
               return true;
            case msg is ObjectGroundAddedMessage:
               ogamsg=msg as ObjectGroundAddedMessage;
               this.addObject(ogamsg.objectGID,ogamsg.cellId);
               return true;
            case msg is ObjectGroundRemovedMessage:
               ogrmsg=msg as ObjectGroundRemovedMessage;
               this.removeObject(ogrmsg.cell);
               return true;
            case msg is ObjectGroundListAddedMessage:
               oglamsg=msg as ObjectGroundListAddedMessage;
               comptObjects=0;
               for each (objectId in oglamsg.referenceIds)
               {
                  this.addObject(objectId,oglamsg.cells[comptObjects]);
                  comptObjects++;
               }
               return true;
            case msg is PaddockRemoveItemRequestAction:
               prira=msg as PaddockRemoveItemRequestAction;
               prirmsg=new PaddockRemoveItemRequestMessage();
               prirmsg.initPaddockRemoveItemRequestMessage(prira.cellId);
               ConnectionsHandler.getConnection().send(prirmsg);
               return true;
            case msg is PaddockMoveItemRequestAction:
               pmira=msg as PaddockMoveItemRequestAction;
               this._currentPaddockItemCellId=pmira.object.disposition.cellId;
               cursorIcon=new Texture();
               iw=ItemWrapper.create(0,0,pmira.object.item.id,0,null,false);
               cursorIcon.uri=iw.iconUri;
               cursorIcon.finalize();
               Kernel.getWorker().addFrame(new RoleplayPointCellFrame(this.onCellPointed,cursorIcon,true,this.paddockCellValidator,true));
               return true;
            case msg is GameDataPaddockObjectRemoveMessage:
               gdpormsg=msg as GameDataPaddockObjectRemoveMessage;
               roleplayContextFrame=Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               this.removePaddockItem(gdpormsg.cellId);
               return true;
            case msg is GameDataPaddockObjectAddMessage:
               gdpoamsg=msg as GameDataPaddockObjectAddMessage;
               this.addPaddockItem(gdpoamsg.paddockItemDescription);
               return true;
            case msg is GameDataPaddockObjectListAddMessage:
               gdpolamsg=msg as GameDataPaddockObjectListAddMessage;
               for each (item in gdpolamsg.paddockItemDescription)
               {
                  this.addPaddockItem(item);
               }
               return true;
            case msg is GameDataPlayFarmObjectAnimationMessage:
               gdpfoamsg=msg as GameDataPlayFarmObjectAnimationMessage;
               for each (cellId in gdpfoamsg.cellId)
               {
                  this.activatePaddockItem(cellId);
               }
               return true;
            case msg is MapNpcsQuestStatusUpdateMessage:
               mnqsumsg=msg as MapNpcsQuestStatusUpdateMessage;
               if(MapDisplayManager.getInstance().currentMapPoint.mapId==mnqsumsg.mapId)
               {
                  for each (npc in this._npcList)
                  {
                     this.removeBackground(npc);
                  }
                  nbnpcqnr=mnqsumsg.npcsIdsWithQuest.length;
                  iq=0;
                  while(iq<nbnpcqnr)
                  {
                     npc=this._npcList[mnqsumsg.npcsIdsWithQuest[iq]];
                     if(npc)
                     {
                        q=Quest.getFirstValidQuest(mnqsumsg.questFlags[i]);
                        if(q!=null)
                        {
                           if(mnqsumsg.questFlags[i].questsToStartId.indexOf(q.id)!=-1)
                           {
                              if(q.repeatType==0)
                              {
                                 questClip=EmbedAssets.getSprite("QUEST_CLIP");
                                 npc.addBackground("questClip",questClip,true);
                              }
                              else
                              {
                                 questClip=EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                                 npc.addBackground("questRepeatableClip",questClip,true);
                              }
                           }
                           else
                           {
                              if(q.repeatType==0)
                              {
                                 questClip=EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                                 npc.addBackground("questObjectiveClip",questClip,true);
                              }
                              else
                              {
                                 questClip=EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                                 npc.addBackground("questRepeatableObjectiveClip",questClip,true);
                              }
                           }
                        }
                     }
                     iq++;
                  }
               }
               return true;
            case msg is ShowCellMessage:
               scmsg=msg as ShowCellMessage;
               HyperlinkShowCellManager.showCell(scmsg.cellId);
               roleplayContextFrame2=Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
               name=roleplayContextFrame2.getActorName(scmsg.sourceId);
               text=I18n.getUiText("ui.fight.showCell",[name,"{cell,"+scmsg.cellId+"::"+scmsg.cellId+"}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is StartZoomAction:
               sza=msg as StartZoomAction;
               if(Atouin.getInstance().currentZoom!=1)
               {
                  Atouin.getInstance().cancelZoom();
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,false);
                  return true;
               }
               player=DofusEntities.getEntity(sza.playerId) as DisplayObject;
               if((player)&&(player.stage))
               {
                  rect=player.getRect(Atouin.getInstance().worldContainer);
                  Atouin.getInstance().zoom(sza.value,rect.x+rect.width/2,rect.y+rect.height/2);
                  KernelEventsManager.getInstance().processCallback(HookList.StartZoom,true);
               }
               return true;
            case msg is SwitchCreatureModeAction:
               scmamsg=msg as SwitchCreatureModeAction;
               if(_creaturesMode!=scmamsg.isActivated)
               {
                  _creaturesMode=scmamsg.isActivated;
                  for (id in _entities)
                  {
                     updateActorLook(id,(_entities[id] as GameContextActorInformations).look);
                  }
               }
               return true;
            default:
               return false;
         }
      }

      private function initNewMap() : void {
         this._npcList=new Dictionary();
         this._fights=new Dictionary();
         this._objects=new Dictionary();
         this._uri=new Dictionary();
         this._paddockItem=new Dictionary();
      }

      override protected function switchPokemonMode() : Boolean {
         if(super.switchPokemonMode())
         {
            KernelEventsManager.getInstance().processCallback(TriggerHookList.CreaturesMode);
            return true;
         }
         return false;
      }

      override public function pulled() : Boolean {
         var fight:Fight = null;
         var team:FightTeam = null;
         for each (fight in this._fights)
         {
            for each (team in fight.teams)
            {
               TooltipManager.hide("fightOptions_"+fight.fightId+"_"+team.teamInfos.teamId);
            }
         }
         if(this._loader)
         {
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onGroundObjectLoaded);
            this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onGroundObjectLoadFailed);
            this._loader=null;
         }
         AnimFunManager.getInstance().stopAllTimer();
         this._fights=null;
         this._objects=null;
         this._npcList=null;
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         return super.pulled();
      }

      public function isFight(entityId:int) : Boolean {
         return _entities[entityId] is FightTeam;
      }

      public function isPaddockItem(entityId:int) : Boolean {
         return _entities[entityId] is GameContextPaddockItemInformations;
      }

      public function getFightTeam(entityId:int) : FightTeam {
         return _entities[entityId] as FightTeam;
      }

      public function getFightId(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).fight.fightId;
      }

      public function getFightLeaderId(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).teamInfos.leaderId;
      }

      public function getFightTeamType(entityId:int) : uint {
         return (_entities[entityId] as FightTeam).teamType;
      }

      override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier=null) : AnimatedCharacter {
         var questClip:Sprite = null;
         var q:Quest = null;
         var entityLooks:Vector.<EntityLook> = null;
         var monstersInfos:GameRolePlayGroupMonsterInformations = null;
         var followersLooks:Vector.<EntityLook> = null;
         var i:uint = 0;
         var underling:MonsterInGroupInformations = null;
         var option:* = undefined;
         var indexedLooks:Array = null;
         var indexedEL:IndexedEntityLook = null;
         var iEL:IndexedEntityLook = null;
         var ac:AnimatedCharacter = super.addOrUpdateActor(infos);
         switch(true)
         {
            case infos is GameRolePlayNpcWithQuestInformations:
               this._npcList[infos.contextualId]=ac;
               q=Quest.getFirstValidQuest((infos as GameRolePlayNpcWithQuestInformations).questFlag);
               this.removeBackground(ac);
               if(q!=null)
               {
                  if((infos as GameRolePlayNpcWithQuestInformations).questFlag.questsToStartId.indexOf(q.id)!=-1)
                  {
                     if(q.repeatType==0)
                     {
                        questClip=EmbedAssets.getSprite("QUEST_CLIP");
                        ac.addBackground("questClip",questClip,true);
                     }
                     else
                     {
                        questClip=EmbedAssets.getSprite("QUEST_REPEATABLE_CLIP");
                        ac.addBackground("questRepeatableClip",questClip,true);
                     }
                  }
                  else
                  {
                     if(q.repeatType==0)
                     {
                        questClip=EmbedAssets.getSprite("QUEST_OBJECTIVE_CLIP");
                        ac.addBackground("questObjectiveClip",questClip,true);
                     }
                     else
                     {
                        questClip=EmbedAssets.getSprite("QUEST_REPEATABLE_OBJECTIVE_CLIP");
                        ac.addBackground("questRepeatableObjectiveClip",questClip,true);
                     }
                  }
               }
               if(ac.look.getBone()==1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode)||(ac.getAnimation()==AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayGroupMonsterInformations:
               if(Dofus.getInstance().options.showEveryMonsters)
               {
                  monstersInfos=infos as GameRolePlayGroupMonsterInformations;
                  followersLooks=new Vector.<EntityLook>(monstersInfos.staticInfos.underlings.length,true);
                  i=0;
                  for each (underling in monstersInfos.staticInfos.underlings)
                  {
                     followersLooks[i++]=underling.look;
                  }
                  this.manageFollowers(ac,followersLooks);
               }
               break;
            case infos is GameRolePlayHumanoidInformations:
               this._playersId.push(infos.contextualId);
               entityLooks=new Vector.<EntityLook>();
               for each (option in (infos as GameRolePlayHumanoidInformations).humanoidInfo.options)
               {
                  if(option is HumanOptionFollowers)
                  {
                     indexedLooks=new Array();
                     for each (indexedEL in option.followingCharactersLook)
                     {
                        indexedLooks.push(indexedEL);
                     }
                     indexedLooks.sortOn("index");
                     for each (iEL in indexedLooks)
                     {
                        entityLooks.push(iEL.look);
                     }
                  }
               }
               this.manageFollowers(ac,entityLooks);
               if(ac.look.getBone()==1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode)||(ac.getAnimation()==AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               break;
            case infos is GameRolePlayMerchantInformations:
               if(ac.look.getBone()==1)
               {
                  ac.addAnimationModifier(_customAnimModifier);
               }
               if((_creaturesMode)||(ac.getAnimation()==AnimationEnum.ANIM_STATIQUE))
               {
                  ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               trace("Affichage d\'un personnage en mode marchand");
               break;
            case infos is GameRolePlayTaxCollectorInformations:
            case infos is GameRolePlayPrismInformations:
               break;
            default:
               _log.warn("Unknown GameRolePlayActorInformations type : "+infos+".");
         }
         return ac;
      }

      private function removeBackground(ac:TiphonSprite) : void {
         if(!ac)
         {
            return;
         }
         ac.removeBackground("questClip");
         ac.removeBackground("questObjectiveClip");
         ac.removeBackground("questRepeatableClip");
         ac.removeBackground("questRepeatableObjectiveClip");
      }

      private function manageFollowers(char:AnimatedCharacter, followers:Vector.<EntityLook>) : void {
         var num:* = 0;
         var i:* = 0;
         var followerBaseLook:EntityLook = null;
         var followerEntityLook:TiphonEntityLook = null;
         var followerEntity:AnimatedCharacter = null;
         if(!char.followersEqual(followers))
         {
            char.removeAllFollowers();
            num=followers.length;
            i=0;
            while(i<num)
            {
               followerBaseLook=followers[i];
               followerEntityLook=EntityLookAdapter.fromNetwork(followerBaseLook);
               followerEntity=new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),followerEntityLook,char);
               char.addFollower(followerEntity);
               i++;
            }
         }
      }

      private function addFight(infos:FightCommonInformations) : void {
         var team:FightTeamInformations = null;
         var teamEntity:IEntity = null;
         var fightTeam:FightTeam = null;
         var teams:Vector.<FightTeam> = new Vector.<FightTeam>(0,false);
         var fight:Fight = new Fight(infos.fightId,teams);
         var teamCounter:uint = 0;
         for each (team in infos.fightTeams)
         {
            teamEntity=RolePlayEntitiesFactory.createFightEntity(infos,team,MapPoint.fromCellId(infos.fightTeamsPositions[teamCounter]));
            (teamEntity as IDisplayable).display();
            fightTeam=new FightTeam(fight,team.teamTypeId,teamEntity,team,infos.fightTeamsOptions[team.teamId]);
            _entities[teamEntity.id]=fightTeam;
            teams.push(fightTeam);
            teamCounter++;
         }
         this._fights[infos.fightId]=fight;
         for each (team in infos.fightTeams)
         {
            this.updateSwordOptions(infos.fightId,team.teamId);
         }
      }

      private function addObject(pObjectUID:uint, pCellId:uint) : void {
         var objectUri:Uri = new Uri(LangManager.getInstance().getEntry("config.gfx.path.item.vector")+Item.getItemById(pObjectUID).iconId+".swf");
         var objectEntity:IInteractive = new RoleplayObjectEntity(pObjectUID,MapPoint.fromCellId(pCellId));
         (objectEntity as IDisplayable).display();
         var groundObject:GameContextActorInformations = new GroundObject(Item.getItemById(pObjectUID));
         groundObject.contextualId=objectEntity.id;
         groundObject.disposition.cellId=pCellId;
         groundObject.disposition.direction=DirectionsEnum.DOWN_RIGHT;
         if(this._objects==null)
         {
            this._objects=new Dictionary();
         }
         this._objects[objectUri]=objectEntity;
         this._uri[pCellId]=this._objects[objectUri];
         _entities[objectEntity.id]=groundObject;
         this._loader.load(objectUri,null,null,true);
      }

      private function removeObject(pCellId:uint) : void {
         if(this._uri[pCellId]!=null)
         {
            (this._uri[pCellId] as IDisplayable).remove();
         }
         if(this._objects[this._uri[pCellId]]!=null)
         {
            delete this._objects[[this._uri[pCellId]]];
         }
         if(_entities[this._uri[pCellId].id]!=null)
         {
            delete _entities[[this._uri[pCellId].id]];
         }
         if(this._uri[pCellId]!=null)
         {
            delete this._uri[[pCellId]];
         }
      }

      private function updateFight(fightId:uint, team:FightTeamInformations) : void {
         var newMember:FightTeamMemberInformations = null;
         var teamMemberIsMonster:* = false;
         var newTeamMemberIsMonster:* = false;
         var teamMemberId:* = 0;
         var newTeamMemberId:* = 0;
         var present:* = false;
         var teamMember:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight==null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.getTeamById(team.teamId);
         var tInfo:FightTeamInformations = (_entities[fightTeam.teamEntity.id] as FightTeam).teamInfos;
         if(tInfo.teamMembers==team.teamMembers)
         {
            return;
         }
         for each (newMember in team.teamMembers)
         {
            teamMemberIsMonster=false;
            newTeamMemberIsMonster=false;
            if(newMember is FightTeamMemberMonsterInformations)
            {
               newTeamMemberIsMonster=true;
               newTeamMemberId=(newMember as FightTeamMemberMonsterInformations).monsterId;
            }
            else
            {
               newTeamMemberId=newMember.id;
            }
            present=false;
            for each (teamMember in tInfo.teamMembers)
            {
               if(teamMember is FightTeamMemberMonsterInformations)
               {
                  teamMemberIsMonster=true;
                  teamMemberId=(teamMember as FightTeamMemberMonsterInformations).monsterId;
               }
               else
               {
                  teamMemberId=teamMember.id;
               }
               if(teamMemberId==newTeamMemberId)
               {
                  present=true;
               }
            }
            if(!present)
            {
               tInfo.teamMembers.push(newMember);
            }
         }
      }

      private function removeFighter(fightId:uint, teamId:uint, charId:int) : void {
         var fightTeam:FightTeam = null;
         var teamInfos:FightTeamInformations = null;
         var newMembers:Vector.<FightTeamMemberInformations> = null;
         var member:FightTeamMemberInformations = null;
         var fight:Fight = this._fights[fightId];
         if(fight)
         {
            fightTeam=fight.teams[teamId];
            teamInfos=fightTeam.teamInfos;
            newMembers=new Vector.<FightTeamMemberInformations>(0,false);
            for each (member in teamInfos.teamMembers)
            {
               if(member.id!=charId)
               {
                  newMembers.push(member);
               }
            }
            teamInfos.teamMembers=newMembers;
         }
      }

      private function removeFight(fightId:uint) : void {
         var team:FightTeam = null;
         var entity:Object = null;
         var fight:Fight = this._fights[fightId];
         if(fight==null)
         {
            return;
         }
         for each (team in fight.teams)
         {
            entity=_entities[team.teamEntity.id];
            Kernel.getWorker().process(new EntityMouseOutMessage(team.teamEntity as IInteractive));
            (team.teamEntity as IDisplayable).remove();
            TooltipManager.hide("fightOptions_"+fightId+"_"+team.teamInfos.teamId);
            delete _entities[[team.teamEntity.id]];
         }
         delete this._fights[[fightId]];
      }

      private function addPaddockItem(item:PaddockItem) : void {
         var contextualId:* = 0;
         var i:Item = Item.getItemById(item.objectGID);
         if(this._paddockItem[item.cellId])
         {
            contextualId=(this._paddockItem[item.cellId] as IEntity).id;
         }
         else
         {
            contextualId=EntitiesManager.getInstance().getFreeEntityId();
         }
         var gcpii:GameContextPaddockItemInformations = new GameContextPaddockItemInformations(contextualId,i.appearance,item.cellId,item.durability,i);
         var e:IEntity = this.addOrUpdateActor(gcpii);
         this._paddockItem[item.cellId]=e;
      }

      private function removePaddockItem(cellId:uint) : void {
         var e:IEntity = this._paddockItem[cellId];
         if(!e)
         {
            return;
         }
         (e as IDisplayable).remove();
         delete this._paddockItem[[cellId]];
      }

      private function activatePaddockItem(cellId:uint) : void {
         var seq:SerialSequencer = null;
         var item:TiphonSprite = this._paddockItem[cellId];
         if(item)
         {
            seq=new SerialSequencer();
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_HIT));
            seq.addStep(new PlayAnimationStep(item,AnimationEnum.ANIM_STATIQUE));
            seq.start();
         }
      }

      private function updateSwordOptions(fightId:uint, teamId:uint, option:int=-1, state:Boolean=false) : void {
         var opt:* = undefined;
         var fight:Fight = this._fights[fightId];
         if(fight==null)
         {
            return;
         }
         var fightTeam:FightTeam = fight.teams[teamId];
         if(fightTeam==null)
         {
            return;
         }
         if(option!=-1)
         {
            fightTeam.teamOptions[option]=state;
         }
         var textures:Vector.<String> = new Vector.<String>();
         for (opt in fightTeam.teamOptions)
         {
            if(fightTeam.teamOptions[opt])
            {
               textures.push("fightOption"+opt);
            }
         }
         TooltipManager.show(textures,(fightTeam.teamEntity as IDisplayable).absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"fightOptions_"+fightId+"_"+teamId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,0);
      }

      private function paddockCellValidator(cellId:int) : Boolean {
         var infos:GameContextActorInformations = null;
         var entity:IEntity = EntitiesManager.getInstance().getEntityOnCell(cellId);
         if(entity)
         {
            infos=getEntityInfos(entity.id);
            if(infos is GameContextPaddockItemInformations)
            {
               return false;
            }
         }
         return (DataMapProvider.getInstance().farmCell(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y))&&(DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cellId).x,MapPoint.fromCellId(cellId).y,true));
      }

      private function onGroundObjectLoaded(e:ResourceLoadedEvent) : void {
         var objectMc:MovieClip = e.resource;
         objectMc.x=objectMc.x-objectMc.width/2;
         objectMc.y=objectMc.y-objectMc.height/2;
         this._objects[e.uri].addChild(objectMc);
      }

      private function onGroundObjectLoadFailed(e:ResourceErrorEvent) : void {
         trace("l\'objet au sol n\'a pas pu être chargé / uri : "+e.uri);
      }

      public function timeoutStop(character:AnimatedCharacter) : void {
         clearTimeout(this._timeout);
         character.setAnimation(AnimationEnum.ANIM_STATIQUE);
         this._currentEmoticon=0;
      }

      private function onPropertyChanged(e:PropertyChangeEvent) : void {
         if(e.propertyName=="mapCoordinates")
         {
            KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,_worldPoint,_currentSubAreaId,e.propertyValue,_currentSubAreaSide);
         }
      }

      override public function onPlayAnim(e:TiphonEvent) : void {
         var animsRandom:Array = new Array();
         var tempStr:String = e.params.substring(6,e.params.length-1);
         animsRandom=tempStr.split(",");
         var whichAnim:int = this._emoteTimesBySprite[(e.currentTarget as TiphonSprite).name]%animsRandom.length;
         e.sprite.setAnimation(animsRandom[whichAnim]);
      }

      private function onAnimationEnd(e:TiphonEvent) : void {
         var statiqueAnim:String = null;
         var animNam:String = null;
         var tiphonSprite:TiphonSprite = e.currentTarget as TiphonSprite;
         tiphonSprite.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         var subEnt:Object = tiphonSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(subEnt!=null)
         {
            animNam=subEnt.getAnimation();
            if(animNam.indexOf("_")==-1)
            {
               animNam=tiphonSprite.getAnimation();
            }
         }
         else
         {
            animNam=tiphonSprite.getAnimation();
         }
         if(animNam.indexOf("_Statique_")==-1)
         {
            statiqueAnim=animNam.replace("_","_Statique_");
         }
         else
         {
            statiqueAnim=animNam;
         }
         if((tiphonSprite.hasAnimation(statiqueAnim,tiphonSprite.getDirection()))||((subEnt)&&(subEnt is TiphonSprite))&&(TiphonSprite(subEnt).hasAnimation(statiqueAnim,TiphonSprite(subEnt).getDirection())))
         {
            tiphonSprite.setAnimation(statiqueAnim);
         }
         else
         {
            tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
            this._currentEmoticon=0;
         }
      }

      private function onCellPointed(success:Boolean, cellId:uint, entityId:int) : void {
         var m:PaddockMoveItemRequestMessage = null;
         if(success)
         {
            m=new PaddockMoveItemRequestMessage();
            m.initPaddockMoveItemRequestMessage(this._currentPaddockItemCellId,cellId);
            ConnectionsHandler.getConnection().send(m);
         }
      }
   }

}