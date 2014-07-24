package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.BindsApi;
   import d2components.TextArea;
   import d2components.Label;
   import d2components.Input;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import flash.utils.Timer;
   import d2hooks.*;
   import d2actions.*;
   import flash.events.TimerEvent;
   import d2data.Server;
   import flash.utils.Dictionary;
   import d2data.Bind;
   import flash.ui.Keyboard;
   import flash.events.Event;
   
   public class ConsoleUi extends Object
   {
      
      public function ConsoleUi() {
         this._paramsRE = new RegExp("\'[a-zA-Z-*]*\'","g");
         super();
      }
      
      private static const SAVE_NAME:String = "consoleOption";
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var bindsApi:BindsApi;
      
      public var contextMod:Object;
      
      private var _maxCmdHistoryIndex:uint = 25;
      
      private var _aHistory:Object;
      
      private var _nHistoryIndex:int = 0;
      
      public var taConsole:TextArea;
      
      public var lblInfo:Label;
      
      public var tiCmd:Input;
      
      public var consoleMainContainer:GraphicContainer;
      
      public var mainContainer:GraphicContainer;
      
      public var redimCtr:GraphicContainer;
      
      public var topBar:GraphicContainer;
      
      public var btnReduce:ButtonContainer;
      
      public var btnExtend:ButtonContainer;
      
      public var btnClose:ButtonContainer;
      
      public var btnResize:ButtonContainer;
      
      public var btnMenu:ButtonContainer;
      
      public var btnClear:ButtonContainer;
      
      public var btnBlock:ButtonContainer;
      
      private var _init:Boolean;
      
      private var _menu:Array;
      
      private var _options:Object;
      
      private var _savePreset:Boolean;
      
      private var _replaceTimer:Timer;
      
      private var _autoCompleteRunning:Boolean;
      
      private var _autoCompleteWithList:Boolean;
      
      private var _autoCompleteWithHistory:Boolean;
      
      private var _inputChanged:Boolean;
      
      private var _autoCompletePossibilities:Array;
      
      private var _autoCompleteIndex:int;
      
      private var _paramsRE:RegExp;
      
      private var _blockScroll:Boolean = false;
      
      public function main(pShowConsole:Boolean) : void {
         this.sysApi.addHook(ConsoleAddCmd,this.onConsoleAddCmd);
         this.sysApi.addHook(ConsoleClear,this.onConsoleClear);
         this.sysApi.addHook(ConsoleOutput,this.onConsoleOutput);
         this.sysApi.addHook(CharacterSelectionStart,this.onCharacterSelectionStart);
         this.sysApi.addHook(KeyboardShortcut,this.onKeyBoardShortcut);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("upArrow",this.onShortcut);
         this.uiApi.addShortcutHook("downArrow",this.onShortcut);
         this.uiApi.addShortcutHook("autoComplete",this.onShortcut);
         this.uiApi.addShortcutHook("historySearch",this.onShortcut);
         this.uiApi.addComponentHook(this.btnReduce,"onRelease");
         this.uiApi.addComponentHook(this.btnExtend,"onRelease");
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnResize,"onRelease");
         this.uiApi.addComponentHook(this.btnMenu,"onRelease");
         this.uiApi.addComponentHook(this.btnClear,"onRelease");
         this.uiApi.addComponentHook(this.consoleMainContainer,"onRelease");
         this.uiApi.addComponentHook(this.redimCtr,"onRelease");
         this.uiApi.addComponentHook(this.btnBlock,"onRelease");
         this.uiApi.addComponentHook(this.topBar,"onPress");
         this.uiApi.addComponentHook(this.topBar,"onDoubleClick");
         this.uiApi.addComponentHook(this.redimCtr,"onPress");
         this.uiApi.addComponentHook(this.tiCmd,"onChange");
         this._autoCompletePossibilities = [];
         this.taConsole.activeSmallHyperlink();
         if(!this._aHistory)
         {
            this.init();
         }
         this._options = this.sysApi.getData(SAVE_NAME,true);
         if(!this._options)
         {
            this._savePreset = true;
            this._autoCompleteWithList = true;
            this._autoCompleteWithHistory = true;
         }
         else
         {
            this._savePreset = this._options.savePreset;
            this._autoCompleteWithList = this._options.hasOwnProperty("autoCompleteWithList")?this._options.autoCompleteWithList:true;
            this._autoCompleteWithHistory = this._options.hasOwnProperty("autoCompleteWithHistory")?this._options.autoCompleteWithHistory:true;
         }
         if((!this._options) || (!this._savePreset))
         {
            this._options = 
               {
                  "opacity":66,
                  "x":100,
                  "y":100,
                  "width":1024,
                  "height":500,
                  "openConsole":false,
                  "savePreset":this._savePreset
               };
         }
         this.mainContainer.visible = false;
         this._replaceTimer = new Timer(100);
         this._replaceTimer.addEventListener(TimerEvent.TIMER,this.onReplaceTimer);
         this._replaceTimer.start();
         this.updateInfo();
         this.onAlphaChange(this._options.opacity);
         if(pShowConsole)
         {
            this.setFocus();
         }
      }
      
      public function replaceComponent() : void {
         var marge:uint = 2;
         if(!this._init)
         {
            this.mainContainer.x = this._options.x;
            this.mainContainer.y = this._options.y;
            this.consoleMainContainer.width = this._options.width;
            this.consoleMainContainer.height = this._options.height;
            this._init = true;
         }
         this.topBar.width = this.consoleMainContainer.width;
         this.topBar.height = 20;
         this.btnMenu.x = marge;
         this.btnMenu.y = marge;
         this.btnClose.x = this.consoleMainContainer.width - marge - this.btnClose.width;
         this.btnClose.y = marge;
         this.btnExtend.x = this.btnClose.x - marge - this.btnExtend.width;
         this.btnExtend.y = marge;
         this.btnReduce.x = this.btnExtend.x - marge - this.btnReduce.width;
         this.btnReduce.y = marge;
         this.btnClear.x = this.btnReduce.x - marge - this.btnClear.width;
         this.btnClear.y = marge;
         this.btnBlock.x = this.btnClear.x - marge - this.btnBlock.width;
         this.btnBlock.y = marge;
         this.lblInfo.x = this.btnMenu.x + this.btnMenu.width + marge;
         this.lblInfo.height = 20;
         this.lblInfo.width = this.btnClear.x - this.lblInfo.x;
         this.tiCmd.x = marge;
         this.tiCmd.height = 25;
         this.tiCmd.y = this.consoleMainContainer.height - this.tiCmd.height - marge;
         this.tiCmd.width = this.consoleMainContainer.width - 2 * this.tiCmd.x;
         this.taConsole.x = marge;
         this.taConsole.y = 25;
         this.taConsole.width = this.consoleMainContainer.width - 2 * this.taConsole.x;
         this.taConsole.height = this.tiCmd.y - this.taConsole.y - marge;
         this.redimCtr.x = this.consoleMainContainer.x;
         this.redimCtr.y = this.consoleMainContainer.y;
         this.redimCtr.width = this.consoleMainContainer.width + 4;
         this.redimCtr.height = this.consoleMainContainer.height + 4;
         this.uiApi.me().render();
      }
      
      public function setFocus() : void {
         this.tiCmd.focus();
      }
      
      public function addCmd(cmd:String, send:Boolean, focusOn:Boolean) : void {
         if(send)
         {
            this.executeCmd(cmd);
         }
         else
         {
            this.tiCmd.text = cmd;
         }
         if(focusOn)
         {
            this.setFocus();
         }
      }
      
      public function updateInfo() : void {
         var playerInfo:Object = null;
         var info:String = "";
         var serverInfo:Server = this.sysApi.getCurrentServer();
         if(serverInfo)
         {
            info = serverInfo.name + " (" + serverInfo.id + ")";
         }
         if(this.playerApi)
         {
            playerInfo = this.playerApi.getPlayedCharacterInfo();
            if(playerInfo)
            {
               info = info + (", " + playerInfo.name + " (" + playerInfo.id + ")");
            }
         }
         if(!info.length)
         {
            info = "Connection server\'s";
         }
         this.lblInfo.text = info;
      }
      
      private function init() : void {
         this._aHistory = this.sysApi.getData("CommandsHistory");
         if(!this._aHistory)
         {
            this._aHistory = new Array();
         }
         this._nHistoryIndex = this._aHistory.length;
      }
      
      private function validCmd() : Boolean {
         if(!this.tiCmd.haveFocus)
         {
            return false;
         }
         var cmd:String = this.tiCmd.text;
         if(cmd.length == 0)
         {
            return true;
         }
         var cmdechap:String = cmd;
         while(cmdechap.indexOf("<") != -1)
         {
            cmdechap = cmdechap.replace("<","&lt;");
         }
         while(cmdechap.indexOf(">") != -1)
         {
            cmdechap = cmdechap.replace(">","&gt;");
         }
         this.output(" > " + cmdechap + "\n");
         this.tiCmd.text = "";
         this.executeCmd(cmd);
         return true;
      }
      
      private function executeCmd(input:String) : void {
         if(!this._aHistory)
         {
            this.init();
         }
         if((!this._aHistory.length) || (!(input == this._aHistory[this._aHistory.length - 1])))
         {
            this._aHistory.push(input);
            if(this._aHistory.length > this._maxCmdHistoryIndex)
            {
               this._aHistory = this._aHistory.slice(this._aHistory.length - this._maxCmdHistoryIndex,this._aHistory.length);
            }
            this._nHistoryIndex = this._aHistory.length;
            this.sysApi.setData("CommandsHistory",this._aHistory);
         }
         else
         {
            this._nHistoryIndex = this._aHistory.length;
         }
         this.sysApi.sendAction(new AuthorizedCommand(input));
         this.setFocus();
      }
      
      private function output(text:String, type:uint = 0) : void {
         var alphaMode:String = !(this._options.opacity == 100)?"alpha":"";
         this.taConsole.appendText(text,type == 0?"p" + alphaMode:type == 1?"pinfo" + alphaMode:type == 2?"perror" + alphaMode:"p" + alphaMode);
         if(!this._blockScroll)
         {
            this.taConsole.scrollV = this.taConsole.maxScrollV;
         }
         this.tiCmd.focus();
      }
      
      private function endResize() : void {
         this.consoleMainContainer.visible = true;
         this.consoleMainContainer.width = this.redimCtr.width - 4;
         this.consoleMainContainer.height = this.redimCtr.height - 4;
         this.redimCtr.endResize();
         this.savePreset();
         this.replaceComponent();
      }
      
      private function savePreset() : void {
         this._options.x = this.mainContainer.x;
         this._options.x = this.mainContainer.x;
         this._options.width = this.consoleMainContainer.width;
         this._options.height = this.consoleMainContainer.height;
         this.sysApi.setData("consoleOption",this._options,true);
      }
      
      private function trimWhitespace(str:String) : String {
         if(str == null)
         {
            return "";
         }
         return str.replace(new RegExp("^\\s+|\\s+$","g"),"");
      }
      
      private function getParamsAutoCompleteFromHelp(pCmd:String, pServerCmd:Boolean) : Array {
         var helpParams:String = null;
         var p:String = null;
         var possibility:String = null;
         var cmdSplit:Array = pCmd.split(" ");
         var cmdParams:String = pCmd.substring(pCmd.lastIndexOf(" ") + 1);
         var help:String = this.sysApi.getCmdHelp(cmdSplit[0],pServerCmd);
         if(help.indexOf("Unknown command") != -1)
         {
            return null;
         }
         var helpSplit:Array = help.split(" ");
         var paramPos:int = cmdSplit.length - 1;
         if(paramPos <= helpSplit.length - 1)
         {
            helpParams = helpSplit[paramPos];
         }
         var params:Array = helpParams.match(this._paramsRE);
         var paramsAutoComplete:Array = [];
         var cmdStart:String = pCmd.substring(0,pCmd.lastIndexOf(" "));
         for each(p in params)
         {
            possibility = cmdStart + " " + p.replace(new RegExp("\\\'","g"),"");
            if(possibility.indexOf(pCmd) != -1)
            {
               paramsAutoComplete.push(possibility);
            }
         }
         return paramsAutoComplete;
      }
      
      private function autoComplete(onlyHistory:Boolean = false, isDeleting:Boolean = false) : void {
         var boldLength:* = 0;
         var serverCmd:* = false;
         var possibilities:Object = null;
         var help:String = null;
         var historyContextMenu:Array = null;
         var historyPossibilities:Array = null;
         var contextMenu:Array = null;
         var cmdPos:uint = 0;
         var sNewCmd:String = null;
         var splittedLine:Array = null;
         var currentCommand:String = null;
         var currentParams:Array = null;
         var entry:String = null;
         var cmd2:String = null;
         var boldStart:* = NaN;
         var cmd3:String = null;
         var paramsAutoComplete:Array = null;
         var p:String = null;
         var paramPossibility:String = null;
         var possibility:String = null;
         var sStartCmd:String = this.tiCmd.text;
         var possibilitiesCount:uint = 0;
         serverCmd = sStartCmd.length > 0?sStartCmd.charAt(0) == "/"?false:true:false;
         if(((this._autoCompleteWithList) || (!this._autoCompleteWithList) && (this._inputChanged)) && (!(sStartCmd.length == 0)) && (!onlyHistory))
         {
            if(!serverCmd)
            {
               sStartCmd = sStartCmd.substr(1);
            }
            if(sStartCmd.length == 0)
            {
               return;
            }
            cmdPos = sStartCmd.substr(0,this.tiCmd.caretIndex).split(" ").length - 1;
            if(cmdPos == 0)
            {
               possibilities = this.sysApi.getAutoCompletePossibilities(sStartCmd,serverCmd);
            }
            else
            {
               splittedLine = sStartCmd.split(" ");
               currentCommand = splittedLine[0];
               splittedLine.splice(0,1);
               currentParams = splittedLine;
               possibilities = this.sysApi.getAutoCompletePossibilitiesOnParam(currentCommand,serverCmd,cmdPos - 1,currentParams);
            }
            possibilitiesCount = possibilities.length;
            sNewCmd = this.sysApi.getConsoleAutoCompletion(sStartCmd,serverCmd);
         }
         var needle:String = this.tiCmd.text;
         var done:Dictionary = new Dictionary();
         if((this._autoCompleteWithHistory) && ((this._autoCompleteWithList) || (!this._autoCompleteWithList) && (this._inputChanged)))
         {
            historyPossibilities = [];
            for each(entry in this._aHistory)
            {
               entry = this.trimWhitespace(entry);
               if((!done[entry.toLowerCase()]) && (!(entry.toLowerCase().indexOf(needle) == -1)))
               {
                  historyPossibilities.push(entry);
                  done[entry.toLowerCase()] = true;
               }
            }
         }
         if((this._autoCompleteWithList) && (historyPossibilities) && (historyPossibilities.length))
         {
            historyContextMenu = [];
            historyContextMenu.push(this.contextMod.createContextMenuTitleObject("History"));
            for each(cmd2 in historyPossibilities)
            {
               boldStart = cmd2.toLowerCase().indexOf(needle);
               boldLength = needle.length;
               historyContextMenu.push(this.contextMod.createContextMenuItemObject(cmd2.substr(0,boldStart) + "<b>" + cmd2.substr(boldStart,boldLength) + "</b>" + cmd2.substr(boldStart + boldLength),this.onPossibilityChoice,[cmd2,true,false],false,null,false,true));
            }
            if((possibilitiesCount == 0) && (historyPossibilities.length == 1))
            {
               sNewCmd = cmd2;
               serverCmd = true;
            }
            possibilitiesCount = possibilitiesCount + historyPossibilities.length;
         }
         if(this._autoCompleteWithList)
         {
            contextMenu = [];
            if(possibilitiesCount == 1)
            {
               if(!isDeleting)
               {
                  this.tiCmd.text = (serverCmd?"":"/") + sNewCmd;
               }
               this.tiCmd.setSelection(this.tiCmd.length,this.tiCmd.length);
               this._autoCompleteRunning = false;
               this.contextMod.closeAllMenu();
            }
            else if((possibilities) && (possibilities.length > 1))
            {
               contextMenu.push(this.contextMod.createContextMenuTitleObject(serverCmd?"Server commands":"Client commands"));
               boldLength = this.getBoldLength(sStartCmd,sNewCmd) + (serverCmd?0:1);
               for each(cmd3 in possibilities)
               {
                  help = this.sysApi.getCmdHelp(cmd3,serverCmd);
                  if(help)
                  {
                     help = help.split("[").join("&#91;");
                  }
                  contextMenu.push(this.contextMod.createContextMenuItemObject((serverCmd?"":"/") + "<b>" + cmd3.substr(0,boldLength) + "</b>" + cmd3.substr(boldLength),this.onPossibilityChoice,[cmd3,serverCmd,!(cmdPos == 0)],false,null,false,true,help));
               }
            }
            
            if(historyContextMenu)
            {
               contextMenu = contextMenu.concat(historyContextMenu);
            }
            if(contextMenu.length)
            {
               this.contextMod.createContextMenu(contextMenu,
                  {
                     "x":this.mainContainer.x,
                     "y":this.mainContainer.y + this.mainContainer.height
                  },this.onContextMenuClose);
               this._autoCompleteRunning = true;
            }
            else
            {
               this.contextMod.closeAllMenu();
            }
         }
         if((!this._autoCompleteWithList) && (!isDeleting) && (sStartCmd.length > 0))
         {
            if(this._inputChanged)
            {
               this._autoCompleteIndex = 0;
               this._inputChanged = false;
               this._autoCompletePossibilities = [];
               if((possibilities) && (possibilities.length > 0))
               {
                  if(cmdPos != 0)
                  {
                     paramsAutoComplete = [];
                     for each(p in possibilities)
                     {
                        paramPossibility = sStartCmd.substring(0,sStartCmd.lastIndexOf(" ")) + " " + p;
                        if(paramPossibility.indexOf(sStartCmd) != -1)
                        {
                           paramsAutoComplete.push(paramPossibility);
                        }
                     }
                     if(paramsAutoComplete.length > 0)
                     {
                        this._autoCompletePossibilities = this._autoCompletePossibilities.concat(paramsAutoComplete);
                     }
                  }
                  else
                  {
                     this._autoCompletePossibilities = this._autoCompletePossibilities.concat(possibilities);
                  }
               }
               else if(sStartCmd.indexOf(" ") != -1)
               {
                  paramsAutoComplete = this.getParamsAutoCompleteFromHelp(sStartCmd,serverCmd);
                  if(paramsAutoComplete)
                  {
                     this._autoCompletePossibilities = this._autoCompletePossibilities.concat(paramsAutoComplete);
                  }
               }
               
               if((historyPossibilities) && (historyPossibilities.length > 0))
               {
                  this._autoCompletePossibilities = this._autoCompletePossibilities.concat(historyPossibilities);
               }
            }
            else if(this._autoCompleteIndex < this._autoCompletePossibilities.length - 1)
            {
               this._autoCompleteIndex++;
            }
            else
            {
               this._autoCompleteIndex = 0;
            }
            
            if(this._autoCompletePossibilities.length > 0)
            {
               possibility = this._autoCompletePossibilities[this._autoCompleteIndex];
               if(possibility.charAt(0) == "/")
               {
                  possibility = possibility.substr(1);
               }
               this.tiCmd.text = (!serverCmd?"/":"") + possibility;
               this.tiCmd.caretIndex = this.tiCmd.text.length;
            }
         }
      }
      
      private function onConsoleOutput(msg:String, type:uint) : void {
         if(this._options.openConsole)
         {
            Console.getInstance().showConsole(true);
         }
         this.output(msg + "\n",type);
      }
      
      private function onKeyBoardShortcut(b:Bind, keycode:uint) : void {
         var registeredBind:Bind = this.bindsApi.getRegisteredBind(b);
         if((!this._autoCompleteWithList) && ((!registeredBind) || (!(registeredBind.targetedShortcut == "autoComplete"))))
         {
            this._inputChanged = true;
            this._autoCompleteRunning = false;
         }
      }
      
      private function onKeyUp(pTarget:Object, pKeyCode:uint) : void {
         if((!this._autoCompleteWithList) && (pKeyCode == Keyboard.BACKSPACE))
         {
            this._inputChanged = true;
            this._autoCompleteRunning = false;
         }
      }
      
      private function onShortcut(s:String) : Boolean {
         if(!this.uiApi.me().visible)
         {
            return false;
         }
         switch(s)
         {
            case "validUi":
               return this.validCmd();
            case "upArrow":
            case "downArrow":
               if(!this.tiCmd.haveFocus)
               {
                  return true;
               }
               if(!this._aHistory.length)
               {
                  return true;
               }
               if((s == "upArrow") && (this._nHistoryIndex >= 0))
               {
                  this._nHistoryIndex--;
               }
               if((s == "downArrow") && (this._nHistoryIndex < this._aHistory.length))
               {
                  this._nHistoryIndex++;
               }
               if(this._aHistory[this._nHistoryIndex] != null)
               {
                  this.tiCmd.text = this._aHistory[this._nHistoryIndex];
               }
               else
               {
                  this.tiCmd.text = "";
               }
               this.tiCmd.setSelection(this.tiCmd.length,this.tiCmd.length);
               return true;
            case "autoComplete":
               this.tiCmd.focus();
               this.autoComplete();
               return true;
            case "historySearch":
               this.tiCmd.focus();
               this.autoComplete();
               return true;
            default:
               return false;
         }
      }
      
      private function onPossibilityChoice(cmd:String, isServerCommand:Boolean, justAdd:Boolean = false) : void {
         var text:String = null;
         var i:* = 0;
         if(justAdd)
         {
            text = this.tiCmd.text;
            i = this.tiCmd.caretIndex;
            while(i >= 0)
            {
               if(text.charAt(i) == " ")
               {
                  this.tiCmd.text = text.substr(0,i + 1) + cmd;
                  break;
               }
               i--;
            }
         }
         else
         {
            this.tiCmd.text = (isServerCommand?"":"/") + cmd + " ";
         }
         this.tiCmd.caretIndex = this.tiCmd.text.length;
      }
      
      public function onPress(target:Object) : void {
         switch(target)
         {
            case this.redimCtr:
               this.consoleMainContainer.visible = false;
               this.redimCtr.startResize();
               break;
            case this.topBar:
               this.mainContainer.startDrag();
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         var alphaMenu:Array = null;
         var openConsoleMenu:Array = null;
         var autoCompleteMenu:Array = null;
         switch(target)
         {
            case this.btnClose:
               Console.getInstance().showConsole(false);
               break;
            case this.redimCtr:
               this.endResize();
               break;
            case this.btnExtend:
               this.mainContainer.x = 100;
               this.mainContainer.y = 100;
               this.consoleMainContainer.width = 1100;
               this.consoleMainContainer.height = 500;
               this.replaceComponent();
               this.mainContainer.stopDrag();
               break;
            case this.btnReduce:
               if(this.consoleMainContainer.height > 200)
               {
                  this.consoleMainContainer.height = this.consoleMainContainer.height - 200;
               }
               else
               {
                  this.consoleMainContainer.height = 500;
               }
               this.replaceComponent();
               break;
            case this.btnClear:
               this.taConsole.text = "";
               break;
            case this.btnMenu:
               this._menu = [];
               alphaMenu = [];
               openConsoleMenu = [];
               autoCompleteMenu = [];
               this._menu.push(this.contextMod.createContextMenuItemObject("Opacity",null,null,false,alphaMenu));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("33%",this.onAlphaChange,[33],false,null,this._options.opacity == 33));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("66%",this.onAlphaChange,[66],false,null,this._options.opacity == 66));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("100%",this.onAlphaChange,[100],false,null,this._options.opacity == 100));
               this._menu.push(this.contextMod.createContextMenuItemObject("Open console",null,null,false,openConsoleMenu));
               openConsoleMenu.push(this.contextMod.createContextMenuItemObject("Manual",this.onOpenConsoleChange,[false],false,null,!this._options.openConsole));
               openConsoleMenu.push(this.contextMod.createContextMenuItemObject("When receive message",this.onOpenConsoleChange,[true],false,null,this._options.openConsole));
               this.onAlphaChange(this._options.opacity);
               this._menu.push(this.contextMod.createContextMenuItemObject("Autocomplete mode",null,null,false,autoCompleteMenu));
               autoCompleteMenu.push(this.contextMod.createContextMenuItemObject("Show list",this.onChangeAutocomplete,[true],false,null,this._autoCompleteWithList));
               autoCompleteMenu.push(this.contextMod.createContextMenuItemObject("Command line",this.onChangeAutocomplete,[false],false,null,!this._autoCompleteWithList));
               this._menu.push(this.contextMod.createContextMenuItemObject("Autocomplete with history",this.onChangeAutocompleteWithHistory,null,false,null,this._autoCompleteWithHistory));
               this._menu.push(this.contextMod.createContextMenuItemObject("Save preset",this.onSavePreset,null,false,null,this._savePreset));
               this.contextMod.createContextMenu(this._menu);
               break;
            case this.btnBlock:
               this._blockScroll = !this._blockScroll;
               this.btnBlock.selected = this._blockScroll;
               break;
            default:
               this.mainContainer.stopDrag();
               this.savePreset();
         }
      }
      
      public function onReleaseOutside(target:Object) : void {
         switch(target)
         {
            case this.redimCtr:
               this.endResize();
               break;
            default:
               this.mainContainer.stopDrag();
               this.savePreset();
         }
      }
      
      public function onDoubleClick(target:Object) : void {
         this.onRelease(this.btnExtend);
      }
      
      private function onAlphaChange(alpha:uint) : void {
         this.consoleMainContainer.bgAlpha = alpha / 100;
         this._options.opacity = alpha;
         this.sysApi.setData("consoleOption",this._options,true);
      }
      
      private function onOpenConsoleChange(show:Boolean) : void {
         this._options.openConsole = show;
         this.sysApi.setData("consoleOption",this._options,true);
      }
      
      private function onSavePreset() : void {
         this._savePreset = !this._savePreset;
         this._options.savePreset = this._savePreset;
         this.sysApi.setData("consoleOption",this._options,true);
      }
      
      private function onChangeAutocomplete(pAutoCompleteWithList:Boolean) : void {
         this._autoCompleteWithList = pAutoCompleteWithList;
         this._options.autoCompleteWithList = this._autoCompleteWithList;
         this.sysApi.setData("consoleOption",this._options,true);
         if((this._autoCompleteWithList) && (this._autoCompletePossibilities))
         {
            this._autoCompletePossibilities.length = 0;
         }
         this._autoCompleteRunning = false;
      }
      
      private function onChangeAutocompleteWithHistory() : void {
         this._autoCompleteWithHistory = !this._autoCompleteWithHistory;
         this._options.autoCompleteWithHistory = this._autoCompleteWithHistory;
         this.sysApi.setData("consoleOption",this._options,true);
      }
      
      private function onReplaceTimer(e:Event) : void {
         this.mainContainer.visible = true;
         this.replaceComponent();
         this._replaceTimer.removeEventListener(TimerEvent.TIMER,this.onReplaceTimer);
      }
      
      private function onCharacterSelectionStart(... args) : void {
         this.updateInfo();
      }
      
      private function onConsoleClear() : void {
         this.taConsole.text = "";
      }
      
      private function onContextMenuClose() : void {
         if(this._lastInput != this.tiCmd.text)
         {
            this._autoCompleteRunning = false;
         }
      }
      
      private var _lastInput:String;
      
      public function onChange(target:Object) : void {
         var isDeleting:Boolean = false;
         if((this._lastInput) && (this.tiCmd.text))
         {
            isDeleting = this._lastInput.length > this.tiCmd.text.length;
         }
         if((this._autoCompleteRunning) && (this.tiCmd.haveFocus) && (!(this._lastInput == this.tiCmd.text)))
         {
            this.autoComplete(false,isDeleting);
         }
         this._lastInput = this.tiCmd.text;
      }
      
      private function onConsoleAddCmd(autoExec:Boolean, cmd:String) : void {
         this.addCmd(cmd,autoExec,false);
      }
      
      private function getBoldLength(cmd1:String, cmd2:String) : int {
         if((cmd1 == null) || (cmd2 == null))
         {
            return 0;
         }
         var splittedCmd1:Array = cmd1.split(" ");
         var splittedCmd2:Array = cmd2.split(" ");
         var lastArgSizeCmd1:int = String(splittedCmd1.pop()).length;
         var lastArgSizeCmd2:int = String(splittedCmd2.pop()).length;
         return lastArgSizeCmd1 < lastArgSizeCmd2?lastArgSizeCmd1:lastArgSizeCmd2;
      }
   }
}
