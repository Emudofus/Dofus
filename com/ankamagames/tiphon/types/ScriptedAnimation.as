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
         

      public function ScriptedAnimation() {
         var animationName:String = null;
         this.events=[];
         this.anims=[];
         super();
         spriteHandler=currentSpriteHandler;
         MEMORY_LOG[this]=1;
         if(spriteHandler!=null)
         {
            switch(spriteHandler.getDirection())
            {
               case 1:
               case 3:
                  animationName=spriteHandler.getAnimation()+"_1";
                  break;
               case 5:
               case 7:
                  animationName=spriteHandler.getAnimation()+"_5";
                  break;
               default:
                  animationName=spriteHandler.getAnimation()+"_"+spriteHandler.getDirection();
            }
            spriteHandler.tiphonEventManager.parseLabels(currentScene,animationName);
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
                                                 "END":TiphonEvent.ANIMATION_END
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

      public function playEventAtFrame(frame:int) : void {
         if((!this.destroyed)&&(!(frame==this._lastFrame)))
         {
            if(currentLabel==PLAYER_STOP)
            {
               stop();
               FpsControler.uncontrolFps(this);
            }
            if(!this.destroyed)
            {
               spriteHandler.tiphonEventManager.dispatchEvents(frame);
            }
            if((!this.destroyed)&&(totalFrames<1)&&(frame==totalFrames))
            {
               spriteHandler.onAnimationEvent(TiphonEvent.ANIMATION_END);
            }
            this._lastFrame=frame;
         }
      }

      public function destroy() : void {
         if(!this.destroyed)
         {
            this.destroyed=true;
            this.events=null;
            this.anims=null;
            spriteHandler=null;
            if(parent)
            {
               parent.removeChild(this);
            }
         }
      }

      public function setAnimation(... args) : void {
         trace("setAnimation",args);
      }

      public function event(... args) : void {
         trace("event",args);
      }

      public function help() : void {
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