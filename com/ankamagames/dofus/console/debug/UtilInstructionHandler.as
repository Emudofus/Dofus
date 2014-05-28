package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.console.ConsoleHandler;
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
         this._validArgs0 = this.validArgs();
         super();
      }
      
      public static const _log:Logger;
      
      private const _validArgs0:Dictionary;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var matchMonsters:Array = null;
         var monsterFilter:String = null;
         var monsters:Vector.<Object> = null;
         var currentMonster:Monster = null;
         var spellFilter:String = null;
         var matchSpells:Vector.<Object> = null;
         switch(cmd)
         {
            case "enablereport":
               this.enablereport(console,cmd,args);
               break;
            case "savereport":
               ErrorManager.addError("Console report",new EmptyError());
               break;
            case "enablelogs":
               this.enableLogs(console,cmd,args);
               break;
            case "info":
               this.info(console,cmd,args);
               break;
            case "search":
               this.search(console,cmd,args);
               break;
            case "searchmonster":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an argument to search for");
                  break;
               }
               matchMonsters = new Array();
               monsterFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
               monsters = GameDataQuery.returnInstance(Monster,GameDataQuery.queryString(Monster,"name",monsterFilter));
               for each(currentMonster in monsters)
               {
                  matchMonsters.push("\t" + currentMonster.name + " (id : " + currentMonster.id + ")");
               }
               matchMonsters.sort(Array.CASEINSENSITIVE);
               console.output(matchMonsters.join("\n"));
               console.output("\tRESULT : " + matchMonsters.length + " monsters found");
               break;
            case "searchspell":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an argument to search for");
                  break;
               }
               spellFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
               matchSpells = GameDataQuery.returnInstance(Spell,GameDataQuery.queryString(Spell,"name",spellFilter));
               matchSpells.sort(Array.CASEINSENSITIVE);
               console.output(matchSpells.join("\n"));
               console.output("\tRESULT : " + matchSpells.length + " spells found");
               break;
            case "loadpacket":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an uri argument");
                  break;
               }
               ConnectionsHandler.getHttpConnection().request(new Uri(args[0],false));
               break;
            case "reccordpacket":
               if(!this._reccordPacketFrame)
               {
                  console.output("Start network reccording");
                  this._reccordPacketFrame = new ReccordNetworkPacketFrame();
                  Kernel.getWorker().addFrame(this._reccordPacketFrame);
               }
               else
               {
                  console.output("Stop network reccording");
                  console.output(this._reccordPacketFrame.reccordedMessageCount + " packet(s) reccorded");
                  Kernel.getWorker().removeFrame(this._reccordPacketFrame);
                  this._reccordPacketFrame = null;
               }
               break;
         }
      }
      
      private var _reccordPacketFrame:ReccordNetworkPacketFrame;
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
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
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         var infoClassName:String = null;
         var searchClassName:String = null;
         var arg0:String = null;
         var possibilities:Array = new Array();
         switch(cmd)
         {
            case "enablelogs":
               if(paramIndex == 0)
               {
                  possibilities.push("true");
                  possibilities.push("false");
               }
               break;
            case "info":
               if(paramIndex == 0)
               {
                  for(infoClassName in this._validArgs0)
                  {
                     possibilities.push(infoClassName);
                  }
               }
               break;
            case "search":
               if(paramIndex == 0)
               {
                  for(searchClassName in this._validArgs0)
                  {
                     possibilities.push(searchClassName);
                  }
               }
               else if(paramIndex == 1)
               {
                  arg0 = this._validArgs0[String(currentParams[0]).toLowerCase()];
                  if(arg0)
                  {
                     possibilities = this.getSimpleVariablesAndAccessors(arg0);
                  }
               }
               
               break;
         }
         return possibilities;
      }
      
      private function enablereport(console:ConsoleHandler, cmd:String, args:Array) : void {
         if(args.length == 0)
         {
            DofusErrorHandler.manualActivation = !DofusErrorHandler.manualActivation;
         }
         else if(args.length == 1)
         {
            switch(args[0])
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
                  console.output("Bad arg. Argument must be true, false, or null");
                  return;
            }
         }
         else
         {
            console.output(cmd + "requires 0 or 1 argument.");
            return;
         }
         
         console.output("\tReport have been " + (DofusErrorHandler.manualActivation?"enabled":"disabled") + ". Dofus need to restart.");
      }
      
      private function enableLogs(console:ConsoleHandler, cmd:String, args:Array) : void {
         if(args.length == 0)
         {
            SOSTarget.enabled = !SOSTarget.enabled;
            console.output("\tSOS logs have been " + (SOSTarget.enabled?"enabled":"disabled") + ".");
         }
         else if(args.length == 1)
         {
            switch(args[0])
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
                  SOSTarget.enabled = !SOSTarget.enabled;
                  console.output("\tSOS logs have been " + (SOSTarget.enabled?"enabled":"disabled") + ".");
                  break;
               default:
                  console.output("Bad arg. Argument must be true, false, or null");
            }
         }
         else
         {
            console.output(cmd + "requires 0 or 1 argument.");
         }
         
      }
      
      private function info(console:ConsoleHandler, cmd:String, args:Array) : void {
         var iDataCenter:String = null;
         var className:String = null;
         var id:* = 0;
         var object:Object = null;
         var idFunction:String = null;
         var varAndAccess:Array = null;
         var hasNameField:* = false;
         var property:String = null;
         var currentObject:Object = null;
         var size:* = 0;
         var result:String = "";
         if(args.length != 2)
         {
            console.output(cmd + " needs 2 args.");
            return;
         }
         iDataCenter = args[0];
         className = this._validArgs0[iDataCenter.toLowerCase()];
         id = int(args[1]);
         if(className)
         {
            object = getDefinitionByName(className);
            idFunction = this.getIdFunction(className);
            if(idFunction == null)
            {
               console.output("WARN : " + iDataCenter + " has no getById function !");
               return;
            }
            object = object[idFunction](id);
            if(object == null)
            {
               console.output(iDataCenter + " " + id + " does not exist.");
               return;
            }
            hasNameField = object.hasOwnProperty("name");
            varAndAccess = this.getSimpleVariablesAndAccessors(className,true);
            varAndAccess.sort(Array.CASEINSENSITIVE);
            for each(property in varAndAccess)
            {
               currentObject = object[property];
               if(!currentObject)
               {
                  result = result + ("\t" + property + " : null\n");
               }
               else if((currentObject is Number) || (currentObject is String))
               {
                  result = result + ("\t" + property + " : " + currentObject.toString() + "\n");
               }
               else
               {
                  size = currentObject.length;
                  if(size > 30)
                  {
                     currentObject = currentObject.slice(0,30);
                     result = result + ("\t" + property + "(" + size + " element(s)) : " + currentObject.toString() + ", ...\n");
                  }
                  else
                  {
                     result = result + ("\t" + property + "(" + size + " element(s)) : " + currentObject.toString() + "\n");
                  }
               }
               
            }
            result = StringUtils.cleanString(result);
            result = "\t<b>" + (hasNameField?object.name:"") + " (id : " + object.id + ")</b>\n" + result;
            console.output(result);
         }
         else
         {
            console.output("Bad args. Can\'t search in \'" + iDataCenter + "\'");
         }
      }
      
      private function search(console:ConsoleHandler, cmd:String, args:Array) : void {
         var iDataCenter:String = null;
         var member:String = null;
         var filter:String = null;
         var validArgs1:Array = null;
         var className:String = null;
         var currentObject:Object = null;
         var hasNameField:* = false;
         var object:Object = null;
         var listingFunction:String = null;
         var results:Array = null;
         var matchSearch:Array = null;
         if(args.length < 3)
         {
            console.output(cmd + " needs 3 arguments");
            return;
         }
         iDataCenter = String(args.shift());
         member = String(args.shift());
         filter = args.join(" ").toLowerCase();
         className = this._validArgs0[iDataCenter.toLowerCase()];
         if(className)
         {
            validArgs1 = this.getSimpleVariablesAndAccessors(className);
            if(validArgs1.indexOf(member) != -1)
            {
               object = getDefinitionByName(className);
               listingFunction = this.getListingFunction(className);
               if(listingFunction == null)
               {
                  console.output("WARN : \'" + iDataCenter + "\' has no listing function !");
                  return;
               }
               results = object[listingFunction]();
               matchSearch = new Array();
               if(results.length == 0)
               {
                  console.output("No object found");
                  return;
               }
               if(results[0][member] is Number)
               {
                  if(isNaN(Number(filter)))
                  {
                     console.output("Bad filter. Attribute \'" + member + "\' is a Number. Use a Number filter.");
                     return;
                  }
                  for each(currentObject in results)
                  {
                     if(currentObject)
                     {
                        hasNameField = currentObject.hasOwnProperty("name");
                        if(currentObject[member] == Number(filter))
                        {
                           matchSearch.push("\t" + (hasNameField?currentObject["name"]:"") + " (id : " + currentObject["id"] + ")");
                        }
                     }
                  }
               }
               else if(results[0][member] is String)
               {
                  for each(currentObject in results)
                  {
                     if(currentObject)
                     {
                        hasNameField = currentObject.hasOwnProperty("name");
                        if(StringUtils.noAccent(String(currentObject[member])).toLowerCase().indexOf(StringUtils.noAccent(filter)) != -1)
                        {
                           matchSearch.push("\t" + (hasNameField?currentObject["name"]:"") + " (id : " + currentObject["id"] + ")");
                        }
                     }
                  }
               }
               
               matchSearch.sort(Array.CASEINSENSITIVE);
               console.output(matchSearch.join("\n"));
               console.output("\tRESULT : " + matchSearch.length + " objects found");
            }
            else
            {
               console.output("Bad args. Attribute \'" + member + "\' does not exist in \'" + iDataCenter + "\' (Case sensitive)");
            }
         }
         else
         {
            console.output("Bad args. Can\'t search in \'" + iDataCenter + "\'");
         }
      }
      
      private function validArgs() : Dictionary {
         var subXML:XML = null;
         var varAndAccessors:Array = null;
         var dico:Dictionary = new Dictionary();
         var xml:XML = describeType(GameDataList);
         for each(subXML in xml..constant)
         {
            varAndAccessors = this.getSimpleVariablesAndAccessors(String(subXML.@type));
            if(varAndAccessors.indexOf("id") != -1)
            {
               dico[String(subXML.@name).toLowerCase()] = String(subXML.@type);
            }
         }
         return dico;
      }
      
      private function getSimpleVariablesAndAccessors(clazz:String, addVectors:Boolean = false) : Array {
         var type:String = null;
         var currentXML:XML = null;
         var result:Array = new Array();
         var xml:XML = describeType(getDefinitionByName(clazz));
         for each(currentXML in xml..variable)
         {
            type = String(currentXML.@type);
            if((type == "int") || (type == "uint") || (type == "Number") || (type == "String"))
            {
               result.push(String(currentXML.@name));
            }
            if(addVectors)
            {
               if((!(type.indexOf("Vector.<int>") == -1)) || (!(type.indexOf("Vector.<uint>") == -1)) || (!(type.indexOf("Vector.<Number>") == -1)) || (!(type.indexOf("Vector.<String>") == -1)))
               {
                  if(type.split("Vector").length == 2)
                  {
                     result.push(String(currentXML.@name));
                  }
               }
            }
         }
         for each(currentXML in xml..accessor)
         {
            type = String(currentXML.@type);
            if((type == "int") || (type == "uint") || (type == "Number") || (type == "String"))
            {
               result.push(String(currentXML.@name));
            }
            if(addVectors)
            {
               if((!(type.indexOf("Vector.<int>") == -1)) || (!(type.indexOf("Vector.<uint>") == -1)) || (!(type.indexOf("Vector.<Number>") == -1)) || (!(type.indexOf("Vector.<String>") == -1)))
               {
                  if(type.split("Vector").length == 2)
                  {
                     result.push(String(currentXML.@name));
                  }
               }
            }
         }
         return result;
      }
      
      private function getIdFunction(clazz:String) : String {
         var subXML:XML = null;
         var parameterType:String = null;
         var xml:XML = describeType(getDefinitionByName(clazz));
         for each(subXML in xml..method)
         {
            if((subXML.@returnType == clazz) && (XMLList(subXML.parameter).length() == 1))
            {
               parameterType = String(XMLList(subXML.parameter)[0].@type);
               if((parameterType == "int") || (parameterType == "uint"))
               {
                  if(String(subXML.@name).indexOf("ById") != -1)
                  {
                     return String(subXML.@name);
                  }
               }
            }
         }
         return null;
      }
      
      private function getListingFunction(clazz:String) : String {
         var subXML:XML = null;
         var xml:XML = describeType(getDefinitionByName(clazz));
         for each(subXML in xml..method)
         {
            if((subXML.@returnType == "Array") && (XMLList(subXML.parameter).length() == 0))
            {
               return String(subXML.@name);
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
