﻿package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.QuestApi;
    import d2api.DataApi;
    import d2api.BindsApi;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import d2components.Grid;
    import d2hooks.FoldAll;
    import d2hooks.TreasureHuntUpdate;
    import d2hooks.TreasureHuntFinished;
    import d2hooks.TreasureHuntAvailableRetryCountUpdate;
    import d2hooks.FlagRemoved;
    import d2enums.ComponentHookList;
    import d2data.TreasureHuntWrapper;
    import d2enums.TreasureHuntStepTypeEnum;
    import d2enums.BuildTypeEnum;
    import d2data.MapPosition;
    import d2hooks.RemoveMapFlag;
    import d2hooks.AddMapFlag;
    import d2actions.TreasureHuntDigRequest;
    import d2enums.TreasureHuntFlagStateEnum;
    import d2actions.TreasureHuntFlagRequest;
    import d2actions.TreasureHuntFlagRemoveRequest;
    import d2actions.TreasureHuntGiveUpRequest;
    import d2hooks.*;
    import d2actions.*;

    public class TreasureHunt 
    {

        private static const NB_MAX_LINE:int = 9;
        private static var _shortcutColor:String;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var questApi:QuestApi;
        public var dataApi:DataApi;
        public var bindsApi:BindsApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _hidden:Boolean = true;
        private var _foldStatus:Boolean;
        private var _compHookData:Dictionary;
        private var _huntType:int = -1;
        private var _huntTypes:Array;
        private var _treasureHunts:Array;
        private var _txBgHeight:int;
        private var _ctrBottomY:int;
        private var _gdLineHeight:int;
        private var _ctrCurrentPosition:Point;
        private var _ctrLastPosition:Point;
        private var _ctrStartPosition:Point;
        private var _currentLocNames:Array;
        public var btn_arrowMaximize:ButtonContainer;
        public var btn_arrowMinimize:ButtonContainer;
        public var ctr_hunt:GraphicContainer;
        public var ctr_bottom:GraphicContainer;
        public var tx_bg:Texture;
        public var tx_title:Texture;
        public var tx_help:Texture;
        public var btn_huntType:ButtonContainer;
        public var btn_giveUp:ButtonContainer;
        public var lbl_huntType:Label;
        public var lbl_steps:Label;
        public var lbl_try:Label;
        public var gd_steps:Grid;

        public function TreasureHunt()
        {
            this._compHookData = new Dictionary(true);
            this._huntTypes = new Array();
            this._treasureHunts = new Array();
            super();
        }

        public function main(param:Object):void
        {
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this.sysApi.addHook(TreasureHuntUpdate, this.onTreasureHunt);
            this.sysApi.addHook(TreasureHuntFinished, this.onTreasureHuntFinished);
            this.sysApi.addHook(TreasureHuntAvailableRetryCountUpdate, this.onTreasureHuntAvailableRetryCountUpdate);
            this.sysApi.addHook(FlagRemoved, this.onFlagRemoved);
            this.uiApi.addComponentHook(this.tx_help, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_help, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_giveUp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_giveUp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_arrowMinimize, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_arrowMinimize, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_PRESS);
            this.uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_RELEASE_OUTSIDE);
            this.uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_title, ComponentHookList.ON_DOUBLE_CLICK);
            this._currentLocNames = new Array();
            this._hidden = false;
            this.ctr_hunt.visible = true;
            this.btn_arrowMaximize.visible = false;
            this._huntType = (param as int);
            this._huntTypes.push(this._huntType);
            this._currentLocNames[this._huntType] = "";
            this._treasureHunts[this._huntType] = this.questApi.getTreasureHunt(this._huntType);
            this._txBgHeight = this.tx_bg.height;
            this._ctrBottomY = this.ctr_bottom.y;
            this._gdLineHeight = this.gd_steps.slotHeight;
            this._ctrCurrentPosition = new Point(this.ctr_hunt.x, this.ctr_hunt.y);
            this._ctrLastPosition = this._ctrCurrentPosition.clone();
            this._ctrStartPosition = this._ctrCurrentPosition.clone();
            this.updateHuntDisplay(this._huntType, true);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function updateStepLine(data:*, components:*, selected:Boolean):void
        {
            var th:TreasureHuntWrapper;
            if (!(this._compHookData[components.ctr_step.name]))
            {
                this.uiApi.addComponentHook(components.ctr_step, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.ctr_step, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.ctr_step.name] = data;
            if (!(this._compHookData[components.btn_loc.name]))
            {
                this.uiApi.addComponentHook(components.btn_loc, ComponentHookList.ON_RELEASE);
            };
            this._compHookData[components.btn_loc.name] = data;
            if (!(this._compHookData[components.btn_pictos.name]))
            {
                this.uiApi.addComponentHook(components.btn_pictos, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_pictos, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_pictos, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.btn_pictos.name] = data;
            if (!(this._compHookData[components.btn_dig.name]))
            {
                this.uiApi.addComponentHook(components.btn_dig, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_dig, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_dig, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.btn_dig.name] = data;
            if (!(this._compHookData[components.btn_digFight.name]))
            {
                this.uiApi.addComponentHook(components.btn_digFight, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_digFight, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_digFight, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.btn_digFight.name] = data;
            if (!(this._compHookData[components.tx_flag.name]))
            {
                this.uiApi.addComponentHook(components.tx_flag, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.tx_flag, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.tx_flag, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.tx_flag.name] = data;
            if (data != null)
            {
                components.btn_digFight.visible = false;
                components.lbl_text.text = data.text;
                components.btn_pictos.visible = false;
                if (data.type == TreasureHuntStepTypeEnum.START)
                {
                    components.btn_loc.visible = true;
                    components.tx_direction.uri = null;
                    components.btn_dig.visible = false;
                    components.tx_flag.visible = false;
                    if ((((this._currentLocNames[this._huntType] == "")) && (components.btn_loc.selected)))
                    {
                        components.btn_loc.selected = false;
                    }
                    else
                    {
                        if (((!((this._currentLocNames[this._huntType] == ""))) && (!(components.btn_loc.selected))))
                        {
                            components.btn_loc.selected = true;
                        };
                    };
                }
                else
                {
                    if ((((((data.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI)) || ((data.type == TreasureHuntStepTypeEnum.DIRECTION)))) || ((data.type == TreasureHuntStepTypeEnum.DIRECTION_TO_HINT))))
                    {
                        components.btn_loc.visible = false;
                        components.tx_direction.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("assets") + "tx_arrow") + data.direction));
                        components.btn_dig.visible = false;
                        components.tx_flag.visible = true;
                        if (data.mapId != 0)
                        {
                            components.tx_flag.gotoAndStop = (data.flagState + 2);
                        }
                        else
                        {
                            components.tx_flag.gotoAndStop = 1;
                        };
                        if ((((this.sysApi.getBuildType() >= BuildTypeEnum.TESTING)) && ((data.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI))))
                        {
                            components.btn_pictos.visible = true;
                        };
                    }
                    else
                    {
                        if (data.type == TreasureHuntStepTypeEnum.FIGHT)
                        {
                            components.btn_loc.visible = false;
                            components.tx_direction.uri = null;
                            components.tx_flag.visible = false;
                            th = this._treasureHunts[this._huntType];
                            if ((th.checkPointCurrent + 1) != th.checkPointTotal)
                            {
                                components.btn_dig.visible = true;
                                components.btn_digFight.visible = false;
                            }
                            else
                            {
                                components.btn_dig.visible = false;
                                components.btn_digFight.visible = true;
                            };
                        }
                        else
                        {
                            if (data.type == TreasureHuntStepTypeEnum.UNKNOWN)
                            {
                                components.tx_direction.uri = null;
                                components.btn_loc.visible = false;
                                components.tx_flag.visible = false;
                                components.btn_dig.visible = false;
                                components.btn_digFight.visible = false;
                            };
                        };
                    };
                };
            }
            else
            {
                components.lbl_text.text = "";
                components.tx_direction.uri = null;
                components.btn_loc.visible = false;
                components.btn_pictos.visible = false;
                components.btn_digFight.visible = false;
                components.tx_flag.visible = false;
            };
        }

        private function showTypeMenu():void
        {
            var current:Boolean;
            var type:int;
            var contextMenu:Array = new Array();
            contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.treasureHunt.type")));
            for each (type in this._huntTypes)
            {
                if (this._huntType == type)
                {
                    current = true;
                }
                else
                {
                    current = false;
                };
                contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText(("ui.treasureHunt.huntType" + type)), this.updateHuntDisplay, [type], false, null, current, true));
            };
            this.modContextMenu.createContextMenu(contextMenu);
        }

        private function updateHuntDisplay(type:int, force:Boolean=false):void
        {
            var th:TreasureHuntWrapper;
            var oldLinesNumber:int;
            var newLinesNumber:int;
            var nbLineToRemove:int;
            if (((!((this._huntType == type))) || (force)))
            {
                this._huntType = type;
                this.lbl_huntType.text = this.uiApi.getText(("ui.treasureHunt.huntType" + type));
                if (this._treasureHunts[this._huntType])
                {
                    th = this._treasureHunts[this._huntType];
                    this.lbl_steps.text = this.uiApi.getText("ui.common.step", (th.checkPointCurrent + 1), th.checkPointTotal);
                    if (th.availableRetryCount == -1)
                    {
                        this.lbl_try.text = this.uiApi.getText("ui.treasureHunt.infiniteTry");
                    }
                    else
                    {
                        if (th.availableRetryCount > 0)
                        {
                            this.lbl_try.text = this.uiApi.processText(this.uiApi.getText("ui.treasureHunt.tryLeft", th.availableRetryCount), "", (th.availableRetryCount == 1));
                        };
                    };
                    oldLinesNumber = this.gd_steps.dataProvider.length;
                    newLinesNumber = th.stepList.length;
                    if (oldLinesNumber != newLinesNumber)
                    {
                        if (newLinesNumber < NB_MAX_LINE)
                        {
                            nbLineToRemove = (NB_MAX_LINE - newLinesNumber);
                            this.tx_bg.height = (this._txBgHeight - (nbLineToRemove * this._gdLineHeight));
                            this.ctr_bottom.y = (this._ctrBottomY - (nbLineToRemove * this._gdLineHeight));
                            this.gd_steps.height = (newLinesNumber * this._gdLineHeight);
                        };
                        this.uiApi.me().render();
                    };
                    this.gd_steps.dataProvider = th.stepList;
                };
            };
        }

        private function stopDragUi():void
        {
            this.ctr_hunt.stopDrag();
            var stageWidth:int = this.uiApi.getStageWidth();
            var stageHeight:int = (this.uiApi.getStageHeight() - 150);
            if (this.ctr_hunt.x < 0)
            {
                this.ctr_hunt.x = 0;
            }
            else
            {
                if ((this.ctr_hunt.x + this.ctr_hunt.width) > stageWidth)
                {
                    this.ctr_hunt.x = (stageWidth - this.ctr_hunt.width);
                };
            };
            if (this.ctr_hunt.y < 0)
            {
                this.ctr_hunt.y = 0;
            }
            else
            {
                if ((this.ctr_hunt.y + this.ctr_hunt.height) > stageHeight)
                {
                    this.ctr_hunt.y = (stageHeight - this.ctr_hunt.height);
                };
            };
            this._ctrLastPosition.x = int(this.ctr_hunt.x);
            this._ctrLastPosition.y = int(this.ctr_hunt.y);
        }

        private function onTreasureHunt(treasureHuntType:uint):void
        {
            var p:MapPosition;
            var newTrHunt:Object = this.questApi.getTreasureHunt(treasureHuntType);
            if (((((((this._treasureHunts[treasureHuntType]) && (this._currentLocNames[treasureHuntType]))) && (!((this._currentLocNames[treasureHuntType] == ""))))) && (!((this._treasureHunts[treasureHuntType].checkPointCurrent == newTrHunt.checkPointCurrent)))))
            {
                p = this.dataApi.getMapInfo(this._treasureHunts[treasureHuntType].stepList[0].mapId);
                this.sysApi.dispatchHook(RemoveMapFlag, this._currentLocNames[treasureHuntType], p.worldMap);
                this._currentLocNames[treasureHuntType] = "";
            };
            this._treasureHunts[treasureHuntType] = newTrHunt;
            if (this._huntTypes.indexOf(treasureHuntType) == -1)
            {
                this._huntTypes.push(treasureHuntType);
                this._currentLocNames[treasureHuntType] = "";
            };
            this.updateHuntDisplay(treasureHuntType, true);
        }

        private function onTreasureHuntFinished(treasureHuntType:uint):void
        {
            var p:MapPosition;
            if (this._currentLocNames[treasureHuntType] != "")
            {
                p = this.dataApi.getMapInfo(this._treasureHunts[treasureHuntType].stepList[0].mapId);
                this.sysApi.dispatchHook(RemoveMapFlag, this._currentLocNames[treasureHuntType], p.worldMap);
                this._currentLocNames[treasureHuntType] = "";
            };
            this._treasureHunts[treasureHuntType] = null;
            delete this._treasureHunts[treasureHuntType];
            var index:int = this._huntTypes.indexOf(treasureHuntType);
            this._huntTypes.splice(index, 1);
            if (treasureHuntType == this._huntType)
            {
                if (this._huntTypes.length > 0)
                {
                    this.updateHuntDisplay(this._huntTypes[0]);
                }
                else
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        private function onTreasureHuntAvailableRetryCountUpdate(treasureHuntType:uint, availableRetryCount:int):void
        {
            this._treasureHunts[treasureHuntType] = this.questApi.getTreasureHunt(treasureHuntType);
            if (availableRetryCount == -1)
            {
                this.lbl_try.text = this.uiApi.getText("ui.treasureHunt.infiniteTry");
            }
            else
            {
                if (availableRetryCount > 0)
                {
                    this.lbl_try.text = this.uiApi.processText(this.uiApi.getText("ui.treasureHunt.tryLeft", availableRetryCount), "", (availableRetryCount == 1));
                };
            };
        }

        private function onFlagRemoved(flagId:String, worldmapId:int):void
        {
            if (flagId.indexOf((("flag_teleportPoint_" + this._huntType) + "_")) == 0)
            {
                this._currentLocNames[this._huntType] = "";
                this.gd_steps.updateItem(0);
            };
        }

        public function onRelease(target:Object):void
        {
            var p:MapPosition;
            var flagId:String;
            switch (target)
            {
                case this.btn_arrowMinimize:
                    this._hidden = true;
                    this.ctr_hunt.visible = false;
                    this.btn_arrowMaximize.visible = true;
                    break;
                case this.btn_arrowMaximize:
                    this._hidden = false;
                    this.ctr_hunt.visible = true;
                    this.btn_arrowMaximize.visible = false;
                    break;
                case this.btn_huntType:
                    this.showTypeMenu();
                    break;
                case this.tx_title:
                    this.stopDragUi();
                    break;
                case this.btn_giveUp:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.treasureHunt.giveUpConfirm"), [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupGiveUp, this.onPopupClose], this.onPopupGiveUp, this.onPopupClose);
                    break;
                default:
                    if (target.name.indexOf("btn_loc") != -1)
                    {
                        p = this.dataApi.getMapInfo(this._compHookData[target.name].mapId);
                        flagId = ((("flag_teleportPoint_" + this._huntType) + "_") + this._compHookData[target.name].mapId);
                        if (this._currentLocNames[this._huntType] == flagId)
                        {
                            target.selected = false;
                            this._currentLocNames[this._huntType] = "";
                        }
                        else
                        {
                            target.selected = true;
                            this._currentLocNames[this._huntType] = flagId;
                        };
                        this.sysApi.dispatchHook(AddMapFlag, flagId, (((((this.uiApi.getText(("ui.treasureHunt.huntType" + this._huntType)) + " [") + p.posX) + ",") + p.posY) + "]"), p.worldMap, p.posX, p.posY, 15636787, true);
                    }
                    else
                    {
                        if (target.name.indexOf("btn_pictos") != -1)
                        {
                            if (this.sysApi.getBuildType() >= BuildTypeEnum.INTERNAL)
                            {
                                this.sysApi.goToUrl(("http://utils.dofus.lan/viewPOIFromLabelId.php?labelIds=" + this._compHookData[target.name].poiLabel));
                            }
                            else
                            {
                                if (this.sysApi.getBuildType() == BuildTypeEnum.TESTING)
                                {
                                    this.sysApi.goToUrl(("http://utils.dofus.lan/viewPOIFromLabelId.php?fromDb=1&labelIds=" + this._compHookData[target.name].poiLabel));
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("btn_dig") != -1)
                            {
                                this.sysApi.sendAction(new TreasureHuntDigRequest(this._huntType));
                            }
                            else
                            {
                                if (target.name.indexOf("tx_flag") != -1)
                                {
                                    this.sysApi.log(2, ((("clic sur flag " + this._compHookData[target.name].index) + " : ") + this._compHookData[target.name].flagState));
                                    if ((((this._compHookData[target.name].flagState == -1)) || ((this._compHookData[target.name].flagState == TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_WRONG))))
                                    {
                                        this.sysApi.sendAction(new TreasureHuntFlagRequest(this._huntType, this._compHookData[target.name].index));
                                    }
                                    else
                                    {
                                        if (this._compHookData[target.name].flagState == TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_UNKNOWN)
                                        {
                                            this.sysApi.sendAction(new TreasureHuntFlagRemoveRequest(this._huntType, this._compHookData[target.name].index));
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
        }

        public function onPress(target:Object):void
        {
            switch (target)
            {
                case this.tx_title:
                    this._ctrLastPosition.x = int(this.ctr_hunt.x);
                    this._ctrLastPosition.y = int(this.ctr_hunt.y);
                    this.ctr_hunt.startDrag();
                    break;
            };
        }

        public function onDoubleClick(target:Object):void
        {
            switch (target)
            {
                case this.tx_title:
                    this.ctr_hunt.stopDrag();
                    this.ctr_hunt.x = this._ctrStartPosition.x;
                    this.ctr_hunt.y = this._ctrStartPosition.y;
                    break;
            };
        }

        public function onReleaseOutside(target:Object):void
        {
            switch (target)
            {
                case this.tx_title:
                    this.stopDragUi();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var bind:String;
            var th:TreasureHuntWrapper;
            var point:uint = 6;
            var relPoint:uint;
            if (target == this.btn_giveUp)
            {
                tooltipText = this.uiApi.getText("ui.fight.option.giveUp");
            };
            if (target == this.btn_arrowMinimize)
            {
                tooltipText = ((this.uiApi.getText("ui.tooltip.foldUi") + " (") + this.uiApi.getText("ui.shortcuts.foldAll"));
                bind = this.bindsApi.getShortcutBindStr("foldAll");
                if (bind)
                {
                    if (!(_shortcutColor))
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    tooltipText = (tooltipText + ((((" <font color='" + _shortcutColor) + "'>(") + bind) + ")</font>"));
                };
                tooltipText = (tooltipText + ")");
            }
            else
            {
                if (target == this.tx_help)
                {
                    tooltipText = this.uiApi.getText("ui.treasureHunt.help");
                }
                else
                {
                    if (target.name.indexOf("ctr_step") != -1)
                    {
                        data = this._compHookData[target.name];
                        if (!(data))
                        {
                            return;
                        };
                        tooltipText = data.overText;
                    }
                    else
                    {
                        if (target.name.indexOf("btn_pictos") != -1)
                        {
                            data = this._compHookData[target.name];
                            if (!(data))
                            {
                                return;
                            };
                            tooltipText = (("Voir les pictos pour " + data.poiLabel) + " (testing/local only)");
                        }
                        else
                        {
                            if (target.name.indexOf("tx_flag") != -1)
                            {
                                data = this._compHookData[target.name];
                                if (!(data))
                                {
                                    return;
                                };
                                if (data.flagState == -1)
                                {
                                    tooltipText = this.uiApi.getText("ui.treasureHunt.flagStatePut");
                                }
                                else
                                {
                                    if (data.flagState == TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_UNKNOWN)
                                    {
                                        tooltipText = this.uiApi.getText("ui.treasureHunt.flagStateRemove");
                                    }
                                    else
                                    {
                                        if (data.flagState == TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_WRONG)
                                        {
                                            tooltipText = this.uiApi.getText("ui.treasureHunt.flagStateReplace");
                                        }
                                        else
                                        {
                                            if (data.flagState == TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_OK)
                                            {
                                                tooltipText = this.uiApi.getText("ui.treasureHunt.flagStateCorrect");
                                            };
                                        };
                                    };
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("btn_dig") != -1)
                                {
                                    data = this._compHookData[target.name];
                                    if (!(data))
                                    {
                                        return;
                                    };
                                    th = this._treasureHunts[this._huntType];
                                    if ((th.checkPointCurrent + 1) == th.checkPointTotal)
                                    {
                                        tooltipText = this.uiApi.getText("ui.treasureHunt.searchHereForTreasure");
                                    }
                                    else
                                    {
                                        tooltipText = this.uiApi.getText("ui.treasureHunt.searchHereForNextStep");
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

        private function onFoldAll(fold:Boolean):void
        {
            if (fold)
            {
                this._foldStatus = !(this._hidden);
                this._hidden = true;
                this.ctr_hunt.visible = false;
                this.btn_arrowMaximize.visible = true;
            }
            else
            {
                this._hidden = !(this._foldStatus);
                this.ctr_hunt.visible = this._foldStatus;
                this.btn_arrowMaximize.visible = !(this._foldStatus);
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupGiveUp():void
        {
            this.sysApi.sendAction(new TreasureHuntGiveUpRequest(this._huntType));
        }


    }
}//package ui

