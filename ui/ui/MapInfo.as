package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.FightApi;
   import d2api.UtilApi;
   import d2api.SocialApi;
   import d2api.MapApi;
   import d2api.PlayedCharacterApi;
   import d2api.ChatApi;
   import d2data.WorldPointWrapper;
   import d2data.PrismSubAreaWrapper;
   import d2network.ActorExtendedAlignmentInformations;
   import d2data.AllianceWrapper;
   import d2components.Label;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2data.MapPosition;
   import d2data.SubArea;
   import d2enums.AggressableStatusEnum;
   import d2data.EmblemSymbol;
   import d2enums.LocationEnum;
   
   public class MapInfo extends Object
   {
      
      public function MapInfo() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var fightApi:FightApi;
      
      public var utilApi:UtilApi;
      
      public var socialApi:SocialApi;
      
      public var mapApi:MapApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var chatApi:ChatApi;
      
      private var _isAchievementRewardsVisible:Boolean;
      
      private var _isHardcoreServer:Boolean;
      
      private var _currentSubAreaId:int;
      
      private var _currentMap:WorldPointWrapper;
      
      private var _allianceEmblemBgShape:uint;
      
      private var _allianceEmblemBgColor:uint;
      
      private var _allianceEmblemIconShape:uint;
      
      private var _allianceEmblemIconColor:uint;
      
      private var _showAlliance:Boolean;
      
      private var _allowAggression:Boolean;
      
      private var _currentAllianceId:int;
      
      private var _currentPrism:PrismSubAreaWrapper;
      
      private var _currentPlayerAlignment:ActorExtendedAlignmentInformations;
      
      private var _myVeryOwnAlliance:AllianceWrapper;
      
      private var _inFight:Boolean;
      
      public var skip:Boolean = false;
      
      public var lbl_info:Label;
      
      public var lbl_coordAndLevel:Label;
      
      public var tx_warning:Texture;
      
      public var infoContainer:GraphicContainer;
      
      public var tx_allianceEmblemBack:Texture;
      
      public var tx_allianceEmblemUp:Texture;
      
      public var lbl_alliance:Label;
      
      public var btn_achievementRewards:ButtonContainer;
      
      public function main(... args) : void {
         this.tx_allianceEmblemBack.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_allianceEmblemBack,"onTextureReady");
         this.tx_allianceEmblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_allianceEmblemUp,"onTextureReady");
         this.sysApi.addHook(MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         this.sysApi.addHook(AllianceUpdateInformations,this.onAllianceUpdateInformations);
         this.sysApi.addHook(PrismsList,this.onPrismsList);
         this.sysApi.addHook(PrismsListUpdate,this.onPrismsListUpdate);
         this.sysApi.addHook(HouseEntered,this.houseEntered);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(GameFightLeave,this.onGameFightLeave);
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(RewardableAchievementsVisible,this.onRewardableAchievementsVisible);
         this.sysApi.addHook(PvpAvaStateChange,this.onPvpAvaStateChange);
         this.uiApi.addComponentHook(this.btn_achievementRewards,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_achievementRewards,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OUT);
         this._isAchievementRewardsVisible = GameUiCore.getInstance().isAchievementRewardsVisible;
         this.btn_achievementRewards.visible = this._isAchievementRewardsVisible;
         this._isHardcoreServer = !(this.sysApi.getPlayerManager().serverGameType == 0);
         this._myVeryOwnAlliance = this.socialApi.getAlliance();
      }
      
      public function set visible(visible:Boolean) : void {
         this.infoContainer.visible = visible;
      }
      
      public function onPrismsList(pPrismsInfo:Object) : void {
         var prismSubAreaInformation:PrismSubAreaWrapper = null;
         if(!this._showAlliance)
         {
            prismSubAreaInformation = this.socialApi.getPrismSubAreaById(this._currentSubAreaId);
            if((prismSubAreaInformation) && (!(prismSubAreaInformation.mapId == -1)))
            {
               this.showAllianceInfo(!prismSubAreaInformation.alliance?this._myVeryOwnAlliance:prismSubAreaInformation.alliance);
               this._showAlliance = true;
            }
         }
      }
      
      public function onPrismsListUpdate(pPrismSubAreas:Object) : void {
         var subAreaId:* = 0;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         for each(subAreaId in pPrismSubAreas)
         {
            if(this._currentSubAreaId == subAreaId)
            {
               prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
               if(prismSubAreaInfo.mapId != -1)
               {
                  if(this._currentAllianceId == prismSubAreaInfo.alliance.allianceId)
                  {
                     this._currentAllianceId = -1;
                  }
                  this.showAllianceInfo(!prismSubAreaInfo.alliance?this._myVeryOwnAlliance:prismSubAreaInfo.alliance);
                  this._showAlliance = true;
               }
               else
               {
                  this._currentAllianceId = -1;
                  this._showAlliance = false;
                  this.lbl_alliance.visible = false;
                  this.tx_allianceEmblemBack.visible = false;
                  this.tx_allianceEmblemUp.visible = false;
               }
            }
         }
      }
      
      public function onAllianceUpdateInformations() : void {
         this._myVeryOwnAlliance = this.socialApi.getAlliance();
         if(this._currentAllianceId == this._myVeryOwnAlliance.allianceId)
         {
            this._currentAllianceId = -1;
            this.showAllianceInfo(this._myVeryOwnAlliance);
         }
      }
      
      private function showAllianceInfo(pAllianceInfo:AllianceWrapper) : void {
         var linkColor:String = null;
         var hoverColor:String = null;
         if((!this._inFight) && (!(this._currentAllianceId == pAllianceInfo.allianceId)))
         {
            linkColor = "#ffd376";
            hoverColor = "#fb6e0d";
            this.lbl_alliance.text = this.chatApi.getAllianceLink(pAllianceInfo,"[" + pAllianceInfo.allianceTag + "]",linkColor,hoverColor);
            this.lbl_alliance.fullWidth();
            this.lbl_alliance.visible = true;
            this.tx_allianceEmblemBack.x = this.lbl_alliance.width + 8;
            this.tx_allianceEmblemUp.x = this.tx_allianceEmblemBack.x + 8;
            this.tx_allianceEmblemUp.y = this.tx_allianceEmblemBack.y + 8;
            if((!(this._allianceEmblemBgShape == pAllianceInfo.backEmblem.idEmblem)) || (!(this._allianceEmblemBgColor == pAllianceInfo.backEmblem.color)) || (!this._showAlliance))
            {
               this._allianceEmblemBgShape = pAllianceInfo.backEmblem.idEmblem;
               this._allianceEmblemBgColor = pAllianceInfo.backEmblem.color;
               this.tx_allianceEmblemBack.visible = false;
               this.tx_allianceEmblemBack.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "backalliance/" + pAllianceInfo.backEmblem.idEmblem + ".swf");
            }
            if((!(this._allianceEmblemIconShape == pAllianceInfo.upEmblem.idEmblem)) || (!(this._allianceEmblemIconColor == pAllianceInfo.upEmblem.color)) || (!this._showAlliance))
            {
               this._allianceEmblemIconShape = pAllianceInfo.upEmblem.idEmblem;
               this._allianceEmblemIconColor = pAllianceInfo.upEmblem.color;
               this.tx_allianceEmblemUp.visible = false;
               this.tx_allianceEmblemUp.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "up/" + this._allianceEmblemIconShape + ".swf");
            }
            this._currentAllianceId = pAllianceInfo.allianceId;
         }
      }
      
      private function updateAttackWarning() : void {
         if(this._inFight)
         {
            return;
         }
         this._allowAggression = this.tx_warning.visible = false;
         var mapPos:MapPosition = this.mapApi.getMapPositionById(this._currentMap.mapId);
         if((mapPos) && (!mapPos.allowAggression))
         {
            return;
         }
         var subarea:SubArea = this.dataApi.getSubArea(this._currentSubAreaId);
         if((subarea) && (subarea.basicAccountAllowed))
         {
            return;
         }
         if((!this._isHardcoreServer) && ((!this._currentPlayerAlignment) || (!this._myVeryOwnAlliance) || (this._currentPlayerAlignment.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED) || (this._currentPlayerAlignment.aggressable == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE) || (this._currentPlayerAlignment.aggressable == AggressableStatusEnum.NON_AGGRESSABLE) || (this._currentPlayerAlignment.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)))
         {
            return;
         }
         this._allowAggression = this.tx_warning.visible = true;
      }
      
      public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean) : void {
         var mapInfo:Object = null;
         var areaName:String = null;
         var subArea:Object = null;
         var subAreaName:String = null;
         var mapName:String = null;
         var prevMap:WorldPointWrapper = this._currentMap;
         this._currentSubAreaId = subAreaId;
         this._currentMap = map as WorldPointWrapper;
         if(this.skip)
         {
            this.skip = false;
         }
         else if(show)
         {
            this.infoContainer.visible = true;
            mapInfo = this.dataApi.getMapInfo(this._currentMap.mapId);
            this.lbl_coordAndLevel.text = this._currentMap.outdoorX + "," + this._currentMap.outdoorY;
            if((!mapInfo) || (!mapInfo.name))
            {
               try
               {
                  areaName = this.dataApi.getArea(this.dataApi.getSubArea(subAreaId).areaId).name;
                  subArea = this.dataApi.getSubArea(subAreaId);
                  subAreaName = subArea.name;
               }
               catch(e:Error)
               {
               }
               if(!subAreaName)
               {
                  subAreaName = "???????";
               }
               if(!areaName)
               {
                  areaName = "???????";
               }
               mapName = "";
               if((areaName.length > 1) && (!(areaName.substr(0,2) == "//")))
               {
                  mapName = mapName + areaName;
               }
               if((subAreaName.length > 1) && (!(subAreaName == areaName)) && (!(subAreaName.substr(0,2) == "//")))
               {
                  mapName = mapName + (" (" + subAreaName + ")");
               }
               this.lbl_info.text = mapName;
               this.lbl_coordAndLevel.text = this.lbl_coordAndLevel.text + (", " + this.uiApi.getText("ui.common.averageLevel") + " " + subArea.level);
            }
            else
            {
               this.lbl_info.text = mapInfo.name;
            }
            this.lbl_info.fullWidth();
            this.lbl_coordAndLevel.fullWidth();
            this.tx_warning.x = this.lbl_coordAndLevel.width + 10;
            this._currentPrism = this.socialApi.getPrismSubAreaById(this._currentSubAreaId);
            if((this._currentPrism) && (!(this._currentPrism.mapId == -1)))
            {
               this.showAllianceInfo(!this._currentPrism.alliance?this._myVeryOwnAlliance:this._currentPrism.alliance);
               this._showAlliance = true;
            }
            else
            {
               this._currentAllianceId = -1;
               this._showAlliance = false;
               this.lbl_alliance.visible = false;
               this.tx_allianceEmblemBack.visible = false;
               this.tx_allianceEmblemUp.visible = false;
            }
         }
         else
         {
            this.infoContainer.visible = false;
         }
         
         this.updateAttackWarning();
      }
      
      public function onTextureReady(pTexture:Texture) : void {
         var icon:EmblemSymbol = null;
         if(!this._showAlliance)
         {
            return;
         }
         if(pTexture == this.tx_allianceEmblemBack)
         {
            this.utilApi.changeColor(this.tx_allianceEmblemBack.getChildByName("back"),this._allianceEmblemBgColor,1);
            this.tx_allianceEmblemBack.mouseEnabled = this.tx_allianceEmblemBack.mouseChildren = false;
            this.tx_allianceEmblemBack.visible = true;
         }
         else if(pTexture == this.tx_allianceEmblemUp)
         {
            icon = this.dataApi.getEmblemSymbol(this._allianceEmblemIconShape);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(this.tx_allianceEmblemUp.getChildByName("up"),this._allianceEmblemIconColor,0);
            }
            else
            {
               this.utilApi.changeColor(this.tx_allianceEmblemUp.getChildByName("up"),this._allianceEmblemIconColor,0,true);
            }
            this.tx_allianceEmblemUp.mouseEnabled = this.tx_allianceEmblemUp.mouseChildren = false;
            this.tx_allianceEmblemUp.visible = true;
         }
         
      }
      
      public function onGameFightJoin(... rest) : void {
         this._inFight = true;
         this.btn_achievementRewards.visible = false;
         this.lbl_alliance.visible = false;
         this.tx_allianceEmblemBack.visible = false;
         this.tx_allianceEmblemUp.visible = false;
         this.tx_warning.visible = false;
      }
      
      public function onGameFightEnd(... rest) : void {
         this._inFight = false;
         this.btn_achievementRewards.visible = this._isAchievementRewardsVisible;
         this.lbl_alliance.visible = this.tx_allianceEmblemBack.visible = this.tx_allianceEmblemUp.visible = this._showAlliance;
         this.tx_warning.visible = this._allowAggression;
      }
      
      public function onGameFightLeave(charId:int) : void {
         this._inFight = false;
         this.btn_achievementRewards.visible = this._isAchievementRewardsVisible;
         this.lbl_alliance.visible = this.tx_allianceEmblemBack.visible = this.tx_allianceEmblemUp.visible = this._showAlliance;
         this.tx_warning.visible = this._allowAggression;
      }
      
      private function onPvpAvaStateChange(status:uint, probationTime:uint) : void {
         if(this._currentMap)
         {
            this._currentPlayerAlignment = this.playerApi.characteristics().alignmentInfos;
            this.updateAttackWarning();
         }
      }
      
      private function onRewardableAchievementsVisible(b:Boolean) : void {
         this._isAchievementRewardsVisible = b;
         if(!this.sysApi.isFightContext())
         {
            this.btn_achievementRewards.visible = this._isAchievementRewardsVisible;
         }
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_achievementRewards)
         {
            if(this.uiApi.getUi("achievementRewardUi"))
            {
               this.uiApi.unloadUi("achievementRewardUi");
            }
            else
            {
               this.uiApi.loadUi("achievementRewardUi","achievementRewardUi");
            }
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         if(target == this.btn_achievementRewards)
         {
            text = this.uiApi.getText("ui.achievement.rewardsWaiting");
         }
         else if(target == this.tx_warning)
         {
            text = this.uiApi.getText("ui.map.warningAttack");
         }
         
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function houseEntered(playerHouse:Boolean, ownerId:int, ownerName:String, price:uint, isLocked:Boolean, worldX:int, worldY:int, houseWrapper:Object) : void {
         this.lbl_coordAndLevel.text = worldX + "," + worldY;
      }
   }
}
