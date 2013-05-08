package com.ankamagames.tiphon.events
{
   import flash.events.Event;
   import com.ankamagames.tiphon.types.ITiphonEvent;


   public class TiphonEvent extends Event implements ITiphonEvent
   {
         

      public function TiphonEvent(pType:String, pSprite:*, pParams:String="") {
         super(pType,false,false);
         this._sprite=pSprite;
         this._params=pParams;
      }

      public static const SOUND_EVENT:String = "Sound";

      public static const DATASOUND_EVENT:String = "DataSound";

      public static const PLAYANIM_EVENT:String = "PlayAnim";

      public static const EVT_EVENT:String = "Evt";

      public static const EVENT_SHOT:String = "SHOT";

      public static const EVENT_END:String = "END";

      public static const PLAYER_STOP:String = "STOP";

      public static const ANIMATION_END:String = "animation_event_end";

      public static const ANIMATION_SHOT:String = "SHOT";

      public static const ANIMATION_EVENT:String = "animation_event";

      public static const RENDER_FAILED:String = "render_failed";

      public static const RENDER_SUCCEED:String = "render_succeed";

      public static const RENDER_FATHER_SUCCEED:String = "render_father_succeed";

      public static const SPRITE_INIT:String = "sprite_init";

      public static const SPRITE_INIT_FAILED:String = "sprite_init_failed";

      public static const SUB_ENTITY_ADDED:String = "new_sub_entity_added";

      private var _label:String;

      private var _sprite;

      private var _params:String;

      private var _animationType:String;

      private var _direction:int = -1;

      public function set label(pLabel:String) : void {
         this._label=pLabel;
      }

      public function get label() : String {
         return this._label;
      }

      public function get sprite() : * {
         return this._sprite;
      }

      public function get params() : String {
         return this._params;
      }

      public function get animationType() : String {
         if(this._animationType==null)
         {
            return "undefined";
         }
         return this._animationType;
      }

      public function get direction() : int {
         return this._direction;
      }

      public function get animationName() : String {
         return this._animationType+"_"+this._direction;
      }

      public function set animationName(pAnimationName:String) : void {
         this._animationType=pAnimationName.split("_")[0];
         this._direction=pAnimationName.split("_")[1];
         if(this._direction==3)
         {
            this._direction=1;
         }
         if(this._direction==7)
         {
            this._direction=5;
         }
      }

      public function duplicate() : TiphonEvent {
         return new TiphonEvent(this.type,this._sprite,this._params);
      }
   }

}