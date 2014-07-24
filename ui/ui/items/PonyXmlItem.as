package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import d2api.TimeApi;
   import d2api.UtilApi;
   import d2data.TaxCollectorWrapper;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.Label;
   import d2components.Grid;
   import d2actions.*;
   import d2hooks.*;
   import flash.geom.ColorTransform;
   import d2data.SocialEntityInFightWrapper;
   import d2enums.TaxCollectorStateEnum;
   import flash.utils.getTimer;
   import d2enums.SelectMethodEnum;
   import utils.JoinFightUtil;
   
   public class PonyXmlItem extends Object
   {
      
      public function PonyXmlItem() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      public var timeApi:TimeApi;
      
      public var utilApi:UtilApi;
      
      private var _grid:Object;
      
      private var _data:TaxCollectorWrapper;
      
      private var _clockStart:uint;
      
      private var _clockEnd:uint;
      
      private var _clockDuration:uint;
      
      private var _previousState:uint = 0;
      
      private var _fighting:Boolean = false;
      
      private var _attackList:String = "";
      
      private var _defenseList:String = "";
      
      private var _infos:String = "";
      
      private var _timeProgressBar_y:uint;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_mine:GraphicContainer;
      
      public var tx_fightState:Texture;
      
      public var tx_timeProgressBar:Texture;
      
      public var tx_attackTeam:Texture;
      
      public var tx_defenseTeam:Texture;
      
      public var lbl_ponyName:Label;
      
      public var lbl_ponyLoc:Label;
      
      public var lbl_ponyPodsXp:Label;
      
      public var gd_attackTeam:Grid;
      
      public var gd_defenseTeam:Grid;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this.mainCtr.mouseEnabled = true;
         this.sysApi.addHook(GuildFightEnnemiesListUpdate,this.onGuildFightEnnemiesListUpdate);
         this.sysApi.addHook(GuildFightAlliesListUpdate,this.onGuildFightAlliesListUpdate);
         this.sysApi.addHook(TaxCollectorUpdate,this.onTaxCollectorUpdate);
         this.gd_attackTeam.mouseEnabled = true;
         this.uiApi.addComponentHook(this.gd_defenseTeam,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_defenseTeam,"onSelectEmptyItem");
         this.uiApi.addComponentHook(this.gd_defenseTeam,"onItemRollOver");
         this.uiApi.addComponentHook(this.gd_defenseTeam,"onItemRollOut");
         this.uiApi.addComponentHook(this.gd_attackTeam,"onItemRollOver");
         this.uiApi.addComponentHook(this.gd_attackTeam,"onItemRollOut");
         this.uiApi.addComponentHook(this.tx_attackTeam,"onRollOver");
         this.uiApi.addComponentHook(this.tx_attackTeam,"onRollOut");
         this.uiApi.addComponentHook(this.tx_defenseTeam,"onRollOver");
         this.uiApi.addComponentHook(this.tx_defenseTeam,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_ponyPodsXp,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_ponyPodsXp,"onRollOut");
         this.uiApi.addComponentHook(this.ctr_mine,"onRollOver");
         this.uiApi.addComponentHook(this.ctr_mine,"onRollOut");
         this.tx_timeProgressBar.transform.colorTransform = new ColorTransform(1,1,1,1,44,-78,-174,0);
         this.tx_timeProgressBar.scaleY = 0;
         this.update(oParam.data,false);
      }
      
      public function unload() : void {
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function get data() : TaxCollectorWrapper {
         return this._data;
      }
      
      public function update(newData:TaxCollectorWrapper, selected:Boolean, force:Boolean = false) : void {
         var fightTCData:SocialEntityInFightWrapper = null;
         var e2:* = undefined;
         var a2:* = undefined;
         if(newData)
         {
            this._data = newData;
            this._previousState = this._data.state;
            this.lbl_ponyName.text = this._data.firstName + " " + this._data.lastName;
            this.lbl_ponyLoc.text = this.dataApi.getSubArea(this._data.subareaId).name + " (" + this._data.mapWorldX + "," + this._data.mapWorldY + ")";
            if(this.sysApi.getCurrentServer().gameTypeId == 1)
            {
               if(this._data.pods == 0)
               {
                  this.lbl_ponyPodsXp.text = "";
               }
               else
               {
                  this.lbl_ponyPodsXp.text = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._data.pods),"m",this._data.pods <= 1);
               }
            }
            else
            {
               this.lbl_ponyPodsXp.text = this.uiApi.getText("ui.social.thingsTaxCollectorGet",this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._data.pods),"m",this._data.pods <= 1),this.utilApi.kamasToString(this._data.experience,""));
            }
            if(this._data.additionalInformation.collectorCallerName != this.playerApi.getPlayedCharacterInfo().name)
            {
               this.ctr_mine.bgAlpha = 0;
            }
            else
            {
               this.ctr_mine.bgAlpha = 0.5;
            }
            if(this._data.state == TaxCollectorStateEnum.STATE_COLLECTING)
            {
               this._fighting = false;
               this.tx_attackTeam.visible = false;
               this.tx_defenseTeam.visible = false;
               this.tx_timeProgressBar.scaleY = 0;
               this.tx_timeProgressBar.visible = false;
               this._attackList = "";
               this._defenseList = "";
               this.gd_attackTeam.dataProvider = new Array();
               this.gd_attackTeam.visible = true;
               this.gd_defenseTeam.dataProvider = new Array();
               this.gd_defenseTeam.visible = true;
               this._infos = this.uiApi.getText("ui.social.guild.taxInCollect") + "\n";
            }
            else
            {
               this.tx_attackTeam.visible = true;
               this.tx_defenseTeam.visible = true;
               this._attackList = this.uiApi.getText("ui.common.attackers") + " : \n";
               this._defenseList = this.uiApi.getText("ui.common.defenders") + " : \n";
               fightTCData = this.socialApi.getGuildFightingTaxCollector(this._data.uniqueId);
               if((fightTCData) && (fightTCData.enemyCharactersInformations) && (fightTCData.enemyCharactersInformations.length > 0))
               {
                  this.gd_attackTeam.dataProvider = fightTCData.enemyCharactersInformations;
                  for each(e2 in fightTCData.enemyCharactersInformations)
                  {
                     this._attackList = this._attackList + (e2.playerCharactersInformations.name + " (" + e2.playerCharactersInformations.level + ")\n");
                  }
               }
               if((fightTCData) && (fightTCData.allyCharactersInformations) && (fightTCData.allyCharactersInformations.length > 0))
               {
                  this.gd_defenseTeam.dataProvider = fightTCData.allyCharactersInformations;
                  for each(a2 in fightTCData.allyCharactersInformations)
                  {
                     this._defenseList = this._defenseList + (a2.playerCharactersInformations.name + " (" + a2.playerCharactersInformations.level + ")\n");
                  }
               }
               this.gd_attackTeam.visible = true;
               this.gd_defenseTeam.visible = true;
               if((this._data.state == TaxCollectorStateEnum.STATE_FIGHTING) || (this._fighting))
               {
                  this.tx_timeProgressBar.scaleY = 0;
                  this.tx_timeProgressBar.visible = false;
                  this._infos = this.uiApi.getText("ui.social.guild.taxInFight") + "\n";
               }
               else if(this._data.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
               {
                  if((!this.tx_timeProgressBar.visible) || (this.tx_timeProgressBar.scaleY == 0) || (!(this._clockEnd == this._data.fightTime)))
                  {
                     this.tx_timeProgressBar.visible = true;
                     this._clockEnd = this._data.fightTime;
                     this._clockDuration = this._data.waitTimeForPlacement;
                     this._clockStart = getTimer();
                     this.sysApi.addEventListener(this.onEnterFrame,"time");
                  }
                  this._infos = this.uiApi.getText("ui.social.guild.taxInEnterFight") + "\n";
               }
               
            }
            if(this._fighting)
            {
               this.tx_fightState.uri = this.uiApi.createUri(this.uiApi.me().getConstant("state_uri") + "2");
            }
            else
            {
               this.tx_fightState.uri = this.uiApi.createUri(this.uiApi.me().getConstant("state_uri") + this._data.state);
            }
            this._infos = this._infos + (this.uiApi.getText("ui.common.ownerWord") + this.uiApi.getText("ui.common.colon") + this._data.additionalInformation.collectorCallerName + "\n");
            this._infos = this._infos + (this.uiApi.getText("ui.social.guild.taxStartDate") + this.uiApi.getText("ui.common.colon") + this.timeApi.getDofusDate(this._data.additionalInformation.date * 1000) + " " + this.timeApi.getClock(this._data.additionalInformation.date * 1000));
         }
         else
         {
            this.tx_fightState.uri = null;
            this.tx_timeProgressBar.visible = false;
            this.tx_attackTeam.visible = false;
            this.tx_defenseTeam.visible = false;
            this.lbl_ponyName.text = "";
            this.lbl_ponyLoc.text = "";
            this.lbl_ponyPodsXp.text = "";
            this.ctr_mine.bgAlpha = 0;
            this.gd_attackTeam.dataProvider = new Array();
            this.gd_attackTeam.visible = false;
            this.gd_defenseTeam.dataProvider = new Array();
            this.gd_defenseTeam.visible = false;
         }
         this.uiApi.me().render();
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         switch(target)
         {
            case this.tx_attackTeam:
               if(this._attackList != "")
               {
                  text = this._attackList;
               }
               break;
            case this.tx_defenseTeam:
               if(this._defenseList != "")
               {
                  text = this._defenseList;
               }
               break;
            case this.ctr_mine:
               if(this._infos != "")
               {
                  text = this._infos;
               }
               break;
            case this.lbl_ponyPodsXp:
               if(this._data)
               {
                  if(this._data.itemsValue)
                  {
                     text = this.uiApi.getText("ui.social.taxCollector.itemsValue",this.utilApi.kamasToString(this._data.itemsValue));
                     if(this._data.kamas)
                     {
                        text = text + "\n";
                     }
                  }
                  if(this._data.kamas)
                  {
                     text = text + this.uiApi.getText("ui.social.taxCollector.kamasCollected",this.utilApi.kamasToString(this._data.kamas,""));
                  }
               }
               break;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         switch(target)
         {
            case this.tx_attackTeam:
            case this.tx_defenseTeam:
            case this.lbl_ponyPodsXp:
            case this.ctr_mine:
               this.uiApi.hideTooltip();
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if((target == this.gd_defenseTeam) && (selectMethod == SelectMethodEnum.CLICK))
         {
            if(target.selectedItem.hasOwnProperty("playerCharactersInformations"))
            {
               if(target.selectedItem.playerCharactersInformations.id != this.playerApi.id())
               {
                  JoinFightUtil.swapPlaces(0,this._data.uniqueId,target.selectedItem.playerCharactersInformations);
               }
               else
               {
                  JoinFightUtil.leave(0,this._data.uniqueId);
               }
            }
         }
      }
      
      public function onSelectEmptyItem(target:Object, selectMethod:uint) : void {
         if((target == this.gd_defenseTeam) && (selectMethod == SelectMethodEnum.CLICK))
         {
            JoinFightUtil.join(0,this._data.uniqueId);
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         if((item) && (item.data))
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(item.data.playerCharactersInformations.name + ", " + item.data.playerCharactersInformations.level),item.container,false,"standard",this.sysApi.getEnum("com.ankamagames.berilia.types.LocationEnum").POINT_BOTTOMRIGHT,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onEnterFrame() : void {
         var clock:uint = getTimer();
         var percentTime:Number = (this._clockDuration - (this._clockEnd - clock)) / this._clockDuration;
         if(clock >= this._clockEnd)
         {
            this.sysApi.removeEventListener(this.onEnterFrame);
            this._fighting = true;
            this.update(this._data,false,true);
         }
         this.tx_timeProgressBar.scaleY = -percentTime;
      }
      
      private function onGuildFightEnnemiesListUpdate(type:int, fightId:uint) : void {
         var enemies:Object = null;
         var e2:* = undefined;
         if((this._data) && (type == 0) && (fightId == this._data.uniqueId))
         {
            enemies = this.socialApi.getGuildFightingTaxCollector(fightId).enemyCharactersInformations;
            this.gd_attackTeam.dataProvider = enemies;
            this._attackList = this.uiApi.getText("ui.common.attackers") + " : \n";
            if((enemies) && (enemies.length > 0))
            {
               for each(e2 in enemies)
               {
                  this._attackList = this._attackList + (e2.playerCharactersInformations.name + " (" + e2.playerCharactersInformations.level + ")\n");
               }
            }
         }
      }
      
      private function onGuildFightAlliesListUpdate(type:int, fightId:uint) : void {
         var allies:Object = null;
         var a2:* = undefined;
         if((this._data) && (type == 0) && (fightId == this._data.uniqueId))
         {
            allies = this.socialApi.getGuildFightingTaxCollector(fightId).allyCharactersInformations;
            this.gd_defenseTeam.dataProvider = allies;
            this._defenseList = this.uiApi.getText("ui.common.defenders") + " : \n";
            if((allies) && (allies.length > 0))
            {
               for each(a2 in allies)
               {
                  this._defenseList = this._defenseList + (a2.playerCharactersInformations.name + " (" + a2.playerCharactersInformations.level + ")\n");
               }
            }
         }
      }
      
      private function onTaxCollectorUpdate(id:int) : void {
         if((this._data) && (id == this._data.uniqueId))
         {
            this.update(this.socialApi.getTaxCollectors()[id],false);
         }
      }
   }
}
