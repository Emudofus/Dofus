package ui
{
    import flash.utils.Timer;
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.ChatApi;
    import d2api.DataApi;
    import __AS3__.vec.Vector;
    import d2components.Texture;
    import d2components.Label;
    import flash.events.TimerEvent;
    import d2enums.TeamEnum;
    import d2hooks.*;
    import __AS3__.vec.*;

    public class WorldCompanionFighterTooltipUi 
    {

        private var _timerHide:Timer;
        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var chatApi:ChatApi;
        public var dataApi:DataApi;
        private var _inPrefight:Boolean;
        private var _showName:Boolean;
        private var _icons:Vector.<Texture>;
        public var lbl_text:Object;
        public var lbl_title:Object;
        public var lbl_damage:Label;
        public var lbl_fightStatus:Label;
        public var backgroundCtr:Object;
        public var mainCtr:Object;

        public function WorldCompanionFighterTooltipUi()
        {
            this._icons = new Vector.<Texture>(0);
            super();
        }

        public function main(oParam:Object=null):void
        {
            this._showName = ((((oParam.makerParam) && (oParam.makerParam.hasOwnProperty("showName")))) ? oParam.makerParam.showName : true);
            this.updateContent(oParam);
            var cellId:uint = ((((oParam.makerParam) && (oParam.makerParam.cellId))) ? oParam.makerParam.cellId : oParam.data.disposition.cellId);
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset, true, cellId);
            if (oParam.autoHide)
            {
                this._timerHide = new Timer(2500);
                this._timerHide.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.start();
            };
        }

        public function updateContent(oParam:Object):void
        {
            var tx:Texture;
            var chatColors:Object;
            var telefragState:String;
            var telefragStr:String;
            var effectIcons:Array;
            var line:String;
            var i:int;
            var tx_icon:Texture;
            var txIconHeight:Number;
            var txIconWidth:Number;
            var centerX:Number;
            var lineSize:Object;
            this._inPrefight = Api.fight.preFightIsActive();
            if (this._inPrefight)
            {
                this.lbl_text.text = Api.fight.getFighterName(oParam.data.contextualId);
                this.lbl_title.text = ((Api.ui.getText("ui.common.level") + " ") + Api.fight.getFighterLevel(oParam.data.contextualId));
            }
            else
            {
                this.lbl_title.text = "";
                if (oParam.data.stats.shieldPoints > 0)
                {
                    this.lbl_text.text = ((((this._showName) ? (Api.fight.getFighterName(oParam.data.contextualId) + " ") : "") + "(") + oParam.data.stats.lifePoints);
                    this.lbl_text.appendText(("+" + oParam.data.stats.shieldPoints), "shield");
                    this.lbl_text.appendText(")", "p");
                }
                else
                {
                    this.lbl_text.text = (((((this._showName) ? (Api.fight.getFighterName(oParam.data.contextualId) + " ") : "") + "(") + oParam.data.stats.lifePoints) + ")");
                };
            };
            this.lbl_text.fullWidth();
            this.lbl_title.fullWidth();
            this.lbl_title.y = 20;
            var posX:int = ((this.lbl_title.width - this.lbl_text.width) / 2);
            if (posX < 0)
            {
                posX = (posX * -1);
                this.lbl_title.x = posX;
                this.lbl_text.x = 0;
            }
            else
            {
                this.lbl_title.x = 0;
                this.lbl_text.x = posX;
            };
            this.backgroundCtr.height = 35;
            if (this.lbl_title.text != "")
            {
                this.backgroundCtr.height = (this.backgroundCtr.height + 20);
            };
            this.lbl_damage.text = "";
            this.lbl_fightStatus.text = "";
            var maxWidth:Number = this.getMaxLabelWidth();
            var offsetIcon:Number = 0;
            for each (tx in this._icons)
            {
                tx.remove();
                this._icons.splice(this._icons.indexOf(tx), 1);
            };
            this.lbl_fightStatus.width = 1;
            this.lbl_fightStatus.removeFromParent();
            if (((oParam.makerParam) && (oParam.makerParam.telefrag)))
            {
                this.mainCtr.addContent(this.lbl_fightStatus);
                this.lbl_fightStatus.y = (this.lbl_text.y + 20);
                chatColors = this.chatApi.getChatColors();
                telefragState = this.dataApi.getSpellState((((oParam.data.teamId == TeamEnum.TEAM_DEFENDER)) ? 244 : 251)).name;
                telefragStr = (((('<font color="#' + chatColors[10].toString(16)) + '">') + telefragState) + "</font>");
                this.lbl_fightStatus.appendText(telefragStr);
                this.lbl_fightStatus.fullWidth();
                maxWidth = this.getMaxLabelWidth();
                this.lbl_text.x = ((maxWidth / 2) - (this.lbl_text.width / 2));
                this.lbl_fightStatus.x = ((maxWidth / 2) - (this.lbl_fightStatus.width / 2));
                this.backgroundCtr.height = (this.backgroundCtr.height + this.lbl_fightStatus.height);
            };
            this.lbl_damage.width = 1;
            this.lbl_damage.removeFromParent();
            if (((oParam.makerParam) && (oParam.makerParam.spellDamage)))
            {
                this.mainCtr.addContent(this.lbl_damage);
                this.lbl_damage.y = (this.lbl_text.y + 20);
                this.lbl_damage.appendText(oParam.makerParam.spellDamage);
                this.lbl_damage.fullWidth();
                effectIcons = oParam.makerParam.spellDamage.effectIcons;
                txIconHeight = 17;
                txIconWidth = 17;
                i = 0;
                while (i < this.lbl_damage.textfield.numLines)
                {
                    line = this.lbl_damage.textfield.getLineText(i);
                    if (effectIcons[i])
                    {
                        tx_icon = (this.uiApi.createComponent("Texture") as Texture);
                        tx_icon.uri = this.uiApi.createUri((Tooltips.STATS_ICONS_PATH + effectIcons[i]));
                        tx_icon.finalize();
                        lineSize = this.uiApi.getTextSize(line, this.lbl_damage.css, this.lbl_damage.cssClass);
                        tx_icon.y = ((this.lbl_damage.y + (lineSize.height * i)) + 8);
                        centerX = (this.getMaxLabelWidth() / 2);
                        tx_icon.x = (((centerX - (lineSize.width / 2)) - txIconWidth) - 2);
                        if (tx_icon.x < 0)
                        {
                            offsetIcon = txIconWidth;
                            tx_icon.x = (tx_icon.x + txIconWidth);
                        };
                        this.mainCtr.addContent(tx_icon);
                        this._icons.push(tx_icon);
                    };
                    i++;
                };
                maxWidth = this.getMaxLabelWidth();
                this.lbl_text.x = (((maxWidth / 2) - (this.lbl_text.width / 2)) + offsetIcon);
                this.lbl_damage.x = (((maxWidth / 2) - (this.lbl_damage.width / 2)) + offsetIcon);
                this.backgroundCtr.height = (this.backgroundCtr.height + this.lbl_damage.height);
            };
            this.backgroundCtr.width = ((maxWidth + 12) + offsetIcon);
        }

        private function getMaxLabelWidth():Number
        {
            var maxWidth:Number;
            if (this.lbl_title.text != "")
            {
                maxWidth = this.lbl_title.width;
            };
            if (((!((this.lbl_text.text == ""))) && (((isNaN(maxWidth)) || ((this.lbl_text.width > maxWidth))))))
            {
                maxWidth = this.lbl_text.width;
            };
            if (((!((this.lbl_damage.text == ""))) && (((isNaN(maxWidth)) || ((this.lbl_damage.width > maxWidth))))))
            {
                maxWidth = this.lbl_damage.width;
            };
            if (((!((this.lbl_fightStatus.text == ""))) && (((isNaN(maxWidth)) || ((this.lbl_fightStatus.width > maxWidth))))))
            {
                maxWidth = this.lbl_fightStatus.width;
            };
            return (maxWidth);
        }

        private function onTimer(e:TimerEvent):void
        {
            this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerHide)
            {
                this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.stop();
                this._timerHide = null;
            };
        }


    }
}//package ui

