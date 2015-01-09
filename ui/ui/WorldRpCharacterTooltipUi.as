package ui
{
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.UtilApi;
    import d2api.SystemApi;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import d2network.HumanInformations;
    import d2network.HumanOptionGuild;
    import d2network.HumanOptionAlliance;
    import d2network.GameRolePlayMerchantInformations;
    import d2data.EmblemSymbol;
    import flash.geom.Rectangle;
    import d2hooks.*;

    public class WorldRpCharacterTooltipUi extends AbstractWorldCharacterTooltipUi 
    {

        private static const TOOLTIP_MIN_WIDTH:int = 160;
        private static const TOOLTIP_MIN_HEIGHT:int = 40;
        private static const EMBLEM_BACK_WIDTH:int = 40;

        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var utilApi:UtilApi;
        public var sysApi:SystemApi;
        private var _guildInformations:Object;
        private var _colorBack:int;
        private var _colorUp:int;
        private var _allianceInformations:Object;
        private var _allianceEmblemBgColor:int;
        private var _allianceEmblemIconColor:int;
        public var mainCtr:Object;
        public var ctr_alignment_top:GraphicContainer;
        public var ctr_alignment_bottom:GraphicContainer;
        public var infosCtr:GraphicContainer;
        public var tx_back:GraphicContainer;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var tx_AllianceEmblemBack:Texture;
        public var tx_AllianceEmblemUp:Texture;
        public var tx_alignment:Texture;
        public var tx_alignmentBottom:Texture;
        public var lbl_playerName:Label;
        public var lbl_guildName:Label;
        public var lbl_title:Label;
        public var ctr_ornament:GraphicContainer;
        public var tx_ornament:Texture;
        private var _achievementData:Object;
        private var _tooltipIsLoaded:Boolean = false;


        public function main(oParam:Object=null):void
        {
            var option:*;
            var w:int;
            var alignmentInfos:Object;
            var currentSize:int;
            var center:Number;
            var allianceEmblemBackX:Number;
            var decX:int;
            var guildDec:Number;
            var decY:int;
            this.uiApi.me().mouseEnabled = (this.uiApi.me().mouseChildren = false);
            var data:Object = oParam.data;
            this.lbl_playerName.x = (this.lbl_playerName.y = (this.lbl_playerName.width = 0));
            this.lbl_guildName.x = (this.lbl_guildName.y = (this.lbl_guildName.width = 0));
            this.lbl_guildName.removeFromParent();
            this.tx_emblemBack.removeFromParent();
            this.tx_emblemUp.removeFromParent();
            this.tx_AllianceEmblemBack.removeFromParent();
            this.tx_AllianceEmblemUp.removeFromParent();
            this.lbl_playerName.removeFromParent();
            this.updatePlayerName(oParam.makerName, data);
            this.infosCtr.addContent(this.lbl_playerName);
            var hasGuildInformation:Boolean;
            var hasAllianceInformation:Boolean;
            var hasInfos:Boolean = data.hasOwnProperty("infos");
            var hasTitle:Boolean = ((data.hasOwnProperty("titleName")) && (data.titleName));
            var hasOrnament:Boolean = ((data.hasOwnProperty("ornamentAssetId")) && ((data.ornamentAssetId > 0)));
            if (hasInfos)
            {
                this._guildInformations = null;
                if ((data.infos.humanoidInfo is HumanInformations))
                {
                    for each (option in (data.infos.humanoidInfo as HumanInformations).options)
                    {
                        if ((option is HumanOptionGuild))
                        {
                            this._guildInformations = option.guildInformations;
                            hasGuildInformation = true;
                        }
                        else
                        {
                            if ((option is HumanOptionAlliance))
                            {
                                this._allianceInformations = option.allianceInformations;
                                hasAllianceInformation = true;
                            };
                        };
                    };
                };
            }
            else
            {
                if ((data is GameRolePlayMerchantInformations))
                {
                    for each (option in (data as GameRolePlayMerchantInformations).options)
                    {
                        if ((option is HumanOptionGuild))
                        {
                            this._guildInformations = option.guildInformations;
                            hasGuildInformation = true;
                        }
                        else
                        {
                            if ((option is HumanOptionAlliance))
                            {
                                this._allianceInformations = option.allianceInformations;
                                hasAllianceInformation = true;
                            };
                        };
                    };
                };
            };
            if (hasGuildInformation)
            {
                this.lbl_playerName.y = 18;
                this.tx_emblemBack.visible = false;
                this.tx_emblemUp.visible = false;
                this.infosCtr.addContent(this.tx_emblemBack);
                this.infosCtr.addContent(this.tx_emblemUp);
                this.infosCtr.addContent(this.lbl_guildName);
                this.lbl_guildName.text = this._guildInformations.guildName;
                this.lbl_guildName.fullWidth();
                this.tx_emblemBack.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemBack, "onTextureReady");
                this.tx_emblemUp.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemUp, "onTextureReady");
                this.tx_emblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "back/") + this._guildInformations.guildEmblem.backgroundShape) + ".swf"));
                this.tx_emblemUp.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "up/") + this._guildInformations.guildEmblem.symbolShape) + ".swf"));
                this._colorUp = this._guildInformations.guildEmblem.symbolColor;
                this._colorBack = this._guildInformations.guildEmblem.backgroundColor;
                this.tx_emblemBack.x = 2;
                this.tx_emblemUp.x = 10;
                this.tx_emblemUp.y = 8;
                this.lbl_guildName.x = 50;
                this.lbl_guildName.y = -2;
                this.lbl_playerName.x = 50;
            };
            this.lbl_title.x = (this.lbl_title.y = 0);
            this.lbl_title.width = 0;
            this.lbl_title.removeFromParent();
            if (hasTitle)
            {
                this.lbl_title.useCustomFormat = true;
                if (data.titleColor)
                {
                    this.lbl_title.text = (((("<font color='#" + data.titleColor.substr(2)) + "'>") + data.titleName) + "</font>");
                };
                this.lbl_title.fullWidth();
                this.infosCtr.addContent(this.lbl_title);
                if (hasGuildInformation)
                {
                    this.lbl_title.y = 40;
                }
                else
                {
                    this.lbl_title.y = 20;
                };
            }
            else
            {
                this.lbl_title.text = "";
                this.tx_emblemBack.x = 2;
                this.tx_emblemUp.x = 10;
            };
            if (hasGuildInformation)
            {
                if (hasAllianceInformation)
                {
                    this.tx_AllianceEmblemBack.visible = false;
                    this.tx_AllianceEmblemUp.visible = false;
                    this.infosCtr.addContent(this.tx_AllianceEmblemBack);
                    this.infosCtr.addContent(this.tx_AllianceEmblemUp);
                    this.lbl_guildName.appendText(((" - [" + this._allianceInformations.allianceTag) + "]"));
                    this.lbl_guildName.fullWidth();
                    this._allianceEmblemBgColor = this._allianceInformations.allianceEmblem.backgroundColor;
                    this._allianceEmblemIconColor = this._allianceInformations.allianceEmblem.symbolColor;
                    this.tx_AllianceEmblemBack.dispatchMessages = (this.tx_AllianceEmblemUp.dispatchMessages = true);
                    this.uiApi.addComponentHook(this.tx_AllianceEmblemBack, "onTextureReady");
                    this.uiApi.addComponentHook(this.tx_AllianceEmblemUp, "onTextureReady");
                    if (this._allianceInformations.allianceEmblem.backgroundShape != this._guildInformations.guildEmblem.backgroundShape)
                    {
                        this.tx_AllianceEmblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "backalliance/") + this._allianceInformations.allianceEmblem.backgroundShape) + ".swf"));
                    };
                    if (this._allianceInformations.allianceEmblem.symbolShape != this._guildInformations.guildEmblem.symbolShape)
                    {
                        this.tx_AllianceEmblemUp.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "up/") + this._allianceInformations.allianceEmblem.symbolShape) + ".swf"));
                    };
                    this.tx_AllianceEmblemBack.y = this.tx_emblemBack.y;
                    this.tx_AllianceEmblemUp.y = this.tx_emblemUp.y;
                    if (this.lbl_guildName.width > this.lbl_playerName.width)
                    {
                        this.tx_AllianceEmblemBack.x = ((this.lbl_guildName.x + this.lbl_guildName.width) + 8);
                    }
                    else
                    {
                        this.tx_AllianceEmblemBack.x = ((this.lbl_playerName.x + this.lbl_playerName.width) + 8);
                    };
                    this.tx_AllianceEmblemBack.x;
                    this.tx_AllianceEmblemUp.x = (this.tx_AllianceEmblemBack.x + 8);
                };
                if (this.lbl_guildName.width > this.lbl_playerName.width)
                {
                    this.lbl_playerName.x = (this.lbl_playerName.x + ((this.lbl_guildName.width - this.lbl_playerName.width) / 2));
                }
                else
                {
                    this.lbl_guildName.x = (this.lbl_guildName.x + ((this.lbl_playerName.width - this.lbl_guildName.width) / 2));
                };
            };
            this.tx_back.height = 0;
            this.tx_back.width = 0;
            this.tx_back.removeFromParent();
            if (this.lbl_title.text != "")
            {
                if (((hasGuildInformation) && ((this.lbl_guildName.width > this.lbl_playerName.width))))
                {
                    w = ((this.lbl_guildName.x + this.lbl_guildName.width) + 8);
                }
                else
                {
                    w = ((this.lbl_playerName.x + this.lbl_playerName.width) + 8);
                };
                if (((hasGuildInformation) && (hasAllianceInformation)))
                {
                    w = (w + (EMBLEM_BACK_WIDTH + 8));
                };
                if (w < (this.lbl_title.width + 8))
                {
                    this.tx_back.width = (this.lbl_title.width + 8);
                    if (hasGuildInformation)
                    {
                        allianceEmblemBackX = ((this.tx_back.width - 8) - EMBLEM_BACK_WIDTH);
                        if (hasAllianceInformation)
                        {
                            this.tx_AllianceEmblemBack.x = allianceEmblemBackX;
                            this.tx_AllianceEmblemUp.x = (this.tx_AllianceEmblemBack.x + 8);
                        };
                        center = ((hasAllianceInformation) ? (((this.tx_emblemBack.x + this.tx_emblemBack.width) + allianceEmblemBackX) / 2) : ((((this.lbl_title.x + this.lbl_title.width) + 8) / 2) + 16));
                        this.lbl_guildName.x = (center - (this.lbl_guildName.width / 2));
                        this.lbl_playerName.x = (center - (this.lbl_playerName.width / 2));
                    };
                }
                else
                {
                    this.tx_back.width = w;
                };
                this.tx_back.height = (this.infosCtr.height + 8);
            }
            else
            {
                if (hasGuildInformation)
                {
                    if (this.lbl_guildName.width > this.lbl_playerName.width)
                    {
                        this.tx_back.width = ((this.lbl_guildName.x + this.lbl_guildName.width) + 8);
                    }
                    else
                    {
                        this.tx_back.width = ((this.lbl_playerName.x + this.lbl_playerName.width) + 8);
                    };
                    if (hasAllianceInformation)
                    {
                        if (this.lbl_guildName.width > this.lbl_playerName.width)
                        {
                            this.tx_back.width = (((this.lbl_guildName.x + this.lbl_guildName.width) + EMBLEM_BACK_WIDTH) + 16);
                        }
                        else
                        {
                            this.tx_back.width = (((this.lbl_playerName.x + this.lbl_playerName.width) + EMBLEM_BACK_WIDTH) + 16);
                        };
                    };
                    this.tx_back.height = (this.infosCtr.height + 6);
                }
                else
                {
                    if (this.lbl_playerName.width < 60)
                    {
                        this.lbl_playerName.x = ((60 - this.lbl_playerName.width) / 2);
                        this.tx_back.width = 68;
                    }
                    else
                    {
                        this.tx_back.width = (this.lbl_playerName.width + 8);
                    };
                    this.tx_back.height = (this.infosCtr.height + 5);
                };
            };
            this.tx_back.width = (this.tx_back.width + 2);
            this.lbl_title.x = (((this.tx_back.width - this.lbl_title.width) / 2) - 4);
            if (((((!((this.lbl_title.text == ""))) && (!(hasGuildInformation)))) && (!(hasAllianceInformation))))
            {
                this.lbl_playerName.x = (((this.tx_back.width / 2) - (this.lbl_playerName.width / 2)) - 4);
            };
            if (((data.hasOwnProperty("infos")) && (data.infos.hasOwnProperty("alignmentInfos"))))
            {
                alignmentInfos = oParam.data.infos.alignmentInfos;
            }
            else
            {
                if (data.hasOwnProperty("alignmentInfos"))
                {
                    alignmentInfos = data.alignmentInfos;
                };
            };
            if (((((alignmentInfos) && ((alignmentInfos.alignmentSide > 0)))) && ((alignmentInfos.alignmentGrade > 0))))
            {
                hasOrnament = false;
            };
            if (((hasOrnament) && ((this.tx_back.width < TOOLTIP_MIN_WIDTH))))
            {
                decX = (TOOLTIP_MIN_WIDTH - this.tx_back.width);
                this.tx_back.width = TOOLTIP_MIN_WIDTH;
                this.lbl_playerName.x = ((TOOLTIP_MIN_WIDTH - this.lbl_playerName.width) / 2);
                if (hasGuildInformation)
                {
                    if (this.lbl_playerName.width > this.lbl_guildName.width)
                    {
                        guildDec = ((TOOLTIP_MIN_WIDTH - (this.tx_emblemBack.width + this.lbl_playerName.width)) / 2);
                    }
                    else
                    {
                        guildDec = ((TOOLTIP_MIN_WIDTH - (this.tx_emblemBack.width + this.lbl_guildName.width)) / 2);
                    };
                    if (guildDec > 8)
                    {
                        guildDec = (guildDec - 8);
                    };
                    this.tx_emblemBack.x = guildDec;
                    this.tx_emblemUp.x = (guildDec + 8);
                    this.lbl_playerName.x = (this.tx_emblemBack.x + 48);
                    this.lbl_guildName.x = (this.tx_emblemBack.x + 48);
                };
                if (hasTitle)
                {
                    this.lbl_title.x = (((TOOLTIP_MIN_WIDTH - this.lbl_title.width) / 2) - 5);
                };
            };
            if (((hasOrnament) && ((this.tx_back.height < TOOLTIP_MIN_HEIGHT))))
            {
                decY = (TOOLTIP_MIN_HEIGHT - this.tx_back.height);
                this.tx_back.height = TOOLTIP_MIN_HEIGHT;
                this.lbl_playerName.y = (((TOOLTIP_MIN_HEIGHT - this.lbl_playerName.height) / 2) - 3);
            };
            this.infosCtr.addContent(this.tx_back, 0);
            this._tooltipIsLoaded = false;
            this.tx_ornament.uri = null;
            if (hasOrnament)
            {
                this.mainCtr.visible = false;
                this.tx_ornament.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_ornament, "onTextureReady");
                this.tx_ornament.uri = this.uiApi.createUri(((((this.sysApi.getConfigEntry("config.gfx.path.ornament") + "ornament_") + data.ornamentAssetId) + ".swf|ornament_") + data.ornamentAssetId));
            }
            else
            {
                this.mainCtr.visible = true;
            };
            if (oParam.zoom)
            {
                this.uiApi.me().scale = oParam.zoom;
            };
            this.tx_alignment.removeFromParent();
            this.tx_alignmentBottom.removeFromParent();
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
            showAlignmentWings(oParam);
        }

        private function updatePlayerName(makerName:String, data:Object):void
        {
            switch (makerName)
            {
                case "player":
                case "mutant":
                    this.lbl_playerName.text = data.infos.name;
                    break;
                case "merchant":
                    this.lbl_playerName.text = (((data.name + " (") + Api.ui.getText("ui.common.merchant")) + ")");
                    break;
            };
            this.lbl_playerName.fullWidth();
        }

        public function updateContent(oParam:Object):void
        {
            this.updatePlayerName(oParam.makerName, oParam.data);
        }

        private function updateEmblemBack(pTexture:Texture, pColor:int):void
        {
            this.utilApi.changeColor(pTexture.getChildByName("back"), pColor, 1);
            pTexture.visible = true;
        }

        private function updateEmblemUp(pTexture:Texture, pColor:int, pSymbolId:int):void
        {
            var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(pSymbolId);
            if (icon.colorizable)
            {
                this.utilApi.changeColor(pTexture.getChildByName("up"), pColor, 0);
            }
            else
            {
                this.utilApi.changeColor(pTexture.getChildByName("up"), pColor, 0, true);
            };
            pTexture.visible = true;
        }

        public function onTextureReady(target:Object):void
        {
            var uiBounds:Object;
            var bounds:*;
            switch (target)
            {
                case this.tx_emblemBack:
                    if (!(this._guildInformations))
                    {
                        return;
                    };
                    this.updateEmblemBack(this.tx_emblemBack, this._colorBack);
                    if (((this._allianceInformations) && ((this._allianceInformations.allianceEmblem.backgroundShape == this._guildInformations.guildEmblem.backgroundShape))))
                    {
                        this.tx_AllianceEmblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "backalliance/") + this._allianceInformations.allianceEmblem.backgroundShape) + ".swf"));
                    };
                    break;
                case this.tx_emblemUp:
                    if (!(this._guildInformations))
                    {
                        return;
                    };
                    this.updateEmblemUp(this.tx_emblemUp, this._colorUp, this._guildInformations.guildEmblem.symbolShape);
                    if (((this._allianceInformations) && ((this._allianceInformations.allianceEmblem.symbolShape == this._guildInformations.guildEmblem.symbolShape))))
                    {
                        this.tx_AllianceEmblemUp.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "up/") + this._allianceInformations.allianceEmblem.symbolShape) + ".swf"));
                    };
                    break;
                case this.tx_AllianceEmblemBack:
                    if (!(this._allianceInformations))
                    {
                        return;
                    };
                    this.updateEmblemBack(this.tx_AllianceEmblemBack, this._allianceEmblemBgColor);
                    break;
                case this.tx_AllianceEmblemUp:
                    if (!(this._allianceInformations))
                    {
                        return;
                    };
                    this.updateEmblemUp(this.tx_AllianceEmblemUp, this._allianceEmblemIconColor, this._allianceInformations.allianceEmblem.symbolShape);
                    break;
                case this.tx_ornament:
                    if (!(this._tooltipIsLoaded))
                    {
                        this.uiApi.buildOrnamentTooltipFrom(this.tx_ornament, new Rectangle(0, 0, this.tx_back.width, this.tx_back.height));
                        this.mainCtr.visible = true;
                        if (((this.tx_ornament.child) && (this.tx_ornament.child.hasOwnProperty("bottom"))))
                        {
                            bounds = this.tx_ornament.child.bottom.getBounds(this.tx_ornament.child.bottom);
                            this.uiApi.me().y = (this.uiApi.me().y - (this.tx_ornament.child.bottom.height + bounds.top));
                        };
                        uiBounds = this.uiApi.me().getBounds(this.uiApi.me());
                        if ((this.uiApi.me().x + uiBounds.left) < 0)
                        {
                            this.uiApi.me().x = (this.uiApi.me().x - uiBounds.left);
                        }
                        else
                        {
                            if ((this.uiApi.me().x + uiBounds.right) > this.uiApi.getStageWidth())
                            {
                                this.uiApi.me().x = (this.uiApi.me().x - ((this.uiApi.me().x + uiBounds.right) - this.uiApi.getStageWidth()));
                            };
                        };
                        if ((this.uiApi.me().y + uiBounds.top) < 0)
                        {
                            this.uiApi.me().y = (this.uiApi.me().y - (this.uiApi.me().y + uiBounds.top));
                        };
                        this._tooltipIsLoaded = true;
                    };
                    break;
            };
        }

        public function unload():void
        {
        }


    }
}//package ui

