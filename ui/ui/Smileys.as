package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.RoleplayApi;
    import d2api.ChatApi;
    import d2api.TooltipApi;
    import d2api.TimeApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import d2components.Grid;
    import d2components.GraphicContainer;
    import d2hooks.EmoteListUpdated;
    import d2hooks.MoodResult;
    import d2hooks.SmileysStart;
    import d2hooks.EmoteUnabledListUpdated;
    import flash.events.TimerEvent;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2hooks.ShortcutsMovementAllowed;
    import d2hooks.OpenSmileys;
    import d2components.Slot;
    import d2actions.ChatSmileyRequest;
    import d2actions.EmotePlayRequest;
    import d2actions.MoodSmileyRequest;
    import d2hooks.TextInformation;
    import d2hooks.*;
    import d2actions.*;

    public class Smileys 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var rpApi:RoleplayApi;
        public var chatApi:ChatApi;
        public var tooltipApi:TooltipApi;
        public var timeApi:TimeApi;
        private var _currentMood:int = -1;
        private var _currentUi:int = 0;
        private var _selectedTxList:Array;
        private var _slotByEmoteId:Dictionary;
        private var _playSmileAllowed:Boolean = true;
        private var _playSmileAllowedTimer:Timer;
        private var _shortcutColor:String;
        public var gd_smileys:Grid;
        public var gd_emotes:Grid;
        public var ctr_smileys:GraphicContainer;
        public var ctr_emotes:GraphicContainer;

        public function Smileys()
        {
            this._selectedTxList = new Array();
            this._slotByEmoteId = new Dictionary();
            super();
        }

        public function main(... args):void
        {
            this.sysApi.addHook(EmoteListUpdated, this.onEmoteListUpdated);
            this.sysApi.addHook(MoodResult, this.onMoodResult);
            this.sysApi.addHook(SmileysStart, this.onSmileysStart);
            this.sysApi.addHook(EmoteUnabledListUpdated, this.onEmoteUnabledListUpdated);
            this._currentUi = args[0];
            this._playSmileAllowed = true;
            this._playSmileAllowedTimer = new Timer(1000, 1);
            this._playSmileAllowedTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPlaySmileAllowedTimer);
            if (!(this.uiApi.getUi(UIEnum.STORAGE_UI)))
            {
                this.sysApi.dispatchHook(ShortcutsMovementAllowed, true);
            };
            this.displayCurrentType();
        }

        public function unload():void
        {
            if (!(this.uiApi.getUi(UIEnum.STORAGE_UI)))
            {
                this.sysApi.dispatchHook(ShortcutsMovementAllowed, false);
            };
            this._playSmileAllowedTimer.stop();
            this._playSmileAllowedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlaySmileAllowedTimer);
            this.uiApi.hideTooltip();
        }

        private function displayCurrentType():void
        {
            if (this._currentUi == 0)
            {
                this.sysApi.dispatchHook(OpenSmileys);
                this.gd_smileys.dataProvider = this.dataApi.getSmiliesWrapperForPlayers();
                this.ctr_smileys.visible = true;
                this.ctr_emotes.visible = false;
                this._currentMood = this.chatApi.getSmileyMood();
                if (((!((this._currentMood == -1))) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = true;
                };
            }
            else
            {
                this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
                this.ctr_emotes.visible = true;
                this.ctr_smileys.visible = false;
            };
        }

        public function updateSmiley(data:*, componentsRef:*, selected:Boolean):void
        {
            componentsRef.slot_smiley.dropValidator = this.dropValidatorFunction;
            if (data)
            {
                this._selectedTxList[data.id] = componentsRef.tx_bgSmiley;
                componentsRef.slot_smiley.data = data;
                if (data.id == this._currentMood)
                {
                    componentsRef.tx_bgSmiley.visible = true;
                }
                else
                {
                    componentsRef.tx_bgSmiley.visible = false;
                };
                componentsRef.slot_smiley.allowDrag = true;
            }
            else
            {
                componentsRef.slot_smiley.data = null;
                componentsRef.tx_bgSmiley.visible = false;
            };
        }

        public function updateEmote(data:*, componentsRef:*, selected:Boolean):void
        {
            var emotes:Object;
            componentsRef.slot_emote.dropValidator = this.dropValidatorFunction;
            if (data)
            {
                componentsRef.slot_emote.data = data;
                this._slotByEmoteId[data.id] = componentsRef.slot_emote;
                componentsRef.slot_emote.allowDrag = true;
                emotes = this.rpApi.getUsableEmotesList();
                if (emotes)
                {
                    if (emotes.indexOf(data.id) == -1)
                    {
                        componentsRef.btn_emote.disabled = true;
                    }
                    else
                    {
                        componentsRef.btn_emote.disabled = false;
                    };
                };
            }
            else
            {
                componentsRef.slot_emote.data = null;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var smileyItem:Object;
            var emoteItem:Object;
            var slot:Slot;
            switch (target)
            {
                case this.gd_smileys:
                    if (selectMethod != 7)
                    {
                        smileyItem = target.selectedItem;
                        if (((smileyItem) && (this._playSmileAllowed)))
                        {
                            this.sysApi.sendAction(new ChatSmileyRequest(smileyItem.id));
                            this._playSmileAllowed = false;
                            this._playSmileAllowedTimer.start();
                        };
                        if (this.sysApi.getOption("smileysAutoclosed", "chat"))
                        {
                            this.uiApi.unloadUi(this.uiApi.me().name);
                        };
                    };
                    break;
                case this.gd_emotes:
                    if (selectMethod != 7)
                    {
                        emoteItem = target.selectedItem;
                        if (((emoteItem) && (this._playSmileAllowed)))
                        {
                            slot = (this._slotByEmoteId[emoteItem.id] as Slot);
                            if (slot != null)
                            {
                                this.sysApi.sendAction(new EmotePlayRequest(emoteItem.id));
                                this._playSmileAllowed = false;
                                this._playSmileAllowedTimer.start();
                            };
                        };
                        if (this.sysApi.getOption("smileysAutoclosed", "chat"))
                        {
                            this.uiApi.unloadUi(this.uiApi.me().name);
                        };
                    };
                    break;
            };
        }

        public function onPlaySmileAllowedTimer(e:TimerEvent):void
        {
            this._playSmileAllowed = true;
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var data:Object;
            var ref:Object;
            if (target == this.gd_emotes)
            {
                ref = item.container;
                if (item.data)
                {
                    if (!(this._shortcutColor))
                    {
                        this._shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        this._shortcutColor = this._shortcutColor.replace("0x", "#");
                    };
                    data = this.uiApi.textTooltipInfo((((((item.data.name + " <font color='") + this._shortcutColor) + "'>(/") + item.data.shortcut) + ")</font>"));
                    this.uiApi.showTooltip(data, ref, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                };
            }
            else
            {
                if (target == this.gd_smileys)
                {
                    ref = item.container;
                    if (((item.data) && ((item.data.id == this._currentMood))))
                    {
                        data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.smiley.mood"));
                        this.uiApi.showTooltip(data, ref, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    };
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            if (this._currentMood == data.id)
            {
                this.sysApi.sendAction(new MoodSmileyRequest(-1));
            }
            else
            {
                this.sysApi.sendAction(new MoodSmileyRequest(data.id));
            };
        }

        public function onEmoteListUpdated():void
        {
            this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
        }

        public function onEmoteUnabledListUpdated(emotesOk:Object):void
        {
            var vsv:int = this.gd_emotes.verticalScrollValue;
            this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
            this.gd_emotes.verticalScrollValue = vsv;
        }

        public function onMoodResult(resultCode:uint, smileyId:int):void
        {
            if (resultCode == 0)
            {
                if (((!((this._currentMood == -1))) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = false;
                };
                this._currentMood = smileyId;
                if (((!((this._currentMood == -1))) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = true;
                };
            }
            else
            {
                if (resultCode == 1)
                {
                    this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.smiley.errorMood"), 666, this.timeApi.getTimestamp());
                }
                else
                {
                    if (resultCode == 2)
                    {
                        this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.smiley.errorFloodMood"), 666, this.timeApi.getTimestamp());
                    };
                };
            };
        }

        private function onSmileysStart(type:uint, forceOpen:String=""):void
        {
            if (((!((type == this._currentUi))) && (!((forceOpen == "false")))))
            {
                this._currentUi = type;
                this.displayCurrentType();
            }
            else
            {
                if (forceOpen != "true")
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object):Boolean
        {
            return (false);
        }

        public function removeDropSourceFunction(target:Object):void
        {
        }

        public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object):void
        {
            iSlotDataHolder.data = data;
        }


    }
}//package ui

