package 
{
    import flash.display.Sprite;
    import ui.Login;
    import ui.LoginThirdParty;
    import ui.ServerSelection;
    import ui.ServerSimpleSelection;
    import ui.ServerListSelection;
    import ui.ServerForm;
    import ui.ServerPopup;
    import ui.items.ServerImgXmlItem;
    import ui.CharacterCreation;
    import ui.CharacterHeader;
    import ui.CharacterSelection;
    import ui.PseudoChoice;
    import ui.PreGameMainMenu;
    import ui.GiftMenu;
    import ui.SecretPopup;
    import ui.UserAgreement;
    import ui.UnavailableCharacterPopup;
    import ui.items.ServerXmlItem;
    import ui.items.GiftCharacterSelectionItem;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.ConnectionApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import flash.utils.Timer;
    import d2hooks.AuthentificationStart;
    import d2hooks.ServerSelectionStart;
    import d2hooks.CharacterSelectionStart;
    import d2hooks.CharacterCreationStart;
    import d2hooks.ServersList;
    import d2hooks.SelectedServerRefused;
    import d2hooks.GameStart;
    import d2hooks.GiftList;
    import d2hooks.CharactersListUpdated;
    import d2hooks.CharacterImpossibleSelection;
    import d2hooks.TutorielAvailable;
    import d2hooks.BreedsAvailable;
    import d2hooks.OpenMainMenu;
    import d2hooks.ConnectionTimerStart;
    import d2hooks.ServerConnectionFailed;
    import d2hooks.UnexpectedSocketClosure;
    import d2hooks.AlreadyConnected;
    import d2hooks.UpdaterConnectionFailed;
    import d2hooks.LoginQueueStatus;
    import d2hooks.QueueStatus;
    import d2hooks.NicknameRegistration;
    import d2hooks.IdentificationSuccess;
    import d2hooks.IdentificationFailed;
    import d2hooks.IdentificationFailedWithDuration;
    import d2hooks.IdentificationFailedForBadVersion;
    import d2hooks.AuthenticationTicketAccepted;
    import d2hooks.AuthenticationTicketRefused;
    import d2hooks.InformationPopup;
    import d2hooks.AgreementsRequired;
    import d2enums.BuildTypeEnum;
    import d2actions.ChangeServer;
    import d2actions.ChangeCharacter;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.CharacterSelection;
    import flash.events.TimerEvent;
    import d2enums.IdentificationFailureReasonEnum;
    import d2actions.ResetGame;
    import d2hooks.*;

    public class Connection extends Sprite 
    {

        public static var loginUiName:String = "login";
        private static var _self:Connection;
        public static var TUTORIAL_SELECTION:Boolean = false;
        public static var TUTORIAL_SELECTION_IS_AVAILABLE:Boolean = false;
        public static var BREEDS_AVAILABLE:int;
        public static var BREEDS_VISIBLE:int;
        public static var waitingForCreation:Boolean = false;
        public static var waitingForCharactersList:Boolean = false;
        public static var loginMustBeSaved:int;

        protected var login:Login;
        protected var loginThirdParty:LoginThirdParty;
        protected var serverSelection:ServerSelection;
        protected var serverSimpleSelection:ServerSimpleSelection;
        protected var serverListSelection:ServerListSelection;
        protected var serverForm:ServerForm;
        protected var serverPopup:ServerPopup;
        protected var serverImgXmlItem:ServerImgXmlItem;
        protected var characterCreation:CharacterCreation;
        protected var characterHeader:CharacterHeader;
        protected var characterSelection:CharacterSelection;
        protected var pseudoChoice:PseudoChoice;
        protected var preGameMainMenu:PreGameMainMenu;
        protected var giftMenu:GiftMenu;
        protected var secretPopup:SecretPopup;
        protected var userAgreement:UserAgreement;
        protected var unavailableCharacterPopup:UnavailableCharacterPopup;
        protected var serverXmlItem:ServerXmlItem;
        protected var giftCharaSelectItem:GiftCharacterSelectionItem;
        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var connecApi:ConnectionApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        public var previousUi:String = "";
        public var currentUi:String = null;
        public var _charaList:Object;
        public var _serversList:Object;
        public var _sPopup:String;
        private var _timeoutTimer:Timer;
        private var _timeoutPopupName:String;


        public static function getInstance():Connection
        {
            return (_self);
        }


        public function destroy():void
        {
            _self = null;
            this._charaList = null;
            this._serversList = null;
        }

        public function main():void
        {
            this.sysApi.addHook(AuthentificationStart, this.onAuthentificationStart);
            this.sysApi.addHook(ServerSelectionStart, this.onServerSelectionStart);
            this.sysApi.addHook(CharacterSelectionStart, this.onCharacterSelectionStart);
            this.sysApi.addHook(CharacterCreationStart, this.onCharacterCreationStart);
            this.sysApi.addHook(ServersList, this.onServersList);
            this.sysApi.addHook(SelectedServerRefused, this.onSelectedServerRefused);
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(GiftList, this.onGiftList);
            this.sysApi.addHook(CharactersListUpdated, this.onCharactersListUpdated);
            this.sysApi.addHook(CharacterImpossibleSelection, this.onCharacterImpossibleSelection);
            this.sysApi.addHook(TutorielAvailable, this.onTutorielAvailable);
            this.sysApi.addHook(BreedsAvailable, this.onBreedsAvailable);
            this.sysApi.addHook(OpenMainMenu, this.onOpenMainMenu);
            this.sysApi.addHook(ConnectionTimerStart, this.onConnectionTimerStart);
            this.sysApi.addHook(ServerConnectionFailed, this.onServerConnectionFailed);
            this.sysApi.addHook(UnexpectedSocketClosure, this.onUnexpectedSocketClosure);
            this.sysApi.addHook(AlreadyConnected, this.onAlreadyConnected);
            this.sysApi.addHook(UpdaterConnectionFailed, this.onUpdaterConnectionFailed);
            this.sysApi.addHook(LoginQueueStatus, this.removeTimer);
            this.sysApi.addHook(QueueStatus, this.removeTimer);
            this.sysApi.addHook(NicknameRegistration, this.removeTimer);
            this.sysApi.addHook(IdentificationSuccess, this.onIdentificationSuccess);
            this.sysApi.addHook(IdentificationFailed, this.onIdentificationFailed);
            this.sysApi.addHook(IdentificationFailedWithDuration, this.onIdentificationFailed);
            this.sysApi.addHook(IdentificationFailedForBadVersion, this.onIdentificationFailedForBadVersion);
            this.sysApi.addHook(AuthenticationTicketAccepted, this.onConnectionStart);
            this.sysApi.addHook(AuthenticationTicketRefused, this.removeTimer);
            this.sysApi.addHook(InformationPopup, this.onInformationPopup);
            if (this.sysApi.getConfigEntry("config.community.current") != "ja")
            {
                this.sysApi.addHook(AgreementsRequired, this.onAgreementsRequired);
            };
            this.uiApi.addShortcutHook("closeUi", this.onOpenMainMenu);
            if (this.sysApi.getConfigEntry("config.loginMode") == "web")
            {
                loginUiName = "loginThirdParty";
            };
            loginMustBeSaved = this.sysApi.getData("saveLogin");
            _self = this;
        }

        public function connexionEnd():void
        {
            this.onGameStart();
        }

        public function characterCreationStart():void
        {
            waitingForCreation = true;
            this.onCharacterCreationStart();
        }

        public function displayHeader():void
        {
            if (!(this.uiApi.getUi("characterHeader")))
            {
                this.uiApi.loadUi("characterHeader");
            };
        }

        private function onAgreementsRequired(files:Object):void
        {
            if (!(this.uiApi.getUi("userAgreement")))
            {
                this.uiApi.loadUi("userAgreement", "userAgreement", files, 3);
            };
        }

        private function onAuthentificationStart():void
        {
            var lastWarning2:Number;
            var now2:Number;
            this.uiApi.loadUi(loginUiName, null, this._sPopup);
            if (((((((!((this.sysApi.getBuildType() == BuildTypeEnum.BETA))) && (!(this.sysApi.isStreaming())))) && ((((this.sysApi.getOs() == "Linux")) || ((this.sysApi.getOs() == "Mac OS")))))) && (!(this.sysApi.isUpdaterVersion2OrUnknown()))))
            {
                this.sysApi.log(2, ("sysApi.getOs() " + this.sysApi.getOs()));
                if (!(this.sysApi.getData("lastUpdaterMigrationWarning")))
                {
                    this.sysApi.setData("lastUpdaterMigrationWarning", 0);
                };
                lastWarning2 = this.sysApi.getData("lastUpdaterMigrationWarning");
                now2 = new Date().getTime();
                if ((((((this.sysApi.getBuildType() == BuildTypeEnum.TESTING)) && ((((lastWarning2 == 0)) || (((now2 - lastWarning2) > 0x6DDD00)))))) || ((((now2 >= 1393920000000)) && ((((lastWarning2 == 0)) || (((now2 - lastWarning2) > 172800000))))))))
                {
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.report.updaterMigration.popup"), [this.uiApi.getText("ui.common.ok")], [this.onPopupWait], this.onPopupWait, null, null, false, true);
                    this.sysApi.setData("lastUpdaterMigrationWarning", now2);
                };
            };
        }

        public function openPreviousUi():void
        {
            switch (this.previousUi)
            {
                case "characterCreation":
                case loginUiName:
                    this.onPreviousUiStart();
                    break;
                case "serverListSelection":
                case "serverSelection":
                case "serverSimpleSelection":
                    this.sysApi.sendAction(new ChangeServer());
                    break;
                case "characterSelection":
                default:
                    if (((this._charaList) && ((this._charaList.length > 0))))
                    {
                        waitingForCharactersList = true;
                        this.onCharacterSelectionStart(this._charaList);
                    }
                    else
                    {
                        if (this.sysApi.getCurrentServer())
                        {
                            this.sysApi.sendAction(new ChangeCharacter(this.sysApi.getCurrentServer().id));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChangeServer());
                        };
                    };
            };
        }

        private function unlockLogin():void
        {
            var login:Object = this.uiApi.getUi("login");
            if (((login) && (login.uiClass)))
            {
                login.uiClass.disableUi(false);
            };
        }

        private function onConnectionStart():void
        {
            if (this.uiApi.getUi(loginUiName))
            {
                this.previousUi = loginUiName;
                this.uiApi.unloadUi(loginUiName);
                this.uiApi.unloadUi(UIEnum.WEB_PORTAL);
            };
        }

        private function onCharacterSelectionStart(characterList:Object):void
        {
            if (((!(this.uiApi.getUi("characterCreation"))) || (waitingForCharactersList)))
            {
                if (TUTORIAL_SELECTION)
                {
                    if (TUTORIAL_SELECTION_IS_AVAILABLE)
                    {
                        TUTORIAL_SELECTION = false;
                        this.sysApi.sendAction(new CharacterSelection(characterList[0].id, true));
                    }
                    else
                    {
                        this.sysApi.sendAction(new CharacterSelection(characterList[0].id, false));
                    };
                }
                else
                {
                    this._charaList = characterList;
                    this.displayHeader();
                    if (!(this.uiApi.getUi("characterSelection")))
                    {
                        this.uiApi.loadUi("characterSelection", "characterSelection", this._charaList);
                    };
                    this.previousUi = this.currentUi;
                    this.currentUi = "characterSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                };
                waitingForCharactersList = false;
            };
        }

        private function onCharacterCreationStart(params:Object=null):void
        {
            if (((((waitingForCreation) || (((((((params) && (params[0]))) && ((params[0][0] == "create")))) && ((params[1] == true)))))) || (((((params) && (params[0]))) && (!((params[0][0] == "create")))))))
            {
                this.displayHeader();
                if (!(this.uiApi.getUi("characterCreation")))
                {
                    this.uiApi.loadUi("characterCreation", "characterCreation", params);
                    this.previousUi = this.currentUi;
                    this.currentUi = "characterCreation";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                };
                waitingForCreation = false;
            };
        }

        private function onServerSelectionStart(params:Object=null):void
        {
            waitingForCreation = params[1];
            this.displayHeader();
            switch (params[0])
            {
                case 1:
                    this.uiApi.loadUi("serverListSelection");
                    this.previousUi = this.currentUi;
                    this.currentUi = "serverListSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                    break;
                case 2:
                    this.uiApi.loadUi("serverSimpleSelection");
                    this.previousUi = this.currentUi;
                    this.currentUi = "serverSimpleSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                    break;
                case 0:
                default:
                    this.uiApi.loadUi("serverSelection");
                    this.previousUi = this.currentUi;
                    this.currentUi = "serverSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
            };
        }

        private function onServersList(serverList:Object):void
        {
            var serversWithCharacters:Array;
            var server:Object;
            this._serversList = serverList;
            if (((((!(this.uiApi.getUi("serverSelection"))) && (!(this.uiApi.getUi("serverListSelection"))))) && (!(this.uiApi.getUi("serverSimpleSelection")))))
            {
                serversWithCharacters = new Array();
                for each (server in this.connecApi.getUsedServers())
                {
                    serversWithCharacters.push(server);
                };
                if ((((serversWithCharacters.length > 0)) && (!(waitingForCreation))))
                {
                    this.displayHeader();
                    this.uiApi.loadUi("serverSelection");
                    this.previousUi = this.currentUi;
                    this.currentUi = "serverSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                }
                else
                {
                    this.onServerSelectionStart([2, true]);
                };
            };
        }

        private function onPreviousUiStart():void
        {
            this.displayHeader();
            this.uiApi.loadUi(this.previousUi);
            var currUi:String = this.previousUi;
            this.previousUi = this.currentUi;
            this.currentUi = currUi;
            if (this.previousUi)
            {
                this.uiApi.unloadUi(this.previousUi);
            };
        }

        private function onGameStart():void
        {
            this.uiApi.unloadUi(this.currentUi);
            this.uiApi.unloadUi("characterSelection");
            this.uiApi.unloadUi("characterHeader");
            this._charaList = null;
        }

        private function onOpenMainMenu(s:String=""):Boolean
        {
            if (!(this.uiApi.getUi("preGameMainMenu")))
            {
                this.uiApi.loadUi("preGameMainMenu", null, [], 3);
            }
            else
            {
                this.uiApi.unloadUi("preGameMainMenu");
            };
            return (true);
        }

        private function onGiftList(giftList:Object, characterList:Object):void
        {
            if (!(this.uiApi.getUi("giftMenu")))
            {
                this.uiApi.loadUi("giftMenu", "giftMenu", {
                    "gift":giftList,
                    "chara":characterList
                }, 2);
            };
            this.previousUi = this.currentUi;
            this.currentUi = "giftMenu";
            if (this.previousUi)
            {
                this.uiApi.unloadUi(this.previousUi);
            };
        }

        private function onTutorielAvailable(tutorielAvailable:Boolean):void
        {
            TUTORIAL_SELECTION_IS_AVAILABLE = tutorielAvailable;
        }

        private function onBreedsAvailable(breedsAvailable:int, breedsVisible:int):void
        {
            BREEDS_AVAILABLE = breedsAvailable;
            BREEDS_VISIBLE = breedsVisible;
        }

        public function onCharactersListUpdated(charactersList:Object):void
        {
            var cha:*;
            this._charaList = new Array();
            for each (cha in charactersList)
            {
                this._charaList.push(cha);
            };
        }

        public function onConnectionTimerStart():void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeoutTimer.reset();
                this._timeoutTimer = null;
            };
            this._timeoutTimer = new Timer(10000, 1);
            this._timeoutTimer.start();
            this._timeoutTimer.addEventListener(TimerEvent.TIMER, this.onTimeOut);
        }

        public function onCharacterImpossibleSelection(pCharacterId:uint):void
        {
        }

        public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object):void
        {
            var text:String;
            var _local_5:String;
            var server:*;
            this.removeTimer();
            switch (error)
            {
                case "AccountRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
                    break;
                case "CommunityRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.communityRestricted");
                    break;
                case "LocationRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.locationRestricted");
                    break;
                case "SubscribersOnly":
                    text = this.uiApi.getText("ui.server.cantChoose.communityNonSubscriberRestricted");
                    break;
                case "RegularPlayersOnly":
                    text = this.uiApi.getText("ui.server.cantChoose.regularPlayerRestricted");
                    break;
                case "StatusOffline":
                    this.sysApi.log(2, "StatusOffline");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusStarting":
                    this.sysApi.log(2, "StatusStarting");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusNojoin":
                    this.sysApi.log(2, "StatusNojoin");
                    text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
                    break;
                case "StatusSaving":
                    this.sysApi.log(2, "StatusSaving");
                    text = this.uiApi.getText("ui.server.cantChoose.serverSaving");
                    break;
                case "StatusStoping":
                    this.sysApi.log(2, "StatusStoping");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusFull":
                    text = (this.uiApi.getText("ui.server.cantChoose.serverFull") + "\n\n");
                    _local_5 = "";
                    for each (server in selectableServers)
                    {
                        _local_5 = (_local_5 + (this.dataApi.getServer(server).name + ", "));
                    };
                    if (_local_5 != "")
                    {
                        _local_5 = _local_5.substr(0, (_local_5.length - 2));
                    }
                    else
                    {
                        _local_5 = this.uiApi.getText("ui.common.none").toLocaleLowerCase();
                    };
                    text = (text + this.uiApi.getText("ui.server.serversAccessibles", _local_5));
                    break;
                case "NoReason":
                case "StatusUnknown":
                    text = this.uiApi.getText("ui.popup.connectionRefused");
                    break;
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
        }

        public function onIdentificationFailed(reason:uint, endDate:Number=0):void
        {
            var _local_3:String;
            this.removeTimer();
            if (reason > 0)
            {
                switch (reason)
                {
                    case IdentificationFailureReasonEnum.BANNED:
                        if (endDate == 0)
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.banned"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        }
                        else
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.bannedWithDuration", ((this.timeApi.getDate(endDate, true) + " ") + this.timeApi.getClock(endDate, false, true))), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        };
                        break;
                    case IdentificationFailureReasonEnum.IN_MAINTENANCE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.inMaintenance"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.KICKED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.kicked"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.UNKNOWN_AUTH_ERROR:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.unknown"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.WRONG_CREDENTIALS:
                        _local_3 = ((this.sysApi.isGuest()) ? this.uiApi.getText("ui.popup.accessDenied.guestAccountNotFound") : this.uiApi.getText("ui.popup.accessDenied.wrongCredentials"));
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), _local_3, [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.BAD_IPRANGE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.badIpRange"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.TOO_MANY_ON_IP:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.toomanyonip"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.TIME_OUT:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.CREDENTIALS_RESET:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.credentialsReset"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.EMAIL_UNVALIDATED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.unvalidatedEmail"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.SERVICE_UNAVAILABLE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.serviceUnavailable"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.OTP_TIMEOUT:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.otpTimeout"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.SPARE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), "", [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                };
            };
            this.unlockLogin();
        }

        public function onIdentificationSuccess(login:String):void
        {
            var oldLogins:Array;
            var logins:Array;
            var oldLogIndex:*;
            var oldLog:String;
            var logins2:Array;
            var oldLog2:String;
            this.removeTimer();
            if (((login) && ((login.length > 0))))
            {
                if (login.indexOf("[GUEST]") == 0)
                {
                    return;
                };
                oldLogins = this.sysApi.getData("LastLogins");
                if (loginMustBeSaved > -1)
                {
                    logins = new Array();
                    for (oldLogIndex in oldLogins)
                    {
                        if (((oldLogins[oldLogIndex]) && ((oldLogins[oldLogIndex].toLowerCase() == login.toLowerCase()))))
                        {
                            oldLogins.splice(oldLogIndex, 1);
                            break;
                        };
                    };
                    logins.push(login);
                    for each (oldLog in oldLogins)
                    {
                        if ((((logins.length < 10)) && ((logins.indexOf(oldLog) == -1))))
                        {
                            logins.push(oldLog);
                        };
                    };
                    this.sysApi.setData("LastLogins", logins);
                }
                else
                {
                    if (((oldLogins) && ((oldLogins.length > 0))))
                    {
                        logins2 = new Array();
                        for each (oldLog2 in oldLogins)
                        {
                            if (((oldLog2) && (!((oldLog2.toLowerCase() == login.toLowerCase())))))
                            {
                                logins2.push(oldLog2);
                            };
                        };
                        this.sysApi.setData("LastLogins", logins2);
                    };
                };
            };
        }

        public function onIdentificationFailedForBadVersion(reason:uint, requiredVersion:Object):void
        {
            this.removeTimer();
            if (reason == IdentificationFailureReasonEnum.BAD_VERSION)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.badVersion", this.sysApi.getCurrentVersion(), ((((((((requiredVersion.major + ".") + requiredVersion.minor) + ".") + requiredVersion.release) + ".") + requiredVersion.revision) + ".") + requiredVersion.patch)), [this.uiApi.getText("ui.common.ok")]);
            };
            this.unlockLogin();
        }

        public function onServerConnectionFailed(reason:uint=0):void
        {
            this.removeTimer();
            if (reason == 4)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.silentServer"), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.connectionFailed.text"), [this.uiApi.getText("ui.common.ok")]);
            };
            this.unlockLogin();
        }

        public function onUnexpectedSocketClosure():void
        {
            this.removeTimer();
            this._sPopup = "unexpectedSocketClosure";
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"), this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"), [this.uiApi.getText("ui.common.ok")]);
            this.unlockLogin();
        }

        public function onAlreadyConnected():void
        {
            this.removeTimer();
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.connection.disconnectAccount"), [this.uiApi.getText("ui.common.ok")]);
            this.unlockLogin();
        }

        public function onInformationPopup(msg:String):void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), msg, [this.uiApi.getText("ui.common.ok")]);
        }

        public function onTimeOut(e:TimerEvent):void
        {
            this.removeTimer();
            this._timeoutPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.wait"), this.uiApi.getText("ui.common.interrupt")], [this.onPopupWait, this.onPopupInterrupt], this.onPopupWait, this.onPopupInterrupt);
        }

        public function onPopupWait():void
        {
        }

        public function onPopupInterrupt():void
        {
            this.sysApi.sendAction(new ResetGame());
        }

        public function removeTimer(... args):void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeoutTimer.reset();
                this._timeoutTimer = null;
            };
        }

        private function onUpdaterConnectionFailed():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.connection.updaterConnectionFailed"), [this.uiApi.getText("ui.common.ok")]);
        }


    }
}//package 

