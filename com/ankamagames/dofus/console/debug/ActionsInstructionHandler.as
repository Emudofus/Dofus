package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class ActionsInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ActionsInstructionHandler));

        public function ActionsInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var actionName:String;
            var apiAction:DofusApiAction;
            var actionClass:Class;
            var actionDesc:XML;
            var neededParams:uint;
            var maxParams:uint;
            var paramsTypes:Array;
            var params:Array;
            var accessors:Array;
            var longestAccessor:uint;
            var hookName:String;
            var hparams:Array;
            var targetedHook:Hook;
            var lookFor:String;
            var actionsList:Array;
            var foundCount:uint;
            var param:*;
            var action:Action;
            var acc:*;
            var accName:String;
            var prop:String;
            var padding:String;
            var i:uint;
            var a:String;
            var aDesc:XML;
            var aParams:Array;
            var p:*;
            var console:* = param1;
            var cmd:* = param2;
            var args:* = param3;
            switch(cmd)
            {
                case "sendaction":
                {
                    if (args.length == 0)
                    {
                        console.output("You must specify an action to send.");
                        return;
                    }
                    actionName = args[0];
                    apiAction = DofusApiAction.getApiActionByName(actionName);
                    if (!apiAction)
                    {
                        console.output("The action \'<i>" + actionName + "</i>\' does not exists.");
                        return;
                    }
                    actionClass = apiAction.actionClass;
                    actionDesc = describeType(actionClass);
                    neededParams;
                    maxParams;
                    paramsTypes;
                    var _loc_5:* = 0;
                    var _loc_8:* = 0;
                    var _loc_9:* = actionDesc..method;
                    var _loc_7:* = new XMLList("");
                    for each (_loc_10 in _loc_9)
                    {
                        
                        var _loc_11:* = _loc_9[_loc_8];
                        with (_loc_9[_loc_8])
                        {
                            if (@name == "create")
                            {
                                _loc_7[_loc_8] = _loc_10;
                            }
                        }
                    }
                    var _loc_6:* = _loc_7.parameter;
                    while (_loc_6 in _loc_5)
                    {
                        
                        param = _loc_6[_loc_5];
                        if (param.@optional == "false")
                        {
                            neededParams = (neededParams + 1);
                        }
                        paramsTypes.push(param.@type);
                        maxParams = (maxParams + 1);
                    }
                    if (args.length < (neededParams + 1) || args.length > (maxParams + 1))
                    {
                        console.output("This action needs at least <b>" + neededParams + "</b> and a maximum of <b>" + maxParams + "</b> parameters.");
                        console.output("Parameters types : " + paramsTypes);
                        return;
                    }
                    args.shift();
                    params = this.getParams(args, paramsTypes);
                    try
                    {
                        action = CallWithParameters.callR(apiAction.actionClass["create"], params);
                        if (!action)
                        {
                            throw new Error();
                        }
                    }
                    catch (e:Error)
                    {
                        console.output("Unable to instanciate the action. Maybe some parameters were invalid ?");
                        return;
                    }
                    accessors;
                    longestAccessor;
                    var _loc_5:* = 0;
                    var _loc_6:* = actionDesc..accessor;
                    while (_loc_6 in _loc_5)
                    {
                        
                        acc = _loc_6[_loc_5];
                        accName = acc.@name;
                        if (accName == "prototype")
                        {
                            continue;
                        }
                        if (accName.length > longestAccessor)
                        {
                            longestAccessor = accName.length;
                        }
                        accessors.push(accName);
                    }
                    accessors.sort();
                    console.output("Sending action <b>" + apiAction.name + "</b>:");
                    var _loc_5:* = 0;
                    var _loc_6:* = accessors;
                    while (_loc_6 in _loc_5)
                    {
                        
                        prop = _loc_6[_loc_5];
                        padding;
                        i = prop.length;
                        while (i < longestAccessor)
                        {
                            
                            padding = padding + " ";
                            i = (i + 1);
                        }
                        console.output("    <b>" + padding + prop + "</b> : " + action[prop]);
                    }
                    Kernel.getWorker().process(action);
                    break;
                }
                case "sendhook":
                {
                    if (args.length == 0)
                    {
                        console.output("You must specify an hook to send.");
                        return;
                    }
                    hookName = args[0];
                    hparams = args.slice(1);
                    targetedHook = Hook.getHookByName(hookName);
                    if (!targetedHook)
                    {
                        throw new ApiError("Hook [" + hookName + "] does not exist");
                    }
                    if (targetedHook.nativeHook)
                    {
                        throw new UntrustedApiCallError("Hook " + hookName + " is a native hook. Native hooks cannot be dispatch by module");
                    }
                    CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(targetedHook).concat(hparams));
                    break;
                }
                case "listactions":
                {
                    lookFor;
                    if (args.length > 0)
                    {
                        lookFor = args.join(" ").toLowerCase();
                        console.output("Registered actions matching \'" + lookFor + "\':");
                    }
                    else
                    {
                        console.output("Registered actions:");
                    }
                    actionsList = DofusApiAction.getApiActionsList();
                    foundCount;
                    var _loc_5:* = 0;
                    var _loc_6:* = actionsList;
                    while (_loc_6 in _loc_5)
                    {
                        
                        a = _loc_6[_loc_5];
                        if (lookFor.length > 0 && a.toLowerCase().indexOf(lookFor) == -1)
                        {
                            continue;
                        }
                        console.output("    <b>" + a + "</b>");
                        aDesc = describeType(actionsList[a].actionClass);
                        aParams;
                        var _loc_7:* = 0;
                        var _loc_10:* = 0;
                        var _loc_11:* = aDesc..method;
                        var _loc_9:* = new XMLList("");
                        for each (_loc_12 in _loc_11)
                        {
                            
                            var _loc_13:* = _loc_11[_loc_10];
                            with (_loc_11[_loc_10])
                            {
                                if (@name == "create")
                                {
                                    _loc_9[_loc_10] = _loc_12;
                                }
                            }
                        }
                        var _loc_8:* = _loc_9.parameter;
                        while (_loc_8 in _loc_7)
                        {
                            
                            p = _loc_8[_loc_7];
                            aParams.push(p.@type);
                        }
                        if (aParams.length > 0)
                        {
                            console.output("        " + aParams);
                        }
                        foundCount = (foundCount + 1);
                    }
                    if (foundCount == 0)
                    {
                        console.output("   No match.");
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
                case "sendaction":
                {
                    return "Send an actions to the worker.";
                }
                case "sendhook":
                {
                    return "Send a hook to the worker.";
                }
                case "listactions":
                {
                    return "List all valid actions.";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command \'" + param1 + "\'.";
        }// end function

        private function getParams(param1:Array, param2:Array) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = [];
            for (_loc_4 in param1)
            {
                
                _loc_5 = parseInt(_loc_4);
                _loc_6 = param1[_loc_5];
                _loc_7 = param2[_loc_5];
                _loc_3[_loc_5] = this.getParam(_loc_6, _loc_7);
            }
            return _loc_3;
        }// end function

        private function getParam(param1:String, param2:String)
        {
            switch(param2)
            {
                case "String":
                {
                    return param1;
                }
                case "Boolean":
                {
                    return param1 == "true" || param1 == "1";
                }
                case "int":
                case "uint":
                {
                    return parseInt(param1);
                }
                default:
                {
                    _log.warn("Unsupported parameter type \'" + param2 + "\'.");
                    return param1;
                    break;
                }
            }
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = [];
            switch(param1)
            {
                case "sendaction":
                {
                    if (param2 == 0)
                    {
                        _loc_5 = DofusApiAction.getApiActionsList();
                        for (_loc_6 in _loc_5)
                        {
                            
                            _loc_4.push(_loc_6);
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

    }
}
