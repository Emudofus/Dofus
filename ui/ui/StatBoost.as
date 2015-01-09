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
    import d2components.GraphicContainer;
    import d2enums.ComponentHookList;
    import d2enums.ProtocolConstantsEnum;
    import d2actions.StatsUpgradeRequest;
    import d2actions.*;
    import d2hooks.*;

    public class StatBoost 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var rpApi:RoleplayApi;
        [Module(name="Ankama_Common")]
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
        private var _additionnalFloor:uint;
        private var _currentFloor:uint;
        private var _rest:uint;
        private var _maxScrollPointsBeforeLimit:uint;
        private var _statFloorValueAndCostInBoostForOneStatPoint:Array;
        private var _aFloors:Array;
        private var _aCosts:Array;
        public var lbl_title:Label;
        public var lbl_pointsTypeTitle:Label;
        public var lbl_capital:Label;
        public var lbl_capitalStat:Label;
        public var lbl_capitalScroll:Label;
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
        public var btn_radioStat:ButtonContainer;
        public var btn_radioScroll:ButtonContainer;
        public var ctr_radioStat:GraphicContainer;
        public var ctr_radioScroll:GraphicContainer;
        public var ctr_capitalChoice:GraphicContainer;
        public var ctr_capitalNoScroll:GraphicContainer;


        public function main(stat:Array):void
        {
            var statAdditionnalPoints:int;
            var statPoints:uint;
            var pointsUsed:uint;
            var currentFloor:int;
            var i:int;
            this.uiApi.addComponentHook(this.inp_pointsValue, ComponentHookList.ON_CHANGE);
            this.uiApi.addComponentHook(this.ctr_radioStat, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_radioScroll, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_radioScroll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_radioScroll, ComponentHookList.ON_ROLL_OUT);
            this.tx_gridColor.y = 38;
            this._stat = stat[0];
            this._statId = stat[1];
            this._statName = this.uiApi.getText(("ui.stats." + this._stat));
            this._characterCharacteristics = this.playerApi.characteristics();
            this._base = this._characterCharacteristics[this._stat].base;
            this.lbl_title.text = this.uiApi.getText("ui.charaSheet.evolution", this._statName);
            this.inp_pointsValue.restrictChars = "0-9";
            this.inp_pointsValue.text = "0";
            this.tx_statPicto.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("picto_uri") + "tx_") + this._stat));
            this._statFloorValueAndCostInBoostForOneStatPoint = new Array();
            this._aCosts = new Array(this.lbl_cost1, this.lbl_cost2, this.lbl_cost3, this.lbl_cost4, this.lbl_cost5);
            this._aFloors = new Array(this.lbl_floor1, this.lbl_floor2, this.lbl_floor3, this.lbl_floor4, this.lbl_floor5);
            this.displayFloors();
            if ((((this._characterCharacteristics.additionnalPoints == 0)) || (!(stat[2]))))
            {
                this.ctr_capitalChoice.visible = false;
                this._capital = this._characterCharacteristics.statsPoints;
                this.lbl_pointsTypeTitle.text = this.uiApi.getText("ui.charaSheet.boostWithStatPoints");
                this.displayPoints();
                this.inp_pointsValue.focus();
                this.inp_pointsValue.setSelection(0, 8388607);
            }
            else
            {
                statAdditionnalPoints = this._characterCharacteristics[this._stat].additionnal;
                if ((((CharacterSheet.getInstance().statPointsBoostType == 0)) || ((statAdditionnalPoints >= ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC))))
                {
                    this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup", this.btn_radioStat, this.uiApi.me());
                }
                else
                {
                    this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup", this.btn_radioScroll, this.uiApi.me());
                };
                this.ctr_capitalNoScroll.visible = false;
                statPoints = 0;
                pointsUsed = 0;
                i = 0;
                while (i < this._statFloorValueAndCostInBoostForOneStatPoint.length)
                {
                    if (((((((this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)]) && ((this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)][0] > statAdditionnalPoints)))) && ((this._statFloorValueAndCostInBoostForOneStatPoint[i][0] <= statAdditionnalPoints)))) || (!(this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)]))))
                    {
                        currentFloor = i;
                        break;
                    };
                    i++;
                };
                while ((statPoints + statAdditionnalPoints) < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
                {
                    pointsUsed = (pointsUsed + this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor][1]);
                    if (this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor].length > 2)
                    {
                        statPoints = (statPoints + int(this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor][2]));
                    }
                    else
                    {
                        statPoints++;
                    };
                    if (((this._statFloorValueAndCostInBoostForOneStatPoint[(currentFloor + 1)]) && (((statPoints + statAdditionnalPoints) >= this._statFloorValueAndCostInBoostForOneStatPoint[(currentFloor + 1)][0]))))
                    {
                        currentFloor++;
                    };
                };
                this._maxScrollPointsBeforeLimit = pointsUsed;
                this.updatePointsType();
                if (statAdditionnalPoints >= ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
                {
                    this.btn_radioScroll.disabled = true;
                    this.ctr_radioScroll.softDisabled = true;
                    this.lbl_capitalScroll.cssClass = "boldrightp4";
                };
            };
        }

        public function unload():void
        {
        }

        private function updatePointsType():void
        {
            var maxPoints:int;
            if (this.btn_radioStat.selected)
            {
                CharacterSheet.getInstance().statPointsBoostType = 0;
                this._capital = this._characterCharacteristics.statsPoints;
                this.lbl_pointsTypeTitle.text = this.uiApi.getText("ui.charaSheet.boostWithStatPoints");
                this.ctr_radioScroll.bgAlpha = 0;
                this.ctr_radioStat.bgAlpha = 1;
                this.lbl_capitalScroll.text = this._characterCharacteristics.additionnalPoints.toString();
                this._base = this._characterCharacteristics[this._stat].base;
                this.updateBaseFloor();
                if (this._pointsUsed > this._capital)
                {
                    this.inp_pointsValue.text = this._capital.toString();
                };
            }
            else
            {
                CharacterSheet.getInstance().statPointsBoostType = 1;
                this._capital = this._characterCharacteristics.additionnalPoints;
                this.lbl_pointsTypeTitle.text = this.uiApi.getText("ui.charaSheet.boostWithAdditionnalPoints");
                this.ctr_radioScroll.bgAlpha = 1;
                this.ctr_radioStat.bgAlpha = 0;
                this.lbl_capitalStat.text = this._characterCharacteristics.statsPoints.toString();
                this._base = this._characterCharacteristics[this._stat].additionnal;
                this.updateBaseFloor();
                maxPoints = this._capital;
                if (((((this.ctr_capitalChoice.visible) && (this.btn_radioScroll.selected))) && ((maxPoints > this._maxScrollPointsBeforeLimit))))
                {
                    maxPoints = this._maxScrollPointsBeforeLimit;
                };
                if (this._pointsUsed > maxPoints)
                {
                    this.inp_pointsValue.text = maxPoints.toString();
                };
            };
            this.displayPoints();
            this.inp_pointsValue.focus();
            this.inp_pointsValue.setSelection(0, 8388607);
        }

        private function validatePointsChoice():void
        {
            var text:String;
            if (this._pointsUsed > 0)
            {
                if (this._rest != 0)
                {
                    text = this.uiApi.getText("ui.charaSheet.evolutionWarn", this._pointsUsed, (this._pointsUsed - this._rest), this._rest);
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupSendBoost, this.onPopupClose], this.onPopupSendBoost, this.onPopupClose);
                }
                else
                {
                    this.sysApi.sendAction(new StatsUpgradeRequest(((this.ctr_capitalChoice.visible) && (!(this.btn_radioStat.selected))), this._statId, this._pointsUsed));
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        private function addStatPoint(point:int):void
        {
            var maxPoints:int;
            var currentFloorModif:int;
            var boostPoints:uint;
            if (point > 0)
            {
                boostPoints = (this._statFloorValueAndCostInBoostForOneStatPoint[(this._currentFloor + currentFloorModif)][1] - this._rest);
                maxPoints = this._capital;
                if (((((this.ctr_capitalChoice.visible) && (this.btn_radioScroll.selected))) && ((maxPoints > this._maxScrollPointsBeforeLimit))))
                {
                    maxPoints = this._maxScrollPointsBeforeLimit;
                };
                if (maxPoints >= (this._pointsUsed + boostPoints))
                {
                    this._pointsUsed = (this._pointsUsed + boostPoints);
                }
                else
                {
                    return;
                };
            }
            else
            {
                boostPoints = this._rest;
                if (this._pointsUsed == 0)
                {
                    maxPoints = this._capital;
                    if (((((this.ctr_capitalChoice.visible) && (this.btn_radioScroll.selected))) && ((maxPoints > this._maxScrollPointsBeforeLimit))))
                    {
                        maxPoints = this._maxScrollPointsBeforeLimit;
                    };
                    this._pointsUsed = maxPoints;
                    this.inp_pointsValue.text = this._pointsUsed.toString();
                }
                else
                {
                    if (((this._statFloorValueAndCostInBoostForOneStatPoint[(this._currentFloor - 1)]) && ((((this._statPointsAdded + this._base) - 1) < this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][0]))))
                    {
                        currentFloorModif = -1;
                    };
                    if (boostPoints == 0)
                    {
                        boostPoints = this._statFloorValueAndCostInBoostForOneStatPoint[(this._currentFloor + currentFloorModif)][1];
                    };
                    if (this._pointsUsed >= boostPoints)
                    {
                        this._pointsUsed = (this._pointsUsed - boostPoints);
                    }
                    else
                    {
                        return;
                    };
                };
            };
            this.inp_pointsValue.text = this._pointsUsed.toString();
            this.displayPoints();
        }

        private function displayPoints():void
        {
            var statPoints:uint;
            var pointsUsed:uint = this._pointsUsed;
            this._currentFloor = this._baseFloor;
            while (pointsUsed >= this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1])
            {
                pointsUsed = (pointsUsed - this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1]);
                if (this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor].length > 2)
                {
                    statPoints = (statPoints + int(this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][2]));
                }
                else
                {
                    statPoints++;
                };
                if (((this._statFloorValueAndCostInBoostForOneStatPoint[(this._currentFloor + 1)]) && (((statPoints + this._base) >= this._statFloorValueAndCostInBoostForOneStatPoint[(this._currentFloor + 1)][0]))))
                {
                    this._currentFloor++;
                };
            };
            this._rest = pointsUsed;
            if (this.ctr_capitalChoice.visible)
            {
                if (this.btn_radioStat.selected)
                {
                    this.lbl_capitalStat.text = String((this._characterCharacteristics.statsPoints - this._pointsUsed));
                }
                else
                {
                    this.lbl_capitalScroll.text = String((this._characterCharacteristics.additionnalPoints - this._pointsUsed));
                };
            }
            else
            {
                this.lbl_capital.text = String((this._characterCharacteristics.statsPoints - this._pointsUsed));
            };
            this.tx_gridColor.x = this._aFloors[this._currentFloor].x;
            this._statPointsAdded = statPoints;
            this.lbl_statAdd.text = ((("+" + this._statPointsAdded) + " ") + this._statName);
            this.lbl_statTotal.text = (((this._statPointsAdded + this._base) + " ") + this._statName);
        }

        private function displayFloors():void
        {
            var floor:*;
            var cost:*;
            var statpoints:*;
            var nbBoostForOneCaracPointAndFloor:*;
            var i:int;
            for each (floor in this._aFloors)
            {
                floor.text = "-";
            };
            for each (cost in this._aCosts)
            {
                cost.text = "-";
            };
            switch (this._stat)
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
            };
            for each (nbBoostForOneCaracPointAndFloor in statpoints)
            {
                this._statFloorValueAndCostInBoostForOneStatPoint.push(nbBoostForOneCaracPointAndFloor);
            };
            i = 0;
            while (i < this._statFloorValueAndCostInBoostForOneStatPoint.length)
            {
                this._aFloors[i].text = ("> " + this._statFloorValueAndCostInBoostForOneStatPoint[i][0]);
                this._aCosts[i].text = this._statFloorValueAndCostInBoostForOneStatPoint[i][1];
                i++;
            };
            this.updateBaseFloor();
        }

        private function updateBaseFloor():void
        {
            var orangeSet:Boolean;
            var i:int;
            while (i < this._statFloorValueAndCostInBoostForOneStatPoint.length)
            {
                if (((((((this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)]) && ((this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)][0] > this._base)))) && ((this._statFloorValueAndCostInBoostForOneStatPoint[i][0] <= this._base)))) || (((!(this._statFloorValueAndCostInBoostForOneStatPoint[(i + 1)])) && (!(orangeSet))))))
                {
                    orangeSet = true;
                    this._baseFloor = i;
                    this.tx_gridColor.x = this._aFloors[i].x;
                };
                i++;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
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
                case this.btn_radioStat:
                    this.updatePointsType();
                    break;
                case this.ctr_radioStat:
                    this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup", this.btn_radioStat, this.uiApi.me());
                    this.updatePointsType();
                    break;
                case this.btn_radioScroll:
                    this.updatePointsType();
                    break;
                case this.ctr_radioScroll:
                    this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup", this.btn_radioScroll, this.uiApi.me());
                    this.updatePointsType();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if ((((target == this.ctr_radioScroll)) && (this.ctr_radioScroll.softDisabled)))
            {
                text = this.uiApi.getText("ui.charaSheet.noBoostIfMaxReached", ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC);
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    this.validatePointsChoice();
                    return (true);
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onChange(target:GraphicContainer):void
        {
            var input:String;
            var maxPoints:int;
            if (target == this.inp_pointsValue)
            {
                input = this.inp_pointsValue.text;
                if (input)
                {
                    this._pointsUsed = int(input);
                }
                else
                {
                    this._pointsUsed = 0;
                };
                maxPoints = this._capital;
                if (((((this.ctr_capitalChoice.visible) && (this.btn_radioScroll.selected))) && ((maxPoints > this._maxScrollPointsBeforeLimit))))
                {
                    maxPoints = this._maxScrollPointsBeforeLimit;
                };
                if (this._pointsUsed > maxPoints)
                {
                    this.inp_pointsValue.text = maxPoints.toString();
                }
                else
                {
                    this.displayPoints();
                };
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupSendBoost():void
        {
            this.sysApi.sendAction(new StatsUpgradeRequest(((this.ctr_capitalChoice.visible) && (!(this.btn_radioStat.selected))), this._statId, (this._pointsUsed - this._rest)));
            this.uiApi.unloadUi(this.uiApi.me().name);
        }


    }
}//package ui

