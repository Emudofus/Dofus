package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.net.URLRequest;
   import flash.net.URLLoader;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.managers.LangManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   
   public class DtdInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function DtdInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const DONT_IGNORE:Array;
      
      public static const IGNORE:Array;
      
      private var _chCurrent:ConsoleHandler;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var constants:XML = null;
         var sBuffer:String = null;
         var sClassName:String = null;
         var aElement:Array = null;
         var xmlKernelEvents:XML = null;
         var sLang:String = null;
         var urlRequest:URLRequest = null;
         var ulLoader:URLLoader = null;
         var xmlCpt:XML = null;
         var aElements:Array = null;
         var aCommonElements:Array = null;
         var sClass:String = null;
         var sSubBuffer:String = null;
         var i:uint = 0;
         var sIter:String = null;
         var sSubIter:String = null;
         var j:uint = 0;
         var className:String = null;
         var xmlDef:XML = null;
         var bDontIgnore:* = false;
         var accessor:XML = null;
         this._chCurrent = console;
         switch(cmd)
         {
            case "kerneleventdtd":
               xmlKernelEvents = describeType(getDefinitionByName("com.ankamagames.dofus.utils.KernelEventList"));
               sBuffer = "";
               aElement = new Array();
               for each (constants in xmlKernelEvents..constant)
               {
                  sClassName = "on" + constants..@type.split("::")[constants..@type.split("::").length - 1];
                  sBuffer = sBuffer + ("&lt;!ELEMENT " + sClassName + " EMPTY &gt;\n");
                  aElement.push(sClassName);
               }
               sBuffer = sBuffer + ("&lt;!ELEMENT SystemEvents (" + aElement.join(" | ") + ")* &gt;");
               console.output(sBuffer);
               break;
            case "shortcutsdtd":
               if(args[0] != null)
               {
                  sLang = args[0];
               }
               if(!sLang)
               {
                  urlRequest = new URLRequest(LangManager.getInstance().getEntry("config.binds.file"));
               }
               else
               {
                  urlRequest = new URLRequest(LangManager.getInstance().getEntry("config.binds.path.root") + "bind_" + sLang + ".xml");
               }
               _log.error(urlRequest.url);
               ulLoader = new URLLoader();
               ulLoader.addEventListener(Event.COMPLETE,this.onXmlLoadComplete);
               ulLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onXmlLoadError);
               ulLoader.load(urlRequest);
               break;
            case "componentdtd":
               xmlCpt = describeType(getDefinitionByName("com.ankamagames.berilia.utils.ComponentList"));
               args = new Array();
               for each (constants in xmlCpt..constant)
               {
                  args.push(constants..@type.split("::").join("."));
               }
            case "dtd":
               aElements = new Array();
               aCommonElements = new Array();
               sBuffer = "";
               sSubBuffer = "";
               j = 0;
               while(j < args.length)
               {
                  if(args[j].indexOf(".") == -1)
                  {
                     sClass = "com.ankamagames.berilia.components." + args[j];
                  }
                  else
                  {
                     sClass = args[j];
                  }
                  if(ApplicationDomain.currentDomain.hasDefinition(sClass))
                  {
                     className = sClass.split(".")[sClass.split(".").length - 1];
                     xmlDef = describeType(getDefinitionByName(sClass));
                     aElement = new Array();
                     for each (accessor in xmlDef..accessor)
                     {
                        bDontIgnore = !(accessor..@declaredBy.indexOf("ankamagames") == -1);
                        i = 0;
                        while(i < DONT_IGNORE.length)
                        {
                           if(DONT_IGNORE[i] == accessor..@name)
                           {
                              bDontIgnore = true;
                              break;
                           }
                           i++;
                        }
                        i = 0;
                        while(i < IGNORE.length)
                        {
                           if(IGNORE[i] == accessor..@name)
                           {
                              bDontIgnore = false;
                              break;
                           }
                           i++;
                        }
                        if((bDontIgnore) && ((accessor..@type == "String") || (accessor..@type == "Boolean") || (accessor..@type == "Number") || (accessor..@type == "uint") || (accessor..@type == "int")))
                        {
                           try
                           {
                              if(aCommonElements[accessor..@name] == null)
                              {
                                 aCommonElements[accessor..@name] = 
                                    {
                                       "type":accessor..@type,
                                       "ref":[className]
                                    };
                              }
                              else
                              {
                                 aCommonElements[accessor..@name].ref.push(className);
                              }
                              aElement[accessor..@name] = accessor..@type;
                           }
                           catch(e:Error)
                           {
                              continue;
                           }
                        }
                     }
                     aElements[className] = aElement;
                  }
                  else
                  {
                     console.output(sClass + " cannot be found.");
                  }
                  j++;
               }
               sSubBuffer = "";
               for (sIter in aCommonElements)
               {
                  if(aCommonElements[sIter].ref.length > 1)
                  {
                     sSubBuffer = sSubBuffer + ("&lt;!ELEMENT " + sIter + " (#PCDATA) &gt;&lt;!-- " + aCommonElements[sIter].type + ", used by " + aCommonElements[sIter].ref.join(", ") + " --&gt;\n");
                  }
               }
               if(sSubBuffer.length)
               {
                  sBuffer = sBuffer + ("\n\n&lt;!--======================= Common Elements =======================--&gt;\n\n" + sSubBuffer);
               }
               for (sIter in aElements)
               {
                  sBuffer = sBuffer + ("\n\n&lt;!--======================= " + sIter + " Elements =======================--&gt;\n\n");
                  aElement = new Array();
                  for (sSubIter in aElements[sIter])
                  {
                     if(isNaN(Number(sSubIter)))
                     {
                        aElement.push(sSubIter + "?");
                     }
                     if((!(aCommonElements[sSubIter] == null)) && (aCommonElements[sSubIter].ref.length == 1))
                     {
                        sBuffer = sBuffer + ("&lt;!ELEMENT " + sSubIter + " (#PCDATA) &gt;&lt;!-- " + aElements[sIter][sSubIter] + " --&gt;\n");
                     }
                  }
                  aElement.push("Size?");
                  aElement.push("Anchors?");
                  aElement.push("Events?");
                  sBuffer = sBuffer + ("&lt;!ELEMENT " + sIter + " (" + aElement.join(" | ") + ")* &gt;\n");
                  sBuffer = sBuffer + ("&lt;!ATTLIST " + sIter + "\n" + "\t\tname CDATA #IMPLIED\n" + "\t\tstrata (LOW | MEDIUM | HIGH | TOP | TOOLTIP) #IMPLIED &gt;");
               }
               console.output(sBuffer);
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "kernelEventdtd":
               return "Generate the Kernel Events DTD.";
            case "componentdtd":
               return "Generate the Components DTD.";
            case "shortcutsdtd":
               return "Generate the Shortcuts DTD.";
            case "dtd":
               return "Generate a DTD for a given class or component.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
      
      private function parseShortcutXml(sXml:String) : void {
         var shortcut:XML = null;
         var xmlShortcuts:XML = XML(sXml);
         var sBuffer:String = "";
         var aElement:Array = new Array();
         for each(shortcut in xmlShortcuts..bind)
         {
            sBuffer = sBuffer + ("&lt;!ELEMENT " + shortcut..@name + " EMPTY &gt;\n");
            aElement.push(shortcut..@name);
         }
         sBuffer = sBuffer + ("&lt;!ELEMENT Shortcuts (" + aElement.join(" | ") + ")* &gt;");
         if(this._chCurrent != null)
         {
            this._chCurrent.output(sBuffer);
         }
      }
      
      public function onXmlLoadComplete(event:Event) : void {
         var loader:URLLoader = URLLoader(event.target);
         this.parseShortcutXml(loader.data);
      }
      
      public function onXmlLoadError(event:Event) : void {
         if(this._chCurrent != null)
         {
            this._chCurrent.output("IO Error : KeyboardBind file cannot be found");
         }
      }
   }
}
