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
      
      public static function getOptionalFeatureById(id:int) : OptionalFeature {
         return GameData.getObject(MODULE,id) as OptionalFeature;
      }
      
      private static var _keywords:Dictionary;
      
      public static function getOptionalFeatureByKeyword(key:String) : OptionalFeature {
         var feature:OptionalFeature = null;
         if((!_keywords) || (!_keywords[key]))
         {
            _keywords = new Dictionary();
            for each(_keywords[feature.keyword] in getAllOptionalFeatures())
            {
            }
         }
         return _keywords[key];
      }
      
      public static function getAllOptionalFeatures() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var keyword:String;
   }
}
