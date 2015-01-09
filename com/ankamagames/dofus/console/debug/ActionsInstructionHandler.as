package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.utils.DofusApiAction;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import flash.utils.describeType;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class ActionsInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ActionsInstructionHandler));


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
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
            var param:* = undefined;
            var action:Action;
            var acc:* = undefined;
            var accName:String;
            var prop:String;
            var padding:String;
            var i:uint;
            var a:String;
            var aDesc:XML;
            var aParams:Array;
            var p:* = undefined;
            switch (cmd)
            {
                case "sendaction":
                    if (args.length == 0)
                    {
                        console.output("You must specify an action to send.");
                        return;
                    };
                    actionName = args[0];
                    apiAction = DofusApiAction.getApiActionByName(actionName);
                    if (!(apiAction))
                    {
                        console.output((("The action '<i>" + actionName) + "</i>' does not exists."));
                        return;
                    };
                    actionClass = apiAction.actionClass;
                    actionDesc = describeType(actionClass);
                    neededParams = 0;
                    maxParams = 0;
                    paramsTypes = [];
                    for each (param in actionDesc..method.(@name == "create").parameter)
                    {
                        if (param.@optional == "false")
                        {
                            neededParams++;
                        };
                        paramsTypes.push(param.@type);
                        maxParams++;
                    };
                    if ((((args.length < (neededParams + 1))) || ((args.length > (maxParams + 1)))))
                    {
                        console.output((((("This action needs at least <b>" + neededParams) + "</b> and a maximum of <b>") + maxParams) + "</b> parameters."));
                        console.output(("Parameters types : " + paramsTypes));
                        return;
                    };
                    args.shift();
                    params = this.getParams(args, paramsTypes);
                    try
                    {
                        action = CallWithParameters.callR(apiAction.actionClass["create"], params);
                        if (!(action))
                        {
                            throw (new Error());
                        };
                    }
                    catch(e:Error)
                    {
                        console.output("Unable to instanciate the action. Maybe some parameters were invalid ?");
                        return;
                    };
                    accessors = [];
                    longestAccessor = 0;
                    for each (acc in actionDesc..accessor)
                    {
                        accName = acc.@name;
                        if (accName == "prototype")
                        {
                        }
                        else
                        {
                            if (accName.length > longestAccessor)
                            {
                                longestAccessor = accName.length;
                            };
                            accessors.push(accName);
                        };
                    };
                    accessors.sort();
                    console.output((("Sending action <b>" + apiAction.name) + "</b>:"));
                    for each (prop in accessors)
                    {
                        padding = "";
                        i = prop.length;
                        while (i < longestAccessor)
                        {
                            padding = (padding + " ");
                            i++;
                        };
                        console.output((((("    <b>" + padding) + prop) + "</b> : ") + action[prop]));
                    };
                    Kernel.getWorker().process(action);
                    return;
                case "sendhook":
                    if (args.length == 0)
                    {
                        console.output("You must specify an hook to send.");
                        return;
                    };
                    hookName = args[0];
                    hparams = args.slice(1);
                    targetedHook = Hook.getHookByName(hookName);
                    if (!(targetedHook))
                    {
                        throw (new ApiError((("Hook [" + hookName) + "] does not exist")));
                    };
                    if (targetedHook.nativeHook)
                    {
                        throw (new UntrustedApiCallError((("Hook " + hookName) + " is a native hook. Native hooks cannot be dispatch by module")));
                    };
                    CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(targetedHook).concat(hparams));
                    return;
                case "listactions":
                    lookFor = "";
                    if (args.length > 0)
                    {
                        lookFor = args.join(" ").toLowerCase();
                        console.output((("Registered actions matching '" + lookFor) + "':"));
                    }
                    else
                    {
                        console.output("Registered actions:");
                    };
                    actionsList = DofusApiAction.getApiActionsList();
                    foundCount = 0;
                    for (a in actionsList)
                    {
                        if ((((lookFor.length > 0)) && ((a.toLowerCase().indexOf(lookFor) == -1))))
                        {
                        }
                        else
                        {
                            console.output((("    <b>" + a) + "</b>"));
                            aDesc = describeType(actionsList[a].actionClass);
                            aParams = [];
                            for each (p in aDesc..method.(@name == "create").parameter)
                            {
                                aParams.push(p.@type);
                            };
                            if (aParams.length > 0)
                            {
                                console.output(("        " + aParams));
                            };
                            foundCount++;
                        };
                    };
                    if (foundCount == 0)
                    {
                        console.output("   No match.");
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "sendaction":
                    return ("Send an actions to the worker.");
                case "sendhook":
                    return ("Send a hook to the worker.");
                case "listactions":
                    return ("List all valid actions.");
            };
            return ((("Unknown command '" + cmd) + "'."));
        }

        private function getParams(data:Array, types:Array):Array
        {
            var iStr:String;
            var i:uint;
            var v:String;
            var t:String;
            var params:Array = [];
            for (iStr in data)
            {
                i = parseInt(iStr);
                v = data[i];
                t = types[i];
                params[i] = this.getParam(v, t);
            };
            return (params);
        }

        private function getParam(value:String, type:String)
        {
            switch (type)
            {
                case "String":
                    return (value);
                case "Boolean":
                    return ((((value == "true")) || ((value == "1"))));
                case "int":
                case "uint":
                    return (parseInt(value));
                default:
                    _log.warn((("Unsupported parameter type '" + type) + "'."));
                    return (value);
            };
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var actionsList:Array;
            var a:String;
            var possibilities:Array = [];
            switch (cmd)
            {
                case "sendaction":
                    if (paramIndex == 0)
                    {
                        actionsList = DofusApiAction.getApiActionsList();
                        for (a in actionsList)
                        {
                            possibilities.push(a);
                        };
                    };
                    break;
            };
            return (possibilities);
        }


    }
}//package com.ankamagames.dofus.console.debug

