package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Point;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import flash.geom.Rectangle;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowMonstersInfoAction;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementWithAgeBonus;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.data.I18n;
   import flash.display.Sprite;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.logic.game.roleplay.types.RoleplayTeamFightersTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.MutantTooltipInformation;
   import com.ankamagames.dofus.network.types.game.context.TaxCollectorStaticExtendedInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.TaxCollectorTooltipInformation;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.logic.game.roleplay.types.PrismTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.PortalTooltipInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.network.enums.TeamTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import flash.ui.Mouse;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOnHumanVendorRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;
   
   public class RoleplayWorldFrame extends Object implements Frame
   {
      
      public function RoleplayWorldFrame() {
         this._common = XmlConfig.getInstance().getEntry("config.ui.skin");
         this._infoEntitiesFrame = new InfoEntitiesFrame();
         this.sysApi = new SystemApi();
         this._entityTooltipData = new Dictionary();
         super();
      }
      
      protected static const _log:Logger;
      
      private static const NO_CURSOR:int = -1;
      
      private static const FIGHT_CURSOR:int = 3;
      
      private static const NPC_CURSOR:int = 1;
      
      private static const INTERACTIVE_CURSOR_OFFSET:Point;
      
      private static const COLLECTABLE_INTERACTIVE_ACTION_ID:uint = 1;
      
      private static var _monstersInfoFrame:MonstersInfoFrame;
      
      private const _common:String;
      
      private var _mouseLabel:Label;
      
      private var _mouseTop:Texture;
      
      private var _mouseBottom:Texture;
      
      private var _mouseRight:Texture;
      
      private var _mouseLeft:Texture;
      
      private var _mouseTopBlue:Texture;
      
      private var _mouseBottomBlue:Texture;
      
      private var _mouseRightBlue:Texture;
      
      private var _mouseLeftBlue:Texture;
      
      private var _texturesReady:Boolean;
      
      private var _playerEntity:AnimatedCharacter;
      
      private var _playerName:String;
      
      private var _allowOnlyCharacterInteraction:Boolean;
      
      public var cellClickEnabled:Boolean;
      
      private var _infoEntitiesFrame:InfoEntitiesFrame;
      
      private var _mouseOverEntityId:int;
      
      private var sysApi:SystemApi;
      
      private var _entityTooltipData:Dictionary;
      
      private var _mouseDown:Boolean;
      
      public var pivotingCharacter:Boolean;
      
      public function get mouseOverEntityId() : int {
         return this._mouseOverEntityId;
      }
      
      public function set allowOnlyCharacterInteraction(pAllow:Boolean) : void {
         this._allowOnlyCharacterInteraction = pAllow;
      }
      
      public function get allowOnlyCharacterInteraction() : Boolean {
         return this._allowOnlyCharacterInteraction;
      }
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function pushed() : Boolean {
         FrustumManager.getInstance().setBorderInteraction(true);
         this._allowOnlyCharacterInteraction = false;
         this.cellClickEnabled = true;
         this.pivotingCharacter = false;
         var shortcutsFrame:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         if((!(shortcutsFrame.heldShortcuts.indexOf("showMonstersInfo") == -1)) && (!Kernel.getWorker().contains(MonstersInfoFrame)))
         {
            Kernel.getWorker().addFrame(_monstersInfoFrame);
         }
         else if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(_monstersInfoFrame);
         }
         
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         if(this._texturesReady)
         {
            return true;
         }
         this._mouseBottom = new Texture();
         this._mouseBottom.uri = new Uri(this._common + "assets.swf|cursorBottom");
         this._mouseBottom.finalize();
         this._mouseTop = new Texture();
         this._mouseTop.uri = new Uri(this._common + "assets.swf|cursorTop");
         this._mouseTop.finalize();
         this._mouseRight = new Texture();
         this._mouseRight.uri = new Uri(this._common + "assets.swf|cursorRight");
         this._mouseRight.finalize();
         this._mouseLeft = new Texture();
         this._mouseLeft.uri = new Uri(this._common + "assets.swf|cursorLeft");
         this._mouseLeft.finalize();
         this._mouseBottomBlue = new Texture();
         this._mouseBottomBlue.uri = new Uri(this._common + "assets.swf|cursorBottomBlue");
         this._mouseBottomBlue.finalize();
         this._mouseTopBlue = new Texture();
         this._mouseTopBlue.uri = new Uri(this._common + "assets.swf|cursorTopBlue");
         this._mouseTopBlue.finalize();
         this._mouseRightBlue = new Texture();
         this._mouseRightBlue.uri = new Uri(this._common + "assets.swf|cursorRightBlue");
         this._mouseRightBlue.finalize();
         this._mouseLeftBlue = new Texture();
         this._mouseLeftBlue.uri = new Uri(this._common + "assets.swf|cursorLeftBlue");
         this._mouseLeftBlue.finalize();
         this._mouseLabel = new Label();
         this._mouseLabel.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
         this._texturesReady = true;
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var amomsg:AdjacentMapOverMessage = null;
         var targetCell:Point = null;
         var cellSprite:GraphicCell = null;
         var item:LinkedCursorData = null;
         var neighborId:* = 0;
         var neighborSubarea:SubArea = null;
         var subareaChange:* = false;
         var x:* = 0;
         var y:* = 0;
         var info:String = null;
         var emomsg:EntityMouseOverMessage = null;
         var tooltipName:String = null;
         var entity:IInteractive = null;
         var animatedCharacter:AnimatedCharacter = null;
         var infos:* = undefined;
         var targetBounds:IRectangle = null;
         var tooltipMaker:String = null;
         var cacheName:String = null;
         var tooltipOffset:* = NaN;
         var mrcmsg:MouseRightClickMessage = null;
         var modContextMenu:Object = null;
         var rightClickedEntity:IInteractive = null;
         var emoutmsg:EntityMouseOutMessage = null;
         var ecmsg:EntityClickMessage = null;
         var entityc:IInteractive = null;
         var EntityClickInfo:GameContextActorInformations = null;
         var menuResult:* = false;
         var ieamsg:InteractiveElementActivationMessage = null;
         var interactiveFrame:RoleplayInteractivesFrame = null;
         var iemovmsg:InteractiveElementMouseOverMessage = null;
         var infosIe:Object = null;
         var ttMaker:String = null;
         var tooltipCacheName:String = null;
         var interactiveElem:InteractiveElement = null;
         var interactiveSkill:InteractiveElementSkill = null;
         var interactive:Interactive = null;
         var elementId:uint = 0;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var houseWrapper:HouseWrapper = null;
         var target:Rectangle = null;
         var iemomsg:InteractiveElementMouseOutMessage = null;
         var smia:ShowMonstersInfoAction = null;
         var mum:MouseUpMessage = null;
         var sf:ShortcutsFrame = null;
         var climsg:CellClickMessage = null;
         var amcmsg:AdjacentMapClickMessage = null;
         var playedEntity:IEntity = null;
         var text:String = null;
         var text2:String = null;
         var target2:Rectangle = null;
         var param:Object = null;
         var tooltipTarget:TiphonSprite = null;
         var rider:TiphonSprite = null;
         var isCreatureMode:* = false;
         var head:DisplayObject = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var fight:FightTeam = null;
         var allianceInfos:AllianceInformations = null;
         var levelDiffInfo:* = 0;
         var grtci:GameRolePlayTaxCollectorInformations = null;
         var guildtcinfos:GuildInformations = null;
         var gwtc:GuildWrapper = null;
         var awtc:AllianceWrapper = null;
         var npcInfos:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var allianceFrame:AllianceFrame = null;
         var targetLevel:uint = 0;
         var playerLevel:uint = 0;
         var rcf:RoleplayContextFrame = null;
         var actorInfos:GameContextActorInformations = null;
         var menu:Object = null;
         var rightClickedinfos:GameContextActorInformations = null;
         var fightId:uint = 0;
         var fightTeamLeader:* = 0;
         var teamType:uint = 0;
         var gfjrmsg:GameFightJoinRequestMessage = null;
         var playerEntity3:IEntity = null;
         var guildId:* = 0;
         var team:FightTeam = null;
         var fighter:FightTeamMemberInformations = null;
         var guild:GuildWrapper = null;
         var playerEntity:IEntity = null;
         var forbiddenCellsIds:Array = null;
         var i:* = 0;
         var nearestCell:MapPoint = null;
         var mp:MapPoint = null;
         var elem:Object = null;
         var enabledSkills:String = null;
         var disabledSkills:String = null;
         var collectSkill:Skill = null;
         var showBonus:* = false;
         var iewab:InteractiveElementWithAgeBonus = null;
         switch(true)
         {
            case msg is CellClickMessage:
               if(this.pivotingCharacter)
               {
                  return false;
               }
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(this.cellClickEnabled)
               {
                  climsg = msg as CellClickMessage;
                  (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentEmoticon = 0;
                  this.roleplayMovementFrame.resetNextMoveMapChange();
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(climsg.cellId));
               }
               return true;
            case msg is AdjacentMapClickMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(this.cellClickEnabled)
               {
                  amcmsg = msg as AdjacentMapClickMessage;
                  playedEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!playedEntity)
                  {
                     _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                     return false;
                  }
                  this.roleplayMovementFrame.setNextMoveMapChange(amcmsg.adjacentMapId);
                  if(!playedEntity.position.equals(MapPoint.fromCellId(amcmsg.cellId)))
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(amcmsg.cellId));
                  }
                  else
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMapChange();
                  }
               }
               return true;
            case msg is AdjacentMapOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               TooltipManager.hide("subareaChange");
               LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
               return true;
            case msg is AdjacentMapOverMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               amomsg = AdjacentMapOverMessage(msg);
               targetCell = CellIdConverter.cellIdToCoord(amomsg.cellId);
               cellSprite = InteractiveCellManager.getInstance().getCell(amomsg.cellId);
               item = new LinkedCursorData();
               if(amomsg.direction == DirectionsEnum.RIGHT)
               {
                  neighborId = PlayedCharacterManager.getInstance().currentMap.rightNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.DOWN)
               {
                  neighborId = PlayedCharacterManager.getInstance().currentMap.bottomNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.LEFT)
               {
                  neighborId = PlayedCharacterManager.getInstance().currentMap.leftNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.UP)
               {
                  neighborId = PlayedCharacterManager.getInstance().currentMap.topNeighbourId;
               }
               
               
               
               neighborSubarea = SubArea.getSubAreaByMapId(neighborId);
               subareaChange = false;
               x = 0;
               y = 0;
               if((neighborSubarea) && (!(neighborSubarea.id == PlayedCharacterManager.getInstance().currentSubArea.id)))
               {
                  subareaChange = true;
                  text = I18n.getUiText("ui.common.toward",[neighborSubarea.name]);
                  text2 = I18n.getUiText("ui.common.level") + " " + neighborSubarea.level;
                  this._mouseLabel.text = text.length > text2.length?text:text2;
                  info = text + "\n" + text2;
               }
               switch(amomsg.direction)
               {
                  case DirectionsEnum.LEFT:
                     item.sprite = subareaChange?this._mouseLeftBlue:this._mouseLeft;
                     item.lockX = true;
                     item.sprite.x = amomsg.zone.x + amomsg.zone.width / 2;
                     item.offset = new Point(0,0);
                     item.lockY = true;
                     item.sprite.y = cellSprite.y + AtouinConstants.CELL_HEIGHT / 2;
                     if(subareaChange)
                     {
                        x = 0;
                        y = item.sprite.height / 2;
                     }
                     break;
                  case DirectionsEnum.UP:
                     item.sprite = subareaChange?this._mouseTopBlue:this._mouseTop;
                     item.lockY = true;
                     item.sprite.y = amomsg.zone.y + amomsg.zone.height / 2;
                     item.offset = new Point(0,0);
                     item.lockX = true;
                     item.sprite.x = cellSprite.x + AtouinConstants.CELL_WIDTH / 2;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth / 2;
                        y = item.sprite.height + 5;
                     }
                     break;
                  case DirectionsEnum.DOWN:
                     item.sprite = subareaChange?this._mouseBottomBlue:this._mouseBottom;
                     item.lockY = true;
                     item.sprite.y = amomsg.zone.getBounds(amomsg.zone).top;
                     item.offset = new Point(0,0);
                     item.lockX = true;
                     item.sprite.x = cellSprite.x + AtouinConstants.CELL_WIDTH / 2;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth / 2;
                        y = -item.sprite.height - this._mouseLabel.textHeight - 34;
                     }
                     break;
                  case DirectionsEnum.RIGHT:
                     item.sprite = subareaChange?this._mouseRightBlue:this._mouseRight;
                     item.lockX = true;
                     item.sprite.x = amomsg.zone.getBounds(amomsg.zone).left + amomsg.zone.width / 2;
                     item.offset = new Point(0,0);
                     item.lockY = true;
                     item.sprite.y = cellSprite.y + AtouinConstants.CELL_HEIGHT / 2;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth;
                        y = item.sprite.height / 2;
                     }
                     break;
               }
               if(subareaChange)
               {
                  target2 = new Rectangle(item.sprite.x + x,item.sprite.y + y,1,1);
                  param = new Object();
                  param.classCss = "center";
                  TooltipManager.show(info,target2,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"subareaChange",0,0,0,true,null,null,param,"Text" + neighborId,false,StrataEnum.STRATA_TOOLTIP,1);
               }
               LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor",item);
               return true;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               this._mouseOverEntityId = emomsg.entity.id;
               tooltipName = "entity_" + emomsg.entity.id;
               this.displayCursor(NO_CURSOR);
               entity = emomsg.entity as IInteractive;
               animatedCharacter = entity as AnimatedCharacter;
               if(animatedCharacter)
               {
                  animatedCharacter = animatedCharacter.getRootEntity();
                  animatedCharacter.highLightCharacterAndFollower(true);
                  entity = animatedCharacter;
                  if((OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER) && (animatedCharacter.getDirection() == DirectionsEnum.DOWN))
                  {
                     animatedCharacter.visibleAura = true;
                  }
               }
               infos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(entity.id) as GameRolePlayActorInformations;
               if(entity is TiphonSprite)
               {
                  tooltipTarget = entity as TiphonSprite;
                  rider = (entity as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                  isCreatureMode = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame)) && (RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode);
                  if((rider) && (!isCreatureMode))
                  {
                     tooltipTarget = rider;
                  }
                  head = tooltipTarget.getSlot("Tete");
                  if(head)
                  {
                     r1 = head.getBounds(StageShareManager.stage);
                     r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
                     targetBounds = r2;
                  }
               }
               if((!targetBounds) || (targetBounds.width == 0) && (targetBounds.height == 0))
               {
                  targetBounds = (entity as IDisplayable).absoluteBounds;
               }
               tooltipMaker = null;
               tooltipOffset = 0;
               if(this.roleplayContextFrame.entitiesFrame.isFight(entity.id))
               {
                  if(this.allowOnlyCharacterInteraction)
                  {
                     return false;
                  }
                  fight = this.roleplayContextFrame.entitiesFrame.getFightTeam(entity.id);
                  infos = new RoleplayTeamFightersTooltipInformation(fight);
                  tooltipMaker = "roleplayFight";
                  this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                  if((fight.hasOptions()) || (fight.hasGroupMember()))
                  {
                     tooltipOffset = 35;
                  }
               }
               else
               {
                  switch(true)
                  {
                     case infos is GameRolePlayCharacterInformations:
                        if(infos.contextualId == PlayedCharacterManager.getInstance().id)
                        {
                           levelDiffInfo = 0;
                        }
                        else
                        {
                           targetLevel = infos.alignmentInfos.characterPower - infos.contextualId;
                           playerLevel = PlayedCharacterManager.getInstance().infos.level;
                           levelDiffInfo = PlayedCharacterManager.getInstance().levelDiff(targetLevel);
                        }
                        infos = new CharacterTooltipInformation(infos as GameRolePlayCharacterInformations,levelDiffInfo);
                        cacheName = "CharacterCache";
                        break;
                     case infos is GameRolePlayMerchantInformations:
                        cacheName = "MerchantCharacterCache";
                        break;
                     case infos is GameRolePlayMutantInformations:
                        if((infos as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                        {
                           infos = new CharacterTooltipInformation(infos,0);
                        }
                        else
                        {
                           infos = new MutantTooltipInformation(infos as GameRolePlayMutantInformations);
                        }
                        break;
                     case infos is GameRolePlayTaxCollectorInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        grtci = infos as GameRolePlayTaxCollectorInformations;
                        guildtcinfos = grtci.identification.guildIdentity;
                        allianceInfos = grtci.identification is TaxCollectorStaticExtendedInformations?(grtci.identification as TaxCollectorStaticExtendedInformations).allianceIdentity:null;
                        gwtc = GuildWrapper.create(guildtcinfos.guildId,guildtcinfos.guildName,guildtcinfos.guildEmblem,0,true);
                        awtc = allianceInfos?AllianceWrapper.create(allianceInfos.allianceId,allianceInfos.allianceTag,allianceInfos.allianceName,allianceInfos.allianceEmblem):null;
                        infos = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((infos as GameRolePlayTaxCollectorInformations).identification.lastNameId).name,TaxCollectorFirstname.getTaxCollectorFirstnameById((infos as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname,gwtc,awtc,(infos as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                        break;
                     case infos is GameRolePlayNpcInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        npcInfos = infos as GameRolePlayNpcInformations;
                        npc = Npc.getNpcById(npcInfos.npcId);
                        infos = new TextTooltipInfo(npc.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","green",0);
                        infos.bgCornerRadius = 10;
                        cacheName = "NPCCacheName";
                        if(npc.actions.length == 0)
                        {
                           break;
                        }
                        this.displayCursor(NPC_CURSOR);
                        break;
                     case infos is GameRolePlayGroupMonsterInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                        if(Kernel.getWorker().contains(MonstersInfoFrame))
                        {
                           tooltipName = "MonstersInfo_" + infos.contextualId;
                           cacheName = (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).getCacheName(infos.contextualId);
                        }
                        else
                        {
                           cacheName = "GroupMonsterCache";
                        }
                        break;
                     case infos is GameRolePlayPrismInformations:
                        allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
                        infos = new PrismTooltipInformation(allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance);
                        break;
                     case infos is GameRolePlayPortalInformations:
                        infos = new PortalTooltipInformation((infos as GameRolePlayPortalInformations).portal.areaId);
                        break;
                     case infos is GameContextPaddockItemInformations:
                        cacheName = "PaddockItemCache";
                        break;
                  }
               }
               if(!infos)
               {
                  _log.warn("Rolling over a unknown entity (" + emomsg.entity.id + ").");
                  return false;
               }
               if(this.roleplayContextFrame.entitiesFrame.hasIcon(entity.id))
               {
                  tooltipOffset = 45;
               }
               if((animatedCharacter) && (!animatedCharacter.rawAnimation) && (!this._entityTooltipData[animatedCharacter]))
               {
                  this._entityTooltipData[animatedCharacter] = 
                     {
                        "data":infos,
                        "name":tooltipName,
                        "tooltipMaker":tooltipMaker,
                        "tooltipOffset":tooltipOffset,
                        "cacheName":cacheName
                     };
                  animatedCharacter.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
                  animatedCharacter.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
               }
               else
               {
                  TooltipManager.show(infos,targetBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,tooltipName,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,tooltipOffset,true,tooltipMaker,null,null,cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
               }
               return true;
            case msg is MouseRightClickMessage:
               mrcmsg = msg as MouseRightClickMessage;
               modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               rightClickedEntity = mrcmsg.target as IInteractive;
               if(rightClickedEntity)
               {
                  rcf = this.roleplayContextFrame;
                  if((!(rightClickedEntity as AnimatedCharacter)) || ((rightClickedEntity as AnimatedCharacter).followed == null))
                  {
                     actorInfos = rcf.entitiesFrame.getEntityInfos(rightClickedEntity.id);
                  }
                  else
                  {
                     actorInfos = rcf.entitiesFrame.getEntityInfos((rightClickedEntity as AnimatedCharacter).followed.id);
                  }
                  if(actorInfos is GameRolePlayNamedActorInformations)
                  {
                     if(!(rightClickedEntity is AnimatedCharacter))
                     {
                        _log.error("L\'entity " + rightClickedEntity.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                        return true;
                     }
                     rightClickedEntity = (rightClickedEntity as AnimatedCharacter).getRootEntity();
                     rightClickedinfos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(rightClickedEntity.id);
                     menu = MenusFactory.create(rightClickedinfos,"multiplayer",[rightClickedEntity]);
                     if(menu)
                     {
                        modContextMenu.createContextMenu(menu);
                     }
                     return true;
                  }
                  if(actorInfos is GameRolePlayGroupMonsterInformations)
                  {
                     menu = MenusFactory.create(actorInfos,"monsterGroup",[rightClickedEntity]);
                     if(menu)
                     {
                        modContextMenu.createContextMenu(menu);
                     }
                     return true;
                  }
               }
               return false;
            case msg is EntityMouseOutMessage:
               emoutmsg = msg as EntityMouseOutMessage;
               this._mouseOverEntityId = 0;
               this.displayCursor(NO_CURSOR);
               TooltipManager.hide("entity_" + emoutmsg.entity.id);
               animatedCharacter = emoutmsg.entity as AnimatedCharacter;
               if(animatedCharacter)
               {
                  animatedCharacter = animatedCharacter.getRootEntity();
                  animatedCharacter.highLightCharacterAndFollower(false);
                  if(!Kernel.getWorker().getFrame(MonstersInfoFrame))
                  {
                     TooltipManager.hide("MonstersInfo_" + animatedCharacter.id);
                  }
               }
               if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)
               {
                  animatedCharacter.visibleAura = false;
               }
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               entityc = ecmsg.entity as IInteractive;
               if(entityc is AnimatedCharacter)
               {
                  entityc = (entityc as AnimatedCharacter).getRootEntity();
               }
               EntityClickInfo = this.roleplayContextFrame.entitiesFrame.getEntityInfos(entityc.id);
               menuResult = RoleplayManager.getInstance().displayContextualMenu(EntityClickInfo,entityc);
               if(this.roleplayContextFrame.entitiesFrame.isFight(entityc.id))
               {
                  fightId = this.roleplayContextFrame.entitiesFrame.getFightId(entityc.id);
                  fightTeamLeader = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(entityc.id);
                  teamType = this.roleplayContextFrame.entitiesFrame.getFightTeamType(entityc.id);
                  if(teamType == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                  {
                     team = this.roleplayContextFrame.entitiesFrame.getFightTeam(entityc.id) as FightTeam;
                     for each(fighter in team.teamInfos.teamMembers)
                     {
                        if(fighter is FightTeamMemberTaxCollectorInformations)
                        {
                           guildId = (fighter as FightTeamMemberTaxCollectorInformations).guildId;
                        }
                     }
                     guild = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                     if((guild) && (guildId == guild.guildId))
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,1,2);
                        Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                        return true;
                     }
                  }
                  gfjrmsg = new GameFightJoinRequestMessage();
                  gfjrmsg.initGameFightJoinRequestMessage(fightTeamLeader,fightId);
                  playerEntity3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if((playerEntity3 as IMovable).isMoving)
                  {
                     this.roleplayMovementFrame.setFollowingMessage(gfjrmsg);
                     (playerEntity3 as IMovable).stop();
                  }
                  else
                  {
                     ConnectionsHandler.getConnection().send(gfjrmsg);
                  }
               }
               else if((!(entityc.id == PlayedCharacterManager.getInstance().id)) && (!menuResult))
               {
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  this.roleplayMovementFrame.askMoveTo(entityc.position);
               }
               
               return true;
            case msg is InteractiveElementActivationMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               ieamsg = msg as InteractiveElementActivationMessage;
               interactiveFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if(!((interactiveFrame) && (interactiveFrame.usingInteractive)))
               {
                  playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if((!DataMapProvider.getInstance().farmCell(playerEntity.position.x,playerEntity.position.y)) && (ieamsg.interactiveElement.elementTypeId == 120))
                  {
                     i = 0;
                     while(i < 8)
                     {
                        mp = ieamsg.position.getNearestCellInDirection(i);
                        if((mp) && (DataMapProvider.getInstance().farmCell(mp.x,mp.y)))
                        {
                           if(!forbiddenCellsIds)
                           {
                              forbiddenCellsIds = [];
                           }
                           forbiddenCellsIds.push(mp.cellId);
                        }
                        i++;
                     }
                  }
                  nearestCell = ieamsg.position.getNearestFreeCellInDirection(ieamsg.position.advancedOrientationTo(playerEntity.position),DataMapProvider.getInstance(),true,true,forbiddenCellsIds);
                  if(!nearestCell)
                  {
                     nearestCell = ieamsg.position;
                  }
                  this.roleplayMovementFrame.setFollowingInteraction(
                     {
                        "ie":ieamsg.interactiveElement,
                        "skillInstanceId":ieamsg.skillInstanceId
                     });
                  this.roleplayMovementFrame.askMoveTo(nearestCell);
               }
               return true;
            case msg is InteractiveElementMouseOverMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               iemovmsg = msg as InteractiveElementMouseOverMessage;
               interactiveElem = iemovmsg.interactiveElement;
               for each(interactiveSkill in interactiveElem.enabledSkills)
               {
                  if(interactiveSkill.skillId == 175)
                  {
                     infosIe = this.roleplayContextFrame.currentPaddock;
                     break;
                  }
               }
               interactive = Interactive.getInteractiveById(interactiveElem.elementTypeId);
               elementId = iemovmsg.interactiveElement.elementId;
               roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               houseWrapper = roleplayEntitiesFrame.housesInformations[elementId];
               target = iemovmsg.sprite.getRect(StageShareManager.stage);
               if(houseWrapper)
               {
                  infosIe = houseWrapper;
               }
               else if((infosIe == null) && (interactive))
               {
                  elem = new Object();
                  elem.interactive = interactive.name;
                  enabledSkills = "";
                  for each(interactiveSkill in interactiveElem.enabledSkills)
                  {
                     enabledSkills = enabledSkills + (Skill.getSkillById(interactiveSkill.skillId).name + "\n");
                  }
                  elem.enabledSkills = enabledSkills;
                  disabledSkills = "";
                  for each(interactiveSkill in interactiveElem.disabledSkills)
                  {
                     disabledSkills = disabledSkills + (Skill.getSkillById(interactiveSkill.skillId).name + "\n");
                  }
                  elem.disabledSkills = disabledSkills;
                  elem.isCollectable = interactive.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID;
                  if(elem.isCollectable)
                  {
                     showBonus = true;
                     iewab = interactiveElem as InteractiveElementWithAgeBonus;
                     if(interactiveElem.enabledSkills.length > 0)
                     {
                        collectSkill = Skill.getSkillById(interactiveElem.enabledSkills[0].skillId);
                        if(collectSkill.parentJobId == 1)
                        {
                           showBonus = false;
                        }
                     }
                     else if(!iewab)
                     {
                        showBonus = false;
                     }
                     
                     if(showBonus)
                     {
                        elem.collectSkill = collectSkill;
                        elem.ageBonus = iewab?iewab.ageBonus:0;
                     }
                  }
                  infosIe = elem;
                  ttMaker = "interactiveElement";
                  tooltipCacheName = "InteractiveElementCache";
               }
               
               if(infosIe)
               {
                  TooltipManager.show(infosIe,new Rectangle(target.right,int(target.y + target.height - AtouinConstants.CELL_HEIGHT),0,0),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TooltipManager.TOOLTIP_STANDAR_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOP,0,true,ttMaker,null,null,tooltipCacheName);
               }
               return true;
            case msg is InteractiveElementMouseOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               iemomsg = msg as InteractiveElementMouseOutMessage;
               TooltipManager.hide();
               return true;
            case msg is ShowAllNamesAction:
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames,false);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._infoEntitiesFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames,true);
               }
               break;
            case msg is ShowMonstersInfoAction:
               smia = msg as ShowMonstersInfoAction;
               _monstersInfoFrame.triggeredByShortcut = smia.fromShortcut;
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  Kernel.getWorker().removeFrame(_monstersInfoFrame);
               }
               else if((AirScanner.hasAir()) && (StageShareManager.stage.nativeWindow.active) && (!((!_monstersInfoFrame.triggeredByShortcut) && (!this._mouseDown))))
               {
                  Kernel.getWorker().addFrame(_monstersInfoFrame);
               }
               
               return true;
            case msg is MouseDownMessage:
               this._mouseDown = true;
               break;
            case msg is MouseUpMessage:
               this._mouseDown = false;
               mum = msg as MouseUpMessage;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if((sf.heldShortcuts.indexOf("showMonstersInfo") == -1) && (Kernel.getWorker().contains(MonstersInfoFrame)))
               {
                  Kernel.getWorker().removeFrame(_monstersInfoFrame);
               }
               break;
         }
         return false;
      }
      
      public function pulled() : Boolean {
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         Mouse.show();
         LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
         LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
         FrustumManager.getInstance().setBorderInteraction(false);
         return true;
      }
      
      private function onEntityAnimRendered(pEvent:TiphonEvent) : void {
         var ac:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
         var tooltipData:Object = this._entityTooltipData[ac];
         TooltipManager.show(tooltipData.data,ac.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,tooltipData.name,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,tooltipData.tooltipOffset,true,tooltipData.tooltipMaker,null,null,tooltipData.cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
         delete this._entityTooltipData[ac];
      }
      
      private function displayCursor(type:int, pEnable:Boolean = true) : void {
         if(type == -1)
         {
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
            return;
         }
         if(PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
         {
            return;
         }
         var lcd:LinkedCursorData = new LinkedCursorData();
         lcd.sprite = RoleplayInteractivesFrame.getCursor(type,pEnable);
         lcd.offset = INTERACTIVE_CURSOR_OFFSET;
         Mouse.hide();
         LinkedCursorSpriteManager.getInstance().addItem("interactiveCursor",lcd);
      }
      
      private function onWisperMessage(playerName:String) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus,playerName);
      }
      
      private function onMerchantPlayerBuyClick(vendorId:int, vendorCellId:uint) : void {
         var eohvrmsg:ExchangeOnHumanVendorRequestMessage = new ExchangeOnHumanVendorRequestMessage();
         eohvrmsg.initExchangeOnHumanVendorRequestMessage(vendorId,vendorCellId);
         ConnectionsHandler.getConnection().send(eohvrmsg);
      }
      
      private function onInviteMenuClicked(playerName:String) : void {
         var invitemsg:PartyInvitationRequestMessage = new PartyInvitationRequestMessage();
         invitemsg.initPartyInvitationRequestMessage(playerName);
         ConnectionsHandler.getConnection().send(invitemsg);
      }
      
      private function onMerchantHouseKickOff(cellId:uint) : void {
         var kickRequest:HouseKickIndoorMerchantRequestMessage = new HouseKickIndoorMerchantRequestMessage();
         kickRequest.initHouseKickIndoorMerchantRequestMessage(cellId);
         ConnectionsHandler.getConnection().send(kickRequest);
      }
      
      private function onWindowDeactivate(pEvent:Event) : void {
         if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(_monstersInfoFrame);
         }
      }
   }
}
