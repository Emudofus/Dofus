package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.errormanager.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class UtilInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        private const _validArgs0:Dictionary;
        public static const _log:Logger = Log.getLogger(getQualifiedClassName(UtilInstructionHandler));

        public function UtilInstructionHandler()
        {
            this._validArgs0 = this.validArgs();
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            switch(param2)
            {
                case "enablereport":
                {
                    this.enablereport(param1, param2, param3);
                    break;
                }
                case "savereport":
                {
                    ErrorManager.addError("Console report", new EmptyError());
                    break;
                }
                case "enablelogs":
                {
                    this.enableLogs(param1, param2, param3);
                    break;
                }
                case "info":
                {
                    this.info(param1, param2, param3);
                    break;
                }
                case "search":
                {
                    this.search(param1, param2, param3);
                    break;
                }
                case "searchmonster":
                {
                    if (param3.length < 1)
                    {
                        param1.output(param2 + " needs an argument to search for");
                        break;
                    }
                    _loc_4 = Monster.getMonsters();
                    _loc_5 = new Array();
                    _loc_6 = param3.join(" ").toLowerCase();
                    for each (_loc_7 in _loc_4)
                    {
                        
                        if (_loc_7 && StringUtils.noAccent(_loc_7.name).toLowerCase().indexOf(StringUtils.noAccent(_loc_6)) != -1)
                        {
                            _loc_5.push("\t" + _loc_7.name + " (id : " + _loc_7.id + ")");
                        }
                    }
                    _loc_5.sort(Array.CASEINSENSITIVE);
                    param1.output(_loc_5.join("\n"));
                    param1.output("\tRESULT : " + _loc_5.length + " monsters found");
                    break;
                }
                case "searchspell":
                {
                    if (param3.length < 1)
                    {
                        param1.output(param2 + " needs an argument to search for");
                        break;
                    }
                    _loc_8 = Spell.getSpells();
                    _loc_9 = new Array();
                    _loc_10 = param3.join(" ").toLowerCase();
                    for each (_loc_11 in _loc_8)
                    {
                        
                        if (_loc_11.name && StringUtils.noAccent(_loc_11.name).toLowerCase().indexOf(StringUtils.noAccent(_loc_10)) != -1)
                        {
                            _loc_9.push("\t" + _loc_11.name + " (id : " + _loc_11.id + ")");
                        }
                    }
                    _loc_9.sort(Array.CASEINSENSITIVE);
                    param1.output(_loc_9.join("\n"));
                    param1.output("\tRESULT : " + _loc_9.length + " spells found");
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
                case "enablelogs":
                {
                    return "Enable / Disable logs, param : [true/false]";
                }
                case "info":
                {
                    return "List properties on a specific data (monster, weapon, etc), param [Class] [id]";
                }
                case "search":
                {
                    return "Generic search function, param : [Class] [Property] [Filter]";
                }
                case "searchmonster":
                {
                    return "Search monster name/id, param : [part of monster name]";
                }
                case "searchspell":
                {
                    return "Search spell name/id, param : [part of spell name]";
                }
                case "enablereport":
                {
                    return "Enable or disable report (see /savereport).";
                }
                case "savereport":
                {
                    return "If report are enable, it will show report UI (see /savereport)";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command \'" + param1 + "\'.";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = new Array();
            switch(param1)
            {
                case "enablelogs":
                {
                    if (param2 == 0)
                    {
                        _loc_4.push("true");
                        _loc_4.push("false");
                    }
                    break;
                }
                case "info":
                {
                    if (param2 == 0)
                    {
                        for (_loc_5 in this._validArgs0)
                        {
                            
                            _loc_4.push(_loc_5);
                        }
                    }
                    break;
                }
                case "search":
                {
                    if (param2 == 0)
                    {
                        for (_loc_6 in this._validArgs0)
                        {
                            
                            _loc_4.push(_loc_6);
                        }
                    }
                    else if (param2 == 1)
                    {
                        _loc_7 = this._validArgs0[String(param3[0]).toLowerCase()];
                        if (_loc_7)
                        {
                            _loc_4 = this.getSimpleVariablesAndAccessors(_loc_7);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        private function enablereport(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            if (param3.length == 0)
            {
                DofusErrorHandler.manualActivation = !DofusErrorHandler.manualActivation;
            }
            else
            {
                switch(param3[0])
                {
                    case "true":
                    {
                        break;
                    }
                    case "false":
                    {
                        break;
                    }
                    case "":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            param1.output("\tReport have been " + (DofusErrorHandler.manualActivation ? ("enabled") : ("disabled")) + ". Dofus need to restart.");
            return;
        }// end function

        private function enableLogs(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            if (param3.length == 0)
            {
                SOSTarget.enabled = !SOSTarget.enabled;
                param1.output("\tSOS logs have been " + (SOSTarget.enabled ? ("enabled") : ("disabled")) + ".");
            }
            else
            {
                switch(param3[0])
                {
                    case "true":
                    {
                        break;
                    }
                    case "false":
                    {
                        break;
                    }
                    case "":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function info(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_10:* = "";
            if (param3.length != 2)
            {
                param1.output(param2 + " needs 2 args.");
                return;
            }
            _loc_4 = param3[0];
            _loc_5 = this._validArgs0[_loc_4.toLowerCase()];
            _loc_6 = int(param3[1]);
            if (_loc_5)
            {
                _loc_7 = getDefinitionByName(_loc_5);
                _loc_8 = this.getIdFunction(_loc_5);
                if (_loc_8 == null)
                {
                    param1.output("WARN : " + _loc_4 + " has no getById function !");
                    return;
                }
                var _loc_14:* = _loc_7;
                _loc_7 = _loc_14._loc_7[_loc_8](_loc_6);
                if (_loc_7 == null)
                {
                    param1.output(_loc_4 + " " + _loc_6 + " does not exist.");
                    return;
                }
                _loc_9 = this.getSimpleVariablesAndAccessors(_loc_5, true);
                _loc_9.sort(Array.CASEINSENSITIVE);
                for each (_loc_11 in _loc_9)
                {
                    
                    _loc_12 = _loc_7[_loc_11];
                    if (_loc_12 is Number || _loc_12 is String)
                    {
                        _loc_10 = _loc_10 + ("\t" + _loc_11 + " : " + _loc_12.toString() + "\n");
                        continue;
                    }
                    _loc_13 = _loc_12.length;
                    if (_loc_13 > 30)
                    {
                        _loc_12 = _loc_12.slice(0, 30);
                        _loc_10 = _loc_10 + ("\t" + _loc_11 + "(" + _loc_13 + " element(s)) : " + _loc_12.toString() + ", ...\n");
                        continue;
                    }
                    _loc_10 = _loc_10 + ("\t" + _loc_11 + "(" + _loc_13 + " element(s)) : " + _loc_12.toString() + "\n");
                }
                _loc_10 = StringUtils.cleanString(_loc_10);
                _loc_10 = "\t<b>" + _loc_7.name + " (id : " + _loc_7.id + ")</b>\n" + _loc_10;
                param1.output(_loc_10);
            }
            else
            {
                param1.output("Bad args. Can\'t search in \'" + _loc_4 + "\'");
            }
            return;
        }// end function

        private function search(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (param3.length < 3)
            {
                param1.output(param2 + " needs 3 arguments");
                return;
            }
            _loc_4 = String(param3.shift());
            _loc_5 = String(param3.shift());
            _loc_6 = param3.join(" ").toLowerCase();
            _loc_8 = this._validArgs0[_loc_4.toLowerCase()];
            if (_loc_8)
            {
                _loc_7 = this.getSimpleVariablesAndAccessors(_loc_8);
                if (_loc_7.indexOf(_loc_5) != -1)
                {
                    _loc_10 = getDefinitionByName(_loc_8);
                    _loc_11 = this.getListingFunction(_loc_8);
                    if (_loc_11 == null)
                    {
                        param1.output("WARN : \'" + _loc_4 + "\' has no listing function !");
                        return;
                    }
                    var _loc_14:* = _loc_10;
                    _loc_12 = _loc_14._loc_10[_loc_11]();
                    _loc_13 = new Array();
                    if (_loc_12.length == 0)
                    {
                        param1.output("No object found");
                        return;
                    }
                    if (_loc_12[0][_loc_5] is Number)
                    {
                        if (isNaN(Number(_loc_6)))
                        {
                            param1.output("Bad filter. Attribute \'" + _loc_5 + "\' is a Number. Use a Number filter.");
                            return;
                        }
                        for each (_loc_9 in _loc_12)
                        {
                            
                            if (!_loc_9)
                            {
                                continue;
                            }
                            if (_loc_9[_loc_5] == Number(_loc_6))
                            {
                                _loc_13.push("\t" + _loc_9["name"] + " (id : " + _loc_9["id"] + ")");
                            }
                        }
                    }
                    else if (_loc_12[0][_loc_5] is String)
                    {
                        for each (_loc_9 in _loc_12)
                        {
                            
                            if (!_loc_9)
                            {
                                continue;
                            }
                            if (StringUtils.noAccent(String(_loc_9[_loc_5])).toLowerCase().indexOf(StringUtils.noAccent(_loc_6)) != -1)
                            {
                                _loc_13.push("\t" + _loc_9["name"] + " (id : " + _loc_9["id"] + ")");
                            }
                        }
                    }
                    _loc_13.sort(Array.CASEINSENSITIVE);
                    param1.output(_loc_13.join("\n"));
                    param1.output("\tRESULT : " + _loc_13.length + " objects found");
                }
                else
                {
                    param1.output("Bad args. Attribute \'" + _loc_5 + "\' does not exist in \'" + _loc_4 + "\' (Case sensitive)");
                }
            }
            else
            {
                param1.output("Bad args. Can\'t search in \'" + _loc_4 + "\'");
            }
            return;
        }// end function

        private function validArgs() : Dictionary
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Dictionary();
            var _loc_2:* = describeType(GameDataList);
            for each (_loc_3 in _loc_2..constant)
            {
                
                _loc_4 = this.getSimpleVariablesAndAccessors(String(_loc_3.@type));
                if (_loc_4.indexOf("name") != -1 && _loc_4.indexOf("id") != -1)
                {
                    _loc_1[String(_loc_3.@name).toLowerCase()] = String(_loc_3.@type);
                }
            }
            return _loc_1;
        }// end function

        private function getSimpleVariablesAndAccessors(param1:String, param2:Boolean = false) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = new Array();
            var _loc_4:* = describeType(getDefinitionByName(param1));
            for each (_loc_6 in _loc_4..variable)
            {
                
                _loc_5 = String(_loc_6.@type);
                if (_loc_5 == "int" || _loc_5 == "uint" || _loc_5 == "Number" || _loc_5 == "String")
                {
                    _loc_3.push(String(_loc_6.@name));
                }
                if (param2)
                {
                    if (_loc_5.indexOf("Vector.<int>") != -1 || _loc_5.indexOf("Vector.<uint>") != -1 || _loc_5.indexOf("Vector.<Number>") != -1 || _loc_5.indexOf("Vector.<String>") != -1)
                    {
                        if (_loc_5.split("Vector").length == 2)
                        {
                            _loc_3.push(String(_loc_6.@name));
                        }
                    }
                }
            }
            for each (_loc_6 in _loc_4..accessor)
            {
                
                _loc_5 = String(_loc_6.@type);
                if (_loc_5 == "int" || _loc_5 == "uint" || _loc_5 == "Number" || _loc_5 == "String")
                {
                    _loc_3.push(String(_loc_6.@name));
                }
                if (param2)
                {
                    if (_loc_5.indexOf("Vector.<int>") != -1 || _loc_5.indexOf("Vector.<uint>") != -1 || _loc_5.indexOf("Vector.<Number>") != -1 || _loc_5.indexOf("Vector.<String>") != -1)
                    {
                        if (_loc_5.split("Vector").length == 2)
                        {
                            _loc_3.push(String(_loc_6.@name));
                        }
                    }
                }
            }
            return _loc_3;
        }// end function

        private function getIdFunction(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = describeType(getDefinitionByName(param1));
            for each (_loc_3 in _loc_2..method)
            {
                
                if (_loc_3.@returnType == param1 && XMLList(_loc_3.parameter).length() == 1)
                {
                    _loc_4 = String(XMLList(_loc_3.parameter)[0].@type);
                    if (_loc_4 == "int" || _loc_4 == "uint")
                    {
                        if (String(_loc_3.@name).indexOf("ById") != -1)
                        {
                            return String(_loc_3.@name);
                        }
                    }
                }
            }
            return null;
        }// end function

        private function getListingFunction(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = describeType(getDefinitionByName(param1));
            for each (_loc_3 in _loc_2..method)
            {
                
                if (_loc_3.@returnType == "Array" && XMLList(_loc_3.parameter).length() == 0)
                {
                    return String(_loc_3.@name);
                }
            }
            return null;
        }// end function

    }
}

import com.ankamagames.dofus.datacenter.monsters.*;

import com.ankamagames.dofus.datacenter.spells.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.dofus.misc.utils.errormanager.*;

import com.ankamagames.jerakine.console.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.logger.targets.*;

import com.ankamagames.jerakine.managers.*;

import com.ankamagames.jerakine.utils.misc.*;

import flash.utils.*;

class EmptyError extends Error
{

    function EmptyError()
    {
        return;
    }// end function

}

