package com.ankamagames.dofus.types.data
{
    public class ServerCommand 
    {

        private static var _cmdList:Array = [];
        private static var _cmdByName:Array = [];

        public var name:String;
        public var help:String;

        public function ServerCommand(name:String, help:String)
        {
            this.name = name;
            this.help = help;
            if (!(_cmdByName[name]))
            {
                _cmdByName[name] = this;
                _cmdList.push(name);
            };
        }

        public static function get commandList():Array
        {
            return (_cmdList);
        }

        public static function autoComplete(cmd:String):String
        {
            var sCmd:String;
            var newCmd:String;
            var bMatch:Boolean;
            var i:uint;
            var aMatch:Array = new Array();
            for (sCmd in _cmdByName)
            {
                if (sCmd.indexOf(cmd) == 0)
                {
                    aMatch.push(sCmd);
                };
            };
            if (aMatch.length > 1)
            {
                newCmd = "";
                bMatch = true;
                i = 1;
                while (i < 30)
                {
                    if (i > aMatch[0].length) break;
                    for each (sCmd in aMatch)
                    {
                        bMatch = ((bMatch) && ((sCmd.indexOf(aMatch[0].substr(0, i)) == 0)));
                        if (!(bMatch)) break;
                    };
                    if (bMatch)
                    {
                        newCmd = aMatch[0].substr(0, i);
                    }
                    else
                    {
                        break;
                    };
                    i++;
                };
                return (newCmd);
            };
            return (aMatch[0]);
        }

        public static function getAutoCompletePossibilities(cmd:String):Array
        {
            var sCmd:String;
            var aMatch:Array = new Array();
            for (sCmd in _cmdByName)
            {
                if (sCmd.indexOf(cmd) == 0)
                {
                    aMatch.push(sCmd);
                };
            };
            return (aMatch);
        }

        public static function getHelp(cmd:String):String
        {
            return (((_cmdByName[cmd]) ? _cmdByName[cmd].help : null));
        }

        public static function hasCommand(cmd:String):Boolean
        {
            return (_cmdByName.hasOwnProperty(cmd));
        }


    }
}//package com.ankamagames.dofus.types.data

