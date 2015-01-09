package 
{
    import flash.display.Sprite;
    import ui.Banner;
    import ui.Chat;
    import ui.Smileys;
    import ui.MapInfo;
    import ui.MainMenu;
    import ui.PayZone;
    import ui.HardcoreDeath;
    import ui.BuffUi;
    import ui.FightModificatorUi;
    import ui.RewardsAndGiftsUi;
    import ui.Report;
    import ui.Zoom;
    import ui.Cinematic;
    import ui.ExternalNotification;
    import ui.OfflineSales;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SocialApi;
    import d2api.DataApi;
    import d2api.ConfigApi;
    import d2api.ContextMenuApi;
    import d2api.TimeApi;
    import d2api.ExternalNotificationApi;
    import d2api.FightApi;
    import d2api.ChatApi;
    import d2api.UtilApi;
    import managers.ExternalNotificationManager;
    import d2hooks.GameStart;
    import d2hooks.SmileysStart;
    import d2hooks.EnabledChannels;
    import d2hooks.TextInformation;
    import d2hooks.PlayerFightRequestSent;
    import d2hooks.PlayerFightFriendlyRequested;
    import d2hooks.PlayerFightFriendlyAnswered;
    import d2hooks.GameRolePlayPlayerLifeStatus;
    import d2hooks.SubscriptionZone;
    import d2hooks.NonSubscriberPopup;
    import d2hooks.GuestLimitationPopup;
    import d2hooks.GuestMode;
    import d2hooks.SlotDropedOnWorld;
    import d2hooks.RoleplayBuffViewContent;
    import d2hooks.RewardableAchievementsVisible;
    import d2hooks.GiftsWaitingAllocation;
    import d2hooks.OpenReport;
    import d2hooks.WorldRightClick;
    import d2hooks.WorldMouseWheel;
    import d2hooks.Cinematic;
    import d2hooks.PackRestrictedSubArea;
    import d2hooks.InactivityNotification;
    import d2hooks.AreaFightModificatorUpdate;
    import d2hooks.OpenOfflineSales;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2hooks.FoldAll;
    import d2enums.StrataEnum;
    import d2actions.PlayerFightFriendlyAnswer;
    import d2actions.AddIgnored;
    import d2actions.GameRolePlayFreeSoulRequest;
    import d2actions.ObjectSetPosition;
    import d2actions.SpellSetPosition;
    import d2actions.ObjectDrop;
    import d2data.ItemWrapper;
    import d2data.SubArea;
    import d2data.Pack;
    import d2hooks.*;
    import d2actions.*;

    public class GameUiCore extends Sprite 
    {

        private static var _self:GameUiCore;

        protected var banner:Banner;
        protected var chat:Chat;
        protected var smileys:Smileys;
        protected var mapInfo:MapInfo;
        protected var mainMenu:MainMenu;
        protected var payZone:PayZone;
        protected var hardcoreDeath:HardcoreDeath;
        protected var buffUi:BuffUi;
        protected var fightModificatorUi:FightModificatorUi;
        protected var rewardsAndGiftsUi:RewardsAndGiftsUi;
        protected var report:Report;
        protected var zoom:Zoom;
        protected var cinematic:Cinematic;
        protected var externalnotification:ExternalNotification;
        protected var offlineSales:OfflineSales;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var playerApi:PlayedCharacterApi;
        public var socialApi:SocialApi;
        public var dataApi:DataApi;
        public var configApi:ConfigApi;
        public var contextMenuApi:ContextMenuApi;
        public var timeApi:TimeApi;
        public var extNotifApi:ExternalNotificationApi;
        public var fightApi:FightApi;
        public var chatApi:ChatApi;
        public var utilApi:UtilApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _channels:Object;
        private var _currentPopupName:String;
        private var _waitingObject:Object;
        private var _waitingObjectName:String;
        private var _waitingObjectQuantity:int;
        private var _folded:Boolean = false;
        private var _ignoreName:String;
        private var _aTextInfos:Array;
        private var _inactivityPopup:String = null;
        public var areAchRewardsRequired:Boolean;
        public var areGiftsRequired:Boolean;

        public function GameUiCore()
        {
            this._aTextInfos = new Array();
            super();
        }

        public static function getInstance():GameUiCore
        {
            return (_self);
        }


        public function main():void
        {
            Api.system = this.sysApi;
            Api.ui = this.uiApi;
            Api.extNotif = this.extNotifApi;
            Api.social = this.socialApi;
            Api.fight = this.fightApi;
            Api.player = this.playerApi;
            Api.data = this.dataApi;
            Api.chat = this.chatApi;
            Api.util = this.utilApi;
            if (this.sysApi.hasAir())
            {
                ExternalNotificationManager.getInstance();
            };
            this.sysApi.createHook("FoldAll");
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(SmileysStart, this.onSmileysStart);
            this.sysApi.addHook(EnabledChannels, this.onEnabledChannels);
            this.sysApi.addHook(TextInformation, this.onTextInformation);
            this.sysApi.addHook(PlayerFightRequestSent, this.onPlayerFightRequestSent);
            this.sysApi.addHook(PlayerFightFriendlyRequested, this.onPlayerFightFriendlyRequested);
            this.sysApi.addHook(PlayerFightFriendlyAnswered, this.onPlayerFightFriendlyAnswered);
            this.sysApi.addHook(GameRolePlayPlayerLifeStatus, this.onGameRolePlayPlayerLifeStatus);
            this.sysApi.addHook(SubscriptionZone, this.onSubscriptionZone);
            this.sysApi.addHook(NonSubscriberPopup, this.onNonSubscriberPopup);
            this.sysApi.addHook(GuestLimitationPopup, this.onGuestLimitationPopup);
            this.sysApi.addHook(GuestMode, this.onGuestMode);
            this.sysApi.addHook(SlotDropedOnWorld, this.onSlotDropedOnWorld);
            this.sysApi.addHook(RoleplayBuffViewContent, this.onRoleplayBuffViewContent);
            this.sysApi.addHook(RewardableAchievementsVisible, this.onRewardableAchievementsVisible);
            this.sysApi.addHook(GiftsWaitingAllocation, this.onGiftsWaitingAllocation);
            this.sysApi.addHook(OpenReport, this.onReportOpen);
            this.sysApi.addHook(WorldRightClick, this.onWorldRightClick);
            this.sysApi.addHook(WorldMouseWheel, this.onWorldMouseWheel);
            this.sysApi.addHook(Cinematic, this.onCinematic);
            this.sysApi.addHook(PackRestrictedSubArea, this.onPackRestrictedSubArea);
            this.sysApi.addHook(InactivityNotification, this.onInactivityNotification);
            this.sysApi.addHook(AreaFightModificatorUpdate, this.onAreaFightModificatorUpdate);
            this.sysApi.addHook(OpenOfflineSales, this.onOpenOfflineSales);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("transparancyMode", this.onShortcut);
            this.uiApi.addShortcutHook("showGrid", this.onShortcut);
            this.uiApi.addShortcutHook("foldAll", this.onShortcut);
            this.uiApi.addShortcutHook("cellSelectionOnly", this.onShortcut);
            this.uiApi.addShortcutHook("showCoord", this.onShortcut);
            _self = this;
        }

        public function getTooltipFightPlacer():Object
        {
            var ref:Object;
            if (this.uiApi.getUi(UIEnum.BANNER))
            {
                ref = this.uiApi.getUi(UIEnum.BANNER).getElement("tooltipFightPlacer");
            };
            return (ref);
        }

        private function onShortcut(s:String):Boolean
        {
            var _local_2:Boolean;
            switch (s)
            {
                case "closeUi":
                    if (this.uiApi.getUi("cartographyUi"))
                    {
                        this.uiApi.unloadUi("cartographyUi");
                    }
                    else
                    {
                        if (!(this.uiApi.getUi("mainMenu")))
                        {
                            this.uiApi.loadUi("mainMenu");
                        }
                        else
                        {
                            this.uiApi.unloadUi("mainMenu");
                        };
                    };
                    return (true);
                case "transparancyMode":
                    _local_2 = this.configApi.getConfigProperty("atouin", "transparentOverlayMode");
                    this.configApi.setConfigProperty("atouin", "transparentOverlayMode", !(_local_2));
                    return (true);
                case "showGrid":
                    _local_2 = this.configApi.getConfigProperty("atouin", "alwaysShowGrid");
                    this.configApi.setConfigProperty("atouin", "alwaysShowGrid", !(_local_2));
                    return (true);
                case "showCoord":
                    _local_2 = this.configApi.getConfigProperty("dofus", "mapCoordinates");
                    this.configApi.setConfigProperty("dofus", "mapCoordinates", !(_local_2));
                    return (true);
                case "foldAll":
                    this._folded = !(this._folded);
                    this.sysApi.dispatchHook(FoldAll, this._folded);
                    return (true);
                case "cellSelectionOnly":
                    _local_2 = this.configApi.getConfigProperty("dofus", "cellSelectionOnly");
                    this.configApi.setConfigProperty("dofus", "cellSelectionOnly", !(_local_2));
                    return (true);
            };
            return (false);
        }

        private function onGameStart():void
        {
            this.uiApi.loadUi(UIEnum.BANNER, null, null, StrataEnum.STRATA_HIGH);
            this.uiApi.loadUi(UIEnum.MAP_INFO_UI);
            if (!(this.uiApi.getUi(UIEnum.CHAT_UI)))
            {
                this.uiApi.loadUi(UIEnum.CHAT_UI, UIEnum.CHAT_UI, [this._channels, this._aTextInfos], StrataEnum.STRATA_TOP);
            };
        }

        private function onSmileysStart(type:uint, forceOpen:String=""):void
        {
            if (!(this.uiApi.getUi(UIEnum.SMILEY_UI)))
            {
                this.uiApi.loadUi(UIEnum.SMILEY_UI, UIEnum.SMILEY_UI, type, StrataEnum.STRATA_TOP);
            };
        }

        private function onEnabledChannels(v:Object):void
        {
            if (!(this.uiApi.getUi(UIEnum.CHAT_UI)))
            {
                this._channels = v;
            };
        }

        private function onTextInformation(content:String="", channel:int=0, timestamp:Number=0, saveMsg:Boolean=true, forceDisplay:Boolean=false):void
        {
            if (!(this.uiApi.getUi(UIEnum.CHAT_UI)))
            {
                this._aTextInfos.push({
                    "content":content,
                    "channel":channel,
                    "timestamp":timestamp,
                    "saveMsg":saveMsg
                });
            };
        }

        private function onPlayerFightRequestSent(targetName:String, friendly:Boolean):void
        {
            if (friendly)
            {
                this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"), this.uiApi.getText("ui.fight.youChallenge", targetName), [this.uiApi.getText("ui.charcrea.undo")], [this.onFightFriendlyRefused], null, this.onFightFriendlyRefused);
            };
        }

        private function onPlayerFightFriendlyRequested(targetName:String):void
        {
            this._ignoreName = targetName;
            this._currentPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.fight.challenge"), this.uiApi.getText("ui.fight.aChallengeYou", targetName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.onFightFriendlyAccepted, this.onFightFriendlyRefused, this.onFightFriendlyIgnore], this.onFightFriendlyAccepted, this.onFightFriendlyRefused);
        }

        private function onFightFriendlyAccepted():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(true));
        }

        private function onFightFriendlyRefused():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(false));
        }

        private function onFightFriendlyIgnore():void
        {
            this.sysApi.sendAction(new PlayerFightFriendlyAnswer(false));
            this.sysApi.sendAction(new AddIgnored(this._ignoreName));
        }

        private function onPlayerFightFriendlyAnswered(accept:Boolean):void
        {
            this.uiApi.unloadUi(this._currentPopupName);
            this._currentPopupName = null;
        }

        private function onWorldRightClick():void
        {
            var menu:Object;
            if (this.playerApi.isInFight())
            {
                menu = this.contextMenuApi.create(null, "fightWorld");
            }
            else
            {
                menu = this.contextMenuApi.create(null, "world");
            };
            this.modContextMenu.createContextMenu(menu);
        }

        private function onWorldMouseWheel(zoomIn:Boolean):void
        {
            if (this.sysApi.getOption("zoomOnMouseWheel", "dofus"))
            {
                Api.system.mouseZoom(zoomIn);
            };
        }

        private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint):void
        {
            if (hardcore == 0)
            {
                switch (status)
                {
                    case 0:
                        break;
                    case 1:
                        this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), ((this.uiApi.getText("ui.gameuicore.playerDied") + "\n\n") + this.uiApi.getText("ui.gameuicore.freeSoul")), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onFreePlayerSoulAccepted, this.onFreePlayerSoulRefused], null, this.onFreePlayerSoulRefused, this.uiApi.createUri((this.sysApi.getConfigEntry("config.content.path") + "gfx/illusUi/gravestone.png")));
                        break;
                    case 2:
                        this.modCommon.openPopup(this.uiApi.getText("ui.login.news"), this.uiApi.getText("ui.gameuicore.soulsWorld"), [this.uiApi.getText("ui.common.ok")]);
                        break;
                };
            }
            else
            {
                if (!(this.uiApi.getUi("hardcoreDeath")))
                {
                    this.uiApi.loadUi("hardcoreDeath");
                };
            };
        }

        private function onFreePlayerSoulAccepted():void
        {
            this.sysApi.sendAction(new GameRolePlayFreeSoulRequest());
        }

        private function onFreePlayerSoulRefused():void
        {
        }

        private function onSubscriptionZone(active:Boolean):void
        {
            if (active)
            {
                if (!(this.uiApi.getUi("payZone")))
                {
                    this.uiApi.loadUi("payZone", "payZone", [0, false]);
                };
            }
            else
            {
                if (this.uiApi.getUi("payZone"))
                {
                    this.uiApi.unloadUi("payZone");
                };
            };
        }

        private function onNonSubscriberPopup():void
        {
            if (!(this.uiApi.getUi("payZone")))
            {
                this.uiApi.loadUi("payZone", "payZone", [0, true]);
            };
        }

        public function onGuestLimitationPopup():void
        {
            if (!(this.uiApi.getUi("payZone")))
            {
                this.uiApi.loadUi("payZone", "payZone", [1, true], StrataEnum.STRATA_TOP);
            };
        }

        private function onGuestMode(active:Boolean):void
        {
            if (active)
            {
                if (!(this.uiApi.getUi("payZone")))
                {
                    this.uiApi.loadUi("payZone", "payZone", [1, false], StrataEnum.STRATA_TOP);
                };
            }
            else
            {
                if (this.uiApi.getUi("payZone"))
                {
                    this.uiApi.unloadUi("payZone");
                };
            };
        }

        private function onAreaFightModificatorUpdate(spellPairId:int):void
        {
            if (((!(this.uiApi.getUi("fightModificatorUi"))) && ((spellPairId > -1))))
            {
                this.uiApi.loadUi("fightModificatorUi", "fightModificatorUi", {"pairId":spellPairId});
            };
        }

        private function onRoleplayBuffViewContent(buffs:Object):void
        {
            if (!(this.uiApi.getUi(UIEnum.BUFF_UI)))
            {
                this.uiApi.loadUi(UIEnum.BUFF_UI, UIEnum.BUFF_UI, {"buffs":buffs});
            };
        }

        public function removeFromBanner(pObject:Object):void
        {
            if (this.uiApi.keyIsDown(16))
            {
                if (pObject.hasOwnProperty("objectUID"))
                {
                    this.sysApi.sendAction(new ObjectSetPosition(pObject.objectUID, 63));
                }
                else
                {
                    this.sysApi.sendAction(new SpellSetPosition(pObject.id, 63));
                };
            };
        }

        public function onSlotDropedOnWorld(pSlot:Object, pDropTarget:Object):void
        {
            var effect:Object;
            var className:String = pSlot.data.simplyfiedQualifiedClassName.toLowerCase();
            switch (true)
            {
                case (className == "spellwrapper"):
                case (className == "presetwrapper"):
                    break;
                case (pSlot.data is ItemWrapper):
                    if ((((pSlot.data.position > 63)) && ((pSlot.data.position < 318))))
                    {
                        this.removeFromBanner(pSlot.data);
                    };
                    for each (effect in pSlot.data.effects)
                    {
                        if ((((((effect.effectId == 981)) || ((effect.effectId == 982)))) || ((effect.effectId == 983))))
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.objectError.CannotDrop"), 10, this.timeApi.getTimestamp());
                            return;
                        };
                    };
                    if (this.playerApi.isInExchange())
                    {
                        return;
                    };
                    this._waitingObject = pSlot.data;
                    this._waitingObjectName = this.dataApi.getItemName(this._waitingObject.objectGID);
                    if (this._waitingObject.quantity > 1)
                    {
                        this.modCommon.openQuantityPopup(1, this._waitingObject.quantity, this._waitingObject.quantity, this.onValidQtyDrop);
                    }
                    else
                    {
                        this.sysApi.sendAction(new ObjectDrop(this._waitingObject.objectUID, this._waitingObject.objectGID, 1));
                    };
                    break;
            };
        }

        private function onValidQtyDrop(pQuantity:int):void
        {
            this._waitingObjectQuantity = pQuantity;
            this.sysApi.sendAction(new ObjectDrop(this._waitingObject.objectUID, this._waitingObject.objectGID, this._waitingObjectQuantity));
        }

        private function onReportOpen(playerID:uint, playerName:String, context:Object=null):void
        {
            this.uiApi.unloadUi("report");
            this.uiApi.loadUi("report", "report", {
                "playerID":playerID,
                "playerName":playerName,
                "context":context
            });
        }

        public function onCinematic(cinematicId:int):void
        {
            if (!(this.uiApi.getUi(UIEnum.CHAT_UI)))
            {
                this.uiApi.loadUi(UIEnum.CHAT_UI, UIEnum.CHAT_UI, [this._channels, this._aTextInfos], StrataEnum.STRATA_TOP);
            };
            var cinematicStrId:String = ("" + cinematicId);
            if (cinematicId == 10)
            {
                cinematicStrId = ((this.sysApi.getCurrentLanguage() + "/") + cinematicStrId);
            };
            this.uiApi.loadUi("cinematic", "cinematic", {"cinematicId":cinematicStrId}, StrataEnum.STRATA_TOP);
        }

        public function onPackRestrictedSubArea(subAreaId:int):void
        {
            var subArea:SubArea = this.dataApi.getSubArea(subAreaId);
            var pack:Pack = this.dataApi.getPack(subArea.packId);
            if (((this.sysApi.hasPart(pack.name)) && (this.sysApi.isDownloadFinished())))
            {
                this.displayRebootPopup();
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.split.PackRestrictedSubAreaError", []), [this.uiApi.getText("ui.common.ok")]);
            };
        }

        private function displayRebootPopup():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.split.rebootConfirm", []), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmRestart, null], this.onConfirmRestart);
        }

        private function onConfirmRestart():void
        {
            this.sysApi.reset();
        }

        private function onInactivityNotification(inactive:Boolean):void
        {
            if (((inactive) && (!(this._inactivityPopup))))
            {
                this._inactivityPopup = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.common.inactivityWarning"), [this.uiApi.getText("ui.common.ok")], [this.inactivityPopupClosed], this.inactivityPopupClosed, this.inactivityPopupClosed);
            };
        }

        private function inactivityPopupClosed():void
        {
            this._inactivityPopup = null;
        }

        private function onRewardableAchievementsVisible(b:Boolean):void
        {
            this.areAchRewardsRequired = b;
        }

        private function onGiftsWaitingAllocation(b:Boolean):void
        {
            this.areGiftsRequired = b;
        }

        private function onOpenOfflineSales(pOfflineSales:Object):void
        {
            this.uiApi.loadUi("offlineSales", null, pOfflineSales, 1, null, true);
        }


    }
}//package 

