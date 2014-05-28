package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import flash.utils.describeType;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   
   public class ActionsInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ActionsInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var actionName:String = null;
         var apiAction:DofusApiAction = null;
         var actionClass:Class = null;
         var actionDesc:XML = null;
         var neededParams:uint = 0;
         var maxParams:uint = 0;
         var paramsTypes:Array = null;
         var params:Array = null;
         var accessors:Array = null;
         var longestAccessor:uint = 0;
         var hookName:String = null;
         var hparams:Array = null;
         var targetedHook:Hook = null;
         var lookFor:String = null;
         var actionsList:Array = null;
         var foundCount:uint = 0;
         var param:* = undefined;
         var action:Action = null;
         var acc:* = undefined;
         var accName:String = null;
         var prop:String = null;
         var padding:String = null;
         var i:uint = 0;
         var a:String = null;
         var aDesc:XML = null;
         var aParams:Array = null;
         var p:* = undefined;
         switch(cmd)
         {
            case "sendaction":
               if(args.length == 0)
               {
                  console.output("You must specify an action to send.");
                  return;
               }
               actionName = args[0];
               apiAction = DofusApiAction.getApiActionByName(actionName);
               if(!apiAction)
               {
                  console.output("The action \'<i>" + actionName + "</i>\' does not exists.");
                  return;
               }
               actionClass = apiAction.actionClass;
               actionDesc = describeType(actionClass);
               neededParams = 0;
               maxParams = 0;
               paramsTypes = [];
               for each (param in actionDesc..method.(@name == "create").parameter)
               {
                  if(param.@optional == "false")
                  {
                     neededParams++;
                  }
                  paramsTypes.push(param.@type);
                  maxParams++;
               }
               if((args.length < neededParams + 1) || (args.length > maxParams + 1))
               {
                  console.output("This action needs at least <b>" + neededParams + "</b> and a maximum of <b>" + maxParams + "</b> parameters.");
                  console.output("Parameters types : " + paramsTypes);
                  return;
               }
               args.shift();
               params = this.getParams(args,paramsTypes);
               try
               {
                  action = CallWithParameters.callR(apiAction.actionClass["create"],params);
                  if(!action)
                  {
                     throw new Error();
                  }
               }
               catch(e:Error)
               {
                  console.output("Unable to instanciate the action. Maybe some parameters were invalid ?");
                  return;
               }
               accessors = [];
               longestAccessor = 0;
               for each (acc in actionDesc..accessor)
               {
                  accName = acc.@name;
                  if(accName != "prototype")
                  {
                     if(accName.length > longestAccessor)
                     {
                        longestAccessor = accName.length;
                     }
                     accessors.push(accName);
                  }
               }
               accessors.sort();
               console.output("Sending action <b>" + apiAction.name + "</b>:");
               for each (prop in accessors)
               {
                  padding = "";
                  i = prop.length;
                  while(i < longestAccessor)
                  {
                     padding = padding + " ";
                     i++;
                  }
                  console.output("    <b>" + padding + prop + "</b> : " + action[prop]);
               }
               Kernel.getWorker().process(action);
               break;
            case "sendhook":
               if(args.length == 0)
               {
                  console.output("You must specify an hook to send.");
                  return;
               }
               hookName = args[0];
               hparams = args.slice(1);
               targetedHook = Hook.getHookByName(hookName);
               if(!targetedHook)
               {
                  throw new ApiError("Hook [" + hookName + "] does not exist");
               }
               else
               {
                  if(targetedHook.nativeHook)
                  {
                     throw new UntrustedApiCallError("Hook " + hookName + " is a native hook. Native hooks cannot be dispatch by module");
                  }
                  else
                  {
                     CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(targetedHook).concat(hparams));
                     break;
                  }
               }
            case "listactions":
               lookFor = "";
               if(args.length > 0)
               {
                  lookFor = args.join(" ").toLowerCase();
                  console.output("Registered actions matching \'" + lookFor + "\':");
               }
               else
               {
                  console.output("Registered actions:");
               }
               actionsList = DofusApiAction.getApiActionsList();
               foundCount = 0;
               for (a in actionsList)
               {
                  if(!((lookFor.length > 0) && (a.toLowerCase().indexOf(lookFor) == -1)))
                  {
                     console.output("    <b>" + a + "</b>");
                     aDesc = describeType(actionsList[a].actionClass);
                     aParams = [];
                     for each (p in aDesc..method.(@name == "create").parameter)
                     {
                        aParams.push(p.@type);
                     }
                     if(aParams.length > 0)
                     {
                        console.output("        " + aParams);
                     }
                     foundCount++;
                  }
               }
               if(foundCount == 0)
               {
                  console.output("   No match.");
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "sendaction":
               return "Send an actions to the worker.";
            case "sendhook":
               return "Send a hook to the worker.";
            case "listactions":
               return "List all valid actions.";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      private function getParams(data:Array, types:Array) : Array {
         var iStr:String = null;
         var i:uint = 0;
         var v:String = null;
         var t:String = null;
         var params:Array = [];
         for(iStr in data)
         {
            i = parseInt(iStr);
            v = data[i];
            t = types[i];
            params[i] = this.getParam(v,t);
         }
         return params;
      }
      
      private function getParam(value:String, type:String) : * {
         switch(type)
         {
            case "String":
               return value;
            case "Boolean":
               return value == "true" || value == "1";
            case "int":
            case "uint":
               return parseInt(value);
            default:
               _log.warn("Unsupported parameter type \'" + type + "\'.");
               return value;
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         var actionsList:Array = null;
         var a:String = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "sendaction":
               if(paramIndex == 0)
               {
                  actionsList = DofusApiAction.getApiActionsList();
                  for(a in actionsList)
                  {
                     possibilities.push(a);
                  }
               }
               break;
         }
         return possibilities;
      }
   }
}
