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
