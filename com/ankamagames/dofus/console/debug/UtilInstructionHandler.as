package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.console.debug.frames.ReccordNetworkPacketFrame;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
    import com.ankamagames.jerakine.logger.targets.SOSTarget;
    import flash.utils.getDefinitionByName;
    import flash.utils.describeType;
    import com.ankamagames.dofus.misc.lists.GameDataList;

    public class UtilInstructionHandler implements ConsoleInstructionHandler 
    {

        public static const _log:Logger = Log.getLogger(getQualifiedClassName(UtilInstructionHandler));

        private const _validArgs0:Dictionary = UtilInstructionHandler.validArgs();

        private var _reccordPacketFrame:ReccordNetworkPacketFrame;


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var matchMonsters:Array;
            var monsterFilter:String;
            var monsters:Vector.<Object>;
            var currentMonster:Monster;
            var spellFilter:String;
            var matchSpells:Vector.<Object>;
            switch (cmd)
            {
                case "enablereport":
                    this.enablereport(console, cmd, args);
                    return;
                case "savereport":
                    ErrorManager.addError("Console report", new EmptyError());
                    return;
                case "enablelogs":
                    this.enableLogs(console, cmd, args);
                    return;
                case "info":
                    this.info(console, cmd, args);
                    return;
                case "search":
                    this.search(console, cmd, args);
                    return;
                case "searchmonster":
                    if (args.length < 1)
                    {
                        console.output((cmd + " needs an argument to search for"));
                        return;
                    };
                    matchMonsters = new Array();
                    monsterFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
                    monsters = GameDataQuery.returnInstance(Monster, GameDataQuery.queryString(Monster, "name", monsterFilter));
                    for each (currentMonster in monsters)
                    {
                        matchMonsters.push((((("\t" + currentMonster.name) + " (id : ") + currentMonster.id) + ")"));
                    };
                    matchMonsters.sort(Array.CASEINSENSITIVE);
                    console.output(matchMonsters.join("\n"));
                    console.output((("\tRESULT : " + matchMonsters.length) + " monsters found"));
                    return;
                case "searchspell":
                    if (args.length < 1)
                    {
                        console.output((cmd + " needs an argument to search for"));
                        return;
                    };
                    spellFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
                    matchSpells = GameDataQuery.returnInstance(Spell, GameDataQuery.queryString(Spell, "name", spellFilter));
                    matchSpells.sort(Array.CASEINSENSITIVE);
                    console.output(matchSpells.join("\n"));
                    console.output((("\tRESULT : " + matchSpells.length) + " spells found"));
                    return;
                case "loadpacket":
                    if (args.length < 1)
                    {
                        console.output((cmd + " needs an uri argument"));
                        return;
                    };
                    ConnectionsHandler.getHttpConnection().request(new Uri(args[0], false));
                    return;
                case "reccordpacket":
                    if (!(this._reccordPacketFrame))
                    {
                        console.output("Start network reccording");
                        this._reccordPacketFrame = new ReccordNetworkPacketFrame();
                        Kernel.getWorker().addFrame(this._reccordPacketFrame);
                    }
                    else
                    {
                        console.output("Stop network reccording");
                        console.output((this._reccordPacketFrame.reccordedMessageCount + " packet(s) reccorded"));
                        Kernel.getWorker().removeFrame(this._reccordPacketFrame);
                        this._reccordPacketFrame = null;
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "enablelogs":
                    return ("Enable / Disable logs, param : [true/false]");
                case "info":
                    return ("List properties on a specific data (monster, weapon, etc), param [Class] [id]");
                case "search":
                    return ("Generic search function, param : [Class] [Property] [Filter]");
                case "searchmonster":
                    return ("Search monster name/id, param : [part of monster name]");
                case "searchspell":
                    return ("Search spell name/id, param : [part of spell name]");
                case "enablereport":
                    return ("Enable or disable report (see /savereport).");
                case "savereport":
                    return ("If report are enable, it will show report UI (see /savereport)");
                case "loadpacket":
                    return ("Load a remote file containing network(s) packets");
                case "reccordpacket":
                    return ("Reccord network(s) packets into a file (usefull with /loadpacket command)");
            };
            return ((("Unknown command '" + cmd) + "'."));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var infoClassName:String;
            var searchClassName:String;
            var arg0:String;
            var possibilities:Array = new Array();
            switch (cmd)
            {
                case "enablelogs":
                    if (paramIndex == 0)
                    {
                        possibilities.push("true");
                        possibilities.push("false");
                    };
                    break;
                case "info":
                    if (paramIndex == 0)
                    {
                        for (infoClassName in this._validArgs0)
                        {
                            possibilities.push(infoClassName);
                        };
                    };
                    break;
                case "search":
                    if (paramIndex == 0)
                    {
                        for (searchClassName in this._validArgs0)
                        {
                            possibilities.push(searchClassName);
                        };
                    }
                    else
                    {
                        if (paramIndex == 1)
                        {
                            arg0 = this._validArgs0[String(currentParams[0]).toLowerCase()];
                            if (arg0)
                            {
                                possibilities = this.getSimpleVariablesAndAccessors(arg0);
                            };
                        };
                    };
                    break;
            };
            return (possibilities);
        }

        private function enablereport(console:ConsoleHandler, cmd:String, args:Array):void
        {
            if (args.length == 0)
            {
                DofusErrorHandler.manualActivation = !(DofusErrorHandler.manualActivation);
            }
            else
            {
                if (args.length == 1)
                {
                    switch (args[0])
                    {
                        case "true":
                            DofusErrorHandler.manualActivation = true;
                            break;
                        case "false":
                            DofusErrorHandler.manualActivation = false;
                            break;
                        case "":
                            DofusErrorHandler.manualActivation = !(DofusErrorHandler.manualActivation);
                            break;
                        default:
                            console.output("Bad arg. Argument must be true, false, or null");
                            return;
                    };
                }
                else
                {
                    console.output((cmd + "requires 0 or 1 argument."));
                    return;
                };
            };
            console.output((("\tReport have been " + ((DofusErrorHandler.manualActivation) ? "enabled" : "disabled")) + ". Dofus need to restart."));
        }

        private function enableLogs(console:ConsoleHandler, cmd:String, args:Array):void
        {
            if (args.length == 0)
            {
                SOSTarget.enabled = !(SOSTarget.enabled);
                console.output((("\tSOS logs have been " + ((SOSTarget.enabled) ? "enabled" : "disabled")) + "."));
            }
            else
            {
                if (args.length == 1)
                {
                    switch (args[0])
                    {
                        case "true":
                            SOSTarget.enabled = true;
                            console.output("\tSOS logs have been enabled.");
                            break;
                        case "false":
                            SOSTarget.enabled = false;
                            console.output("\tSOS logs have been disabled.");
                            break;
                        case "":
                            SOSTarget.enabled = !(SOSTarget.enabled);
                            console.output((("\tSOS logs have been " + ((SOSTarget.enabled) ? "enabled" : "disabled")) + "."));
                            break;
                        default:
                            console.output("Bad arg. Argument must be true, false, or null");
                    };
                }
                else
                {
                    console.output((cmd + "requires 0 or 1 argument."));
                };
            };
        }

        private function info(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var iDataCenter:String;
            var className:String;
            var id:int;
            var object:Object;
            var idFunction:String;
            var varAndAccess:Array;
            var hasNameField:Boolean;
            var property:String;
            var currentObject:Object;
            var _local_14:int;
            var result:String = "";
            if (args.length != 2)
            {
                console.output((cmd + " needs 2 args."));
                return;
            };
            iDataCenter = args[0];
            className = this._validArgs0[iDataCenter.toLowerCase()];
            id = int(args[1]);
            if (className)
            {
                object = getDefinitionByName(className);
                idFunction = this.getIdFunction(className);
                if (idFunction == null)
                {
                    console.output((("WARN : " + iDataCenter) + " has no getById function !"));
                    return;
                };
                object = object[idFunction](id);
                if (object == null)
                {
                    console.output((((iDataCenter + " ") + id) + " does not exist."));
                    return;
                };
                hasNameField = object.hasOwnProperty("name");
                varAndAccess = this.getSimpleVariablesAndAccessors(className, true);
                varAndAccess.sort(Array.CASEINSENSITIVE);
                for each (property in varAndAccess)
                {
                    currentObject = object[property];
                    if (!(currentObject))
                    {
                        result = (result + (("\t" + property) + " : null\n"));
                    }
                    else
                    {
                        if ((((currentObject is Number)) || ((currentObject is String))))
                        {
                            result = (result + (((("\t" + property) + " : ") + currentObject.toString()) + "\n"));
                        }
                        else
                        {
                            _local_14 = currentObject.length;
                            if (_local_14 > 30)
                            {
                                currentObject = currentObject.slice(0, 30);
                                result = (result + (((((("\t" + property) + "(") + _local_14) + " element(s)) : ") + currentObject.toString()) + ", ...\n"));
                            }
                            else
                            {
                                result = (result + (((((("\t" + property) + "(") + _local_14) + " element(s)) : ") + currentObject.toString()) + "\n"));
                            };
                        };
                    };
                };
                result = StringUtils.cleanString(result);
                result = ((((("\t<b>" + ((hasNameField) ? object.name : "")) + " (id : ") + object.id) + ")</b>\n") + result);
                console.output(result);
            }
            else
            {
                console.output((("Bad args. Can't search in '" + iDataCenter) + "'"));
            };
        }

        private function search(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var iDataCenter:String;
            var member:String;
            var filter:String;
            var validArgs1:Array;
            var className:String;
            var currentObject:Object;
            var hasNameField:Boolean;
            var object:Object;
            var listingFunction:String;
            var results:Array;
            var matchSearch:Array;
            if (args.length < 3)
            {
                console.output((cmd + " needs 3 arguments"));
                return;
            };
            iDataCenter = String(args.shift());
            member = String(args.shift());
            filter = args.join(" ").toLowerCase();
            className = this._validArgs0[iDataCenter.toLowerCase()];
            if (className)
            {
                validArgs1 = this.getSimpleVariablesAndAccessors(className);
                if (validArgs1.indexOf(member) != -1)
                {
                    object = getDefinitionByName(className);
                    listingFunction = this.getListingFunction(className);
                    if (listingFunction == null)
                    {
                        console.output((("WARN : '" + iDataCenter) + "' has no listing function !"));
                        return;
                    };
                    results = object[listingFunction]();
                    matchSearch = new Array();
                    if (results.length == 0)
                    {
                        console.output("No object found");
                        return;
                    };
                    if ((results[0][member] is Number))
                    {
                        if (isNaN(Number(filter)))
                        {
                            console.output((("Bad filter. Attribute '" + member) + "' is a Number. Use a Number filter."));
                            return;
                        };
                        for each (currentObject in results)
                        {
                            if (!(currentObject))
                            {
                            }
                            else
                            {
                                hasNameField = currentObject.hasOwnProperty("name");
                                if (currentObject[member] == Number(filter))
                                {
                                    matchSearch.push((((("\t" + ((hasNameField) ? currentObject["name"] : "")) + " (id : ") + currentObject["id"]) + ")"));
                                };
                            };
                        };
                    }
                    else
                    {
                        if ((results[0][member] is String))
                        {
                            for each (currentObject in results)
                            {
                                if (!(currentObject))
                                {
                                }
                                else
                                {
                                    hasNameField = currentObject.hasOwnProperty("name");
                                    if (StringUtils.noAccent(String(currentObject[member])).toLowerCase().indexOf(StringUtils.noAccent(filter)) != -1)
                                    {
                                        matchSearch.push((((("\t" + ((hasNameField) ? currentObject["name"] : "")) + " (id : ") + currentObject["id"]) + ")"));
                                    };
                                };
                            };
                        };
                    };
                    matchSearch.sort(Array.CASEINSENSITIVE);
                    console.output(matchSearch.join("\n"));
                    console.output((("\tRESULT : " + matchSearch.length) + " objects found"));
                }
                else
                {
                    console.output((((("Bad args. Attribute '" + member) + "' does not exist in '") + iDataCenter) + "' (Case sensitive)"));
                };
            }
            else
            {
                console.output((("Bad args. Can't search in '" + iDataCenter) + "'"));
            };
        }

        private function validArgs():Dictionary
        {
            var subXML:XML;
            var varAndAccessors:Array;
            var dico:Dictionary = new Dictionary();
            var xml:XML = describeType(GameDataList);
            for each (subXML in xml..constant)
            {
                varAndAccessors = this.getSimpleVariablesAndAccessors(String(subXML.@type));
                if (varAndAccessors.indexOf("id") != -1)
                {
                    dico[String(subXML.@name).toLowerCase()] = String(subXML.@type);
                };
            };
            return (dico);
        }

        private function getSimpleVariablesAndAccessors(clazz:String, addVectors:Boolean=false):Array
        {
            var type:String;
            var currentXML:XML;
            var result:Array = new Array();
            var xml:XML = describeType(getDefinitionByName(clazz));
            for each (currentXML in xml..variable)
            {
                type = String(currentXML.@type);
                if ((((((((type == "int")) || ((type == "uint")))) || ((type == "Number")))) || ((type == "String"))))
                {
                    result.push(String(currentXML.@name));
                };
                if (addVectors)
                {
                    if (((((((!((type.indexOf("Vector.<int>") == -1))) || (!((type.indexOf("Vector.<uint>") == -1))))) || (!((type.indexOf("Vector.<Number>") == -1))))) || (!((type.indexOf("Vector.<String>") == -1)))))
                    {
                        if (type.split("Vector").length == 2)
                        {
                            result.push(String(currentXML.@name));
                        };
                    };
                };
            };
            for each (currentXML in xml..accessor)
            {
                type = String(currentXML.@type);
                if ((((((((type == "int")) || ((type == "uint")))) || ((type == "Number")))) || ((type == "String"))))
                {
                    result.push(String(currentXML.@name));
                };
                if (addVectors)
                {
                    if (((((((!((type.indexOf("Vector.<int>") == -1))) || (!((type.indexOf("Vector.<uint>") == -1))))) || (!((type.indexOf("Vector.<Number>") == -1))))) || (!((type.indexOf("Vector.<String>") == -1)))))
                    {
                        if (type.split("Vector").length == 2)
                        {
                            result.push(String(currentXML.@name));
                        };
                    };
                };
            };
            return (result);
        }

        private function getIdFunction(clazz:String):String
        {
            var subXML:XML;
            var parameterType:String;
            var xml:XML = describeType(getDefinitionByName(clazz));
            for each (subXML in xml..method)
            {
                if ((((subXML.@returnType == clazz)) && ((XMLList(subXML.parameter).length() == 1))))
                {
                    parameterType = String(XMLList(subXML.parameter)[0].@type);
                    if ((((parameterType == "int")) || ((parameterType == "uint"))))
                    {
                        if (String(subXML.@name).indexOf("ById") != -1)
                        {
                            return (String(subXML.@name));
                        };
                    };
                };
            };
            return (null);
        }

        private function getListingFunction(clazz:String):String
        {
            var subXML:XML;
            var xml:XML = describeType(getDefinitionByName(clazz));
            for each (subXML in xml..method)
            {
                if ((((subXML.@returnType == "Array")) && ((XMLList(subXML.parameter).length() == 0))))
                {
                    return (String(subXML.@name));
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.console.debug

class EmptyError extends Error 
{


    override public function getStackTrace():String
    {
        return ("");
    }


}

