package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.UtilApi;
    import d2data.EmblemWrapper;
    import d2components.Texture;
    import d2components.Input;
    import d2components.Grid;
    import d2components.ComboBox;
    import d2components.ColorPicker;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2data.EmblemSymbolCategory;
    import d2hooks.GuildCreationResult;
    import d2hooks.UiLoaded;
    import d2hooks.LeaveDialog;
    import d2enums.ComponentHookList;
    import d2enums.ProtocolConstantsEnum;
    import d2data.EmblemSymbol;
    import d2data.GuildWrapper;
    import d2actions.LeaveDialog;
    import d2actions.GuildCreationValid;
    import d2actions.GuildModificationNameValid;
    import d2actions.GuildModificationEmblemValid;
    import d2actions.GuildModificationValid;
    import d2enums.SocialGroupCreationResultEnum;
    import d2enums.SelectMethodEnum;
    import d2hooks.*;
    import d2actions.*;

    public class GuildCreator 
    {

        public static const CREATION:uint = 0;
        public static const NAME_MODIFICATION:uint = 1;
        public static const EMBLEM_MODIFICATION:uint = 2;
        public static const MODIFICATION:uint = 3;
        public static const EMBLEM_TAB_ICON:uint = 0;
        public static const EMBLEM_TAB_BACKGROUND:uint = 1;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var utilApi:UtilApi;
        private var _mode:uint = 0;
        private var _nCurrentTab:int = -1;
        private var _emblemList:Object;
        private var _background:Object;
        private var _backgroundIdx:uint;
        private var _backgroundColor:uint;
        private var _icon:EmblemWrapper;
        private var _iconIdx:uint;
        private var _iconColor:uint;
        private var _stickEmblem:Boolean = false;
        private var _iconCategories:Array;
        private var _currentIconCat:Object;
        private var _emblemsHash:String;
        public var tx_emblem:Texture;
        public var tx_icon:Texture;
        public var inp_guildname:Input;
        public var gd_emblemBack:Grid;
        public var gd_emblemFront:Grid;
        public var cbb_emblemCategory:ComboBox;
        public var cp_colorPk:ColorPicker;
        public var btn_create:ButtonContainer;
        public var btn_background:ButtonContainer;
        public var btn_icon:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var tx_nameRules:Texture;
        public var mainCtr:GraphicContainer;
        public var guildNameCtr:GraphicContainer;
        public var emblemCreatorCtr:GraphicContainer;
        public var ctr_hexaColor:GraphicContainer;
        public var inp_hexaValue:Input;
        public var btn_hexaOk:ButtonContainer;

        public function GuildCreator()
        {
            this._iconCategories = new Array();
            super();
        }

        public function get mode():uint
        {
            return (this._mode);
        }

        public function set mode(v:uint):void
        {
            this._mode = v;
            this.refreshUIMode();
        }

        public function main(... args):void
        {
            var emblemCat:EmblemSymbolCategory;
            this.sysApi.addHook(GuildCreationResult, this.onGuildCreationResult);
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            this.sysApi.addHook(LeaveDialog, this.onLeaveDialog);
            this.uiApi.addComponentHook(this.tx_emblem, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.gd_emblemBack, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_emblemFront, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cbb_emblemCategory, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cp_colorPk, "onColorChange");
            this.uiApi.addComponentHook(this.cp_colorPk, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_create, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_background, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_icon, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_nameRules, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_nameRules, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.ctr_hexaColor.visible = false;
            if (args[0][0])
            {
                if (args[0][1])
                {
                    this._mode = MODIFICATION;
                }
                else
                {
                    this._mode = NAME_MODIFICATION;
                };
            }
            else
            {
                if (args[0][1])
                {
                    this._mode = EMBLEM_MODIFICATION;
                }
                else
                {
                    this._mode = CREATION;
                };
            };
            this.gd_emblemBack.visible = true;
            this.gd_emblemBack.disabled = false;
            this.gd_emblemFront.visible = false;
            this.tx_emblem.dispatchMessages = true;
            this._emblemList = this.dataApi.getEmblems();
            this.inp_guildname.maxChars = ProtocolConstantsEnum.MAX_GUILDNAME_LEN;
            var esc:Object = this.dataApi.getAllEmblemSymbolCategories();
            var allowedCategories:int = this.socialApi.getAllowedGuildEmblemSymbolCategories();
            for each (emblemCat in esc)
            {
                if ((allowedCategories & Math.pow(2, (emblemCat.id - 1))))
                {
                    this._iconCategories.push({
                        "label":emblemCat.name,
                        "value":emblemCat.id
                    });
                };
            };
            this.cbb_emblemCategory.dataProvider = this._iconCategories;
            this._currentIconCat = this._iconCategories[0];
        }

        public function unload():void
        {
        }

        public function selectBackground(item:Object, updateGrid:Boolean):void
        {
            if (item != null)
            {
                if (((updateGrid) && ((this._nCurrentTab == EMBLEM_TAB_BACKGROUND))))
                {
                    this.gd_emblemBack.selectedItem = item;
                };
                this._background = item;
                this.tx_emblem.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "back/") + item.iconUri.fileName.split(".")[0]) + ".swf"));
            };
        }

        public function selectIcon(item:EmblemWrapper, updateGrid:Boolean):void
        {
            var icon:EmblemSymbol;
            if (item != null)
            {
                if (((updateGrid) && ((this._nCurrentTab == EMBLEM_TAB_ICON))))
                {
                    this.gd_emblemFront.selectedItem = item;
                };
                this._icon = item;
                this.tx_icon.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "up/") + item.iconUri.fileName.split(".")[0]) + ".swf"));
                icon = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
                if (icon.colorizable)
                {
                    this.utilApi.changeColor(this.tx_icon, this._iconColor, 0);
                }
                else
                {
                    this.utilApi.changeColor(this.tx_icon, this._iconColor, 0, true);
                };
            };
        }

        public function getCurrentTab():int
        {
            return (this._nCurrentTab);
        }

        private function refreshUIMode():void
        {
            switch (this._mode)
            {
                case CREATION:
                    this.guildNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    this.randomEmblem();
                    break;
                case NAME_MODIFICATION:
                    this.guildNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = true;
                    break;
                case EMBLEM_MODIFICATION:
                    this.guildNameCtr.disabled = true;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    break;
                case MODIFICATION:
                    this.guildNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    break;
            };
            this.updateLogoFromPlayerGuild();
            this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
            this.uiApi.me().render();
        }

        private function updateLogoFromPlayerGuild():void
        {
            var guild:GuildWrapper;
            if (this.socialApi.hasGuild())
            {
                guild = this.socialApi.getGuild();
                if (!(this.socialApi.isGuildNameInvalid()))
                {
                    this.inp_guildname.text = guild.guildName;
                };
                this._background = guild.backEmblem;
                this.tx_emblem.uri = this._background.fullSizeIconUri;
                this._backgroundColor = this._background.color;
                this._icon = guild.upEmblem;
                this.tx_icon.uri = this._icon.fullSizeIconUri;
                this._iconColor = this._icon.color;
                this.setIconColor(this._iconColor);
            };
        }

        private function randomEmblem():void
        {
            var rnd:int;
            rnd = Math.floor((Math.random() * this._emblemList[EMBLEM_TAB_BACKGROUND].length));
            this.selectBackground(this._emblemList[EMBLEM_TAB_BACKGROUND][rnd], false);
            this.setBackgroundColor((Math.random() * 0xFFFFFF));
            rnd = Math.floor((Math.random() * this._emblemList[EMBLEM_TAB_ICON].length));
            this.selectIcon(this._emblemList[EMBLEM_TAB_ICON][rnd], false);
            this.setIconColor((Math.random() * 0xFFFFFF));
        }

        private function openSelectedTab(tab:int):void
        {
            var cat:Object;
            if (this._nCurrentTab == tab)
            {
                return;
            };
            this._nCurrentTab = tab;
            this._stickEmblem = true;
            switch (tab)
            {
                case EMBLEM_TAB_ICON:
                    if (this.gd_emblemFront.dataProvider.length == 0)
                    {
                        if (this._icon)
                        {
                            for each (cat in this._iconCategories)
                            {
                                if (this._icon.category == cat.value)
                                {
                                    this._currentIconCat = cat;
                                    this.cbb_emblemCategory.selectedItem = this._currentIconCat;
                                };
                            };
                        };
                        this.updateIconGrid();
                        this.gd_emblemFront.selectedItem = this._icon;
                    };
                    this.gd_emblemBack.visible = false;
                    this.gd_emblemFront.visible = true;
                    this.cbb_emblemCategory.visible = true;
                    this.cp_colorPk.color = this._iconColor;
                    break;
                case EMBLEM_TAB_BACKGROUND:
                    if (this.gd_emblemBack.dataProvider.length == 0)
                    {
                        this.gd_emblemBack.dataProvider = this._emblemList[EMBLEM_TAB_BACKGROUND];
                        this.gd_emblemBack.selectedItem = this._background;
                    };
                    this.gd_emblemBack.visible = true;
                    this.gd_emblemFront.visible = false;
                    this.cbb_emblemCategory.visible = false;
                    this.cp_colorPk.color = this._backgroundColor;
                    break;
            };
            this._stickEmblem = false;
        }

        private function setBackgroundColor(color:Number):void
        {
            this._backgroundColor = color;
            if (((((((((this.tx_emblem) && (this.tx_emblem.uri))) && (this.tx_emblem.child))) && (this.tx_emblem.child.hasOwnProperty("back")))) && (this.tx_emblem.child.back)))
            {
                this.utilApi.changeColor(this.tx_emblem.getChildByName("back"), this._backgroundColor, 1);
            };
        }

        private function setIconColor(color:Number):void
        {
            var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
            this._iconColor = color;
            if (icon.colorizable)
            {
                this.utilApi.changeColor(this.tx_icon, this._iconColor, 0);
            }
            else
            {
                this.utilApi.changeColor(this.tx_icon, this._iconColor, 0, true);
            };
        }

        private function _unloadGuildCreation():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        private function updateIconGrid():void
        {
            var emblem:EmblemWrapper;
            var DP:Array = new Array();
            var hash:String = "";
            for each (emblem in this._emblemList[EMBLEM_TAB_ICON])
            {
                if ((((emblem.category == this._currentIconCat.value)) || ((this._currentIconCat.value == uint.MAX_VALUE))))
                {
                    DP.push(emblem);
                    hash = (hash + (emblem.idEmblem + "-"));
                };
            };
            if (this._emblemsHash != hash)
            {
                this.gd_emblemFront.dataProvider = DP;
                this._emblemsHash = hash;
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:uint;
            var position:int;
            switch (target)
            {
                case this.btn_close:
                    this.sysApi.sendAction(new LeaveDialog());
                    this._unloadGuildCreation();
                    break;
                case this.btn_background:
                    this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
                    break;
                case this.btn_icon:
                    this.openSelectedTab(EMBLEM_TAB_ICON);
                    this.setBackgroundColor(this._backgroundColor);
                    break;
                case this.btn_hexaOk:
                    _local_2 = int(Number(("0x" + this.inp_hexaValue.text)));
                    this.onColorChange(new Object(), _local_2);
                    this.cp_colorPk.color = _local_2;
                    break;
                case this.cp_colorPk:
                    if (this.uiApi.keyIsDown(16))
                    {
                        this.inp_hexaValue.text = this.cp_colorPk.color.toString(16);
                        this.ctr_hexaColor.visible = true;
                        this.inp_hexaValue.focus();
                        position = this.inp_hexaValue.text.length;
                        this.inp_hexaValue.setSelection(position, position);
                    };
                    break;
                case this.btn_create:
                    if (((!((this._mode == EMBLEM_MODIFICATION))) && ((((this.inp_guildname.text.length < ProtocolConstantsEnum.MIN_GUILDNAME_LEN)) || ((this.inp_guildname.text.length > ProtocolConstantsEnum.MAX_GUILDNAME_LEN))))))
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.guild.invalidName"), [this.uiApi.getText("ui.common.ok")]);
                    }
                    else
                    {
                        if (this._mode == CREATION)
                        {
                            this.sysApi.sendAction(new GuildCreationValid(this.inp_guildname.text, this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                        }
                        else
                        {
                            if (this._mode == NAME_MODIFICATION)
                            {
                                this.sysApi.sendAction(new GuildModificationNameValid(this.inp_guildname.text));
                            }
                            else
                            {
                                if (this._mode == EMBLEM_MODIFICATION)
                                {
                                    this.sysApi.sendAction(new GuildModificationEmblemValid(this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                                }
                                else
                                {
                                    if (this._mode == MODIFICATION)
                                    {
                                        this.sysApi.sendAction(new GuildModificationValid(this.inp_guildname.text, this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                                    };
                                };
                            };
                        };
                    };
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.social.nameRules")), target, false, "standard", 0, 0, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onColorChange(target:Object, fixedColor:int=-1):void
        {
            var color:Number;
            if (!(this.ctr_hexaColor.visible))
            {
                color = this.cp_colorPk.color;
            }
            else
            {
                color = fixedColor;
                this.ctr_hexaColor.visible = false;
            };
            switch (this._nCurrentTab)
            {
                case 0:
                    if (!(this._stickEmblem))
                    {
                        this.setIconColor(color);
                    };
                    break;
                case 1:
                    if (!(this._stickEmblem))
                    {
                        this.setBackgroundColor(color);
                    };
                    break;
            };
        }

        public function onGuildCreationResult(result:uint):void
        {
            switch (result)
            {
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                    this._unloadGuildCreation();
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.guild.AlreadyUseName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.guild.invalidName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.guild.AlreadyUseEmblem"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.guild.requirementUnmet"), [this.uiApi.getText("ui.common.ok")]);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.gd_emblemBack:
                    if (((((isNewSelection) && (!(this._stickEmblem)))) && (!((selectMethod == SelectMethodEnum.AUTO)))))
                    {
                        this.selectBackground(target.selectedItem, false);
                    };
                    break;
                case this.gd_emblemFront:
                    if (((((!(this._stickEmblem)) && (!((selectMethod == SelectMethodEnum.AUTO))))) && (((isNewSelection) || ((this.gd_emblemFront.dataProvider.length == 1))))))
                    {
                        this.selectIcon((target.selectedItem as EmblemWrapper), false);
                    };
                    break;
                case this.cbb_emblemCategory:
                    if (isNewSelection)
                    {
                        this._currentIconCat = this._iconCategories[this.cbb_emblemCategory.selectedIndex];
                        switch (selectMethod)
                        {
                            case 0:
                            case 3:
                            case 4:
                            case 8:
                                this._stickEmblem = true;
                                this.updateIconGrid();
                                this._stickEmblem = false;
                                break;
                        };
                        break;
                    };
            };
        }

        public function onTextureReady(target:Object):void
        {
            switch (target)
            {
                case this.tx_emblem:
                    this.utilApi.changeColor(target.getChildByName("back"), this._backgroundColor, 1);
                    break;
            };
        }

        public function onUiLoaded(name:String):void
        {
            if (name == "guildCreator")
            {
                if (this.socialApi.isGuildNameInvalid())
                {
                    this._mode = NAME_MODIFICATION;
                };
                this.refreshUIMode();
            };
        }

        public function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onShortcut(s:String):Boolean
        {
            var color:uint;
            switch (s)
            {
                case "validUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        color = int(Number(("0x" + this.inp_hexaValue.text)));
                        this.onColorChange(new Object(), color);
                        this.cp_colorPk.color = color;
                    };
                    return (true);
                case "closeUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        this.ctr_hexaColor.visible = false;
                    }
                    else
                    {
                        this.sysApi.sendAction(new LeaveDialog());
                        this._unloadGuildCreation();
                    };
                    return (true);
            };
            return (false);
        }


    }
}//package ui

