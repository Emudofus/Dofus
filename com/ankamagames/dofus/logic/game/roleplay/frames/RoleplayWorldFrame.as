package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Point;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
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
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
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
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.logic.game.roleplay.types.PrismTooltipInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
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
      
      private var _mouseTop:Texture;
      
      private var _mouseBottom:Texture;
      
      private var _mouseRight:Texture;
      
      private var _mouseLeft:Texture;
      
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
      
      public function set allowOnlyCharacterInteraction(param1:Boolean) : void {
         this._allowOnlyCharacterInteraction = param1;
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
         var _loc1_:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         if(!(_loc1_.heldShortcuts.indexOf("showMonstersInfo") == -1) && !Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().addFrame(_monstersInfoFrame);
         }
         else
         {
            if(Kernel.getWorker().contains(MonstersInfoFrame))
            {
               Kernel.getWorker().removeFrame(_monstersInfoFrame);
            }
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
         this._texturesReady = true;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:AdjacentMapOverMessage = null;
         var _loc3_:Point = null;
         var _loc4_:GraphicCell = null;
         var _loc5_:LinkedCursorData = null;
         var _loc6_:EntityMouseOverMessage = null;
         var _loc7_:String = null;
         var _loc8_:IInteractive = null;
         var _loc9_:AnimatedCharacter = null;
         var _loc10_:* = undefined;
         var _loc11_:IRectangle = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:* = NaN;
         var _loc15_:MouseRightClickMessage = null;
         var _loc16_:Object = null;
         var _loc17_:IInteractive = null;
         var _loc18_:EntityMouseOutMessage = null;
         var _loc19_:EntityClickMessage = null;
         var _loc20_:IInteractive = null;
         var _loc21_:GameContextActorInformations = null;
         var _loc22_:* = false;
         var _loc23_:InteractiveElementActivationMessage = null;
         var _loc24_:RoleplayInteractivesFrame = null;
         var _loc25_:InteractiveElementMouseOverMessage = null;
         var _loc26_:Object = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:InteractiveElement = null;
         var _loc30_:InteractiveElementSkill = null;
         var _loc31_:Interactive = null;
         var _loc32_:uint = 0;
         var _loc33_:RoleplayEntitiesFrame = null;
         var _loc34_:HouseWrapper = null;
         var _loc35_:Rectangle = null;
         var _loc36_:InteractiveElementMouseOutMessage = null;
         var _loc37_:ShowMonstersInfoAction = null;
         var _loc38_:MouseUpMessage = null;
         var _loc39_:ShortcutsFrame = null;
         var _loc40_:CellClickMessage = null;
         var _loc41_:AdjacentMapClickMessage = null;
         var _loc42_:IEntity = null;
         var _loc43_:TiphonSprite = null;
         var _loc44_:TiphonSprite = null;
         var _loc45_:* = false;
         var _loc46_:DisplayObject = null;
         var _loc47_:Rectangle = null;
         var _loc48_:Rectangle2 = null;
         var _loc49_:FightTeam = null;
         var _loc50_:AllianceInformations = null;
         var _loc51_:* = 0;
         var _loc52_:GameRolePlayTaxCollectorInformations = null;
         var _loc53_:GuildInformations = null;
         var _loc54_:GuildWrapper = null;
         var _loc55_:AllianceWrapper = null;
         var _loc56_:GameRolePlayNpcInformations = null;
         var _loc57_:Npc = null;
         var _loc58_:AllianceFrame = null;
         var _loc59_:uint = 0;
         var _loc60_:uint = 0;
         var _loc61_:RoleplayContextFrame = null;
         var _loc62_:GameContextActorInformations = null;
         var _loc63_:Object = null;
         var _loc64_:GameContextActorInformations = null;
         var _loc65_:uint = 0;
         var _loc66_:* = 0;
         var _loc67_:uint = 0;
         var _loc68_:GameFightJoinRequestMessage = null;
         var _loc69_:IEntity = null;
         var _loc70_:* = 0;
         var _loc71_:FightTeam = null;
         var _loc72_:FightTeamMemberInformations = null;
         var _loc73_:GuildWrapper = null;
         var _loc74_:IEntity = null;
         var _loc75_:Array = null;
         var _loc76_:* = 0;
         var _loc77_:MapPoint = null;
         var _loc78_:MapPoint = null;
         var _loc79_:Object = null;
         var _loc80_:String = null;
         var _loc81_:String = null;
         var _loc82_:Skill = null;
         var _loc83_:* = false;
         var _loc84_:InteractiveElementWithAgeBonus = null;
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
                  _loc40_ = param1 as CellClickMessage;
                  (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentEmoticon = 0;
                  this.roleplayMovementFrame.resetNextMoveMapChange();
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc40_.cellId));
               }
               return true;
            case param1 is AdjacentMapClickMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(this.cellClickEnabled)
               {
                  _loc41_ = param1 as AdjacentMapClickMessage;
                  _loc42_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!_loc42_)
                  {
                     _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                     return false;
                  }
                  this.roleplayMovementFrame.setNextMoveMapChange(_loc41_.adjacentMapId);
                  if(!_loc42_.position.equals(MapPoint.fromCellId(_loc41_.cellId)))
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(_loc41_.cellId));
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
               _loc5_ = new LinkedCursorData();
               switch(_loc2_.direction)
               {
                  case DirectionsEnum.LEFT:
                     _loc5_.sprite = this._mouseLeft;
                     _loc5_.lockX = true;
                     _loc5_.sprite.x = _loc2_.zone.x + _loc2_.zone.width / 2;
                     _loc5_.offset = new Point(0,0);
                     _loc5_.lockY = true;
                     _loc5_.sprite.y = _loc4_.y + AtouinConstants.CELL_HEIGHT / 2;
                     break;
                  case DirectionsEnum.UP:
                     _loc5_.sprite = this._mouseTop;
                     _loc5_.lockY = true;
                     _loc5_.sprite.y = _loc2_.zone.y + _loc2_.zone.height / 2;
                     _loc5_.offset = new Point(0,0);
                     _loc5_.lockX = true;
                     _loc5_.sprite.x = _loc4_.x + AtouinConstants.CELL_WIDTH / 2;
                     break;
                  case DirectionsEnum.DOWN:
                     _loc5_.sprite = this._mouseBottom;
                     _loc5_.lockY = true;
                     _loc5_.sprite.y = _loc2_.zone.getBounds(_loc2_.zone).top;
                     _loc5_.offset = new Point(0,0);
                     _loc5_.lockX = true;
                     _loc5_.sprite.x = _loc4_.x + AtouinConstants.CELL_WIDTH / 2;
                     break;
                  case DirectionsEnum.RIGHT:
                     _loc5_.sprite = this._mouseRight;
                     _loc5_.lockX = true;
                     _loc5_.sprite.x = _loc2_.zone.getBounds(_loc2_.zone).left + _loc2_.zone.width / 2;
                     _loc5_.offset = new Point(0,0);
                     _loc5_.lockY = true;
                     _loc5_.sprite.y = _loc4_.y + AtouinConstants.CELL_HEIGHT / 2;
                     break;
               }
               LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor",_loc5_);
               return true;
            case param1 is EntityMouseOverMessage:
               _loc6_ = param1 as EntityMouseOverMessage;
               this._mouseOverEntityId = _loc6_.entity.id;
               _loc7_ = "entity_" + _loc6_.entity.id;
               this.displayCursor(NO_CURSOR);
               _loc8_ = _loc6_.entity as IInteractive;
               _loc9_ = _loc8_ as AnimatedCharacter;
               if(_loc9_)
               {
                  _loc9_ = _loc9_.getRootEntity();
                  _loc9_.highLightCharacterAndFollower(true);
                  _loc8_ = _loc9_;
                  if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER && _loc9_.getDirection() == DirectionsEnum.DOWN)
                  {
                     _loc9_.visibleAura = true;
                  }
               }
               _loc10_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc8_.id) as GameRolePlayActorInformations;
               if(_loc8_ is TiphonSprite)
               {
                  _loc43_ = _loc8_ as TiphonSprite;
                  _loc44_ = (_loc8_ as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                  _loc45_ = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame)) && (RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode);
                  if((_loc44_) && !_loc45_)
                  {
                     _loc43_ = _loc44_;
                  }
                  _loc46_ = _loc43_.getSlot("Tete");
                  if(_loc46_)
                  {
                     _loc47_ = _loc46_.getBounds(StageShareManager.stage);
                     _loc48_ = new Rectangle2(_loc47_.x,_loc47_.y,_loc47_.width,_loc47_.height);
                     _loc11_ = _loc48_;
                  }
               }
               if(!_loc11_ || _loc11_.width == 0 && _loc11_.height == 0)
               {
                  _loc11_ = (_loc8_ as IDisplayable).absoluteBounds;
               }
               _loc12_ = null;
               _loc14_ = 0;
               if(this.roleplayContextFrame.entitiesFrame.isFight(_loc8_.id))
               {
                  if(this.allowOnlyCharacterInteraction)
                  {
                     return false;
                  }
                  _loc49_ = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc8_.id);
                  _loc10_ = new RoleplayTeamFightersTooltipInformation(_loc49_);
                  _loc12_ = "roleplayFight";
                  this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                  if((_loc49_.hasOptions()) || (_loc49_.hasGroupMember()))
                  {
                     _loc14_ = 35;
                  }
               }
               else
               {
                  switch(true)
                  {
                     case _loc10_ is GameRolePlayCharacterInformations:
                        if(_loc10_.contextualId == PlayedCharacterManager.getInstance().id)
                        {
                           _loc51_ = 0;
                        }
                        else
                        {
                           _loc59_ = _loc10_.alignmentInfos.characterPower - _loc10_.contextualId;
                           _loc60_ = PlayedCharacterManager.getInstance().infos.level;
                           _loc51_ = PlayedCharacterManager.getInstance().levelDiff(_loc59_);
                        }
                        _loc10_ = new CharacterTooltipInformation(_loc10_ as GameRolePlayCharacterInformations,_loc51_);
                        _loc13_ = "CharacterCache";
                        break;
                     case _loc10_ is GameRolePlayMutantInformations:
                        if((_loc10_ as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                        {
                           _loc10_ = new CharacterTooltipInformation(_loc10_,0);
                        }
                        else
                        {
                           _loc10_ = new MutantTooltipInformation(_loc10_ as GameRolePlayMutantInformations);
                        }
                        break;
                     case _loc10_ is GameRolePlayTaxCollectorInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        _loc52_ = _loc10_ as GameRolePlayTaxCollectorInformations;
                        _loc53_ = _loc52_.identification.guildIdentity;
                        _loc50_ = _loc52_.identification is TaxCollectorStaticExtendedInformations?(_loc52_.identification as TaxCollectorStaticExtendedInformations).allianceIdentity:null;
                        _loc54_ = GuildWrapper.create(_loc53_.guildId,_loc53_.guildName,_loc53_.guildEmblem,0,true);
                        _loc55_ = _loc50_?AllianceWrapper.create(_loc50_.allianceId,_loc50_.allianceTag,_loc50_.allianceName,_loc50_.allianceEmblem):null;
                        _loc10_ = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((_loc10_ as GameRolePlayTaxCollectorInformations).identification.lastNameId).name,TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc10_ as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname,_loc54_,_loc55_,(_loc10_ as GameRolePlayTaxCollectorInformations).taxCollectorAttack);
                        break;
                     case _loc10_ is GameRolePlayNpcInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        _loc56_ = _loc10_ as GameRolePlayNpcInformations;
                        _loc57_ = Npc.getNpcById(_loc56_.npcId);
                        _loc10_ = new TextTooltipInfo(_loc57_.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","green",0);
                        _loc10_.bgCornerRadius = 10;
                        _loc13_ = "NPCCacheName";
                        if(_loc57_.actions.length == 0)
                        {
                           break;
                        }
                        this.displayCursor(NPC_CURSOR);
                        break;
                     case _loc10_ is GameRolePlayGroupMonsterInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                        if(Kernel.getWorker().contains(MonstersInfoFrame))
                        {
                           _loc7_ = "MonstersInfo_" + _loc10_.contextualId;
                           _loc13_ = (Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame).getCacheName(_loc10_.contextualId);
                        }
                        else
                        {
                           _loc13_ = "GroupMonsterCache";
                        }
                        break;
                     case _loc10_ is GameRolePlayPrismInformations:
                        _loc58_ = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
                        _loc10_ = new PrismTooltipInformation(_loc58_.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance);
                        break;
                  }
               }
               if(!_loc10_)
               {
                  _log.warn("Rolling over a unknown entity (" + _loc6_.entity.id + ").");
                  return false;
               }
               if(this.roleplayContextFrame.entitiesFrame.hasIcon(_loc8_.id))
               {
                  _loc14_ = 45;
               }
               if((_loc9_) && (!_loc9_.rawAnimation) && !this._entityTooltipData[_loc9_])
               {
                  this._entityTooltipData[_loc9_] = 
                     {
                        "data":_loc10_,
                        "name":_loc7_,
                        "tooltipMaker":_loc12_,
                        "tooltipOffset":_loc14_,
                        "cacheName":_loc13_
                     };
                  _loc9_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
               }
               else
               {
                  TooltipManager.show(_loc10_,_loc11_,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,_loc7_,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,_loc14_,true,_loc12_,null,null,_loc13_,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
               }
               return true;
            case param1 is MouseRightClickMessage:
               _loc15_ = param1 as MouseRightClickMessage;
               _loc16_ = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               _loc17_ = _loc15_.target as IInteractive;
               if(_loc17_)
               {
                  _loc61_ = this.roleplayContextFrame;
                  if(!(_loc17_ as AnimatedCharacter) || (_loc17_ as AnimatedCharacter).followed == null)
                  {
                     _loc62_ = _loc61_.entitiesFrame.getEntityInfos(_loc17_.id);
                  }
                  else
                  {
                     _loc62_ = _loc61_.entitiesFrame.getEntityInfos((_loc17_ as AnimatedCharacter).followed.id);
                  }
                  if(_loc62_ is GameRolePlayNamedActorInformations)
                  {
                     if(!(_loc17_ is AnimatedCharacter))
                     {
                        _log.error("L\'entity " + _loc17_.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                        return true;
                     }
                     _loc17_ = (_loc17_ as AnimatedCharacter).getRootEntity();
                     _loc64_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc17_.id);
                     _loc63_ = MenusFactory.create(_loc64_,"multiplayer",[_loc17_]);
                     if(_loc63_)
                     {
                        _loc16_.createContextMenu(_loc63_);
                     }
                     return true;
                  }
                  if(_loc62_ is GameRolePlayGroupMonsterInformations)
                  {
                     _loc63_ = MenusFactory.create(_loc62_,"monsterGroup",[_loc17_]);
                     if(_loc63_)
                     {
                        _loc16_.createContextMenu(_loc63_);
                     }
                     return true;
                  }
               }
               return false;
            case param1 is EntityMouseOutMessage:
               _loc18_ = param1 as EntityMouseOutMessage;
               this._mouseOverEntityId = 0;
               this.displayCursor(NO_CURSOR);
               TooltipManager.hide("entity_" + _loc18_.entity.id);
               _loc9_ = _loc18_.entity as AnimatedCharacter;
               if(_loc9_)
               {
                  _loc9_ = _loc9_.getRootEntity();
                  _loc9_.highLightCharacterAndFollower(false);
                  if(!Kernel.getWorker().getFrame(MonstersInfoFrame))
                  {
                     TooltipManager.hide("MonstersInfo_" + _loc9_.id);
                  }
               }
               if(OptionManager.getOptionManager("tiphon").auraMode == OptionEnum.AURA_ON_ROLLOVER)
               {
                  _loc9_.visibleAura = false;
               }
               return true;
            case param1 is EntityClickMessage:
               _loc19_ = param1 as EntityClickMessage;
               _loc20_ = _loc19_.entity as IInteractive;
               if(_loc20_ is AnimatedCharacter)
               {
                  _loc20_ = (_loc20_ as AnimatedCharacter).getRootEntity();
               }
               _loc21_ = this.roleplayContextFrame.entitiesFrame.getEntityInfos(_loc20_.id);
               _loc22_ = RoleplayManager.getInstance().displayContextualMenu(_loc21_,_loc20_);
               if(this.roleplayContextFrame.entitiesFrame.isFight(_loc20_.id))
               {
                  _loc65_ = this.roleplayContextFrame.entitiesFrame.getFightId(_loc20_.id);
                  _loc66_ = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(_loc20_.id);
                  _loc67_ = this.roleplayContextFrame.entitiesFrame.getFightTeamType(_loc20_.id);
                  if(_loc67_ == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                  {
                     _loc71_ = this.roleplayContextFrame.entitiesFrame.getFightTeam(_loc20_.id) as FightTeam;
                     for each (_loc72_ in _loc71_.teamInfos.teamMembers)
                     {
                        if(_loc72_ is FightTeamMemberTaxCollectorInformations)
                        {
                           _loc70_ = (_loc72_ as FightTeamMemberTaxCollectorInformations).guildId;
                        }
                     }
                     _loc73_ = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                     if((_loc73_) && _loc70_ == _loc73_.guildId)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,1,2);
                        Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                        return true;
                     }
                  }
                  _loc68_ = new GameFightJoinRequestMessage();
                  _loc68_.initGameFightJoinRequestMessage(_loc66_,_loc65_);
                  _loc69_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if((_loc69_ as IMovable).isMoving)
                  {
                     this.roleplayMovementFrame.setFollowingMessage(_loc68_);
                     (_loc69_ as IMovable).stop();
                  }
                  else
                  {
                     ConnectionsHandler.getConnection().send(_loc68_);
                  }
               }
               else
               {
                  if(!(_loc20_.id == PlayedCharacterManager.getInstance().id) && !_loc22_)
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMoveTo(_loc20_.position);
                  }
               }
               return true;
            case param1 is InteractiveElementActivationMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               _loc23_ = param1 as InteractiveElementActivationMessage;
               _loc24_ = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if(!((_loc24_) && (_loc24_.usingInteractive)))
               {
                  _loc74_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!DataMapProvider.getInstance().farmCell(_loc74_.position.x,_loc74_.position.y) && _loc23_.interactiveElement.elementTypeId == 120)
                  {
                     _loc76_ = 0;
                     while(_loc76_ < 8)
                     {
                        _loc78_ = _loc23_.position.getNearestCellInDirection(_loc76_);
                        if((_loc78_) && (DataMapProvider.getInstance().farmCell(_loc78_.x,_loc78_.y)))
                        {
                           if(!_loc75_)
                           {
                              _loc75_ = [];
                           }
                           _loc75_.push(_loc78_.cellId);
                        }
                        _loc76_++;
                     }
                  }
                  _loc77_ = _loc23_.position.getNearestFreeCellInDirection(_loc23_.position.advancedOrientationTo(_loc74_.position),DataMapProvider.getInstance(),true,true,_loc75_);
                  if(!_loc77_)
                  {
                     _loc77_ = _loc23_.position;
                  }
                  this.roleplayMovementFrame.setFollowingInteraction(
                     {
                        "ie":_loc23_.interactiveElement,
                        "skillInstanceId":_loc23_.skillInstanceId
                     });
                  this.roleplayMovementFrame.askMoveTo(_loc77_);
               }
               return true;
            case param1 is InteractiveElementMouseOverMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               _loc25_ = param1 as InteractiveElementMouseOverMessage;
               _loc29_ = _loc25_.interactiveElement;
               for each (_loc30_ in _loc29_.enabledSkills)
               {
                  if(_loc30_.skillId == 175)
                  {
                     _loc26_ = this.roleplayContextFrame.currentPaddock;
                     break;
                  }
               }
               _loc31_ = Interactive.getInteractiveById(_loc29_.elementTypeId);
               _loc32_ = _loc25_.interactiveElement.elementId;
               _loc33_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               _loc34_ = _loc33_.housesInformations[_loc32_];
               _loc35_ = _loc25_.sprite.getRect(StageShareManager.stage);
               if(_loc34_)
               {
                  _loc26_ = _loc34_;
               }
               else
               {
                  if(_loc26_ == null && (_loc31_))
                  {
                     _loc79_ = new Object();
                     _loc79_.interactive = _loc31_.name;
                     _loc80_ = "";
                     for each (_loc30_ in _loc29_.enabledSkills)
                     {
                        _loc80_ = _loc80_ + (Skill.getSkillById(_loc30_.skillId).name + "\n");
                     }
                     _loc79_.enabledSkills = _loc80_;
                     _loc81_ = "";
                     for each (_loc30_ in _loc29_.disabledSkills)
                     {
                        _loc81_ = _loc81_ + (Skill.getSkillById(_loc30_.skillId).name + "\n");
                     }
                     _loc79_.disabledSkills = _loc81_;
                     _loc79_.isCollectable = _loc31_.actionId == COLLECTABLE_INTERACTIVE_ACTION_ID;
                     if(_loc79_.isCollectable)
                     {
                        _loc83_ = true;
                        _loc84_ = _loc29_ as InteractiveElementWithAgeBonus;
                        if(_loc29_.enabledSkills.length > 0)
                        {
                           _loc82_ = Skill.getSkillById(_loc29_.enabledSkills[0].skillId);
                           if(_loc82_.parentJobId == 1)
                           {
                              _loc83_ = false;
                           }
                        }
                        else
                        {
                           if(!_loc84_)
                           {
                              _loc83_ = false;
                           }
                        }
                        if(_loc83_)
                        {
                           _loc79_.collectSkill = _loc82_;
                           _loc79_.ageBonus = _loc84_?_loc84_.ageBonus:0;
                        }
                     }
                     _loc26_ = _loc79_;
                     _loc27_ = "interactiveElement";
                     _loc28_ = "InteractiveElementCache";
                  }
               }
               if(_loc26_)
               {
                  TooltipManager.show(_loc26_,new Rectangle(_loc35_.right,int(_loc35_.y + _loc35_.height - AtouinConstants.CELL_HEIGHT),0,0),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TooltipManager.TOOLTIP_STANDAR_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOP,0,true,_loc27_,null,null,_loc28_);
               }
               return true;
            case param1 is InteractiveElementMouseOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               _loc36_ = param1 as InteractiveElementMouseOutMessage;
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
               break;
            case param1 is ShowMonstersInfoAction:
               _loc37_ = param1 as ShowMonstersInfoAction;
               _monstersInfoFrame.triggeredByShortcut = _loc37_.fromShortcut;
               if(Kernel.getWorker().contains(MonstersInfoFrame))
               {
                  Kernel.getWorker().removeFrame(_monstersInfoFrame);
               }
               else
               {
                  if((AirScanner.hasAir()) && (StageShareManager.stage.nativeWindow.active) && !(!_monstersInfoFrame.triggeredByShortcut && !this._mouseDown))
                  {
                     Kernel.getWorker().addFrame(_monstersInfoFrame);
                  }
               }
               return true;
            case param1 is MouseDownMessage:
               this._mouseDown = true;
               break;
            case param1 is MouseUpMessage:
               this._mouseDown = false;
               _loc38_ = param1 as MouseUpMessage;
               _loc39_ = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(_loc39_.heldShortcuts.indexOf("showMonstersInfo") == -1 && (Kernel.getWorker().contains(MonstersInfoFrame)))
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
      
      private function onEntityAnimRendered(param1:TiphonEvent) : void {
         var _loc2_:AnimatedCharacter = param1.currentTarget as AnimatedCharacter;
         _loc2_.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
         var _loc3_:Object = this._entityTooltipData[_loc2_];
         TooltipManager.show(_loc3_.data,_loc2_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,_loc3_.name,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,_loc3_.tooltipOffset,true,_loc3_.tooltipMaker,null,null,_loc3_.cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
         delete this._entityTooltipData[[_loc2_]];
      }
      
      private function displayCursor(param1:int, param2:Boolean=true) : void {
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
      
      private function onWisperMessage(param1:String) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus,param1);
      }
      
      private function onMerchantPlayerBuyClick(param1:int, param2:uint) : void {
         var _loc3_:ExchangeOnHumanVendorRequestMessage = new ExchangeOnHumanVendorRequestMessage();
         _loc3_.initExchangeOnHumanVendorRequestMessage(param1,param2);
         ConnectionsHandler.getConnection().send(_loc3_);
      }
      
      private function onInviteMenuClicked(param1:String) : void {
         var _loc2_:PartyInvitationRequestMessage = new PartyInvitationRequestMessage();
         _loc2_.initPartyInvitationRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function onMerchantHouseKickOff(param1:uint) : void {
         var _loc2_:HouseKickIndoorMerchantRequestMessage = new HouseKickIndoorMerchantRequestMessage();
         _loc2_.initHouseKickIndoorMerchantRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      private function onWindowDeactivate(param1:Event) : void {
         if(Kernel.getWorker().contains(MonstersInfoFrame))
         {
            Kernel.getWorker().removeFrame(_monstersInfoFrame);
         }
      }
   }
}
