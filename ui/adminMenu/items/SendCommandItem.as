package adminMenu.items
{
    import d2hooks.*;

    public class SendCommandItem extends ExecItem 
    {

        public var command:String;

        public function SendCommandItem(cmd:String, delay:int=0, repeat:int=1)
        {
            this.command = cmd;
            super(delay, repeat);
        }

        override public function get callbackFunction():Function
        {
            switch (this.getReplaceString(this.command))
            {
                case "item":
                case "monster":
                case "look":
                case "fireworks":
                case "spell":
                    return (this.openSelectItem);
            };
            return (Api.consoleMod.addCommande);
        }

        private function openSelectItem(... args):void
        {
            _cmdArg = args;
            if (Api.uiApi.getUi("adminSelectItem"))
            {
                Api.uiApi.unloadUi("adminSelectItem");
            };
            Api.uiApi.loadUi("adminSelectItem", "adminSelectItem", [this.execItemCmd, args[0], true]);
        }

        private function execItemCmd(value:String, cmd:String):void
        {
            var currentReplaceString:String = this.getReplaceString(cmd);
            var replacePos:int = cmd.indexOf(("#" + currentReplaceString));
            cmd = ((cmd.substr(0, replacePos) + value) + cmd.substr(((replacePos + currentReplaceString.length) + 1)));
            currentReplaceString = this.getReplaceString(cmd);
            if (currentReplaceString)
            {
                _cmdArg[0] = cmd;
                this.openSelectItem.apply(this, _cmdArg);
                _cmdArg[0] = this.command;
            }
            else
            {
                Api.consoleMod.addCommande(cmd, _cmdArg[1], _cmdArg[2]);
            };
        }

        override public function getcallbackArgs(replaceParam:Object):Array
        {
            return ([replace(this.command, replaceParam), true, false]);
        }

        private function getReplaceString(command:String):String
        {
            var replaceStringIndex:uint = command.indexOf("#");
            if (command.substr((replaceStringIndex + 1), 4) == "item")
            {
                return ("item");
            };
            if (command.substr((replaceStringIndex + 1), 4) == "look")
            {
                return ("look");
            };
            if (command.substr((replaceStringIndex + 1), 7) == "monster")
            {
                return ("monster");
            };
            if (command.substr((replaceStringIndex + 1), 9) == "fireworks")
            {
                return ("fireworks");
            };
            if (command.substr((replaceStringIndex + 1), 5) == "spell")
            {
                return ("spell");
            };
            return (null);
        }


    }
}//package adminMenu.items

