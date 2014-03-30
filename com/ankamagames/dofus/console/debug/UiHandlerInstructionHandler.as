package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.dofus.misc.utils.Inspector;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.utils.ModuleScriptAnalyzer;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.UiRenderManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.console.moduleLogger.Console;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   
   public class UiHandlerInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function UiHandlerInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiHandlerInstructionHandler));
      
      private var _uiInspector:Inspector;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var currentUiList:Dictionary = null;
         var uiOutput:Array = null;
         var ml:Array = null;
         var mod:UiModule = null;
         var m:Array = null;
         var um:UiModule = null;
         var toggleChat:* = false;
         var value:* = false;
         var uiTarget:UiRootContainer = null;
         var elemTarget:GraphicContainer = null;
         var count:uint = 0;
         var uiList:Array = null;
         var i:String = null;
         var uiName:String = null;
         var ui:UiData = null;
         var ma:ModuleScriptAnalyzer = null;
         switch(cmd)
         {
            case "loadui":
               break;
            case "unloadui":
               if(args.length == 0)
               {
                  count = 0;
                  uiList = [];
                  for (i in Berilia.getInstance().uiList)
                  {
                     if(Berilia.getInstance().uiList[i].name != "Console")
                     {
                        uiList.push(Berilia.getInstance().uiList[i].name);
                     }
                  }
                  for each (i in uiList)
                  {
                     Berilia.getInstance().unloadUi(i);
                  }
                  console.output(uiList.length + " UI were unload");
                  break;
               }
               if(Berilia.getInstance().unloadUi(args[0]))
               {
                  console.output("RIP " + args[0]);
               }
               else
               {
                  console.output(args[0] + " does not exist or an error occured while unloading UI");
               }
               break;
            case "clearuicache":
               UiRenderManager.getInstance().clearCache();
               break;
            case "setuiscale":
               Berilia.getInstance().scale = Number(args[0]);
               break;
            case "useuicache":
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,"useCache",args[0] == "true");
               BeriliaConstants.USE_UI_CACHE = args[0] == "true";
               break;
            case "uilist":
               currentUiList = Berilia.getInstance().uiList;
               uiOutput = [];
               for (uiName in currentUiList)
               {
                  ui = UiRootContainer(currentUiList[uiName]).uiData;
                  uiOutput.push([uiName,ui.name,ui.uiClassName,ui.module.id,ui.module.trusted]);
               }
               console.output(StringUtils.formatArray(uiOutput,["Instance ID","Ui name","Class","Module","Trusted"]));
               break;
            case "reloadui":
               UiModuleManager.getInstance().loadModule(args[0]);
               break;
            case "fps":
               Dofus.getInstance().toggleFPS();
               break;
            case "modulelist":
               ml = [];
               m = UiModuleManager.getInstance().getModules();
               for each (mod in m)
               {
                  ml.push([mod.id,mod.author,mod.trusted,true]);
               }
               m = UiModuleManager.getInstance().disabledModules;
               if(m.length)
               {
                  for each (mod in m)
                  {
                     ml.push([mod.id,mod.author,mod.trusted,false]);
                  }
               }
               console.output(StringUtils.formatArray(ml,["ID","Author","Trusted","Active"]));
               break;
            case "getmoduleinfo":
               um = UiModuleManager.getInstance().getModule(args[0]);
               if(um)
               {
                  ma = new ModuleScriptAnalyzer(um,null);
               }
               else
               {
                  console.output("Module " + args[0] + " does not exists");
               }
               break;
            case "chatoutput":
               toggleChat = (!args.length) || (String(args[0]).toLowerCase() == "true") || (String(args[0]).toLowerCase() == "on");
               Console.getInstance().display();
               Console.getInstance().disableLogEvent();
               KernelEventsManager.getInstance().processCallback(ChatHookList.ToggleChatLog,toggleChat);
               value = OptionManager.getOptionManager("chat")["chatoutput"];
               OptionManager.getOptionManager("chat")["chatoutput"] = toggleChat;
               if(toggleChat)
               {
                  console.output("Chatoutput is on.");
               }
               else
               {
                  console.output("Chatoutput is off.");
               }
               break;
            case "uiinspector":
            case "inspector":
               if(!this._uiInspector)
               {
                  this._uiInspector = new Inspector();
               }
               this._uiInspector.enable = !this._uiInspector.enable;
               if(this._uiInspector.enable)
               {
                  console.output("Inspector is ON.\n Use Ctrl-C to save the last hovered element informations.");
               }
               else
               {
                  console.output("Inspector is OFF.");
               }
               break;
            case "inspectuielementsos":
            case "inspectuielement":
               if(args.length == 0)
               {
                  console.output(cmd + " need at least one argument (" + cmd + " uiName [uiElementName])");
                  break;
               }
               uiTarget = Berilia.getInstance().getUi(args[0]);
               if(!uiTarget)
               {
                  console.output("UI " + args[0] + " not found (use /uilist to grab current displayed UI list)");
                  break;
               }
               if(args.length == 1)
               {
                  this.inspectUiElement(uiTarget,cmd == "inspectuielementsos"?null:console);
                  break;
               }
               elemTarget = uiTarget.getElement(args[1]);
               if(!elemTarget)
               {
                  console.output("UI Element " + args[0] + " not found on UI " + args[0] + "(use /uiinspector to view elements names)");
                  break;
               }
               this.inspectUiElement(elemTarget,cmd == "inspectuielementsos"?null:console);
               break;
         }
      }
      
      private function inspectUiElement(target:GraphicContainer, console:ConsoleHandler) : void {
         var txt:String = null;
         var property:String = null;
         var type:String = null;
         var properties:Array = DescribeTypeCache.getVariables(target).concat();
         properties.sort();
         for each (property in properties)
         {
            try
            {
               type = !(target[property] == null)?getQualifiedClassName(target[property]).split("::").pop():"?";
               if(type == "Array")
               {
                  type = type + (", len: " + target[property].length);
               }
               txt = property + " (" + type + ") : " + target[property];
            }
            catch(e:Error)
            {
               txt = property + " (?) : <Exception throw by getter>";
            }
            if(!console)
            {
               _log.info(txt);
            }
            else
            {
               console.output(txt);
            }
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "loadui":
               return "Load an UI. Usage: loadUi <uiId> <uiInstanceName>(optional)";
            case "unloadui":
               return "Unload UI with the given UI instance name.";
            case "clearuicache":
               return "Clear all UI in cache (will force xml parsing).";
            case "setuiscale":
               return "Set scale for all scalable UI. Usage: setUiScale <Number> (100% = 1.0)";
            case "useuicache":
               return "Enable UI caching";
            case "uilist":
               return "Get current UI list";
            case "reloadui":
               return "Unload and reload an Ui";
            case "fps":
               return "Toggle FPS";
            case "chatoutput":
               return "Display the chat content in a separated window.";
            case "modulelist":
               return "Display activated modules.";
            case "inspector":
            case "uiinspector":
               return "Display a tooltip with informations over each interactive element";
            case "inspectuielement":
               return "Display the property list of an UI element (UI or Component), usage /inspectuielement uiName (elementName)";
            case "inspectuielementsos":
               return "Display the property list of an UI element (UI or Component) to SOS, usage /inspectuielement uiName (elementName)";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         var i:String = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "unloadui":
               if(paramIndex == 0)
               {
                  for (i in Berilia.getInstance().uiList)
                  {
                     possibilities.push(Berilia.getInstance().uiList[i].name);
                  }
               }
               break;
         }
         return possibilities;
      }
   }
}
