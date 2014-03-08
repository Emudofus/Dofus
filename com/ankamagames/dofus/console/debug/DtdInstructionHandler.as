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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DtdInstructionHandler));
      
      public static const DONT_IGNORE:Array = new Array("alpha","linkedTo");
      
      public static const IGNORE:Array = new Array("width","height","haveFocus");
      
      private var _chCurrent:ConsoleHandler;
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:URLRequest = null;
         var _loc11_:URLLoader = null;
         var _loc12_:XML = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:uint = 0;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:uint = 0;
         var _loc21_:String = null;
         var _loc22_:XML = null;
         var _loc23_:* = false;
         var _loc24_:XML = null;
         this._chCurrent = param1;
         switch(param2)
         {
            case "kerneleventdtd":
               _loc8_ = describeType(getDefinitionByName("com.ankamagames.dofus.utils.KernelEventList"));
               _loc5_ = "";
               _loc7_ = new Array();
               for each (_loc4_ in _loc8_..constant)
               {
                  _loc6_ = "on" + _loc4_..@type.split("::")[_loc4_..@type.split("::").length-1];
                  _loc5_ = _loc5_ + ("&lt;!ELEMENT " + _loc6_ + " EMPTY &gt;\n");
                  _loc7_.push(_loc6_);
               }
               _loc5_ = _loc5_ + ("&lt;!ELEMENT SystemEvents (" + _loc7_.join(" | ") + ")* &gt;");
               param1.output(_loc5_);
               break;
            case "shortcutsdtd":
               if(param3[0] != null)
               {
                  _loc9_ = param3[0];
               }
               if(!_loc9_)
               {
                  _loc10_ = new URLRequest(LangManager.getInstance().getEntry("config.binds.file"));
               }
               else
               {
                  _loc10_ = new URLRequest(LangManager.getInstance().getEntry("config.binds.path.root") + "bind_" + _loc9_ + ".xml");
               }
               _log.error(_loc10_.url);
               _loc11_ = new URLLoader();
               _loc11_.addEventListener(Event.COMPLETE,this.onXmlLoadComplete);
               _loc11_.addEventListener(IOErrorEvent.IO_ERROR,this.onXmlLoadError);
               _loc11_.load(_loc10_);
               break;
            case "componentdtd":
               _loc12_ = describeType(getDefinitionByName("com.ankamagames.berilia.utils.ComponentList"));
               param3 = new Array();
               for each (_loc4_ in _loc12_..constant)
               {
                  param3.push(_loc4_..@type.split("::").join("."));
               }
            case "dtd":
               _loc13_ = new Array();
               _loc14_ = new Array();
               _loc5_ = "";
               _loc16_ = "";
               _loc20_ = 0;
               while(_loc20_ < param3.length)
               {
                  if(param3[_loc20_].indexOf(".") == -1)
                  {
                     _loc15_ = "com.ankamagames.berilia.components." + param3[_loc20_];
                  }
                  else
                  {
                     _loc15_ = param3[_loc20_];
                  }
                  if(ApplicationDomain.currentDomain.hasDefinition(_loc15_))
                  {
                     _loc21_ = _loc15_.split(".")[_loc15_.split(".").length-1];
                     _loc22_ = describeType(getDefinitionByName(_loc15_));
                     _loc7_ = new Array();
                     for each (_loc24_ in _loc22_..accessor)
                     {
                        _loc23_ = !(_loc24_..@declaredBy.indexOf("ankamagames") == -1);
                        _loc17_ = 0;
                        while(_loc17_ < DONT_IGNORE.length)
                        {
                           if(DONT_IGNORE[_loc17_] == _loc24_..@name)
                           {
                              _loc23_ = true;
                              break;
                           }
                           _loc17_++;
                        }
                        _loc17_ = 0;
                        while(_loc17_ < IGNORE.length)
                        {
                           if(IGNORE[_loc17_] == _loc24_..@name)
                           {
                              _loc23_ = false;
                              break;
                           }
                           _loc17_++;
                        }
                        if((_loc23_) && (_loc24_..@type == "String" || _loc24_..@type == "Boolean" || _loc24_..@type == "Number" || _loc24_..@type == "uint" || _loc24_..@type == "int"))
                        {
                           try
                           {
                              if(_loc14_[_loc24_..@name] == null)
                              {
                                 _loc14_[_loc24_..@name] = 
                                    {
                                       "type":_loc24_..@type,
                                       "ref":[_loc21_]
                                    };
                              }
                              else
                              {
                                 _loc14_[_loc24_..@name].ref.push(_loc21_);
                              }
                              _loc7_[_loc24_..@name] = _loc24_..@type;
                           }
                           catch(e:Error)
                           {
                              continue;
                           }
                        }
                     }
                     _loc13_[_loc21_] = _loc7_;
                  }
                  else
                  {
                     param1.output(_loc15_ + " cannot be found.");
                  }
                  _loc20_++;
               }
               _loc16_ = "";
               for (_loc18_ in _loc14_)
               {
                  if(_loc14_[_loc18_].ref.length > 1)
                  {
                     _loc16_ = _loc16_ + ("&lt;!ELEMENT " + _loc18_ + " (#PCDATA) &gt;&lt;!-- " + _loc14_[_loc18_].type + ", used by " + _loc14_[_loc18_].ref.join(", ") + " --&gt;\n");
                  }
               }
               if(_loc16_.length)
               {
                  _loc5_ = _loc5_ + ("\n\n&lt;!--======================= Common Elements =======================--&gt;\n\n" + _loc16_);
               }
               for (_loc18_ in _loc13_)
               {
                  _loc5_ = _loc5_ + ("\n\n&lt;!--======================= " + _loc18_ + " Elements =======================--&gt;\n\n");
                  _loc7_ = new Array();
                  for (_loc19_ in _loc13_[_loc18_])
                  {
                     if(isNaN(Number(_loc19_)))
                     {
                        _loc7_.push(_loc19_ + "?");
                     }
                     if(!(_loc14_[_loc19_] == null) && _loc14_[_loc19_].ref.length == 1)
                     {
                        _loc5_ = _loc5_ + ("&lt;!ELEMENT " + _loc19_ + " (#PCDATA) &gt;&lt;!-- " + _loc13_[_loc18_][_loc19_] + " --&gt;\n");
                     }
                  }
                  _loc7_.push("Size?");
                  _loc7_.push("Anchors?");
                  _loc7_.push("Events?");
                  _loc5_ = _loc5_ + ("&lt;!ELEMENT " + _loc18_ + " (" + _loc7_.join(" | ") + ")* &gt;\n");
                  _loc5_ = _loc5_ + ("&lt;!ATTLIST " + _loc18_ + "\n" + "\t\tname CDATA #IMPLIED\n" + "\t\tstrata (LOW | MEDIUM | HIGH | TOP | TOOLTIP) #IMPLIED &gt;");
               }
               param1.output(_loc5_);
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
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
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
      
      private function parseShortcutXml(param1:String) : void {
         var _loc5_:XML = null;
         var _loc2_:XML = XML(param1);
         var _loc3_:* = "";
         var _loc4_:Array = new Array();
         for each (_loc5_ in _loc2_..bind)
         {
            _loc3_ = _loc3_ + ("&lt;!ELEMENT " + _loc5_..@name + " EMPTY &gt;\n");
            _loc4_.push(_loc5_..@name);
         }
         _loc3_ = _loc3_ + ("&lt;!ELEMENT Shortcuts (" + _loc4_.join(" | ") + ")* &gt;");
         if(this._chCurrent != null)
         {
            this._chCurrent.output(_loc3_);
         }
      }
      
      public function onXmlLoadComplete(param1:Event) : void {
         var _loc2_:URLLoader = URLLoader(param1.target);
         this.parseShortcutXml(_loc2_.data);
      }
      
      public function onXmlLoadError(param1:Event) : void {
         if(this._chCurrent != null)
         {
            this._chCurrent.output("IO Error : KeyboardBind file cannot be found");
         }
      }
   }
}
