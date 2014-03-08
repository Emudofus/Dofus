package com.ankamagames.dofus.misc.utils
{
   import flash.utils.Dictionary;
   import flash.geom.Matrix;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class EmbedAssets extends Object
   {
      
      public function EmbedAssets() {
         super();
      }
      
      private static var _cache:Dictionary = new Dictionary();
      
      public static const DefaultBeriliaSlotIcon:Class = EmbedAssets_DefaultBeriliaSlotIcon;
      
      public static const CHECKPOINT_CLIP_TOP:Class = EmbedAssets_CHECKPOINT_CLIP_TOP;
      
      public static const CHECKPOINT_CLIP_LEFT:Class = EmbedAssets_CHECKPOINT_CLIP_LEFT;
      
      public static const CHECKPOINT_CLIP_BOTTOM:Class = EmbedAssets_CHECKPOINT_CLIP_BOTTOM;
      
      public static const CHECKPOINT_CLIP_RIGHT:Class = EmbedAssets_CHECKPOINT_CLIP_RIGHT;
      
      private static const CHECKPOINT_CLIP:Class = EmbedAssets_CHECKPOINT_CLIP;
      
      private static const QUEST_CLIP:Class = EmbedAssets_QUEST_CLIP;
      
      private static const QUEST_REPEATABLE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_CLIP;
      
      private static const QUEST_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_OBJECTIVE_CLIP;
      
      private static const QUEST_REPEATABLE_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_OBJECTIVE_CLIP;
      
      private static const TEAM_CIRCLE_CLIP:Class = EmbedAssets_TEAM_CIRCLE_CLIP;
      
      private static const SWORDS_CLIP:Class = EmbedAssets_SWORDS_CLIP;
      
      private static const FLAG_CURSOR:Class = EmbedAssets_FLAG_CURSOR;
      
      private static var matrix:Matrix = new Matrix();
      
      public static function getBitmap(param1:String, param2:Boolean=false, param3:Boolean=true) : Bitmap {
         var _loc4_:Bitmap = null;
         var _loc6_:BitmapData = null;
         if((param3) && !(_cache[param1] == null))
         {
            _loc4_ = _cache[param1];
            if(!param2)
            {
               return _loc4_;
            }
            _loc6_ = new BitmapData(_loc4_.width,_loc4_.height,true,16711935);
            _loc6_.draw(_loc4_,matrix);
            return new Bitmap(_loc6_);
         }
         var _loc5_:Class = EmbedAssets[param1] as Class;
         _loc4_ = new _loc5_() as Bitmap;
         if(param3)
         {
            saveCache(param1,_loc4_);
         }
         return _loc4_;
      }
      
      public static function getSprite(param1:String) : Sprite {
         var _loc2_:Class = EmbedAssets[param1] as Class;
         var _loc3_:Sprite = new _loc2_() as Sprite;
         return _loc3_;
      }
      
      public static function getClass(param1:String) : Class {
         return EmbedAssets[param1] as Class;
      }
      
      private static function saveCache(param1:String, param2:*) : void {
         _cache[param1] = param2;
      }
   }
}
