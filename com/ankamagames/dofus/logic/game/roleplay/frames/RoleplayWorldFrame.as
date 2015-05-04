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
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
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
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.tiphon.display.TiphonSprite;
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
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayTreasureHintInformations;
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
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.data.I18n;
   import flash.display.Sprite;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.atouin.types.FrustumShape;
   import flash.events.MouseEvent;
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
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
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
      
      public function RoleplayWorldFrame()
      {
         this._infoEntitiesFrame = new InfoEntitiesFrame();
         this.sysApi = new SystemApi();
         this._entityTooltipData = new Dictionary();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayWorldFrame));
      
      private static const NO_CURSOR:int = -1;
      
      private static const FIGHT_CURSOR:int = 3;
      
      private static const NPC_CURSOR:int = 1;
      
      private static const INTERACTIVE_CURSOR_OFFSET:Point = new Point(0,0);
      
      private static const COLLECTABLE_INTERACTIVE_ACTION_ID:uint = 1;
      
      private static var _monstersInfoFrame:MonstersInfoFrame = new MonstersInfoFrame();
      
      private const _common:String = XmlConfig.getInstance().getEntry("config.ui.skin");
      
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
      
      public function get mouseOverEntityId() : int
      {
         return this._mouseOverEntityId;
      }
      
      public function set allowOnlyCharacterInteraction(param1:Boolean) : void
      {
         this._allowOnlyCharacterInteraction = param1;
      }
      
      public function get allowOnlyCharacterInteraction() : Boolean
      {
         return this._allowOnlyCharacterInteraction;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame
      {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function pushed() : Boolean
      {
         FrustumManager.getInstance().setBorderInteraction(true);
         this._allowOnlyCharacterInteraction = false;
         this.cellClickEnabled = true;
         this.pivotingCharacter = false;
         var _loc1_:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         if(!(_loc1_.heldShortcuts.indexOf("showMonstersInfo") == -1) && !Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().addFrame(_monstersInfoFrame);
         }
         else if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(_monstersInfoFrame);
         }
         
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
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
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:AdjacentMapOverMessage = null;
         var _loc3_:Point = null;
         var _loc4_:GraphicCell = null;
         var _loc5_:Point = null;
         var _loc6_:LinkedCursorData = null;
         var _loc7_:WorldPointWrapper = null;
         var _loc8_:* = 0;
         var _loc9_:SubArea = null;
         var _loc10_:* = false;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:Point = null;
         var _loc16_:EntityMouseOverMessage = null;
         var _loc17_:String = null;
         var _loc18_:IInteractive = null;
         var _loc19_:AnimatedCharacter = null;
         var _loc20_:* = undefined;
         var _loc21_:IRectangle = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:* = NaN;
         var _loc25_:MouseRightClickMessage = null;
         var _loc26_:Object = null;
         var _loc27_:IInteractive = null;
         var _loc28_:EntityMouseOutMessage = null;
         var _loc29_:EntityClickMessage = null;
         var _loc30_:IInteractive = null;
         var _loc31_:GameContextActorInformations = null;
         var _loc32_:* = false;
         var _loc33_:InteractiveElementActivationMessage = null;
         var _loc34_:RoleplayInteractivesFrame = null;
         var _loc35_:InteractiveElementMouseOverMessage = null;
         var _loc36_:Object = null;
         var _loc37_:String = null;
         var _loc38_:String = null;
         var _loc39_:InteractiveElement = null;
         var _loc40_:InteractiveElementSkill = null;
         var _loc41_:Interactive = null;
         var _loc42_:uint = 0;
         var _loc43_:RoleplayEntitiesFrame = null;
         var _loc44_:HouseWrapper = null;
         var _loc45_:Rectangle = null;
         var _loc46_:InteractiveElementMouseOutMessage = null;
         var _loc47_:ShowMonstersInfoAction = null;
         var _loc48_:MouseUpMessage = null;
         var _loc49_:ShortcutsFrame = null;
         var _loc50_:CellClickMessage = null;
         var _loc51_:AdjacentMapClickMessage = null;
         var _loc52_:IEntity = null;
         var _loc53_:MapPosition = null;
         var _loc54_:String = null;
         var _loc55_:Rectangle = null;
         var _loc56_:Object = null;
         var _loc57_:Array = null;
         var _loc58_:DisplayObject = null;
         var _loc59_:DisplayObjectContainer = null;
         var _loc60_:UiRootContainer = null;
         var _loc61_:GraphicContainer = null;
         var _loc62_:Array = null;
         var _loc63_:GraphicContainer = null;
         var _loc64_:* = undefined;
         var _loc65_:* = false;
         var _loc66_:TiphonSprite = null;
         var _loc67_:TiphonSprite = null;
         var _loc68_:* = false;
         var _loc69_:DisplayObject = null;
         var _loc70_:Rectangle = null;
         var _loc71_:Rectangle2 = null;
         var _loc72_:FightTeam = null;
         var _loc73_:AllianceInformations = null;
         var _loc74_:* = 0;
         var _loc75_:GameRolePlayTaxCollectorInformations = null;
         var _loc76_:GuildInformations = null;
         var _loc77_:GuildWrapper = null;
         var _loc78_:AllianceWrapper = null;
         var _loc79_:GameRolePlayNpcInformations = null;
         var _loc80_:Npc = null;
         var _loc81_:AllianceFrame = null;
         var _loc82_:GameRolePlayTreasureHintInformations = null;
         var _loc83_:Npc = null;
         var _loc84_:uint = 0;
         var _loc85_:uint = 0;
         var _loc86_:RoleplayContextFrame = null;
         var _loc87_:GameContextActorInformations = null;
         var _loc88_:Object = null;
         var _loc89_:GameContextActorInformations = null;
         var _loc90_:uint = 0;
         var _loc91_:* = 0;
         var _loc92_:uint = 0;
         var _loc93_:GameFightJoinRequestMessage = null;
         var _loc94_:IEntity = null;
         var _loc95_:* = 0;
         var _loc96_:FightTeam = null;
         var _loc97_:FightTeamMemberInformations = null;
         var _loc98_:GuildWrapper = null;
         var _loc99_:IEntity = null;
         var _loc100_:Array = null;
         var _loc101_:* = 0;
         var _loc102_:MapPoint = null;
         var _loc103_:MapPoint = null;
         var _loc104_:Object = null;
         var _loc105_:String = null;
         var _loc106_:String = null;
         var _loc107_:Skill = null;
         var _loc108_:* = false;
         var _loc109_:InteractiveElementWithAgeBonus = null;
         switch(true)
         {
            case param1 is CellClickMessage:
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
                  _loc50_ = param1 as CellClickMessage;
                  (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentEmoticon = 0;
                  this.roleplayMovementFrame.resetNextMoveMapChange();
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc50_.cellId));
               }
               return true;
            case param1 is AdjacentMapClickMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(this.cellClickEnabled)
               {
                  _loc51_ = param1 as AdjacentMapClickMessage;
                  _loc52_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!_loc52_)
                  {
                     _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                     return false;
                  }
                  this.roleplayMovementFrame.setNextMoveMapChange(_loc51_.adjacentMapId);
                  if(!_loc52_.position.equals(MapPoint.fromCellId(_loc51_.cellId)))
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc51_.cellId));
                  }
                  else
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMapChange();
                  }
               }
               return true;
            case param1 is AdjacentMapOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               TooltipManager.hide("subareaChange");
               LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
               return true;
            case param1 is AdjacentMapOverMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               _loc2_ = AdjacentMapOverMessage(param1);
               _loc3_ = CellIdConverter.cellIdToCoord(_loc2_.cellId);
               _loc4_ = InteractiveCellManager.getInstance().getCell(_loc2_.cellId);
               _loc5_ = _loc4_.parent.localToGlobal(new Point(_loc4_.x,_loc4_.y));
               _loc6_ = new LinkedCursorData();
               if(PlayedCharacterManager.getInstance().currentMap.leftNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.rightNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.topNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.bottomNeighbourId == -1)
               {
                  _loc7_ = new WorldPointWrapper(MapDisplayManager.getInstance().getDataMapContainer().id);
               }
               else
               {
                  _loc7_ = PlayedCharacterManager.getInstance().currentMap;
               }
               if(_loc2_.direction == DirectionsEnum.RIGHT)
               {
                  _loc8_ = _loc7_.rightNeighbourId;
               }
               else if(_loc2_.direction == DirectionsEnum.DOWN)
               {
                  _loc8_ = _loc7_.bottomNeighbourId;
               }
               else if(_loc2_.direction == DirectionsEnum.LEFT)
               {
                  _loc8_ = _loc7_.leftNeighbourId;
               }
               else if(_loc2_.direction == DirectionsEnum.UP)
               {
                  _loc8_ = _loc7_.topNeighbourId;
               }
               
               
               
               _loc9_ = SubArea.getSubAreaByMapId(_loc8_);
               _loc10_ = false;
               _loc11_ = 0;
               _loc12_ = 0;
               if(_loc9_)
               {
                  if(_loc9_.id != PlayedCharacterManager.getInstance().currentSubArea.id)
                  {
                     _loc10_ = true;
                     _loc14_ = I18n.getUiText("ui.common.toward",[_loc9_.name]);
                     _loc54_ = I18n.getUiText("ui.common.level") + " " + _loc9_.level;
                  }
                  _loc53_ = MapPosition.getMapPositionById(_loc8_);
                  if((_loc53_.showNameOnFingerpost) && (_loc53_.name))
                  {
                     _loc14_ = I18n.getUiText("ui.common.toward",[_loc53_.name]);
                  }
                  if((_loc14_) && !(_loc14_ == ""))
                  {
                     this._mouseLabel.text = _loc14_.length > _loc54_.length?_loc14_:_loc54_;
                     _loc13_ = _loc14_ + "\n" + _loc54_;
                  }
               }
               switch(_loc2_.direction)
               {
                  case DirectionsEnum.LEFT:
                     _loc6_.sprite = _loc10_?this._mouseLeftBlue:this._mouseLeft;
                     _loc6_.lockX = true;
                     _loc6_.sprite.x = _loc2_.zone.x + _loc2_.zone.width / 2;
                     _loc6_.offset = new Point(0,0);
                     _loc6_.lockY = true;
                     _loc6_.sprite.y = _loc5_.y + AtouinConstants.CELL_HEIGHT / 2 * Atouin.getInstance().currentZoom;
                     if(_loc10_)
                     {
                        _loc11_ = 0;
                        _loc12_ = _loc6_.sprite.height / 2;
                     }
                     break;
                  case DirectionsEnum.UP:
                     _loc6_.sprite = _loc10_?this._mouseTopBlue:this._mouseTop;
                     _loc6_.lockY = true;
                     _loc6_.sprite.y = _loc2_.zone.y + _loc2_.zone.height / 2;
                     _loc6_.offset = new Point(0,0);
                     _loc6_.lockX = true;
                     _loc6_.sprite.x = _loc5_.x + AtouinConstants.CELL_WIDTH / 2 * Atouin.getInstance().currentZoom;
                     if(_loc10_)
                     {
                        _loc11_ = -this._mouseLabel.textWidth / 2;
                        _loc12_ = _loc6_.sprite.height + 5;
                     }
                     break;
                  case DirectionsEnum.DOWN:
                     _loc6_.sprite = _loc10_?this._mouseBottomBlue:this._mouseBottom;
                     _loc6_.lockY = true;
                     _loc6_.sprite.y = _loc2_.zone.getBounds(_loc2_.zone).top;
                     _loc6_.offset = new Point(0,0);
                     _loc6_.lockX = true;
                     _loc6_.sprite.x = _loc5_.x + AtouinConstants.CELL_WIDTH / 2 * Atouin.getInstance().currentZoom;
                     if(_loc10_)
                     {
                        _loc11_ = -this._mouseLabel.textWidth / 2;
                        _loc12_ = -_loc6_.sprite.height - this._mouseLabel.textHeight - 34;
                     }
                     break;
                  case DirectionsEnum.RIGHT:
                     _loc6_.sprite = _loc10_?this._mouseRightBlue:this._mouseRight;
                     _loc6_.lockX = true;
                     _loc6_.sprite.x = _loc2_.zone.getBounds(_loc2_.zone).left + _loc2_.zone.width / 2;
                     _loc6_.offset = new Point(0,0);
                     _loc6_.lockY = true;
                     _loc6_.sprite.y = _loc5_.y + AtouinConstants.CELL_HEIGHT / 2 * Atouin.getInstance().currentZoom;
                     if(_loc10_)
                     {
                        _loc11_ = -this._mouseLabel.textWidth;
                        _loc12_ = _loc6_.sprite.height / 2;
                     }
                     break;
               }
               if(_loc10_)
               {
                  _loc55_ = new Rectangle(_loc6_.sprite.x + _loc11_,_loc6_.sprite.y + _loc12_,1,1);
                  _loc56_ = new Object();
                  _loc56_.classCss = "center";
                  TooltipManager.show(_loc13_,_loc55_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"subareaChange",0,0,0,true,null,null,_loc56_,"Text" + _loc8_,false,StrataEnum.STRATA_TOOLTIP,1);
               }
               LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor",_loc6_);
               return true;
            case param1 is MapComplementaryInformationsDataMessage:
               if(!StageShareManager.mouseOnStage)
               {
                  return false;
               }
               _loc15_ = new Point(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY);
               if(Atouin.getInstance().options.frustum.containsPoint(_loc15_))
               {
                  _loc57_ = StageShareManager.stage.getObjectsUnderPoint(_loc15_);
                  _loc60_ = Berilia.getInstance().getUi("banner");
                  _loc61_ = _loc60_.getElement("mainCtr");
                  _loc62_ = _loc60_.getElements();
                  while(true)
                  {
                     for each(_loc58_ in _loc57_)
                     {
                        _loc59_ = _loc58_ is GraphicContainer?_loc58_ as GraphicContainer:_loc58_.parent;
                        if(_loc58_ != _loc59_)
                        {
                           while(_loc59_)
                           {
                              if(_loc59_ is GraphicContainer)
                              {
                                 break;
                              }
                              _loc59_ = _loc59_.parent;
                           }
                        }
                        _loc65_ = false;
                        for(_loc64_ in _loc62_)
                        {
                           _loc63_ = _loc62_[_loc64_];
                           if(_loc63_ == _loc59_ && _loc64_.indexOf("elem_") == -1)
                           {
                              _loc65_ = true;
                              break;
                           }
                        }
                        if((_loc59_) && (_loc65_) && (_loc61_.contains(_loc59_)))
                        {
                           break;
                        }
                        continue;
                     }
                     var _loc110_:* = 0;
                     var _loc111_:* = _loc57_;
                     for each(_loc58_ in _loc57_)
                     {
                        if(_loc58_.parent is FrustumShape)
                        {
                           _loc58_.parent.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
                           break;
                        }
                     }
                  }
                  return false;
               }
               return false;
            case param1 is EntityMouseOverMessage:
               _loc16_ = param1 as EntityMouseOverMessage;
               this._mouseOverEntityId = _loc16_.entity.id;
               _loc17_ = "entity_" + _loc16_.entity.id;
               this.displayCursor(NO_CURSOR);
               _loc18_ = _loc16_.entity as IInteractive;
               _loc19_ = _loc18_ as AnimatedCharacter;
               if(_loc19_)
               {
                  _loc19_ = _loc19_.getRootEntity();
                  _loc19_.highLightCharacterAndFollower(true);
                  _loc18_ = _loc19_;
                  if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER && _loc19_.getDirection() == DirectionsEnum.DOWN)
                  {
                     _loc19_.visibleAura = true;
                  }
               }
               _loc20_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc18_.id) as GameRolePlayActorInformations;
               if(_loc18_ is TiphonSprite)
               {
                  _loc66_ = _loc18_ as TiphonSprite;
                  _loc67_ = (_loc18_ as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                  _loc68_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame)) && (RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode);
                  if((_loc67_) && !_loc68_)
                  {
                     _loc66_ = _loc67_;
                  }
                  _loc69_ = _loc66_.getSlot("Tete");
                  if(_loc69_)
                  {
                     _loc70_ = _loc69_.getBounds(StageShareManager.stage);
                     _loc71_ = new Rectangle2(_loc70_.x,_loc70_.y,_loc70_.width,_loc70_.height);
                     _loc21_ = _loc71_;
                  }
               }
               if(!_loc21_ || _loc21_.width == 0 && _loc21_.height == 0)
               {
                  _loc21_ = (_loc18_ as IDisplayable).absoluteBounds;
               }
               _loc22_ = null;
               _loc24_ = 0;
               if(this.roleplayContextFrame.entitiesFrame.isFight(_loc18_.id))
               {
                  if(this.allowOnlyCharacterInteraction)
                  {
                     return false;
                  }
                  _loc72_ = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc18_.id);
                  _loc20_ = new RoleplayTeamFightersTooltipInformation(_loc72_);
                  _loc22_ = "roleplayFight";
                  this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                  if((_loc72_.hasOptions()) || (_loc72_.hasGroupMember()))
                  {
                     _loc24_ = 35;
                  }
               }
               else
               {
                  switch(true)
                  {
                     case _loc20_ is GameRolePlayCharacterInformations:
                        if(_loc20_.contextualId == PlayedCharacterManager.getInstance().id)
                        {
                           _loc74_ = 0;
                        }
                        else
                        {
                           _loc84_ = _loc20_.alignmentInfos.characterPower - _loc20_.contextualId;
                           _loc85_ = PlayedCharacterManager.getInstance().infos.level;
                           _loc74_ = PlayedCharacterManager.getInstance().levelDiff(_loc84_);
                        }
                        _loc20_ = new CharacterTooltipInformation(_loc20_ as GameRolePlayCharacterInformations,_loc74_);
                        _loc23_ = "CharacterCache";
                        break;
                     case _loc20_ is GameRolePlayMerchantInformations:
                        _loc23_ = "MerchantCharacterCache";
                        break;
                     case _loc20_ is GameRolePlayMutantInformations:
                        if((_loc20_ as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                        {
                           _loc20_ = new CharacterTooltipInformation(_loc20_,0);
                        }
                        else
                        {
                           _loc20_ = new MutantTooltipInformation(_loc20_ as GameRolePlayMutantInformations);
                        }
                        break;
                     case _loc20_ is GameRolePlayTaxCollectorInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        _loc75_ = _loc20_ as GameRolePlayTaxCollectorInformations;
                        _loc76_ = _loc75_.identification.guildIdentity;
                        _loc73_ = _loc75_.identification is TaxCollectorStaticExtendedInformations?(_loc75_.identification as TaxCollectorStaticExtendedInformations).allianceIdentity:null;
                        _loc77_ = GuildWrapper.create(_loc76_.guildId,_loc76_.guildName,_loc76_.guildEmblem,0,true);
                        _loc78_ = _loc73_?AllianceWrapper.create(_loc73_.allianceId,_loc73_.allianceTag,_loc73_.allianceName,_loc73_.allianceEmblem):null;
                        _loc20_ = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_loc20_ as GameRolePlayTaxCollectorInformations).identification.lastNameId).name,TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc20_ as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname,_loc77_,_loc78_,(_loc20_ as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                        break;
                     case _loc20_ is GameRolePlayNpcInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        _loc79_ = _loc20_ as GameRolePlayNpcInformations;
                        _loc80_ = Npc.getNpcById(_loc79_.npcId);
                        _loc20_ = new TextTooltipInfo(_loc80_.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","green",0);
                        _loc20_.bgCornerRadius = 10;
                        _loc23_ = "NPCCacheName";
                        if(_loc80_.actions.length == 0)
                        {
                           break;
                        }
                        this.displayCursor(NPC_CURSOR);
                        break;
                     case _loc20_ is GameRolePlayGroupMonsterInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                        if(Kernel.getWorker().contains(MonstersInfoFrame))
                        {
                           _loc17_ = "MonstersInfo_" + _loc20_.contextualId;
                           _loc23_ = (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).getCacheName(_loc20_.contextualId);
                        }
                        else
                        {
                           _loc23_ = "GroupMonsterCache";
                        }
                        break;
                     case _loc20_ is GameRolePlayPrismInformations:
                        _loc81_ = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
                        _loc20_ = new PrismTooltipInformation(_loc81_.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance);
                        break;
                     case _loc20_ is GameRolePlayPortalInformations:
                        _loc20_ = new PortalTooltipInformation((_loc20_ as GameRolePlayPortalInformations).portal.areaId);
                        break;
                     case _loc20_ is GameContextPaddockItemInformations:
                        _loc23_ = "PaddockItemCache";
                        break;
                     case _loc20_ is GameRolePlayTreasureHintInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        _loc82_ = _loc20_ as GameRolePlayTreasureHintInformations;
                        _loc83_ = Npc.getNpcById(_loc82_.npcId);
                        _loc20_ = new TextTooltipInfo(_loc83_.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","orange",0);
                        _loc20_.bgCornerRadius = 10;
                        _loc23_ = "TrHintCacheName";
                        break;
                  }
               }
               if(!_loc20_)
               {
                  _log.warn("Rolling over a unknown entity (" + _loc16_.entity.id + ").");
                  return false;
               }
               if(this.roleplayContextFrame.entitiesFrame.hasIcon(_loc18_.id))
               {
                  _loc24_ = 45;
               }
               if((_loc19_) && (!_loc19_.rawAnimation) && !this._entityTooltipData[_loc19_])
               {
                  this._entityTooltipData[_loc19_] = {
                     "data":_loc20_,
                     "name":_loc17_,
                     "tooltipMaker":_loc22_,
                     "tooltipOffset":_loc24_,
                     "cacheName":_loc23_
                  };
                  _loc19_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
                  _loc19_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
               }
               else
               {
                  TooltipManager.show(_loc20_,_loc21_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,_loc17_,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,_loc24_,true,_loc22_,null,null,_loc23_,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
               }
               return true;
            case param1 is MouseRightClickMessage:
               _loc25_ = param1 as MouseRightClickMessage;
               _loc26_ = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               _loc27_ = _loc25_.target as IInteractive;
               if(_loc27_)
               {
                  _loc86_ = this.roleplayContextFrame;
                  if(!(_loc27_ as AnimatedCharacter) || (_loc27_ as AnimatedCharacter).followed == null)
                  {
                     _loc87_ = _loc86_.entitiesFrame.getEntityInfos(_loc27_.id);
                  }
                  else
                  {
                     _loc87_ = _loc86_.entitiesFrame.getEntityInfos((_loc27_ as AnimatedCharacter).followed.id);
                  }
                  if(_loc87_ is GameRolePlayNamedActorInformations)
                  {
                     if(!(_loc27_ is AnimatedCharacter))
                     {
                        _log.error("L\'entity " + _loc27_.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                        return true;
                     }
                     _loc27_ = (_loc27_ as AnimatedCharacter).getRootEntity();
                     _loc89_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc27_.id);
                     _loc88_ = MenusFactory.create(_loc89_,"multiplayer",[_loc27_]);
                     if(_loc88_)
                     {
                        _loc26_.createContextMenu(_loc88_);
                     }
                     return true;
                  }
                  if(_loc87_ is GameRolePlayGroupMonsterInformations)
                  {
                     _loc88_ = MenusFactory.create(_loc87_,"monsterGroup",[_loc27_]);
                     if(_loc88_)
                     {
                        _loc26_.createContextMenu(_loc88_);
                     }
                     return true;
                  }
               }
               return false;
            case param1 is EntityMouseOutMessage:
               _loc28_ = param1 as EntityMouseOutMessage;
               this._mouseOverEntityId = 0;
               this.displayCursor(NO_CURSOR);
               TooltipManager.hide("entity_" + _loc28_.entity.id);
               _loc19_ = _loc28_.entity as AnimatedCharacter;
               if(_loc19_)
               {
                  _loc19_ = _loc19_.getRootEntity();
                  _loc19_.highLightCharacterAndFollower(false);
                  if(!Kernel.getWorker().getFrame(MonstersInfoFrame))
                  {
                     TooltipManager.hide("MonstersInfo_" + _loc19_.id);
                  }
                  if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)
                  {
                     _loc19_.visibleAura = false;
                  }
               }
               return true;
            case param1 is EntityClickMessage:
               _loc29_ = param1 as EntityClickMessage;
               _loc30_ = _loc29_.entity as IInteractive;
               if(_loc30_ is AnimatedCharacter)
               {
                  _loc30_ = (_loc30_ as AnimatedCharacter).getRootEntity();
               }
               _loc31_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc30_.id);
               _loc32_ = RoleplayManager.getInstance().displayContextualMenu(_loc31_,_loc30_);
               if(this.roleplayContextFrame.entitiesFrame.isFight(_loc30_.id))
               {
                  _loc90_ = this.roleplayContextFrame.entitiesFrame.getFightId(_loc30_.id);
                  _loc91_ = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_loc30_.id);
                  _loc92_ = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_loc30_.id);
                  if(_loc92_ == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                  {
                     _loc96_ = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc30_.id) as FightTeam;
                     for each(_loc97_ in _loc96_.teamInfos.teamMembers)
                     {
                        if(_loc97_ is FightTeamMemberTaxCollectorInformations)
                        {
                           _loc95_ = (_loc97_ as FightTeamMemberTaxCollectorInformations).guildId;
                        }
                     }
                     _loc98_ = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                     if((_loc98_) && _loc95_ == _loc98_.guildId)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,1,2);
                        Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                        return true;
                     }
                  }
                  _loc93_ = new GameFightJoinRequestMessage();
                  _loc93_.initGameFightJoinRequestMessage(_loc91_,_loc90_);
                  _loc94_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if((_loc94_ as IMovable).isMoving)
                  {
                     this.roleplayMovementFrame.setFollowingMessage(_loc93_);
                     (_loc94_ as IMovable).stop();
                  }
                  else
                  {
                     ConnectionsHandler.getConnection().send(_loc93_);
                  }
               }
               else if(!(_loc30_.id == PlayedCharacterManager.getInstance().id) && !_loc32_)
               {
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  if(_loc31_ is GameRolePlayActorInformations && _loc31_ is GameRolePlayGroupMonsterInformations)
                  {
                     this.roleplayMovementFrame.setFollowingMonsterFight(_loc30_);
                  }
                  this.roleplayMovementFrame.askMoveTo(_loc30_.position);
               }
               
               return true;
            case param1 is InteractiveElementActivationMessage:
               if((this.allowOnlyCharacterInteraction) || !AirScanner.isStreamingVersion() && OptionManager.getOptionManager("dofus")["enableForceWalk"] == true && ((ShortcutsFrame.ctrlKeyDown) || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && (ShortcutsFrame.altKeyDown)))
               {
                  return false;
               }
               _loc33_ = param1 as InteractiveElementActivationMessage;
               _loc34_ = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if(!((_loc34_) && (_loc34_.usingInteractive)))
               {
                  _loc99_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!DataMapProvider.getInstance().farmCell(_loc99_.position.x,_loc99_.position.y) && _loc33_.interactiveElement.elementTypeId == 120)
                  {
                     _loc101_ = 0;
                     while(_loc101_ < 8)
                     {
                        _loc103_ = _loc33_.position.getNearestCellInDirection(_loc101_);
                        if((_loc103_) && (DataMapProvider.getInstance().farmCell(_loc103_.x,_loc103_.y)))
                        {
                           if(!_loc100_)
                           {
                              _loc100_ = [];
                           }
                           _loc100_.push(_loc103_.cellId);
                        }
                        _loc101_++;
                     }
                  }
                  _loc102_ = _loc33_.position.getNearestFreeCellInDirection(_loc33_.position.advancedOrientationTo(_loc99_.position),DataMapProvider.getInstance(),true,true,false,_loc100_);
                  if(!_loc102_)
                  {
                     _loc102_ = _loc33_.position;
                  }
                  this.roleplayMovementFrame.setFollowingInteraction({
                     "ie":_loc33_.interactiveElement,
                     "skillInstanceId":_loc33_.skillInstanceId
                  });
                  this.roleplayMovementFrame.askMoveTo(_loc102_);
               }
               return true;
            case param1 is InteractiveElementMouseOverMessage:
               if((this.allowOnlyCharacterInteraction) || !AirScanner.isStreamingVersion() && OptionManager.getOptionManager("dofus")["enableForceWalk"] == true && ((ShortcutsFrame.ctrlKeyDown) || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && (ShortcutsFrame.altKeyDown)))
               {
                  return false;
               }
               _loc35_ = param1 as InteractiveElementMouseOverMessage;
               _loc39_ = _loc35_.interactiveElement;
               for each(_loc40_ in _loc39_.enabledSkills)
               {
                  if(_loc40_.skillId == 175)
                  {
                     _loc36_ = this.roleplayContextFrame.currentPaddock;
                     break;
                  }
               }
               _loc41_ = Interactive.getInteractiveById(_loc39_.elementTypeId);
               _loc42_ = _loc35_.interactiveElement.elementId;
               _loc43_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               _loc44_ = _loc43_.housesInformations[_loc42_];
               _loc45_ = _loc35_.sprite.getRect(StageShareManager.stage);
               if(_loc44_)
               {
                  _loc36_ = _loc44_;
               }
               else if(_loc36_ == null && (_loc41_))
               {
                  _loc104_ = new Object();
                  _loc104_.interactive = _loc41_.name;
                  _loc105_ = "";
                  for each(_loc40_ in _loc39_.enabledSkills)
                  {
                     _loc105_ = _loc105_ + (Skill.getSkillById(_loc40_.skillId).name + "\n");
                  }
                  _loc104_.enabledSkills = _loc105_;
                  _loc106_ = "";
                  for each(_loc40_ in _loc39_.disabledSkills)
                  {
                     _loc106_ = _loc106_ + (Skill.getSkillById(_loc40_.skillId).name + "\n");
                  }
                  _loc104_.disabledSkills = _loc106_;
                  _loc104_.isCollectable = _loc41_.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID;
                  if(_loc104_.isCollectable)
                  {
                     _loc108_ = true;
                     _loc109_ = _loc39_ as InteractiveElementWithAgeBonus;
                     if(_loc39_.enabledSkills.length > 0)
                     {
                        _loc107_ = Skill.getSkillById(_loc39_.enabledSkills[0].skillId);
                        if(_loc107_.parentJobId == 1)
                        {
                           _loc108_ = false;
                        }
                     }
                     else if(!_loc109_)
                     {
                        _loc108_ = false;
                     }
                     
                     if(_loc108_)
                     {
                        _loc104_.collectSkill = _loc107_;
                        _loc104_.ageBonus = _loc109_?_loc109_.ageBonus:0;
                     }
                  }
                  _loc36_ = _loc104_;
                  _loc37_ = "interactiveElement";
                  _loc38_ = "InteractiveElementCache";
               }
               
               if(_loc36_)
               {
                  TooltipManager.show(_loc36_,new Rectangle(_loc45_.right,int(_loc45_.y + _loc45_.height - AtouinConstants.CELL_HEIGHT),0,0),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TooltipManager.TOOLTIP_STANDAR_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOP,0,true,_loc37_,null,null,_loc38_);
               }
               return true;
            case param1 is InteractiveElementMouseOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               _loc46_ = param1 as InteractiveElementMouseOutMessage;
               TooltipManager.hide();
               return true;
            case param1 is ShowAllNamesAction:
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
               return true;
            case param1 is ShowMonstersInfoAction:
               _loc47_ = param1 as ShowMonstersInfoAction;
               _monstersInfoFrame.triggeredByShortcut = _loc47_.fromShortcut;
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  Kernel.getWorker().removeFrame(_monstersInfoFrame);
               }
               else if((StageShareManager.isActive) && !(!_monstersInfoFrame.triggeredByShortcut && !this._mouseDown))
               {
                  Kernel.getWorker().addFrame(_monstersInfoFrame);
               }
               
               return true;
            case param1 is MouseDownMessage:
               this._mouseDown = true;
               break;
            case param1 is MouseUpMessage:
               this._mouseDown = false;
               _loc48_ = param1 as MouseUpMessage;
               _loc49_ = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(_loc49_.heldShortcuts.indexOf("showMonstersInfo") == -1 && (Kernel.getWorker().contains(MonstersInfoFrame)))
               {
                  Kernel.getWorker().removeFrame(_monstersInfoFrame);
               }
               break;
         }
         return false;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         Mouse.show();
         LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
         LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
         FrustumManager.getInstance().setBorderInteraction(false);
         return true;
      }
      
      private function onEntityAnimRendered(param1:TiphonEvent) : void
      {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
         var _loc3_:Object = this._entityTooltipData[_loc2_];
         TooltipManager.show(_loc3_.data,_loc2_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,_loc3_.name,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,_loc3_.tooltipOffset,true,_loc3_.tooltipMaker,null,null,_loc3_.cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
         delete this._entityTooltipData[_loc2_];
         true;
      }
      
      private function displayCursor(param1:int, param2:Boolean = true) : void
      {
         if(param1 == -1)
         {
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("interactiveCursor");
            return;
         }
         if(PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
         {
            return;
         }
         var _loc3_:LinkedCursorData = new LinkedCursorData();
         _loc3_.sprite = RoleplayInteractivesFrame.getCursor(param1,param2);
         _loc3_.offset = INTERACTIVE_CURSOR_OFFSET;
         Mouse.hide();
         LinkedCursorSpriteManager.getInstance().addItem("interactiveCursor",_loc3_);
      }
      
      private function onWisperMessage(param1:String) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus,param1);
      }
      
      private function onMerchantPlayerBuyClick(param1:int, param2:uint) : void
      {
         var _loc3_:ExchangeOnHumanVendorRequestMessage = new ExchangeOnHumanVendorRequestMessage();
         _loc3_.initExchangeOnHumanVendorRequestMessage(param1,param2);
         ConnectionsHandler.getConnection().send(_loc3_);
      }
      
      private function onInviteMenuClicked(param1:String) : void
      {
         var _loc2_:PartyInvitationRequestMessage = new PartyInvitationRequestMessage();
         _loc2_.initPartyInvitationRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function onMerchantHouseKickOff(param1:uint) : void
      {
         var _loc2_:HouseKickIndoorMerchantRequestMessage = new HouseKickIndoorMerchantRequestMessage();
         _loc2_.initHouseKickIndoorMerchantRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function onWindowDeactivate(param1:Event) : void
      {
         if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(_monstersInfoFrame);
         }
      }
   }
}
