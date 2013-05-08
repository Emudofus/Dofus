package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.dofus.types.entities.BenchmarkCharacter;
   import com.ankamagames.dofus.logic.common.frames.DebugBotFrame;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.frames.FightBotFrame;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;


   public class BenchmarkInstructionHandler extends Object implements ConsoleInstructionHandler
   {
         

      public function BenchmarkInstructionHandler() {
         this._log=Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));
         super();
      }

      private static var id:uint = 50000;

      protected var _log:Logger;

      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var animEntity:IAnimated = null;
         var dirEntity:IAnimated = null;
         var fps:FpsManager = null;
         var txt:String = null;
         var useCache:* = false;
         var typeZone:* = 0;
         var showFightZone:* = false;
         var showInteractiveCells:* = false;
         var showTacticMode:* = false;
         var showScalezone:* = false;
         var flattenCells:* = false;
         var showBlockMvt:* = false;
         var rpCharEntity:BenchmarkCharacter = null;
         var fr:DebugBotFrame = null;
         var chatind:* = 0;
         var time:* = 0;
         var external:* = false;
         var arg:String = null;
         var valueTab:Array = null;
         var cmdValue:String = null;
         switch(cmd)
         {
            case "addmovingcharacter":
               if(args.length>0)
               {
                  rpCharEntity=new BenchmarkCharacter(id++,TiphonEntityLook.fromString(args[0]));
                  rpCharEntity.position=MapPoint.fromCellId(int(Math.random()*300));
                  rpCharEntity.display();
                  rpCharEntity.move(BenchmarkMovementBehavior.getRandomPath(rpCharEntity));
               }
               break;
            case "setanimation":
               animEntity=DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               animEntity.setAnimation(args[0]);
               break;
            case "setdirection":
               dirEntity=DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               dirEntity.setDirection(args[0]);
               break;
            case "tiphon-error":
               TiphonDebugManager.disable();
               break;
            case "bot-spectator":
               if(Kernel.getWorker().contains(DebugBotFrame))
               {
                  Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                  console.output("Arret du bot-spectator, "+DebugBotFrame.getInstance().fightCount+" combat(s) vu");
               }
               else
               {
                  fr=DebugBotFrame.getInstance();
                  chatind=args.indexOf("debugchat");
                  if(chatind!=-1)
                  {
                     time=500;
                     if(args.length>chatind+1)
                     {
                        time=args[chatind+1];
                     }
                     fr.enableChatMessagesBot(true,time);
                  }
                  Kernel.getWorker().addFrame(fr);
                  console.output("Démarrage du bot-spectator ");
               }
               break;
            case "bot-fight":
               if(Kernel.getWorker().contains(FightBotFrame))
               {
                  Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                  console.output("Arret du bot-fight, "+FightBotFrame.getInstance().fightCount+" combat(s) effectué");
               }
               else
               {
                  Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                  console.output("Démarrage du bot-fight ");
               }
               break;
            case "fpsmanager":
               fps=FpsManager.getInstance();
               if(StageShareManager.stage.contains(fps))
               {
                  fps.hide();
               }
               else
               {
                  external=!(args.indexOf("external")==-1);
                  if(external)
                  {
                     console.output("Fps Manager External");
                  }
                  fps.display(external);
               }
               break;
            case "fastanimfun":
               console.output((AnimFunManager.getInstance().fastDelay?"Désactivation":"Activation")+" de l\'exécution rapide des anims-funs");
               AnimFunManager.getInstance().fastDelay=!AnimFunManager.getInstance().fastDelay;
               break;
            case "tacticmode":
               TacticModeManager.getInstance().hide();
               useCache=false;
               typeZone=0;
               showFightZone=false;
               showInteractiveCells=false;
               showTacticMode=false;
               showScalezone=false;
               flattenCells=true;
               showBlockMvt=true;
               for each (arg in args)
               {
                  valueTab=arg.split("=");
                  if(valueTab==null)
                  {
                  }
                  else
                  {
                     cmdValue=valueTab[1];
                     if((!(arg.search("fightzone")==-1))&&(valueTab.length<1))
                     {
                        showFightZone=cmdValue.toLowerCase()=="true"?true:false;
                     }
                     else
                     {
                        if((!(arg.search("clearcache")==-1))&&(valueTab.length<1))
                        {
                           useCache=cmdValue.toLowerCase()=="true"?false:true;
                        }
                        else
                        {
                           if((!(arg.search("mode")==-1))&&(valueTab.length<1))
                           {
                              typeZone=cmdValue.toLowerCase()=="rp"?1:0;
                           }
                           else
                           {
                              if((!(arg.search("interactivecells")==-1))&&(valueTab.length<1))
                              {
                                 showInteractiveCells=cmdValue.toLowerCase()=="true"?true:false;
                              }
                              else
                              {
                                 if((!(arg.search("scalezone")==-1))&&(valueTab.length<1))
                                 {
                                    showScalezone=cmdValue.toLowerCase()=="true"?true:false;
                                 }
                                 else
                                 {
                                    if((!(arg.search("show")==-1))&&(valueTab.length<1))
                                    {
                                       showTacticMode=cmdValue.toLowerCase()=="true"?true:false;
                                    }
                                    else
                                    {
                                       if((!(arg.search("flattencells")==-1))&&(valueTab.length<1))
                                       {
                                          flattenCells=cmdValue.toLowerCase()=="true"?true:false;
                                       }
                                       else
                                       {
                                          if((!(arg.search("blocLDV")==-1))&&(valueTab.length<1))
                                          {
                                             showBlockMvt=cmdValue.toLowerCase()=="true"?true:false;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               if(showTacticMode)
               {
                  TacticModeManager.getInstance().setDebugMode(showFightZone,useCache,typeZone,showInteractiveCells,showScalezone,flattenCells,showBlockMvt);
                  TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap,true);
                  txt="Activation";
               }
               else
               {
                  txt="Désactivation";
               }
               txt=txt+" du mode tactique.";
               console.output(txt);
               break;
         }
      }

      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "addmovingcharacter":
               return "Add a new mobile character on scene.";
            case "fpsmanager":
               return "Displays the performance of the client. (external)";
            case "bot-spectator":
               return "Start/Stop the auto join fight spectator bot"+"\n    debugchat";
            case "tiphon-error":
               return "Désactive l\'affichage des erreurs du moteur d\'animation.";
            case "fastanimfun":
               return "Active/Désactive l\'exécution rapide des anims funs.";
            case "tacticmode":
               return "Active/Désactive le mode tactique"+"\n    show=[true|false]"+"\n    clearcache=[true|false]"+"\n    mode=[fight|RP]"+"\n    interactivecells=[true|false] "+"\n    fightzone=[true|false]"+"\n    scalezone=[true|false]"+"\n    flattencells=[true|false]";
            default:
               return "Unknow command";
         }
      }

      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         switch(cmd)
         {
            case "tacticmode":
               return ["show","clearcache","mode","interactivecells","fightzone","scalezone","flattencells"];
            default:
               return [];
         }
      }
   }

}