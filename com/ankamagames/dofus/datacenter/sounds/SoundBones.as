package com.ankamagames.dofus.datacenter.sounds
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.data.GameData;
    import __AS3__.vec.*;

    public class SoundBones implements IDataCenter 
    {

        public static var MODULE:String = "SoundBones";

        public var id:uint;
        public var keys:Vector.<String>;
        public var values:Vector.<Vector.<SoundAnimation>>;
        private var _cacheDictionary:Dictionary;


        public static function getSoundBonesById(id:uint):SoundBones
        {
            var sb:SoundBones = (GameData.getObject(MODULE, id) as SoundBones);
            return (sb);
        }

        public static function getSoundBones():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function getSoundAnimations(animationName:String):Vector.<SoundAnimation>
        {
            if (this._cacheDictionary == null)
            {
                this.makeCacheDictionary();
            };
            return (this._cacheDictionary[animationName]);
        }

        public function getSoundAnimationByFrame(animationName:String, label:String, frame:uint):Vector.<SoundAnimation>
        {
            var animationList:Vector.<SoundAnimation> = this.getSoundAnimations(animationName);
            return (animationList.filter(function (a:SoundAnimation):Boolean
            {
                return ((((a.label == label)) && ((a.startFrame == frame))));
            }));
        }

        public function getSoundAnimationByLabel(animationName:String, label:String=null):Vector.<SoundAnimation>
        {
            var sa:SoundAnimation;
            if (this._cacheDictionary == null)
            {
                this.makeCacheDictionary();
            };
            var ret:Vector.<SoundAnimation> = new Vector.<SoundAnimation>();
            for each (sa in this._cacheDictionary[animationName])
            {
                if ((((sa.label == label)) || ((((label == null)) && ((sa.label == "null"))))))
                {
                    ret.push(sa);
                };
            };
            return (ret);
        }

        public function getRandomSoundAnimation(animationName:String, label:String=null):SoundAnimation
        {
            var list:Vector.<SoundAnimation> = this.getSoundAnimationByLabel(animationName, label);
            var rnd:int = int((Math.random() % list.length));
            var sa:SoundAnimation = list[rnd];
            return (sa);
        }

        private function makeCacheDictionary():void
        {
            var animationName:String;
            var animationParams:Array;
            var animationType:String;
            var animationDirection:int;
            var i:String;
            this._cacheDictionary = new Dictionary();
            for (i in this.keys)
            {
                animationName = this.keys[i];
                this._cacheDictionary[animationName] = this.values[i];
                animationParams = animationName.split("_");
                if (((animationParams) && ((animationParams.length == 2))))
                {
                    animationType = animationParams[0];
                    animationDirection = int(animationParams[1]);
                }
                else
                {
                    break;
                };
                switch (animationDirection)
                {
                    case 1:
                        this._cacheDictionary[(animationType + "_3")] = this.values[i];
                        break;
                    case 3:
                        this._cacheDictionary[(animationType + "_1")] = this.values[i];
                        break;
                    case 5:
                        this._cacheDictionary[(animationType + "_7")] = this.values[i];
                        break;
                    case 7:
                        this._cacheDictionary[(animationType + "_5")] = this.values[i];
                        break;
                };
            };
        }


    }
}//package com.ankamagames.dofus.datacenter.sounds

