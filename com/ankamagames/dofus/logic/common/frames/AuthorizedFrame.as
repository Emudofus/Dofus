package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.console.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class AuthorizedFrame extends RegisteringFrame
    {
        private var _hasRights:Boolean;
        private var _isFantomas:Boolean;
        private var _loader:IResourceLoader;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthorizedFrame));

        public function AuthorizedFrame()
        {
            return;
        }// end function

        override public function get priority() : int
        {
            return Priority.LOW;
        }// end function

        override public function pushed() : Boolean
        {
            this.hasRights = false;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.objectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.objectLoadedFailed);
            this._loader.load(new Uri(File.applicationDirectory.nativePath + File.separator + "uplauncher.xml"));
            return true;
        }// end function

        override public function pulled() : Boolean
        {
            return true;
        }// end function

        public function set hasRights(param1:Boolean) : void
        {
            this._hasRights = param1;
            if (param1)
            {
                HyperlinkFactory.registerProtocol("admin", HyperlinkAdminManager.addCmd);
                ConsolesManager.registerConsole("debug", new ConsoleHandler(Kernel.getWorker()), new DebugConsoleInstructionRegistar());
            }
            else
            {
                ConsolesManager.registerConsole("debug", new ConsoleHandler(Kernel.getWorker()), new BasicConsoleInstructionRegistar());
            }
            return;
        }// end function

        public function isFantomas() : Boolean
        {
            return this._isFantomas;
        }// end function

        override protected function registerMessages() : void
        {
            register(ConsoleMessage, this.onConsoleMessage);
            register(AuthorizedCommandAction, this.onAuthorizedCommandAction);
            register(ConsoleOutputMessage, this.onConsoleOutputMessage);
            register(QuitGameAction, this.onQuitGameAction);
            return;
        }// end function

        private function onConsoleMessage(param1:ConsoleMessage) : Boolean
        {
            ConsolesManager.getConsole("debug").output(param1.content);
            return true;
        }// end function

        private function onAuthorizedCommandAction(param1:AuthorizedCommandAction) : Boolean
        {
            var acmsg:AdminCommandMessage;
            var aca:* = param1;
            if (aca.command.substr(0, 1) == "/")
            {
                try
                {
                    ConsolesManager.getConsole("debug").process(ConsolesManager.getMessage(aca.command));
                }
                catch (ucie:UnhandledConsoleInstructionError)
                {
                    ConsolesManager.getConsole("debug").output("Unknown command: " + aca.command + "\n");
                }
            }
            else if (ConnectionsHandler.connectionType != ConnectionType.DISCONNECTED)
            {
                if (this._hasRights)
                {
                    acmsg = new AdminCommandMessage();
                    acmsg.initAdminCommandMessage(aca.command);
                    ConnectionsHandler.getConnection().send(acmsg);
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
        }// end function

        private function onConsoleOutputMessage(param1:ConsoleOutputMessage) : Boolean
        {
            if (param1.consoleId != "debug")
            {
                return false;
            }
            KernelEventsManager.getInstance().processCallback(HookList.ConsoleOutput, param1.text);
            return true;
        }// end function

        private function onQuitGameAction(param1:QuitGameAction) : Boolean
        {
            Dofus.getInstance().quit();
            return true;
        }// end function

        public function objectLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = new XML(event.resource);
            if (_loc_2.Debug.fantomas.contains("1"))
            {
                this._isFantomas = true;
            }
            else
            {
                this._isFantomas = false;
            }
            return;
        }// end function

        public function objectLoadedFailed(event:ResourceErrorEvent) : void
        {
            _log.debug("Uplauncher loading failed : " + event.uri + ", " + event.errorMsg);
            return;
        }// end function

    }
}
