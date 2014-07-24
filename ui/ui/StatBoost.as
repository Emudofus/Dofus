package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.RoleplayApi;
   import d2components.Label;
   import d2components.Input;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2enums.ComponentHookList;
   import d2actions.*;
   import d2hooks.*;
   import d2components.GraphicContainer;
   
   public class StatBoost extends Object
   {
      
      public function StatBoost() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var rpApi:RoleplayApi;
      
      public var modCommon:Object;
      
      private var _characterCharacteristics;
      
      private var _statId:uint;
      
      private var _stat:String;
      
      private var _statName:String;
      
      private var _statPointsAdded:uint = 0;
      
      private var _pointsUsed:uint = 0;
      
      private var _capital:uint;
      
      private var _base:uint;
      
      private var _baseFloor:uint;
      
      private var _currentFloor:uint;
      
      private var _rest:uint;
      
      private var _statFloorValueAndCostInBoostForOneStatPoint:Array;
      
      private var _aFloors:Array;
      
      private var _aCosts:Array;
      
      public var lbl_title:Label;
      
      public var lbl_capital:Label;
      
      public var lbl_statAdd:Label;
      
      public var lbl_statTotal:Label;
      
      public var lbl_floor1:Label;
      
      public var lbl_floor2:Label;
      
      public var lbl_floor3:Label;
      
      public var lbl_floor4:Label;
      
      public var lbl_floor5:Label;
      
      public var lbl_cost1:Label;
      
      public var lbl_cost2:Label;
      
      public var lbl_cost3:Label;
      
      public var lbl_cost4:Label;
      
      public var lbl_cost5:Label;
      
      public var inp_pointsValue:Input;
      
      public var tx_statPicto:Texture;
      
      public var tx_gridColor:Texture;
      
      public var btn_close:ButtonContainer;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_less:ButtonContainer;
      
      public var btn_more:ButtonContainer;
      
      public function main(stat:Array) : void {
         this.uiApi.addComponentHook(this.inp_pointsValue,ComponentHookList.ON_CHANGE);
         this.tx_gridColor.y = 206;
         this._stat = stat[0];
         this._statId = stat[1];
         this._statName = this.uiApi.getText("ui.stats." + this._stat);
         this._characterCharacteristics = this.playerApi.characteristics();
         this._capital = this._characterCharacteristics.statsPoints;
         this._base = this._characterCharacteristics[this._stat].base;
         this.lbl_title.text = this.uiApi.getText("ui.charaSheet.evolution",this._statName);
         this.inp_pointsValue.restrictChars = "0-9";
         this.inp_pointsValue.text = "0";
         this.tx_statPicto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "tx_" + this._stat);
         this._statFloorValueAndCostInBoostForOneStatPoint = new Array();
         this._aCosts = new Array(this.lbl_cost1,this.lbl_cost2,this.lbl_cost3,this.lbl_cost4,this.lbl_cost5);
         this._aFloors = new Array(this.lbl_floor1,this.lbl_floor2,this.lbl_floor3,this.lbl_floor4,this.lbl_floor5);
         this.displayFloors();
         this.displayPoints();
         this.inp_pointsValue.focus();
         this.inp_pointsValue.setSelection(0,8388607);
      }
      
      public function unload() : void {
      }
      
      private function validatePointsChoice() : void {
         var text:String = null;
         if(this._pointsUsed > 0)
         {
            if(this._rest != 0)
            {
               text = this.uiApi.getText("ui.charaSheet.evolutionWarn",this._pointsUsed,this._pointsUsed - this._rest,this._rest);
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupSendBoost,this.onPopupClose],this.onPopupSendBoost,this.onPopupClose);
            }
            else
            {
               this.sysApi.sendAction(new StatsUpgradeRequest(this._statId,this._pointsUsed));
               this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
      }
      
      private function addStatPoint(point:int) : void {
         var currentFloorModif:int = 0;
         var boostPoints:uint = 0;
         if(point > 0)
         {
            boostPoints = this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + currentFloorModif][1] - this._rest;
            if(this._capital >= this._pointsUsed + boostPoints)
            {
               this._pointsUsed = this._pointsUsed + boostPoints;
            }
            else
            {
               return;
            }
         }
         else
         {
            boostPoints = this._rest;
            if((this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor - 1]) && (this._statPointsAdded + this._base - 1 < this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][0]))
            {
               currentFloorModif = -1;
            }
            if(boostPoints == 0)
            {
               boostPoints = this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + currentFloorModif][1];
            }
            if(this._pointsUsed >= boostPoints)
            {
               this._pointsUsed = this._pointsUsed - boostPoints;
            }
            else
            {
               return;
            }
         }
         this.inp_pointsValue.text = this._pointsUsed.toString();
         this.displayPoints();
      }
      
      private function displayPoints() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function displayFloors() : void {
         var floor:* = undefined;
         var cost:* = undefined;
         var statpoints:* = undefined;
         var nbBoostForOneCaracPointAndFloor:* = undefined;
         var orangeSet:* = false;
         var i:* = 0;
         for each(floor in this._aFloors)
         {
            floor.text = "-";
         }
         for each(cost in this._aCosts)
         {
            cost.text = "-";
         }
         switch(this._stat)
         {
            case "vitality":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForVitality;
               break;
            case "wisdom":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForWisdom;
               break;
            case "strength":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForStrength;
               break;
            case "intelligence":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForIntelligence;
               break;
            case "chance":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForChance;
               break;
            case "agility":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForAgility;
               break;
         }
         for each(nbBoostForOneCaracPointAndFloor in statpoints)
         {
            this._statFloorValueAndCostInBoostForOneStatPoint.push(nbBoostForOneCaracPointAndFloor);
         }
         orangeSet = false;
         i = 0;
         while(i < this._statFloorValueAndCostInBoostForOneStatPoint.length)
         {
            this._aFloors[i].text = "> " + this._statFloorValueAndCostInBoostForOneStatPoint[i][0];
            this._aCosts[i].text = this._statFloorValueAndCostInBoostForOneStatPoint[i][1];
            if((this._statFloorValueAndCostInBoostForOneStatPoint[i + 1] && this._statFloorValueAndCostInBoostForOneStatPoint[i + 1][0] > this._base) && (this._statFloorValueAndCostInBoostForOneStatPoint[i][0] <= this._base) || (!this._statFloorValueAndCostInBoostForOneStatPoint[i + 1]) && (!orangeSet))
            {
               orangeSet = true;
               this._baseFloor = i;
               this.tx_gridColor.x = this._aFloors[i].x;
            }
            i++;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_valid:
               this.validatePointsChoice();
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_less:
               this.addStatPoint(-1);
               break;
            case this.btn_more:
               this.addStatPoint(1);
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               this.validatePointsChoice();
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onChange(target:GraphicContainer) : void {
         var input:String = null;
         if(target == this.inp_pointsValue)
         {
            input = this.inp_pointsValue.text;
            if(input)
            {
               this._pointsUsed = int(input);
            }
            else
            {
               this._pointsUsed = 0;
            }
            if(this._pointsUsed > this._capital)
            {
               this._pointsUsed = this._capital;
               this.inp_pointsValue.text = this._pointsUsed.toString();
            }
            this.displayPoints();
         }
      }
      
      public function onPopupClose() : void {
      }
      
      public function onPopupSendBoost() : void {
         this.sysApi.sendAction(new StatsUpgradeRequest(this._statId,this._pointsUsed - this._rest));
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
