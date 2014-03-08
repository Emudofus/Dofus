package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import flash.utils.Dictionary;
   
   public class OptionalFeature extends Object implements IDataCenter
   {
      
      public function OptionalFeature() {
         super();
      }
      
      public static const MODULE:String = "OptionalFeatures";
      
      public static function getOptionalFeatureById(param1:int) : OptionalFeature {
         return GameData.getObject(MODULE,param1) as OptionalFeature;
      }
      
      private static var _keywords:Dictionary;
      
      public static function getOptionalFeatureByKeyword(param1:String) : OptionalFeature {
         var _loc2_:OptionalFeature = null;
         if(!_keywords || !_keywords[param1])
         {
            _keywords = new Dictionary();
            for each (_keywords[_loc2_.keyword] in getAllOptionalFeatures())
            {
            }
         }
         return _keywords[param1];
      }
      
      public static function getAllOptionalFeatures() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var keyword:String;
   }
}
