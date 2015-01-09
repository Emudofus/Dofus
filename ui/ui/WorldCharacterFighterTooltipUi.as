package ui
{
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.UtilApi;
    import d2api.SystemApi;
    import d2api.FightApi;
    import d2api.ChatApi;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import __AS3__.vec.Vector;
    import d2enums.BreedEnum;
    import d2enums.TeamEnum;
    import __AS3__.vec.*;

    public class WorldCharacterFighterTooltipUi extends AbstractWorldCharacterTooltipUi 
    {

        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var utilApi:UtilApi;
        public var sysApi:SystemApi;
        public var fightApi:FightApi;
        public var chatApi:ChatApi;
        public var mainCtr:Object;
        public var ctr_alignment_top:GraphicContainer;
        public var ctr_alignment_bottom:GraphicContainer;
        public var tx_alignment:Texture;
        public var tx_alignmentBottom:Texture;
        public var infosCtr:GraphicContainer;
        public var lbl_playerName:Label;
        public var lbl_info:Label;
        public var lbl_damage:Label;
        public var lbl_fightStatus:Label;
        public var tx_back:GraphicContainer;
        public var tx_status:Texture;
        private var _isInPreFight:Boolean;
        private var _icons:Vector.<Texture>;

        public function WorldCharacterFighterTooltipUi()
        {
            this._icons = new Vector.<Texture>(0);
            super();
        }

        public function main(oParam:Object=null):void
        {
            var tx:Texture;
            var breedText:String;
            var chatColors:Object;
            var telefragState:String;
            var telefragStr:String;
            this._isInPreFight = this.playerApi.isInPreFight();
            for each (tx in this._icons)
            {
                tx.remove();
                this._icons.splice(this._icons.indexOf(tx), 1);
            };
            this.updatePlayerName(oParam);
            this.lbl_info.height = (this.lbl_info.width = 0);
            this.lbl_info.removeFromParent();
            if (this._isInPreFight)
            {
                this.lbl_info.useCustomFormat = true;
                breedText = "";
                if (oParam.data.breed > 0)
                {
                    breedText = Api.data.getBreed(oParam.data.breed).shortName;
                }
                else
                {
                    if (oParam.data.breed == BreedEnum.INCARNATION)
                    {
                        breedText = Api.ui.getText("ui.common.incarnation");
                    };
                };
                if (breedText != "")
                {
                    breedText = (breedText + (" " + Api.ui.getText("ui.common.short.level")));
                }
                else
                {
                    breedText = (breedText + Api.ui.getText("ui.common.level"));
                };
                this.lbl_info.text = ((breedText + " ") + oParam.data.level);
                this.lbl_info.fullWidth();
                this.infosCtr.addChild(this.lbl_info);
                this.lbl_info.y = 20;
            };
            this.lbl_fightStatus.height = (this.lbl_fightStatus.width = 0);
            this.lbl_fightStatus.removeFromParent();
            if (((oParam.makerParam) && (oParam.makerParam.telefrag)))
            {
                chatColors = this.chatApi.getChatColors();
                telefragState = this.dataApi.getSpellState((((oParam.data.teamId == TeamEnum.TEAM_DEFENDER)) ? 244 : 251)).name;
                telefragStr = (((('<font color="#' + chatColors[10].toString(16)) + '">') + telefragState) + "</font>");
                this.lbl_fightStatus.text = "";
                this.lbl_fightStatus.appendText(telefragStr);
                this.lbl_fightStatus.fullWidth();
                this.infosCtr.addChild(this.lbl_fightStatus);
                this.lbl_fightStatus.y = 20;
            };
            this.tx_back.height = (this.tx_back.width = 0);
            this.tx_back.removeFromParent();
            var backWidth:Number = this.lbl_playerName.width;
            if ((((this.lbl_info.width > 0)) && ((backWidth < this.lbl_info.width))))
            {
                backWidth = this.lbl_info.width;
            };
            if ((((this.lbl_fightStatus.width > 0)) && ((backWidth < this.lbl_fightStatus.width))))
            {
                backWidth = this.lbl_fightStatus.width;
            };
            this.lbl_damage.removeFromParent();
            this.tx_back.width = (backWidth + 8);
            this.tx_back.height = (this.infosCtr.height + 8);
            this.infosCtr.addContent(this.tx_back, 0);
            this.updateSpellDamage(oParam);
            if (this.lbl_info.width > 0)
            {
                this.lbl_info.x = (((this.tx_back.width - this.lbl_info.width) / 2) - 4);
            };
            if (this.lbl_fightStatus.width > 0)
            {
                this.lbl_fightStatus.x = (((this.tx_back.width - this.lbl_fightStatus.width) / 2) - 4);
            };
            this.lbl_playerName.x = (((this.tx_back.width / 2) - (this.lbl_playerName.width / 2)) - 4);
            this.updateStatus(oParam);
            this.tx_alignment.removeFromParent();
            this.tx_alignmentBottom.removeFromParent();
            var cellId:uint = ((((oParam.makerParam) && (oParam.makerParam.cellId))) ? oParam.makerParam.cellId : oParam.data.disposition.cellId);
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset, true, cellId);
            if (Api.system.getOption("showAlignmentWings", "dofus"))
            {
                showAlignmentWings(oParam);
            };
        }

        private function updatePlayerName(oParam:Object):void
        {
            var showName:Boolean = ((this.fightApi.isMouseOverFighter(oParam.data.contextualId)) ? true : false);
            if (!(this._isInPreFight))
            {
                if (oParam.data.stats.shieldPoints > 0)
                {
                    this.lbl_playerName.text = ((showName) ? (oParam.data.name + " ") : "");
                    this.lbl_playerName.text = (this.lbl_playerName.text + ("(" + oParam.data.stats.lifePoints));
                    this.lbl_playerName.appendText(("+" + oParam.data.stats.shieldPoints), "shield");
                    this.lbl_playerName.appendText(")", "p");
                }
                else
                {
                    this.lbl_playerName.text = ((showName) ? (oParam.data.name + " ") : "");
                    this.lbl_playerName.text = (this.lbl_playerName.text + (("(" + oParam.data.stats.lifePoints) + ")"));
                };
            }
            else
            {
                this.lbl_playerName.text = oParam.data.name;
            };
            this.lbl_playerName.fullWidth();
            this.tx_back.width = (this.lbl_playerName.width + 8);
        }

        private function updateStatus(oParam:Object):void
        {
            this.tx_status.visible = false;
            var playerStatus:int = Api.fight.getFighterStatus(oParam.data.contextualId);
            if ((((playerStatus == 20)) || ((playerStatus == 21))))
            {
                this.tx_status.visible = true;
                if (!(this._isInPreFight))
                {
                    this.lbl_playerName.y = 0;
                    if (((!(oParam.makerParam)) || (!(oParam.makerParam.spellDamage))))
                    {
                        this.lbl_playerName.x = 25;
                        this.tx_back.width = (this.tx_back.width + 25);
                    }
                    else
                    {
                        if (oParam.makerParam.spellDamage)
                        {
                            if (this.lbl_damage.width < (this.lbl_playerName.width + 25))
                            {
                                this.lbl_playerName.x = 25;
                                if (this.tx_back.width < (this.lbl_playerName.width + 25))
                                {
                                    this.tx_back.width = (this.tx_back.width + 25);
                                    this.lbl_damage.x = (this.lbl_damage.x + this.tx_status.width);
                                }
                                else
                                {
                                    this.tx_back.width = (this.tx_back.width + 8);
                                };
                            }
                            else
                            {
                                this.lbl_playerName.x = (((this.lbl_damage.x + (this.lbl_damage.width / 2)) + 25) - ((this.lbl_playerName.width + 25) / 2));
                            };
                        };
                    };
                }
                else
                {
                    if (this.lbl_playerName.width > this.lbl_info.width)
                    {
                        this.lbl_playerName.x = (this.lbl_playerName.x + 25);
                        this.tx_back.width = (this.tx_back.width + 25);
                        this.lbl_info.x = (this.lbl_info.x + (this.tx_status.width - 4));
                    }
                    else
                    {
                        this.lbl_playerName.x = 25;
                    };
                };
                this.tx_status.y = (this.lbl_playerName.y + 4);
                this.tx_status.x = (this.lbl_playerName.x - 25);
            };
        }

        private function updateSpellDamage(oParam:Object):void
        {
            var offsetIcon:Number;
            var effectIcons:Array;
            var line:String;
            var i:int;
            var tx_icon:Texture;
            var txIconHeight:Number;
            var txIconWidth:Number;
            var centerX:Number;
            var lineSize:Object;
            var backWidth:Number;
            this.lbl_damage.width = 1;
            if (((oParam.makerParam) && (oParam.makerParam.spellDamage)))
            {
                this.infosCtr.addContent(this.lbl_damage);
                this.lbl_damage.y = (this.lbl_playerName.y + 20);
                this.lbl_damage.text = "";
                this.lbl_damage.appendText(oParam.makerParam.spellDamage);
                this.lbl_damage.fullWidth();
                offsetIcon = 0;
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
                        centerX = (this.getInFightMaxLabelWidth() / 2);
                        tx_icon.x = (((centerX - (lineSize.width / 2)) - txIconWidth) - 2);
                        if (tx_icon.x < 0)
                        {
                            offsetIcon = txIconWidth;
                            tx_icon.x = (tx_icon.x + txIconWidth);
                        };
                        this.infosCtr.addContent(tx_icon);
                        this._icons.push(tx_icon);
                    };
                    i++;
                };
                backWidth = this.getInFightMaxLabelWidth();
                this.tx_back.width = ((backWidth + 8) + offsetIcon);
                this.tx_back.height = (this.infosCtr.height + 8);
                this.lbl_playerName.x = (((backWidth / 2) - (this.lbl_playerName.width / 2)) + offsetIcon);
                this.lbl_damage.x = (((backWidth / 2) - (this.lbl_damage.width / 2)) + offsetIcon);
            };
        }

        private function getInFightMaxLabelWidth():Number
        {
            var maxWidth:Number;
            if (this.lbl_playerName.text != "")
            {
                maxWidth = this.lbl_playerName.width;
            };
            if (((!((this.lbl_damage.text == ""))) && (((isNaN(maxWidth)) || ((this.lbl_damage.width > maxWidth))))))
            {
                maxWidth = this.lbl_damage.width;
            };
            return (maxWidth);
        }

        public function updateContent(oParam:Object):void
        {
            var tx:Texture;
            for each (tx in this._icons)
            {
                tx.remove();
                this._icons.splice(this._icons.indexOf(tx), 1);
            };
            this.updatePlayerName(oParam);
            this.updateSpellDamage(oParam);
            this.updateStatus(oParam);
        }

        public function unload():void
        {
        }


    }
}//package ui

