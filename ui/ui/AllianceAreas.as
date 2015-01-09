package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import d2api.PlayedCharacterApi;
    import d2api.ConfigApi;
    import d2api.MapApi;
    import d2api.UtilApi;
    import flash.utils.Dictionary;
    import d2components.GraphicContainer;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.ComboBox;
    import d2data.ItemWrapper;
    import d2data.PrismSubAreaWrapper;
    import d2hooks.PrismsListUpdate;
    import d2enums.PrismStateEnum;
    import d2enums.ComponentHookList;
    import d2actions.PrismSettingsRequest;
    import d2hooks.AddMapFlag;
    import d2enums.CompassTypeEnum;
    import d2hooks.*;
    import d2actions.*;

    public class AllianceAreas 
    {

        private static const SERVER_CONST_KOH_DURATION:int = 2;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        public var playerApi:PlayedCharacterApi;
        public var configApi:ConfigApi;
        public var mapApi:MapApi;
        public var utilApi:UtilApi;
        private var _prismsList:Array;
        private var _bDescendingSort:Boolean = false;
        private var _compHookData:Dictionary;
        private var _assetsPath:String;
        private var _txtHours:Array;
        private var _txtMinutes:Array;
        private var _quartersNumber:uint;
        private var _subAreaBeingModified:int = -1;
        private var _forceShowPrismId:int;
        private var _moduleTypeIdToDisplay:int = 0;
        public var mainCtr:GraphicContainer;
        public var ctr_setHour:GraphicContainer;
        public var gd_subAreas:Grid;
        public var btn_tabType:ButtonContainer;
        public var btn_tabSubArea:ButtonContainer;
        public var btn_tabCoord:ButtonContainer;
        public var btn_tabModules:ButtonContainer;
        public var btn_tabNuggets:ButtonContainer;
        public var btn_tabState:ButtonContainer;
        public var btn_tabVulneHour:ButtonContainer;
        public var lbl_conquestInfo:Label;
        public var cb_moduleTypes:ComboBox;
        public var lbl_prismArea:Label;
        public var lbl_explanationHour:Label;
        public var cb_hours:ComboBox;
        public var cb_minutes:ComboBox;
        public var btn_close:ButtonContainer;
        public var btn_save:ButtonContainer;
        public var btn_undo:ButtonContainer;

        public function AllianceAreas()
        {
            this._compHookData = new Dictionary(true);
            super();
        }

        public function main(... args):void
        {
            var itemw:ItemWrapper;
            var alreadyIn:Boolean;
            var prismInfo:PrismSubAreaWrapper;
            var prismId:int;
            var id:int;
            var type:*;
            this.sysApi.addHook(PrismsListUpdate, this.onPrismsListUpdate);
            this._assetsPath = this.uiApi.me().getConstant("assets");
            this._txtHours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];
            this._txtMinutes = ["00", "30"];
            this.cb_hours.dataNameField = "";
            this.cb_hours.dataProvider = this._txtHours;
            this.cb_minutes.dataNameField = "";
            this.cb_minutes.dataProvider = this._txtMinutes;
            this._prismsList = new Array();
            var moduleTypeNames:Array = new Array();
            var prismIds:Object = this.socialApi.getAlliance().prismIds;
            moduleTypeNames.push({
                "id":0,
                "label":this.uiApi.getText("ui.common.all")
            });
            for each (prismId in prismIds)
            {
                prismInfo = this.socialApi.getPrismSubAreaById(prismId);
                this._prismsList.push(prismInfo);
                for each (id in prismInfo.modulesItemIds)
                {
                    itemw = this.dataApi.getItemWrapper(id, 0, 0, 1);
                    alreadyIn = false;
                    for each (type in moduleTypeNames)
                    {
                        if (type.label == itemw.name)
                        {
                            alreadyIn = true;
                        };
                    };
                    if (!(alreadyIn))
                    {
                        moduleTypeNames.push({
                            "id":id,
                            "label":itemw.name
                        });
                    };
                };
            };
            this.cb_moduleTypes.dataProvider = moduleTypeNames;
            this.cb_moduleTypes.value = this.cb_moduleTypes.dataProvider[0];
            if (args)
            {
                this._forceShowPrismId = args[0];
            }
            else
            {
                this._forceShowPrismId = -1;
            };
            this.updateSubAreas();
        }

        public function unload():void
        {
        }

        public function updateSubAreaLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var sHours:String;
            var sMinutes:String;
            if (!(this._compHookData[componentsRef.lbl_subArea.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lbl_subArea, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.lbl_subArea, "onRollOut");
            };
            this._compHookData[componentsRef.lbl_subArea.name] = data;
            if (!(this._compHookData[componentsRef.tx_type.name]))
            {
                this.uiApi.addComponentHook(componentsRef.tx_type, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.tx_type, "onRollOut");
            };
            this._compHookData[componentsRef.tx_type.name] = data;
            if (!(this._compHookData[componentsRef.lbl_vulneHour.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lbl_vulneHour, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.lbl_vulneHour, "onRollOut");
            };
            this._compHookData[componentsRef.lbl_vulneHour.name] = data;
            if (!(this._compHookData[componentsRef.tx_module.name]))
            {
                this.uiApi.addComponentHook(componentsRef.tx_module, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.tx_module, "onRollOut");
            };
            this._compHookData[componentsRef.tx_module.name] = data;
            if (!(this._compHookData[componentsRef.lbl_state.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lbl_state, "onRollOver");
                this.uiApi.addComponentHook(componentsRef.lbl_state, "onRollOut");
            };
            this._compHookData[componentsRef.lbl_state.name] = data;
            if (!(this._compHookData[componentsRef.lbl_coord.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lbl_coord, "onRelease");
            };
            this._compHookData[componentsRef.lbl_coord.name] = data;
            if (data)
            {
                if (data.isVillage)
                {
                    componentsRef.tx_type.uri = this.uiApi.createUri((this._assetsPath + "tx_villageIcon"));
                }
                else
                {
                    componentsRef.tx_type.uri = this.uiApi.createUri((this._assetsPath + "tx_prismIcon"));
                };
                componentsRef.lbl_subArea.text = data.subAreaName;
                componentsRef.lbl_coord.text = ((data.worldX + ",") + data.worldY);
                componentsRef.lbl_coord.mouseEnabled = true;
                componentsRef.lbl_coord.handCursor = true;
                componentsRef.lbl_nuggets.text = this.utilApi.kamasToString(data.rewardTokenCount, "");
                if (data.modulesItemIds.length > 0)
                {
                    componentsRef.tx_module.visible = true;
                }
                else
                {
                    componentsRef.tx_module.visible = false;
                };
                componentsRef.lbl_state.text = this.uiApi.getText(("ui.prism.state" + data.state));
                sHours = data.timeSlotHour.toString();
                if (sHours.length == 1)
                {
                    sHours = ("0" + sHours);
                };
                sMinutes = (data.timeSlotQuarter * 15).toString();
                if (sMinutes.length == 1)
                {
                    sMinutes = ("0" + sMinutes);
                };
                componentsRef.lbl_vulneHour.text = ((sHours + ":") + sMinutes);
                if ((((((data.state == PrismStateEnum.PRISM_STATE_INVULNERABLE)) || ((data.state == PrismStateEnum.PRISM_STATE_NORMAL)))) && (this.socialApi.hasGuildRight(this.playerApi.id(), "setAlliancePrism"))))
                {
                    componentsRef.btn_setHour.visible = true;
                    if (!(this._compHookData[componentsRef.btn_setHour.name]))
                    {
                        this.uiApi.addComponentHook(componentsRef.btn_setHour, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(componentsRef.btn_setHour, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(componentsRef.btn_setHour, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._compHookData[componentsRef.btn_setHour.name] = data;
                }
                else
                {
                    componentsRef.btn_setHour.visible = false;
                };
                if (data.subAreaId == this._forceShowPrismId)
                {
                    componentsRef.ctr_line.bgColor = this.sysApi.getConfigEntry("colors.grid.over");
                }
                else
                {
                    componentsRef.ctr_line.bgColor = -1;
                };
            }
            else
            {
                componentsRef.tx_type.uri = null;
                componentsRef.lbl_subArea.text = "";
                componentsRef.lbl_coord.text = "";
                componentsRef.lbl_nuggets.text = "";
                componentsRef.lbl_state.text = "";
                componentsRef.lbl_vulneHour.text = "";
                componentsRef.ctr_line.bgColor = -1;
                componentsRef.tx_module.visible = false;
                componentsRef.btn_setHour.visible = false;
            };
        }

        private function updateSubAreas():void
        {
            var prism:PrismSubAreaWrapper;
            var nbZone:int;
            var nbVillage:int;
            var prismsListPostFilter:Array = new Array();
            for each (prism in this._prismsList)
            {
                if (prism.mapId > -1)
                {
                    if (prism.isVillage)
                    {
                        nbVillage++;
                    }
                    else
                    {
                        nbZone++;
                    };
                };
                if (((prism) && (((((prism.modulesItemIds) && ((prism.modulesItemIds.indexOf(this._moduleTypeIdToDisplay) > -1)))) || ((this._moduleTypeIdToDisplay == 0))))))
                {
                    prismsListPostFilter.push(prism);
                };
            };
            if ((((nbZone == 0)) && ((nbVillage == 0))))
            {
                this.lbl_conquestInfo.text = this.uiApi.getText("ui.alliance.noArea");
            }
            else
            {
                if ((((nbZone > 0)) && ((nbVillage == 0))))
                {
                    this.lbl_conquestInfo.text = this.uiApi.processText(this.uiApi.getText("ui.alliance.nbAreas", nbZone), "m", (nbZone == 1));
                }
                else
                {
                    if ((((nbZone == 0)) && ((nbVillage > 0))))
                    {
                        this.lbl_conquestInfo.text = this.uiApi.processText(this.uiApi.getText("ui.alliance.nbVillages", nbVillage), "m", (nbVillage == 1));
                    }
                    else
                    {
                        this.lbl_conquestInfo.text = this.uiApi.processText(this.uiApi.getText("ui.alliance.nbAreasAndVillages", nbZone, nbVillage), "m", (((nbVillage == 1)) && ((nbZone == 1))));
                    };
                };
            };
            this.gd_subAreas.dataProvider = prismsListPostFilter;
            var i:int;
            while (i < prismsListPostFilter.length)
            {
                if (this._forceShowPrismId == prismsListPostFilter[i].subAreaId)
                {
                    this.gd_subAreas.moveTo(i, true);
                    return;
                };
                i++;
            };
        }

        private function setHour(data:Object):void
        {
            this.ctr_setHour.visible = true;
            this._subAreaBeingModified = data.subAreaId;
            var sHours:String = data.timeSlotHour.toString();
            if (sHours.length == 1)
            {
                sHours = ("0" + sHours);
            };
            var sMinutes:String = (data.timeSlotQuarter * 15).toString();
            if (sMinutes.length == 1)
            {
                sMinutes = ("0" + sMinutes);
            };
            var duration:Number = (this.configApi.getServerConstant(SERVER_CONST_KOH_DURATION) as Number);
            this.lbl_prismArea.text = data.subAreaName;
            this.lbl_explanationHour.text = this.uiApi.getText("ui.prism.vulnerabilityHourInfos", ((duration / 1000) / 3600), sHours, sMinutes);
            var index:int = this._txtHours.indexOf(sHours);
            if (index == -1)
            {
                index = 0;
            };
            this.cb_hours.value = this._txtHours[index];
            index = this._txtMinutes.indexOf(sMinutes);
            if (index == -1)
            {
                index = 0;
            };
            this.cb_minutes.value = this._txtMinutes[index];
        }

        private function onPrismsListUpdate(prismModifiedIds:Object):void
        {
            var prismInfo:PrismSubAreaWrapper;
            var alreadyExists:Boolean;
            var id:int;
            var prism:PrismSubAreaWrapper;
            var myAllianceId:int = this.socialApi.getAlliance().allianceId;
            for each (id in prismModifiedIds)
            {
                prismInfo = this.socialApi.getPrismSubAreaById(id);
                if (prismInfo.alliance.allianceId != myAllianceId)
                {
                }
                else
                {
                    alreadyExists = false;
                    for each (prism in this._prismsList)
                    {
                        if (prism.subAreaId == id)
                        {
                            prism = prismInfo;
                            alreadyExists = true;
                        };
                    };
                    if (!(alreadyExists))
                    {
                        this._prismsList.push(prismInfo);
                    };
                };
            };
            this.updateSubAreas();
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:int;
            var _local_6:Object;
            var px:int;
            var py:int;
            this.sysApi.log(2, ("release sur " + target.name));
            switch (target)
            {
                case this.btn_tabType:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("isVillage", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("isVillage", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabSubArea:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("subAreaName", Array.CASEINSENSITIVE);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("subAreaName", (Array.CASEINSENSITIVE | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabCoord:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("worldX", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("worldX", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabModules:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("modulesItemIds");
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("modulesItemIds", Array.DESCENDING);
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabNuggets:
                    this.sysApi.log(2, ("btn_tabNuggets " + this._bDescendingSort));
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("rewardTokenCount", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("rewardTokenCount", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabState:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("state", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("state", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_tabVulneHour:
                    if (this._bDescendingSort)
                    {
                        this.gd_subAreas.sortOn("nextVulnerabilityDate", Array.NUMERIC);
                    }
                    else
                    {
                        this.gd_subAreas.sortOn("nextVulnerabilityDate", (Array.NUMERIC | Array.DESCENDING));
                    };
                    this._bDescendingSort = !(this._bDescendingSort);
                    break;
                case this.btn_close:
                case this.btn_undo:
                    this.ctr_setHour.visible = false;
                    this._subAreaBeingModified = -1;
                    break;
                case this.btn_save:
                    _local_2 = this.timeApi.getTimezoneOffset();
                    _local_3 = (((_local_2 / 1000) * 60) % 60);
                    _local_4 = ((_local_2 / ((1000 * 60) * 60)) % 24);
                    _local_5 = (((this.cb_hours.selectedIndex - _local_4) * 4) + ((this.cb_minutes.selectedIndex - _local_3) * 2));
                    if (_local_5 < 0)
                    {
                        _local_5 = (_local_5 + 96);
                    };
                    this._quartersNumber = _local_5;
                    if (this._subAreaBeingModified > -1)
                    {
                        this.sysApi.sendAction(new PrismSettingsRequest(this._subAreaBeingModified, this._quartersNumber));
                    };
                    this.ctr_setHour.visible = false;
                    this._subAreaBeingModified = -1;
                    break;
                default:
                    if (target.name.indexOf("lbl_coord") != -1)
                    {
                        _local_6 = this._compHookData[target.name];
                        px = _local_6.worldX;
                        py = _local_6.worldY;
                        this.sysApi.dispatchHook(AddMapFlag, ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_PVP_SEEK) + "_pos_") + px) + "_") + py), (((((px + ",") + py) + " (") + this.uiApi.getText("ui.zaap.prism")) + ")"), this.mapApi.getCurrentWorldMap().id, px, py, 0xFF0000, true);
                    }
                    else
                    {
                        if (target.name.indexOf("btn_setHour") != -1)
                        {
                            _local_6 = this._compHookData[target.name];
                            this.setHour(_local_6);
                        };
                    };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.cb_moduleTypes:
                    this._moduleTypeIdToDisplay = this.cb_moduleTypes.selectedItem.id;
                    this.updateSubAreas();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:PrismSubAreaWrapper;
            var date:Date;
            var isVillage:Boolean;
            var localDate:Date;
            var hours:String;
            var minutes:String;
            var localHours:String;
            var localMinutes:String;
            var remainingTime:Number;
            var itemw:ItemWrapper;
            var id:int;
            var point:uint = 7;
            var relPoint:uint = 1;
            if (target.name.indexOf("tx_type") != -1)
            {
                isVillage = this._compHookData[target.name].isVillage;
                if (isVillage)
                {
                    tooltipText = this.uiApi.getText("ui.zaap.village");
                }
                else
                {
                    tooltipText = this.uiApi.getText("ui.zaap.prism");
                };
            }
            else
            {
                if (target.name.indexOf("btn_setHour") != -1)
                {
                    tooltipText = this.uiApi.getText("ui.prism.changeVulnerabilityHour");
                }
                else
                {
                    if (target.name.indexOf("lbl_vulneHour") != -1)
                    {
                        data = this._compHookData[target.name];
                        if (((!(data)) || ((((data.lastTimeSlotModificationAuthorName == "?")) && ((data.lastTimeSlotModificationAuthorGuildId == 0))))))
                        {
                            return;
                        };
                        if (((!(this.socialApi.getGuildByid(data.lastTimeSlotModificationAuthorGuildId))) || (!(this.socialApi.getGuildByid(data.lastTimeSlotModificationAuthorGuildId).guildName))))
                        {
                            tooltipText = this.uiApi.getText("ui.prism.lastVulnerabilityChange", this.timeApi.getDate((data.lastTimeSlotModificationDate * 1000), true));
                        }
                        else
                        {
                            tooltipText = this.uiApi.getText("ui.prism.lastVulnerabilityChangeBy", this.timeApi.getDate((data.lastTimeSlotModificationDate * 1000), true), data.lastTimeSlotModificationAuthorName, this.socialApi.getGuildByid(data.lastTimeSlotModificationAuthorGuildId).guildName);
                        };
                        date = new Date(((data.nextVulnerabilityDate * 1000) + this.timeApi.getTimezoneOffset()));
                        localDate = new Date((data.nextVulnerabilityDate * 1000));
                        hours = date.getUTCHours().toString();
                        if (hours.length == 1)
                        {
                            hours = ("0" + hours);
                        };
                        minutes = date.getUTCMinutes().toString();
                        if (minutes.length == 1)
                        {
                            minutes = ("0" + minutes);
                        };
                        localHours = localDate.getHours().toString();
                        if (localHours.length == 1)
                        {
                            localHours = ("0" + localHours);
                        };
                        localMinutes = localDate.getMinutes().toString();
                        if (localMinutes.length == 1)
                        {
                            localMinutes = ("0" + localMinutes);
                        };
                        tooltipText = (tooltipText + ((((("\n" + this.uiApi.getText("ui.prism.serverVulnerabilityHour")) + this.uiApi.getText("ui.common.colon")) + hours) + ":") + minutes));
                        tooltipText = (tooltipText + ((((("\n" + this.uiApi.getText("ui.prism.localVulnerabilityHour")) + this.uiApi.getText("ui.common.colon")) + localHours) + ":") + localMinutes));
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_state") != -1)
                        {
                            data = this._compHookData[target.name];
                            if (data)
                            {
                                date = new Date();
                                remainingTime = ((data.nextVulnerabilityDate * 1000) - date.time);
                                if ((((data.state == PrismStateEnum.PRISM_STATE_WEAKENED)) || ((data.state == PrismStateEnum.PRISM_STATE_SABOTAGED))))
                                {
                                    tooltipText = this.uiApi.getText(("ui.prism.stateInfos" + data.state), this.timeApi.getDuration(remainingTime));
                                }
                                else
                                {
                                    tooltipText = this.uiApi.getText(("ui.prism.stateInfos" + data.state));
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("tx_module") != -1)
                            {
                                data = this._compHookData[target.name];
                                if (((data) && ((data.modulesItemIds.length > 0))))
                                {
                                    tooltipText = "";
                                    for each (id in data.modulesItemIds)
                                    {
                                        itemw = this.dataApi.getItemWrapper(id, 0, 0, 1);
                                        tooltipText = (tooltipText + (itemw.name + "\n"));
                                    };
                                    tooltipText = tooltipText.substr(0, (tooltipText.length - 1));
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("lbl_subArea") != -1)
                                {
                                    data = this._compHookData[target.name];
                                    if (data)
                                    {
                                        tooltipText = ((this.uiApi.getText("ui.social.guild.taxStartDate") + this.uiApi.getText("ui.common.colon")) + this.timeApi.getDate((data.placementDate * 1000)));
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (tooltipText)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}//package ui

