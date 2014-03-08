package com.ankamagames.dofus.logic.game.approach.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Loader;
   import flash.events.IOErrorEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedSuccessMessage;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketAcceptedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketRefusedMessage;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AlreadyConnectedMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListMessage;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.network.messages.game.character.choice.BasicCharactersListMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AccountCapabilitiesMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCreationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCreationResultMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.network.messages.game.character.deletion.CharacterDeletionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.deletion.CharacterDeletionErrorMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionFailureMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRelookSelectionAction;
   import com.ankamagames.dofus.network.messages.security.ClientKeyMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateRequestMessage;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.lua.LuaPlayer;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedErrorMissingMapPackMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.misc.Pack;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedErrorMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicTimeMessage;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsListMessage;
   import com.ankamagames.dofus.network.messages.authorized.ConsoleCommandsListMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListWithModificationsMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRecolorInformation;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRelookInformation;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterHardcoreInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsExecuteMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.network.messages.game.character.replay.CharacterReplayWithRecolorRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionWithRecolorMessage;
   import com.ankamagames.dofus.network.messages.game.character.replay.CharacterReplayWithRenameRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionWithRenameMessage;
   import com.ankamagames.dofus.network.messages.game.character.replay.CharacterReplayWithRelookRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionWithRelookMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterFirstSelectionMessage;
   import com.ankamagames.dofus.network.messages.game.character.replay.CharacterReplayRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionMessage;
   import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionsObjetAttributionMessage;
   import com.ankamagames.dofus.network.messages.game.startup.StartupActionFinishedMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.utils.setTimeout;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.network.enums.CharacterDeletionErrorEnum;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceReadyMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRecolorSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRenameSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterReplayRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SynchronisationFrame;
   import com.ankamagames.dofus.logic.game.common.frames.LivingObjectFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ContextChangeFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CommonUiFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.JobsFrame;
   import com.ankamagames.dofus.logic.game.common.frames.MountFrame;
   import com.ankamagames.dofus.logic.game.common.frames.HouseFrame;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ExternalGameFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   import com.ankamagames.dofus.logic.connection.frames.GameStartingFrame;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
   import com.ankamagames.dofus.console.moduleLogger.Console;
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.dofus.logic.game.common.frames.ServerTransferFrame;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.jerakine.script.ScriptsManager;
   import com.ankamagames.dofus.scripts.api.EntityApi;
   import com.ankamagames.dofus.scripts.api.ScriptSequenceApi;
   import com.ankamagames.dofus.scripts.api.CameraApi;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.types.data.ServerCommand;
   import com.ankamagames.dofus.network.messages.game.approach.HelloGameMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListErrorMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeselectionAction;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListRequestMessage;
   import flash.system.ApplicationDomain;
   
   public class GameServerApproachFrame extends Object implements Frame
   {
      
      public function GameServerApproachFrame() {
         this._charactersList = new Vector.<BasicCharacterWrapper>();
         this._charactersToRecolorList = new Array();
         this._charactersToRenameList = new Array();
         this._charactersToRelookList = new Array();
         this._giftList = new Array();
         this._kernel = KernelEventsManager.getInstance();
         this._lc = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameServerApproachFrame));
      
      private static var _changeLogLoader:Loader = new Loader();
      
      private static function onChangeLogError(param1:IOErrorEvent) : void {
      }
      
      private static function onChangeLogLoaded(param1:Event) : void {
      }
      
      private var _charactersList:Vector.<BasicCharacterWrapper>;
      
      private var _charactersToRecolorList:Array;
      
      private var _charactersToRenameList:Array;
      
      private var _charactersToRelookList:Array;
      
      private var _giftList:Array;
      
      private var _kernel:KernelEventsManager;
      
      private var _gmaf:LoadingModuleFrame;
      
      private var _waitingMessages:Vector.<Message>;
      
      private var _cssmsg:CharacterSelectedSuccessMessage;
      
      private var _requestedCharacterId:uint;
      
      private var _lc:LoaderContext;
      
      private var commonMod:Object;
      
      private var _reconnectMsgSend:Boolean = false;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get requestedCharaId() : uint {
         return this._requestedCharacterId;
      }
      
      public function set requestedCharaId(param1:uint) : void {
         this._requestedCharacterId = param1;
      }
      
      public function isCharacterWaitingForChange(param1:uint) : Boolean {
         if(this._charactersToRecolorList[param1])
         {
            return true;
         }
         return false;
      }
      
      public function pushed() : Boolean {
         SecureModeManager.getInstance().checkMigrate();
         AirScanner.allowByteCodeExecution(this._lc,true);
         Kernel.getWorker().addFrame(new MiscFrame());
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var perso:* = undefined;
         var color:* = undefined;
         var characterId:int = 0;
         var characterColors:Array = null;
         var characterName:String = null;
         var characterHead:int = 0;
         var recolors:Vector.<int> = null;
         var isReplay:Boolean = false;
         var parts:Vector.<uint> = null;
         var atamsg:AuthenticationTicketAcceptedMessage = null;
         var atrmsg:AuthenticationTicketRefusedMessage = null;
         var scfMsg:ServerConnectionFailedMessage = null;
         var acmsg:AlreadyConnectedMessage = null;
         var clmsg:CharactersListMessage = null;
         var unusableCharacters:Vector.<uint> = null;
         var o:BasicCharacterWrapper = null;
         var unusable:Boolean = false;
         var server:Server = null;
         var bclmsg:BasicCharactersListMessage = null;
         var b:BasicCharacterWrapper = null;
         var accmsg:AccountCapabilitiesMessage = null;
         var cca:CharacterCreationAction = null;
         var ccmsg:CharacterCreationRequestMessage = null;
         var colors:Vector.<int> = null;
         var ccrmsg:CharacterCreationResultMessage = null;
         var cda:CharacterDeletionAction = null;
         var cdrmsg:CharacterDeletionRequestMessage = null;
         var cdemsg:CharacterDeletionErrorMessage = null;
         var reason:String = null;
         var cnsra:CharacterNameSuggestionRequestAction = null;
         var cnsrmsg:CharacterNameSuggestionRequestMessage = null;
         var cnssmsg:CharacterNameSuggestionSuccessMessage = null;
         var cnsfmsg:CharacterNameSuggestionFailureMessage = null;
         var i:int = 0;
         var crlsa:CharacterRelookSelectionAction = null;
         var bTutorial:Boolean = false;
         var cssmsg:CharacterSelectedSuccessMessage = null;
         var flashKeyMsg:ClientKeyMessage = null;
         var gccrmsg:GameContextCreateRequestMessage = null;
         var soundApi:SoundApi = null;
         var luaPlayer:LuaPlayer = null;
         var csemmpmsg:CharacterSelectedErrorMissingMapPackMessage = null;
         var subArea:SubArea = null;
         var pack:Pack = null;
         var csemsg:CharacterSelectedErrorMessage = null;
         var btmsg:BasicTimeMessage = null;
         var date:Date = null;
         var salm:StartupActionsListMessage = null;
         var cclMsg:ConsoleCommandsListMessage = null;
         var atmsg:AuthenticationTicketMessage = null;
         var clwrmsg:CharactersListWithModificationsMessage = null;
         var ctrci:CharacterToRecolorInformation = null;
         var ctrni:uint = 0;
         var ctrli:CharacterToRelookInformation = null;
         var ctrid:int = 0;
         var charColors:Array = null;
         var num:int = 0;
         var uIndexedColor:Number = NaN;
         var uIndex:int = 0;
         var uColor:int = 0;
         var chi:CharacterHardcoreInformations = null;
         var cbi:CharacterBaseInformations = null;
         var bonusXp:int = 0;
         var cbi2:CharacterBaseInformations = null;
         var openCharsList:Boolean = false;
         var saem:StartupActionsExecuteMessage = null;
         var charToConnect:BasicCharacterWrapper = null;
         var charToConnectSpecificallyId:int = 0;
         var ctc:BasicCharacterWrapper = null;
         var fakacsa:CharacterSelectionAction = null;
         var bChi:CharacterHardcoreInformations = null;
         var bCbi:CharacterBaseInformations = null;
         var c:* = undefined;
         var persoc:Object = null;
         var crwrrmsg:CharacterReplayWithRecolorRequestMessage = null;
         var cswrmsg:CharacterSelectionWithRecolorMessage = null;
         var person:Object = null;
         var crwrnrmsg:CharacterReplayWithRenameRequestMessage = null;
         var cswrnmsg:CharacterSelectionWithRenameMessage = null;
         var person2:Object = null;
         var crwrlrmsg:CharacterReplayWithRelookRequestMessage = null;
         var cswrlmsg:CharacterSelectionWithRelookMessage = null;
         var charToColor:* = undefined;
         var charToRename2:Object = null;
         var charToRelook:Object = null;
         var firstSelection:Boolean = false;
         var cfsmsg:CharacterFirstSelectionMessage = null;
         var crrmsg:CharacterReplayRequestMessage = null;
         var csmsg:CharacterSelectionMessage = null;
         var gift:StartupActionAddObject = null;
         var _items:Array = null;
         var item:ObjectItemInformationWithQuantity = null;
         var oj:Object = null;
         var iw:ItemWrapper = null;
         var charaListMinusDeadPeople:Array = null;
         var gar:GiftAssignRequestAction = null;
         var sao:StartupActionsObjetAttributionMessage = null;
         var safm:StartupActionFinishedMessage = null;
         var cmdIndex:uint = 0;
         var msg:Message = param1;
         switch(true)
         {
            case msg is HelloGameMessage:
               ConnectionsHandler.confirmGameServerConnection();
               parts = PartManager.getInstance().getServerPartList();
               atmsg = new AuthenticationTicketMessage();
               atmsg.initAuthenticationTicketMessage(LangManager.getInstance().getEntry("config.lang.current"),AuthentificationManager.getInstance().gameServerTicket);
               ConnectionsHandler.getConnection().send(atmsg);
               InactivityManager.getInstance().start();
               this._kernel.processCallback(HookList.AuthenticationTicket);
               return true;
            case msg is AuthenticationTicketAcceptedMessage:
               atamsg = msg as AuthenticationTicketAcceptedMessage;
               setTimeout(this.requestCharactersList,500);
               this._kernel.processCallback(HookList.AuthenticationTicketAccepted);
               return true;
            case msg is AuthenticationTicketRefusedMessage:
               atrmsg = msg as AuthenticationTicketRefusedMessage;
               this._kernel.processCallback(HookList.AuthenticationTicketRefused);
               return true;
            case msg is ServerConnectionFailedMessage:
               scfMsg = ServerConnectionFailedMessage(msg);
               if(scfMsg.failedConnection == ConnectionsHandler.getConnection().getSubConnection(scfMsg))
               {
                  PlayerManager.getInstance().destroy();
                  this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.connexion.gameConnexionFailed"),[I18n.getUiText("ui.common.ok")],[this.onEscapePopup],this.onEscapePopup,this.onEscapePopup);
                  KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
               }
               return true;
            case msg is AlreadyConnectedMessage:
               acmsg = AlreadyConnectedMessage(msg);
               KernelEventsManager.getInstance().processCallback(HookList.AlreadyConnected);
               return true;
            case msg is CharactersListMessage:
               clmsg = msg as CharactersListMessage;
               unusableCharacters = new Vector.<uint>();
               if(msg is CharactersListWithModificationsMessage)
               {
                  clwrmsg = msg as CharactersListWithModificationsMessage;
                  for each (ctrci in clwrmsg.charactersToRecolor)
                  {
                     charColors = new Array(-1,-1,-1,-1,-1);
                     num = ctrci.colors.length;
                     i = 0;
                     while(i < num)
                     {
                        uIndexedColor = ctrci.colors[i];
                        uIndex = uIndexedColor >> 24-1;
                        uColor = uIndexedColor & 16777215;
                        if(uIndex > -1 && uIndex < charColors.length)
                        {
                           charColors[uIndex] = uColor;
                        }
                        i++;
                     }
                     this._charactersToRecolorList[ctrci.id] = 
                        {
                           "id":ctrci.id,
                           "colors":charColors
                        };
                  }
                  for each (ctrni in clwrmsg.charactersToRename)
                  {
                     this._charactersToRenameList.push(ctrni);
                  }
                  for each (ctrli in clwrmsg.charactersToRelook)
                  {
                     this._charactersToRelookList[ctrli.id] = ctrli;
                  }
                  for each (ctrid in clwrmsg.unusableCharacters)
                  {
                     unusableCharacters.push(ctrid);
                  }
               }
               this._charactersList = new Vector.<BasicCharacterWrapper>();
               unusable = false;
               server = PlayerManager.getInstance().server;
               if(server.gameTypeId == 1)
               {
                  for each (chi in clmsg.characters)
                  {
                     if(unusableCharacters.indexOf(chi.id) != -1)
                     {
                        unusable = true;
                     }
                     o = BasicCharacterWrapper.create(chi.id,chi.name,chi.level,chi.entityLook,chi.breed,chi.sex,chi.deathState,chi.deathCount,1,unusable);
                     this._charactersList.push(o);
                  }
               }
               else
               {
                  for each (cbi in clmsg.characters)
                  {
                     if(unusableCharacters.indexOf(cbi.id) != -1)
                     {
                        unusable = true;
                     }
                     bonusXp = 1;
                     for each (cbi2 in clmsg.characters)
                     {
                        if(!(cbi2.id == cbi.id) && cbi2.level > cbi.level && bonusXp < 4)
                        {
                           bonusXp++;
                        }
                     }
                     o = BasicCharacterWrapper.create(cbi.id,cbi.name,cbi.level,cbi.entityLook,cbi.breed,cbi.sex,0,0,bonusXp,unusable);
                     this._charactersList.push(o);
                  }
               }
               PlayerManager.getInstance().charactersList = this._charactersList;
               if(this._charactersList.length)
               {
                  openCharsList = true;
                  if(clmsg.hasStartupActions)
                  {
                     saem = new StartupActionsExecuteMessage();
                     saem.initStartupActionsExecuteMessage();
                     ConnectionsHandler.getConnection().send(saem);
                     openCharsList = false;
                  }
                  else
                  {
                     if((((Dofus.getInstance().options) && (Dofus.getInstance().options.autoConnectType == 2)) || (PlayerManager.getInstance().autoConnectOfASpecificCharacterId > -1)) && (PlayerManager.getInstance().allowAutoConnectCharacter))
                     {
                        charToConnectSpecificallyId = PlayerManager.getInstance().autoConnectOfASpecificCharacterId;
                        if(charToConnectSpecificallyId == -1)
                        {
                           charToConnect = this._charactersList[0];
                        }
                        else
                        {
                           for each (ctc in this._charactersList)
                           {
                              if(ctc.id == charToConnectSpecificallyId)
                              {
                                 charToConnect = ctc;
                                 break;
                              }
                           }
                        }
                        if((charToConnect) && (!(server.gameTypeId == 1) || charToConnect.deathState == 0) && !SecureModeManager.getInstance().active && !this.isCharacterWaitingForChange(charToConnect.id))
                        {
                           openCharsList = false;
                           this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
                           fakacsa = new CharacterSelectionAction();
                           fakacsa.btutoriel = false;
                           fakacsa.characterId = charToConnect.id;
                           this.process(fakacsa);
                           PlayerManager.getInstance().allowAutoConnectCharacter = false;
                        }
                     }
                  }
                  if(openCharsList)
                  {
                     if(!Berilia.getInstance().getUi("characterSelection"))
                     {
                        this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                     }
                     else
                     {
                        this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
                     }
                  }
               }
               else
               {
                  this._kernel.processCallback(HookList.CharacterCreationStart,["create",true]);
                  this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
               }
               return true;
            case msg is BasicCharactersListMessage:
               bclmsg = msg as BasicCharactersListMessage;
               this._charactersList = new Vector.<BasicCharacterWrapper>();
               if(PlayerManager.getInstance().server.gameTypeId == 1)
               {
                  for each (bChi in bclmsg.characters)
                  {
                     b = BasicCharacterWrapper.create(bChi.id,bChi.name,bChi.level,bChi.entityLook,bChi.breed,bChi.sex,bChi.deathState,bChi.deathCount,1,false);
                     this._charactersList.push(b);
                  }
               }
               else
               {
                  for each (bCbi in bclmsg.characters)
                  {
                     b = BasicCharacterWrapper.create(bCbi.id,bCbi.name,bCbi.level,bCbi.entityLook,bCbi.breed,bCbi.sex,0,0,1,false);
                     this._charactersList.push(b);
                  }
               }
               PlayerManager.getInstance().charactersList = this._charactersList;
               return true;
            case msg is CharactersListErrorMessage:
               this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.connexion.charactersListError"),[I18n.getUiText("ui.common.ok")]);
               return false;
            case msg is AccountCapabilitiesMessage:
               accmsg = msg as AccountCapabilitiesMessage;
               this._kernel.processCallback(HookList.TutorielAvailable,accmsg.tutorialAvailable);
               this._kernel.processCallback(HookList.BreedsAvailable,accmsg.breedsAvailable,accmsg.breedsVisible);
               PlayerManager.getInstance().adminStatus = accmsg.status;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterCreationStart,["create"]);
               return true;
            case msg is CharacterCreationAction:
               cca = msg as CharacterCreationAction;
               ccmsg = new CharacterCreationRequestMessage();
               colors = new Vector.<int>();
               for each (c in cca.colors)
               {
                  colors.push(c);
               }
               while(colors.length < ProtocolConstantsEnum.MAX_PLAYER_COLOR)
               {
                  colors.push(-1);
               }
               ccmsg.initCharacterCreationRequestMessage(cca.name,cca.breed,cca.sex,colors,cca.head);
               ConnectionsHandler.getConnection().send(ccmsg);
               return true;
            case msg is CharacterCreationResultMessage:
               ccrmsg = msg as CharacterCreationResultMessage;
               this._kernel.processCallback(HookList.CharacterCreationResult,ccrmsg.result);
               return true;
            case msg is CharacterDeletionAction:
               cda = msg as CharacterDeletionAction;
               cdrmsg = new CharacterDeletionRequestMessage();
               cdrmsg.initCharacterDeletionRequestMessage(cda.id,MD5.hash(cda.id + "~" + cda.answer));
               ConnectionsHandler.getConnection().send(cdrmsg);
               return true;
            case msg is CharacterDeletionErrorMessage:
               cdemsg = msg as CharacterDeletionErrorMessage;
               reason = "";
               if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_TOO_MANY_CHAR_DELETION)
               {
                  reason = "TooManyDeletion";
               }
               else
               {
                  if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_BAD_SECRET_ANSWER)
                  {
                     reason = "WrongAnswer";
                  }
                  else
                  {
                     if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_RESTRICED_ZONE)
                     {
                        reason = "UnsecureMode";
                     }
                  }
               }
               this._kernel.processCallback(HookList.CharacterDeletionError,reason);
               return true;
            case msg is CharacterNameSuggestionRequestAction:
               cnsra = msg as CharacterNameSuggestionRequestAction;
               cnsrmsg = new CharacterNameSuggestionRequestMessage();
               cnsrmsg.initCharacterNameSuggestionRequestMessage();
               ConnectionsHandler.getConnection().send(cnsrmsg);
               return true;
            case msg is CharacterNameSuggestionSuccessMessage:
               cnssmsg = msg as CharacterNameSuggestionSuccessMessage;
               this._kernel.processCallback(HookList.CharacterNameSuggestioned,cnssmsg.suggestion);
               return true;
            case msg is CharacterNameSuggestionFailureMessage:
               cnsfmsg = msg as CharacterNameSuggestionFailureMessage;
               _log.error("Generation de nom impossible !");
               return true;
            case msg is CharacterSelectedForceMessage:
               if(!this._reconnectMsgSend)
               {
                  Kernel.beingInReconection = true;
                  characterId = CharacterSelectedForceMessage(msg).id;
                  this._reconnectMsgSend = true;
                  ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
               }
               return true;
            case msg is CharacterRecolorSelectionAction:
               if(PlayerManager.getInstance().server.gameTypeId == 1)
               {
                  for each (persoc in this._charactersList)
                  {
                     if(persoc.id == (msg as CharacterRecolorSelectionAction).characterId)
                     {
                        if(persoc.deathState == 1)
                        {
                           isReplay = true;
                        }
                        else
                        {
                           if(persoc.deathState == 0)
                           {
                              isReplay = false;
                           }
                           else
                           {
                              this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.common.cantSelectThisCharacterLimb"),[I18n.getUiText("ui.common.ok")]);
                           }
                        }
                     }
                  }
               }
               else
               {
                  isReplay = false;
               }
               characterId = (msg as CharacterRecolorSelectionAction).characterId;
               characterColors = (msg as CharacterRecolorSelectionAction).characterColors;
               recolors = new Vector.<int>();
               i = 0;
               i = 0;
               while(recolors.length < ProtocolConstantsEnum.MAX_PLAYER_COLOR)
               {
                  if(characterColors[i] != null)
                  {
                     recolors.push(characterColors[i]);
                  }
                  else
                  {
                     recolors.push(-1);
                  }
                  i++;
               }
               if(isReplay)
               {
                  crwrrmsg = new CharacterReplayWithRecolorRequestMessage();
                  crwrrmsg.initCharacterReplayWithRecolorRequestMessage(characterId,recolors);
                  ConnectionsHandler.getConnection().send(crwrrmsg);
               }
               else
               {
                  cswrmsg = new CharacterSelectionWithRecolorMessage();
                  cswrmsg.initCharacterSelectionWithRecolorMessage(characterId,recolors);
                  ConnectionsHandler.getConnection().send(cswrmsg);
               }
               return true;
            case msg is CharacterRenameSelectionAction:
               if(PlayerManager.getInstance().server.gameTypeId == 1)
               {
                  for each (person in this._charactersList)
                  {
                     if(person.id == (msg as CharacterRenameSelectionAction).characterId)
                     {
                        if(person.deathState == 1)
                        {
                           isReplay = true;
                        }
                        else
                        {
                           if(person.deathState == 0)
                           {
                              isReplay = false;
                           }
                           else
                           {
                              this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.common.cantSelectThisCharacterLimb"),[I18n.getUiText("ui.common.ok")]);
                           }
                        }
                     }
                  }
               }
               else
               {
                  isReplay = false;
               }
               characterId = (msg as CharacterRenameSelectionAction).characterId;
               characterName = (msg as CharacterRenameSelectionAction).characterName;
               if(isReplay)
               {
                  crwrnrmsg = new CharacterReplayWithRenameRequestMessage();
                  crwrnrmsg.initCharacterReplayWithRenameRequestMessage(characterId,characterName);
                  ConnectionsHandler.getConnection().send(crwrnrmsg);
               }
               else
               {
                  cswrnmsg = new CharacterSelectionWithRenameMessage();
                  cswrnmsg.initCharacterSelectionWithRenameMessage(characterId,characterName);
                  ConnectionsHandler.getConnection().send(cswrnmsg);
               }
               return true;
            case msg is CharacterRelookSelectionAction:
               crlsa = msg as CharacterRelookSelectionAction;
               if(PlayerManager.getInstance().server.gameTypeId == 1)
               {
                  for each (person2 in this._charactersList)
                  {
                     if(person2.id == crlsa.characterId)
                     {
                        if(person2.deathState == 1)
                        {
                           isReplay = true;
                        }
                        else
                        {
                           if(person2.deathState == 0)
                           {
                              isReplay = false;
                           }
                           else
                           {
                              this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.common.cantSelectThisCharacterLimb"),[I18n.getUiText("ui.common.ok")]);
                           }
                        }
                     }
                  }
               }
               else
               {
                  isReplay = false;
               }
               characterId = crlsa.characterId;
               characterHead = crlsa.characterHead;
               if(isReplay)
               {
                  crwrlrmsg = new CharacterReplayWithRelookRequestMessage();
                  crwrlrmsg.initCharacterReplayWithRelookRequestMessage(characterId,characterHead);
                  ConnectionsHandler.getConnection().send(crwrlrmsg);
               }
               else
               {
                  cswrlmsg = new CharacterSelectionWithRelookMessage();
                  cswrlmsg.initCharacterSelectionWithRelookMessage(characterId,characterHead);
                  ConnectionsHandler.getConnection().send(cswrlmsg);
               }
               return true;
            case msg is CharacterDeselectionAction:
               this._requestedCharacterId = 0;
               return true;
            case msg is CharacterSelectionAction:
            case msg is CharacterReplayRequestAction:
               if(this._requestedCharacterId)
               {
                  return false;
               }
               bTutorial = false;
               if(msg is CharacterSelectionAction)
               {
                  characterId = (msg as CharacterSelectionAction).characterId;
                  bTutorial = (msg as CharacterSelectionAction).btutoriel;
                  isReplay = false;
               }
               else
               {
                  if(msg is CharacterReplayRequestAction)
                  {
                     characterId = (msg as CharacterReplayRequestAction).characterId;
                     bTutorial = false;
                     isReplay = true;
                  }
               }
               this._requestedCharacterId = characterId;
               if(this._charactersToRecolorList[characterId])
               {
                  for each (perso in this._charactersList)
                  {
                     if(perso.id == characterId)
                     {
                        charToColor = perso;
                     }
                  }
                  this._kernel.processCallback(HookList.CharacterCreationStart,new Array("recolor",charToColor,this._charactersToRecolorList[characterId].colors));
               }
               else
               {
                  if(this._charactersToRenameList.indexOf(characterId) != -1)
                  {
                     for each (perso in this._charactersList)
                     {
                        if(perso.id == characterId)
                        {
                           charToRename2 = perso;
                        }
                     }
                     this._kernel.processCallback(HookList.CharacterCreationStart,new Array("rename",charToRename2));
                  }
                  else
                  {
                     if(this._charactersToRelookList[characterId])
                     {
                        for each (perso in this._charactersList)
                        {
                           if(perso.id == characterId)
                           {
                              charToRelook = perso;
                           }
                        }
                        this._kernel.processCallback(HookList.CharacterCreationStart,new Array("relook",charToRelook,this._charactersToRelookList[characterId].cosmeticId));
                     }
                     else
                     {
                        firstSelection = bTutorial;
                        if(bTutorial)
                        {
                           cfsmsg = new CharacterFirstSelectionMessage();
                           cfsmsg.initCharacterFirstSelectionMessage(characterId,true);
                           ConnectionsHandler.getConnection().send(cfsmsg);
                        }
                        else
                        {
                           if(isReplay)
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
                     }
                  }
               }
               return true;
            case msg is CharacterSelectedSuccessMessage:
               cssmsg = msg as CharacterSelectedSuccessMessage;
               ConnectionsHandler.pause();
               if(this._gmaf == null)
               {
                  this._gmaf = new LoadingModuleFrame();
                  Kernel.getWorker().addFrame(this._gmaf);
               }
               PlayedCharacterManager.getInstance().infos = cssmsg.infos;
               DataStoreType.CHARACTER_ID = cssmsg.infos.id.toString();
               Kernel.getWorker().pause();
               this._cssmsg = cssmsg;
               UiModuleManager.getInstance().reset();
               if(PlayerManager.getInstance().hasRights)
               {
                  UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE,false);
               }
               else
               {
                  UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE.concat(Constants.ADMIN_MODULE),false);
               }
               Dofus.getInstance().renameApp(cssmsg.infos.name);
               if(AirScanner.hasAir())
               {
                  ExternalNotificationManager.getInstance().init();
               }
               return true;
            case msg is AllModulesLoadedMessage:
               this._gmaf = null;
               try
               {
                  _changeLogLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onChangeLogError);
                  _changeLogLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onChangeLogLoaded);
                  if(AirScanner.hasAir())
                  {
                     _changeLogLoader.loadBytes(Base64.decodeToByteArray(I18n.getUiText("ui.link.changelog")),this._lc);
                  }
               }
               catch(e:Error)
               {
               }
               Kernel.getWorker().addFrame(new AlignmentFrame());
               Kernel.getWorker().addFrame(new SynchronisationFrame());
               Kernel.getWorker().addFrame(new LivingObjectFrame());
               Kernel.getWorker().addFrame(new AllianceFrame());
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
               Kernel.getWorker().addFrame(new EmoticonFrame());
               Kernel.getWorker().addFrame(new QuestFrame());
               Kernel.getWorker().addFrame(new TinselFrame());
               Kernel.getWorker().addFrame(new PartyManagementFrame());
               Kernel.getWorker().addFrame(new ProtectPishingFrame());
               Kernel.getWorker().addFrame(new StackManagementFrame());
               Kernel.getWorker().addFrame(new ExternalGameFrame());
               Kernel.getWorker().addFrame(new AveragePricesFrame());
               Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(GameStartingFrame));
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               if((Kernel.beingInReconection) && !this._reconnectMsgSend)
               {
                  this._reconnectMsgSend = true;
                  ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
               }
               flashKeyMsg = new ClientKeyMessage();
               flashKeyMsg.initClientKeyMessage(InterClientManager.getInstance().flashKey);
               ConnectionsHandler.getConnection().send(flashKeyMsg);
               if(this._cssmsg != null)
               {
                  PlayedCharacterManager.getInstance().infos = this._cssmsg.infos;
                  DataStoreType.CHARACTER_ID = this._cssmsg.infos.id.toString();
               }
               Kernel.getWorker().removeFrame(this);
               if(PlayerManager.getInstance().subscriptionEndDate > 0)
               {
                  PartManager.getInstance().checkAndDownload("all");
                  PartManager.getInstance().checkAndDownload("subscribed");
               }
               if(XmlConfig.getInstance().getBooleanEntry("config.dev.mode"))
               {
                  ModuleDebugManager.display(XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.controler"));
                  Console.getInstance().display(!XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.eventUtil"));
                  ConsoleLUA.getInstance().display(!XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.luaUtil"));
               }
               this._kernel.processCallback(HookList.GameStart);
               Kernel.getWorker().addFrame(new ServerTransferFrame());
               gccrmsg = new GameContextCreateRequestMessage();
               ConnectionsHandler.getConnection().send(gccrmsg);
               soundApi = new SoundApi();
               soundApi.stopIntroMusic();
               Shortcut.loadSavedData();
               luaPlayer = ScriptsManager.getInstance().getPlayer(ScriptsManager.LUA_PLAYER) as LuaPlayer;
               if(!luaPlayer)
               {
                  luaPlayer = new LuaPlayer();
                  ScriptsManager.getInstance().addPlayer(ScriptsManager.LUA_PLAYER,luaPlayer);
                  ScriptsManager.getInstance().addPlayerApi(luaPlayer,"EntityApi",new EntityApi());
                  ScriptsManager.getInstance().addPlayerApi(luaPlayer,"SeqApi",new ScriptSequenceApi());
                  ScriptsManager.getInstance().addPlayerApi(luaPlayer,"CameraApi",new CameraApi());
               }
               return true;
            case msg is ConnectionResumedMessage:
               return true;
            case msg is CharacterSelectedErrorMissingMapPackMessage:
               csemmpmsg = msg as CharacterSelectedErrorMissingMapPackMessage;
               subArea = SubArea.getSubAreaById(csemmpmsg.subAreaId);
               pack = Pack.getPackById(subArea.packId);
               if(pack.name == "subscribed")
               {
                  PartManager.getInstance().checkAndDownload("all");
               }
               PartManager.getInstance().checkAndDownload(pack.name);
               KernelEventsManager.getInstance().processCallback(HookList.PackRestrictedSubArea,csemmpmsg.subAreaId);
               return true;
            case msg is CharacterSelectedErrorMessage:
               csemsg = msg as CharacterSelectedErrorMessage;
               this._kernel.processCallback(HookList.CharacterImpossibleSelection,this._requestedCharacterId);
               this._requestedCharacterId = 0;
               return true;
            case msg is BasicTimeMessage:
               btmsg = msg as BasicTimeMessage;
               date = new Date();
               TimeManager.getInstance().serverTimeLag = (btmsg.timestamp + btmsg.timezoneOffset * 60) * 1000 - date.getTime();
               TimeManager.getInstance().serverUtcTimeLag = btmsg.timestamp * 1000 - date.getTime();
               TimeManager.getInstance().timezoneOffset = btmsg.timezoneOffset * 60 * 1000;
               TimeManager.getInstance().dofusTimeYearLag = -1370;
               return true;
            case msg is StartupActionsListMessage:
               salm = msg as StartupActionsListMessage;
               for each (gift in salm.actions)
               {
                  _items = new Array();
                  for each (item in gift.items)
                  {
                     iw = ItemWrapper.create(0,0,item.objectGID,item.quantity,item.effects,false);
                     _items.push(iw);
                  }
                  oj = 
                     {
                        "uid":gift.uid,
                        "title":gift.title,
                        "text":gift.text,
                        "items":_items
                     };
                  this._giftList.push(oj);
               }
               if(this._giftList.length)
               {
                  charaListMinusDeadPeople = new Array();
                  for each (perso in this._charactersList)
                  {
                     if(!perso.deathState || perso.deathState == 0)
                     {
                        charaListMinusDeadPeople.push(perso);
                     }
                  }
                  if(charaListMinusDeadPeople.length > 0)
                  {
                     this._kernel.processCallback(HookList.GiftList,this._giftList,charaListMinusDeadPeople);
                  }
                  else
                  {
                     if(!Berilia.getInstance().getUi("characterSelection"))
                     {
                        this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                     }
                     else
                     {
                        this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
                     }
                  }
               }
               else
               {
                  Kernel.getWorker().removeFrame(this);
                  _log.warn("Empty Gift List Received");
               }
               return true;
            case msg is GiftAssignRequestAction:
               gar = msg as GiftAssignRequestAction;
               if(gar.characterId == 0 && gar.giftId == this._giftList[0].uid)
               {
                  if(!Berilia.getInstance().getUi("characterSelection"))
                  {
                     this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                  }
               }
               sao = new StartupActionsObjetAttributionMessage();
               sao.initStartupActionsObjetAttributionMessage(gar.giftId,gar.characterId);
               ConnectionsHandler.getConnection().send(sao);
               return true;
            case msg is StartupActionFinishedMessage:
               safm = msg as StartupActionFinishedMessage;
               KernelEventsManager.getInstance().processCallback(HookList.GiftAssigned,safm.actionId);
               if(safm.actionId == this._giftList[0].uid)
               {
                  if(!Berilia.getInstance().getUi("characterSelection"))
                  {
                     this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                  }
               }
               return true;
            case msg is ConsoleCommandsListMessage:
               cclMsg = msg as ConsoleCommandsListMessage;
               cmdIndex = 0;
               while(cmdIndex < cclMsg.aliases.length)
               {
                  cmdIndex++;
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function onEscapePopup() : void {
         Kernel.getInstance().reset();
      }
      
      private function requestCharactersList() : void {
         var _loc1_:CharactersListRequestMessage = new CharactersListRequestMessage();
         if((ConnectionsHandler) && (ConnectionsHandler.getConnection()))
         {
            ConnectionsHandler.getConnection().send(_loc1_);
         }
      }
   }
}
