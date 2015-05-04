package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.dofus.types.entities.BenchmarkCharacter;
   import com.ankamagames.dofus.logic.common.frames.DebugBotFrame;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.dofus.logic.common.frames.FightBotFrame;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class BenchmarkInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function BenchmarkInstructionHandler()
      {
         this._log = Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));
         super();
      }
      
      private static var id:uint = 50000;
      
      protected var _log:Logger;
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc4_:IAnimated = null;
         var _loc5_:LuaScriptRecorderFrame = null;
         var _loc6_:IAnimated = null;
         var _loc7_:FpsManager = null;
         var _loc8_:String = null;
         var _loc9_:* = false;
         var _loc10_:* = 0;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc14_:* = false;
         var _loc15_:* = false;
         var _loc16_:* = false;
         var _loc17_:BenchmarkCharacter = null;
         var _loc18_:DebugBotFrame = null;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = false;
         var _loc22_:String = null;
         var _loc23_:Array = null;
         var _loc24_:String = null;
         switch(param2)
         {
            case "addmovingcharacter":
               if(param3.length > 0)
               {
                  _loc17_ = new BenchmarkCharacter(id++,TiphonEntityLook.fromString(param3[0]));
                  _loc17_.position = MapPoint.fromCellId(int(Math.random() * 300));
                  _loc17_.display();
                  _loc17_.move(BenchmarkMovementBehavior.getRandomPath(_loc17_));
               }
               break;
            case "setanimation":
               _loc4_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               _loc5_ = Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame;
               if(Kernel.getWorker().getFrame(LuaScriptRecorderFrame))
               {
                  _loc5_.createLine("player","setAnimation",param3[0],true);
               }
               _loc4_.setAnimation(param3[0]);
               break;
            case "setdirection":
               _loc6_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               _loc6_.setDirection(param3[0]);
               break;
            case "tiphon-error":
               TiphonDebugManager.disable();
               break;
            case "bot-spectator":
               if(Kernel.getWorker().contains(DebugBotFrame))
               {
                  Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                  param1.output("Arret du bot-spectator, " + DebugBotFrame.getInstance().fightCount + " combat(s) vu");
               }
               else
               {
                  _loc18_ = DebugBotFrame.getInstance();
                  _loc19_ = param3.indexOf("debugchat");
                  if(_loc19_ != -1)
                  {
                     _loc20_ = 500;
                     if(param3.length > _loc19_ + 1)
                     {
                        _loc20_ = param3[_loc19_ + 1];
                     }
                     _loc18_.enableChatMessagesBot(true,_loc20_);
                  }
                  Kernel.getWorker().addFrame(_loc18_);
                  param1.output("Démarrage du bot-spectator ");
               }
               break;
            case "bot-fight":
               if(Kernel.getWorker().contains(FightBotFrame))
               {
                  Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                  param1.output("Arret du bot-fight, " + FightBotFrame.getInstance().fightCount + " combat(s) effectué");
               }
               else
               {
                  Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                  param1.output("Démarrage du bot-fight ");
               }
               break;
            case "fpsmanager":
               _loc7_ = FpsManager.getInstance();
               if(StageShareManager.stage.contains(_loc7_))
               {
                  _loc7_.hide();
               }
               else
               {
                  _loc21_ = !(param3.indexOf("external") == -1);
                  if(_loc21_)
                  {
                     param1.output("Fps Manager External");
                  }
                  _loc7_.display(_loc21_);
               }
               break;
            case "tacticmode":
               TacticModeManager.getInstance().hide();
               _loc9_ = false;
               _loc10_ = 0;
               _loc11_ = false;
               _loc12_ = false;
               _loc13_ = false;
               _loc14_ = false;
               _loc15_ = true;
               _loc16_ = true;
               for each(_loc22_ in param3)
               {
                  _loc23_ = _loc22_.split("=");
                  if(_loc23_ != null)
                  {
                     _loc24_ = _loc23_[1];
                     if(!(_loc22_.search("fightzone") == -1) && _loc23_.length > 1)
                     {
                        _loc11_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     else if(!(_loc22_.search("clearcache") == -1) && _loc23_.length > 1)
                     {
                        _loc9_ = _loc24_.toLowerCase() == "true"?false:true;
                     }
                     else if(!(_loc22_.search("mode") == -1) && _loc23_.length > 1)
                     {
                        _loc10_ = _loc24_.toLowerCase() == "rp"?1:0;
                     }
                     else if(!(_loc22_.search("interactivecells") == -1) && _loc23_.length > 1)
                     {
                        _loc12_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     else if(!(_loc22_.search("scalezone") == -1) && _loc23_.length > 1)
                     {
                        _loc14_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     else if(!(_loc22_.search("show") == -1) && _loc23_.length > 1)
                     {
                        _loc13_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     else if(!(_loc22_.search("flattencells") == -1) && _loc23_.length > 1)
                     {
                        _loc15_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     else if(!(_loc22_.search("blocLDV") == -1) && _loc23_.length > 1)
                     {
                        _loc16_ = _loc24_.toLowerCase() == "true"?true:false;
                     }
                     
                     
                     
                     
                     
                     
                     
                  }
               }
               if(_loc13_)
               {
                  TacticModeManager.getInstance().setDebugMode(_loc11_,_loc9_,_loc10_,_loc12_,_loc14_,_loc15_,_loc16_);
                  TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap,true);
                  _loc8_ = "Activation";
               }
               else
               {
                  _loc8_ = "Désactivation";
               }
               _loc8_ = _loc8_ + " du mode tactique.";
               param1.output(_loc8_);
               break;
         }
      }
      
      public function getHelp(param1:String) : String
      {
         switch(param1)
         {
            case "addmovingcharacter":
               return "Add a new mobile character on scene.";
            case "fpsmanager":
               return "Displays the performance of the client. (external)";
            case "bot-spectator":
               return "Start/Stop the auto join fight spectator bot" + "\n    debugchat";
            case "tiphon-error":
               return "Désactive l\'affichage des erreurs du moteur d\'animation.";
            case "tacticmode":
               return "Active/Désactive le mode tactique" + "\n    show=[true|false]" + "\n    clearcache=[true|false]" + "\n    mode=[fight|RP]" + "\n    interactivecells=[true|false] " + "\n    fightzone=[true|false]" + "\n    scalezone=[true|false]" + "\n    flattencells=[true|false]";
            default:
               return "Unknow command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
      {
         var _loc4_:TiphonSprite = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         switch(param1)
         {
            case "tacticmode":
               return ["show","clearcache","mode","interactivecells","fightzone","scalezone","flattencells"];
            case "setanimation":
               _loc4_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite;
               _loc5_ = _loc4_.animationList;
               _loc6_ = [];
               for each(_loc7_ in _loc5_)
               {
                  if(_loc7_.indexOf("Anim") != -1)
                  {
                     _loc6_.push(_loc7_);
                  }
               }
               _loc6_.sort();
               return _loc6_;
            default:
               return [];
         }
      }
   }
}
