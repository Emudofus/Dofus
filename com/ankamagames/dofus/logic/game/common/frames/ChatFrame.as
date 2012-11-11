package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.console.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.dofus.datacenter.notifications.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.externalnotification.enums.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.chat.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.messages.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.options.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.dofus.network.messages.game.chat.*;
    import com.ankamagames.dofus.network.messages.game.chat.channel.*;
    import com.ankamagames.dofus.network.messages.game.chat.smiley.*;
    import com.ankamagames.dofus.network.messages.game.context.notification.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.dofus.network.messages.game.moderation.*;
    import com.ankamagames.dofus.network.messages.web.ankabox.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.utils.*;

    public class ChatFrame extends Object implements Frame
    {
        private var _aChannels:Array;
        private var _aDisallowedChannels:Array;
        private var _aMessagesByChannel:Array;
        private var _msgUId:uint = 0;
        private var _maxMessagesStored:uint = 100;
        private var _aCensoredWords:Dictionary;
        private var _smileyMood:int = -1;
        private var _options:ChatOptions;
        private var _cssUri:String;
        private var _aChatColors:Array;
        private var _ankaboxEnabled:Boolean = false;
        private var _aSmilies:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatFrame));
        public static const GUILD_SOUND:uint = 0;
        public static const PARTY_SOUND:uint = 1;
        public static const PRIVATE_SOUND:uint = 2;
        public static const ALERT_SOUND:uint = 3;
        public static const RED_CHANNEL_ID:uint = 666;
        public static const URL_MATCHER:RegExp = /\b((http|https|ftp):\/\/)?(([^:@ ]*)(:([^@ ]*))?@)?((www\.)?(([a-z0-9\-\.]{2,})(\.[a-z0-9\-]{2,})))(:([0-9]+))?(\/[^\s`!()\[\]{};:''"",<>?«»“”‘’#]*)?(\?([^\s`!()\[\]{};:''"".,<>?«»“”‘’]*))?(#(.*))?""\b((http|https|ftp):\/\/)?(([^:@ ]*)(:([^@ ]*))?@)?((www\.)?(([a-z0-9\-\.]{2,})(\.[a-z0-9\-]{2,})))(:([0-9]+))?(\/[^\s`!()\[\]{};:'",<>?«»“”‘’#]*)?(\?([^\s`!()\[\]{};:'".,<>?«»“”‘’]*))?(#(.*))?/gi;
        public static const LINK_TLDS:Array = new Array(".com", ".edu", ".org", ".fr", ".info", ".net", ".de", ".ja", ".uk", ".us", ".it", ".nl", ".ru", ".es", ".pt", ".br");

        public function ChatFrame()
        {
            this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/chat.css";
            this._aChatColors = new Array();
            CssManager.getInstance().askCss(this._cssUri, new Callback(this.onCssLoaded));
            return;
        }// end function

        public function pushed() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this._options = new ChatOptions();
            this.setDisplayOptions(this._options);
            this._aChannels = ChatChannel.getChannels();
            this._aDisallowedChannels = new Array();
            this._aMessagesByChannel = new Array();
            this._aSmilies = new Array();
            this._aCensoredWords = new Dictionary();
            for (_loc_1 in this._aChannels)
            {
                
                this._aMessagesByChannel[this._aChannels[_loc_1].id] = new Array();
            }
            this._aMessagesByChannel[RED_CHANNEL_ID] = new Array();
            ConsolesManager.registerConsole("chat", new ConsoleHandler(Kernel.getWorker(), false), new ChatConsoleInstructionRegistrar());
            for each (_loc_2 in Smiley.getSmileys())
            {
                
                if (_loc_2.forPlayers)
                {
                    _loc_10 = SmileyWrapper.create(_loc_2.id, _loc_2.gfxId, _loc_2.order);
                    this._aSmilies.push(_loc_10);
                }
            }
            this._aSmilies.sortOn("order", Array.NUMERIC);
            _loc_3 = XmlConfig.getInstance().getEntry("config.lang.current");
            _loc_4 = CensoredWord.getCensoredWords();
            _loc_5 = 0;
            for each (_loc_6 in _loc_4)
            {
                
                if (_loc_6)
                {
                    if (_loc_6.language == _loc_3)
                    {
                        _loc_5 = _loc_5 + 1;
                        if (_loc_6.deepLooking)
                        {
                            this._aCensoredWords[_loc_6.word] = 2;
                            continue;
                        }
                        this._aCensoredWords[_loc_6.word] = 1;
                    }
                }
            }
            _loc_7 = OptionManager.getOptionManager("chat");
            _loc_8 = PlayedCharacterManager.getInstance().id;
            if (!_loc_7["moodSmiley_" + _loc_8])
            {
                _loc_7.add("moodSmiley_" + _loc_8, "");
            }
            var _loc_9:* = _loc_7["moodSmiley_" + _loc_8];
            if (_loc_7["moodSmiley_" + _loc_8] && _loc_9 != "")
            {
                _loc_11 = new Date();
                _loc_12 = _loc_9.split("_");
                if (int(_loc_12[0]) > 0 && Number(_loc_12[1]) < _loc_11.time + 604800000)
                {
                    _loc_13 = new MoodSmileyRequestAction();
                    _loc_13.smileyId = int(_loc_12[0]);
                    this.process(_loc_13);
                }
            }
            return true;
        }// end function

        public function get entitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        public function get socialFrame() : SocialFrame
        {
            return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
        }// end function

        public function get priority() : int
        {
            return 0;
        }// end function

        public function get disallowedChannels() : Array
        {
            return this._aDisallowedChannels;
        }// end function

        public function get chatColors() : Array
        {
            return this._aChatColors;
        }// end function

        public function get censoredWords() : Dictionary
        {
            return this._aCensoredWords;
        }// end function

        public function get smilies() : Array
        {
            return this._aSmilies;
        }// end function

        public function get maxMessagesStored() : int
        {
            return this._maxMessagesStored;
        }// end function

        public function get smileyMood() : int
        {
            return this._smileyMood;
        }// end function

        public function get ankaboxEnabled() : Boolean
        {
            return this._ankaboxEnabled;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var content:String;
            var bwira:BasicWhoIsRequestAction;
            var bwirmsg:BasicWhoIsRequestMessage;
            var nwira:NumericWhoIsRequestAction;
            var nwirmsg:NumericWhoIsRequestMessage;
            var ch:uint;
            var ctoa:ChatTextOutputAction;
            var pattern:RegExp;
            var charTempL:String;
            var charTempR:String;
            var objects:Vector.<ObjectItem>;
            var scwomsg:ChatServerWithObjectMessage;
            var numItem:int;
            var listItem:Vector.<ItemWrapper>;
            var casmsg:ChatAdminServerMessage;
            var pwmsg:PopupWarningMessage;
            var csmsg:ChatServerMessage;
            var bubbleContent:String;
            var newContent:Array;
            var thinking:Boolean;
            var cscwomsg:ChatServerCopyWithObjectMessage;
            var cscmsg:ChatServerCopyMessage;
            var timsg:TextInformationMessage;
            var param:Array;
            var msgContent:String;
            var textId:uint;
            var params:Array;
            var timestampf:Number;
            var comsg:ConsoleOutputMessage;
            var consoleTimestamp:Number;
            var taimsg:TextActionInformationMessage;
            var paramTaimsg:Array;
            var channel2:uint;
            var timestamp2:Number;
            var cemsg:ChatErrorMessage;
            var timestampErr:Number;
            var contentErr:String;
            var sma:SaveMessageAction;
            var csrmsg:ChatSmileyRequestMessage;
            var lcsmsg:LocalizedChatSmileyMessage;
            var smileyItemLocalized:SmileyWrapper;
            var cell:GraphicCell;
            var gctr:GraphicContainer;
            var scmsg:ChatSmileyMessage;
            var smileyItem:SmileyWrapper;
            var smileyEntity:IDisplayable;
            var sysApi:SystemApi;
            var msrmsg:MoodSmileyRequestMessage;
            var msrtmsg:MoodSmileyResultMessage;
            var date:Date;
            var id:int;
            var chatOpt:OptionManager;
            var cecmsg:ChannelEnablingChangeMessage;
            var cebmsg:ChannelEnablingMessage;
            var tua:TabsUpdateAction;
            var cca:ChatCommandAction;
            var ecmsg:EnabledChannelsMessage;
            var btmsg:BasicTimeMessage;
            var date2:Date;
            var oemsg:ObjectErrorMessage;
            var objectErrorText:String;
            var bwimsg:BasicWhoIsMessage;
            var areaName:String;
            var notice:String;
            var text:String;
            var nwimsg:NumericWhoIsMessage;
            var bwnmmsg:BasicWhoIsNoMatchMessage;
            var lomra:LivingObjectMessageRequestAction;
            var lomrmsg:LivingObjectMessageRequestMessage;
            var lommsg:LivingObjectMessageMessage;
            var speakingItemText:SpeakingItemText;
            var cla:ChatLoadedAction;
            var nbsmsg:NotificationByServerMessage;
            var a:Array;
            var notification:Notification;
            var title:String;
            var egtcgmsg:ExchangeGuildTaxCollectorGetMessage;
            var idFName:Number;
            var idName:Number;
            var taxCollectorName:String;
            var textObjects:String;
            var objectsAndExp:String;
            var nmmsg:MailStatusMessage;
            var msmsg:MailStatusMessage;
            var charas:CharacterCharacteristicsInformations;
            var infos:CharacterBaseInformations;
            var variables:Array;
            var variable:String;
            var guilde:String;
            var leftIndex:int;
            var rightIndex:int;
            var leftBlock:String;
            var rightBlock:String;
            var middleBlock:String;
            var replace:Boolean;
            var mapInfo:Array;
            var posX:Number;
            var posY:Number;
            var nb:int;
            var o:int;
            var ccmwomsg:ChatClientMultiWithObjectMessage;
            var itemWrapper:ItemWrapper;
            var objectItem:ObjectItem;
            var ccmmsg:ChatClientMultiMessage;
            var nb2:int;
            var jo:int;
            var ccpwomsg:ChatClientPrivateWithObjectMessage;
            var itemWrapper2:ItemWrapper;
            var objectItem2:ObjectItem;
            var ccpmsg:ChatClientPrivateMessage;
            var i:int;
            var oi:ObjectItem;
            var speakerEntity:IDisplayable;
            var tooltipContent:String;
            var thinkBubble:ThinkBubble;
            var bubble:ChatBubble;
            var iTimsg:*;
            var channel:uint;
            var timestamp:Number;
            var iTaimsg:*;
            var entityInfo:GameContextActorInformations;
            var chanId:*;
            var parameter:String;
            var nbsmsgNid:uint;
            var object:ObjectItemQuantity;
            var msg:* = param1;
            switch(true)
            {
                case msg is BasicWhoIsRequestAction:
                {
                    bwira = msg as BasicWhoIsRequestAction;
                    bwirmsg = new BasicWhoIsRequestMessage();
                    bwirmsg.initBasicWhoIsRequestMessage(bwira.playerName);
                    ConnectionsHandler.getConnection().send(bwirmsg);
                    return true;
                }
                case msg is NumericWhoIsRequestAction:
                {
                    nwira = msg as NumericWhoIsRequestAction;
                    nwirmsg = new NumericWhoIsRequestMessage();
                    nwirmsg.initNumericWhoIsRequestMessage(nwira.playerId);
                    ConnectionsHandler.getConnection().send(bwirmsg);
                    return true;
                }
                case msg is ChatTextOutputAction:
                {
                    ch = ChatTextOutputAction(msg).channel;
                    ctoa = msg as ChatTextOutputAction;
                    content = ctoa.content;
                    content = StringUtils.concatSameString(content, " ");
                    content = content.split("\r").join(" ");
                    if (content.length > 256)
                    {
                        _log.error("Too long message has been truncated before sending.");
                        content = content.substr(0, 255);
                    }
                    pattern = /%[a-z]+%""%[a-z]+%/;
                    if (content.match(pattern) != null)
                    {
                        charas = PlayedCharacterManager.getInstance().characteristics;
                        infos = PlayedCharacterManager.getInstance().infos;
                        variables = I18n.getUiText("ui.chat.variable.experience").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), int((charas.experience - charas.experienceLevelFloor) / (charas.experienceNextLevelFloor - charas.experienceLevelFloor) * 100) + "%");
                        }
                        variables = I18n.getUiText("ui.chat.variable.level").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), infos.level);
                        }
                        variables = I18n.getUiText("ui.chat.variable.life").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), charas.lifePoints);
                        }
                        variables = I18n.getUiText("ui.chat.variable.maxlife").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), charas.maxLifePoints);
                        }
                        variables = I18n.getUiText("ui.chat.variable.lifepercent").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), int(charas.lifePoints / charas.maxLifePoints * 100) + "%");
                        }
                        variables = I18n.getUiText("ui.chat.variable.myself").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), infos.name);
                        }
                        variables = I18n.getUiText("ui.chat.variable.stats").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), I18n.getUiText("ui.chat.variable.statsresult", new Array(this.displayCarac(charas.vitality), this.displayCarac(charas.wisdom), this.displayCarac(charas.strength), this.displayCarac(charas.intelligence), this.displayCarac(charas.chance), this.displayCarac(charas.agility), this.displayCarac(charas.initiative), this.displayCarac(charas.actionPoints), this.displayCarac(charas.movementPoints))));
                        }
                        variables = I18n.getUiText("ui.chat.variable.area").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            if (PlayedCharacterManager.getInstance().currentSubArea != null)
                            {
                                content = content.replace(new RegExp(variable, "g"), PlayedCharacterManager.getInstance().currentSubArea.area.name);
                            }
                        }
                        variables = I18n.getUiText("ui.chat.variable.subarea").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            if (PlayedCharacterManager.getInstance().currentSubArea != null)
                            {
                                content = content.replace(new RegExp(variable, "g"), PlayedCharacterManager.getInstance().currentSubArea.name);
                            }
                        }
                        variables = I18n.getUiText("ui.chat.variable.position").split(",");
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), "[" + PlayedCharacterManager.getInstance().currentMap.outdoorX + "," + PlayedCharacterManager.getInstance().currentMap.outdoorY + "]");
                        }
                        variables = I18n.getUiText("ui.chat.variable.guild").split(",");
                        guilde = this.socialFrame.guild == null ? (I18n.getUiText("ui.chat.variable.guilderror")) : (this.socialFrame.guild.guildName);
                        var _loc_3:* = 0;
                        var _loc_4:* = variables;
                        while (_loc_4 in _loc_3)
                        {
                            
                            variable = _loc_4[_loc_3];
                            content = content.replace(new RegExp(variable, "g"), guilde);
                        }
                    }
                    charTempL = String.fromCharCode(2);
                    charTempR = String.fromCharCode(3);
                    while (true)
                    {
                        
                        leftIndex = content.indexOf("[");
                        if (leftIndex == -1)
                        {
                            break;
                        }
                        rightIndex = content.indexOf("]");
                        if (rightIndex == -1)
                        {
                            break;
                        }
                        if (leftIndex > rightIndex)
                        {
                            break;
                        }
                        leftBlock = content.substring(0, leftIndex);
                        rightBlock = content.substring((rightIndex + 1));
                        middleBlock = content.substring((leftIndex + 1), rightIndex);
                        replace;
                        mapInfo = middleBlock.split(",");
                        if (mapInfo.length == 2)
                        {
                            posX = Number(mapInfo[0]);
                            posY = Number(mapInfo[1]);
                            if (!isNaN(posX) && !isNaN(posY))
                            {
                                replace;
                                content = leftBlock + "{map," + int(posX) + "," + int(posY) + "}" + rightBlock;
                            }
                        }
                        if (replace)
                        {
                            content = leftBlock + charTempL + middleBlock + charTempR + rightBlock;
                        }
                    }
                    content = content.split(charTempL).join("[").split(charTempR).join("]");
                    if (content.length > 256)
                    {
                        content = content.substr(0, 253) + "...";
                    }
                    objects = new Vector.<ObjectItem>;
                    if (!this._aChannels[ch].isPrivate)
                    {
                        if (ctoa.objects)
                        {
                            nb = ctoa.objects.length;
                            o;
                            while (o < nb)
                            {
                                
                                itemWrapper = SecureCenter.unsecure(ctoa.objects[o]);
                                objectItem = new ObjectItem();
                                objectItem.initObjectItem(itemWrapper.position, itemWrapper.objectGID, 0, false, itemWrapper.effectsList == null ? (new Vector.<ObjectEffect>) : (itemWrapper.effectsList), itemWrapper.objectUID, itemWrapper.quantity);
                                objects.push(objectItem);
                                o = (o + 1);
                            }
                            ccmwomsg = new ChatClientMultiWithObjectMessage();
                            ccmwomsg.initChatClientMultiWithObjectMessage(content, ch, objects);
                            ConnectionsHandler.getConnection().send(ccmwomsg);
                        }
                        else
                        {
                            ccmmsg = new ChatClientMultiMessage();
                            ccmmsg.initChatClientMultiMessage(content, ch);
                            ConnectionsHandler.getConnection().send(ccmmsg);
                        }
                    }
                    else
                    {
                        if (ctoa.receiverName.length < 2 || ctoa.receiverName.length > 31)
                        {
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.chat.error.1"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.getTimestamp());
                            return true;
                        }
                        if (ctoa.objects)
                        {
                            objects = new Vector.<ObjectItem>;
                            nb2 = ctoa.objects.length;
                            jo;
                            while (jo < nb2)
                            {
                                
                                itemWrapper2 = SecureCenter.unsecure(ctoa.objects[jo]);
                                objectItem2 = new ObjectItem();
                                objectItem2.initObjectItem(itemWrapper2.position, itemWrapper2.objectGID, 0, false, itemWrapper2.effectsList == null ? (new Vector.<ObjectEffect>) : (itemWrapper2.effectsList), itemWrapper2.objectUID, itemWrapper2.quantity);
                                objects.push(objectItem2);
                                jo = (jo + 1);
                            }
                            ccpwomsg = new ChatClientPrivateWithObjectMessage();
                            ccpwomsg.initChatClientPrivateWithObjectMessage(content, ctoa.receiverName, objects);
                            ConnectionsHandler.getConnection().send(ccpwomsg);
                        }
                        else
                        {
                            ccpmsg = new ChatClientPrivateMessage();
                            ccpmsg.initChatClientPrivateMessage(content, ctoa.receiverName);
                            ConnectionsHandler.getConnection().send(ccpmsg);
                        }
                    }
                    return true;
                }
                case msg is ChatServerWithObjectMessage:
                {
                    scwomsg = msg as ChatServerWithObjectMessage;
                    AccountManager.getInstance().setAccount(scwomsg.senderName, scwomsg.senderAccountId);
                    if (scwomsg.channel != RED_CHANNEL_ID && scwomsg.channel != ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE && (this.socialFrame.isIgnored(scwomsg.senderName, scwomsg.senderAccountId) || this.socialFrame.isEnemy(scwomsg.senderName)))
                    {
                        return true;
                    }
                    if (scwomsg.senderId != PlayedCharacterManager.getInstance().id)
                    {
                        if (scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                        {
                            this.playAlertSound(GUILD_SOUND);
                        }
                        if (scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                        {
                            this.playAlertSound(PARTY_SOUND);
                        }
                        if (scwomsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                        {
                            this.playAlertSound(PRIVATE_SOUND);
                        }
                    }
                    numItem = scwomsg.objects.length;
                    listItem = new Vector.<ItemWrapper>(numItem);
                    i;
                    while (i < numItem)
                    {
                        
                        oi = scwomsg.objects[i];
                        listItem[i] = ItemWrapper.create(oi.position, oi.objectUID, oi.objectGID, oi.quantity, oi.effects, false);
                        i = (i + 1);
                    }
                    content = this.checkCensored(scwomsg.content, scwomsg.channel, scwomsg.senderAccountId, scwomsg.senderName)[0];
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerWithObject, scwomsg.channel, scwomsg.senderId, scwomsg.senderName, content, this.getRealTimestamp(scwomsg.timestamp), scwomsg.fingerprint, listItem);
                    this.saveMessage(scwomsg.channel, scwomsg.content, content, this.getRealTimestamp(scwomsg.timestamp), scwomsg.fingerprint, scwomsg.senderId, scwomsg.senderName, listItem);
                    return true;
                }
                case msg is ChatAdminServerMessage:
                {
                    casmsg = msg as ChatAdminServerMessage;
                    AccountManager.getInstance().setAccount(casmsg.senderName, casmsg.senderAccountId);
                    if (casmsg.senderId != PlayedCharacterManager.getInstance().id)
                    {
                        if (casmsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                        {
                            this.playAlertSound(GUILD_SOUND);
                        }
                        if (casmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || casmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                        {
                            this.playAlertSound(PARTY_SOUND);
                        }
                        if (casmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                        {
                            this.playAlertSound(PRIVATE_SOUND);
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServer, casmsg.channel, casmsg.senderId, casmsg.senderName, casmsg.content, this.getRealTimestamp(casmsg.timestamp), casmsg.fingerprint, true);
                    this.saveMessage(casmsg.channel, casmsg.content, casmsg.content, this.getRealTimestamp(casmsg.timestamp), casmsg.fingerprint, casmsg.senderId, casmsg.senderName, null, "", 0, 0, null, true);
                    return true;
                }
                case msg is PopupWarningMessage:
                {
                    pwmsg = msg as PopupWarningMessage;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.PopupWarning, pwmsg.author, pwmsg.content, pwmsg.lockDuration);
                    return true;
                }
                case msg is ChatServerMessage:
                {
                    csmsg = msg as ChatServerMessage;
                    AccountManager.getInstance().setAccount(csmsg.senderName, csmsg.senderAccountId);
                    if (csmsg.channel != RED_CHANNEL_ID && csmsg.channel != ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE && (this.socialFrame.isIgnored(csmsg.senderName, csmsg.senderAccountId) || this.socialFrame.isEnemy(csmsg.senderName)))
                    {
                        return true;
                    }
                    if (csmsg.senderId != PlayedCharacterManager.getInstance().id)
                    {
                        if (csmsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                        {
                            this.playAlertSound(GUILD_SOUND);
                        }
                        if (csmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || csmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                        {
                            this.playAlertSound(PARTY_SOUND);
                        }
                        if (csmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                        {
                            this.playAlertSound(PRIVATE_SOUND);
                        }
                    }
                    newContent = this.checkCensored(csmsg.content, csmsg.channel, csmsg.senderAccountId, csmsg.senderName);
                    content = newContent[0];
                    if (csmsg.channel == ChatChannelsMultiEnum.CHANNEL_ADS)
                    {
                        content = csmsg.content;
                    }
                    if (content.substr(0, 6).toLowerCase() == "/think")
                    {
                        thinking;
                        bubbleContent = newContent[1].substr(7);
                    }
                    else if (content.charAt(0) == "*" && content.charAt((content.length - 1)) == "*")
                    {
                        thinking;
                        bubbleContent = newContent[1].substr(1, content.length - 2);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServer, csmsg.channel, csmsg.senderId, csmsg.senderName, content, this.getRealTimestamp(csmsg.timestamp), csmsg.fingerprint, false);
                    this.saveMessage(csmsg.channel, csmsg.content, content, this.getRealTimestamp(csmsg.timestamp), csmsg.fingerprint, csmsg.senderId, csmsg.senderName);
                    if (Kernel.getWorker().contains(FightBattleFrame) || content.substr(0, 3).toLowerCase() == "/me")
                    {
                        return true;
                    }
                    if (csmsg.channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL)
                    {
                        speakerEntity = DofusEntities.getEntity(csmsg.senderId) as IDisplayable;
                        if (speakerEntity == null)
                        {
                            return true;
                        }
                        if (speakerEntity is AnimatedCharacter)
                        {
                            if ((speakerEntity as AnimatedCharacter).isMoving)
                            {
                                return true;
                            }
                        }
                        tooltipContent = newContent[1];
                        if (thinking)
                        {
                            thinkBubble = new ThinkBubble(bubbleContent);
                        }
                        else
                        {
                            bubble = new ChatBubble(tooltipContent);
                        }
                        TooltipManager.show(thinking ? (thinkBubble) : (bubble), speakerEntity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "msg" + csmsg.senderId, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_TOPRIGHT, 0, true, null, null, null, null, false, StrataEnum.STRATA_WORLD);
                    }
                    return true;
                }
                case msg is ChatServerCopyWithObjectMessage:
                {
                    cscwomsg = msg as ChatServerCopyWithObjectMessage;
                    numItem = cscwomsg.objects.length;
                    listItem = new Vector.<ItemWrapper>(numItem);
                    i;
                    while (i < numItem)
                    {
                        
                        oi = cscwomsg.objects[i];
                        listItem[i] = ItemWrapper.create(oi.position, oi.objectUID, oi.objectGID, oi.quantity, oi.effects);
                        i = (i + 1);
                    }
                    content = this.checkCensored(cscwomsg.content, cscwomsg.channel, PlayerManager.getInstance().accountId, PlayedCharacterManager.getInstance().infos.name)[0];
                    this.saveMessage(cscwomsg.channel, cscwomsg.content, content, this.getRealTimestamp(cscwomsg.timestamp), cscwomsg.fingerprint, 0, "", listItem, cscwomsg.receiverName, cscwomsg.receiverId);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerCopyWithObject, cscwomsg.channel, cscwomsg.receiverName, content, this.getRealTimestamp(cscwomsg.timestamp), cscwomsg.fingerprint, cscwomsg.receiverId, listItem);
                    return true;
                }
                case msg is ChatServerCopyMessage:
                {
                    cscmsg = msg as ChatServerCopyMessage;
                    content = this.checkCensored(cscmsg.content, cscmsg.channel, PlayerManager.getInstance().accountId, PlayedCharacterManager.getInstance().infos.name)[0];
                    this.saveMessage(cscmsg.channel, cscmsg.content, content, this.getRealTimestamp(cscmsg.timestamp), cscmsg.fingerprint, 0, "", null, cscmsg.receiverName, cscmsg.receiverId);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerCopy, cscmsg.channel, cscmsg.receiverName, content, this.getRealTimestamp(cscmsg.timestamp), cscmsg.fingerprint, cscmsg.receiverId);
                    return true;
                }
                case msg is TextInformationMessage:
                {
                    timsg = msg as TextInformationMessage;
                    param = new Array();
                    var _loc_3:* = 0;
                    var _loc_4:* = timsg.parameters;
                    while (_loc_4 in _loc_3)
                    {
                        
                        iTimsg = _loc_4[_loc_3];
                        param.push(iTimsg);
                    }
                    params = new Array();
                    if (InfoMessage.getInfoMessageById(timsg.msgType * 10000 + timsg.msgId))
                    {
                        textId = InfoMessage.getInfoMessageById(timsg.msgType * 10000 + timsg.msgId).textId;
                        if (param != null)
                        {
                            if (param[0] && param[0].indexOf("~") != -1)
                            {
                                params = param[0].split("~");
                            }
                            else
                            {
                                params = param;
                            }
                        }
                    }
                    else
                    {
                        _log.error("Information message " + (timsg.msgType * 10000 + timsg.msgId) + " cannot be found.");
                        if (timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_ERROR)
                        {
                            textId = InfoMessage.getInfoMessageById(10231).textId;
                        }
                        else
                        {
                            textId = InfoMessage.getInfoMessageById(207).textId;
                        }
                        params.push(timsg.msgId);
                    }
                    msgContent = I18n.getText(textId);
                    if (msgContent)
                    {
                        msgContent = ParamsDecoder.applyParams(msgContent, params);
                        timestamp = this.getTimestamp();
                        if (timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_ERROR)
                        {
                            channel = RED_CHANNEL_ID;
                            this.playAlertSound(ALERT_SOUND);
                        }
                        else if (timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_MESSAGE)
                        {
                            channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                        }
                        else if (timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_PVP)
                        {
                            channel = ChatActivableChannelsEnum.CHANNEL_ALIGN;
                        }
                        else if (timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_FIGHT)
                        {
                            channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG;
                        }
                        this.saveMessage(channel, null, msgContent, timestamp);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, msgContent, channel, timestamp, false);
                        if (AirScanner.hasAir() && timsg.msgId == 224)
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification, ExternalNotificationTypeEnum.MEMBER_CONNECTION, [params[0]]);
                        }
                    }
                    else
                    {
                        _log.error("There\'s no message for id " + (timsg.msgType * 10000 + timsg.msgId));
                    }
                    return true;
                }
                case msg is FightOutputAction:
                {
                    timestampf = this.getTimestamp();
                    this.saveMessage(FightOutputAction(msg).channel, null, FightOutputAction(msg).content, timestampf);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, FightOutputAction(msg).content, FightOutputAction(msg).channel, timestampf, false);
                    return true;
                }
                case msg is ConsoleOutputMessage:
                {
                    comsg = msg as ConsoleOutputMessage;
                    if (comsg.consoleId != "chat")
                    {
                        return false;
                    }
                    consoleTimestamp = this.getTimestamp();
                    this.saveMessage(ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, null, comsg.text, consoleTimestamp);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, comsg.text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, consoleTimestamp, false);
                    return true;
                }
                case msg is TextActionInformationMessage:
                {
                    taimsg = msg as TextActionInformationMessage;
                    paramTaimsg = new Array();
                    var _loc_3:* = 0;
                    var _loc_4:* = taimsg.params;
                    while (_loc_4 in _loc_3)
                    {
                        
                        iTaimsg = _loc_4[_loc_3];
                        paramTaimsg.push(iTaimsg);
                    }
                    channel2 = ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG;
                    timestamp2 = this.getTimestamp();
                    this.saveMessage(channel2, null, "", timestamp2, "", 0, "", null, "", 0, taimsg.textKey, paramTaimsg);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextActionInformation, taimsg.textKey, params, channel2, timestamp2, false);
                    return true;
                }
                case msg is ChatErrorMessage:
                {
                    cemsg = msg as ChatErrorMessage;
                    timestampErr = this.getTimestamp();
                    switch(cemsg.reason)
                    {
                        case ChatErrorEnum.CHAT_ERROR_INTERIOR_MONOLOGUE:
                        case ChatErrorEnum.CHAT_ERROR_INVALID_MAP:
                        case ChatErrorEnum.CHAT_ERROR_NO_GUILD:
                        case ChatErrorEnum.CHAT_ERROR_NO_PARTY:
                        case ChatErrorEnum.CHAT_ERROR_RECEIVER_NOT_FOUND:
                        case ChatErrorEnum.CHAT_ERROR_NO_PARTY_ARENA:
                        case ChatErrorEnum.CHAT_ERROR_NO_TEAM:
                        {
                            contentErr = I18n.getUiText("ui.chat.error." + cemsg.reason);
                            break;
                        }
                        case ChatErrorEnum.CHAT_ERROR_ALIGN:
                        {
                        }
                        default:
                        {
                            contentErr = I18n.getUiText("ui.chat.error.0");
                            break;
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, contentErr, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, timestampErr);
                    return true;
                }
                case msg is SaveMessageAction:
                {
                    sma = SaveMessageAction(msg);
                    this.saveMessage(sma.channel, sma.content, sma.content, sma.timestamp);
                    return true;
                }
                case msg is ChatSmileyRequestAction:
                {
                    csrmsg = new ChatSmileyRequestMessage();
                    csrmsg.initChatSmileyRequestMessage(ChatSmileyRequestAction(msg).smileyId);
                    ConnectionsHandler.getConnection().send(csrmsg);
                    return true;
                }
                case msg is LocalizedChatSmileyMessage:
                {
                    lcsmsg = msg as LocalizedChatSmileyMessage;
                    smileyItemLocalized = new SmileyWrapper();
                    smileyItemLocalized.id = lcsmsg.smileyId;
                    cell = InteractiveCellManager.getInstance().getCell(lcsmsg.cellId);
                    gctr = new GraphicContainer();
                    gctr.x = cell.x;
                    gctr.y = cell.y;
                    gctr.width = cell.width;
                    gctr.height = cell.height;
                    gctr.x = gctr.x + 14;
                    gctr.y = gctr.y - 35;
                    if (cell)
                    {
                        TooltipManager.show(smileyItemLocalized, gctr, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "smiley_" + lcsmsg.entityId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, StrataEnum.STRATA_WORLD);
                    }
                    return true;
                }
                case msg is ChatSmileyMessage:
                {
                    scmsg = msg as ChatSmileyMessage;
                    AccountManager.getInstance().setAccountFromId(scmsg.entityId, scmsg.accountId);
                    if (this.entitiesFrame)
                    {
                        entityInfo = this.entitiesFrame.getEntityInfos(scmsg.entityId);
                        if (entityInfo && entityInfo is GameRolePlayCharacterInformations && this.socialFrame.isIgnored(GameRolePlayCharacterInformations(entityInfo).name, scmsg.accountId))
                        {
                            return true;
                        }
                    }
                    smileyItem = new SmileyWrapper();
                    smileyItem.id = scmsg.smileyId;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatSmiley, scmsg.smileyId, scmsg.entityId);
                    smileyEntity = DofusEntities.getEntity(scmsg.entityId) as IDisplayable;
                    if (smileyEntity == null)
                    {
                        return true;
                    }
                    if (smileyEntity is AnimatedCharacter)
                    {
                        if ((smileyEntity as AnimatedCharacter).isMoving)
                        {
                            return true;
                        }
                    }
                    sysApi = new SystemApi();
                    TooltipManager.show(smileyItem, smileyEntity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), true, "smiley" + scmsg.entityId, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, null, null, null, null, false, StrataEnum.STRATA_WORLD, sysApi.getCurrentZoom());
                    return true;
                }
                case msg is MoodSmileyRequestAction:
                {
                    msrmsg = new MoodSmileyRequestMessage();
                    msrmsg.initMoodSmileyRequestMessage(MoodSmileyRequestAction(msg).smileyId);
                    ConnectionsHandler.getConnection().send(msrmsg);
                    return true;
                }
                case msg is MoodSmileyResultMessage:
                {
                    msrtmsg = msg as MoodSmileyResultMessage;
                    this._smileyMood = msrtmsg.smileyId;
                    date = new Date();
                    id = PlayedCharacterManager.getInstance().id;
                    chatOpt = OptionManager.getOptionManager("chat");
                    if (!chatOpt["moodSmiley_" + id])
                    {
                        chatOpt.add("moodSmiley_" + id, "");
                    }
                    chatOpt["moodSmiley_" + id] = this._smileyMood + "_" + date.time;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.MoodResult, msrtmsg.resultCode, msrtmsg.smileyId);
                    return true;
                }
                case msg is ChannelEnablingChangeMessage:
                {
                    cecmsg = msg as ChannelEnablingChangeMessage;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChannelEnablingChange, cecmsg.channel, cecmsg.enable);
                    return true;
                }
                case msg is ChannelEnablingAction:
                {
                    cebmsg = new ChannelEnablingMessage();
                    cebmsg.initChannelEnablingMessage(ChannelEnablingAction(msg).channel, ChannelEnablingAction(msg).enable);
                    ConnectionsHandler.getConnection().send(cebmsg);
                    return true;
                }
                case msg is TabsUpdateAction:
                {
                    tua = msg as TabsUpdateAction;
                    if (tua.tabs)
                    {
                        OptionManager.getOptionManager("chat").channelTabs = tua.tabs;
                    }
                    if (tua.tabsNames)
                    {
                        OptionManager.getOptionManager("chat").tabsNames = tua.tabsNames;
                    }
                    return true;
                }
                case msg is ChatCommandAction:
                {
                    cca = msg as ChatCommandAction;
                    try
                    {
                        ConsolesManager.getConsole("chat").process(ConsolesManager.getMessage(cca.command));
                    }
                    catch (ucie:UnhandledConsoleInstructionError)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, ucie.message, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, getTimestamp());
                    }
                    return true;
                }
                case msg is EnabledChannelsMessage:
                {
                    ecmsg = msg as EnabledChannelsMessage;
                    var _loc_3:* = 0;
                    var _loc_4:* = ecmsg.disallowed;
                    while (_loc_4 in _loc_3)
                    {
                        
                        chanId = _loc_4[_loc_3];
                        this._aDisallowedChannels.push(chanId);
                    }
                    KernelEventsManager.getInstance().processCallback(ChatHookList.EnabledChannels, ecmsg.channels);
                    return true;
                }
                case msg is BasicTimeMessage:
                {
                    btmsg = msg as BasicTimeMessage;
                    date2 = new Date();
                    TimeManager.getInstance().serverTimeLag = (btmsg.timestamp + btmsg.timezoneOffset) * 1000 - date2.getTime();
                    TimeManager.getInstance().timezoneOffset = btmsg.timezoneOffset * 1000;
                    TimeManager.getInstance().dofusTimeYearLag = -1370;
                    return true;
                }
                case msg is ObjectErrorMessage:
                {
                    oemsg = msg as ObjectErrorMessage;
                    switch(oemsg.reason)
                    {
                        case ObjectErrorEnum.INVENTORY_FULL:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.InventoryFull");
                            break;
                        }
                        case ObjectErrorEnum.CANNOT_EQUIP_TWICE:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.CannotEquipTwice");
                            break;
                        }
                        case ObjectErrorEnum.NOT_TRADABLE:
                        {
                            break;
                        }
                        case ObjectErrorEnum.CANNOT_DROP:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.CannotDrop");
                            break;
                        }
                        case ObjectErrorEnum.CANNOT_DROP_NO_PLACE:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.CannotDropNoPlace");
                            break;
                        }
                        case ObjectErrorEnum.CANNOT_DESTROY:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.CannotDelete");
                            break;
                        }
                        case ObjectErrorEnum.LEVEL_TOO_LOW:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.levelTooLow");
                            break;
                        }
                        case ObjectErrorEnum.LIVING_OBJECT_REFUSED_FOOD:
                        {
                            objectErrorText = I18n.getUiText("ui.objectError.LivingObjectRefusedFood");
                            break;
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                    this.playAlertSound(ALERT_SOUND);
                    if (objectErrorText)
                    {
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, objectErrorText, RED_CHANNEL_ID, this.getTimestamp());
                    }
                    else
                    {
                        _log.error("Texte d\'erreur objet " + oemsg.reason + " manquant");
                    }
                    return false;
                }
                case msg is BasicWhoIsMessage:
                {
                    bwimsg = msg as BasicWhoIsMessage;
                    if (bwimsg.areaId != -1)
                    {
                        areaName = Area.getAreaById(bwimsg.areaId).name;
                    }
                    else
                    {
                        areaName = I18n.getUiText("ui.common.unknowArea");
                    }
                    notice = "{player," + bwimsg.characterName + "}";
                    if (bwimsg.position == GameHierarchyEnum.MODERATOR)
                    {
                        notice = notice + (" (<b><font color=\'" + XmlConfig.getInstance().getEntry("colors.hierarchy.moderator").replace("0x", "#") + "\'>" + I18n.getUiText("ui.common.moderator") + "</font></b>)");
                    }
                    else if (bwimsg.position == GameHierarchyEnum.GAMEMASTER_PADAWAN)
                    {
                        notice = notice + (" (<b><font color=\'" + XmlConfig.getInstance().getEntry("colors.hierarchy.gamemaster_padawan").replace("0x", "#") + "\'>" + I18n.getUiText("ui.common.gameMasterAssistant") + "</font></b>)");
                    }
                    else if (bwimsg.position == GameHierarchyEnum.GAMEMASTER)
                    {
                        notice = notice + (" (<b><font color=\'" + XmlConfig.getInstance().getEntry("colors.hierarchy.gamemaster").replace("0x", "#") + "\'>" + I18n.getUiText("ui.common.gameMaster") + "</font></b>)");
                    }
                    else if (bwimsg.position == GameHierarchyEnum.ADMIN)
                    {
                        notice = notice + (" (<b><font color=\'" + XmlConfig.getInstance().getEntry("colors.hierarchy.administrator").replace("0x", "#") + "\'>" + I18n.getUiText("ui.common.administrator") + "</font></b>)");
                    }
                    text = I18n.getUiText("ui.common.whois", [bwimsg.accountNickname, notice, areaName]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.getTimestamp());
                    return true;
                }
                case msg is NumericWhoIsMessage:
                {
                    nwimsg = msg as NumericWhoIsMessage;
                    AccountManager.getInstance().setAccountFromId(nwimsg.playerId, nwimsg.accountId);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.NumericWhoIs, nwimsg.playerId, nwimsg.accountId);
                    return true;
                }
                case msg is BasicWhoIsNoMatchMessage:
                {
                    bwnmmsg = msg as BasicWhoIsNoMatchMessage;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.common.playerNotFound", [bwnmmsg.search]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.getTimestamp());
                    return true;
                }
                case msg is LivingObjectMessageRequestAction:
                {
                    lomra = msg as LivingObjectMessageRequestAction;
                    lomrmsg = new LivingObjectMessageRequestMessage();
                    lomrmsg.initLivingObjectMessageRequestMessage(lomra.msgId, null, lomra.livingObjectUID);
                    ConnectionsHandler.getConnection().send(lomrmsg);
                    return true;
                }
                case msg is LivingObjectMessageMessage:
                {
                    lommsg = msg as LivingObjectMessageMessage;
                    speakingItemText = SpeakingItemText.getSpeakingItemTextById(lommsg.msgId);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.LivingObjectMessage, lommsg.owner, speakingItemText.textString, this.getRealTimestamp(lommsg.timeStamp));
                    return true;
                }
                case msg is ChatLoadedAction:
                {
                    cla = msg as ChatLoadedAction;
                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_ON_CONNECT);
                    return true;
                }
                case msg is NotificationByServerMessage:
                {
                    nbsmsg = msg as NotificationByServerMessage;
                    a = new Array();
                    var _loc_3:* = 0;
                    var _loc_4:* = nbsmsg.parameters;
                    while (_loc_4 in _loc_3)
                    {
                        
                        parameter = _loc_4[_loc_3];
                        a.push(parameter);
                    }
                    notification = Notification.getNotificationById(nbsmsg.id);
                    title = I18n.getText(notification.titleId);
                    text = I18n.getText(notification.messageId, a);
                    if (notification.id)
                    {
                        nbsmsgNid = NotificationManager.getInstance().prepareNotification(title, text, notification.iconId, "serverMsg_" + notification.id);
                        NotificationManager.getInstance().addCallbackToNotification(nbsmsgNid, "NotificationUpdateFlag", [notification.id]);
                        NotificationManager.getInstance().sendNotification(nbsmsgNid);
                    }
                    return true;
                }
                case msg is ExchangeGuildTaxCollectorGetMessage:
                {
                    egtcgmsg = msg as ExchangeGuildTaxCollectorGetMessage;
                    idFName = parseInt(egtcgmsg.collectorName.split(",")[0], 36);
                    idName = parseInt(egtcgmsg.collectorName.split(",")[1], 36);
                    taxCollectorName = TaxCollectorFirstname.getTaxCollectorFirstnameById(idFName).firstname + " " + TaxCollectorName.getTaxCollectorNameById(idName).name;
                    textObjects;
                    var _loc_3:* = 0;
                    var _loc_4:* = egtcgmsg.objectsInfos;
                    while (_loc_4 in _loc_3)
                    {
                        
                        object = _loc_4[_loc_3];
                        if (textObjects != "")
                        {
                            textObjects = textObjects + ", ";
                        }
                        textObjects = textObjects + (object.quantity + "x" + Item.getItemById(object.objectUID).name);
                    }
                    if (textObjects != "")
                    {
                        objectsAndExp = I18n.getUiText("ui.social.thingsTaxCollectorGet", [textObjects, egtcgmsg.experience]);
                    }
                    else
                    {
                        objectsAndExp = I18n.getUiText("ui.social.xpTaxCollectorGet", [egtcgmsg.experience]);
                    }
                    text = I18n.getUiText("ui.social.taxcollectorRecolted", [taxCollectorName, "(" + egtcgmsg.worldX + ", " + egtcgmsg.worldY + ")", egtcgmsg.userName, objectsAndExp]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.CHANNEL_GUILD, this.getTimestamp());
                    return true;
                }
                case msg is NewMailMessage:
                {
                    nmmsg = msg as NewMailMessage;
                    this._ankaboxEnabled = true;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.MailStatus, true, nmmsg.unread, nmmsg.total);
                    break;
                }
                case msg is MailStatusMessage:
                {
                    msmsg = msg as MailStatusMessage;
                    this._ankaboxEnabled = true;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.MailStatus, false, msmsg.unread, msmsg.total);
                    break;
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

        public function getRedId() : uint
        {
            return RED_CHANNEL_ID;
        }// end function

        public function getMessages() : Array
        {
            return this._aMessagesByChannel;
        }// end function

        public function get options() : ChatOptions
        {
            return this._options;
        }// end function

        public function setDisplayOptions(param1:ChatOptions) : void
        {
            this._options = param1;
            return;
        }// end function

        private function onCssLoaded() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = CssManager.getInstance().getCss(this._cssUri);
            var _loc_3:* = 0;
            while (_loc_3 < 13)
            {
                
                _loc_2 = _loc_1.getStyle("p" + _loc_3);
                this._aChatColors[_loc_3] = uint(this.color0x(_loc_2["color"]));
                _loc_3++;
            }
            _loc_2 = _loc_1.getStyle("p");
            this._aChatColors.push(uint(this.color0x(_loc_2["color"])));
            return;
        }// end function

        private function color0x(param1:String) : String
        {
            return param1.replace("#", "0x");
        }// end function

        private function displayCarac(param1:CharacterBaseCharacteristic) : String
        {
            var _loc_2:* = param1.alignGiftBonus + param1.contextModif + param1.objectsAndMountBonus;
            var _loc_3:* = "+";
            if (_loc_2 < 0)
            {
                _loc_3 = "";
            }
            return param1.base + " (" + _loc_3 + _loc_2 + ")";
        }// end function

        private function playAlertSound(param1:uint) : void
        {
            var _loc_2:* = new SoundApi();
            switch(param1)
            {
                case GUILD_SOUND:
                {
                    if (_loc_2.playSoundForGuildMessage())
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.GUILD_CHAT_MESSAGE);
                    }
                    break;
                }
                case PARTY_SOUND:
                {
                    if (_loc_2.playSoundForGuildMessage())
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.PARTY_CHAT_MESSAGE);
                    }
                    break;
                }
                case PRIVATE_SOUND:
                {
                    if (_loc_2.playSoundForGuildMessage())
                    {
                        SoundManager.getInstance().manager.playUISound(UISoundEnum.PRIVATE_CHAT_MESSAGE);
                    }
                    break;
                }
                case ALERT_SOUND:
                {
                    SoundManager.getInstance().manager.playUISound(UISoundEnum.RED_CHAT_MESSAGE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function saveMessage(param1:int = 0, param2:String = "", param3:String = "", param4:Number = 0, param5:String = "", param6:uint = 0, param7:String = "", param8:Vector.<ItemWrapper> = null, param9:String = "", param10:uint = 0, param11:uint = 0, param12:Array = null, param13:Boolean = false) : void
        {
            var _loc_14:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            if (param9 != "")
            {
                _loc_14 = new ChatSentenceWithRecipient(this._msgUId, param2, param3, param1, param4, param5, param6, param7, param9, param10, param8);
            }
            else if (param7 != "")
            {
                _loc_14 = new ChatSentenceWithSource(this._msgUId, param2, param3, param1, param4, param5, param6, param7, param8, param13);
            }
            else if (param11 != 0)
            {
                _loc_14 = new ChatInformationSentence(this._msgUId, param2, param3, param1, param4, param5, param11, param12);
            }
            else
            {
                _loc_14 = new BasicChatSentence(this._msgUId, param2, param3, param1, param4, param5);
            }
            this._aMessagesByChannel[param1].push(_loc_14);
            var _loc_15:* = 0;
            if (this._aMessagesByChannel[param1].length > this._maxMessagesStored)
            {
                _loc_16 = this._aMessagesByChannel[param1].length - this._maxMessagesStored;
                _loc_17 = 0;
                while (_loc_17 < _loc_16)
                {
                    
                    this._aMessagesByChannel[param1].shift();
                    _loc_15 = _loc_15 + 1;
                    _loc_17 = _loc_17 + 1;
                }
            }
            var _loc_18:* = this;
            var _loc_19:* = this._msgUId + 1;
            _loc_18._msgUId = _loc_19;
            KernelEventsManager.getInstance().processCallback(ChatHookList.NewMessage, param1, _loc_15);
            return;
        }// end function

        private function getTimestamp() : Number
        {
            return TimeManager.getInstance().getTimestamp();
        }// end function

        private function getRealTimestamp(param1:Number) : Number
        {
            return param1 * 1000 + TimeManager.getInstance().timezoneOffset;
        }// end function

        public function getTimestampServerByRealTimestamp(param1:Number) : Number
        {
            return (param1 - TimeManager.getInstance().timezoneOffset) / 1000;
        }// end function

        public function checkCensored(param1:String, param2:uint, param3:uint, param4:String) : Array
        {
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = false;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_5:* = param1;
            if (OptionManager.getOptionManager("chat").filterInsult && param2 != 8 && param2 != 10 && param2 != 11 && param2 != 666)
            {
                _loc_15 = XmlConfig.getInstance().getEntry("config.lang.current");
                _loc_16 = "";
                _loc_17 = ["&", "%", "?", "#", "§", "!"];
                _loc_18 = _loc_15 == "ja";
                if (!_loc_18)
                {
                    _loc_19 = _loc_5.split(" ");
                    for each (_loc_20 in _loc_19)
                    {
                        
                        _loc_21 = _loc_20.toLowerCase();
                        _loc_22 = "";
                        if (this._aCensoredWords)
                        {
                            if (this._aCensoredWords[_loc_21])
                            {
                                _loc_23 = 0;
                                while (_loc_23 < _loc_21.length)
                                {
                                    
                                    _loc_22 = _loc_22 + _loc_17[_loc_21.charCodeAt(_loc_23) % 5];
                                    _loc_23++;
                                }
                            }
                            else
                            {
                                for (_loc_24 in this._aCensoredWords)
                                {
                                    
                                    if (this._aCensoredWords[_loc_24] == 2)
                                    {
                                        if (_loc_21.indexOf(_loc_24) != -1)
                                        {
                                            _loc_25 = 0;
                                            while (_loc_25 < _loc_21.length)
                                            {
                                                
                                                _loc_22 = _loc_22 + _loc_17[_loc_21.charCodeAt(_loc_25) % 5];
                                                _loc_25++;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if (_loc_22 == "")
                        {
                            _loc_22 = _loc_20;
                        }
                        _loc_16 = _loc_16 + (_loc_22 + " ");
                    }
                    _loc_5 = _loc_16.slice(0, (_loc_16.length - 1));
                }
                else
                {
                    _loc_26 = "&%?§!&?&%§!&%!&%?#§!";
                    _loc_27 = _loc_5.toUpperCase();
                    for (_loc_28 in this._aCensoredWords)
                    {
                        
                        _loc_29 = 0;
                        while (_loc_29 != -1)
                        {
                            
                            _loc_29 = _loc_27.indexOf(_loc_28);
                            if (_loc_29 != -1)
                            {
                                _loc_5 = _loc_5.substr(0, _loc_29) + _loc_26.substr(0, _loc_28.length) + _loc_5.substr(_loc_29 + _loc_28.length);
                                _loc_27 = _loc_5.toUpperCase();
                            }
                        }
                    }
                }
            }
            var _loc_6:* = _loc_5.split(" ");
            var _loc_7:* = "";
            var _loc_8:* = false;
            var _loc_9:* = "";
            var _loc_10:* = "";
            var _loc_11:* = "";
            for each (_loc_12 in _loc_6)
            {
                
                _loc_30 = "";
                _loc_31 = this.needToFormateUrl(_loc_12);
                if (_loc_31.formate)
                {
                    _loc_30 = _loc_30 + ("[<a href=\'event:chatLinkRelease," + _loc_31.url + "," + param3 + "," + param4 + "\'><u><b>" + _loc_31.url + "</b></u></a>]");
                    _loc_8 = true;
                }
                if (_loc_30 == "")
                {
                    _loc_30 = _loc_12;
                }
                _loc_7 = _loc_7 + (_loc_30 + " ");
            }
            _loc_5 = _loc_7.slice(0, (_loc_7.length - 1));
            _loc_13 = 0;
            _loc_14 = new Array();
            if (_loc_13 > 0)
            {
                _loc_32 = I18n.getUiText("ui.popup.warning");
                _loc_14[0] = _loc_5 + " [<font color=\"" + XmlConfig.getInstance().getEntry("colors.hyperlink.warning").replace("0x", "#") + "\"><u><b><a href=\'event:chatWarning\'>" + I18n.getUiText("ui.popup.warning") + "</a></b></u></font>]";
                _loc_14[1] = _loc_5 + " [" + _loc_32 + "]";
            }
            else
            {
                _loc_14[0] = _loc_5;
                _loc_14[1] = _loc_5;
            }
            return _loc_14;
        }// end function

        public function needToFormateUrl(param1:String) : Object
        {
            var _loc_2:* = param1.replace("&amp;amp;", "&");
            var _loc_3:* = _loc_2 != param1;
            var _loc_4:* = new RegExp(URL_MATCHER);
            var _loc_5:* = new RegExp(URL_MATCHER).exec(_loc_2);
            var _loc_6:* = new Object();
            new Object().formate = false;
            if (_loc_5)
            {
                if (_loc_3)
                {
                    _loc_6.url = _loc_5[0].replace("&", "&amp;amp;");
                }
                else
                {
                    _loc_6.url = _loc_5[0];
                }
                _loc_6.index = _loc_5.index;
                if (_loc_5[2] == undefined && _loc_5[8] == undefined && _loc_5[7].split(".").length >= 2 && LINK_TLDS.indexOf(_loc_5[11]) == -1)
                {
                    _loc_6.formate = false;
                }
                else
                {
                    _loc_6.formate = true;
                }
            }
            return _loc_6;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.atouin.types.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.dofus.console.*;

import com.ankamagames.dofus.datacenter.communication.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.livingObjects.*;

import com.ankamagames.dofus.datacenter.notifications.*;

import com.ankamagames.dofus.datacenter.npcs.*;

import com.ankamagames.dofus.datacenter.world.*;

import com.ankamagames.dofus.externalnotification.enums.*;

import com.ankamagames.dofus.internalDatacenter.communication.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.kernel.sound.*;

import com.ankamagames.dofus.kernel.sound.enum.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.actions.*;

import com.ankamagames.dofus.logic.game.common.actions.chat.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.common.misc.*;

import com.ankamagames.dofus.logic.game.fight.frames.*;

import com.ankamagames.dofus.logic.game.fight.messages.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.misc.options.*;

import com.ankamagames.dofus.misc.utils.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.basic.*;

import com.ankamagames.dofus.network.messages.game.chat.*;

import com.ankamagames.dofus.network.messages.game.chat.channel.*;

import com.ankamagames.dofus.network.messages.game.chat.smiley.*;

import com.ankamagames.dofus.network.messages.game.context.notification.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.messages.game.inventory.items.*;

import com.ankamagames.dofus.network.messages.game.moderation.*;

import com.ankamagames.dofus.network.messages.web.ankabox.*;

import com.ankamagames.dofus.network.types.game.character.characteristic.*;

import com.ankamagames.dofus.network.types.game.character.choice.*;

import com.ankamagames.dofus.network.types.game.context.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.dofus.types.entities.*;

import com.ankamagames.dofus.uiApi.*;

import com.ankamagames.jerakine.console.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.managers.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.misc.*;

import com.ankamagames.jerakine.utils.system.*;

import flash.utils.*;

class Notification extends Object
{
    public var title:String;
    public var contentText:String;
    public var type:uint;
    public var name:String = "";
    public var startTime:int;
    private var _duration:int;
    public var pauseOnOver:Boolean;
    public var callback:String;
    public var callbackType:String;
    public var callbackParams:Object;
    public var texture:Object;
    public var position:int;
    public var notifyUser:Boolean = false;
    public var tutorialId:int = -1;
    public var blockCallbackOnTimerEnds:Boolean = false;
    private var _buttonList:Array;
    private var _imageList:Array;

    function Notification() : void
    {
        this._buttonList = new Array();
        this._imageList = new Array();
        return;
    }// end function

    public function get duration() : int
    {
        return this._duration;
    }// end function

    public function get displayText() : String
    {
        return this.title + "\n\n" + this.contentText;
    }// end function

    public function get buttonList() : Array
    {
        return this._buttonList;
    }// end function

    public function get imageList() : Array
    {
        return this._imageList;
    }// end function

    public function addButton(param1:String, param2:String, param3:Object = null, param4:Boolean = false, param5:Number = 0, param6:Number = 0, param7:String = "action") : void
    {
        var _loc_8:* = new Object();
        new Object().label = param1;
        _loc_8.action = param2;
        _loc_8.actionType = param7;
        _loc_8.params = param3;
        _loc_8.width = param5 <= 0 ? (130) : (param5);
        _loc_8.height = param6 <= 0 ? (32) : (param6);
        _loc_8.forceClose = param4;
        _loc_8.name = "btn" + ((this._buttonList.length + 1)).toString();
        this._buttonList.push(_loc_8);
        return;
    }// end function

    public function addImage(param1:Uri, param2:String = "", param3:String = "", param4:Number = -1, param5:Number = -1, param6:Number = -1, param7:Number = -1) : void
    {
        var _loc_8:* = new Object();
        new Object().uri = param1;
        _loc_8.label = param2;
        _loc_8.tips = param3;
        _loc_8.x = param4;
        _loc_8.y = param5;
        _loc_8.width = param6;
        _loc_8.height = param7;
        _loc_8.verticalAlign = param5 == -1;
        _loc_8.horizontalAlign = false;
        this._imageList.push(_loc_8);
        return;
    }// end function

    public function setTimer(param1:uint, param2:Boolean = false, param3:Boolean = false) : void
    {
        this._duration = param1 * 1000;
        this.startTime = 0;
        this.pauseOnOver = param2;
        this.blockCallbackOnTimerEnds = param3;
        this.notifyUser = true;
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.atouin.types.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.dofus.console.*;

import com.ankamagames.dofus.datacenter.communication.*;

import com.ankamagames.dofus.datacenter.items.*;

import com.ankamagames.dofus.datacenter.livingObjects.*;

import com.ankamagames.dofus.datacenter.notifications.*;

import com.ankamagames.dofus.datacenter.npcs.*;

import com.ankamagames.dofus.datacenter.world.*;

import com.ankamagames.dofus.externalnotification.enums.*;

import com.ankamagames.dofus.internalDatacenter.communication.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.kernel.*;

import com.ankamagames.dofus.kernel.net.*;

import com.ankamagames.dofus.kernel.sound.*;

import com.ankamagames.dofus.kernel.sound.enum.*;

import com.ankamagames.dofus.logic.common.managers.*;

import com.ankamagames.dofus.logic.game.common.actions.*;

import com.ankamagames.dofus.logic.game.common.actions.chat.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.logic.game.common.misc.*;

import com.ankamagames.dofus.logic.game.fight.frames.*;

import com.ankamagames.dofus.logic.game.fight.messages.*;

import com.ankamagames.dofus.logic.game.roleplay.frames.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.misc.options.*;

import com.ankamagames.dofus.misc.utils.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.messages.game.basic.*;

import com.ankamagames.dofus.network.messages.game.chat.*;

import com.ankamagames.dofus.network.messages.game.chat.channel.*;

import com.ankamagames.dofus.network.messages.game.chat.smiley.*;

import com.ankamagames.dofus.network.messages.game.context.notification.*;

import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;

import com.ankamagames.dofus.network.messages.game.inventory.items.*;

import com.ankamagames.dofus.network.messages.game.moderation.*;

import com.ankamagames.dofus.network.messages.web.ankabox.*;

import com.ankamagames.dofus.network.types.game.character.characteristic.*;

import com.ankamagames.dofus.network.types.game.character.choice.*;

import com.ankamagames.dofus.network.types.game.context.*;

import com.ankamagames.dofus.network.types.game.context.roleplay.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.dofus.network.types.game.data.items.effects.*;

import com.ankamagames.dofus.types.entities.*;

import com.ankamagames.dofus.uiApi.*;

import com.ankamagames.jerakine.console.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.managers.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.misc.*;

import com.ankamagames.jerakine.utils.system.*;

import flash.utils.*;

class Smiley extends Object
{
    public var pictoId:int;
    public var position:int;

    function Smiley(param1:int, param2:int) : void
    {
        this.pictoId = param1;
        this.position = param2;
        return;
    }// end function

}

