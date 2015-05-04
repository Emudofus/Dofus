package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import flash.utils.Dictionary;
   
   public class SoundBones extends Object implements IDataCenter
   {
      
      public function SoundBones()
      {
         super();
      }
      
      public static var MODULE:String = "SoundBones";
      
      public static function getSoundBonesById(param1:uint) : SoundBones
      {
         var _loc2_:SoundBones = GameData.getObject(MODULE,param1) as SoundBones;
         return _loc2_;
      }
      
      public static function getSoundBones() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var keys:Vector.<String>;
      
      public var values:Vector.<Vector.<SoundAnimation>>;
      
      private var _cacheDictionary:Dictionary;
      
      public function getSoundAnimations(param1:String) : Vector.<SoundAnimation>
      {
         if(this._cacheDictionary == null)
         {
            this.makeCacheDictionary();
         }
         return this._cacheDictionary[param1];
      }
      
      public function getSoundAnimationByFrame(param1:String, param2:String, param3:uint) : Vector.<SoundAnimation>
      {
         var animationName:String = param1;
         var label:String = param2;
         var frame:uint = param3;
         var animationList:Vector.<SoundAnimation> = this.getSoundAnimations(animationName);
         return animationList.filter(function(param1:SoundAnimation):Boolean
         {
            return param1.label == label && param1.startFrame == frame;
         });
      }
      
      public function getSoundAnimationByLabel(param1:String, param2:String = null) : Vector.<SoundAnimation>
      {
         var _loc4_:SoundAnimation = null;
         if(this._cacheDictionary == null)
         {
            this.makeCacheDictionary();
         }
         var _loc3_:Vector.<SoundAnimation> = new Vector.<SoundAnimation>();
         for each(_loc4_ in this._cacheDictionary[param1])
         {
            if(_loc4_.label == param2 || param2 == null && _loc4_.label == "null")
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getRandomSoundAnimation(param1:String, param2:String = null) : SoundAnimation
      {
         var _loc3_:Vector.<SoundAnimation> = this.getSoundAnimationByLabel(param1,param2);
         var _loc4_:int = int(Math.random() % _loc3_.length);
         var _loc5_:SoundAnimation = _loc3_[_loc4_];
         return _loc5_;
      }
      
      private function makeCacheDictionary() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         this._cacheDictionary = new Dictionary();
         for(_loc5_ in this.keys)
         {
            _loc1_ = this.keys[_loc5_];
            this._cacheDictionary[_loc1_] = this.values[_loc5_];
            _loc2_ = _loc1_.split("_");
            if((_loc2_) && _loc2_.length == 2)
            {
               _loc3_ = _loc2_[0];
               _loc4_ = int(_loc2_[1]);
               switch(_loc4_)
               {
                  case 1:
                     this._cacheDictionary[_loc3_ + "_3"] = this.values[_loc5_];
                     continue;
                  case 3:
                     this._cacheDictionary[_loc3_ + "_1"] = this.values[_loc5_];
                     continue;
                  case 5:
                     this._cacheDictionary[_loc3_ + "_7"] = this.values[_loc5_];
                     continue;
                  case 7:
                     this._cacheDictionary[_loc3_ + "_5"] = this.values[_loc5_];
                     continue;
                  default:
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
   }
}
