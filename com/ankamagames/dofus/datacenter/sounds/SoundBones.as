package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import flash.utils.Dictionary;
   
   public class SoundBones extends Object implements IDataCenter
   {
      
      public function SoundBones() {
         super();
      }
      
      public static var MODULE:String = "SoundBones";
      
      public static function getSoundBonesById(id:uint) : SoundBones {
         var sb:SoundBones = GameData.getObject(MODULE,id) as SoundBones;
         return sb;
      }
      
      public static function getSoundBones() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var keys:Vector.<String>;
      
      public var values:Vector.<Vector.<SoundAnimation>>;
      
      private var _cacheDictionary:Dictionary;
      
      public function getSoundAnimations(animationName:String) : Vector.<SoundAnimation> {
         if(this._cacheDictionary == null)
         {
            this.makeCacheDictionary();
         }
         return this._cacheDictionary[animationName];
      }
      
      public function getSoundAnimationByFrame(animationName:String, label:String, frame:uint) : Vector.<SoundAnimation> {
         var animationList:Vector.<SoundAnimation> = this.getSoundAnimations(animationName);
         return animationList.filter(function(a:SoundAnimation):Boolean
         {
            return (a.label == label) && (a.startFrame == frame);
         });
      }
      
      public function getSoundAnimationByLabel(animationName:String, label:String = null) : Vector.<SoundAnimation> {
         var sa:SoundAnimation = null;
         if(this._cacheDictionary == null)
         {
            this.makeCacheDictionary();
         }
         var ret:Vector.<SoundAnimation> = new Vector.<SoundAnimation>();
         for each(sa in this._cacheDictionary[animationName])
         {
            if((sa.label == label) || (label == null) && (sa.label == "null"))
            {
               ret.push(sa);
            }
         }
         return ret;
      }
      
      public function getRandomSoundAnimation(animationName:String, label:String = null) : SoundAnimation {
         var list:Vector.<SoundAnimation> = this.getSoundAnimationByLabel(animationName,label);
         var rnd:int = int(Math.random() % list.length);
         var sa:SoundAnimation = list[rnd];
         return sa;
      }
      
      private function makeCacheDictionary() : void {
         var i:String = null;
         this._cacheDictionary = new Dictionary();
         for(i in this.keys)
         {
            this._cacheDictionary[this.keys[i]] = this.values[i];
         }
      }
   }
}
