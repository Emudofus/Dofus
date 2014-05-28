package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class AuthorizedFrame extends RegisteringFrame
   {
      
      public function AuthorizedFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      private var _hasRights:Boolean;
      
      private var _isFantomas:Boolean;
      
      private var _loader:IResourceLoader;
      
      override public function get priority() : int {
         return Priority.LOW;
      }
      
      override public function pushed() : Boolean {
         this.hasRights = false;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.objectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
         this._loader.load(new Uri(File.applicationDirectory.nativePath + File.separator + "uplauncher.xml"));
         return true;
      }
      
      override public function pulled() : Boolean {
         return true;
      }
      
      public function set hasRights(b:Boolean) : void {
         this._hasRights = b;
         if(b)
         {
            HyperlinkFactory.registerProtocol("admin",HyperlinkAdminManager.addCmd);
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new DebugConsoleInstructionRegistar());
         }
         else
         {
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new BasicConsoleInstructionRegistar());
         }
      }
      
      public function isFantomas() : Boolean {
         return this._isFantomas;
      }
      
      override protected function registerMessages() : void {
         register(ConsoleMessage,this.onConsoleMessage);
         register(AuthorizedCommandAction,this.onAuthorizedCommandAction);
         register(ConsoleOutputMessage,this.onConsoleOutputMessage);
         register(QuitGameAction,this.onQuitGameAction);
      }
      
      private function onConsoleMessage(cmsg:ConsoleMessage) : Boolean {
         ConsolesManager.getConsole("debug").output(cmsg.content,cmsg.type);
         return true;
      }
      
      private function onAuthorizedCommandAction(aca:AuthorizedCommandAction) : Boolean {
         var acmsg:AdminCommandMessage = null;
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
               if((aca.command.length >= 1) && (aca.command.length <= ProtocolConstantsEnum.MAX_CHAT_LEN))
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
      
      private function onConsoleOutputMessage(comsg:ConsoleOutputMessage) : Boolean {
         if(comsg.consoleId != "debug")
         {
            return false;
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConsoleOutput,comsg.text,comsg.type);
         return true;
      }
      
      private function onQuitGameAction(qga:QuitGameAction) : Boolean {
         Dofus.getInstance().quit();
         return true;
      }
      
      public function objectLoaded(e:ResourceLoadedEvent) : void {
         var uplauncher:XML = new XML(e.resource);
         if(uplauncher.Debug.fantomas.contains("1"))
         {
            this._isFantomas = true;
         }
         else
         {
            this._isFantomas = false;
         }
      }
      
      public function objectLoadedFailed(e:ResourceErrorEvent) : void {
         _log.debug("Uplauncher loading failed : " + e.uri + ", " + e.errorMsg);
      }
   }
}
