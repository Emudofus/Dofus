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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
