package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.manager.ClassicSoundManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegSoundManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.berilia.managers.UiSoundManager;
   import com.ankamagames.dofus.datacenter.sounds.SoundUiHook;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.managers.UiModuleManager;
   
   public class SoundInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function SoundInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundInstructionHandler));
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc7_:* = false;
         var _loc8_:String = null;
         var _loc9_:* = NaN;
         var _loc10_:* = false;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         switch(param2)
         {
            case "playmusic":
               if(param3.length != 2)
               {
                  param1.output("COMMAND FAILED ! playmusic must have followings parameters : \n-id\n-volume");
                  return;
               }
               _loc5_ = param3[0];
               _loc6_ = param3[1];
               _loc7_ = true;
               SoundManager.getInstance().manager.playAdminSound(_loc5_,_loc6_,_loc7_,0);
               break;
            case "stopmusic":
               SoundManager.getInstance().manager.removeAllSounds();
               break;
            case "playambiance":
               if(param3.length != 2)
               {
                  param1.output("COMMAND FAILED ! playambiance must have followings parameters : \n-id\n-volume");
                  return;
               }
               _loc8_ = param3[0];
               _loc9_ = param3[1];
               _loc10_ = true;
               SoundManager.getInstance().manager.playAdminSound(_loc8_,_loc9_,_loc10_,1);
               break;
            case "stopambiance":
               SoundManager.getInstance().manager.stopAdminSound(1);
               break;
            case "addsoundinplaylist":
               if(param3.length != 4)
               {
                  param1.output("addSoundInPLaylist must have followings parameters : \n-id\n-volume\n-silenceMin\n-SilenceMax");
                  return;
               }
               _loc4_ = param3[0];
               _loc11_ = param3[1];
               _loc12_ = param3[2];
               _loc13_ = param3[3];
               if(!SoundManager.getInstance().manager.addSoundInPlaylist(_loc4_,_loc11_,_loc12_,_loc13_))
               {
                  param1.output("addSoundInPLaylist failed !");
               }
               break;
            case "stopplaylist":
               if(param3.length != 0)
               {
                  param1.output("stopplaylist doesn\'t accept any paramter");
                  return;
               }
               SoundManager.getInstance().manager.stopPlaylist();
               break;
            case "playplaylist":
               if(param3.length != 0)
               {
                  param1.output("removeSoundInPLaylist doesn\'t accept any paramter");
                  return;
               }
               SoundManager.getInstance().manager.playPlaylist();
               break;
            case "activesounds":
               if(SoundManager.getInstance().manager is ClassicSoundManager)
               {
                  (SoundManager.getInstance().manager as ClassicSoundManager).forceSoundsDebugMode = true;
               }
               if(SoundManager.getInstance().manager is RegSoundManager)
               {
                  (SoundManager.getInstance().manager as RegSoundManager).forceSoundsDebugMode = true;
               }
               break;
            case "clearsoundcache":
               RegConnectionManager.getInstance().send(ProtocolEnum.CLEAR_CACHE);
               break;
            case "adduisoundelement":
               if(param3.length < 4)
               {
                  param1.output("4 parameters needed");
                  return;
               }
               if(!UiSoundManager.getInstance().getUi(param3[0]))
               {
                  UiSoundManager.getInstance().registerUi(param3[0]);
               }
               UiSoundManager.getInstance().registerUiElement(param3[0],param3[1],param3[2],param3[3]);
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "playsound":
               return "Play a sound";
            case "clearsoundcache":
               return "Nettoye les fichiers pré-cachés pour le son afin de les relire directement depuis le disque lors de la prochaine demande de lecture";
            default:
               return "Unknown command \'" + param1 + "\'.";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:SoundUiHook = null;
         switch(param1)
         {
            case "adduisoundelement":
               if(param2 == 0)
               {
                  return this.getUiList((param3) && (param3.length)?param3[0]:null);
               }
               if(param2 == 2)
               {
                  _loc4_ = (param3) && param3.length > 2?param3[2].toLowerCase():"";
                  _loc5_ = [];
                  _loc6_ = SoundUiHook.getSoundUiHooks();
                  for each (_loc7_ in _loc6_)
                  {
                     if(_loc7_.name.toLowerCase().indexOf(_loc4_) != -1)
                     {
                        _loc5_.push(_loc7_.name);
                     }
                  }
                  return _loc5_;
               }
               break;
         }
         return [];
      }
      
      private function getUiList(param1:String=null) : Array {
         var _loc4_:UiModule = null;
         var _loc5_:UiData = null;
         var param1:String = param1.toLowerCase();
         var _loc2_:Array = [];
         var _loc3_:Array = UiModuleManager.getInstance().getModules();
         for each (_loc4_ in _loc3_)
         {
            for each (_loc5_ in _loc4_.uis)
            {
               if(!param1 || !(_loc5_.name.toLowerCase().indexOf(param1) == -1))
               {
                  _loc2_.push(_loc5_.name);
               }
            }
         }
         _loc2_.sort();
         return _loc2_;
      }
      
      private function getParams(param1:Array, param2:Array) : Array {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:Array = [];
         for (_loc4_ in param1)
         {
            _loc5_ = parseInt(_loc4_);
            _loc6_ = param1[_loc5_];
            _loc7_ = param2[_loc5_];
            _loc3_[_loc5_] = this.getParam(_loc6_,_loc7_);
         }
         return _loc3_;
      }
      
      private function getParam(param1:String, param2:String) : * {
         switch(param2)
         {
            case "String":
               return param1;
            case "Boolean":
               return (param1 == "true") || (param1 == "1");
            case "int":
            case "uint":
               return parseInt(param1);
            default:
               _log.warn("Unsupported parameter type \'" + param2 + "\'.");
               return param1;
         }
      }
   }
}
