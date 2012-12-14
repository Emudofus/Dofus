package com.ankamagames.jerakine.console
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.utils.*;

    public class ConsoleHandler extends Object implements MessageHandler, ConsoleInstructionHandler
    {
        private var _name:String;
        private var _handlers:Dictionary;
        private var _outputHandler:MessageHandler;
        private var _displayExecutionTime:Boolean;
        private var _hideCommandsWithoutHelp:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ConsoleHandler));

        public function ConsoleHandler(param1:MessageHandler, param2:Boolean = true, param3:Boolean = false)
        {
            this._outputHandler = param1;
            this._handlers = new Dictionary();
            this._displayExecutionTime = param2;
            this._hideCommandsWithoutHelp = param3;
            this._handlers["help"] = this;
            return;
        }// end function

        public function get handlers() : Dictionary
        {
            return this._handlers;
        }// end function

        public function get outputHandler() : MessageHandler
        {
            return this._outputHandler;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function process(param1:Message) : Boolean
        {
            if (param1 is ConsoleInstructionMessage)
            {
                this.dispatchMessage(ConsoleInstructionMessage(param1));
                return true;
            }
            return false;
        }// end function

        public function output(param1:String) : void
        {
            this._outputHandler.process(new ConsoleOutputMessage(this._name, param1));
            return;
        }// end function

        public function addHandler(param1, param2:ConsoleInstructionHandler) : void
        {
            var _loc_3:* = null;
            if (param1 is Array)
            {
                for each (_loc_3 in param1)
                {
                    
                    if (_loc_3)
                    {
                        this._handlers[String(_loc_3)] = param2;
                    }
                }
            }
            else if (param1)
            {
                this._handlers[String(param1)] = param2;
            }
            return;
        }// end function

        public function changeOutputHandler(param1:MessageHandler) : void
        {
            this._outputHandler = param1;
            return;
        }// end function

        public function removeHandler(param1:String) : void
        {
            delete this._handlers[param1];
            return;
        }// end function

        public function isHandled(param1:String) : Boolean
        {
            return this._handlers[param1] != null;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            switch(param2)
            {
                case "help":
                {
                    if (param3.length == 0)
                    {
                        param1.output(I18n.getUiText("ui.console.generalHelp", [this._name]));
                        _loc_4 = new Array();
                        for (param2 in this._handlers)
                        {
                            
                            _loc_4.push(param2);
                        }
                        _loc_4.sort();
                        for each (_loc_5 in _loc_4)
                        {
                            
                            _loc_6 = (this._handlers[_loc_5] as ConsoleInstructionHandler).getHelp(_loc_5);
                            if (_loc_6 || !this._hideCommandsWithoutHelp)
                            {
                                param1.output("  - <b>" + _loc_5 + "</b>: " + _loc_6);
                            }
                        }
                    }
                    else
                    {
                        _loc_7 = this._handlers[param3[0]];
                        if (_loc_7)
                        {
                            param1.output("<b>" + _loc_5 + "</b>: " + _loc_7.getHelp(param3[0]));
                        }
                        else
                        {
                            param1.output(I18n.getUiText("ui.console.unknownCommand", [param3[0]]));
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "help":
                {
                    return I18n.getUiText("ui.console.displayhelp");
                }
                default:
                {
                    break;
                }
            }
            return I18n.getUiText("ui.chat.console.noHelp", [param1]);
        }// end function

        public function getCmdHelp(param1:String) : String
        {
            var _loc_2:* = this._handlers[param1];
            if (_loc_2)
            {
                return _loc_2.getHelp(param1);
            }
            return null;
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

        public function autoComplete(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            var _loc_2:* = new Array();
            var _loc_4:* = param1.split(" ");
            if (param1.split(" ").length == 1)
            {
                for (_loc_3 in this._handlers)
                {
                    
                    if (_loc_3.indexOf(param1) == 0)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
                _loc_5 = "";
            }
            else
            {
                _loc_2 = this.getAutoCompletePossibilitiesOnParam(_loc_4[0], (_loc_4.slice(1).length - 1), _loc_4.slice(1));
                _loc_5 = _loc_4.slice(0, (_loc_4.length - 1)).join(" ") + " ";
            }
            if (_loc_2.length > 1)
            {
                _loc_6 = "";
                _loc_7 = true;
                _loc_8 = 1;
                while (_loc_8 < 30)
                {
                    
                    if (_loc_8 > _loc_2[0].length)
                    {
                        break;
                    }
                    for each (_loc_3 in _loc_2)
                    {
                        
                        _loc_7 = _loc_7 && _loc_3.indexOf(_loc_2[0].substr(0, _loc_8)) == 0;
                        if (!_loc_7)
                        {
                            break;
                        }
                    }
                    if (_loc_7)
                    {
                        _loc_6 = _loc_2[0].substr(0, _loc_8);
                    }
                    else
                    {
                        break;
                    }
                    _loc_8 = _loc_8 + 1;
                }
                return _loc_5 + _loc_6;
            }
            else
            {
                if (_loc_2.length == 1)
                {
                    return _loc_5 + _loc_2[0];
                }
                return param1;
            }
        }// end function

        public function getAutoCompletePossibilities(param1:String) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for (_loc_3 in this._handlers)
            {
                
                if (_loc_3.indexOf(param1) == 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function getAutoCompletePossibilitiesOnParam(param1:String, param2:uint, param3:Array) : Array
        {
            var _loc_7:* = null;
            var _loc_4:* = this._handlers[param1];
            var _loc_5:* = new Array();
            var _loc_6:* = new Array();
            if (_loc_4)
            {
                _loc_5 = _loc_4.getParamPossibilities(param1, param2, param3);
                for each (_loc_7 in _loc_5)
                {
                    
                    if (_loc_7.indexOf(param3[param2]) == 0)
                    {
                        _loc_6.push(_loc_7);
                    }
                }
                return _loc_6;
            }
            return [];
        }// end function

        private function dispatchMessage(param1:ConsoleInstructionMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this._handlers[param1.cmd] != null)
            {
                _loc_2 = this._handlers[param1.cmd] as ConsoleInstructionHandler;
                _loc_3 = getTimer();
                _loc_2.handle(this, param1.cmd, param1.args);
                if (this._displayExecutionTime)
                {
                    this.output("Command " + param1.cmd + " executed in " + (getTimer() - _loc_3) + " ms");
                }
            }
            else
            {
                throw new UnhandledConsoleInstructionError(I18n.getUiText("ui.console.notfound", [param1.cmd]));
            }
            return;
        }// end function

    }
}
