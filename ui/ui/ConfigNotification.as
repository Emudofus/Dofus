package ui
{
    import d2api.BindsApi;
    import d2api.DataApi;
    import flash.utils.Dictionary;
    import d2components.ButtonContainer;
    import d2components.ComboBox;
    import d2components.Grid;
    import types.ConfigProperty;
    import d2enums.ExternalNotificationTypeEnum;
    import d2data.ExternalNotification;

    public class ConfigNotification extends ConfigUi 
    {

        private static const _displayDurationValues:Array = [3, 5, 10, 30, 60];
        private static var _events:Array;

        public var bindsApi:BindsApi;
        public var dataApi:DataApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _displayDurations:Array;
        private var _notificationModes:Array;
        private var _maxNumbers:Array;
        private var _notificationPositions:Array;
        private var _eventBtnList:Dictionary;
        private var _soundBtnList:Dictionary;
        private var _notifyBtnList:Dictionary;
        private var _multiBtnList:Dictionary;
        public var btn_alphaWindows:ButtonContainer;
        public var cb_notifMode:ComboBox;
        public var cb_displayDuration:ComboBox;
        public var cb_maxNumber:ComboBox;
        public var cb_notifPosition:ComboBox;
        public var gd_notifications:Grid;

        public function ConfigNotification()
        {
            this._eventBtnList = new Dictionary(true);
            this._soundBtnList = new Dictionary(true);
            this._notifyBtnList = new Dictionary(true);
            this._multiBtnList = new Dictionary(true);
            super();
        }

        public function main(args:*):void
        {
            var i:int;
            var e:Object;
            var cb_displayDurationIndex:int;
            var nbGeneralEvents:int;
            var eventOptions:Object;
            var properties:Array = new Array();
            properties.push(new ConfigProperty("btn_alphaWindows", "notificationsAlphaWindows", "dofus"));
            properties.push(new ConfigProperty("cb_notifMode", "notificationsMode", "dofus"));
            properties.push(new ConfigProperty("cb_displayDuration", "notificationsDisplayDuration", "dofus"));
            properties.push(new ConfigProperty("cb_maxNumber", "notificationsMaxNumber", "dofus"));
            properties.push(new ConfigProperty("cb_notifPosition", "notificationsPosition", "dofus"));
            init(properties);
            if (!(_events))
            {
                _events = new Array();
                _events.push({
                    "text":uiApi.getText("ui.achievement.achievement"),
                    "order":0,
                    "notifType":ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED
                });
                _events.push({
                    "text":uiApi.getText("ui.almanax.questDone"),
                    "order":1,
                    "notifType":ExternalNotificationTypeEnum.QUEST_VALIDATED
                });
                nbGeneralEvents = this.dataApi.getExternalNotifications().length;
                i = 1;
                while (i <= nbGeneralEvents)
                {
                    _events.push({
                        "text":this.getEventDescription(i),
                        "order":_events.length,
                        "notifType":i
                    });
                    i++;
                };
            };
            for each (e in _events)
            {
                eventOptions = configApi.getExternalNotificationOptions(e.notifType);
                e.active = eventOptions.active;
                if (eventOptions.hasOwnProperty("sound"))
                {
                    e.sound = eventOptions.sound;
                };
                if (eventOptions.hasOwnProperty("notify"))
                {
                    e.notify = eventOptions.notify;
                };
                if (eventOptions.hasOwnProperty("multi"))
                {
                    e.multi = eventOptions.multi;
                };
            };
            this._notificationModes = new Array(uiApi.getText("ui.common.none"), uiApi.getText("ui.alert.activation.noFocusOnOneClient"), uiApi.getText("ui.alert.activation.minimizedOneClient"), uiApi.getText("ui.alert.activation.noFocusOnAnyClient"));
            this.cb_notifMode.dataProvider = this._notificationModes;
            this.cb_notifMode.value = this._notificationModes[sysApi.getOption("notificationsMode", "dofus")];
            this.cb_notifMode.dataNameField = "";
            this._displayDurations = new Array(uiApi.getText("ui.alert.displayDuration1"), uiApi.getText("ui.alert.displayDuration2"), uiApi.getText("ui.alert.displayDuration3"), uiApi.getText("ui.alert.displayDuration4"), uiApi.getText("ui.alert.displayDuration5"));
            this.cb_displayDuration.dataProvider = this._displayDurations;
            cb_displayDurationIndex = _displayDurationValues.indexOf(sysApi.getOption("notificationsDisplayDuration", "dofus"));
            this.cb_displayDuration.value = this._displayDurations[cb_displayDurationIndex];
            this.cb_displayDuration.dataNameField = "";
            this._maxNumbers = new Array("1", "3", "5", "10");
            this.cb_maxNumber.dataProvider = this._maxNumbers;
            this.cb_maxNumber.value = sysApi.getOption("notificationsMaxNumber", "dofus").toString();
            this.cb_maxNumber.dataNameField = "";
            this.cb_notifPosition.dataProvider = (this._notificationPositions = [uiApi.getText("ui.alert.position.bottomRightCorner"), uiApi.getText("ui.alert.position.bottomLeftCorner"), uiApi.getText("ui.alert.position.topRightCorner"), uiApi.getText("ui.alert.position.topLeftCorner")]);
            this.cb_notifPosition.value = this._notificationPositions[sysApi.getOption("notificationsPosition", "dofus")];
            this.cb_notifPosition.dataNameField = "";
            this.gd_notifications.dataProvider = _events;
        }

        private function getEventDescription(pEventType:int):String
        {
            var extNotif:ExternalNotification;
            var extNotifs:Object = this.dataApi.getExternalNotifications();
            var text:String = ("event" + pEventType);
            for each (extNotif in extNotifs)
            {
                if (ExternalNotificationTypeEnum[extNotif.name] == pEventType)
                {
                    text = extNotif.description;
                    break;
                };
            };
            return (text);
        }

        override public function reset():void
        {
            super.reset();
            init(_properties);
        }

        public function updateNotificationLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._eventBtnList[componentsRef.btn_activate.name]))
            {
                uiApi.addComponentHook(componentsRef.btn_activate, "onRelease");
            };
            this._eventBtnList[componentsRef.btn_activate.name] = data;
            if (!(this._soundBtnList[componentsRef.btn_sound.name]))
            {
                uiApi.addComponentHook(componentsRef.btn_sound, "onRelease");
            };
            this._soundBtnList[componentsRef.btn_sound.name] = data;
            if (!(this._notifyBtnList[componentsRef.btn_notify.name]))
            {
                uiApi.addComponentHook(componentsRef.btn_notify, "onRelease");
            };
            this._notifyBtnList[componentsRef.btn_notify.name] = data;
            if (!(this._multiBtnList[componentsRef.btn_multi.name]))
            {
                uiApi.addComponentHook(componentsRef.btn_multi, "onRelease");
            };
            this._multiBtnList[componentsRef.btn_multi.name] = data;
            if (data)
            {
                componentsRef.btn_label_btn_activate.text = data.text;
                if (data.active)
                {
                    componentsRef.btn_activate.selected = true;
                }
                else
                {
                    componentsRef.btn_activate.selected = false;
                };
                if (!(data.sound))
                {
                    componentsRef.btn_sound.selected = true;
                }
                else
                {
                    componentsRef.btn_sound.selected = false;
                };
                if (!(data.notify))
                {
                    componentsRef.btn_notify.selected = true;
                }
                else
                {
                    componentsRef.btn_notify.selected = false;
                };
                if (!(data.multi))
                {
                    componentsRef.btn_multi.selected = true;
                }
                else
                {
                    componentsRef.btn_multi.selected = false;
                };
                componentsRef.btn_activate.visible = true;
                componentsRef.btn_sound.visible = data.hasOwnProperty("sound");
                componentsRef.btn_notify.visible = data.hasOwnProperty("notify");
                componentsRef.btn_multi.visible = data.hasOwnProperty("multi");
            }
            else
            {
                componentsRef.btn_activate.visible = false;
                componentsRef.btn_sound.visible = false;
                componentsRef.btn_notify.visible = false;
                componentsRef.btn_multi.visible = false;
            };
        }

        override public function onRelease(target:Object):void
        {
            var event:Object;
            if (target.name.indexOf("btn_activate") != -1)
            {
                event = this._eventBtnList[target.name];
                target.selected = this.updateEventOptions(event.order, "active");
            }
            else
            {
                if (target.name.indexOf("btn_sound") != -1)
                {
                    event = this._soundBtnList[target.name];
                    target.selected = !(this.updateEventOptions(event.order, "sound"));
                }
                else
                {
                    if (target.name.indexOf("btn_notify") != -1)
                    {
                        event = this._notifyBtnList[target.name];
                        target.selected = !(this.updateEventOptions(event.order, "notify"));
                    }
                    else
                    {
                        if (target.name.indexOf("btn_multi") != -1)
                        {
                            event = this._multiBtnList[target.name];
                            target.selected = !(this.updateEventOptions(event.order, "multi"));
                        }
                        else
                        {
                            if (target.name.indexOf("btn_alphaWindows") != -1)
                            {
                                setProperty("dofus", "notificationsAlphaWindows", target.selected);
                            };
                        };
                    };
                };
            };
        }

        private function updateEventOptions(pEventIndex:int, pEventOptionName:String):Boolean
        {
            var event:Object = _events[pEventIndex];
            event[pEventOptionName] = !(event[pEventOptionName]);
            configApi.setExternalNotificationOptions(event.notifType, event);
            return (event[pEventOptionName]);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.cb_notifMode:
                    setProperty("dofus", "notificationsMode", this.cb_notifMode.selectedIndex);
                    break;
                case this.cb_displayDuration:
                    setProperty("dofus", "notificationsDisplayDuration", _displayDurationValues[this.cb_displayDuration.selectedIndex]);
                    break;
                case this.cb_maxNumber:
                    setProperty("dofus", "notificationsMaxNumber", int(this.cb_maxNumber.selectedItem));
                    break;
                case this.cb_notifPosition:
                    setProperty("dofus", "notificationsPosition", this.cb_notifPosition.selectedIndex);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var event:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            if (target.name.indexOf("btn_sound") != -1)
            {
                tooltipText = uiApi.getText("ui.alert.info.sound");
            }
            else
            {
                if (target.name.indexOf("btn_multi") != -1)
                {
                    event = this._multiBtnList[target.name];
                    if (_events[event.order].multi == true)
                    {
                        tooltipText = uiApi.getText("ui.alert.info.multi.deactivate");
                    }
                    else
                    {
                        tooltipText = uiApi.getText("ui.alert.info.multi.activate");
                    };
                }
                else
                {
                    if (target.name.indexOf("btn_notify") != -1)
                    {
                        tooltipText = uiApi.getText("ui.alert.info.notify");
                    };
                };
            };
            if (tooltipText != "")
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }


    }
}//package ui

