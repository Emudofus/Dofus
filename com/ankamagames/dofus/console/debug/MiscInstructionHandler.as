package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.dofus.logic.game.common.frames.SynchronisationFrame;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.logger.LogLogger;
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.InvokeEvent;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.replay.LogFrame;
   import flash.filesystem.FileMode;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.utils.setTimeout;
   import com.ankamagames.dofus.logic.shield.ShieldSecureLevel;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import flash.display.StageQuality;


   public class MiscInstructionHandler extends Object implements ConsoleInstructionHandler
   {
         

      public function MiscInstructionHandler() {
         super();
      }



      private var _synchronisationFrameInstance:SynchronisationFrame;

      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var log:Logger = null;
         var size:uint = 0;
         var emptySince:uint = 0;
         var i:uint = 0;
         var s:String = null;
         var managerName:String = null;
         var logFile:File = null;
         var entitiesList:Array = null;
         var level:uint = 0;
         var val:* = undefined;
         var prop:Array = null;
         var name:String = null;
         var p:Object = null;
         var o:* = undefined;
         var fsLog:FileStream = null;
         var logContent:ByteArray = null;
         var entity:TiphonSprite = null;
         var tete:DisplayObject = null;
         switch(cmd)
         {
            case "log":
               log=Log.getLogger(getQualifiedClassName(MiscInstructionHandler));
               LogLogger.activeLog((args[0]=="true")||(args[0]=="on"));
               console.output("Log set to "+LogLogger.logIsActive());
               break;
            case "newdofus":
               NativeApplication.nativeApplication.dispatchEvent(new Event(InvokeEvent.INVOKE));
               break;
            case "i18nsize":
               size=0;
               emptySince=0;
               i=1;
               s="";
               do
               {
                  s=I18n.getText(i++);
                  if(s)
                  {
                     emptySince=0;
                     size=size+s.length;
                  }
                  else
                  {
                     emptySince++;
                  }
                  if(emptySince>=20)
                  {
                     console.output(size+" characters in "+(i-1)+" entries.");
                     break loop0;
                  }
               }
               while(true);
               break;
            case "clear":
               KernelEventsManager.getInstance().processCallback(HookList.ConsoleClear);
               break;
            case "config":
               if(!args[0])
               {
                  console.output("Syntax : /config <manager> [<option>]");
               }
               else
               {
                  managerName=args[0];
                  if(!OptionManager.getOptionManager(managerName))
                  {
                     console.output("Unknown manager \'"+managerName+"\').");
                  }
                  else
                  {
                     if(args[1])
                     {
                        if(OptionManager.getOptionManager("atouin")[args[1]]!=null)
                        {
                           val=args[2];
                           if(val=="true")
                           {
                              val=true;
                           }
                           if(val=="false")
                           {
                              val=false;
                           }
                           if(parseInt(val).toString()==val)
                           {
                              val=parseInt(val);
                           }
                           OptionManager.getOptionManager("atouin")[args[1]]=val;
                        }
                        else
                        {
                           console.output(args[1]+" not found on AtouinOption");
                        }
                     }
                     else
                     {
                        prop=new Array();
                        for (name in OptionManager.getOptionManager("atouin"))
                        {
                           prop.push(
                              {
                                 name:name,
                                 value:OptionManager.getOptionManager("atouin")[name]
                              }
                           );
                        }
                        prop.sortOn("name");
                        for each (p in prop)
                        {
                           console.output(" - "+p.name+" : "+p.value);
                        }
                     }
                  }
               }
               break;
            case "clearwebcache":
               TimeoutHTMLLoader.resetCache();
               break;
            case "geteventmodeparams":
               if(args.length!=2)
               {
                  console.output("Syntax : /getEventModeParams <login> <password>");
                  return;
               }
               console.output(Base64.encode("login:"+args[0]+",password:"+args[1]));
               break;
            case "setquality":
               if(args.length!=1)
               {
                  console.output("Current stage.quality : ["+StageShareManager.stage.quality+"]");
                  return;
               }
               StageShareManager.stage.quality=args[0];
               console.output("Try set stage.qualitity to ["+args[0]+"], result : ["+StageShareManager.stage.quality+"]");
               break;
            case "lowdefskin":
               for each (o in EntitiesManager.getInstance().entities)
               {
                  if(o is TiphonSprite)
                  {
                     TiphonSprite(o).setAlternativeSkinIndex(TiphonSprite(o).getAlternativeSkinIndex()==-1?0:-1);
                  }
               }
               break;
            case "copylog":
               LogFrame.getInstance(false).duplicateLogFile();
               break;
            case "savereplaylog":
               logFile=LogFrame.getInstance(false).duplicateLogFile();
               if(logFile.exists)
               {
                  fsLog=new FileStream();
                  logContent=new ByteArray();
                  fsLog.open(logFile,FileMode.READ);
                  fsLog.readBytes(logContent);
                  File.desktopDirectory.save(logContent,"log.d2l");
               }
               break;
            case "synchrosequence":
               if(Kernel.getWorker().contains(SynchronisationFrame))
               {
                  this._synchronisationFrameInstance=Kernel.getWorker().getFrame(SynchronisationFrame) as SynchronisationFrame;
                  Kernel.getWorker().removeFrame(this._synchronisationFrameInstance);
                  console.output("Synchro sequence disable");
               }
               else
               {
                  if(this._synchronisationFrameInstance)
                  {
                     console.output("Synchro sequence enable");
                     Kernel.getWorker().addFrame(this._synchronisationFrameInstance);
                  }
                  else
                  {
                     console.output("Can\'t enable synchro sequence");
                  }
               }
               break;
            case "throw":
               if(args[0]=="async")
               {
                  setTimeout(new function():void
                  {
                     throw new Error("Test error");
                     },100);
                  }
                  else
                  {
                     throw new Error("Test error");
                  }
                  break;
               case "sd":
                  entitiesList=EntitiesManager.getInstance().entities;
                  for each (entity in entitiesList)
                  {
                     if(entity)
                     {
                        tete=entity.getSlot("Tete");
                        if(tete)
                        {
                           tete.scaleX=2;
                           tete.scaleY=2;
                        }
                     }
                  }
                  break;
               case "showsmilies":
                  KernelEventsManager.getInstance().processCallback(HookList.ShowSmilies);
                  break;
               case "shieldmax":
               case "shieldmoy":
               case "shieldmin":
                  if(cmd=="shieldmax")
                  {
                     level=ShieldSecureLevel.MAX;
                  }
                  if(cmd=="shieldmoy")
                  {
                     level=ShieldSecureLevel.MEDIUM;
                  }
                  if(cmd=="shieldmin")
                  {
                     level=ShieldSecureLevel.LOW;
                  }
                  SecureModeManager.getInstance().shieldLevel=level;
                  console.output("Le niveau de s�curit� du shield a bien �tait modifi� au niveau "+cmd.substr(6));
                  break;
               case "debugmouseover":
                  HumanInputHandler.getInstance().debugOver=!HumanInputHandler.getInstance().debugOver;
                  break;
            }
      }

      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "log":
               return "Switch on/off client log process.";
            case "i18nsize":
               return "Get the total size in characters of I18N datas.";
            case "newdofus":
               return "Try to launch a new dofus client.";
            case "clear":
               return "clear the console output";
            case "clearwebcache":
               return "clear cached web browser";
            case "geteventmodeparams":
               return "Get event mode config file param. param 1 : login, param 2 : password";
            case "setquality":
               return "Set stage quality (no param to get actual value)";
            case "config":
               return "list options in different managers if no param else set an option /config [managerName] [paramName] [paramValue]";
            case "copylog":
               return "Copy current log file to xxx.copy";
            case "savereplaylog":
               return I18n.getUiText("ui.chat.console.help.savereplaylog");
            case "synchrosequence":
               return "Enable/disable synchro sequence";
            case "throw":
               return "Throw an exception (test only) option:[async|sync]";
            case "showsmilies":
               return "Activate/Deactivate smilies detection";
            case "debugmouseover":
               return "Activate/Deactivate mouse over debug : It will show which objects receive event and their bounds.";
            default:
               return "No help for command \'"+cmd+"\'";
         }
      }

      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         var managerName:String = null;
         var name:String = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "throw":
               possibilities=["async","sync"];
               break;
            case "setquality":
               possibilities=[StageQuality.LOW,StageQuality.MEDIUM,StageQuality.HIGH,StageQuality.BEST];
               break;
            case "config":
               if(paramIndex==0)
               {
                  possibilities=OptionManager.getOptionManagers();
               }
               else
               {
                  if(paramIndex==1)
                  {
                     managerName=currentParams[0];
                     for (name in OptionManager.getOptionManager(managerName))
                     {
                        possibilities.push(name);
                     }
                  }
               }
               break;
         }
         return possibilities;
      }
   }

}