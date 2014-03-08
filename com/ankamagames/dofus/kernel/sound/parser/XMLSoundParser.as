package com.ankamagames.dofus.kernel.sound.parser
{
   import com.ankamagames.jerakine.types.SoundEventParamWrapper;
   import __AS3__.vec.Vector;
   
   public class XMLSoundParser extends Object
   {
      
      public function XMLSoundParser() {
         super();
      }
      
      private static const _IDS_UNLOCALIZED:Array = new Array("20","17","16");
      
      public static function parseXMLSoundFile(param1:XML, param2:Vector.<uint>) : SoundEventParamWrapper {
         var _loc4_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:Vector.<SoundEventParamWrapper> = null;
         var _loc8_:XMLList = null;
         var _loc9_:Vector.<SoundEventParamWrapper> = null;
         var _loc10_:XML = null;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:uint = 0;
         var _loc17_:SoundEventParamWrapper = null;
         var _loc3_:XMLList = param1.elements();
         var _loc5_:RegExp = new RegExp("^\\s*(.*?)\\s*$","g");
         for each (_loc6_ in _loc3_)
         {
            if(_loc4_ == null)
            {
               _loc12_ = _loc6_.@skin;
               _loc13_ = _loc12_.split(",");
               for each (_loc14_ in _loc13_)
               {
                  _loc15_ = _loc14_.replace(_loc5_,"$1");
                  for each (_loc16_ in param2)
                  {
                     if(_loc15_ == _loc16_.toString())
                     {
                        _loc4_ = _loc6_;
                     }
                  }
               }
            }
         }
         _loc7_ = new Vector.<SoundEventParamWrapper>();
         _loc8_ = _loc4_.elements();
         _loc9_ = new Vector.<SoundEventParamWrapper>();
         for each (_loc10_ in _loc8_)
         {
            _loc17_ = new SoundEventParamWrapper(_loc10_.Id,_loc10_.Volume,_loc10_.RollOff);
            _loc17_.berceauDuree = _loc10_.BerceauDuree;
            _loc17_.berceauVol = _loc10_.BerceauVol;
            _loc17_.berceauFadeIn = _loc10_.BerceauFadeIn;
            _loc17_.berceauFadeOut = _loc10_.BerceauFadeOut;
            _loc7_.push(_loc17_);
         }
         _loc11_ = Math.random() * Math.floor(_loc7_.length-1);
         return _loc7_[_loc11_];
      }
      
      public static function isLocalized(param1:String) : Boolean {
         var _loc2_:String = null;
         for each (_loc2_ in _IDS_UNLOCALIZED)
         {
            if(param1.split(_loc2_)[0] == "")
            {
               return false;
            }
         }
         return true;
      }
      
      private var _xmlBreed:XML;
   }
}
