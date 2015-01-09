package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.AlignmentApi;
    import d2api.PlayedCharacterApi;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import flash.geom.ColorTransform;
    import flash.utils.getTimer;
    import d2actions.PrismFightJoinLeaveRequest;
    import d2actions.PrismInfoJoinLeaveRequest;
    import d2actions.PrismFightSwapRequest;
    import d2hooks.*;
    import d2actions.*;

    public class PrismDefense 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var alignApi:AlignmentApi;
        public var playerApi:PlayedCharacterApi;
        private var _bInFighters:Boolean = false;
        private var _bJoinableFight:Boolean = false;
        private var _clockStart:uint;
        private var _clockDuration:uint;
        private var _sAttack:String;
        private var _sAttackersWord:String;
        public var prismDefenseCtr:GraphicContainer;
        public var lbl_loc:Label;
        public var lbl_nbBadGuys:Label;
        public var tx_progressBar:Texture;
        public var tx_badGuys:Texture;
        public var gd_defense:Grid;
        public var gd_reserve:Grid;
        public var btn_join:ButtonContainer;
        public var btn_littleClose:ButtonContainer;
        public var btn_prism:ButtonContainer;
        public var btn_lbl_btn_join:Label;


        public function main(param:Array):void
        {
            this.uiApi.addComponentHook(this.gd_defense, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_defense, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_defense, "onItemRollOut");
            this.uiApi.addComponentHook(this.gd_reserve, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_reserve, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_reserve, "onItemRollOut");
            this.uiApi.addComponentHook(this.tx_badGuys, "onRollOver");
            this.uiApi.addComponentHook(this.tx_badGuys, "onRollOut");
            this.gd_defense.autoSelectMode = 0;
            this.gd_reserve.autoSelectMode = 0;
            this.gd_defense.dataProvider = new Array();
            this.tx_progressBar.transform.colorTransform = new ColorTransform(1, 0.09, 0.09);
            this.tx_progressBar.scaleX = 0;
            this._sAttackersWord = this.uiApi.getText("ui.common.attackers");
            this._bJoinableFight = false;
            if (((param) && (param[0])))
            {
                if (param[0] == 1)
                {
                    this._bJoinableFight = true;
                };
            };
            this.prismDefenseCtr.visible = false;
        }

        public function unload():void
        {
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        private function updateFighters():void
        {
            if (this._bJoinableFight)
            {
                this.prismDefenseCtr.visible = true;
                this.btn_prism.disabled = false;
            }
            else
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
                this.btn_prism.disabled = true;
                this.prismDefenseCtr.visible = false;
            };
        }

        public function onPrismFightStateUpdate(state:uint):void
        {
            if (((!(this.sysApi)) || (!(this.uiApi))))
            {
                return;
            };
            switch (state)
            {
                case 1:
                    this._bJoinableFight = true;
                    break;
                case 2:
                    this._bJoinableFight = false;
                    this.updateFighters();
                    break;
            };
        }

        public function onPrismFightUpdate(fightId:int, attackersUpdated:Boolean, defendersUpdated:Boolean, reservesUpdated:Boolean):void
        {
        }

        public function onPrismInfoValid(timeLeftBeforeFight:int, waitTimeForPlacement:int, nbPositionForDefensors:uint):void
        {
            this._clockDuration = (timeLeftBeforeFight * 100);
            this._clockStart = getTimer();
            this.sysApi.addEventListener(this.onEnterFrame, "time");
        }

        public function onPrismInfoInvalid(reason:uint):void
        {
            switch (reason)
            {
                case 0:
                    this.sysApi.log(2, "    pas de raison");
                    break;
                case 1:
                    this.sysApi.log(2, "    pas de combat");
                    break;
                case 2:
                    this.sysApi.log(2, "    en combat");
                    break;
            };
        }

        public function onPrismInfoClose():void
        {
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_prism:
                case this.btn_littleClose:
                    if (this._bJoinableFight)
                    {
                        if (this.prismDefenseCtr.visible)
                        {
                            this.sysApi.removeEventListener(this.onEnterFrame);
                            if (this._bInFighters)
                            {
                                this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, false));
                            };
                            this.sysApi.sendAction(new PrismInfoJoinLeaveRequest(false));
                            this.prismDefenseCtr.visible = false;
                        }
                        else
                        {
                            this.sysApi.sendAction(new PrismInfoJoinLeaveRequest(true));
                            this.prismDefenseCtr.visible = true;
                            this.onPrismFightUpdate(1, true, true, true);
                        };
                    };
                    break;
                case this.btn_join:
                    if (this._bInFighters)
                    {
                        this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, false));
                    }
                    else
                    {
                        this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, true));
                    };
                    break;
                case this.gd_defense:
                case this.gd_reserve:
                    this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, true));
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            switch (target)
            {
                case this.gd_defense:
                    _local_4 = this.gd_defense.selectedItem;
                    if (_local_4)
                    {
                        if (_local_4.playerCharactersInformations.id == this.playerApi.id())
                        {
                            this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, false));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PrismFightSwapRequest(0, _local_4.playerCharactersInformations.id));
                        };
                    }
                    else
                    {
                        this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0, true));
                    };
                    break;
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo((((((item.data.playerCharactersInformations.name + ", ") + item.data.playerCharactersInformations.level) + " (") + item.data.playerCharactersInformations.grade) + ")")), item.container, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRollOver(target:Object):void
        {
            switch (target)
            {
                case this.tx_badGuys:
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._sAttack), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    break;
                case this.btn_prism:
                    if (!(this._bJoinableFight))
                    {
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.pvp.prismAlreadyFighting")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    };
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onEnterFrame():void
        {
            var clock:uint = getTimer();
            var percentTime:Number = ((clock - this._clockStart) / this._clockDuration);
            this.tx_progressBar.scaleX = percentTime;
            if (percentTime >= 1)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
                this._bJoinableFight = false;
                this.updateFighters();
            };
        }


    }
}//package ui

