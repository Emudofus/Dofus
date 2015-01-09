package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import d2api.UtilApi;
    import d2data.SocialEntityInFightWrapper;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import d2components.Grid;
    import d2hooks.GuildFightEnnemiesListUpdate;
    import d2hooks.GuildFightAlliesListUpdate;
    import d2hooks.TaxCollectorUpdate;
    import flash.geom.ColorTransform;
    import ui.AllianceFights;
    import d2data.TaxCollectorWrapper;
    import d2data.PrismSubAreaWrapper;
    import flash.utils.getTimer;
    import d2network.CharacterMinimalAllianceInformations;
    import d2network.CharacterMinimalGuildInformations;
    import d2enums.SelectMethodEnum;
    import utils.JoinFightUtil;
    import d2hooks.*;
    import d2actions.*;

    public class AllianceFightXmlItem 
    {

        private static const TYPE_TAX_COLLECTOR:int = 0;
        private static const TYPE_PRISM:int = 1;

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        public var utilApi:UtilApi;
        private var _data:SocialEntityInFightWrapper;
        private var _detailedData:Object;
        private var _clockStart:uint;
        private var _clockEnd:uint;
        private var _clockDuration:uint;
        private var _savedTime:int = 0;
        private var _previousState:uint = 0;
        private var _fighting:Boolean = false;
        private var _forceShowType:int = -1;
        private var _forceShowFight:int = -1;
        private var _attackList:String = "";
        private var _defenseList:String = "";
        private var _infos:String = "";
        private var _timeProgressBar_y:uint;
        private var _assetsPath:String;
        public var mainCtr:GraphicContainer;
        public var tx_fightType:Texture;
        public var tx_timeProgressBar:Texture;
        public var tx_attackTeam:Texture;
        public var tx_defenseTeam:Texture;
        public var lbl_name:Label;
        public var lbl_loc:Label;
        public var lbl_infos:Label;
        public var gd_attackTeam:Grid;
        public var gd_defenseTeam:Grid;


        public function main(oParam:Object=null):void
        {
            this.mainCtr.mouseEnabled = true;
            this.sysApi.addHook(GuildFightEnnemiesListUpdate, this.onGuildFightEnnemiesListUpdate);
            this.sysApi.addHook(GuildFightAlliesListUpdate, this.onGuildFightAlliesListUpdate);
            this.sysApi.addHook(TaxCollectorUpdate, this.onTaxCollectorUpdate);
            this.gd_attackTeam.mouseEnabled = true;
            this.uiApi.addComponentHook(this.gd_defenseTeam, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_defenseTeam, "onSelectEmptyItem");
            this.uiApi.addComponentHook(this.gd_defenseTeam, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_defenseTeam, "onItemRollOut");
            this.uiApi.addComponentHook(this.gd_attackTeam, "onItemRollOver");
            this.uiApi.addComponentHook(this.gd_attackTeam, "onItemRollOut");
            this.uiApi.addComponentHook(this.tx_attackTeam, "onRollOver");
            this.uiApi.addComponentHook(this.tx_attackTeam, "onRollOut");
            this.uiApi.addComponentHook(this.tx_defenseTeam, "onRollOver");
            this.uiApi.addComponentHook(this.tx_defenseTeam, "onRollOut");
            this.uiApi.addComponentHook(this.tx_fightType, "onRollOver");
            this.uiApi.addComponentHook(this.tx_fightType, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_infos, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_infos, "onRollOut");
            this.tx_timeProgressBar.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 44, -78, -174, 0);
            this.tx_timeProgressBar.scaleY = 0;
            this._clockEnd = 0;
            this._clockDuration = 0;
            this._clockStart = 0;
            this._assetsPath = this.uiApi.me().getConstant("assets");
            this._forceShowType = AllianceFights.getInstance().forceShowType;
            this._forceShowFight = AllianceFights.getInstance().forceShowFight;
            this.update(oParam.data, false);
        }

        public function unload():void
        {
            this.tx_timeProgressBar.scaleY = 0;
            this._clockEnd = 0;
            this._clockDuration = 0;
            this._clockStart = 0;
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function get data():Object
        {
            return (this._data);
        }

        public function update(newData:Object, selected:Boolean, force:Boolean=false):void
        {
            var detailedData:TaxCollectorWrapper;
            var guildName:String;
            var e2:*;
            var a2:*;
            var detailedPData:PrismSubAreaWrapper;
            var fighter:Object;
            var percentTime:Number;
            var e:*;
            var a:*;
            if (newData)
            {
                this._data = (newData as SocialEntityInFightWrapper);
                this.tx_attackTeam.visible = true;
                this.tx_defenseTeam.visible = true;
                this._attackList = ((this.uiApi.getText("ui.common.attackers") + this.uiApi.getText("ui.common.colon")) + "\n");
                this._defenseList = ((this.uiApi.getText("ui.common.defenders") + this.uiApi.getText("ui.common.colon")) + "\n");
                this.gd_attackTeam.visible = true;
                this.gd_defenseTeam.visible = true;
                if ((((this._forceShowType == this._data.typeId)) && ((this._forceShowFight == this._data.uniqueId))))
                {
                    this.mainCtr.bgColor = this.sysApi.getConfigEntry("colors.grid.over");
                }
                else
                {
                    this.mainCtr.bgColor = -1;
                };
                if (this._data.typeId == TYPE_TAX_COLLECTOR)
                {
                    detailedData = this.socialApi.getTaxCollector(this._data.uniqueId);
                    if (!(detailedData))
                    {
                        return;
                    };
                    this.lbl_name.text = ((detailedData.firstName + " ") + detailedData.lastName);
                    this.lbl_loc.text = (((((this.dataApi.getSubArea(detailedData.subareaId).name + " (") + detailedData.mapWorldX) + ",") + detailedData.mapWorldY) + ")");
                    guildName = ((detailedData.guild) ? detailedData.guild.guildName : this.socialApi.getGuild().guildName);
                    this.lbl_infos.text = ((this.uiApi.getText("ui.common.guild") + this.uiApi.getText("ui.common.colon")) + guildName);
                    if (((((this._data) && (this._data.enemyCharactersInformations))) && ((this._data.enemyCharactersInformations.length > 0))))
                    {
                        this.gd_attackTeam.dataProvider = this._data.enemyCharactersInformations;
                        for each (e2 in this._data.enemyCharactersInformations)
                        {
                            this._attackList = (this._attackList + (((e2.playerCharactersInformations.name + " (") + e2.playerCharactersInformations.level) + ")\n"));
                        };
                    };
                    if (((((this._data) && (this._data.allyCharactersInformations))) && ((this._data.allyCharactersInformations.length > 0))))
                    {
                        this.gd_defenseTeam.dataProvider = this._data.allyCharactersInformations;
                        for each (a2 in this._data.allyCharactersInformations)
                        {
                            this._defenseList = (this._defenseList + (((a2.playerCharactersInformations.name + " (") + a2.playerCharactersInformations.level) + ")\n"));
                        };
                    };
                    if (((!(this.tx_timeProgressBar.visible)) || ((this.tx_timeProgressBar.scaleY == 0))))
                    {
                        this.tx_timeProgressBar.visible = true;
                    };
                    this._clockEnd = detailedData.fightTime;
                    this._clockDuration = detailedData.waitTimeForPlacement;
                    this._clockStart = getTimer();
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    this.tx_fightType.uri = this.uiApi.createUri((this._assetsPath + "tx_iconTaxCollector"));
                    this._detailedData = detailedData;
                }
                else
                {
                    if (this._data.typeId == TYPE_PRISM)
                    {
                        detailedPData = this.socialApi.getPrismSubAreaById(this._data.uniqueId);
                        this.lbl_name.text = ((this.uiApi.getText("ui.zaap.prism") + " ") + detailedPData.alliance.allianceName);
                        this.lbl_loc.text = (((((detailedPData.subAreaName + " (") + detailedPData.worldX) + ",") + detailedPData.worldY) + ")");
                        this.lbl_infos.text = this.uiApi.getText("ui.prism.placed", this.timeApi.getDate((detailedPData.placementDate * 1000)));
                        if (((((this._data) && (this._data.enemyCharactersInformations))) && ((this._data.enemyCharactersInformations.length > 0))))
                        {
                            this.gd_attackTeam.dataProvider = this._data.enemyCharactersInformations;
                            for each (e in this._data.enemyCharactersInformations)
                            {
                                fighter = e.playerCharactersInformations;
                                if ((fighter is CharacterMinimalAllianceInformations))
                                {
                                    this._attackList = (this._attackList + (((((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName) + " - [") + fighter.alliance.allianceTag) + "]\n"));
                                }
                                else
                                {
                                    if ((fighter is CharacterMinimalGuildInformations))
                                    {
                                        this._attackList = (this._attackList + (((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName) + "\n"));
                                    }
                                    else
                                    {
                                        this._attackList = (this._attackList + (((fighter.name + " (") + fighter.level) + ")\n"));
                                    };
                                };
                            };
                        };
                        if (((((this._data) && (this._data.allyCharactersInformations))) && ((this._data.allyCharactersInformations.length > 0))))
                        {
                            this.gd_defenseTeam.dataProvider = this._data.allyCharactersInformations;
                            for each (a in this._data.allyCharactersInformations)
                            {
                                fighter = a.playerCharactersInformations;
                                if (fighter.name == "3451")
                                {
                                    this._defenseList = (this._defenseList + (((this.lbl_name.text + " (") + fighter.level) + ")\n"));
                                }
                                else
                                {
                                    if ((((fighter is CharacterMinimalGuildInformations)) || ((fighter is CharacterMinimalAllianceInformations))))
                                    {
                                        this._defenseList = (this._defenseList + (((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName) + "\n"));
                                    }
                                    else
                                    {
                                        this._defenseList = (this._defenseList + (((fighter.name + " (") + fighter.level) + ")\n"));
                                    };
                                };
                            };
                        };
                        this.tx_timeProgressBar.visible = true;
                        this._clockEnd = this._data.fightTime;
                        this._clockDuration = this._data.waitTimeForPlacement;
                        this._clockStart = getTimer();
                        percentTime = ((this._clockDuration - (this._clockEnd - this._clockStart)) / this._clockDuration);
                        this.tx_timeProgressBar.scaleY = -(percentTime);
                        this.sysApi.addEventListener(this.onEnterFrame, "time");
                        if (detailedPData.isVillage)
                        {
                            this.tx_fightType.uri = this.uiApi.createUri((this._assetsPath + "tx_villageIcon"));
                        }
                        else
                        {
                            this.tx_fightType.uri = this.uiApi.createUri((this._assetsPath + "tx_prismIcon"));
                        };
                        this._detailedData = detailedPData;
                    };
                };
            }
            else
            {
                this.tx_timeProgressBar.scaleY = 0;
                this._clockEnd = 0;
                this._clockDuration = 0;
                this._clockStart = 0;
                this.mainCtr.bgColor = -1;
                this.tx_fightType.uri = null;
                this.tx_timeProgressBar.visible = false;
                this.tx_attackTeam.visible = false;
                this.tx_defenseTeam.visible = false;
                this.lbl_name.text = "";
                this.lbl_loc.text = "";
                this.lbl_infos.text = "";
                this.gd_attackTeam.dataProvider = new Array();
                this.gd_attackTeam.visible = false;
                this.gd_defenseTeam.dataProvider = new Array();
                this.gd_defenseTeam.visible = false;
            };
            this.uiApi.me().render();
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            switch (target)
            {
                case this.tx_attackTeam:
                    if (this._attackList != "")
                    {
                        text = this._attackList;
                    };
                    break;
                case this.tx_defenseTeam:
                    if (this._defenseList != "")
                    {
                        text = this._defenseList;
                    };
                    break;
                case this.tx_fightType:
                    if (this._infos != "")
                    {
                        text = this._infos;
                    };
                    break;
                case this.lbl_infos:
                    if (((this._detailedData) && ((this._data.typeId == TYPE_TAX_COLLECTOR))))
                    {
                        if (this._detailedData.itemsValue)
                        {
                            text = this.uiApi.getText("ui.social.taxCollector.itemsValue", this.utilApi.kamasToString(this._detailedData.itemsValue));
                            if (this._detailedData.kamas)
                            {
                                text = (text + "\n");
                            };
                        };
                        if (this._detailedData.kamas)
                        {
                            text = (text + this.uiApi.getText("ui.social.taxCollector.kamasCollected", this.utilApi.kamasToString(this._detailedData.kamas, "")));
                        };
                    };
                    break;
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            switch (target)
            {
                case this.tx_attackTeam:
                case this.tx_defenseTeam:
                case this.tx_fightType:
                case this.lbl_infos:
                    this.uiApi.hideTooltip();
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if ((((target == this.gd_defenseTeam)) && ((selectMethod == SelectMethodEnum.CLICK))))
            {
                if (target.selectedItem.hasOwnProperty("playerCharactersInformations"))
                {
                    if (target.selectedItem.playerCharactersInformations.id != this.playerApi.id())
                    {
                        JoinFightUtil.swapPlaces(this._data.typeId, this._data.uniqueId, target.selectedItem.playerCharactersInformations);
                    }
                    else
                    {
                        JoinFightUtil.leave(this._data.typeId, this._data.uniqueId);
                    };
                };
            };
        }

        public function onSelectEmptyItem(target:Object, selectMethod:uint):void
        {
            if ((((target == this.gd_defenseTeam)) && ((selectMethod == SelectMethodEnum.CLICK))))
            {
                JoinFightUtil.join(this._data.typeId, this._data.uniqueId);
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var fighter:Object;
            if (((item) && (item.data)))
            {
                text = "";
                if (target == this.gd_attackTeam)
                {
                    fighter = item.data.playerCharactersInformations;
                    if ((fighter is CharacterMinimalAllianceInformations))
                    {
                        text = (((((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName) + " - [") + fighter.alliance.allianceTag) + "]");
                    }
                    else
                    {
                        if ((fighter is CharacterMinimalGuildInformations))
                        {
                            text = ((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName);
                        }
                        else
                        {
                            text = (((fighter.name + " (") + fighter.level) + ")");
                        };
                    };
                };
                if (target == this.gd_defenseTeam)
                {
                    fighter = item.data.playerCharactersInformations;
                    if (fighter.name == "3451")
                    {
                        text = (((this.lbl_name.text + " (") + fighter.level) + ")");
                    }
                    else
                    {
                        if ((((fighter is CharacterMinimalGuildInformations)) || ((fighter is CharacterMinimalAllianceInformations))))
                        {
                            text = ((((fighter.name + " (") + fighter.level) + ") ") + fighter.guild.guildName);
                        }
                        else
                        {
                            text = (((fighter.name + " (") + fighter.level) + ")");
                        };
                    };
                };
                if (text != "")
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), item.container, false, "standard", this.sysApi.getEnum("com.ankamagames.berilia.types.LocationEnum").POINT_BOTTOMRIGHT, 1, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onEnterFrame():void
        {
            var clock:uint = getTimer();
            var percentTime:Number = ((this._clockDuration - (this._clockEnd - clock)) / this._clockDuration);
            if (percentTime > 1)
            {
                percentTime = 0;
            };
            if (clock >= this._clockEnd)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
            };
            this.tx_timeProgressBar.scaleY = -(percentTime);
        }

        private function onGuildFightEnnemiesListUpdate(type:int, fightId:uint):void
        {
            var enemies:Object;
            var e2:*;
            if (((((this._data) && ((type == this._data.typeId)))) && ((fightId == this._data.uniqueId))))
            {
                if (type == 0)
                {
                    enemies = this.socialApi.getAllFightingTaxCollector(fightId).enemyCharactersInformations;
                }
                else
                {
                    if (type == 1)
                    {
                        enemies = this.socialApi.getFightingPrism(fightId).enemyCharactersInformations;
                    };
                };
                this.gd_attackTeam.dataProvider = enemies;
                this._attackList = ((this.uiApi.getText("ui.common.attackers") + this.uiApi.getText("ui.common.colon")) + "\n");
                if (((enemies) && ((enemies.length > 0))))
                {
                    for each (e2 in enemies)
                    {
                        this._attackList = (this._attackList + (((e2.playerCharactersInformations.name + " (") + e2.playerCharactersInformations.level) + ")\n"));
                    };
                }
                else
                {
                    this._attackList = "";
                };
            };
        }

        private function onGuildFightAlliesListUpdate(type:int, fightId:uint):void
        {
            var allies:Object;
            var a2:*;
            if (((((this._data) && ((type == this._data.typeId)))) && ((fightId == this._data.uniqueId))))
            {
                if (type == 0)
                {
                    allies = this.socialApi.getAllFightingTaxCollector(fightId).allyCharactersInformations;
                }
                else
                {
                    if (type == 1)
                    {
                        allies = this.socialApi.getFightingPrism(fightId).allyCharactersInformations;
                    };
                };
                this.gd_defenseTeam.dataProvider = allies;
                this._defenseList = ((this.uiApi.getText("ui.common.defenders") + this.uiApi.getText("ui.common.colon")) + "\n");
                if (((allies) && ((allies.length > 0))))
                {
                    for each (a2 in allies)
                    {
                        this._defenseList = (this._defenseList + (((a2.playerCharactersInformations.name + " (") + a2.playerCharactersInformations.level) + ")\n"));
                    };
                }
                else
                {
                    this._defenseList = "";
                };
            };
        }

        private function onTaxCollectorUpdate(id:int):void
        {
            if (((this._data) && ((id == this._data.uniqueId))))
            {
                this.update(this.socialApi.getAllFightingTaxCollector(id), false);
            };
        }


    }
}//package ui.items

