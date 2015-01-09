package 
{
    import flash.display.Sprite;
    import ui.ConsoleUi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2hooks.ToggleConsole;
    import d2enums.StrataEnum;
    import d2hooks.UiLoaded;
    import d2hooks.*;

    public class Console extends Sprite 
    {

        private static var _self:Console;

        protected var console:ConsoleUi = null;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        private var _consoleState:Boolean;
        private var _waitingCmd:Array;

        public function Console()
        {
            this._waitingCmd = [];
            super();
        }

        public static function getInstance():Console
        {
            return (_self);
        }


        public function main():void
        {
            _self = this;
            this.uiApi.addShortcutHook("toggleConsole", this.onConsoleToggle);
            this.sysApi.addHook(ToggleConsole, this.onHookConsoleToggle);
        }

        public function showConsole(show:Boolean):void
        {
            var console:Object = this.uiApi.getUi("console");
            if (console)
            {
                this._consoleState = (console.visible = show);
                if (show)
                {
                    ConsoleUi(console.uiClass).updateInfo();
                    ConsoleUi(console.uiClass).replaceComponent();
                    this.uiApi.getUi("console").uiClass.setFocus();
                };
            }
            else
            {
                this.uiApi.loadUi("console", "console", [show], StrataEnum.STRATA_TOP);
                this._consoleState = show;
            };
        }

        public function addCommande(cmd:String, send:Boolean, openConsole:Boolean):void
        {
            var console:Object = this.uiApi.getUi("console");
            if (console)
            {
                if (openConsole)
                {
                    this.showConsole(true);
                };
                ConsoleUi(console.uiClass).addCmd(cmd, send, openConsole);
            }
            else
            {
                this._waitingCmd.push({
                    "cmd":cmd,
                    "send":send,
                    "openConsole":openConsole
                });
                this.sysApi.addHook(UiLoaded, this.onUiLoaded);
                this.showConsole(false);
            };
        }

        private function onAuthentificationStart():void
        {
            this.showConsole(false);
        }

        private function onConsoleToggle(shortcut:String):Boolean
        {
            var hasBoo:String = this.sysApi.getConfigEntry("config.boo");
            if (((!(this.sysApi.hasRight())) && (!(hasBoo))))
            {
                return (false);
            };
            if (shortcut != "toggleConsole")
            {
                return (true);
            };
            if (this._consoleState)
            {
                this.showConsole(false);
            }
            else
            {
                this.showConsole(true);
            };
            return (false);
        }

        private function onHookConsoleToggle():void
        {
            var hasBoo:String = this.sysApi.getConfigEntry("config.boo");
            if (((((!(this.sysApi.hasRight())) && (!(hasBoo)))) && (!(this.sysApi.isDevMode()))))
            {
                return;
            };
            if (this._consoleState)
            {
                this.showConsole(false);
            }
            else
            {
                this.showConsole(true);
            };
        }

        private function onUiLoaded(uiName:String):void
        {
            var i:uint;
            var console:ConsoleUi;
            if (uiName == "console")
            {
                this.sysApi.removeHook(UiLoaded);
                i = 0;
                while (i < this._waitingCmd.length)
                {
                    this.addCommande(this._waitingCmd[i].cmd, this._waitingCmd[i].send, this._waitingCmd[i].openConsole);
                    i++;
                };
                console = this.uiApi.getUi("console").uiClass;
                console.replaceComponent();
                this.uiApi.getUi("console").visible = this._consoleState;
                this._waitingCmd = [];
            };
        }


    }
}//package 

