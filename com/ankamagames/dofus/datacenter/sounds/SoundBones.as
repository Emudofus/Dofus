package com.ankamagames.dofus.datacenter.sounds
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.utils.*;

    public class SoundBones extends Object implements IDataCenter
    {
        public var id:uint;
        public var keys:Vector.<String>;
        public var values:Vector.<Vector.<SoundAnimation>>;
        private var _cacheDictionary:Dictionary;
        public static var MODULE:String = "SoundBones";

        public function SoundBones()
        {
            return;
        }// end function

        public function getSoundAnimations(param1:String) : Vector.<SoundAnimation>
        {
            if (this._cacheDictionary == null)
            {
                this.makeCacheDictionary();
            }
            return this._cacheDictionary[param1];
        }// end function

        public function getSoundAnimationByFrame(param1:String, param2:String, param3:uint) : Vector.<SoundAnimation>
        {
            var animationName:* = param1;
            var label:* = param2;
            var frame:* = param3;
            var animationList:* = this.getSoundAnimations(animationName);
            return animationList.filter(function (param1:SoundAnimation) : Boolean
            {
                return param1.label == label && param1.startFrame == frame;
            }// end function
            );
        }// end function

        public function getSoundAnimationByLabel(param1:String, param2:String = null) : Vector.<SoundAnimation>
        {
            var _loc_4:* = null;
            if (this._cacheDictionary == null)
            {
                this.makeCacheDictionary();
            }
            var _loc_3:* = new Vector.<SoundAnimation>;
            for each (_loc_4 in this._cacheDictionary[param1])
            {
                
                if (_loc_4.label == param2 || param2 == null && _loc_4.label == "null")
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public function getRandomSoundAnimation(param1:String, param2:String = null) : SoundAnimation
        {
            var _loc_3:* = this.getSoundAnimationByLabel(param1, param2);
            var _loc_4:* = int(Math.random() % _loc_3.length);
            var _loc_5:* = _loc_3[_loc_4];
            return _loc_3[_loc_4];
        }// end function

        private function makeCacheDictionary() : void
        {
            var _loc_1:* = null;
            this._cacheDictionary = new Dictionary();
            for (_loc_1 in this.keys)
            {
                
                this._cacheDictionary[this.keys[_loc_1]] = this.values[_loc_1];
            }
            return;
        }// end function

        public static function getSoundBonesById(param1:uint) : SoundBones
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as ;
            return _loc_2;
        }// end function

        public static function getSoundBones() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
