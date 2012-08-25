package com.ankamagames.dofus.logic.game.approach.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.messages.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.approach.actions.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.dofus.network.messages.game.approach.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.dofus.network.messages.game.character.choice.*;
    import com.ankamagames.dofus.network.messages.game.character.creation.*;
    import com.ankamagames.dofus.network.messages.game.character.deletion.*;
    import com.ankamagames.dofus.network.messages.game.character.replay.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.startup.*;
    import com.ankamagames.dofus.network.messages.security.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.dofus.network.types.game.startup.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class GameServerApproachFrame extends Object implements Frame
    {
        private var _charactersList:Array;
        private var _charactersToRecolorList:Array;
        private var _charactersToRenameList:Array;
        private var _giftList:Array;
        private var _kernel:KernelEventsManager;
        private var _gmaf:LoadingModuleFrame;
        private var _waitingMessages:Vector.<Message>;
        private var _cssmsg:CharacterSelectedSuccessMessage;
        private var _requestedCharacterId:uint;
        private var _lc:LoaderContext;
        private var commonMod:Object;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GameServerApproachFrame));
        private static var _changeLogLoader:Loader = new Loader();

        public function GameServerApproachFrame()
        {
            this._charactersList = new Array();
            this._charactersToRecolorList = new Array();
            this._charactersToRenameList = new Array();
            this._giftList = new Array();
            this._kernel = KernelEventsManager.getInstance();
            this._lc = new LoaderContext(false, ApplicationDomain.currentDomain);
            this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get requestedCharaId() : uint
        {
            return this._requestedCharacterId;
        }// end function

        public function set requestedCharaId(param1:uint) : void
        {
            this._requestedCharacterId = param1;
            return;
        }// end function

        public function isCharacterWaitingForChange(param1:uint) : Boolean
        {
            if (this._charactersToRecolorList[param1])
            {
                return true;
            }
            return false;
        }// end function

        public function pushed() : Boolean
        {
            if (AirScanner.hasAir())
            {
                this._lc["allowLoadBytesCodeExecution"] = true;
            }
            Kernel.getWorker().addFrame(new MiscFrame());
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var perso:*;
            var color:*;
            var characterId:int;
            var characterColors:Array;
            var characterName:String;
            var recolors:Vector.<int>;
            var isReplay:Boolean;
            var parts:Vector.<uint>;
            var atamsg:AuthenticationTicketAcceptedMessage;
            var atrmsg:AuthenticationTicketRefusedMessage;
            var scfMsg:ServerConnectionFailedMessage;
            var acmsg:AlreadyConnectedMessage;
            var clmsg:CharactersListMessage;
            var unusableCharacters:Vector.<uint>;
            var o:Object;
            var accmsg:AccountCapabilitiesMessage;
            var cca:CharacterCreationAction;
            var ccmsg:CharacterCreationRequestMessage;
            var colors:Vector.<int>;
            var ccrmsg:CharacterCreationResultMessage;
            var cda:CharacterDeletionAction;
            var cdrmsg:CharacterDeletionRequestMessage;
            var cdemsg:CharacterDeletionErrorMessage;
            var reason:String;
            var cnsra:CharacterNameSuggestionRequestAction;
            var cnsrmsg:CharacterNameSuggestionRequestMessage;
            var cnssmsg:CharacterNameSuggestionSuccessMessage;
            var cnsfmsg:CharacterNameSuggestionFailureMessage;
            var bTutorial:Boolean;
            var cssmsg:CharacterSelectedSuccessMessage;
            var flashKeyMsg:ClientKeyMessage;
            var gccrmsg:GameContextCreateRequestMessage;
            var soundApi:SoundApi;
            var csemmpmsg:CharacterSelectedErrorMissingMapPackMessage;
            var subArea:SubArea;
            var pack:Pack;
            var csemsg:CharacterSelectedErrorMessage;
            var btmsg:BasicTimeMessage;
            var date:Date;
            var salm:StartupActionsListMessage;
            var cclMsg:ConsoleCommandsListMessage;
            var atwcpmsg:AuthenticationTicketWithClientPacksMessage;
            var atmsg:AuthenticationTicketMessage;
            var clwrmsg:CharactersListWithModificationsMessage;
            var ctri:CharacterToRecolorInformation;
            var ctrid:uint;
            var charColors:Array;
            var num:int;
            var i:int;
            var uIndexedColor:Number;
            var uIndex:int;
            var uColor:int;
            var chi:CharacterHardcoreInformations;
            var cbi:CharacterBaseInformations;
            var bonusXp:int;
            var cbi2:CharacterBaseInformations;
            var saem:StartupActionsExecuteMessage;
            var c:*;
            var persoc:Object;
            var crwrrmsg:CharacterReplayWithRecolorRequestMessage;
            var cswrmsg:CharacterSelectionWithRecolorMessage;
            var person:Object;
            var crwrnrmsg:CharacterReplayWithRenameRequestMessage;
            var cswrnmsg:CharacterSelectionWithRenameMessage;
            var charToColor:*;
            var charToRename2:Object;
            var firstSelection:Boolean;
            var cfsmsg:CharacterFirstSelectionMessage;
            var crrmsg:CharacterReplayRequestMessage;
            var csmsg:CharacterSelectionMessage;
            var gift:StartupActionAddObject;
            var _items:Array;
            var item:ObjectItemInformationWithQuantity;
            var oj:Object;
            var iw:ItemWrapper;
            var charaListMinusDeadPeople:Array;
            var gar:GiftAssignRequestAction;
            var sao:StartupActionsObjetAttributionMessage;
            var safm:StartupActionFinishedMessage;
            var cmdIndex:uint;
            var msg:* = param1;
            switch(true)
            {
                case msg is HelloGameMessage:
                {
                    ConnectionsHandler.confirmGameServerConnection();
                    parts = PartManager.getInstance().getServerPartList();
                    if (parts != null && parts.length > 0)
                    {
                        if (!Kernel.getWorker().getFrame(UpdaterDialogFrame))
                        {
                            Kernel.getWorker().addFrame(new UpdaterDialogFrame());
                        }
                        atwcpmsg = new AuthenticationTicketWithClientPacksMessage();
                        atwcpmsg.initAuthenticationTicketWithClientPacksMessage(LangManager.getInstance().getEntry("config.lang.current"), AuthentificationManager.getInstance().gameServerTicket, parts);
                        ConnectionsHandler.getConnection().send(atwcpmsg);
                    }
                    else
                    {
                        atmsg = new AuthenticationTicketMessage();
                        atmsg.initAuthenticationTicketMessage(LangManager.getInstance().getEntry("config.lang.current"), AuthentificationManager.getInstance().gameServerTicket);
                        ConnectionsHandler.getConnection().send(atmsg);
                    }
                    InactivityManager.getInstance().start();
                    this._kernel.processCallback(HookList.AuthenticationTicket);
                    return true;
                }
                case msg is AuthenticationTicketAcceptedMessage:
                {
                    atamsg = msg as AuthenticationTicketAcceptedMessage;
                    setTimeout(this.requestCharactersList, 500);
                    this._kernel.processCallback(HookList.AuthenticationTicketAccepted);
                    return true;
                }
                case msg is AuthenticationTicketRefusedMessage:
                {
                    atrmsg = msg as AuthenticationTicketRefusedMessage;
                    this._kernel.processCallback(HookList.AuthenticationTicketRefused);
                    return true;
                }
                case msg is ServerConnectionFailedMessage:
                {
                    scfMsg = ServerConnectionFailedMessage(msg);
                    if (scfMsg.failedConnection == ConnectionsHandler.getConnection())
                    {
                        PlayerManager.getInstance().destroy();
                        this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.connexion.gameConnexionFailed"), [I18n.getUiText("ui.common.ok")], [this.onEscapePopup], this.onEscapePopup, this.onEscapePopup);
                        KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                    }
                    return true;
                }
                case msg is AlreadyConnectedMessage:
                {
                    acmsg = AlreadyConnectedMessage(msg);
                    KernelEventsManager.getInstance().processCallback(HookList.AlreadyConnected);
                    return true;
                }
                case msg is CharactersListMessage:
                {
                    clmsg = msg as CharactersListMessage;
                    unusableCharacters = new Vector.<uint>;
                    if (msg is CharactersListWithModificationsMessage)
                    {
                        clwrmsg = msg as CharactersListWithModificationsMessage;
                        var _loc_3:int = 0;
                        var _loc_4:* = clwrmsg.charactersToRecolor;
                        while (_loc_4 in _loc_3)
                        {
                            
                            ctri = _loc_4[_loc_3];
                            charColors = new Array(-1, -1, -1, -1, -1);
                            num = ctri.colors.length;
                            i;
                            while (i < num)
                            {
                                
                                uIndexedColor = ctri.colors[i];
                                uIndex = (uIndexedColor >> 24) - 1;
                                uColor = uIndexedColor & 16777215;
                                if (uIndex > -1 && uIndex < charColors.length)
                                {
                                    charColors[uIndex] = uColor;
                                }
                                i = (i + 1);
                            }
                            this._charactersToRecolorList[ctri.id] = {id:ctri.id, colors:charColors};
                        }
                        var _loc_3:int = 0;
                        var _loc_4:* = clwrmsg.charactersToRename;
                        while (_loc_4 in _loc_3)
                        {
                            
                            ctrid = _loc_4[_loc_3];
                            this._charactersToRenameList.push(ctrid);
                        }
                        var _loc_3:int = 0;
                        var _loc_4:* = clwrmsg.unusableCharacters;
                        while (_loc_4 in _loc_3)
                        {
                            
                            ctrid = _loc_4[_loc_3];
                            unusableCharacters.push(ctrid);
                        }
                    }
                    this._charactersList = new Array();
                    if (PlayerManager.getInstance().server.gameTypeId == 1)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = clmsg.characters;
                        while (_loc_4 in _loc_3)
                        {
                            
                            chi = _loc_4[_loc_3];
                            o;
                            o.bonusXp = 1;
                            if (unusableCharacters.indexOf(chi.id) != -1)
                            {
                                o.unusable = true;
                            }
                            else
                            {
                                o.unusable = false;
                            }
                            _log.debug(" - [" + chi.id + "] " + chi.name + " (Lv " + chi.level + ") - " + o.entityLook);
                            this._charactersList.push(o);
                        }
                    }
                    else
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = clmsg.characters;
                        while (_loc_4 in _loc_3)
                        {
                            
                            cbi = _loc_4[_loc_3];
                            o;
                            bonusXp;
                            var _loc_5:int = 0;
                            var _loc_6:* = clmsg.characters;
                            while (_loc_6 in _loc_5)
                            {
                                
                                cbi2 = _loc_6[_loc_5];
                                if (cbi2.id != cbi.id && cbi2.level > cbi.level && bonusXp < 4)
                                {
                                    bonusXp = (bonusXp + 1);
                                }
                            }
                            o.bonusXp = bonusXp;
                            if (unusableCharacters.indexOf(cbi.id) != -1)
                            {
                                o.unusable = true;
                            }
                            else
                            {
                                o.unusable = false;
                            }
                            _log.debug(" - [" + cbi.id + "] " + cbi.name + " (Lv " + cbi.level + ") - XP x" + bonusXp + "  " + o.entityLook);
                            this._charactersList.push(o);
                        }
                    }
                    if (this._charactersList.length)
                    {
                        if (clmsg.hasStartupActions)
                        {
                            saem = new StartupActionsExecuteMessage();
                            saem.initStartupActionsExecuteMessage();
                            ConnectionsHandler.getConnection().send(saem);
                        }
                        else if (!Berilia.getInstance().getUi("characterSelection"))
                        {
                            this._kernel.processCallback(HookList.CharacterSelectionStart, this._charactersList);
                        }
                        else
                        {
                            this._kernel.processCallback(HookList.CharactersListUpdated, this._charactersList);
                        }
                    }
                    else
                    {
                        this._kernel.processCallback(HookList.CharacterCreationStart, ["create", true]);
                        this._kernel.processCallback(HookList.CharactersListUpdated, this._charactersList);
                    }
                    return true;
                }
                case msg is CharactersListErrorMessage:
                {
                    _log.error("Characters list error.");
                    this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.connexion.charactersListError"), [I18n.getUiText("ui.common.ok")]);
                    return false;
                }
                case msg is AccountCapabilitiesMessage:
                {
                    accmsg = msg as AccountCapabilitiesMessage;
                    this._kernel.processCallback(HookList.TutorielAvailable, accmsg.tutorialAvailable);
                    this._kernel.processCallback(HookList.BreedsAvailable, accmsg.breedsAvailable, accmsg.breedsVisible);
                    PlayerManager.getInstance().adminStatus = accmsg.status;
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterCreationStart, ["create"]);
                    return true;
                }
                case msg is CharacterCreationAction:
                {
                    cca = msg as CharacterCreationAction;
                    ccmsg = new CharacterCreationRequestMessage();
                    colors = new Vector.<int>;
                    var _loc_3:int = 0;
                    var _loc_4:* = cca.colors;
                    while (_loc_4 in _loc_3)
                    {
                        
                        c = _loc_4[_loc_3];
                        colors.push(c);
                    }
                    while (colors.length < ProtocolConstants.MAX_PLAYER_COLOR)
                    {
                        
                        colors.push(-1);
                    }
                    ccmsg.initCharacterCreationRequestMessage(cca.name, cca.breed, cca.sex, colors);
                    ConnectionsHandler.getConnection().send(ccmsg);
                    return true;
                }
                case msg is CharacterCreationResultMessage:
                {
                    ccrmsg = msg as CharacterCreationResultMessage;
                    this._kernel.processCallback(HookList.CharacterCreationResult, ccrmsg.result);
                    return true;
                }
                case msg is CharacterDeletionAction:
                {
                    cda = msg as CharacterDeletionAction;
                    cdrmsg = new CharacterDeletionRequestMessage();
                    cdrmsg.initCharacterDeletionRequestMessage(cda.id, MD5.hex_md5(cda.id + "~" + cda.answer));
                    ConnectionsHandler.getConnection().send(cdrmsg);
                    return true;
                }
                case msg is CharacterDeletionErrorMessage:
                {
                    cdemsg = msg as CharacterDeletionErrorMessage;
                    reason;
                    if (cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_TOO_MANY_CHAR_DELETION)
                    {
                        reason;
                    }
                    else if (cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_BAD_SECRET_ANSWER)
                    {
                        reason;
                    }
                    else if (cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_RESTRICED_ZONE)
                    {
                        reason;
                    }
                    this._kernel.processCallback(HookList.CharacterDeletionError, reason);
                    return true;
                }
                case msg is CharacterNameSuggestionRequestAction:
                {
                    cnsra = msg as CharacterNameSuggestionRequestAction;
                    cnsrmsg = new CharacterNameSuggestionRequestMessage();
                    cnsrmsg.initCharacterNameSuggestionRequestMessage();
                    ConnectionsHandler.getConnection().send(cnsrmsg);
                    return true;
                }
                case msg is CharacterNameSuggestionSuccessMessage:
                {
                    cnssmsg = msg as CharacterNameSuggestionSuccessMessage;
                    this._kernel.processCallback(HookList.CharacterNameSuggestioned, cnssmsg.suggestion);
                    return true;
                }
                case msg is CharacterNameSuggestionFailureMessage:
                {
                    cnsfmsg = msg as CharacterNameSuggestionFailureMessage;
                    _log.error("Generation de nom impossible !");
                    return true;
                }
                case msg is CharacterSelectedForceMessage:
                {
                    Kernel.beingInReconection = true;
                    characterId = CharacterSelectedForceMessage(msg).id;
                    ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
                    return true;
                }
                case msg is CharacterRecolorSelectionAction:
                {
                    if (PlayerManager.getInstance().server.gameTypeId == 1)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._charactersList;
                        while (_loc_4 in _loc_3)
                        {
                            
                            persoc = _loc_4[_loc_3];
                            if (persoc.id == (msg as CharacterRecolorSelectionAction).characterId)
                            {
                                if (persoc.deathState == 1)
                                {
                                    isReplay;
                                    continue;
                                }
                                if (persoc.deathState == 0)
                                {
                                    isReplay;
                                    continue;
                                }
                                _log.error("perso dans les limbes !!");
                                this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.common.cantSelectThisCharacterLimb"), [I18n.getUiText("ui.common.ok")]);
                            }
                        }
                    }
                    else
                    {
                        isReplay;
                    }
                    characterId = (msg as CharacterRecolorSelectionAction).characterId;
                    characterColors = (msg as CharacterRecolorSelectionAction).characterColors;
                    recolors = new Vector.<int>;
                    var _loc_3:int = 0;
                    var _loc_4:* = characterColors;
                    while (_loc_4 in _loc_3)
                    {
                        
                        color = _loc_4[_loc_3];
                        recolors.push(color);
                    }
                    while (recolors.length < ProtocolConstants.MAX_PLAYER_COLOR)
                    {
                        
                        recolors.push(-1);
                    }
                    if (isReplay)
                    {
                        crwrrmsg = new CharacterReplayWithRecolorRequestMessage();
                        crwrrmsg.initCharacterReplayWithRecolorRequestMessage(characterId, recolors);
                        ConnectionsHandler.getConnection().send(crwrrmsg);
                    }
                    else
                    {
                        cswrmsg = new CharacterSelectionWithRecolorMessage();
                        cswrmsg.initCharacterSelectionWithRecolorMessage(characterId, recolors);
                        ConnectionsHandler.getConnection().send(cswrmsg);
                    }
                    return true;
                }
                case msg is CharacterRenameSelectionAction:
                {
                    if (PlayerManager.getInstance().server.gameTypeId == 1)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._charactersList;
                        while (_loc_4 in _loc_3)
                        {
                            
                            person = _loc_4[_loc_3];
                            if (person.id == (msg as CharacterRenameSelectionAction).characterId)
                            {
                                if (person.deathState == 1)
                                {
                                    isReplay;
                                    continue;
                                }
                                if (person.deathState == 0)
                                {
                                    isReplay;
                                    continue;
                                }
                                _log.error("perso dans les limbes !!");
                                this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.common.cantSelectThisCharacterLimb"), [I18n.getUiText("ui.common.ok")]);
                            }
                        }
                    }
                    else
                    {
                        isReplay;
                    }
                    characterId = (msg as CharacterRenameSelectionAction).characterId;
                    characterName = (msg as CharacterRenameSelectionAction).characterName;
                    if (isReplay)
                    {
                        crwrnrmsg = new CharacterReplayWithRenameRequestMessage();
                        crwrnrmsg.initCharacterReplayWithRenameRequestMessage(characterId, characterName);
                        ConnectionsHandler.getConnection().send(crwrnrmsg);
                    }
                    else
                    {
                        cswrnmsg = new CharacterSelectionWithRenameMessage();
                        cswrnmsg.initCharacterSelectionWithRenameMessage(characterId, characterName);
                        ConnectionsHandler.getConnection().send(cswrnmsg);
                    }
                    return true;
                }
                case msg is CharacterDeselectionAction:
                {
                    this._requestedCharacterId = 0;
                    return true;
                }
                case msg is CharacterSelectionAction:
                case msg is CharacterReplayRequestAction:
                {
                    if (this._requestedCharacterId)
                    {
                        return false;
                    }
                    bTutorial;
                    if (msg is CharacterSelectionAction)
                    {
                        characterId = (msg as CharacterSelectionAction).characterId;
                        bTutorial = (msg as CharacterSelectionAction).btutoriel;
                        isReplay;
                    }
                    else if (msg is CharacterReplayRequestAction)
                    {
                        characterId = (msg as CharacterReplayRequestAction).characterId;
                        bTutorial;
                        isReplay;
                    }
                    this._requestedCharacterId = characterId;
                    if (this._charactersToRecolorList[characterId])
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._charactersList;
                        while (_loc_4 in _loc_3)
                        {
                            
                            perso = _loc_4[_loc_3];
                            if (perso.id == characterId)
                            {
                                charToColor = perso;
                            }
                        }
                        this._kernel.processCallback(HookList.CharacterCreationStart, new Array("recolor", charToColor, this._charactersToRecolorList[characterId].colors));
                    }
                    else if (this._charactersToRenameList.indexOf(characterId) != -1)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = this._charactersList;
                        while (_loc_4 in _loc_3)
                        {
                            
                            perso = _loc_4[_loc_3];
                            if (perso.id == characterId)
                            {
                                charToRename2 = perso;
                            }
                        }
                        this._kernel.processCallback(HookList.CharacterCreationStart, new Array("rename", charToRename2));
                    }
                    else
                    {
                        firstSelection = bTutorial;
                        if (bTutorial)
                        {
                            cfsmsg = new CharacterFirstSelectionMessage();
                            cfsmsg.initCharacterFirstSelectionMessage(characterId, true);
                            ConnectionsHandler.getConnection().send(cfsmsg);
                        }
                        else if (isReplay)
                        {
                            crrmsg = new CharacterReplayRequestMessage();
                            crrmsg.initCharacterReplayRequestMessage(characterId);
                            ConnectionsHandler.getConnection().send(crrmsg);
                        }
                        else
                        {
                            csmsg = new CharacterSelectionMessage();
                            csmsg.initCharacterSelectionMessage(characterId);
                            ConnectionsHandler.getConnection().send(csmsg);
                        }
                    }
                    return true;
                }
                case msg is CharacterSelectedSuccessMessage:
                {
                    cssmsg = msg as CharacterSelectedSuccessMessage;
                    ConnectionsHandler.pause();
                    if (this._gmaf == null)
                    {
                        this._gmaf = new LoadingModuleFrame();
                        Kernel.getWorker().addFrame(this._gmaf);
                    }
                    PlayedCharacterManager.getInstance().infos = cssmsg.infos;
                    DataStoreType.CHARACTER_ID = cssmsg.infos.id.toString();
                    Kernel.getWorker().pause();
                    this._cssmsg = cssmsg;
                    UiModuleManager.getInstance().reset();
                    if (PlayerManager.getInstance().hasRights)
                    {
                        UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE, false);
                    }
                    else
                    {
                        UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE.concat(Constants.ADMIN_MODULE), false);
                    }
                    Dofus.getInstance().renameApp(cssmsg.infos.name);
                    return true;
                }
                case msg is AllModulesLoadedMessage:
                {
                    Kernel.getWorker().removeFrame(this._gmaf);
                    this._gmaf = null;
                    try
                    {
                        _changeLogLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onChangeLogError);
                        _changeLogLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onChangeLogLoaded);
                        if (AirScanner.hasAir())
                        {
                            _changeLogLoader.loadBytes(Base64.decodeToByteArray(I18n.getUiText("ui.link.changelog")), this._lc);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                    Kernel.getWorker().addFrame(new AlignmentFrame());
                    Kernel.getWorker().addFrame(new SynchronisationFrame());
                    Kernel.getWorker().addFrame(new LivingObjectFrame());
                    Kernel.getWorker().addFrame(new PrismFrame());
                    Kernel.getWorker().addFrame(new PlayedCharacterUpdatesFrame());
                    Kernel.getWorker().addFrame(new SocialFrame());
                    Kernel.getWorker().addFrame(new SpellInventoryManagementFrame());
                    Kernel.getWorker().addFrame(new InventoryManagementFrame());
                    Kernel.getWorker().addFrame(new ContextChangeFrame());
                    Kernel.getWorker().addFrame(new CommonUiFrame());
                    Kernel.getWorker().addFrame(new ChatFrame());
                    Kernel.getWorker().addFrame(new JobsFrame());
                    Kernel.getWorker().addFrame(new MountFrame());
                    Kernel.getWorker().addFrame(new HouseFrame());
                    Kernel.getWorker().addFrame(new RoleplayEmoticonFrame());
                    Kernel.getWorker().addFrame(new QuestFrame());
                    Kernel.getWorker().addFrame(new PartyManagementFrame());
                    Kernel.getWorker().addFrame(new ProtectPishingFrame());
                    Kernel.getWorker().addFrame(new StackManagementFrame());
                    Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(GameStartingFrame));
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    if (Kernel.beingInReconection)
                    {
                        ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
                    }
                    flashKeyMsg = new ClientKeyMessage();
                    flashKeyMsg.initClientKeyMessage(InterClientManager.getInstance().flashKey);
                    ConnectionsHandler.getConnection().send(flashKeyMsg);
                    if (this._cssmsg != null)
                    {
                        PlayedCharacterManager.getInstance().infos = this._cssmsg.infos;
                        DataStoreType.CHARACTER_ID = this._cssmsg.infos.id.toString();
                        _log.warn("Character selected : " + this._cssmsg.infos.name + " (Lv " + this._cssmsg.infos.level + ")");
                    }
                    Kernel.getWorker().removeFrame(this);
                    if (PlayerManager.getInstance().subscriptionEndDate > 0)
                    {
                        PartManager.getInstance().checkAndDownload("all");
                        PartManager.getInstance().checkAndDownload("subscribed");
                    }
                    if (XmlConfig.getInstance().getEntry("config.dev.mode"))
                    {
                        ModuleDebugManager.display(true);
                        Console.getInstance().display(true);
                    }
                    this._kernel.processCallback(HookList.GameStart);
                    gccrmsg = new GameContextCreateRequestMessage();
                    ConnectionsHandler.getConnection().send(gccrmsg);
                    soundApi = new SoundApi();
                    soundApi.stopIntroMusic();
                    return true;
                }
                case msg is ConnectionResumedMessage:
                {
                    return true;
                }
                case msg is CharacterSelectedErrorMissingMapPackMessage:
                {
                    csemmpmsg = msg as CharacterSelectedErrorMissingMapPackMessage;
                    subArea = SubArea.getSubAreaById(csemmpmsg.subAreaId);
                    pack = Pack.getPackById(subArea.packId);
                    if (pack.name == "subscribed")
                    {
                        PartManager.getInstance().checkAndDownload("all");
                    }
                    PartManager.getInstance().checkAndDownload(pack.name);
                    KernelEventsManager.getInstance().processCallback(HookList.PackRestrictedSubArea, csemmpmsg.subAreaId);
                    return true;
                }
                case msg is CharacterSelectedErrorMessage:
                {
                    csemsg = msg as CharacterSelectedErrorMessage;
                    _log.error("Impossible de selectionner ce personnage");
                    this._kernel.processCallback(HookList.CharacterImpossibleSelection, this._requestedCharacterId);
                    this._requestedCharacterId = 0;
                    return true;
                }
                case msg is BasicTimeMessage:
                {
                    btmsg = msg as BasicTimeMessage;
                    date = new Date();
                    TimeManager.getInstance().serverTimeLag = (btmsg.timestamp + btmsg.timezoneOffset) * 1000 - date.getTime();
                    TimeManager.getInstance().timezoneOffset = btmsg.timezoneOffset * 1000;
                    TimeManager.getInstance().dofusTimeYearLag = -1370;
                    return true;
                }
                case msg is StartupActionsListMessage:
                {
                    salm = msg as StartupActionsListMessage;
                    var _loc_3:int = 0;
                    var _loc_4:* = salm.actions;
                    while (_loc_4 in _loc_3)
                    {
                        
                        gift = _loc_4[_loc_3];
                        _items = new Array();
                        var _loc_5:int = 0;
                        var _loc_6:* = gift.items;
                        while (_loc_6 in _loc_5)
                        {
                            
                            item = _loc_6[_loc_5];
                            iw = ItemWrapper.create(0, 0, item.objectGID, item.quantity, item.effects, false);
                            _items.push(iw);
                        }
                        oj;
                        this._giftList.push(oj);
                    }
                    if (this._giftList.length)
                    {
                        charaListMinusDeadPeople = new Array();
                        var _loc_3:int = 0;
                        var _loc_4:* = this._charactersList;
                        while (_loc_4 in _loc_3)
                        {
                            
                            perso = _loc_4[_loc_3];
                            if (!perso.deathState || perso.deathState == 0)
                            {
                                charaListMinusDeadPeople.push(perso);
                            }
                        }
                        if (charaListMinusDeadPeople.length > 0)
                        {
                            this._kernel.processCallback(HookList.GiftList, this._giftList, charaListMinusDeadPeople);
                        }
                        else
                        {
                            _log.error("No characters to give gifts");
                            if (!Berilia.getInstance().getUi("characterSelection"))
                            {
                                this._kernel.processCallback(HookList.CharacterSelectionStart, this._charactersList);
                            }
                            else
                            {
                                this._kernel.processCallback(HookList.CharactersListUpdated, this._charactersList);
                            }
                        }
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this);
                        _log.error("Empty Gift List Received");
                    }
                    return true;
                }
                case msg is GiftAssignRequestAction:
                {
                    gar = msg as GiftAssignRequestAction;
                    if (gar.characterId == 0 && gar.giftId == this._giftList[0].uid)
                    {
                        if (!Berilia.getInstance().getUi("characterSelection"))
                        {
                            this._kernel.processCallback(HookList.CharacterSelectionStart, this._charactersList);
                        }
                    }
                    sao = new StartupActionsObjetAttributionMessage();
                    sao.initStartupActionsObjetAttributionMessage(gar.giftId, gar.characterId);
                    ConnectionsHandler.getConnection().send(sao);
                    return true;
                }
                case msg is StartupActionFinishedMessage:
                {
                    safm = msg as StartupActionFinishedMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.GiftAssigned, safm.actionId);
                    if (safm.actionId == this._giftList[0].uid)
                    {
                        if (!Berilia.getInstance().getUi("characterSelection"))
                        {
                            this._kernel.processCallback(HookList.CharacterSelectionStart, this._charactersList);
                        }
                    }
                    return true;
                }
                case msg is ConsoleCommandsListMessage:
                {
                    cclMsg = msg as ConsoleCommandsListMessage;
                    cmdIndex;
                    while (cmdIndex < cclMsg.aliases.length)
                    {
                        
                        new ServerCommand(cclMsg.aliases[cmdIndex], cclMsg.descriptions[cmdIndex]);
                        cmdIndex = (cmdIndex + 1);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private function onEscapePopup() : void
        {
            Kernel.getInstance().reset();
            return;
        }// end function

        private function requestCharactersList() : void
        {
            var _loc_1:* = new CharactersListRequestMessage();
            ConnectionsHandler.getConnection().send(_loc_1);
            return;
        }// end function

        private static function onChangeLogError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private static function onChangeLogLoaded(event:Event) : void
        {
            return;
        }// end function

    }
}
