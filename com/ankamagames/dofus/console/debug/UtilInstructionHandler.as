package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.dofus.console.debug.frames.ReccordNetworkPacketFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.jerakine.logger.targets.SOSTarget;
   import flash.utils.getDefinitionByName;
   import flash.utils.describeType;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   
   public class UtilInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function UtilInstructionHandler() {
         super();
      }
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(UtilInstructionHandler));
      
      private const _validArgs0:Dictionary = this.validArgs();
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Vector.<Object> = null;
         var _loc7_:Monster = null;
         var _loc8_:String = null;
         var _loc9_:Vector.<Object> = null;
         switch(param2)
         {
            case "enablereport":
               this.enablereport(param1,param2,param3);
               break;
            case "savereport":
               ErrorManager.addError("Console report",new EmptyError());
               break;
            case "enablelogs":
               this.enableLogs(param1,param2,param3);
               break;
            case "info":
               this.info(param1,param2,param3);
               break;
            case "search":
               this.search(param1,param2,param3);
               break;
            case "searchmonster":
               if(param3.length < 1)
               {
                  param1.output(param2 + " needs an argument to search for");
                  break;
               }
               _loc4_ = new Array();
               _loc5_ = StringUtils.noAccent(param3.join(" ").toLowerCase());
               _loc6_ = GameDataQuery.returnInstance(Monster,GameDataQuery.queryString(Monster,"name",_loc5_));
               for each (_loc7_ in _loc6_)
               {
                  _loc4_.push("\t" + _loc7_.name + " (id : " + _loc7_.id + ")");
               }
               _loc4_.sort(Array.CASEINSENSITIVE);
               param1.output(_loc4_.join("\n"));
               param1.output("\tRESULT : " + _loc4_.length + " monsters found");
               break;
            case "searchspell":
               if(param3.length < 1)
               {
                  param1.output(param2 + " needs an argument to search for");
                  break;
               }
               _loc8_ = StringUtils.noAccent(param3.join(" ").toLowerCase());
               _loc9_ = GameDataQuery.returnInstance(Spell,GameDataQuery.queryString(Spell,"name",_loc8_));
               _loc9_.sort(Array.CASEINSENSITIVE);
               param1.output(_loc9_.join("\n"));
               param1.output("\tRESULT : " + _loc9_.length + " spells found");
               break;
            case "loadpacket":
               if(param3.length < 1)
               {
                  param1.output(param2 + " needs an uri argument");
                  break;
               }
               ConnectionsHandler.getHttpConnection().request(new Uri(param3[0],false));
               break;
            case "reccordpacket":
               if(!this._reccordPacketFrame)
               {
                  param1.output("Start network reccording");
                  this._reccordPacketFrame = new ReccordNetworkPacketFrame();
                  Kernel.getWorker().addFrame(this._reccordPacketFrame);
               }
               else
               {
                  param1.output("Stop network reccording");
                  param1.output(this._reccordPacketFrame.reccordedMessageCount + " packet(s) reccorded");
                  Kernel.getWorker().removeFrame(this._reccordPacketFrame);
                  this._reccordPacketFrame = null;
               }
               break;
         }
      }
      
      private var _reccordPacketFrame:ReccordNetworkPacketFrame;
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "enablelogs":
               return "Enable / Disable logs, param : [true/false]";
            case "info":
               return "List properties on a specific data (monster, weapon, etc), param [Class] [id]";
            case "search":
               return "Generic search function, param : [Class] [Property] [Filter]";
            case "searchmonster":
               return "Search monster name/id, param : [part of monster name]";
            case "searchspell":
               return "Search spell name/id, param : [part of spell name]";
            case "enablereport":
               return "Enable or disable report (see /savereport).";
            case "savereport":
               return "If report are enable, it will show report UI (see /savereport)";
            case "loadpacket":
               return "Load a remote file containing network(s) packets";
            case "reccordpacket":
               return "Reccord network(s) packets into a file (usefull with /loadpacket command)";
            default:
               return "Unknown command \'" + param1 + "\'.";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:Array = new Array();
         switch(param1)
         {
            case "enablelogs":
               if(param2 == 0)
               {
                  _loc4_.push("true");
                  _loc4_.push("false");
               }
               break;
            case "info":
               if(param2 == 0)
               {
                  for (_loc5_ in this._validArgs0)
                  {
                     _loc4_.push(_loc5_);
                  }
               }
               break;
            case "search":
               if(param2 == 0)
               {
                  for (_loc6_ in this._validArgs0)
                  {
                     _loc4_.push(_loc6_);
                  }
               }
               else
               {
                  if(param2 == 1)
                  {
                     _loc7_ = this._validArgs0[String(param3[0]).toLowerCase()];
                     if(_loc7_)
                     {
                        _loc4_ = this.getSimpleVariablesAndAccessors(_loc7_);
                     }
                  }
               }
               break;
         }
         return _loc4_;
      }
      
      private function enablereport(param1:ConsoleHandler, param2:String, param3:Array) : void {
         if(param3.length == 0)
         {
            DofusErrorHandler.manualActivation = !DofusErrorHandler.manualActivation;
         }
         else
         {
            if(param3.length == 1)
            {
               switch(param3[0])
               {
                  case "true":
                     DofusErrorHandler.manualActivation = true;
                     break;
                  case "false":
                     DofusErrorHandler.manualActivation = false;
                     break;
                  case "":
                     DofusErrorHandler.manualActivation = !DofusErrorHandler.manualActivation;
                     break;
                  default:
                     param1.output("Bad arg. Argument must be true, false, or null");
                     return;
               }
            }
            else
            {
               param1.output(param2 + "requires 0 or 1 argument.");
               return;
            }
         }
         param1.output("\tReport have been " + (DofusErrorHandler.manualActivation?"enabled":"disabled") + ". Dofus need to restart.");
      }
      
      private function enableLogs(param1:ConsoleHandler, param2:String, param3:Array) : void {
         if(param3.length == 0)
         {
            SOSTarget.enabled = !SOSTarget.enabled;
            param1.output("\tSOS logs have been " + (SOSTarget.enabled?"enabled":"disabled") + ".");
         }
         else
         {
            if(param3.length == 1)
            {
               switch(param3[0])
               {
                  case "true":
                     SOSTarget.enabled = true;
                     param1.output("\tSOS logs have been enabled.");
                     break;
                  case "false":
                     SOSTarget.enabled = false;
                     param1.output("\tSOS logs have been disabled.");
                     break;
                  case "":
                     SOSTarget.enabled = !SOSTarget.enabled;
                     param1.output("\tSOS logs have been " + (SOSTarget.enabled?"enabled":"disabled") + ".");
                     break;
                  default:
                     param1.output("Bad arg. Argument must be true, false, or null");
               }
            }
            else
            {
               param1.output(param2 + "requires 0 or 1 argument.");
            }
         }
      }
      
      private function info(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc11_:* = false;
         var _loc12_:String = null;
         var _loc13_:Object = null;
         var _loc14_:* = 0;
         var _loc10_:* = "";
         if(param3.length != 2)
         {
            param1.output(param2 + " needs 2 args.");
            return;
         }
         _loc4_ = param3[0];
         _loc5_ = this._validArgs0[_loc4_.toLowerCase()];
         _loc6_ = int(param3[1]);
         if(_loc5_)
         {
            _loc7_ = getDefinitionByName(_loc5_);
            _loc8_ = this.getIdFunction(_loc5_);
            if(_loc8_ == null)
            {
               param1.output("WARN : " + _loc4_ + " has no getById function !");
               return;
            }
            _loc7_ = _loc7_[_loc8_](_loc6_);
            if(_loc7_ == null)
            {
               param1.output(_loc4_ + " " + _loc6_ + " does not exist.");
               return;
            }
            _loc11_ = _loc7_.hasOwnProperty("name");
            _loc9_ = this.getSimpleVariablesAndAccessors(_loc5_,true);
            _loc9_.sort(Array.CASEINSENSITIVE);
            for each (_loc12_ in _loc9_)
            {
               _loc13_ = _loc7_[_loc12_];
               if(!_loc13_)
               {
                  _loc10_ = _loc10_ + ("\t" + _loc12_ + " : null\n");
               }
               else
               {
                  if(_loc13_ is Number || _loc13_ is String)
                  {
                     _loc10_ = _loc10_ + ("\t" + _loc12_ + " : " + _loc13_.toString() + "\n");
                  }
                  else
                  {
                     _loc14_ = _loc13_.length;
                     if(_loc14_ > 30)
                     {
                        _loc13_ = _loc13_.slice(0,30);
                        _loc10_ = _loc10_ + ("\t" + _loc12_ + "(" + _loc14_ + " element(s)) : " + _loc13_.toString() + ", ...\n");
                     }
                     else
                     {
                        _loc10_ = _loc10_ + ("\t" + _loc12_ + "(" + _loc14_ + " element(s)) : " + _loc13_.toString() + "\n");
                     }
                  }
               }
            }
            _loc10_ = StringUtils.cleanString(_loc10_);
            _loc10_ = "\t<b>" + (_loc11_?_loc7_.name:"") + " (id : " + _loc7_.id + ")</b>\n" + _loc10_;
            param1.output(_loc10_);
         }
         else
         {
            param1.output("Bad args. Can\'t search in \'" + _loc4_ + "\'");
         }
      }
      
      private function search(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:* = false;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         if(param3.length < 3)
         {
            param1.output(param2 + " needs 3 arguments");
            return;
         }
         _loc4_ = String(param3.shift());
         _loc5_ = String(param3.shift());
         _loc6_ = param3.join(" ").toLowerCase();
         _loc8_ = this._validArgs0[_loc4_.toLowerCase()];
         if(_loc8_)
         {
            _loc7_ = this.getSimpleVariablesAndAccessors(_loc8_);
            if(_loc7_.indexOf(_loc5_) != -1)
            {
               _loc11_ = getDefinitionByName(_loc8_);
               _loc12_ = this.getListingFunction(_loc8_);
               if(_loc12_ == null)
               {
                  param1.output("WARN : \'" + _loc4_ + "\' has no listing function !");
                  return;
               }
               _loc13_ = _loc11_[_loc12_]();
               _loc14_ = new Array();
               if(_loc13_.length == 0)
               {
                  param1.output("No object found");
                  return;
               }
               if(_loc13_[0][_loc5_] is Number)
               {
                  if(isNaN(Number(_loc6_)))
                  {
                     param1.output("Bad filter. Attribute \'" + _loc5_ + "\' is a Number. Use a Number filter.");
                     return;
                  }
                  for each (_loc9_ in _loc13_)
                  {
                     if(_loc9_)
                     {
                        _loc10_ = _loc9_.hasOwnProperty("name");
                        if(_loc9_[_loc5_] == Number(_loc6_))
                        {
                           _loc14_.push("\t" + (_loc10_?_loc9_["name"]:"") + " (id : " + _loc9_["id"] + ")");
                        }
                     }
                  }
               }
               else
               {
                  if(_loc13_[0][_loc5_] is String)
                  {
                     for each (_loc9_ in _loc13_)
                     {
                        if(_loc9_)
                        {
                           _loc10_ = _loc9_.hasOwnProperty("name");
                           if(StringUtils.noAccent(String(_loc9_[_loc5_])).toLowerCase().indexOf(StringUtils.noAccent(_loc6_)) != -1)
                           {
                              _loc14_.push("\t" + (_loc10_?_loc9_["name"]:"") + " (id : " + _loc9_["id"] + ")");
                           }
                        }
                     }
                  }
               }
               _loc14_.sort(Array.CASEINSENSITIVE);
               param1.output(_loc14_.join("\n"));
               param1.output("\tRESULT : " + _loc14_.length + " objects found");
            }
            else
            {
               param1.output("Bad args. Attribute \'" + _loc5_ + "\' does not exist in \'" + _loc4_ + "\' (Case sensitive)");
            }
         }
         else
         {
            param1.output("Bad args. Can\'t search in \'" + _loc4_ + "\'");
         }
      }
      
      private function validArgs() : Dictionary {
         var _loc3_:XML = null;
         var _loc4_:Array = null;
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:XML = describeType(GameDataList);
         for each (_loc3_ in _loc2_..constant)
         {
            _loc4_ = this.getSimpleVariablesAndAccessors(String(_loc3_.@type));
            if(_loc4_.indexOf("id") != -1)
            {
               _loc1_[String(_loc3_.@name).toLowerCase()] = String(_loc3_.@type);
            }
         }
         return _loc1_;
      }
      
      private function getSimpleVariablesAndAccessors(param1:String, param2:Boolean=false) : Array {
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc3_:Array = new Array();
         var _loc4_:XML = describeType(getDefinitionByName(param1));
         for each (_loc6_ in _loc4_..variable)
         {
            _loc5_ = String(_loc6_.@type);
            if(_loc5_ == "int" || _loc5_ == "uint" || _loc5_ == "Number" || _loc5_ == "String")
            {
               _loc3_.push(String(_loc6_.@name));
            }
            if(param2)
            {
               if(!(_loc5_.indexOf("Vector.<int>") == -1) || !(_loc5_.indexOf("Vector.<uint>") == -1) || !(_loc5_.indexOf("Vector.<Number>") == -1) || !(_loc5_.indexOf("Vector.<String>") == -1))
               {
                  if(_loc5_.split("Vector").length == 2)
                  {
                     _loc3_.push(String(_loc6_.@name));
                  }
               }
            }
         }
         for each (_loc6_ in _loc4_..accessor)
         {
            _loc5_ = String(_loc6_.@type);
            if(_loc5_ == "int" || _loc5_ == "uint" || _loc5_ == "Number" || _loc5_ == "String")
            {
               _loc3_.push(String(_loc6_.@name));
            }
            if(param2)
            {
               if(!(_loc5_.indexOf("Vector.<int>") == -1) || !(_loc5_.indexOf("Vector.<uint>") == -1) || !(_loc5_.indexOf("Vector.<Number>") == -1) || !(_loc5_.indexOf("Vector.<String>") == -1))
               {
                  if(_loc5_.split("Vector").length == 2)
                  {
                     _loc3_.push(String(_loc6_.@name));
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function getIdFunction(param1:String) : String {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc2_:XML = describeType(getDefinitionByName(param1));
         for each (_loc3_ in _loc2_..method)
         {
            if(_loc3_.@returnType == param1 && XMLList(_loc3_.parameter).length() == 1)
            {
               _loc4_ = String(XMLList(_loc3_.parameter)[0].@type);
               if(_loc4_ == "int" || _loc4_ == "uint")
               {
                  if(String(_loc3_.@name).indexOf("ById") != -1)
                  {
                     return String(_loc3_.@name);
                  }
               }
            }
         }
         return null;
      }
      
      private function getListingFunction(param1:String) : String {
         var _loc3_:XML = null;
         var _loc2_:XML = describeType(getDefinitionByName(param1));
         for each (_loc3_ in _loc2_..method)
         {
            if(_loc3_.@returnType == "Array" && XMLList(_loc3_.parameter).length() == 0)
            {
               return String(_loc3_.@name);
            }
         }
         return null;
      }
   }
}
class EmptyError extends Error
{
   
   function EmptyError() {
      super();
   }
   
   override public function getStackTrace() : String {
      return "";
   }
}
