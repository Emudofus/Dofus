package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.messages.security.CheckIntegrityMessage;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.File;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkAdminManager;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.console.DebugConsoleInstructionRegistar;
   import com.ankamagames.dofus.console.BasicConsoleInstructionRegistar;
   import com.ankamagames.dofus.network.messages.authorized.ConsoleMessage;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.jerakine.console.ConsoleOutputMessage;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.network.messages.authorized.AdminCommandMessage;
   import com.ankamagames.jerakine.console.UnhandledConsoleInstructionError;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   
   public class AuthorizedFrame extends RegisteringFrame
   {
      
      public function AuthorizedFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthorizedFrame));
      
      private var _hasRights:Boolean;
      
      private var _isFantomas:Boolean;
      
      private var _include_CheckIntegrityMessage:CheckIntegrityMessage = null;
      
      private var _loader:IResourceLoader;
      
      override public function get priority() : int
      {
         return Priority.LOW;
      }
      
      override public function pushed() : Boolean
      {
         this.hasRights = false;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.objectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
         this._loader.load(new Uri(File.applicationDirectory.nativePath + File.separator + "uplauncher.xml"));
         return true;
      }
      
      override public function pulled() : Boolean
      {
         return true;
      }
      
      public function set hasRights(param1:Boolean) : void
      {
         this._hasRights = param1;
         if(param1)
         {
            HyperlinkFactory.registerProtocol("admin",HyperlinkAdminManager.addCmd);
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new DebugConsoleInstructionRegistar());
         }
         else
         {
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new BasicConsoleInstructionRegistar());
         }
      }
      
      public function isFantomas() : Boolean
      {
         return this._isFantomas;
      }
      
      override protected function registerMessages() : void
      {
         register(ConsoleMessage,this.onConsoleMessage);
         register(AuthorizedCommandAction,this.onAuthorizedCommandAction);
         register(ConsoleOutputMessage,this.onConsoleOutputMessage);
         register(QuitGameAction,this.onQuitGameAction);
      }
      
      private function onConsoleMessage(param1:ConsoleMessage) : Boolean
      {
         ConsolesManager.getConsole("debug").output(param1.content,param1.type);
         return true;
      }
      
      private function onAuthorizedCommandAction(param1:AuthorizedCommandAction) : Boolean
      {
         var acmsg:AdminCommandMessage = null;
         var aca:AuthorizedCommandAction = param1;
         if(aca.command.substr(0,1) == "/")
         {
            try
            {
               ConsolesManager.getConsole("debug").process(ConsolesManager.getMessage(aca.command));
            }
            catch(ucie:UnhandledConsoleInstructionError)
            {
               ConsolesManager.getConsole("debug").output("Unknown command: " + aca.command + "\n");
            }
         }
         else if(ConnectionsHandler.connectionType != ConnectionType.DISCONNECTED)
         {
            if(this._hasRights)
            {
               if(aca.command.length >= 1 && aca.command.length <= ProtocolConstantsEnum.MAX_CHAT_LEN)
               {
                  acmsg = new AdminCommandMessage();
                  acmsg.initAdminCommandMessage(aca.command);
                  ConnectionsHandler.getConnection().send(acmsg);
               }
               else
               {
                  ConsolesManager.getConsole("debug").output("Too long command is too long, try again.");
               }
            }
            else
            {
               ConsolesManager.getConsole("debug").output("You have no admin rights, please use only client side commands. (/help)");
            }
         }
         else
         {
            ConsolesManager.getConsole("debug").output("You are disconnected, use only client side commands.");
         }
         
         return true;
      }
      
      private function onConsoleOutputMessage(param1:ConsoleOutputMessage) : Boolean
      {
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         if(param1.consoleId != "debug")
         {
            return false;
         }
         var _loc2_:Dictionary = this.getValidClass();
         var _loc3_:String = param1.text;
         var _loc4_:RegExp = new RegExp("@client\\((\\w*)\\.(\\d*)\\.(\\w*)\\)","gm");
         var _loc5_:* = true;
         var _loc6_:uint = 0;
         while((_loc5_) && _loc6_++ < 100)
         {
            _loc7_ = _loc3_.match(_loc4_);
            _loc5_ = !(_loc7_.length == 0);
            for each(_loc8_ in _loc7_)
            {
               _loc9_ = null;
               _loc10_ = _loc8_.substring(8,_loc8_.length - 1).split(".");
               _loc11_ = _loc2_[_loc10_[0].toLowerCase()];
               if(_loc11_ != null)
               {
                  _loc12_ = getDefinitionByName(_loc11_);
                  _loc13_ = this.getIdFunction(_loc11_);
                  if(_loc13_ != null)
                  {
                     _loc14_ = _loc12_[_loc13_](parseInt(_loc10_[1]));
                     if(_loc14_ != null)
                     {
                        if(_loc14_.hasOwnProperty(_loc10_[2]))
                        {
                           _loc9_ = _loc14_[_loc10_[2]];
                        }
                        else
                        {
                           _loc9_ = _loc8_.substr(0,_loc8_.length - 1) + ".bad field)";
                        }
                     }
                     else
                     {
                        _loc9_ = _loc8_.substr(0,_loc8_.length - 1) + ".bad ID)";
                     }
                  }
                  else
                  {
                     _loc9_ = _loc8_.substr(0,_loc8_.length - 1) + ".not compatible class)";
                  }
               }
               else
               {
                  _loc9_ = _loc8_.substr(0,_loc8_.length - 1) + ".bad class)";
               }
               _loc3_ = _loc3_.split(_loc8_).join(_loc9_);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConsoleOutput,_loc3_,param1.type);
         return true;
      }
      
      private function getValidClass() : Dictionary
      {
         var _loc3_:XML = null;
         var _loc4_:Array = null;
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:XML = DescribeTypeCache.typeDescription(GameDataList);
         for each(_loc3_ in _loc2_..constant)
         {
            _loc4_ = this.getSimpleVariablesAndAccessors(String(_loc3_.@type));
            if(_loc4_.indexOf("id") != -1)
            {
               _loc1_[String(_loc3_.@name).toLowerCase()] = String(_loc3_.@type);
            }
         }
         return _loc1_;
      }
      
      private function getSimpleVariablesAndAccessors(param1:String, param2:Boolean = false) : Array
      {
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc3_:Array = new Array();
         var _loc4_:XML = DescribeTypeCache.typeDescription(getDefinitionByName(param1));
         for each(_loc6_ in _loc4_..variable)
         {
            _loc5_ = String(_loc6_.@type);
            if(_loc5_ == "int" || _loc5_ == "uint" || _loc5_ == "Number" || _loc5_ == "String")
            {
               _loc3_.push(String(_loc6_.@name));
            }
            if(param2)
            {
               if(!(_loc5_.indexOf("Vector.<int>") == -1) || !(_loc5_.indexOf("Vector.<uint>") == -1) || !(_loc5_.indexOf("Vector.<Number>") == -1) || !(_loc5_.indexOf("Vector.<String>") == -1))
               {
                  if(_loc5_.split("Vector").length == 2)
                  {
                     _loc3_.push(String(_loc6_.@name));
                  }
               }
            }
         }
         for each(_loc6_ in _loc4_..accessor)
         {
            _loc5_ = String(_loc6_.@type);
            if(_loc5_ == "int" || _loc5_ == "uint" || _loc5_ == "Number" || _loc5_ == "String")
            {
               _loc3_.push(String(_loc6_.@name));
            }
            if(param2)
            {
               if(!(_loc5_.indexOf("Vector.<int>") == -1) || !(_loc5_.indexOf("Vector.<uint>") == -1) || !(_loc5_.indexOf("Vector.<Number>") == -1) || !(_loc5_.indexOf("Vector.<String>") == -1))
               {
                  if(_loc5_.split("Vector").length == 2)
                  {
                     _loc3_.push(String(_loc6_.@name));
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function getIdFunction(param1:String) : String
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc2_:XML = DescribeTypeCache.typeDescription(getDefinitionByName(param1));
         for each(_loc3_ in _loc2_..method)
         {
            if(_loc3_.@returnType == param1 && (XMLList(_loc3_.parameter).length() == 1 || XMLList(_loc3_.parameter).length() == 2))
            {
               _loc4_ = String(XMLList(_loc3_.parameter)[0].@type);
               if(_loc4_ == "int" || _loc4_ == "uint")
               {
                  if(String(_loc3_.@name).indexOf("ById") != -1)
                  {
                     return String(_loc3_.@name);
                  }
               }
            }
         }
         return null;
      }
      
      private function onQuitGameAction(param1:QuitGameAction) : Boolean
      {
         Dofus.getInstance().quit();
         return true;
      }
      
      public function objectLoaded(param1:ResourceLoadedEvent) : void
      {
         var _loc2_:XML = new XML(param1.resource);
         if(_loc2_.Debug.fantomas.contains("1"))
         {
            this._isFantomas = true;
         }
         else
         {
            this._isFantomas = false;
         }
      }
      
      public function objectLoadedFailed(param1:ResourceErrorEvent) : void
      {
         _log.debug("Uplauncher loading failed : " + param1.uri + ", " + param1.errorMsg);
      }
   }
}
