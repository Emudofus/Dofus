package com.ankamagames.tiphon.events
{
    import com.ankamagames.tiphon.types.*;
    import flash.events.*;

    public class TiphonEvent extends Event implements ITiphonEvent
    {
        private var _label:String;
        private var _sprite:Object;
        private var _params:String;
        private var _animationType:String;
        private var _direction:int = -1;
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

        public function TiphonEvent(param1:String, param2, param3:String = "")
        {
            super(param1, false, false);
            this._sprite = param2;
            this._params = param3;
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function get sprite()
        {
            return this._sprite;
        }// end function

        public function get params() : String
        {
            return this._params;
        }// end function

        public function get animationType() : String
        {
            if (this._animationType == null)
            {
                return "undefined";
            }
            return this._animationType;
        }// end function

        public function get direction() : int
        {
            return this._direction;
        }// end function

        public function get animationName() : String
        {
            return this._animationType + "_" + this._direction;
        }// end function

        public function set animationName(param1:String) : void
        {
            this._animationType = param1.split("_")[0];
            this._direction = param1.split("_")[1];
            if (this._direction == 3)
            {
                this._direction = 1;
            }
            if (this._direction == 7)
            {
                this._direction = 5;
            }
            return;
        }// end function

        public function duplicate() : TiphonEvent
        {
            return new TiphonEvent(this.type, this._sprite, this._params);
        }// end function

    }
}
