package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.tiphon.engine.TiphonFpsManager;
   
   public class ScriptedAnimation extends TiphonAnimation
   {
      
      public function ScriptedAnimation()
      {
         var _loc1_:String = null;
         this.events = [];
         this.anims = [];
         super();
         spriteHandler = currentSpriteHandler;
         MEMORY_LOG[this] = 1;
         if(spriteHandler != null)
         {
            switch(spriteHandler.getDirection())
            {
               case 1:
               case 3:
                  _loc1_ = spriteHandler.getAnimation() + "_1";
                  break;
               case 5:
               case 7:
                  _loc1_ = spriteHandler.getAnimation() + "_5";
                  break;
               default:
                  _loc1_ = spriteHandler.getAnimation() + "_" + spriteHandler.getDirection();
            }
            spriteHandler.tiphonEventManager.parseLabels(currentScene,_loc1_);
         }
         TiphonFpsManager.addOldScriptedAnimation(this);
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ScriptedAnimation));
      
      public static var currentSpriteHandler:IAnimationSpriteHandler;
      
      private static const EVENT_SHOT:String = "SHOT";
      
      private static const EVENT_END:String = "END";
      
      private static const PLAYER_STOP:String = "STOP";
      
      private static const EVENTS:Object = {
         "SHOT":TiphonEvent.ANIMATION_SHOT,
         "END":TiphonEvent.ANIMATION_END,
         "DESTROY":TiphonEvent.ANIMATION_DESTROY
      };
      
      public var SHOT:String;
      
      public var END:String;
      
      public var destroyed:Boolean = false;
      
      private var events:Array;
      
      private var anims:Array;
      
      private var _lastFrame:int = -1;
      
      public var bone:int;
      
      public var animationName:String;
      
      public var direction:int;
      
      public var inCache:Boolean = false;
      
      public function playEventAtFrame(param1:int) : void
      {
         if(!this.destroyed && !(param1 == this._lastFrame))
         {
            if(currentLabel == PLAYER_STOP)
            {
               stop();
               FpsControler.uncontrolFps(this);
            }
            if(!this.destroyed)
            {
               spriteHandler.tiphonEventManager.dispatchEvents(param1);
            }
            if(!this.destroyed && totalFrames > 1 && param1 == totalFrames)
            {
               spriteHandler.onAnimationEvent(TiphonEvent.ANIMATION_END);
            }
            this._lastFrame = param1;
         }
      }
      
      public function destroy() : void
      {
         if(!this.destroyed)
         {
            this.destroyed = true;
            this.events = null;
            this.anims = null;
            spriteHandler = null;
            if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      public function setAnimation(... rest) : void
      {
         trace("setAnimation",rest);
      }
      
      public function event(... rest) : void
      {
         trace("event",rest);
      }
      
      public function help() : void
      {
         trace("Fonctions utilisables : ");
         trace("\t\t- setAnimation([nom_anim])");
         trace("\t\t- event([nom])");
         trace("");
         trace("Events :");
         trace("\t\t- SHOT : la cible du sort est touché");
         trace("\t\t- END : l\'animation est finie");
      }
   }
}
